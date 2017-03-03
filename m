Received: from eggs.gnu.org ([2001:4830:134:3::10]:38859)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1cjmDj-0005b7-NJ
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 07:22:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1cjmDf-0003uV-Kc
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 07:22:03 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:35627
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cornelia.huck@de.ibm.com>)
	id 1cjmDf-0003uJ-Dj
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 07:21:59 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v23CIknh037493
	for <qemu-devel@nongnu.org>; Fri, 3 Mar 2017 07:21:58 -0500
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
	by mx0b-001b2d01.pphosted.com with ESMTP id 28xs8v5bea-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 03 Mar 2017 07:21:58 -0500
Received: from localhost
	by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <cornelia.huck@de.ibm.com>;
	Fri, 3 Mar 2017 12:21:56 -0000
Date: Fri, 3 Mar 2017 13:21:49 +0100
From: Cornelia Huck <cornelia.huck@de.ibm.com>
In-Reply-To: <20170302185942.76255-1-pasic@linux.vnet.ibm.com>
References: <20170302185942.76255-1-pasic@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <20170303132149.34e5906a.cornelia.huck@de.ibm.com>
Subject: Re: [Qemu-devel] [PATCH 1/1] virtio: fail device if
 set_event_notifier fails
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Halil Pasic <pasic@linux.vnet.ibm.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>

On Thu,  2 Mar 2017 19:59:42 +0100
Halil Pasic <pasic@linux.vnet.ibm.com> wrote:

> The function virtio_notify_irqfd used to ignore the return code of
> event_notifier_set. Let's fail the device should this occur.

I'm wondering if there are reasons for event_notifier_set() to fail
beyond "we've hit an internal race and should make an effort to fix
that one, or else we have completely messed up in qemu". Marking the
device broken tells the guest that there's something wrong with the
device, but I think we want qemu bug reports when there's something
broken with the irqfd.

> 
> Signed-off-by: Halil Pasic <pasic@linux.vnet.ibm.com>
> 
> ---
> 
> This patch is most likely flawed because virtio_notify_irqfd
> is probably supposed to be thread-safe and neither strerror
> nor virtio_error are that. Anyway lets get the discussion started with this.
> 
> There was a suggestion by Michael to make event_notifier_set void
> and assert inside. After some thinking, I settled at the opinion,
> that neither doing nothing nor crashing the guest is a good idea
> should this failure happen in production. So I came up with this.
> 
> Looking forward to your feedback.
> ---
>  hw/virtio/virtio.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
> index 23483c7..e05f3e5 100644
> --- a/hw/virtio/virtio.c
> +++ b/hw/virtio/virtio.c
> @@ -1555,6 +1555,8 @@ static bool virtio_should_notify(VirtIODevice *vdev, VirtQueue *vq)
>  void virtio_notify_irqfd(VirtIODevice *vdev, VirtQueue *vq)
>  {
>      bool should_notify;
> +    int rc;
> +
>      rcu_read_lock();
>      should_notify = virtio_should_notify(vdev, vq);
>      rcu_read_unlock();
> @@ -1581,7 +1583,11 @@ void virtio_notify_irqfd(VirtIODevice *vdev, VirtQueue *vq)
>       * to an atomic operation.
>       */
>      virtio_set_isr(vq->vdev, 0x1);
> -    event_notifier_set(&vq->guest_notifier);
> +    rc = event_notifier_set(&vq->guest_notifier);
> +    if (unlikely(rc)) {
> +        virtio_error(vdev, "guest notifier broken for vdev at %p (%s)", vdev,
> +                     strerror(-rc));
> +    }
>  }
> 
>  static void virtio_irq(VirtQueue *vq)
