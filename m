Return-Path: <SRS0=6joO=EP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E220C2D0A3
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 20:31:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B7CA9206D8
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 20:31:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J8m1ix3H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7CA9206D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45562 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kcDp5-0002yT-NK
	for qemu-devel@archiver.kernel.org; Mon, 09 Nov 2020 15:31:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50716)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1kcDnc-0002Lb-46
 for qemu-devel@nongnu.org; Mon, 09 Nov 2020 15:30:00 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:24334)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1kcDnZ-0007Dp-V7
 for qemu-devel@nongnu.org; Mon, 09 Nov 2020 15:29:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604953797;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kMXJSBTGJNybytcSyrPT/t/N94qrIkuRMRD/A00Fdgg=;
 b=J8m1ix3HZ2ML0YvNkOB+Afgcburb+P50K7YEmzG+V76d4xWBVvjy3xA7syXinPbXXS4gEG
 2MIpULn6EBJW4bGDR6ZvkKCws/8+X5qs2OvZfCnfMkZ6fHJwDmkcFg/ULE631lZYSLjLlM
 85Rh+SNRjVSA4bCUebNKvvpf42/VSoY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-515-fsqXXJ98OcOns2BmMIpA_w-1; Mon, 09 Nov 2020 15:29:53 -0500
X-MC-Unique: fsqXXJ98OcOns2BmMIpA_w-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5F5B0188C122;
 Mon,  9 Nov 2020 20:29:52 +0000 (UTC)
Received: from w520.home (ovpn-112-213.phx2.redhat.com [10.3.112.213])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D737410013D9;
 Mon,  9 Nov 2020 20:29:51 +0000 (UTC)
Date: Mon, 9 Nov 2020 13:29:50 -0700
From: Alex Williamson <alex.williamson@redhat.com>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Subject: Re: [RFC PATCH for-QEMU-5.2] vfio: Make migration support experimental
Message-ID: <20201109132950.6c2dfe02@w520.home>
In-Reply-To: <20201109194417.GR3024@work-vm>
References: <160494787833.1473.10514376876696596117.stgit@gimli.home>
 <20201109194417.GR3024@work-vm>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=alex.williamson@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=216.205.24.124;
 envelope-from=alex.williamson@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/09 00:04:29
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: Neo Jia <cjia@nvidia.com>, Juan Quintela <quintela@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, qemu-devel@nongnu.org,
 Kirti Wankhede <kwankhede@nvidia.com>,
 Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 9 Nov 2020 19:44:17 +0000
"Dr. David Alan Gilbert" <dgilbert@redhat.com> wrote:

> * Alex Williamson (alex.williamson@redhat.com) wrote:
> > Per the proposed documentation for vfio device migration:
> >=20
> >   Dirty pages are tracked when device is in stop-and-copy phase
> >   because if pages are marked dirty during pre-copy phase and
> >   content is transfered from source to destination, there is no
> >   way to know newly dirtied pages from the point they were copied
> >   earlier until device stops. To avoid repeated copy of same
> >   content, pinned pages are marked dirty only during
> >   stop-and-copy phase.
> >=20
> > Essentially, since we don't have hardware dirty page tracking for
> > assigned devices at this point, we consider any page that is pinned
> > by an mdev vendor driver or pinned and mapped through the IOMMU to
> > be perpetually dirty.  In the worst case, this may result in all of
> > guest memory being considered dirty during every iteration of live
> > migration.  The current vfio implementation of migration has chosen
> > to mask device dirtied pages until the final stages of migration in
> > order to avoid this worst case scenario.
> >=20
> > Allowing the device to implement a policy decision to prioritize
> > reduced migration data like this jeopardizes QEMU's overall ability
> > to implement any degree of service level guarantees during migration.
> > For example, any estimates towards achieving acceptable downtime
> > margins cannot be trusted when such a device is present.  The vfio
> > device should participate in dirty page tracking to the best of its
> > ability throughout migration, even if that means the dirty footprint
> > of the device impedes migration progress, allowing both QEMU and
> > higher level management tools to decide whether to continue the
> > migration or abort due to failure to achieve the desired behavior. =20
>=20
> I don't feel particularly badly about the decision to squash it in
> during the stop-and-copy phase; for devices where the pinned memory
> is large, I don't think doing it during the main phase makes much sense;
> especially if you then have to deal with tracking changes in pinning.


AFAIK the kernel support for tracking changes in page pinning already
exists, this is largely the vfio device in QEMU that decides when to
start exposing the device dirty footprint to QEMU.  I'm a bit surprised
by this answer though, we don't really know what the device memory
footprint is.  It might be large, it might be nothing, but by not
participating in dirty page tracking until the VM is stopped, we can't
know what the footprint is and how it will affect downtime.  Is it
really the place of a QEMU device driver to impose this sort of policy?


> Having said that, I agree with marking it as experimental, because
> I'm dubious how useful it will be for the same reason, I worry
> about whether the downtime will be so large to make it pointless.


TBH I think that's the wrong reason to mark it experimental.  There's
clearly demand for vfio device migration and even if the practical use
cases are initially small, they will expand over time and hardware will
get better.  My objection is that the current behavior masks the
hardware and device limitations, leading to unrealistic expectations.
If the user expects minimal downtime, configures convergence to account
for that, QEMU thinks it can achieve it, and then the device marks
everything dirty, that's not supportable.  OTOH if the vfio device
participates in dirty tracking through pre-copy, then the practical use
cases will find themselves as migrations will either be aborted because
downtime tolerances cannot be achieved or downtimes will be configured
to match reality.  Thanks,

Alex

> Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
>=20
> > Link: https://lists.gnu.org/archive/html/qemu-devel/2020-11/msg00807.ht=
ml
> > Cc: Kirti Wankhede <kwankhede@nvidia.com>
> > Cc: Neo Jia <cjia@nvidia.com>
> > Cc: Dr. David Alan Gilbert <dgilbert@redhat.com>
> > Cc: Juan Quintela <quintela@redhat.com>
> > Cc: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> > Cc: Cornelia Huck <cohuck@redhat.com>
> > Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
> > ---
> >=20
> > Given that our discussion in the link above seems to be going in
> > circles, I'm afraid it seems necessary to both have a contigency
> > plan and to raise the visibility of the current behavior to
> > determine whether others agree that this is a sufficiently
> > troubling behavior to consider migration support experimental
> > at this stage.  Please voice your opinion or contribute patches
> > to resolve this before QEMU 5.2.  Thanks,
> >=20
> > Alex
> >=20
> >  hw/vfio/migration.c           |    2 +-
> >  hw/vfio/pci.c                 |    2 ++
> >  include/hw/vfio/vfio-common.h |    1 +
> >  3 files changed, 4 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
> > index 3ce285ea395d..cd44d465a50b 100644
> > --- a/hw/vfio/migration.c
> > +++ b/hw/vfio/migration.c
> > @@ -882,7 +882,7 @@ int vfio_migration_probe(VFIODevice *vbasedev, Erro=
r **errp)
> >      Error *local_err =3D NULL;
> >      int ret =3D -ENOTSUP;
> > =20
> > -    if (!container->dirty_pages_supported) {
> > +    if (!vbasedev->enable_migration || !container->dirty_pages_support=
ed) {
> >          goto add_blocker;
> >      }
> > =20
> > diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> > index 58c0ce8971e3..1349b900e513 100644
> > --- a/hw/vfio/pci.c
> > +++ b/hw/vfio/pci.c
> > @@ -3194,6 +3194,8 @@ static Property vfio_pci_dev_properties[] =3D {
> >                      VFIO_FEATURE_ENABLE_REQ_BIT, true),
> >      DEFINE_PROP_BIT("x-igd-opregion", VFIOPCIDevice, features,
> >                      VFIO_FEATURE_ENABLE_IGD_OPREGION_BIT, false),
> > +    DEFINE_PROP_BOOL("x-enable-migration", VFIOPCIDevice,
> > +                     vbasedev.enable_migration, false),
> >      DEFINE_PROP_BOOL("x-no-mmap", VFIOPCIDevice, vbasedev.no_mmap, fal=
se),
> >      DEFINE_PROP_BOOL("x-balloon-allowed", VFIOPCIDevice,
> >                       vbasedev.ram_block_discard_allowed, false),
> > diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-commo=
n.h
> > index baeb4dcff102..2119872c8af1 100644
> > --- a/include/hw/vfio/vfio-common.h
> > +++ b/include/hw/vfio/vfio-common.h
> > @@ -123,6 +123,7 @@ typedef struct VFIODevice {
> >      bool needs_reset;
> >      bool no_mmap;
> >      bool ram_block_discard_allowed;
> > +    bool enable_migration;
> >      VFIODeviceOps *ops;
> >      unsigned int num_irqs;
> >      unsigned int num_regions;
> >  =20


