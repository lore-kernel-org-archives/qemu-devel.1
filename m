Return-Path: <SRS0=hUBF=7W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89816C433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 17:53:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5AFED2074B
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 17:53:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UZhn+awB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5AFED2074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51058 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jiiQq-0006hO-F6
	for qemu-devel@archiver.kernel.org; Tue, 09 Jun 2020 13:53:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54998)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1jii83-00073b-TK
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 13:33:39 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:37080
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1jii82-0004DS-TB
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 13:33:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591724017;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ozlwcaevOxkBiPqU5CsLaPTK4wFZAqmdrORbRpmkUQI=;
 b=UZhn+awB9BROaeFTQ8ilEGRp0mlUN/tOIdClR4ipYDHLEfzKnSZ3y0XP2540/4EgK8THVE
 +Bu9dWDxvscSLtptJYmZ8T+CxZb6IHXN0iV0Gr+CxVOHeoN6CjQ4p3L3IPfy85tl6/Qs11
 9r/HYR+lP3vxyaMg3AFPuGd+I2d3r7g=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-99-V-lYuownNtObSlc0xgP9sA-1; Tue, 09 Jun 2020 13:33:34 -0400
X-MC-Unique: V-lYuownNtObSlc0xgP9sA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5326A1007278;
 Tue,  9 Jun 2020 17:33:33 +0000 (UTC)
Received: from w520.home (ovpn-112-195.phx2.redhat.com [10.3.112.195])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2FCA660C87;
 Tue,  9 Jun 2020 17:33:27 +0000 (UTC)
Date: Tue, 9 Jun 2020 11:33:26 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Laurent Vivier <laurent@vivier.eu>
Subject: Re: [PATCH v2] hw/vfio/common: Trace in which mode an IOMMU is opened
Message-ID: <20200609113326.100e74fe@w520.home>
In-Reply-To: <b687dd06-490d-dde9-53cc-aa05f38f769e@vivier.eu>
References: <20200527155555.6833-1-philmd@redhat.com>
 <b687dd06-490d-dde9-53cc-aa05f38f769e@vivier.eu>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.120;
 envelope-from=alex.williamson@redhat.com; helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/09 01:38:49
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: qemu-trivial@nongnu.org, Cornelia Huck <cohuck@redhat.com>,
 qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>,
 Eric Auger <eric.auger@redhat.com>,
 Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 9 Jun 2020 19:23:32 +0200
Laurent Vivier <laurent@vivier.eu> wrote:

> Le 27/05/2020 =C3=A0 17:55, Philippe Mathieu-Daud=C3=A9 a =C3=A9crit=C2=
=A0:
> > One might want to check which IOMMU version the host kernel
> > provide. Add a trace event to see in which mode we opened
> > our container.
> >=20
> > Reviewed-by: Cornelia Huck <cohuck@redhat.com>
> > Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> > ---
> > v2: Only display string description (Eric)
> >=20
> > Supersedes: <20200526173542.28710-1-philmd@redhat.com>
> > ---
> >  hw/vfio/common.c     | 19 ++++++++++++++-----
> >  hw/vfio/trace-events |  1 +
> >  2 files changed, 15 insertions(+), 5 deletions(-)
> >=20
> > diff --git a/hw/vfio/common.c b/hw/vfio/common.c
> > index 0b3593b3c0..f24450472e 100644
> > --- a/hw/vfio/common.c
> > +++ b/hw/vfio/common.c
> > @@ -1157,15 +1157,24 @@ static void vfio_put_address_space(VFIOAddressS=
pace *space)
> >  static int vfio_get_iommu_type(VFIOContainer *container,
> >                                 Error **errp)
> >  {
> > -    int iommu_types[] =3D { VFIO_TYPE1v2_IOMMU, VFIO_TYPE1_IOMMU,
> > -                          VFIO_SPAPR_TCE_v2_IOMMU, VFIO_SPAPR_TCE_IOMM=
U };
> > +    static const struct {
> > +        int type;
> > +        const char *name;
> > +    } iommu[] =3D {
> > +        {VFIO_TYPE1v2_IOMMU, "Type1 (v2)"},
> > +        {VFIO_TYPE1_IOMMU, "Type1 (v1)"},
> > +        {VFIO_SPAPR_TCE_v2_IOMMU, "sPAPR TCE (v2)"},
> > +        {VFIO_SPAPR_TCE_IOMMU, "sPAPR TCE (v1)"}
> > +    };
> >      int i;
> > =20
> > -    for (i =3D 0; i < ARRAY_SIZE(iommu_types); i++) {
> > -        if (ioctl(container->fd, VFIO_CHECK_EXTENSION, iommu_types[i])=
) {
> > -            return iommu_types[i];
> > +    for (i =3D 0; i < ARRAY_SIZE(iommu); i++) {
> > +        if (ioctl(container->fd, VFIO_CHECK_EXTENSION, iommu[i].type))=
 {
> > +            trace_vfio_get_iommu_type(iommu[i].name);
> > +            return iommu[i].type;
> >          }
> >      }
> > +    trace_vfio_get_iommu_type("Not available or not supported");
> >      error_setg(errp, "No available IOMMU models");
> >      return -EINVAL;
> >  }
> > diff --git a/hw/vfio/trace-events b/hw/vfio/trace-events
> > index b1ef55a33f..d3f1e48618 100644
> > --- a/hw/vfio/trace-events
> > +++ b/hw/vfio/trace-events
> > @@ -115,6 +115,7 @@ vfio_region_sparse_mmap_header(const char *name, in=
t index, int nr_areas) "Devic
> >  vfio_region_sparse_mmap_entry(int i, unsigned long start, unsigned lon=
g end) "sparse entry %d [0x%lx - 0x%lx]"
> >  vfio_get_dev_region(const char *name, int index, uint32_t type, uint32=
_t subtype) "%s index %d, %08x/%0x8"
> >  vfio_dma_unmap_overflow_workaround(void) ""
> > +vfio_get_iommu_type(const char *type) "IOMMU type: %s"
> > =20
> >  # platform.c
> >  vfio_platform_base_device_init(char *name, int groupid) "%s belongs to=
 group #%d"
> >  =20
>=20
> Applied to my trivial-patches branch.

I was not actually a fan of this patch:

https://lists.gnu.org/archive/html/qemu-devel/2020-05/msg08144.html

I don't think the convenience to the trace user to avoid looking up the
type string in the header is worth the bloat to the non-trace user to
declare these strings in the code.  Thanks,

Alex


