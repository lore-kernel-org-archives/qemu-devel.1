Return-Path: <SRS0=pQgJ=ZH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E7F7C432C3
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2019 03:26:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 28AA4206EF
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2019 03:26:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g8F1dkDZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28AA4206EF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35096 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iVSFS-0001iq-BK
	for qemu-devel@archiver.kernel.org; Thu, 14 Nov 2019 22:26:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43248)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.williamson@redhat.com>) id 1iVSEe-0000zh-Lv
 for qemu-devel@nongnu.org; Thu, 14 Nov 2019 22:25:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.williamson@redhat.com>) id 1iVSEb-0000Q6-El
 for qemu-devel@nongnu.org; Thu, 14 Nov 2019 22:25:23 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:23215
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
 id 1iVSEZ-0000PQ-Ft
 for qemu-devel@nongnu.org; Thu, 14 Nov 2019 22:25:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573788318;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CBp4FmTFndoV2E6Z2nSTSST44p0wLfI37SUsgMQuKGo=;
 b=g8F1dkDZeG1L/fjiShtL8HKGpGI8I9NU/jIrKVn1Gof5VPHApNHKTrvpClSZxvOqXZHX1q
 FBNfgcq2JTA4BJ+dQjy6AdQ2ikZbipGM00xn0M3JQiMG11G9XG2uQbpi9CW86uX5Oentka
 3CVC3PkSqPkmsyhP+w7zvHYOxInRl0Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-381-Ww_qgsfoNW2x5uLx9PHSHg-1; Thu, 14 Nov 2019 22:25:15 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3C806802695;
 Fri, 15 Nov 2019 03:25:12 +0000 (UTC)
Received: from x1.home (ovpn-116-56.phx2.redhat.com [10.3.116.56])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B81F4101F6CA;
 Fri, 15 Nov 2019 03:25:09 +0000 (UTC)
Date: Thu, 14 Nov 2019 20:21:33 -0700
From: Alex Williamson <alex.williamson@redhat.com>
To: Yan Zhao <yan.y.zhao@intel.com>
Subject: Re: [PATCH v9 Kernel 2/5] vfio iommu: Add ioctl defination to get
 dirty pages bitmap.
Message-ID: <20191114202133.4b046cb9@x1.home>
In-Reply-To: <20191115024035.GA24163@joy-OptiPlex-7040>
References: <1573578220-7530-1-git-send-email-kwankhede@nvidia.com>
 <1573578220-7530-3-git-send-email-kwankhede@nvidia.com>
 <20191112153020.71406c44@x1.home>
 <324ce4f8-d655-ee37-036c-fc9ef9045bef@nvidia.com>
 <20191113130705.32c6b663@x1.home>
 <7f74a2a1-ba1c-9d4c-dc5e-343ecdd7d6d6@nvidia.com>
 <20191114140625.213e8a99@x1.home>
 <20191115024035.GA24163@joy-OptiPlex-7040>
Organization: Red Hat
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: Ww_qgsfoNW2x5uLx9PHSHg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: "Zhengxiao.zx@Alibaba-inc.com" <Zhengxiao.zx@Alibaba-inc.com>, "Tian,
 Kevin" <kevin.tian@intel.com>, "Liu, Yi
 L" <yi.l.liu@intel.com>, "cjia@nvidia.com" <cjia@nvidia.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "eskultet@redhat.com" <eskultet@redhat.com>, "Yang,
 Ziye" <ziye.yang@intel.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "cohuck@redhat.com" <cohuck@redhat.com>,
 "shuangtai.tst@alibaba-inc.com" <shuangtai.tst@alibaba-inc.com>,
 "dgilbert@redhat.com" <dgilbert@redhat.com>, "Wang,
 Zhi A" <zhi.a.wang@intel.com>, "mlevitsk@redhat.com" <mlevitsk@redhat.com>,
 "pasic@linux.ibm.com" <pasic@linux.ibm.com>, "aik@ozlabs.ru" <aik@ozlabs.ru>,
 Kirti Wankhede <kwankhede@nvidia.com>, "eauger@redhat.com" <eauger@redhat.com>,
 "felipe@nutanix.com" <felipe@nutanix.com>,
 "jonathan.davies@nutanix.com" <jonathan.davies@nutanix.com>, "Liu,
 Changpeng" <changpeng.liu@intel.com>, "Ken.Xue@amd.com" <Ken.Xue@amd.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 14 Nov 2019 21:40:35 -0500
Yan Zhao <yan.y.zhao@intel.com> wrote:

> On Fri, Nov 15, 2019 at 05:06:25AM +0800, Alex Williamson wrote:
> > On Fri, 15 Nov 2019 00:26:07 +0530
> > Kirti Wankhede <kwankhede@nvidia.com> wrote:
> >  =20
> > > On 11/14/2019 1:37 AM, Alex Williamson wrote: =20
> > > > On Thu, 14 Nov 2019 01:07:21 +0530
> > > > Kirti Wankhede <kwankhede@nvidia.com> wrote:
> > > >    =20
> > > >> On 11/13/2019 4:00 AM, Alex Williamson wrote:   =20
> > > >>> On Tue, 12 Nov 2019 22:33:37 +0530
> > > >>> Kirti Wankhede <kwankhede@nvidia.com> wrote:
> > > >>>       =20
> > > >>>> All pages pinned by vendor driver through vfio_pin_pages API sho=
uld be
> > > >>>> considered as dirty during migration. IOMMU container maintains =
a list of
> > > >>>> all such pinned pages. Added an ioctl defination to get bitmap o=
f such   =20
> > > >>>
> > > >>> definition
> > > >>>       =20
> > > >>>> pinned pages for requested IO virtual address range.   =20
> > > >>>
> > > >>> Additionally, all mapped pages are considered dirty when physical=
ly
> > > >>> mapped through to an IOMMU, modulo we discussed devices opting in=
 to
> > > >>> per page pinning to indicate finer granularity with a TBD mechani=
sm to
> > > >>> figure out if any non-opt-in devices remain.
> > > >>>       =20
> > > >>
> > > >> You mean, in case of device direct assignment (device pass through=
)?   =20
> > > >=20
> > > > Yes, or IOMMU backed mdevs.  If vfio_dmas in the container are full=
y
> > > > pinned and mapped, then the correct dirty page set is all mapped pa=
ges.
> > > > We discussed using the vpfn list as a mechanism for vendor drivers =
to
> > > > reduce their migration footprint, but we also discussed that we wou=
ld
> > > > need a way to determine that all participants in the container have
> > > > explicitly pinned their working pages or else we must consider the
> > > > entire potential working set as dirty.
> > > >    =20
> > >=20
> > > How can vendor driver tell this capability to iommu module? Any sugge=
stions? =20
> >=20
> > I think it does so by pinning pages.  Is it acceptable that if the
> > vendor driver pins any pages, then from that point forward we consider
> > the IOMMU group dirty page scope to be limited to pinned pages?  There
> > are complications around non-singleton IOMMU groups, but I think we're
> > already leaning towards that being a non-worthwhile problem to solve.
> > So if we require that only singleton IOMMU groups can pin pages and we
> > pass the IOMMU group as a parameter to
> > vfio_iommu_driver_ops.pin_pages(), then the type1 backend can set a
> > flag on its local vfio_group struct to indicate dirty page scope is
> > limited to pinned pages.  We might want to keep a flag on the
> > vfio_iommu struct to indicate if all of the vfio_groups for each
> > vfio_domain in the vfio_iommu.domain_list dirty page scope limited to
> > pinned pages as an optimization to avoid walking lists too often.  Then
> > we could test if vfio_iommu.domain_list is not empty and this new flag
> > does not limit the dirty page scope, then everything within each
> > vfio_dma is considered dirty.
> > =20
>=20
> hi Alex
> could you help clarify whether my understandings below are right?
> In future,
> 1. for mdev and for passthrough device withoug hardware ability to track
> dirty pages, the vendor driver has to explicitly call
> vfio_pin_pages()/vfio_unpin_pages() + a flag to tell vfio its dirty page =
set.

For non-IOMMU backed mdevs without hardware dirty page tracking,
there's no change to the vendor driver currently.  Pages pinned by the
vendor driver are marked as dirty.

For any IOMMU backed device, mdev or direct assignment, all mapped
memory would be considered dirty unless there are explicit calls to pin
pages on top of the IOMMU page pinning and mapping.  These would likely
be enabled only when the device is in the _SAVING device_state.

> 2. for those devices with hardware ability to track dirty pages, will sti=
ll
> provide a callback to vendor driver to get dirty pages. (as for those dev=
ices,
> it is hard to explicitly call vfio_pin_pages()/vfio_unpin_pages())
>
> 3. for devices relying on dirty bit info in physical IOMMU, there
> will be a callback to physical IOMMU driver to get dirty page set from
> vfio.

The proposal here does not cover exactly how these would be
implemented, it only establishes the container as the point of user
interaction with the dirty bitmap and hopefully allows us to maintain
that interface regardless of whether we have dirty tracking at the
device or the system IOMMU.  Ideally devices with dirty tracking would
make use of page pinning and we'd extend the interface to allow vendor
drivers the ability to indicate the clean/dirty state of those pinned
pages.  For system IOMMU dirty page tracking, that potentially might
mean that we support IOMMU page faults and the container manages those
faults such that the container is the central record of dirty pages.
Until these interfaces are designed, we can only speculate, but the
goal is to design a user interface compatible with how those features
might evolve.  If you identify something that can't work, please raise
the issue.  Thanks,

Alex


