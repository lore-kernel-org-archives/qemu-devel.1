Return-Path: <SRS0=0rPh=D4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 364BBC388F9
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 15:09:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A9D0E20BED
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 15:09:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AGrEmnKZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9D0E20BED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41114 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVFkH-0000Zf-Lr
	for qemu-devel@archiver.kernel.org; Wed, 21 Oct 2020 11:09:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56656)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kVFTG-00019A-7S
 for qemu-devel@nongnu.org; Wed, 21 Oct 2020 10:52:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:41138)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kVFTD-0007Di-Qm
 for qemu-devel@nongnu.org; Wed, 21 Oct 2020 10:52:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603291925;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KJqgfzgMH2OdIBrTsR3fX2xulgE2o1i8/h/EYcWdKsA=;
 b=AGrEmnKZSImrEVOMEQ9tx8xEL9dBilRpRfxKOm9Dhfhh3JLEPkjMZgvuhHx2lfO5PToJVW
 ZuOEoXDBFu6SX8h4JXU6a3wZG6CWjMeB2syKBvbKBUJFUN1nWtBSUdunPbEGITpvQUOPJr
 u2wOFOlVQxQV5P25qcVw7Bxda/ANrbs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-26-3K9h8S7wN2iNRu6n3nWF1A-1; Wed, 21 Oct 2020 10:52:02 -0400
X-MC-Unique: 3K9h8S7wN2iNRu6n3nWF1A-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F40ED10866A3;
 Wed, 21 Oct 2020 14:52:00 +0000 (UTC)
Received: from localhost (ovpn-113-74.ams2.redhat.com [10.36.113.74])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 73EA16EF74;
 Wed, 21 Oct 2020 14:52:00 +0000 (UTC)
Date: Wed, 21 Oct 2020 15:51:59 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Volker =?iso-8859-1?Q?R=FCmelin?= <vr_qemu@t-online.de>
Subject: Re: [PATCH] qmp: fix aio_poll() assertion failure on Windows
Message-ID: <20201021145159.GA615462@stefanha-x1.localdomain>
References: <20201021064033.8600-1-vr_qemu@t-online.de>
MIME-Version: 1.0
In-Reply-To: <20201021064033.8600-1-vr_qemu@t-online.de>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="sdtB3X0nJg68CQEu"
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/20 22:12:28
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
 qemu-block@nongnu.org, Stefan Weil <sw@weilnetz.de>, qemu-devel@nongnu.org,
 Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--sdtB3X0nJg68CQEu
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 21, 2020 at 08:40:33AM +0200, Volker R=FCmelin wrote:
> Commit 9ce44e2ce2 "qmp: Move dispatcher to a coroutine" modified
> aio_poll() in util/aio-posix.c to avoid an assertion failure. This
> change is missing in util/aio-win32.c.
>=20
> Apply the changes to util/aio-posix.c to util/aio-win32.c too.
> This fixes an assertion failure on Windows whenever QEMU exits.
>=20
> $ ./qemu-system-x86_64.exe -machine pc,accel=3Dtcg -display gtk
> **
> ERROR:../qemu/util/aio-win32.c:337:aio_poll: assertion failed:
> (in_aio_context_home_thread(ctx))
> Bail out! ERROR:../qemu/util/aio-win32.c:337:aio_poll: assertion
> failed: (in_aio_context_home_thread(ctx))
>=20
> Fixes: 9ce44e2ce2 ("qmp: Move dispatcher to a coroutine")
> Signed-off-by: Volker R=FCmelin <vr_qemu@t-online.de>
> ---
>  util/aio-win32.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)

Thanks, applied to my block-next tree:
https://gitlab.com/stefanha/qemu/commits/block-next

Stefan

--sdtB3X0nJg68CQEu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl+QSw8ACgkQnKSrs4Gr
c8heiggAyOCuL8d4kPpRFm8BTehbnz70W/HX3qDgVhrqKkzVjt/u0Na13wRJZZjy
KrZbx6GNrhD6y/zqc3UeSWdnIx2DASElnRzwNXVFuak2CmTOAVsjE2QL9MDpk3di
14nns+IW2pEvShC78bJzGhwDzKOImkGZVvgjMbZQAR9h2vQMaN9iZQCBo8aas/tE
Tzfq5u4b6uz6Y4B1dZucy5QwtNwIqOf8xb/dnASHyrVANkx9xL+BGih4Osmc7W59
oVL5qeZWoCVi34QP6xDh/3V+6XBzomonuk/zLUuK6K3uBjgBasc2p+p2jaEssF3c
E7hMvqbLuew4NkLUuWRFNhzQ+MyNpw==
=zyx9
-----END PGP SIGNATURE-----

--sdtB3X0nJg68CQEu--


