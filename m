Received: from eggs.gnu.org ([2001:4830:134:3::10]:50072)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fslP3-0004wx-Cj
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 04:55:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fslDJ-0002fl-Ql
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 04:43:37 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:44862 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1fslDJ-0002eN-LS
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 04:43:33 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 5032C40241C5
	for <qemu-devel@nongnu.org>; Thu, 23 Aug 2018 08:43:33 +0000 (UTC)
Date: Thu, 23 Aug 2018 16:43:30 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20180823084330.GA6960@lemon.usersys.redhat.com>
References: <20180822145707.GJ3878@lemon.usersys.redhat.com>
	<d8a08241-413f-daf2-5164-45a0e66a69c5@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d8a08241-413f-daf2-5164-45a0e66a69c5@redhat.com>
Subject: Re: [Qemu-devel] virtio_stw_phys_cached crash
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, jasowang@redhat.com

On Wed, 08/22 19:45, Paolo Bonzini wrote:
> On 22/08/2018 16:57, Fam Zheng wrote:
> > On master (13b7b188501) and v3.0.0, booting the OpenBSD install63.iso with a
> > virtio-net (slirp backend) device gives this assertion failure:
> > 
> > (gdb) bt
> > #0  0x00007f6f25703feb in raise () at /lib64/libc.so.6
> > #1  0x00007f6f256ee5c1 in abort () at /lib64/libc.so.6
> > #2  0x00007f6f256ee491 in _nl_load_domain.cold.0 () at /lib64/libc.so.6
> > #3  0x00007f6f256fc752 in  () at /lib64/libc.so.6
> > #4  0x000055d966f5b5d6 in address_space_stw_le_cached (cache=0x7f6f040fd700, addr=516, val=1, attrs=..., result=0x0)
> >     at /stor/work/qemu/include/exec/memory_ldst_cached.inc.h:85
> 
> Does this help?

Nope. The crash happens the same (once you press "Auto Install" at the first
prompt).

Fam

> 
> diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
> index d4e4d98b59..5982678c75 100644
> --- a/hw/virtio/virtio.c
> +++ b/hw/virtio/virtio.c
> @@ -2006,14 +2006,25 @@ static int virtio_set_features_nocheck(VirtIODevice *vdev, uint64_t val)
>  
>  int virtio_set_features(VirtIODevice *vdev, uint64_t val)
>  {
> -   /*
> +    int ret;
> +    /*
>       * The driver must not attempt to set features after feature negotiation
>       * has finished.
>       */
>      if (vdev->status & VIRTIO_CONFIG_S_FEATURES_OK) {
>          return -EINVAL;
>      }
> -    return virtio_set_features_nocheck(vdev, val);
> +    ret = virtio_set_features_nocheck(vdev, val);
> +    if (!ret && (val & VIRTIO_RING_F_EVENT_IDX)) {
> +        /* VIRTIO_RING_F_EVENT_IDX changes the size of the caches.  */
> +        int i;
> +        for (i = 0; i < VIRTIO_QUEUE_MAX; i++) {
> +            if (vdev->vq[i].vring.num != 0) {
> +                virtio_init_region_cache(vdev, i);
> +            }
> +        }
> +    }
> +    return ret;
>  }
>  
>  int virtio_load(VirtIODevice *vdev, QEMUFile *f, int version_id)
> 
> (I haven't tried to reproduce, or checked the spec to see if this could
> be a guest bug too.  Of course assertion failures are wrong anyway, so
> we might as well work around it as above).
> 
> Paolo
