Return-Path: <SRS0=7f1Q=CT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C48DC43461
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 10:51:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ECCC820872
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 10:51:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F1KUp4BS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECCC820872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59488 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGKBE-0008Fs-L8
	for qemu-devel@archiver.kernel.org; Thu, 10 Sep 2020 06:51:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54860)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kGK9n-0006ZK-BG
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 06:50:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:55731)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kGK9l-0005Ne-JN
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 06:50:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599735020;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kaHPOF8EaQEd/XQSpzKPrV8mrw+elOeuSRhrSvxuXJc=;
 b=F1KUp4BSxmVovzt4aIiOqe1YKdNPUWzcr5pjBzosphh4FtQ2KaP/kEFaRiQ8mxyRpHh/Nl
 4k8h2zuao8kHtbSEtWX/eWCIxDqwULIEQqQ20OvJW/kcQtQsQTbjdoq+C1/+FjD6QvIqzg
 tB/PHESRE5IBi8KyzdQEAMgkhy0NRdM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-210-QnlQJ4ujOcK1VhKfjDxitw-1; Thu, 10 Sep 2020 06:50:16 -0400
X-MC-Unique: QnlQJ4ujOcK1VhKfjDxitw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 313AE801AEE;
 Thu, 10 Sep 2020 10:50:15 +0000 (UTC)
Received: from localhost (ovpn-114-5.ams2.redhat.com [10.36.114.5])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9CA8519C66;
 Thu, 10 Sep 2020 10:50:11 +0000 (UTC)
Date: Thu, 10 Sep 2020 11:50:10 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Subject: Re: [PATCH v6 1/4] util/vfio-helpers: Improve reporting unsupported
 IOMMU type
Message-ID: <20200910105010.GB45048@stefanha-x1.localdomain>
References: <20200909142354.334859-1-philmd@redhat.com>
 <20200909142354.334859-2-philmd@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200909142354.334859-2-philmd@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0.0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="7iMSBzlTiPOCCT2k"
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/10 02:38:59
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--7iMSBzlTiPOCCT2k
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 09, 2020 at 04:23:51PM +0200, Philippe Mathieu-Daud=E9 wrote:
> Change the confuse "VFIO IOMMU check failed" error message by
> the explicit "VFIO IOMMU Type1 is not supported" once.
>=20
> Example on POWER:
>=20
>  $ qemu-system-ppc64 -drive if=3Dnone,id=3Dnvme0,file=3Dnvme://0001:01:00=
.0/1,format=3Draw
>  qemu-system-ppc64: -drive if=3Dnone,id=3Dnvme0,file=3Dnvme://0001:01:00.=
0/1,format=3Draw: VFIO IOMMU Type1 is not supported
>=20
> Suggested-by: Alex Williamson <alex.williamson@redhat.com>
> Reviewed-by: Fam Zheng <fam@euphon.net>
> Signed-off-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>
> ---
>  util/vfio-helpers.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--7iMSBzlTiPOCCT2k
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl9aBOIACgkQnKSrs4Gr
c8htlgf6AggFgB5axcvzYWReX4s+/ipGtkY/TWzzMkMQPDAG6H5zekOAGLIRA2yI
zeCBs2HNnetcCXAp/PfNtrjQ91zVFgD9HGEyURn/W3MvYf7M7FD5wwMXP+lCgWrq
b0X61rAPcWn8x1I0X14/tZXT8BbrtNeRNrORonnUxJ7QHjcjmRQxymu9BfkGo6Al
VfkZTGMrooEkE+IWqQLYtOtaMvKcTPYgoQmC5fSpRu/Al+ktJt49CUaYHjGw3P+H
fgS8+zyAXCxxoM77NxCTlfv1z31AhIdLqxf/I5ZZ2D6E571eOdm3AbDi2DQqGCKi
enbZIh/GIAmdGEIK1rwdEa1vIPFGpw==
=KzT6
-----END PGP SIGNATURE-----

--7iMSBzlTiPOCCT2k--


