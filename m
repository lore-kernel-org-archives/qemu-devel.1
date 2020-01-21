Return-Path: <SRS0=2jXw=3K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 422CBC2D0CE
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 16:30:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0AE8B206A2
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 16:30:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="evXAF1sI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0AE8B206A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57740 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1itwPt-0007SS-0A
	for qemu-devel@archiver.kernel.org; Tue, 21 Jan 2020 11:30:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37208)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1itwP9-0006zY-86
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 11:29:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1itwP8-0003uQ-Bd
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 11:29:27 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:33898
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1itwP8-0003uE-7I
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 11:29:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579624165;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=r9o52lM8R3rbgH89aHwnoVUf52Sbu854YyBQ4rr4Y34=;
 b=evXAF1sIsLMidSJjWdwExP6x93yPNrkbbldkmLxC3t89WGWjQqr6+QKAzC6XJ+aCejDS+G
 1oq42raVLnix2JRF5czLFuGWIfBIrWhnI3nQd/vb5MDvpyEJwXlgWTCRxIxUHM5YsL347C
 I34FZhipzY5GFi+Kf0vXi25767cHHfA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-2-pPI7GaRCO4yuyhzKYjmBlw-1; Tue, 21 Jan 2020 11:29:21 -0500
X-MC-Unique: pPI7GaRCO4yuyhzKYjmBlw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9E5781007290;
 Tue, 21 Jan 2020 16:29:20 +0000 (UTC)
Received: from localhost (ovpn-117-223.ams2.redhat.com [10.36.117.223])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 84B1D3AF;
 Tue, 21 Jan 2020 16:29:17 +0000 (UTC)
Date: Tue, 21 Jan 2020 16:29:16 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
To: "Bulekov, Alexander" <alxndr@bu.edu>
Subject: Re: [PATCH v7 12/20] exec: keep ram block across fork when using qtest
Message-ID: <20200121162916.GG641751@stefanha-x1.localdomain>
References: <20200120055410.22322-1-alxndr@bu.edu>
 <20200120055410.22322-18-alxndr@bu.edu>
MIME-Version: 1.0
In-Reply-To: <20200120055410.22322-18-alxndr@bu.edu>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="YH9Qf6Fh2G5kB/85"
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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

--YH9Qf6Fh2G5kB/85
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 20, 2020 at 05:54:59AM +0000, Bulekov, Alexander wrote:
> Ram blocks were marked MADV_DONTFORK breaking fuzzing-tests which
> execute each test-input in a forked process.
>=20
> Signed-off-by: Alexander Bulekov <alxndr@bu.edu>
> ---
>  exec.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--YH9Qf6Fh2G5kB/85
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl4nJtwACgkQnKSrs4Gr
c8h6XAf+OJC3nPQ/T/0cbVbIYHdk6+qzIjwZPwo81KYw/4M8qDYcNXB4yu9Y2Dkj
v8htOFXkSImBqF0mP3ELy8zK4wh9lkjYI2vtwK3SnqMxyde2XSuWr+3BQtrNmanf
xahPWlyNgJiBuN8RLP6zOBkxrWchvTkioccdYBHeTcagw5oqMtweOGs7+oTF/tf0
eDNbxTzzxDpZgrP+VYP5DqTyeu5kt4WWsmHlpNUc5jpSxCZSf2j5FcxUZdREE5OQ
K1pBRKatrQ50Pj1BjpbSyvK8FQt/mNCDvZC7a+MNeX00akQCeGFdwQd5E0lK20v+
HavEzgTd41pZDd1Jyu/ht1n2p2g7Qg==
=fibY
-----END PGP SIGNATURE-----

--YH9Qf6Fh2G5kB/85--


