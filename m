Return-Path: <SRS0=9x1+=D5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE518C388F2
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2020 13:54:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B803D22249
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2020 13:54:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OLSAhGrq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B803D22249
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55080 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVb3L-0003JF-Gq
	for qemu-devel@archiver.kernel.org; Thu, 22 Oct 2020 09:54:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40442)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kVb1u-0001N5-Hv
 for qemu-devel@nongnu.org; Thu, 22 Oct 2020 09:53:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:29777)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kVb1s-0007Iz-Bs
 for qemu-devel@nongnu.org; Thu, 22 Oct 2020 09:53:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603374799;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dnJLpZiA5bYnmKJQENBfTAplw7okbITT3dI5N48I76Q=;
 b=OLSAhGrqTD70fvt67HcRexVXIwo4oGxLHJmynIB+BWlFTLL2PV7HenzxD/JAU9KXJAY6H6
 YOakQyocNNfDRwj4OJFzau+xI0YZzpTriWM4m6P7syQgR4Q8jzlp/nDIoZMpFW+HPH+XFq
 QUviAB32GxAcEKW9kUoDlNci+GboiNs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-595-RTkLpyFpPRuZc-LhJLuO4Q-1; Thu, 22 Oct 2020 09:53:17 -0400
X-MC-Unique: RTkLpyFpPRuZc-LhJLuO4Q-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4056F804B64;
 Thu, 22 Oct 2020 13:53:16 +0000 (UTC)
Received: from localhost (ovpn-114-229.ams2.redhat.com [10.36.114.229])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B215E55781;
 Thu, 22 Oct 2020 13:53:12 +0000 (UTC)
Date: Thu, 22 Oct 2020 14:53:11 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Subject: Re: [PATCH 02/16] util/vfio-helpers: Improve reporting unsupported
 IOMMU type
Message-ID: <20201022135311.GC761187@stefanha-x1.localdomain>
References: <20201020172428.2220726-1-philmd@redhat.com>
 <20201020172428.2220726-3-philmd@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20201020172428.2220726-3-philmd@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="Y5rl02BVI9TCfPar"
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/22 08:33:10
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--Y5rl02BVI9TCfPar
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 20, 2020 at 07:24:14PM +0200, Philippe Mathieu-Daud=E9 wrote:
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

--Y5rl02BVI9TCfPar
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl+RjscACgkQnKSrs4Gr
c8icAgf7BGICuYx7L9VG1VF1SzZjg7WcAGG2QZrojwFWo8Z2UiTqeM/5lSOScT/r
upS0MoAx8eezGTuClHj46i78OeRItYPJrMkAEObEB/2ycfVzKtFBhXnUcDtynh5x
YptfWCx2aUIykY3tW8icAoQZiM+mKyxO59MYJ/VaQ3n2mcnO2cQ+ouIoNFRgayLE
O7ZW3S/Ch8Xk655MTmL9QLKH49hM88V7Dh80SQ/p7Sn8hTQyh/XJUE9EVCo7hA8f
1fjEKC9lstiDeqpAG1Xlm1qfGpQbwsWzIvUt6eUi9pwoHnK3RpXWiCrpWYu10TJa
kd6oQiO4L1NdGAv13Ga9ATOfSbgZiQ==
=RoXo
-----END PGP SIGNATURE-----

--Y5rl02BVI9TCfPar--


