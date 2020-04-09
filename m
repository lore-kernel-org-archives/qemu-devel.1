Return-Path: <SRS0=qpXq=5Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A407C2BA2B
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Apr 2020 14:56:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 41CBB206E9
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Apr 2020 14:56:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iCkXmMGJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41CBB206E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51134 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jMYbA-0007mf-F7
	for qemu-devel@archiver.kernel.org; Thu, 09 Apr 2020 10:56:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43703)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1jMYaU-0007B3-FX
 for qemu-devel@nongnu.org; Thu, 09 Apr 2020 10:55:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1jMYaT-0002wN-C9
 for qemu-devel@nongnu.org; Thu, 09 Apr 2020 10:55:26 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:51286
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1jMYaT-0002vz-8y
 for qemu-devel@nongnu.org; Thu, 09 Apr 2020 10:55:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1586444124;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7w9AMJuOospUEouwGl8pZ9jOrQnoUO3wMgXnbfTfLL4=;
 b=iCkXmMGJralLsNjdTDtV3321ntwqfiv4pJ8Oyn1DNY4vwt/qrqqLYgpWsyjtciCYOQrdoC
 gTohd+BnU+IRcDte1EKHOMJYPI35So8jLVhYQkF/JSRvMy/HU/sFdeAL2AnvEHnjip55P4
 yE6qmutecd+x0L4pX/iRCpIH3kXKGWw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-81-drVDNWlCNCC8VQoNAl_3uA-1; Thu, 09 Apr 2020 10:55:19 -0400
X-MC-Unique: drVDNWlCNCC8VQoNAl_3uA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B1363800D53;
 Thu,  9 Apr 2020 14:55:18 +0000 (UTC)
Received: from localhost (ovpn-114-141.ams2.redhat.com [10.36.114.141])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 450801195B1;
 Thu,  9 Apr 2020 14:55:13 +0000 (UTC)
Date: Thu, 9 Apr 2020 15:55:12 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Subject: Re: [PATCH for-5.0] aio-posix: signal-proof fdmon-io_uring
Message-ID: <20200409145512.GB317045@stefanha-x1.localdomain>
References: <20200408091139.273851-1-stefanha@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200408091139.273851-1-stefanha@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="f2QGlHpHGjS2mn6Y"
Content-Disposition: inline
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
Cc: Fam Zheng <fam@euphon.net>, Paolo Bonzini <pbonzini@redhat.com>,
 Julia Suvorova <jusual@redhat.com>, qemu-block@nongnu.org, sgarzare@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--f2QGlHpHGjS2mn6Y
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 08, 2020 at 10:11:39AM +0100, Stefan Hajnoczi wrote:
> The io_uring_enter(2) syscall returns with errno=3DEINTR when interrupted
> by a signal.  Retry the syscall in this case.
>=20
> It's essential to do this in the io_uring_submit_and_wait() case.  My
> interpretation of the Linux v5.5 io_uring_enter(2) code is that it
> shouldn't affect the io_uring_submit() case, but there is no guarantee
> this will always be the case.  Let's check for -EINTR around both APIs.
>=20
> Note that the liburing APIs have -errno return values.
>=20
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  util/fdmon-io_uring.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)

Thanks, applied to my block tree:
https://github.com/stefanha/qemu/commits/block

Stefan

--f2QGlHpHGjS2mn6Y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl6PN1AACgkQnKSrs4Gr
c8idUggAoS6H2m1IviOF6BPvwfJ9SN6Ah7/ai8zun5w+yZbAMyTTTQw1s1GkMkLp
Eti5lItyB9LISmgfoIEnKdwsXiJ7e1H2DyMo7ywN0dIMdcp44i18LwYPPf/YBDLQ
f9eCmT0hJNTRbfKtx5sQucDUbYuMdh0hwgYdUXVyraKxWrbMshTi0QXzLDKWf0oL
Y55sRIEQSW9d/MYE83x2HEj1eGg2L9eCDKq3vjryIr8vH3NzlEc2fgGgVdOnRKQq
d3LsM4sH3+uWLNZJ3JymqZlNEV6NIq2/a3J01/zO+KgQNm0dZtAlH90iaJZG89QU
AlpIgH/BGOOd1GTQ5OgKJOmk5sxd8g==
=ImnL
-----END PGP SIGNATURE-----

--f2QGlHpHGjS2mn6Y--


