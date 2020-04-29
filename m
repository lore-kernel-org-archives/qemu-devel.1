Return-Path: <SRS0=Qmby=6N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F10BBC83003
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 09:23:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B8ED520731
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 09:23:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bFpcTf2B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8ED520731
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45514 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTiw4-0003Ow-Uw
	for qemu-devel@archiver.kernel.org; Wed, 29 Apr 2020 05:23:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33148)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1jTivO-0002YF-Mc
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 05:22:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1jTivN-0006zn-HB
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 05:22:38 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:52222
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jTivN-0006qI-0a
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 05:22:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588152154;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=k0buYRTYTi0d2vF01agownmWEJuC/4qGmXxXl9LWQmQ=;
 b=bFpcTf2B4lLofGl9naet4aTvWVfrsPAkAp0srqTKK1hRxnBoG01JMZBFOUAwIIXKSMbi4D
 iVheHOd6JlRTJ51k61cGAf6k+cGBwFhUAm7FvbO0KXZQumYGjc/Dkq8C3Y8NkU5h7jCP43
 smgNih49iRtmFhfZt0VCn7HPH9l/WUU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-399-7qvN90lMMx67HLrSrZa07g-1; Wed, 29 Apr 2020 05:22:31 -0400
X-MC-Unique: 7qvN90lMMx67HLrSrZa07g-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 431A6464
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2020 09:22:30 +0000 (UTC)
Received: from localhost (ovpn-114-2.ams2.redhat.com [10.36.114.2])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CCDA499D6;
 Wed, 29 Apr 2020 09:22:29 +0000 (UTC)
Date: Wed, 29 Apr 2020 10:22:28 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Subject: Re: [PULL 12/32] block/file-posix: Fix check_cache_dropped() error
 handling
Message-ID: <20200429092228.GC122432@stefanha-x1.localdomain>
References: <20200429072048.29963-1-armbru@redhat.com>
 <20200429072048.29963-13-armbru@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200429072048.29963-13-armbru@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="69pVuxX8awAiJ7fD"
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=stefanha@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/29 01:18:10
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--69pVuxX8awAiJ7fD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 29, 2020 at 09:20:28AM +0200, Markus Armbruster wrote:
> The Error ** argument must be NULL, &error_abort, &error_fatal, or a
> pointer to a variable containing NULL.  Passing an argument of the
> latter kind twice without clearing it in between is wrong: if the
> first call sets an error, it no longer points to NULL for the second
> call.
>=20
> check_cache_dropped() calls error_setg() in a loop.  It fails to break
> the loop in one instance.  If a subsequent iteration error_setg()s
> again, it trips error_setv()'s assertion.
>=20
> Fix it to break the loop.
>=20
> Fixes: 31be8a2a97ecba7d31a82932286489cac318e9e9
> Cc: Stefan Hajnoczi <stefanha@redhat.com>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> Reviewed-by: Eric Blake <eblake@redhat.com>
> Message-Id: <20200422130719.28225-3-armbru@redhat.com>
> ---
>  block/file-posix.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)

Thanks for fixing this bug!

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--69pVuxX8awAiJ7fD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl6pR1QACgkQnKSrs4Gr
c8hu3wgAqsYhHhT2HgdYJzMPmNfuO0Az4CqiI3nmCFHjMBagVbnaeNklHNqWIrsn
T8Zib/js6kT++DFPjq8/tYK0FlId3RBDeCUanI0zThOl7r90sxgTVzu3IZhvUwBK
Mrl1t6FPvRbL8fOjNM7y2SmKlllMt8FZy8DtmoZ7jNjgDvByd4bWapiD9j1aDfH6
h6zdGlUwdZNcNB9Y9zKUSj+b3FJXhELUy1cF69B0XHaPNOxCNLTgWNlLod9AxOSJ
F90qdhUZH3bGl+gUR9dojLGQt8fZB6vP/Hvi4owmcWBcShw7tEYTNoE/fJTy3a1k
jMRJAdp87ntFv+hyGQiKKvOG93OatA==
=5C6z
-----END PGP SIGNATURE-----

--69pVuxX8awAiJ7fD--


