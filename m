Return-Path: <SRS0=vd3Y=BW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74106C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2020 14:01:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3BD26207DA
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2020 14:01:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L9BBNWIl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BD26207DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49614 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k5rJO-0004A3-Ha
	for qemu-devel@archiver.kernel.org; Wed, 12 Aug 2020 10:01:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56834)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1k5rIg-0003b5-Tx
 for qemu-devel@nongnu.org; Wed, 12 Aug 2020 10:00:18 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:20404
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1k5rIe-0007du-E7
 for qemu-devel@nongnu.org; Wed, 12 Aug 2020 10:00:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597240815;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Lj048Fusy99BryiM3rsXzMbTqEvrtzTWuAc+OspqBB8=;
 b=L9BBNWIloGD3Dki59lQbYUtOtXIKztwaAWXcE1JYLfdb5R595HD1GYpbFt/E0AlOwG4b30
 +PHY31/HqT4AMSGcdtRMF/b9sY4Ig6MccgQD4elKwWktnje89J+m6vD1L0aa0MZfG+6VxR
 kXSlbp90YVLb4yHcVC+HgF/gEGdCSKw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-185-vefFpRkRNIqiQPCSJEmyzg-1; Wed, 12 Aug 2020 10:00:12 -0400
X-MC-Unique: vefFpRkRNIqiQPCSJEmyzg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5E52A1009443;
 Wed, 12 Aug 2020 14:00:11 +0000 (UTC)
Received: from localhost (ovpn-114-96.ams2.redhat.com [10.36.114.96])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 02C285D9D7;
 Wed, 12 Aug 2020 14:00:10 +0000 (UTC)
Date: Wed, 12 Aug 2020 15:00:09 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: "Denis V. Lunev" <den@openvz.org>
Subject: Re: [PATCH v2 for 5.2 0/3] block: add logging facility for long
 standing IO requests
Message-ID: <20200812140009.GB112330@stefanha-x1.localdomain>
References: <20200810101447.7380-1-den@openvz.org>
MIME-Version: 1.0
In-Reply-To: <20200810101447.7380-1-den@openvz.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="IiVenqGWf+H9Y6IX"
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=stefanha@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/12 06:16:38
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--IiVenqGWf+H9Y6IX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 10, 2020 at 01:14:44PM +0300, Denis V. Lunev wrote:
> There are severe delays with IO requests processing if QEMU is running in
> virtual machine or over software defined storage. Such delays potentially
> results in unpredictable guest behavior. For example, guests over IDE or
> SATA drive could remount filesystem read-only if write is performed
> longer than 10 seconds.
>=20
> Such reports are very complex to process. Some good starting point for th=
is
> seems quite reasonable. This patch provides one. It adds logging of such
> potentially dangerous long IO operations.
>=20
> Changed from v2:
> - removed accidentally added slirp subproject ID
> - added comment describing timeout selection to patch 3
>=20
> Changes from v1:
> - fixed conversions using macros suggested by Stefan
> - fixed option declaration
> - enabled by default with patch 3
>=20
> Signed-off-by: Denis V. Lunev <den@openvz.org>
> CC: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> CC: Kevin Wolf <kwolf@redhat.com>
> CC: Max Reitz <mreitz@redhat.com>
> CC: Stefan Hajnoczi <stefanha@redhat.com>

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--IiVenqGWf+H9Y6IX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl8z9ekACgkQnKSrs4Gr
c8hRzQf/WXTLzs14ArtBlYmIbCcQGlNymF2xzKZXFvTpdNx6NixfQReeoIMPAQrA
cv+7hgBheu2mCAIld6D/n5WfH+/dv34vOHtQJ9+UhzeCc5HHJRIflOFJf1wGeUil
XSSnP3U/Bn3w0cWC8GbK/KeWwT1FrqSjH2P9+QR62NT4YuYitRipo0L7JIIM7WkS
Uyt+AeHXRm9wLfZu6wKI2IIm1a35JijQ1luN3uPCVremURdpIQDY+pRA3TBylyCg
6eJDYSPmYT4qDGG4yG2UtpLh7S9RAPfosvcrChNAPjVRPhTZdzw+FOtHQMSvE7ee
1dRBwAaDkUhek1h1zpUX5B+XJu46gQ==
=eHN6
-----END PGP SIGNATURE-----

--IiVenqGWf+H9Y6IX--


