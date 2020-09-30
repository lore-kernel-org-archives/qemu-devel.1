Return-Path: <SRS0=HfOj=DH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 570A8C4727F
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 09:24:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C2B8D20754
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 09:24:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gkku1UfD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2B8D20754
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59766 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNYLO-000054-Ql
	for qemu-devel@archiver.kernel.org; Wed, 30 Sep 2020 05:24:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32834)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kNYKf-0007zU-1m
 for qemu-devel@nongnu.org; Wed, 30 Sep 2020 05:23:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:34368)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kNYKd-0002GN-Bx
 for qemu-devel@nongnu.org; Wed, 30 Sep 2020 05:23:28 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601457806;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=owz3HwVppTAtTe1AsZH8ihXWtgDRkufigx8d3LlmVbc=;
 b=gkku1UfDSbmZvtofTyKLdJ1V/wEmRad0lUI1+l7SxIPBp7HfvNr1KyBPiBmUh8oXe5+WFD
 2uHijfYxpx+pkjP6svpg1lLXKzKcrmGuoZQtTk/nWiUcjYF2N9kRpTRfrBxncR3tk1Pgh4
 Oag2zbZ79SJs0BWGSMc7dbeM4yZvFno=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-408-s6MHC3INMpmnFhasMx4MxA-1; Wed, 30 Sep 2020 05:23:20 -0400
X-MC-Unique: s6MHC3INMpmnFhasMx4MxA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A270164082;
 Wed, 30 Sep 2020 09:23:19 +0000 (UTC)
Received: from localhost (ovpn-114-33.ams2.redhat.com [10.36.114.33])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 245565D9D3;
 Wed, 30 Sep 2020 09:23:18 +0000 (UTC)
Date: Wed, 30 Sep 2020 10:23:17 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Eric Auger <eric.auger@redhat.com>
Subject: Re: [PATCH v2 0/2] NVMe passthrough: Take into account host IOVA
 reserved regions
Message-ID: <20200930092317.GD201070@stefanha-x1.localdomain>
References: <20200929085550.30926-1-eric.auger@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200929085550.30926-1-eric.auger@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="RYJh/3oyKhIjGcML"
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/30 00:31:59
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.687,
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
Cc: fam@euphon.net, lvivier@redhat.com, cohuck@redhat.com,
 qemu-devel@nongnu.org, mreitz@redhat.com, alex.williamson@redhat.com,
 qemu-arm@nongnu.org, kwolf@redhat.com, philmd@redhat.com,
 eric.auger.pro@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--RYJh/3oyKhIjGcML
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 29, 2020 at 10:55:48AM +0200, Eric Auger wrote:
> The current IOVA allocator allocates within the [0x10000, 1ULL << 39]
> window, without paying attention to the host IOVA reserved regions.
> This prevents NVMe passthtrough from working on ARM as the fixed
> IOVAs rapidly grow up to the MSI reserved region [0x8000000, 0x8100000]
> causing some VFIO MAP DMA failures. This series collects the usable
> IOVA regions using VFIO GET_INFO (this requires the host to support
> VFIO_IOMMU_TYPE1_INFO_CAP_IOVA_RANGE) and rework the fixed and
> temporary IOVA allocators to avoid those latter.
>=20
> For the time being we do not change the arbitrary min/max IOVAs.
> In theory they could be dynamically determined but the kernel
> currently fails to expose some HW limitations described in the ACPI
> tables (such as PCI root complex Device Memory Address Size Limit).
> See kernel thread related to "[RFC 0/3] iommu: Reserved regions for
> IOVAs beyond dma_mask and iommu aperture" for more details:
> https://lkml.org/lkml/2020/9/28/1102
>=20
> Best Regards
>=20
> Eric
>=20
> This series can be found at:
> https://github.com/eauger/qemu/tree/nvme_resv_v2
>=20
> This was tested on ARM only.
>=20
> History:
> v1 -> v2:
> - remove "util/vfio-helpers: Dynamically compute the min/max IOVA" to
>   relax the kernel dependency
> - Fix cabapbility enumeration loop
> - set s->usable_iova_ranges=3DNULL to avoid double free
> - handle possible u64 wrap
>=20
> Eric Auger (2):
>   util/vfio-helpers: Collect IOVA reserved regions
>   util/vfio-helpers: Rework the IOVA allocator to avoid IOVA reserved
>     regions
>=20
>  util/vfio-helpers.c | 129 +++++++++++++++++++++++++++++++++++++++++---
>  1 file changed, 123 insertions(+), 6 deletions(-)
>=20
> --=20
> 2.21.3
>=20

Thanks, applied to my block tree:
https://github.com/stefanha/qemu/commits/block

Stefan

--RYJh/3oyKhIjGcML
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl90ToUACgkQnKSrs4Gr
c8gAGwf/TJ37FKH9VTr7GZxX7+oYWcyUhmO3ECWC6G2/h8eTXHQ48T+oANfVbAuD
tAPIYm0QqgPn0XTHBzdzASZq2f5RGokDqmqoBtxhrirokv4/ennyZUivgSunJ08/
ERJPgdi9aM02/gWhYf/L9JNS/EJNfWOCgq2W7MAMU4Sq9zEAQ6CQHpi4cJAR6w/2
PyskYk8GMA5AlCP94g38oLEIKveXX7lEdFtuVo+A93OP7XsKJKiqgZmlLStZrBMu
mRCtyWVnxbTBzHGvchJj0T9xuo77n1zJs1FvyOCthvM8OLKyg6NYA8OhOGRMqD7x
NALPNsrZPKOC2qlLkLQ66nVTP9Q42w==
=P5el
-----END PGP SIGNATURE-----

--RYJh/3oyKhIjGcML--


