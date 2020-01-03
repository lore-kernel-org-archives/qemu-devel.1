Return-Path: <SRS0=dCqM=2Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BDDAC2D0C2
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jan 2020 11:28:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 466B021835
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jan 2020 11:28:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z8dzx/x6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 466B021835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51120 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1inL7r-0004rq-AP
	for qemu-devel@archiver.kernel.org; Fri, 03 Jan 2020 06:28:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39827)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1inL7C-0004Rd-0Z
 for qemu-devel@nongnu.org; Fri, 03 Jan 2020 06:27:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1inL7A-0002rl-Qr
 for qemu-devel@nongnu.org; Fri, 03 Jan 2020 06:27:37 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:21766
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1inL7A-0002nh-I1
 for qemu-devel@nongnu.org; Fri, 03 Jan 2020 06:27:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578050855;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=YisDe0ZNVXNWAZNsOqXFsNz9ZtnkqVCeYL+S4EPOWFM=;
 b=Z8dzx/x6xIlE9mpn0slgowGeR57jrRIRI5vivS9Atak7hdtqhQc/d7rk0PPiwWKyK9rYq0
 CTGf9V/c7njQRQtBu4jamYAPq/nR0IRLt8Z9x3w30ZtKK9oLRYbBUKLdEx5wtF4LnxAqWZ
 RUcoqxbZ5ttakHfu3cgwilz/bSoOVfI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-194-LJT328QgNliTDl61mfcTlA-1; Fri, 03 Jan 2020 06:27:32 -0500
X-MC-Unique: LJT328QgNliTDl61mfcTlA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B7853107ACC4;
 Fri,  3 Jan 2020 11:27:31 +0000 (UTC)
Received: from localhost (ovpn-116-102.ams2.redhat.com [10.36.116.102])
 by smtp.corp.redhat.com (Postfix) with ESMTP id AFA631001281;
 Fri,  3 Jan 2020 11:27:28 +0000 (UTC)
Date: Fri, 3 Jan 2020 11:27:26 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
To: "Oleinik, Alexander" <alxndr@bu.edu>
Subject: Re: [PATCH v6 16/21] fuzz: add support for fork-based fuzzing.
Message-ID: <20200103112726.GL130240@stefanha-x1.localdomain>
References: <20191129213424.6290-1-alxndr@bu.edu>
 <20191129213424.6290-17-alxndr@bu.edu>
MIME-Version: 1.0
In-Reply-To: <20191129213424.6290-17-alxndr@bu.edu>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="TdMwOTenGjBWB1uY"
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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
Cc: "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "bsd@redhat.com" <bsd@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--TdMwOTenGjBWB1uY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 29, 2019 at 09:34:50PM +0000, Oleinik, Alexander wrote:
> fork() is a simple way to ensure that state does not leak in between
> fuzzing runs. Unfortunately, the fuzzer mutation engine relies on
> bitmaps which contain coverage information for each fuzzing run, and
> these bitmaps should be copied from the child to the parent(where the
> mutation occurs). These bitmaps are created through compile-time
> instrumentation and they are not shared with fork()-ed processes, by
> default. To address this, we create a shared memory region, adjust its
> size and map it _over_ the counter region. Furthermore, libfuzzer
> doesn't generally expose the globals that specify the location of the
> counters/coverage bitmap. As a workaround, we rely on a custom linker
> script which forces all of the bitmaps we care about to be placed in a
> contiguous region, which is easy to locate and mmap over.
>=20
> Signed-off-by: Alexander Bulekov <alxndr@bu.edu>
> ---
>  exec.c                      | 12 ++++++--
>  tests/fuzz/Makefile.include |  3 ++
>  tests/fuzz/fork_fuzz.c      | 55 +++++++++++++++++++++++++++++++++++++
>  tests/fuzz/fork_fuzz.h      | 23 ++++++++++++++++
>  tests/fuzz/fork_fuzz.ld     | 37 +++++++++++++++++++++++++
>  tests/fuzz/fuzz.c           |  2 +-
>  6 files changed, 129 insertions(+), 3 deletions(-)
>  create mode 100644 tests/fuzz/fork_fuzz.c
>  create mode 100644 tests/fuzz/fork_fuzz.h
>  create mode 100644 tests/fuzz/fork_fuzz.ld

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--TdMwOTenGjBWB1uY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl4PJR4ACgkQnKSrs4Gr
c8hCXAf/dWzvnhV1CNlBx/8O1zl0AbX/Mbmkvmrsb+NEpmqQt6oatUoq5ow7G0hW
6M8EM/XveM0GAPD2vmRGiQUw4ETY45yqdfMm8F55S8we6JarF4EhZoJB+Mp47EiH
Im+aHFFeNqDvsgdxoLQA/HgkcIcTx/JVP/Hc6ouJEagTn3zHAKCN7xc/A7eVcrSx
81tTeprULJCIPKp2BT2nnmeq2kXz3ZsAkHOpuGDOCvddQetv+EGn3kSsx91X+aru
D52L7vEWNhM2HrozceRZfvfbtzBTmcTe+XeNUlb0m7C5wPq8M5LVnps4+1RIL97o
u4q1NrCnwhxTxLY+7oKM2VEKGx30EQ==
=vQ2Y
-----END PGP SIGNATURE-----

--TdMwOTenGjBWB1uY--


