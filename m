Return-Path: <SRS0=QD06=ZF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8D70C432C3
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2019 20:23:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F8B5206F2
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2019 20:23:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PXATA0mY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F8B5206F2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50650 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iUzBA-0001hV-Q5
	for qemu-devel@archiver.kernel.org; Wed, 13 Nov 2019 15:23:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38165)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.williamson@redhat.com>) id 1iUz9t-0001F8-1e
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 15:22:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.williamson@redhat.com>) id 1iUz9q-0006kc-DW
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 15:22:31 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:51319
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
 id 1iUz9p-0006jM-Tv
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 15:22:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573676549;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wlGEC0VPXYDz82zBu54hly9iDvxNA97A5KyZweue1QE=;
 b=PXATA0mYIIWDmiTMomgjssgMt/nMFBE1yIa/NkogF5uDXn1ZLdlNfQ5jrwdSXZlplR8Usi
 /SPoFYWlzm/QDzLQOZUPSyb/180bZunkxPKTrW/XU/K5WSQG9Chshw5FF4gcDing2XFHmG
 baSLEGamSRYWtA1VY8iG/9/eN5TadO4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-285-PjADqJW5PYuMoPEQ_FZUdw-1; Wed, 13 Nov 2019 15:22:26 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9D0B4107ACC5;
 Wed, 13 Nov 2019 20:22:21 +0000 (UTC)
Received: from x1.home (ovpn-116-138.phx2.redhat.com [10.3.116.138])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D80484A;
 Wed, 13 Nov 2019 20:22:19 +0000 (UTC)
Date: Wed, 13 Nov 2019 13:22:19 -0700
From: Alex Williamson <alex.williamson@redhat.com>
To: Kirti Wankhede <kwankhede@nvidia.com>
Subject: Re: [PATCH v9 Kernel 3/5] vfio iommu: Add ioctl defination to unmap
 IOVA and return dirty bitmap
Message-ID: <20191113132219.5075b32e@x1.home>
In-Reply-To: <a148c5e2-ad34-6973-de50-eab472ed38fb@nvidia.com>
References: <1573578220-7530-1-git-send-email-kwankhede@nvidia.com>
 <1573578220-7530-4-git-send-email-kwankhede@nvidia.com>
 <20191112153017.3c792673@x1.home>
 <a148c5e2-ad34-6973-de50-eab472ed38fb@nvidia.com>
Organization: Red Hat
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: PjADqJW5PYuMoPEQ_FZUdw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
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
Cc: Zhengxiao.zx@Alibaba-inc.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 cjia@nvidia.com, kvm@vger.kernel.org, eskultet@redhat.com, ziye.yang@intel.com,
 qemu-devel@nongnu.org, cohuck@redhat.com, shuangtai.tst@alibaba-inc.com,
 dgilbert@redhat.com, zhi.a.wang@intel.com, mlevitsk@redhat.com,
 pasic@linux.ibm.com, aik@ozlabs.ru, eauger@redhat.com, felipe@nutanix.com,
 jonathan.davies@nutanix.com, yan.y.zhao@intel.com, changpeng.liu@intel.com,
 Ken.Xue@amd.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 14 Nov 2019 01:22:39 +0530
Kirti Wankhede <kwankhede@nvidia.com> wrote:

> On 11/13/2019 4:00 AM, Alex Williamson wrote:
> > On Tue, 12 Nov 2019 22:33:38 +0530
> > Kirti Wankhede <kwankhede@nvidia.com> wrote:
> >  =20
> >> With vIOMMU, during pre-copy phase of migration, while CPUs are still
> >> running, IO virtual address unmap can happen while device still keepin=
g
> >> reference of guest pfns. Those pages should be reported as dirty befor=
e
> >> unmap, so that VFIO user space application can copy content of those p=
ages
> >> from source to destination.
> >>
> >> IOCTL defination added here add bitmap pointer, size and flag. If flag=
 =20
> >=20
> > definition, adds
> >  =20
> >> VFIO_DMA_UNMAP_FLAG_GET_DIRTY_BITMAP is set and bitmap memory is alloc=
ated
> >> and bitmap_size of set, then ioctl will create bitmap of pinned pages =
and =20
> >=20
> > s/of/is/
> >  =20
> >> then unmap those.
> >>
> >> Signed-off-by: Kirti Wankhede <kwankhede@nvidia.com>
> >> Reviewed-by: Neo Jia <cjia@nvidia.com>
> >> ---
> >>   include/uapi/linux/vfio.h | 33 +++++++++++++++++++++++++++++++++
> >>   1 file changed, 33 insertions(+)
> >>
> >> diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
> >> index 6fd3822aa610..72fd297baf52 100644
> >> --- a/include/uapi/linux/vfio.h
> >> +++ b/include/uapi/linux/vfio.h
> >> @@ -925,6 +925,39 @@ struct vfio_iommu_type1_dirty_bitmap {
> >>  =20
> >>   #define VFIO_IOMMU_GET_DIRTY_BITMAP             _IO(VFIO_TYPE, VFIO_=
BASE + 17)
> >>  =20
> >> +/**
> >> + * VFIO_IOMMU_UNMAP_DMA_GET_BITMAP - _IOWR(VFIO_TYPE, VFIO_BASE + 18,
> >> + *=09=09=09=09      struct vfio_iommu_type1_dma_unmap_bitmap)
> >> + *
> >> + * Unmap IO virtual addresses using the provided struct
> >> + * vfio_iommu_type1_dma_unmap_bitmap.  Caller sets argsz.
> >> + * VFIO_DMA_UNMAP_FLAG_GET_DIRTY_BITMAP should be set to get dirty bi=
tmap
> >> + * before unmapping IO virtual addresses. If this flag is not set, on=
ly IO
> >> + * virtual address are unmapped without creating pinned pages bitmap,=
 that
> >> + * is, behave same as VFIO_IOMMU_UNMAP_DMA ioctl.
> >> + * User should allocate memory to get bitmap and should set size of a=
llocated
> >> + * memory in bitmap_size field. One bit in bitmap is used to represen=
t per page
> >> + * consecutively starting from iova offset. Bit set indicates page at=
 that
> >> + * offset from iova is dirty.
> >> + * The actual unmapped size is returned in the size field and bitmap =
of pages
> >> + * in the range of unmapped size is returned in bitmap if flag
> >> + * VFIO_DMA_UNMAP_FLAG_GET_DIRTY_BITMAP is set.
> >> + *
> >> + * No guarantee is made to the user that arbitrary unmaps of iova or =
size
> >> + * different from those used in the original mapping call will succee=
d.
> >> + */
> >> +struct vfio_iommu_type1_dma_unmap_bitmap {
> >> +=09__u32        argsz;
> >> +=09__u32        flags;
> >> +#define VFIO_DMA_UNMAP_FLAG_GET_DIRTY_BITMAP (1 << 0)
> >> +=09__u64        iova;                        /* IO virtual address */
> >> +=09__u64        size;                        /* Size of mapping (byte=
s) */
> >> +=09__u64        bitmap_size;                 /* in bytes */
> >> +=09void __user *bitmap;                      /* one bit per page */
> >> +};
> >> +
> >> +#define VFIO_IOMMU_UNMAP_DMA_GET_BITMAP _IO(VFIO_TYPE, VFIO_BASE + 18=
)
> >> + =20
> >=20
> > Why not extend VFIO_IOMMU_UNMAP_DMA to support this rather than add an
> > ioctl that duplicates the functionality and extends it??  =20
>=20
> We do want old userspace applications to work with new kernel and=20
> vice-versa, right?
>=20
> If I try to change existing VFIO_IOMMU_UNMAP_DMA ioctl structure, say if=
=20
> add 'bitmap_size' and 'bitmap' after 'size', with below code in old=20
> kernel, old kernel & new userspace will work.
>=20
>          minsz =3D offsetofend(struct vfio_iommu_type1_dma_unmap, size);
>=20
>          if (copy_from_user(&unmap, (void __user *)arg, minsz))
>                  return -EFAULT;
>=20
>          if (unmap.argsz < minsz || unmap.flags)
>                  return -EINVAL;
>=20
>=20
> With new kernel it would change to:
>          minsz =3D offsetofend(struct vfio_iommu_type1_dma_unmap, bitmap)=
;

No, the minimum structure size still ends at size, we interpret flags
and argsz to learn if the user understands those fields and optionally
include them.  Therefore old userspace on new kernel continues to work.

>          if (copy_from_user(&unmap, (void __user *)arg, minsz))
>                  return -EFAULT;
>=20
>          if (unmap.argsz < minsz || unmap.flags)
>                  return -EINVAL;
>=20
> Then old userspace app will fail because unmap.argsz < minsz and might=20
> be copy_from_user would cause seg fault because userspace sdk doesn't=20
> contain new member variables.
> We can't change the sequence to keep 'size' as last member, because then=
=20
> new userspace app on old kernel will interpret it wrong.

If we have new userspace on old kernel, that userspace needs to be able
to learn that this feature exists (new flag in the
vfio_iommu_type1_info struct as suggested below) and only make use of it
when available.  This is why the old kernel checks argsz against minsz.
So long as the user passes something at least minsz in size, we have
compatibility.  The old kernel doesn't understand the GET_DIRTY_BITMAP
flag and will return an error if the user attempts to use it.  Thanks,

Alex
=20
> > Otherwise
> > same comments as previous, in fact it's too bad we can't use this ioctl
> > for both, but a DONT_UNMAP flag on the UNMAP_DMA ioctl seems a bit
> > absurd.
> >=20
> > I suspect we also want a flags bit in VFIO_IOMMU_GET_INFO to indicate
> > these capabilities are supported.
> >  =20
>=20
> Ok. I'll add that.
>=20
> > Maybe for both ioctls we also want to define it as the user's
> > responsibility to zero the bitmap, requiring the kernel to only set
> > bits as necessary.  =20
>=20
> Ok. Updating comment.
>=20
> Thanks,
> Kirti
>=20
> > Thanks,
> >=20
> > Alex
> >  =20
> >>   /* -------- Additional API for SPAPR TCE (Server POWERPC) IOMMU ----=
---- */
> >>  =20
> >>   /* =20
> >  =20
>=20


