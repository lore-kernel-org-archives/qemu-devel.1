Received: from eggs.gnu.org ([2001:4830:134:3::10]:41688)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maxime.coquelin@redhat.com>) id 1gPtHU-0001mI-Tf
	for qemu-devel@nongnu.org; Thu, 22 Nov 2018 13:00:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <maxime.coquelin@redhat.com>) id 1gPtEW-0007L8-Ur
	for qemu-devel@nongnu.org; Thu, 22 Nov 2018 12:57:47 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53632)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <maxime.coquelin@redhat.com>)
	id 1gPtEW-0007AL-MR
	for qemu-devel@nongnu.org; Thu, 22 Nov 2018 12:57:44 -0500
References: <1542895581-10721-1-git-send-email-wexu@redhat.com>
From: Maxime Coquelin <maxime.coquelin@redhat.com>
Message-ID: <2a4aa88d-37ce-7b9e-14c9-238b1e0ffd5c@redhat.com>
Date: Thu, 22 Nov 2018 18:57:31 +0100
MIME-Version: 1.0
In-Reply-To: <1542895581-10721-1-git-send-email-wexu@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 00/16] packed ring virtio-net backend
 support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: wexu@redhat.com, qemu-devel@nongnu.org, tiwei.bie@intel.com
Cc: jasowang@redhat.com, mst@redhat.com, jfreimann@redhat.com

Hi Wei,

I just tested your series with Tiwei's v3, and it fails
with ctrl vq enabled:
qemu-system-x86_64: virtio-net ctrl missing headers

Regards,
Maxime

On 11/22/18 3:06 PM, wexu@redhat.com wrote:
> From: Wei Xu <wexu@redhat.com>
> 
> Code base:
>      https://github.com/Whishay/qemu.git
> 
> rfc v3 -> v1
> - migration support for both userspace and vhost-net, need tweak vhost
>    ioctl() to make it work(the code is pasted in the commit message of
>    vhost migration patch #13).
> 
> Note:
>    the high 32-bit guest feature bit is saved as a subsection for
>    virtio devices which makes packed ring feature bit check unusable when
>    loading the saved per-queue variables(this is done before loading
>    subsection which is the last action for device during migration),
>    so I save and load all the things generally for now, any idea to fix this?
> 
> - Fixed comments from Jason for rfc v3 sorted by patch #, two comments I
>    didn't take were(from patch) listed here:
> 09: - introduce new API(virtqueue_fill_n()).
>        - Didn't take it since userspace backend does not support batching,
>          so only one element is popped and current API should be enough.
> 06 & 07: Refactor split and packed pop()/get_avail_bytes().
>           - the duplicated code interwined with split/packed ring specific
>             things and it might make it unclear, so I only extracted the few
>             common parts out side rcu and keep the others separate.
> 
> The other revised comments:
> 02: - reuse current 'avail/used' for 'driver/device' in VRingMemoryRegionCache.
>      - remove event_idx since shadow_avail_idx works.
> 03: - move size recalculation to a separate patch.
>      - keep 'avail/used' in current calculation function name.
>      - initialize 'desc' memory region as 'false' for 1.0('true' for 1.1)
> 04: - delete 'event_idx'
> 05: - rename 'wc' to wrap_counter.
> 06: - converge common part outside rcu section for 1.0/1.1.
>      - move memory barrier for the first 'desc' in between checking flag
>        and read other fields.
>      - remove unnecessary memory barriers for indirect descriptors.
>      - no need to destroy indirect memory cache since it is generally done
>        before return from the function.
>      - remove redundant maximum chained descriptors limitation check.
>      - there are some differences(desc name, wrap idx/counter, flags) between
>        split and packed rings, so keep them separate for now.
>      - amend the comment when recording index and wrap counter for a kick
>        from guest.
> 07: - calculate fields in descriptor instead of read it when filling.
>      - put memory barrier correctly before filling the flags in descriptor.
>      - replace full memory barrier with a write barrier in fill.
>      - shift to read descriptor flags and descriptor necessarily and
>        separately in packed_pop().
>      - correct memory barrier in packed_pop() as in packed_fill().
> 08: - reuse 'shadow_avail_idx' instead of adding a new 'event_idx'.
>      - use the compact and verified vring_packed_need_event()
>        version for vhost net/user.
> 12: - remove the odd cherry-pick comment.
>      - used bit '15' for wrap_counters.
> 
> rfc v2->v3
> - addressed performance issue
> - fixed feedback from v2
> 
> rfc v1->v2
> - sync to tiwei's v5
> - reuse memory cache function with 1.0
> - dropped detach patch and notification helper(04 & 05 in v1)
> - guest virtio-net driver unload/reload support
> - event suppression support(not tested)
> - addressed feedback from v1
> 
> Wei Xu (15):
>    virtio: introduce packed ring definitions
>    virtio: redefine structure & memory cache for packed ring
>    virtio: expand offset calculation for packed ring
>    virtio: add memory region init for packed ring
>    virtio: init wrap counter for packed ring
>    virtio: init and desc empty check for packed ring
>    virtio: get avail bytes check for packed ring
>    virtio: fill/flush/pop for packed ring
>    virtio: event suppression support for packed ring
>    virtio-net: fill head desc after done all in a chain
>    virtio: add userspace migration of packed ring
>    virtio: add vhost-net migration of packed ring
>    virtio: packed ring feature bit for userspace backend
>    vhost: enable packed ring
>    virtio: enable packed ring via a new command line
> 
>   VERSION                                        |   2 +-
>   hw/net/vhost_net.c                             |   2 +
>   hw/net/virtio-net.c                            |  11 +-
>   hw/virtio/virtio.c                             | 756 +++++++++++++++++++++++--
>   include/hw/virtio/virtio.h                     |   8 +-
>   include/standard-headers/linux/virtio_config.h |  15 +
>   include/standard-headers/linux/virtio_ring.h   |  43 ++
>   7 files changed, 783 insertions(+), 54 deletions(-)
> 
