Received: from eggs.gnu.org ([2001:4830:134:3::10]:57062)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <guangrong.xiao@gmail.com>) id 1d67ZZ-0006xG-PM
	for qemu-devel@nongnu.org; Wed, 03 May 2017 23:36:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <guangrong.xiao@gmail.com>) id 1d67ZW-0003aK-N3
	for qemu-devel@nongnu.org; Wed, 03 May 2017 23:36:57 -0400
Received: from mail-pf0-x243.google.com ([2607:f8b0:400e:c00::243]:34979)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <guangrong.xiao@gmail.com>)
	id 1d67ZW-0003Zi-Fx
	for qemu-devel@nongnu.org; Wed, 03 May 2017 23:36:54 -0400
Received: by mail-pf0-x243.google.com with SMTP id o68so338430pfj.2
	for <qemu-devel@nongnu.org>; Wed, 03 May 2017 20:36:54 -0700 (PDT)
References: <20170503105224.19049-1-xiaoguangrong@tencent.com>
	<e186ce8d-52fc-3eca-1343-1a2f18331a76@redhat.com>
	<ff732c49-de24-eebd-ae8e-2de00281f211@gmail.com>
	<878cbc47-316c-d508-a5a3-22029dee2203@redhat.com>
From: Xiao Guangrong <guangrong.xiao@gmail.com>
Message-ID: <9af959d5-23c2-abd4-6100-577755239d2f@gmail.com>
Date: Thu, 4 May 2017 11:36:55 +0800
MIME-Version: 1.0
In-Reply-To: <878cbc47-316c-d508-a5a3-22029dee2203@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 0/7] KVM: MMU: fast write protect
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, mtosatti@redhat.com, avi.kivity@gmail.com, rkrcmar@redhat.com
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, qemu-devel@nongnu.org, Xiao Guangrong <xiaoguangrong@tencent.com>



On 05/03/2017 10:57 PM, Paolo Bonzini wrote:
> 
> 
> On 03/05/2017 16:50, Xiao Guangrong wrote:
>> Furthermore, userspace has no knowledge about if PML is enable (it
>> can be required from sysfs, but it is a good way in QEMU), so it is
>> difficult for the usespace to know when to use write-protect-all.
>> Maybe we can make KVM_CAP_X86_WRITE_PROTECT_ALL_MEM return false if
>> PML is enabled?
> 
> Yes, that's a good idea.  Though it's a pity that, with PML, setting the
> dirty bit will still do the massive walk of the rmap.  At least with
> reset_dirty_pages it's done a little bit at a time.
> 
>>> Also, I wonder how the alternative write protection mechanism would
>>> affect performance of the dirty page ring buffer patches.  You would do
>>> the write protection of all memory at the end of
>>> kvm_vm_ioctl_reset_dirty_pages.  You wouldn't even need a separate
>>> ioctl, which is nice.  On the other hand, checkpoints would be more
>>> frequent and most pages would be write-protected, so it would be more
>>> expensive to rebuild the shadow page tables...
>>
>> Yup, write-protect-all can improve reset_dirty_pages indeed, i will
>> apply your idea after reset_dirty_pages is merged.
>>
>> However, we still prefer to have a separate ioctl for write-protect-all
>> which cooperates with KVM_GET_DIRTY_LOG to improve live migration that
>> should not always depend on checkpoint.
> 
> Ok, I plan to merge the dirty ring pages early in 4.13 development.

Great.

As there is no conflict between these two patchsets except dirty
ring pages takes benefit from write-protect-all, i think they
can be developed and iterated independently, right?

Or you prefer to merge dirty ring pages first then review the
new version of this patchset later?

Thanks!
