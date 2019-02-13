Received: from eggs.gnu.org ([209.51.188.92]:51406)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wexu@redhat.com>) id 1gtueP-000060-Od
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 08:32:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wexu@redhat.com>) id 1gtueF-0007ux-4v
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 08:32:26 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54748)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wexu@redhat.com>) id 1gtueE-0007q9-Ro
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 08:32:23 -0500
From: wexu@redhat.com
Date: Wed, 13 Feb 2019 08:25:35 -0500
Message-Id: <1550064346-17012-1-git-send-email-wexu@redhat.com>
Subject: [Qemu-devel] [PATCH v3 00/11] packed ring virtio-net backends
 support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: wexu@redhat.com, jasowang@redhat.com, mst@redhat.com, jfreiman@redhat.com, maxime.coquelin@redhat.com, tiwei.bie@intel.com

From: Wei Xu <wexu@redhat.com>

https://github.com/Whishay/qemu.git 

Userspace and vhost-net backedn test has been done with upstream kernel
in guest.

v2->v3
    v2/01 - drop it since the header has been synchronized from kernel.(mst & jason)
    v3/01 - rename 'avail_wrap_counter' to 'last_avail_wrap_counter',
            'event_wrap_counter' to 'avail_wrap_counter' to make it easier
            to understand.(Jason)
          - revise commit message.(Jason)
    v3/02 - split packed ring areas size calculation to next patch.(Jason)
            to not break bisect(Jason).
    v3/03 - initialize packed ring region with correct size and attribute.
          - remove unnecessary 'else' checks. (Jason)
    v3/06 - add commit log.
          - replace 'event_wrap-counter' with 'avail_wrap_counter'.
          - merge common memory cache size check to virtqueue_get_avail_bytes().(Jason)
          - revise memory barrier comment.(Jason) 
          - check indirect descriptors by desc.len/sizeof(desc).(Jason)
          - flip wrap counter with '^=1'.(Jason)
    v3/07 - move desc.id/len initialization to the declaration.(Jason)
          - flip wrap counter '!' with '^=1'.(Jason)
          - add memory barrier comments in commit message.
    v3/08 - use offsetof() when writing cache.(Jason)
          - avoid duplicated memory region write when turning off event_idx
            supported notification.(Jason)
          - add commit log.(Jason)
          - add avail & last_avail wrap counter difference description in commit log.
    v3/09 - remove unnecessary used/avail idx/wrap-counter from subsection.
          - put new subsection to the end of vmstate_virtio.(Jason)
          - squash the two userspace and vhost-net migration patches in v2.(Jason)
    v3/10 - reword commit message.
          - this is a help not a bug fix so I would like to keep it as a
            separate patch still.(Proposed a merge it by Jason)
          - the virtqueue_fill() is also not like an API so I would prefer not
            to touch it, please correct me if I did not get it in the right
            way.(Proposed a squash by Jason)
    v3/11 - squash feature bits for user space and vhost kernel/user backends.
          - enable packed ring feature bit provision on host by default.(Jason)

Wei Xu (11):
  virtio: rename structure for packed ring
  virtio: device/driver area size calculation helper for split ring
  virtio: initialize packed ring region
  virtio: initialize wrap counter for packed ring
  virtio: queue/descriptor check helpers for packed ring
  virtio: get avail bytes check for packed ring
  virtio: fill/flush/pop for packed ring
  virtio: event suppression support for packed ring
  virtio-net: update the head descriptor in a chain lastly
  virtio: migration support for packed ring
  virtio: CLI and provide packed ring feature bit by default

 hw/net/vhost_net.c         |   2 +
 hw/net/virtio-net.c        |  11 +-
 hw/virtio/virtio.c         | 798 +++++++++++++++++++++++++++++++++++++++++----
 include/hw/virtio/virtio.h |   4 +-
 4 files changed, 757 insertions(+), 58 deletions(-)

-- 
1.8.3.1
