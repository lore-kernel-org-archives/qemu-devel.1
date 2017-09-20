Received: from eggs.gnu.org ([2001:4830:134:3::10]:60943)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dug21-0002TI-L1
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 10:31:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dug1w-0003h9-41
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 10:31:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59052)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1dug1v-0003gw-Ur
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 10:31:12 -0400
Date: Wed, 20 Sep 2017 16:30:59 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20170920163059.2ddd456c.cohuck@redhat.com>
In-Reply-To: <20170919180038.26056-6-dgilbert@redhat.com>
References: <20170919180038.26056-1-dgilbert@redhat.com>
	<20170919180038.26056-6-dgilbert@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 5/5] migration: Route more error paths
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, quintela@redhat.com, peterx@redhat.com, peter.maydell@linaro.org, rth@twiddle.net

On Tue, 19 Sep 2017 19:00:38 +0100
"Dr. David Alan Gilbert (git)" <dgilbert@redhat.com> wrote:

> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> 
> vmstate_save is called in a few places, and vmstate_save_state is
> called in lots of places.
> 
> Route error returns from the easier cases back up;  there are lots
> of more complex cases where there own error paths need fixing.
> 
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> ---
>  hw/display/virtio-gpu.c    |  4 +---
>  hw/virtio/virtio.c         | 13 +++++++------
>  include/hw/virtio/virtio.h |  2 +-
>  migration/vmstate-types.c  | 11 ++++++++---
>  tests/test-vmstate.c       |  6 +++---
>  5 files changed, 20 insertions(+), 16 deletions(-)
> 

> diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
> index 464947f76d..860333788b 100644
> --- a/hw/virtio/virtio.c
> +++ b/hw/virtio/virtio.c
> @@ -1899,7 +1899,7 @@ static const VMStateDescription vmstate_virtio = {
>      }
>  };
>  
> -void virtio_save(VirtIODevice *vdev, QEMUFile *f)
> +int virtio_save(VirtIODevice *vdev, QEMUFile *f)
>  {
>      BusState *qbus = qdev_get_parent_bus(DEVICE(vdev));
>      VirtioBusClass *k = VIRTIO_BUS_GET_CLASS(qbus);

Would it make sense to touch up the save_config callback as well? Else
virtio_save() looks a bit lopsided.

[For virtio-ccw, the callback can simply pass on any return code from
vmstate_save_state(). For virtio-pci, we can probably make
pci_device_save() restore the interrupt state in any case.]
