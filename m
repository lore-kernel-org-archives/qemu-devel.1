Return-Path: <SRS0=NHD5=ZG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70DF0C432C3
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2019 21:09:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F6E2206E1
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2019 21:09:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ma7N64UA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F6E2206E1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33732 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iVMN7-0001c1-ED
	for qemu-devel@archiver.kernel.org; Thu, 14 Nov 2019 16:09:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45550)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.williamson@redhat.com>) id 1iVMLx-0000jn-Dl
 for qemu-devel@nongnu.org; Thu, 14 Nov 2019 16:08:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.williamson@redhat.com>) id 1iVMLv-0007w9-V0
 for qemu-devel@nongnu.org; Thu, 14 Nov 2019 16:08:33 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:36109
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
 id 1iVMLv-0007vz-RY
 for qemu-devel@nongnu.org; Thu, 14 Nov 2019 16:08:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573765711;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5pDDzLjSI9qqUSPbYB+psol3zH7V2uqbHtghDpsPPfw=;
 b=Ma7N64UAjPXSZb0I1kK/hH14vp419Y/4hVl6LL6fMutlXZrxE6rJ3QRrUZzQwPOapcAWbO
 St/AasopnWSDxZwQDrgXd8yAJpwiP+u0zvZLx1UcPrZwdY8ac8ojFk+iPV7nHj6i4AM0sz
 T5EjbH7NTqmbG9qaIYz0bCnfHzuYlfE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-25-vveDkcKHPMmtyIMiyhPKmg-1; Thu, 14 Nov 2019 16:08:29 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4D071800C77;
 Thu, 14 Nov 2019 21:08:27 +0000 (UTC)
Received: from x1.home (ovpn-116-138.phx2.redhat.com [10.3.116.138])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E88355C1D4;
 Thu, 14 Nov 2019 21:08:25 +0000 (UTC)
Date: Thu, 14 Nov 2019 14:08:25 -0700
From: Alex Williamson <alex.williamson@redhat.com>
To: Kirti Wankhede <kwankhede@nvidia.com>
Subject: Re: [PATCH v9 Kernel 3/5] vfio iommu: Add ioctl defination to unmap
 IOVA and return dirty bitmap
Message-ID: <20191114140825.7472970d@x1.home>
In-Reply-To: <1f8fc51f-8bdc-7c0c-43ce-1b252f429260@nvidia.com>
References: <1573578220-7530-1-git-send-email-kwankhede@nvidia.com>
 <1573578220-7530-4-git-send-email-kwankhede@nvidia.com>
 <20191112153017.3c792673@x1.home>
 <a148c5e2-ad34-6973-de50-eab472ed38fb@nvidia.com>
 <20191113132219.5075b32e@x1.home>
 <1f8fc51f-8bdc-7c0c-43ce-1b252f429260@nvidia.com>
Organization: Red Hat
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: vveDkcKHPMmtyIMiyhPKmg-1
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

On Fri, 15 Nov 2019 00:26:26 +0530
Kirti Wankhede <kwankhede@nvidia.com> wrote:

> On 11/14/2019 1:52 AM, Alex Williamson wrote:
> > On Thu, 14 Nov 2019 01:22:39 +0530
> > Kirti Wankhede <kwankhede@nvidia.com> wrote:
> >  =20
> >> On 11/13/2019 4:00 AM, Alex Williamson wrote: =20
> >>> On Tue, 12 Nov 2019 22:33:38 +0530
> >>> Kirti Wankhede <kwankhede@nvidia.com> wrote:
> >>>     =20
> >>>> With vIOMMU, during pre-copy phase of migration, while CPUs are stil=
l
> >>>> running, IO virtual address unmap can happen while device still keep=
ing
> >>>> reference of guest pfns. Those pages should be reported as dirty bef=
ore
> >>>> unmap, so that VFIO user space application can copy content of those=
 pages
> >>>> from source to destination.
> >>>>
> >>>> IOCTL defination added here add bitmap pointer, size and flag. If fl=
ag =20
> >>>
> >>> definition, adds
> >>>     =20
> >>>> VFIO_DMA_UNMAP_FLAG_GET_DIRTY_BITMAP is set and bitmap memory is all=
ocated
> >>>> and bitmap_size of set, then ioctl will create bitmap of pinned page=
s and =20
> >>>
> >>> s/of/is/
> >>>     =20
> >>>> then unmap those.
> >>>>
> >>>> Signed-off-by: Kirti Wankhede <kwankhede@nvidia.com>
> >>>> Reviewed-by: Neo Jia <cjia@nvidia.com>
> >>>> ---
> >>>>    include/uapi/linux/vfio.h | 33 +++++++++++++++++++++++++++++++++
> >>>>    1 file changed, 33 insertions(+)
> >>>>
> >>>> diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
> >>>> index 6fd3822aa610..72fd297baf52 100644
> >>>> --- a/include/uapi/linux/vfio.h
> >>>> +++ b/include/uapi/linux/vfio.h
> >>>> @@ -925,6 +925,39 @@ struct vfio_iommu_type1_dirty_bitmap {
> >>>>   =20
> >>>>    #define VFIO_IOMMU_GET_DIRTY_BITMAP             _IO(VFIO_TYPE, VF=
IO_BASE + 17)
> >>>>   =20
> >>>> +/**
> >>>> + * VFIO_IOMMU_UNMAP_DMA_GET_BITMAP - _IOWR(VFIO_TYPE, VFIO_BASE + 1=
8,
> >>>> + *=09=09=09=09      struct vfio_iommu_type1_dma_unmap_bitmap)
> >>>> + *
> >>>> + * Unmap IO virtual addresses using the provided struct
> >>>> + * vfio_iommu_type1_dma_unmap_bitmap.  Caller sets argsz.
> >>>> + * VFIO_DMA_UNMAP_FLAG_GET_DIRTY_BITMAP should be set to get dirty =
bitmap
> >>>> + * before unmapping IO virtual addresses. If this flag is not set, =
only IO
> >>>> + * virtual address are unmapped without creating pinned pages bitma=
p, that
> >>>> + * is, behave same as VFIO_IOMMU_UNMAP_DMA ioctl.
> >>>> + * User should allocate memory to get bitmap and should set size of=
 allocated
> >>>> + * memory in bitmap_size field. One bit in bitmap is used to repres=
ent per page
> >>>> + * consecutively starting from iova offset. Bit set indicates page =
at that
> >>>> + * offset from iova is dirty.
> >>>> + * The actual unmapped size is returned in the size field and bitma=
p of pages
> >>>> + * in the range of unmapped size is returned in bitmap if flag
> >>>> + * VFIO_DMA_UNMAP_FLAG_GET_DIRTY_BITMAP is set.
> >>>> + *
> >>>> + * No guarantee is made to the user that arbitrary unmaps of iova o=
r size
> >>>> + * different from those used in the original mapping call will succ=
eed.
> >>>> + */
> >>>> +struct vfio_iommu_type1_dma_unmap_bitmap {
> >>>> +=09__u32        argsz;
> >>>> +=09__u32        flags;
> >>>> +#define VFIO_DMA_UNMAP_FLAG_GET_DIRTY_BITMAP (1 << 0)
> >>>> +=09__u64        iova;                        /* IO virtual address =
*/
> >>>> +=09__u64        size;                        /* Size of mapping (by=
tes) */
> >>>> +=09__u64        bitmap_size;                 /* in bytes */
> >>>> +=09void __user *bitmap;                      /* one bit per page */
> >>>> +};
> >>>> +
> >>>> +#define VFIO_IOMMU_UNMAP_DMA_GET_BITMAP _IO(VFIO_TYPE, VFIO_BASE + =
18)
> >>>> + =20
> >>>
> >>> Why not extend VFIO_IOMMU_UNMAP_DMA to support this rather than add a=
n
> >>> ioctl that duplicates the functionality and extends it?? =20
> >>
> >> We do want old userspace applications to work with new kernel and
> >> vice-versa, right?
> >>
> >> If I try to change existing VFIO_IOMMU_UNMAP_DMA ioctl structure, say =
if
> >> add 'bitmap_size' and 'bitmap' after 'size', with below code in old
> >> kernel, old kernel & new userspace will work.
> >>
> >>           minsz =3D offsetofend(struct vfio_iommu_type1_dma_unmap, siz=
e);
> >>
> >>           if (copy_from_user(&unmap, (void __user *)arg, minsz))
> >>                   return -EFAULT;
> >>
> >>           if (unmap.argsz < minsz || unmap.flags)
> >>                   return -EINVAL;
> >>
> >>
> >> With new kernel it would change to:
> >>           minsz =3D offsetofend(struct vfio_iommu_type1_dma_unmap, bit=
map); =20
> >=20
> > No, the minimum structure size still ends at size, we interpret flags
> > and argsz to learn if the user understands those fields and optionally
> > include them.  Therefore old userspace on new kernel continues to work.
> >  =20
> >>           if (copy_from_user(&unmap, (void __user *)arg, minsz))
> >>                   return -EFAULT;
> >>
> >>           if (unmap.argsz < minsz || unmap.flags)
> >>                   return -EINVAL;
> >>
> >> Then old userspace app will fail because unmap.argsz < minsz and might
> >> be copy_from_user would cause seg fault because userspace sdk doesn't
> >> contain new member variables.
> >> We can't change the sequence to keep 'size' as last member, because th=
en
> >> new userspace app on old kernel will interpret it wrong. =20
> >=20
> > If we have new userspace on old kernel, that userspace needs to be able
> > to learn that this feature exists (new flag in the
> > vfio_iommu_type1_info struct as suggested below) and only make use of i=
t
> > when available.  This is why the old kernel checks argsz against minsz.
> > So long as the user passes something at least minsz in size, we have
> > compatibility.  The old kernel doesn't understand the GET_DIRTY_BITMAP
> > flag and will return an error if the user attempts to use it.  Thanks,
> >  =20
>=20
> Ok. So then VFIO_IOMMU_UNMAP_DMA_GET_BITMAP ioctl is not needed. I'll do=
=20
> the change. Again bitmap will be created considering smallest page size=
=20
> of iova_pgsizes
>=20
> But VFIO_IOMMU_GET_DIRTY_BITMAP ioctl will still required, right?

Yes, I'm not willing to suggest a flag on an unmap ioctl that
eliminates the unmap just so we can re-use it for retrieving a dirty
page bitmap.  That'd be ugly.  Thanks,

Alex


