Return-Path: <SRS0=ZyMj=EB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 628F9C55178
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 16:05:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D2F12242A
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 16:05:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q2d86EVv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D2F12242A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43046 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kX4zx-0005lO-0J
	for qemu-devel@archiver.kernel.org; Mon, 26 Oct 2020 12:05:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52524)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kX4sY-0006LY-KD
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 11:57:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:28618)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kX4sW-0005De-Lo
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 11:57:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603727867;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=IvhixfVta10aQOb7mSES7Wcye9C377QkS2jv12FA2+w=;
 b=Q2d86EVvDbsg4/Aq7Oo207XcvT3iJd5LYY+MH5+IlBmBczjfGiS0vrv/xQ2E3wqdJw4OvY
 wUGBtJI7mHeE6S5dbPKHZbv9cDV3xwmmFS3PLDwArezB5dtyvrawcHu+i/BteoFeTouTW8
 y1KJV1ytxco6CHZfPC2l65LDuHWZcKo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-156-fSzbyDw3O5mXyGluJz1bOQ-1; Mon, 26 Oct 2020 11:57:42 -0400
X-MC-Unique: fSzbyDw3O5mXyGluJz1bOQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9FB2881F027;
 Mon, 26 Oct 2020 15:57:40 +0000 (UTC)
Received: from localhost (ovpn-114-214.ams2.redhat.com [10.36.114.214])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B5D831002388;
 Mon, 26 Oct 2020 15:57:37 +0000 (UTC)
Date: Mon, 26 Oct 2020 15:57:36 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Klaus Jensen <its@irrelevant.dk>
Subject: Re: [PATCH v6 2/3] nvme: add namespace I/O optimization fields to
 shared header
Message-ID: <20201026155736.GI52035@stefanha-x1.localdomain>
References: <20201026060101.371900-1-its@irrelevant.dk>
 <20201026060101.371900-3-its@irrelevant.dk>
MIME-Version: 1.0
In-Reply-To: <20201026060101.371900-3-its@irrelevant.dk>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="+PbGPm1eXpwOoWkI"
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/25 21:03:19
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
 qemu-block@nongnu.org, Klaus Jensen <k.jensen@samsung.com>,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Keith Busch <kbusch@kernel.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--+PbGPm1eXpwOoWkI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 26, 2020 at 07:01:00AM +0100, Klaus Jensen wrote:
> From: Klaus Jensen <k.jensen@samsung.com>
>=20
> This adds the NPWG, NPWA, NPDG, NPDA and NOWS family of fields to the
> shared nvme.h header for use by later patches.
>=20
> Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
> Cc: Stefan Hajnoczi <stefanha@redhat.com>
> Cc: Fam Zheng <fam@euphon.net>
> ---
>  include/block/nvme.h | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--+PbGPm1eXpwOoWkI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl+W8fAACgkQnKSrs4Gr
c8iJtggAvML+lRLj87ZRfD0hqYpJQX55XWCcfcsR78v68jKt1TpGlwQIz7CVmxcx
yhHwH9Wrbu6PmCWBvEJyMtLA89xZ/OO2vPT/vIJ5o2LwqZRj9ATSE+Tj+hwY1PpQ
CxIJB8aawcCerl9OuSothVN9kE4ZcpS7VxhOUeKxs4o5tya52w115t32xLzLRrm5
K93bTGui0ymMQkt6CtpOZXNDgxUqT7C804lZ+RuNHx2egTzzwX7qLJYui0AYWvrK
QL0/4odrVbHrKBT/tP4mwnOU1N+nVh0IFcLUmuKnb757c3n59ZyNyU/Fm1RkVyWl
GFDyFa/RfdEI+gbmXzgAkl5sOowI6A==
=sy+Z
-----END PGP SIGNATURE-----

--+PbGPm1eXpwOoWkI--


