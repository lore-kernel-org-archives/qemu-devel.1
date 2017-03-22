Received: from eggs.gnu.org ([2001:4830:134:3::10]:39550)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cqeii-0004Kv-Md
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 07:46:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cqeie-0007tb-NG
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 07:46:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41030)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1cqeie-0007tM-EJ
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 07:46:24 -0400
References: <1489158897-9206-1-git-send-email-yang.zhong@intel.com>
	<4712D8F4B26E034E80552F30A67BE0B1A0F91A@ORSMSX112.amr.corp.intel.com>
	<920352018.1797331.1489251855464.JavaMail.zimbra@redhat.com>
	<4712D8F4B26E034E80552F30A67BE0B1A13045@ORSMSX112.amr.corp.intel.com>
	<991a0f3d-5e1f-d17c-a8f3-a42c02ac2f17@redhat.com>
	<4712D8F4B26E034E80552F30A67BE0B1A1561C@ORSMSX112.amr.corp.intel.com>
	<f05fe113-c286-19b0-f5bc-ee2c1ea05568@redhat.com>
	<4712D8F4B26E034E80552F30A67BE0B1A16F14@ORSMSX112.amr.corp.intel.com>
	<1466597512.4602267.1489609298091.JavaMail.zimbra@redhat.com>
	<4712D8F4B26E034E80552F30A67BE0B1A19A11@ORSMSX112.amr.corp.intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <b23eb236-6f32-fb2b-1a61-a831053e277b@redhat.com>
Date: Wed, 22 Mar 2017 12:46:21 +0100
MIME-Version: 1.0
In-Reply-To: <4712D8F4B26E034E80552F30A67BE0B1A19A11@ORSMSX112.amr.corp.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 2/2] reduce qemu's heap Rss size from
 12252kB to 2752KB
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Xu, Anthony" <anthony.xu@intel.com>
Cc: "Zhong, Yang" <yang.zhong@intel.com>, "Peng, Chao P" <chao.p.peng@intel.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>



On 16/03/2017 21:02, Xu, Anthony wrote:
>>> memory_region_finalize.
>>> Let me know if you think otherwise.
>>
>> Yes, you can replace memory_region_del_subregion in
>> memory_region_finalize
>> with special code that does
>>
>>     assert(!mr->enabled);
>>     assert(subregion->container == mr);
>>     subregion->container = NULL;
>>     QTAILQ_REMOVE(&mr->subregions, subregion, subregions_link);
>>     memory_region_unref(subregion);
>>
>> The last four lines are shared with memory_region_del_subregion, so please
>> factor them in a new function, for example
>> memory_region_del_subregion_internal.
> 
> After adding synchronize_rcu, I saw an infinite recursive call,
>   mem_commit-> memory_region_finalize-> mem_commit->
> memory_region_finalize-> ......
> it caused a segment fault, because 8M stack space is used up, and found when 
> memory_region_finalize is called, memory_region_transaction_depth is 0 and 
> memory_region_update_pending is true. That's not normal!

Ok, this is a bug.  This would fix it:

> Please review below patch
> 
> diff --git a/memory.c b/memory.c
> index 64b0a60..4c95aaf 100644
> --- a/memory.c
> +++ b/memory.c
> @@ -906,12 +906,6 @@ void memory_region_transaction_begin(void)
>      ++memory_region_transaction_depth;
>  }
> 
> -static void memory_region_clear_pending(void)
> -{
> -    memory_region_update_pending = false;
> -    ioeventfd_update_pending = false;
> -}
> -
>  void memory_region_transaction_commit(void)
>  {
>      AddressSpace *as;
> @@ -927,14 +921,14 @@ void memory_region_transaction_commit(void)
>              QTAILQ_FOREACH(as, &address_spaces, address_spaces_link) {
>                  address_space_update_topology(as);
>              }
> -
> +            memory_region_update_pending = false;
>              MEMORY_LISTENER_CALL_GLOBAL(commit, Forward);
>          } else if (ioeventfd_update_pending) {
>              QTAILQ_FOREACH(as, &address_spaces, address_spaces_link) {
>                  address_space_update_ioeventfds(as);
>              }
> +            ioeventfd_update_pending = false;
>          }
> -        memory_region_clear_pending();
>     }
>  }

So please send it to the list with Signed-off-by line.

> The thing is, seems both address_space_translate and address_space_dispatch_free 
> are called under the global lock. When synchronize_rcu is called, no other threads 
> are in RCU critical section.

No, not necessarily.  address_space_write for example is called outside
the global lock by KVM and it calls address_space_translate.

> Seems RCU is not that useful for address space.

I suggest that you study the code more closely...  there is this in
kvm-all.c:

            DPRINTF("handle_mmio\n");
            /* Called outside BQL */
            address_space_rw(&address_space_memory,
                             run->mmio.phys_addr, attrs,
                             run->mmio.data,
                             run->mmio.len,
                             run->mmio.is_write);

and adding a simple assert() would have quickly disproved your theory.

> After adding synchronize_rcu, we noticed a RCU dead loop.  synchronize_rcu is called 
> inside RCU critical section. It happened when guest OS programmed the PCI bar.
> The call trace is like,
> address_space_write-> pci_host_config_write_common -> 
> memory_region_transaction_commit ->mem_commit-> synchronize_rcu
> pci_host_config_write_common is called inside RCU critical section.
> 
> The address_space_write change fixed this issue.

It's not a fix if the code is not thread-safe anymore!  But I think you
have the answer now as to why you cannot use synchronize_rcu.

Paolo
