Return-Path: <SRS0=sZ46=CY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74CE0C43461
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 10:11:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 07B6621D24
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 10:11:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FDnQ2YWQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07B6621D24
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54314 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kI7wF-0007Pw-5O
	for qemu-devel@archiver.kernel.org; Tue, 15 Sep 2020 06:11:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44986)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1kI7uz-0006lz-E3
 for qemu-devel@nongnu.org; Tue, 15 Sep 2020 06:10:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:31991)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1kI7us-0008OX-UZ
 for qemu-devel@nongnu.org; Tue, 15 Sep 2020 06:10:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600164625;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WtrAHA50eWoIhE7jJ5AdGa3m2fvFNMhD0wQGYELrCPo=;
 b=FDnQ2YWQrv/ndLImcOSzyO/RAyFpttW3Qf1jaIadU2NMR/jsB9WvHvFn3fxJcl1djq+H+T
 nqUk2YXSuQ7QQUkTC4mxkv/Bvjn9JeQSPTnu+QAOjdq4q6wnECiz9sJ7RVkRbwNiwa4LB0
 owJbiWKOqlQsgQ0rdX8hHDsRedTj+1s=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-143-tSQPFBaLPu-rnNn3aFWnnQ-1; Tue, 15 Sep 2020 06:10:24 -0400
X-MC-Unique: tSQPFBaLPu-rnNn3aFWnnQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8DB28191E2AB;
 Tue, 15 Sep 2020 10:10:21 +0000 (UTC)
Received: from gondolin (ovpn-113-4.ams2.redhat.com [10.36.113.4])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5F9FE81C6B;
 Tue, 15 Sep 2020 10:10:13 +0000 (UTC)
Date: Tue, 15 Sep 2020 12:10:10 +0200
From: Cornelia Huck <cohuck@redhat.com>
To: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>
Subject: Re: [PATCH v2 1/3] vfio: Find DMA available capability
Message-ID: <20200915121010.117fa931.cohuck@redhat.com>
In-Reply-To: <fbd1df4e-8d51-87c8-2b07-5b65666342d0@redhat.com>
References: <1600122570-12941-1-git-send-email-mjrosato@linux.ibm.com>
 <1600122570-12941-2-git-send-email-mjrosato@linux.ibm.com>
 <fbd1df4e-8d51-87c8-2b07-5b65666342d0@redhat.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=cohuck@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=216.205.24.124; envelope-from=cohuck@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/15 02:10:32
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.792,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: thuth@redhat.com, Matthew Rosato <mjrosato@linux.ibm.com>,
 pmorel@linux.ibm.com, schnelle@linux.ibm.com, qemu-s390x@nongnu.org,
 david@redhat.com, qemu-devel@nongnu.org, pasic@linux.ibm.com,
 borntraeger@de.ibm.com, alex.williamson@redhat.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 15 Sep 2020 08:14:24 +0200
Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> wrote:

> Hi Matthew,
>=20
> On 9/15/20 12:29 AM, Matthew Rosato wrote:
> > The underlying host may be limiting the number of outstanding DMA
> > requests for type 1 IOMMU.  Add helper functions to check for the
> > DMA available capability and retrieve the current number of DMA
> > mappings allowed.
> >=20
> > Signed-off-by: Matthew Rosato <mjrosato@linux.ibm.com>
> > ---
> >  hw/vfio/common.c              | 37 +++++++++++++++++++++++++++++++++++=
++
> >  include/hw/vfio/vfio-common.h |  2 ++
> >  2 files changed, 39 insertions(+)

(...)

> > +bool vfio_get_info_dma_avail(struct vfio_iommu_type1_info *info,
> > +                             unsigned int *avail)
> > +{
> > +    struct vfio_info_cap_header *hdr;
> > +    struct vfio_iommu_type1_info_dma_avail *cap;
> > +
> > +    /* If the capability cannot be found, assume no DMA limiting */
> > +    hdr =3D vfio_get_iommu_type1_info_cap(info,
> > +                                        VFIO_IOMMU_TYPE1_INFO_DMA_AVAI=
L);
> > +    if (hdr =3D=3D NULL || avail =3D=3D NULL) { =20
>=20
> If you expect the caller to use avail=3DNULL, then why
> return false when there is available information?

I agree; if the purpose of this function is to check if limiting is in
place and only optionally return the actual limit, we should return
true for hdr !=3D NULL and avail =3D=3D NULL.

>=20
> > +        return false;
> > +    }
> > +
> > +    cap =3D (void *) hdr;
> > +    *avail =3D cap->avail;
> > +    return true;
> > +}
> > +
> >  static int vfio_setup_region_sparse_mmaps(VFIORegion *region,
> >                                            struct vfio_region_info *inf=
o)
> >  {

(...)


