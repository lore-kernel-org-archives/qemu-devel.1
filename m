Return-Path: <SRS0=hbhd=3T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 326B8C2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 14:40:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B14CA20658
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 14:40:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OBbBh7Q2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B14CA20658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33542 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ixAzK-0000VN-Pr
	for qemu-devel@archiver.kernel.org; Thu, 30 Jan 2020 09:40:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38595)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1ixAyf-0008Eu-6K
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 09:39:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1ixAyd-00014y-8t
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 09:39:28 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:57738
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1ixAyd-00010v-4b
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 09:39:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580395164;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2fBMCPJ20LJL6hIeRe4arYABcpKlDxNlRGfldpskCfQ=;
 b=OBbBh7Q280bFv8jJMZzkKSvr7qciXHVDi/aHv32Q5uBnuXG+0OPvxX3nFWlWDzR6sOj4eV
 4Vnk0VNDywdPBOhWyxxqKqndEVI6nqiw6Ue9HufxhM695IBHnJ9LDzzG38OcyDD4INC/Hm
 KRp8TTgRLdcA1VPkvX1mxhKjnr5QPEA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-157-V_w6J6JoOv6zhH3P-OrqPw-1; Thu, 30 Jan 2020 09:39:05 -0500
X-MC-Unique: V_w6J6JoOv6zhH3P-OrqPw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C8E02100550E;
 Thu, 30 Jan 2020 14:39:04 +0000 (UTC)
Received: from localhost (unknown [10.36.118.87])
 by smtp.corp.redhat.com (Postfix) with ESMTP id ABAA37FB5B;
 Thu, 30 Jan 2020 14:39:01 +0000 (UTC)
Date: Thu, 30 Jan 2020 14:39:00 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
To: "Bulekov, Alexander" <alxndr@bu.edu>
Subject: Re: [PATCH v8 01/21] softmmu: split off vl.c:main() into main.c
Message-ID: <20200130143900.GB180311@stefanha-x1.localdomain>
References: <20200129053357.27454-1-alxndr@bu.edu>
 <20200129053357.27454-2-alxndr@bu.edu>
MIME-Version: 1.0
In-Reply-To: <20200129053357.27454-2-alxndr@bu.edu>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="A6N2fC+uXW/VQSAv"
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "bsd@redhat.com" <bsd@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--A6N2fC+uXW/VQSAv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 29, 2020 at 05:34:11AM +0000, Bulekov, Alexander wrote:
> A program might rely on functions implemented in vl.c, but implement its
> own main(). By placing main into a separate source file, there are no
> complaints about duplicate main()s when linking against vl.o. For
> example, the virtual-device fuzzer uses a main() provided by libfuzzer,
> and needs to perform some initialization before running the softmmu
> initialization. Now, main simply calls three vl.c functions which
> handle the guest initialization, main loop and cleanup.
>=20
> Signed-off-by: Alexander Bulekov <alxndr@bu.edu>
> ---
>  Makefile                |  1 +
>  Makefile.objs           |  2 ++
>  Makefile.target         |  2 +-
>  include/sysemu/sysemu.h |  4 ++++
>  main.c                  | 53 +++++++++++++++++++++++++++++++++++++++++
>  vl.c                    | 36 +++++++---------------------
>  6 files changed, 70 insertions(+), 28 deletions(-)
>  create mode 100644 main.c

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--A6N2fC+uXW/VQSAv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl4y6oQACgkQnKSrs4Gr
c8hhWwf+NMz8A+NZUxVV3T44Wzyd/KTQobyKpAUvF+AMy7IMwwvBCKwi0PmEcv0O
Pu2l9QAYnm0qxV2NgFlZ53sqJ2ZiylYmKwTkFEXUwUJ1+aUJHwa8A7YPDmAdUbxR
uEKk+PZmF/EXQM3GAgLHfGdF1RX0vprOPYZKEyEUTs6ARtIfD/xkpNgbLtkJUbM8
NM6TczwSC/P94IVHcEU+DHcWnV7d9VSDYxp3zdNXJbrHQDeXsJavU1GWu1/hX1MW
eyxB6oP19JwLFqU4ECQyUz+R/EY/tJJxa2xgJ+HF68yUv2z+l+dLUQh2Z/HmkD5U
l0MICbOk9TPhI2ONQD9mB6SYbBA6WA==
=emt7
-----END PGP SIGNATURE-----

--A6N2fC+uXW/VQSAv--


