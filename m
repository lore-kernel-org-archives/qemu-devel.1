Return-Path: <SRS0=dCqM=2Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66128C2D0C2
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jan 2020 11:11:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 32B122085B
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jan 2020 11:11:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PtStpZk2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32B122085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50952 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1inKrX-0004Fo-CI
	for qemu-devel@archiver.kernel.org; Fri, 03 Jan 2020 06:11:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49335)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1inKqo-0003ps-Ly
 for qemu-devel@nongnu.org; Fri, 03 Jan 2020 06:10:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1inKqn-0006AK-HZ
 for qemu-devel@nongnu.org; Fri, 03 Jan 2020 06:10:42 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:28929
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1inKqn-00067i-Bq
 for qemu-devel@nongnu.org; Fri, 03 Jan 2020 06:10:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578049840;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fZJEzQD7/Yg85JRyF40AlJxXnCnNqSe3PF9v7wJkHbY=;
 b=PtStpZk2pfriFeBPkZ/DNntja9NS9u7HvDfNIyt4ebXrxW3r0USBWNz1asXEOhtqqaPTL9
 /9xSZk0xrdVj4JQN4SjeqlfJ4iuTpdafKm7ft1pTrCmJNbegYzikyg3yckVqOabyp5P0uu
 p/ImuWYEw8BY6qijjTQJRmJUYG5rK4E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-45-b8rJg8kKMH6LkltdCv7VHg-1; Fri, 03 Jan 2020 06:10:39 -0500
X-MC-Unique: b8rJg8kKMH6LkltdCv7VHg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0292D18543A3;
 Fri,  3 Jan 2020 11:10:38 +0000 (UTC)
Received: from localhost (ovpn-116-102.ams2.redhat.com [10.36.116.102])
 by smtp.corp.redhat.com (Postfix) with ESMTP id EA6DC7A078;
 Fri,  3 Jan 2020 11:10:34 +0000 (UTC)
Date: Fri, 3 Jan 2020 11:10:32 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
To: "Oleinik, Alexander" <alxndr@bu.edu>
Subject: Re: [PATCH v6 11/21] libqtest: make bufwrite rely on the TransportOps
Message-ID: <20200103111032.GF130240@stefanha-x1.localdomain>
References: <20191129213424.6290-1-alxndr@bu.edu>
 <20191129213424.6290-12-alxndr@bu.edu>
MIME-Version: 1.0
In-Reply-To: <20191129213424.6290-12-alxndr@bu.edu>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="QNDPHrPUIc00TOLW"
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
Cc: Thomas Huth <thuth@redhat.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "bsd@redhat.com" <bsd@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Laurent Vivier <lvivier@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--QNDPHrPUIc00TOLW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 29, 2019 at 09:34:46PM +0000, Oleinik, Alexander wrote:
> When using qtest "in-process" communication, qtest_sendf directly calls
> a function in the server (qtest.c). Previously, bufwrite used
> socket_send, which bypasses the TransportOps enabling the call into
> qtest.c. This change replaces the socket_send calls with ops->send,
> maintaining the benefits of the direct socket_send call, while adding
> support for in-process qtest calls.
>=20
> Signed-off-by: Alexander Bulekov <alxndr@bu.edu>
> ---
>  tests/libqtest.c | 4 ++--
>  tests/libqtest.h | 3 +++
>  2 files changed, 5 insertions(+), 2 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--QNDPHrPUIc00TOLW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl4PISgACgkQnKSrs4Gr
c8iHHwgArxYDnpLDxAllHg5Ss5QObbIwR9UPfOfPifCQx0W6OsB0kjmu0Jhr5g/p
QNuZLdQgHi/cWaNGMNrKDckEp21aXdwZtBKFtHuWj0LLldQjAHq4xbBrqwtnfnGT
oeyb038voqGpsRXa/0rgFq8ajeLv1tuAxDJDTeuO1roysYA5tZO8V6xzBOTzrptN
LXRdeYXvaciwYRBtv0xS5/yNbtR/nU7f4GlOqcUegbZXH5NzBF2QWTQ8yK2h7qHv
66ia2JN65L9X0OhBO66H4kQhygzUEsH9Wq77lJhKGM82d34Bd8uS/rgVhlspPL0O
QUQg2uPQtFsF2K6bsX2uAj+0zbXDvg==
=2UXC
-----END PGP SIGNATURE-----

--QNDPHrPUIc00TOLW--


