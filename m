Received: from eggs.gnu.org ([2001:4830:134:3::10]:59954)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dlAMu-00012N-GK
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 04:53:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dlAMt-0005bA-JB
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 04:53:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39344)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1dlAMt-0005av-9m
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 04:53:31 -0400
References: <20170824123006.GK5379@umbus.fritz.box>
	<20170825083123.47432-1-aik@ozlabs.ru>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <4608a2c1-5c74-efea-d901-3b5cfa0519e6@redhat.com>
Date: Fri, 25 Aug 2017 10:53:27 +0200
MIME-Version: 1.0
In-Reply-To: <20170825083123.47432-1-aik@ozlabs.ru>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC PATCH qemu] exec: Destroy dispatch immediately
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexey Kardashevskiy <aik@ozlabs.ru>, qemu-devel@nongnu.org
Cc: David Gibson <david@gibson.dropbear.id.au>

On 25/08/2017 10:31, Alexey Kardashevskiy wrote:
> Otherwise old dispatch holds way too much memory before RCU gets
> a chance to free old dispatches.
> 
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> ---
> 
> This is a follow-up to the "Memory use with >100 virtio devices"
> thread.
> 
> I assume this is a dirty hack (which fixes the problem though)

This doesn't work.  AddressSpaceDispatch can be accessed outside the big
QEMU lock, which is why it is destroyed via call_rcu.

The solution is to: 1) share the FlatView structures if they refer to
the same root memory region; 2) have one AddressSpaceDispatch per
FlatView instead of one per AddressSpace, so that FlatView reference
counting takes care of clearing the AddressSpaceDispatch too.  Neither
is particularly hard.  The second requires getting rid of the
as->dispatch_listener and "hard coding" the creation of the
AddressSpaceDispatch from the FlatView in memory.c.

Paolo

> and I wonder what the proper solution would be. Thanks.
> 
> 
> What happens here is that every virtio block device creates 2 address
> spaces - for modern config space (called "virtio-pci-cfg-as") and
> for busmaster (common pci thing, called after the device name,
> in my case "virtio-blk-pci").
> 
> Each address_space_init() updates topology for _every_ address space.
> Every topology update (address_space_update_topology()) creates a new
> dispatch tree - AddressSpaceDispatch with nodes (1KB) and
> sections (48KB) and destroys the old one.
> 
> However the dispatch destructor is postponed via RCU which does not
> get a chance to execute until the machine is initialized but before
> we get there, memory is not returned to the pool, and this is a lot
> of memory which grows n^2.
> 
> 
> Interestingly, mem_add() from exec.c is called twice:
> as as->dispatch_listener.region_add() and
> as as->dispatch_listener.region_nop() - I did not understand
> the trick but it does not work if I remove the .region_nop() hook.
> How does it work? :)
> 
> ---
>  exec.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/exec.c b/exec.c
> index 01ac21e3cd..ea5f3eb209 100644
> --- a/exec.c
> +++ b/exec.c
> @@ -2707,7 +2707,7 @@ static void mem_commit(MemoryListener *listener)
>  
>      atomic_rcu_set(&as->dispatch, next);
>      if (cur) {
> -        call_rcu(cur, address_space_dispatch_free, rcu);
> +        address_space_dispatch_free(cur);
>      }
>  }
>  
> 
