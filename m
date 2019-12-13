Return-Path: <SRS0=VaDC=2D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 438FFC2D0C9
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2019 21:28:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AD77921655
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2019 21:27:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A0+z82iy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD77921655
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48540 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifkGM-0006MM-CO
	for qemu-devel@archiver.kernel.org; Fri, 13 Dec 2019 07:41:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38944)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1ifkFa-0005xf-K0
 for qemu-devel@nongnu.org; Fri, 13 Dec 2019 07:40:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1ifkFW-0007j9-Pm
 for qemu-devel@nongnu.org; Fri, 13 Dec 2019 07:40:52 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:29366
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1ifkFW-0007gs-JJ
 for qemu-devel@nongnu.org; Fri, 13 Dec 2019 07:40:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576240849;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=z88FNi6+3WMPtk+LPuwA/jobz+3Kf8euIeQsHxA5BbE=;
 b=A0+z82iyF8kB8LZM/vifgUfkPQR7+3b6W8zXqDvgHRFe852uT0rN9K5PllpWfjCayrW89I
 Cc0qWR5FkCXdxuW6iNJWLT5CsIY98TW2RFlAtj2l6z99Atvwc1Py6/C2Bz0TWt+alXC1W6
 PNLwXqb//902GpycPS1vZLeyT3XgxMs=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-141-ppEvyWr5NqOUPnO6DVLb_Q-1; Fri, 13 Dec 2019 07:40:47 -0500
Received: by mail-qv1-f72.google.com with SMTP id ec1so1599219qvb.6
 for <qemu-devel@nongnu.org>; Fri, 13 Dec 2019 04:40:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=+s0C82+veouVCKj85NooB+QxipYroTDdAOR57GJFYkA=;
 b=YRDSUgH4Weunni5Sca5mGkUgVAwpRrB7kYmlAjThNtMOHW2TEWpL4lu7eAeL8CGSIW
 daig6/fBiZVES4i/rLa/mCDYJDLI4R9ruh2tOGK46L+WH+FJyrStXgw/fSebjQcoA/ux
 BkC6nMVq5WDb2mFJu0uhN3BJmo3B5Pdzdnl5spRamSOsPcOdEwmHB0dECexE6cJizaFe
 gGaUq3ZeYu6SfkZ+AFM/exh03NnRaQvY8s3F9mWoc5nJlADFVME7lxomMoANO+ZV62hu
 s27fg/2UbzBxWijX5nmAbOsIKcMYSY+vH+tyMXlaDyZ3LcJ1ddq64/EVdZ56Bcxdf7k5
 iy4g==
X-Gm-Message-State: APjAAAVJF5YRaH+WxY/YPZuS+RgGod5/tf1zfnObMAcTbEFbuNMSLeEV
 UXeuKQ2CVmBmvDTR5s2eQt8AUTZ2I+av1M/Ip5wnRM+wEQ9D4CZpu+Uw6ZDuBB7Ebd0gwxiSuyP
 8o7GkREO+Mqt32ic=
X-Received: by 2002:a05:620a:1358:: with SMTP id
 c24mr13597223qkl.285.1576240847321; 
 Fri, 13 Dec 2019 04:40:47 -0800 (PST)
X-Google-Smtp-Source: APXvYqywigQfgR0CG+N9oBwqtxit2p00vXxhasB8oB8F6ovWYMzZzy193IHIxZ3BZ8G190V9150PeQ==
X-Received: by 2002:a05:620a:1358:: with SMTP id
 c24mr13597183qkl.285.1576240846894; 
 Fri, 13 Dec 2019 04:40:46 -0800 (PST)
Received: from redhat.com (bzq-79-181-48-215.red.bezeqint.net. [79.181.48.215])
 by smtp.gmail.com with ESMTPSA id y18sm2792784qki.0.2019.12.13.04.40.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Dec 2019 04:40:46 -0800 (PST)
Date: Fri, 13 Dec 2019 07:40:41 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Denis Plotnikov <dplotnikov@virtuozzo.com>
Subject: Re: [PATCH] virtio: fix IO request length in virtio SCSI/block
 #PSBM-78839
Message-ID: <20191213072714-mutt-send-email-mst@kernel.org>
References: <20191018115547.19299-1-dplotnikov@virtuozzo.com>
 <20191023172005-mutt-send-email-mst@kernel.org>
 <42b80a75-6ab4-5123-bbf5-eee21c2841ac@virtuozzo.com>
 <20191106065816-mutt-send-email-mst@kernel.org>
 <c39d90bc-92c0-6b53-b7a6-992ec69bb0b0@virtuozzo.com>
MIME-Version: 1.0
In-Reply-To: <c39d90bc-92c0-6b53-b7a6-992ec69bb0b0@virtuozzo.com>
X-MC-Unique: ppEvyWr5NqOUPnO6DVLb_Q-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: "kwolf@redhat.com" <kwolf@redhat.com>, Denis Lunev <den@virtuozzo.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "mreitz@redhat.com" <mreitz@redhat.com>, Roman Kagan <rkagan@virtuozzo.com>,
 "stefanha@redhat.com" <stefanha@redhat.com>,
 "kraxel@redhat.com" <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Nov 25, 2019 at 09:16:10AM +0000, Denis Plotnikov wrote:
>=20
>=20
> On 06.11.2019 15:03, Michael S. Tsirkin wrote:
> > On Thu, Oct 24, 2019 at 11:34:34AM +0000, Denis Lunev wrote:
> >> On 10/24/19 12:28 AM, Michael S. Tsirkin wrote:
> >>> On Fri, Oct 18, 2019 at 02:55:47PM +0300, Denis Plotnikov wrote:
> >>>> From: "Denis V. Lunev" <den@openvz.org>
> >>>>
> >>>> Linux guests submit IO requests no longer than PAGE_SIZE * max_seg
> >>>> field reported by SCSI controler. Thus typical sequential read with
> >>>> 1 MB size results in the following pattern of the IO from the guest:
> >>>>    8,16   1    15754     2.766095122  2071  D   R 2095104 + 1008 [dd=
]
> >>>>    8,16   1    15755     2.766108785  2071  D   R 2096112 + 1008 [dd=
]
> >>>>    8,16   1    15756     2.766113486  2071  D   R 2097120 + 32 [dd]
> >>>>    8,16   1    15757     2.767668961     0  C   R 2095104 + 1008 [0]
> >>>>    8,16   1    15758     2.768534315     0  C   R 2096112 + 1008 [0]
> >>>>    8,16   1    15759     2.768539782     0  C   R 2097120 + 32 [0]
> >>>> The IO was generated by
> >>>>    dd if=3D/dev/sda of=3D/dev/null bs=3D1024 iflag=3Ddirect
> >>>>
> >>>> This effectively means that on rotational disks we will observe 3 IO=
PS
> >>>> for each 2 MBs processed. This definitely negatively affects both
> >>>> guest and host IO performance.
> >>>>
> >>>> The cure is relatively simple - we should report lengthy scatter-gat=
her
> >>>> ability of the SCSI controller. Fortunately the situation here is ve=
ry
> >>>> good. VirtIO transport layer can accomodate 1024 items in one reques=
t
> >>>> while we are using only 128. This situation is present since almost
> >>>> very beginning. 2 items are dedicated for request metadata thus we
> >>>> should publish VIRTQUEUE_MAX_SIZE - 2 as max_seg.
> >>>>
> >>>> The following pattern is observed after the patch:
> >>>>    8,16   1     9921     2.662721340  2063  D   R 2095104 + 1024 [dd=
]
> >>>>    8,16   1     9922     2.662737585  2063  D   R 2096128 + 1024 [dd=
]
> >>>>    8,16   1     9923     2.665188167     0  C   R 2095104 + 1024 [0]
> >>>>    8,16   1     9924     2.665198777     0  C   R 2096128 + 1024 [0]
> >>>> which is much better.
> >>>>
> >>>> The dark side of this patch is that we are tweaking guest visible
> >>>> parameter, though this should be relatively safe as above transport
> >>>> layer support is present in QEMU/host Linux for a very long time.
> >>>> The patch adds configurable property for VirtIO SCSI with a new defa=
ult
> >>>> and hardcode option for VirtBlock which does not provide good
> >>>> configurable framework.
> >>>>
> >>>> Unfortunately the commit can not be applied as is. For the real cure=
 we
> >>>> need guest to be fixed to accomodate that queue length, which is don=
e
> >>>> only in the latest 4.14 kernel. Thus we are going to expose the prop=
erty
> >>>> and tweak it on machine type level.
> >>>>
> >>>> The problem with the old kernels is that they have
> >>>> max_segments <=3D virtqueue_size restriction which cause the guest
> >>>> crashing in the case of violation.
> >>> This isn't just in the guests: virtio spec also seems to imply this,
> >>> or at least be vague on this point.
> >>>
> >>> So I think it'll need a feature bit.
> >>> Doing that in a safe way will also allow being compatible with old gu=
ests.
> >>>
> >>> The only downside is it's a bit more work as we need to
> >>> spec this out and add guest support.
> >>>
> >>>> To fix the case described above in the old kernels we can increase
> >>>> virtqueue_size to 256 and max_segments to 254. The pitfall here is
> >>>> that seabios allows the virtqueue_size-s < 128, however, the seabios
> >>>> patch extending that value to 256 is pending.
> >>> And the fix here is just to limit large vq size to virtio 1.0.
> >>> In that mode it's fine I think:
> >>>
> >>>
> >>>     /* check if the queue is available */
> >>>     if (vp->use_modern) {
> >>>         num =3D vp_read(&vp->common, virtio_pci_common_cfg, queue_siz=
e);
> >>>         if (num > MAX_QUEUE_NUM) {
> >>>             vp_write(&vp->common, virtio_pci_common_cfg, queue_size,
> >>>                      MAX_QUEUE_NUM);
> >>>             num =3D vp_read(&vp->common, virtio_pci_common_cfg, queue=
_size);
> >>>         }
> >>>     } else {
> >>>         num =3D vp_read(&vp->legacy, virtio_pci_legacy, queue_num);
> >>>     }
> The same seabios snippet,=A0 but more detailed:
>=20
> vp_find_vq()
> {
>  =A0=A0 ...
>  =A0=A0 /* check if the queue is available */
>  =A0=A0 if (vp->use_modern) {
>  =A0=A0=A0=A0=A0=A0 num =3D vp_read(&vp->common, virtio_pci_common_cfg, q=
ueue_size);
>  =A0=A0=A0=A0=A0=A0 if (num > MAX_QUEUE_NUM) {
>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 vp_write(&vp->common, virtio_pci_common_c=
fg, queue_size,
>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 MAX_QUEUE_NUM)=
;
>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 num =3D vp_read(&vp->common, virtio_pci_c=
ommon_cfg, queue_size);

So how about we drop this last line in bios?

Will fix things for existing hypervisors.
spec does not say guests need to re-read it.

>  =A0=A0=A0=A0=A0=A0 }
>  =A0=A0 } else {
>  =A0=A0=A0=A0=A0=A0 num =3D vp_read(&vp->legacy, virtio_pci_legacy, queue=
_num);
>  =A0=A0 }
>  =A0=A0 if (!num) {
>  =A0=A0=A0=A0=A0=A0 dprintf(1, "ERROR: queue size is 0\n");
>  =A0=A0=A0=A0=A0=A0 goto fail;
>  =A0=A0 }
>  =A0=A0 if (num > MAX_QUEUE_NUM) {
>  =A0=A0=A0=A0=A0=A0 dprintf(1, "ERROR: queue size %d > %d\n", num, MAX_QU=
EUE_NUM);
>  =A0=A0=A0=A0=A0=A0 goto fail;
>  =A0=A0 }
> ...
> }
>=20
> It turned out that the problem is here, but not because of the seabios co=
de.
> The virtqueue size is written and then incorrect value is re-read.
> Thanks to Roman Kagan (rkagan@virtuozzo.com) for investigating the root=
=20
> cause of the problem.
>=20
> As the code states, for the modern devices, seabios reads the queue size=
=20
> and if it's
> greater than seabios can support, reduce the queue size to the max=20
> seabios supported value.
>=20
> This doesn't work.
>=20
> The reason is that the size is read from the virtio device,
>=20
> virtio_pci_common_read()
> {
>  =A0=A0=A0 ...
>  =A0=A0=A0 case VIRTIO_PCI_COMMON_Q_SIZE:
>  =A0=A0=A0=A0=A0=A0=A0 val =3D virtio_queue_get_num(vdev, vdev->queue_sel=
);
>  =A0=A0=A0=A0=A0=A0=A0 break;
>  =A0=A0=A0 ...
> }
>=20
> but is written to the proxy
>=20
> virtio_pci_common_write()
> {
>  =A0=A0=A0 ...
>  =A0=A0=A0 case VIRTIO_PCI_COMMON_Q_SIZE:
>  =A0=A0=A0=A0=A0=A0=A0 proxy->vqs[vdev->queue_sel].num =3D val;
>  =A0=A0=A0=A0=A0=A0=A0 break;
>  =A0=A0 ...
> }.

Yea that's a bug. Here's a hacky way to fix it.
But I think really we should just get rid of the
two copies down the road.


diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
index c6b47a9c73..e5c759e19e 100644
--- a/hw/virtio/virtio-pci.c
+++ b/hw/virtio/virtio-pci.c
@@ -1256,6 +1256,8 @@ static void virtio_pci_common_write(void *opaque, hwa=
ddr addr,
         break;
     case VIRTIO_PCI_COMMON_Q_SIZE:
         proxy->vqs[vdev->queue_sel].num =3D val;
+        virtio_queue_set_num(vdev, vdev->queue_sel,
+                             proxy->vqs[vdev->queue_sel].num);
         break;
     case VIRTIO_PCI_COMMON_Q_MSIX:
         msix_vector_unuse(&proxy->pci_dev,


> The final stage of the size setting is propagated it from the proxy to=20
> the device on virtqueue enabling:
>=20
> virtio_cpi_common_write()
> {
>  =A0=A0=A0 ...
>  =A0=A0=A0 case VIRTIO_PCI_COMMON_Q_ENABLE:
>  =A0=A0=A0=A0=A0=A0=A0 virtio_queue_set_num(vdev, vdev->queue_sel,
>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 proxy->vqs[vdev->queue_sel].num);
>  =A0=A0=A0=A0=A0=A0=A0 virtio_queue_set_rings(vdev, vdev->queue_sel,
> ((uint64_t)proxy->vqs[vdev->queue_sel].desc[1]) << 32 |
>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 proxy=
->vqs[vdev->queue_sel].desc[0],
> ((uint64_t)proxy->vqs[vdev->queue_sel].avail[1]) << 32 |
>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 proxy=
->vqs[vdev->queue_sel].avail[0],
> ((uint64_t)proxy->vqs[vdev->queue_sel].used[1]) << 32 |
>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 proxy=
->vqs[vdev->queue_sel].used[0]);
>  =A0=A0=A0=A0=A0=A0=A0 proxy->vqs[vdev->queue_sel].enabled =3D 1;
>  =A0=A0=A0=A0=A0=A0=A0 break;
>  =A0=A0=A0 ...
> }.
>=20
> So we have the following workflow:
> suppose the device has virtqueue size =3D 256 and seabios MAX_QUEUE_NUM =
=3D 128.
> In that case the seabios works like:
>=20
> 1. if vp_modern read the size (256)
> 2. 256 > 128
> 3. write virtqueue size =3D 128
> 4. re-read virtqueue size =3D 256 !!!

bios probably should not re-read size, it's a waste of cpu cycles anyway.


> 5. fail because of the check
>  =A0=A0=A0 if (num > MAX_QUEUE_NUM) {
>  =A0=A0=A0=A0=A0=A0=A0 dprintf(1, "ERROR: queue size %d > %d\n", num, MAX=
_QUEUE_NUM);
>  =A0=A0=A0=A0=A0=A0=A0 goto fail;
>  =A0=A0=A0 }
>=20
> To fix the issue, we need to read and write the virtqueue size from the=
=20
> same place.
> Should we do with the proxy?
> Is there any reason to read from the device and write to the proxy?
>=20
> Furthermore, the size setting has a few flaws:
>=20
> 1. The size being set should be a power of 2
> 2. The size being set should be less or equal to the virtqueue size (and=
=20
> be greater that 2?)

I think 1 is checked in virtio_queue_set_num.
I guess we should check 2 as well?


>=20
> Denis
> >> you mean to put the code like this into virtio_pci_realize() inside QE=
MU?
> >>
> >> If no, can you pls clarify which component should be touched.
> >>
> >> Den
> > I mean:
> >   - add an API to change the default queue size
> >   - add a validate features callback, in there check and for modern
> >     flag set in features increase the queue size
> >
> > maybe all this is too much work, we could block this
> > for transitional devices, but your patch does not do it,
> > you need to check that legacy is enabled not that modern
> > is not disabled.
> >
> >
> >
>=20


