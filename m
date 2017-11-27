Received: from eggs.gnu.org ([2001:4830:134:3::10]:56435)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ppandit@redhat.com>) id 1eJNd9-00077z-Fh
	for qemu-devel@nongnu.org; Mon, 27 Nov 2017 12:55:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ppandit@redhat.com>) id 1eJNd6-00027o-E5
	for qemu-devel@nongnu.org; Mon, 27 Nov 2017 12:55:43 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36360)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ppandit@redhat.com>) id 1eJNd6-00027G-8G
	for qemu-devel@nongnu.org; Mon, 27 Nov 2017 12:55:40 -0500
Date: Mon, 27 Nov 2017 23:25:28 +0530 (IST)
From: P J P <ppandit@redhat.com>
In-Reply-To: <20171127111532.GI16527@stefanha-x1.localdomain>
Message-ID: <nycvar.YSQ.7.76.1711272251290.24944@wniryva>
References: <20171124183446.7308-1-ppandit@redhat.com>
	<20171124183446.7308-2-ppandit@redhat.com>
	<20171127111532.GI16527@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [Qemu-devel] [PATCH v3 1/2] virtio: check VirtQueue Vring
 object is set
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Qemu Developers <qemu-devel@nongnu.org>, zhangboxian <zhangboxian@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>, Cornelia Huck <cohuck@redhat.com>

+-- On Mon, 27 Nov 2017, Cornelia Huck wrote --+
|The check for align is not really needed, as virtio-1 disallows setting align 
|anyway.

 disallows...?

| Checking for !desc is wrong (why shouldn't a driver be able to unset a
| descriptor table?)

+-- On Mon, 27 Nov 2017, Stefan Hajnoczi wrote --+
| > +    if (!vdev->vq[n].vring.num || !desc || !vdev->vq[n].vring.align) {
| ...
|   vdev->vq[n].vring.desc = desc;
|
| Why !desc?

virtio_queue_set_rings
 virtio_init_region_cache
   VirtQueue *vq = &vdev->vq[n];
   ...
   addr = vq->vring.desc;
   if (!addr) {
       return;
   }

These checks seem to be repeating all over. As mentioned earlier, could these 
be collated in one place, maybe virtio_queue_get_num()?

  int virtio_queue_get_num(VirtIODevice *vdev, int n)
  {
      VirtQueue *vq = &vdev->vq[n];

      if (!vq->.vring.num
           || !vq->vring.desc
           || !vq->vring.align) {
          return 0;  /* vq not set */
      }

      return vdev->vq[n].vring.num;
  }


Thank you.
--
Prasad J Pandit / Red Hat Product Security Team
47AF CE69 3A90 54AA 9045 1053 DD13 3D32 FE5B 041F
