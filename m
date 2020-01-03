Return-Path: <SRS0=dCqM=2Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD7A8C2D0C2
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jan 2020 11:20:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 74F442085B
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jan 2020 11:20:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Dykr8VyR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74F442085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51046 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1inL0O-0000jE-7R
	for qemu-devel@archiver.kernel.org; Fri, 03 Jan 2020 06:20:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59190)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1inKz1-0007lN-3D
 for qemu-devel@nongnu.org; Fri, 03 Jan 2020 06:19:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1inKz0-0004d2-1U
 for qemu-devel@nongnu.org; Fri, 03 Jan 2020 06:19:11 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:60497
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1inKyz-0004ag-RZ
 for qemu-devel@nongnu.org; Fri, 03 Jan 2020 06:19:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578050349;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KBqyCspBHOrXYgLA25prmlpKPUtTooiQG2OyTLVe+b8=;
 b=Dykr8VyRRfHj+EdJd+nD3cYmGn+2B/Xf76LxPLJBNEuBXtQgZ8euRSPzLNXBrebCg4flxb
 zB8H6rX3bdxftUu1QLHxp7yjgCbK3tcDpaT3bfu68oaMDPkhURAtz5xmlv2WHfpK4YtsJI
 QUrtXfb4bIkirwA5Vc7kNqXBJohELjw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-295-QcO6w65hPFKc0JqmYuk4Iw-1; Fri, 03 Jan 2020 06:19:06 -0500
X-MC-Unique: QcO6w65hPFKc0JqmYuk4Iw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 16DBB107ACC4;
 Fri,  3 Jan 2020 11:19:05 +0000 (UTC)
Received: from localhost (ovpn-116-102.ams2.redhat.com [10.36.116.102])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2BBF87E48D;
 Fri,  3 Jan 2020 11:19:01 +0000 (UTC)
Date: Fri, 3 Jan 2020 11:19:00 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
To: "Oleinik, Alexander" <alxndr@bu.edu>
Subject: Re: [PATCH v6 05/21] libqtest: Add a layer of abstraciton to send/recv
Message-ID: <20200103111900.GI130240@stefanha-x1.localdomain>
References: <20191129213424.6290-1-alxndr@bu.edu>
 <20191129213424.6290-6-alxndr@bu.edu>
MIME-Version: 1.0
In-Reply-To: <20191129213424.6290-6-alxndr@bu.edu>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="9s922KAXlWjPfK/Q"
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
Cc: Thomas Huth <thuth@redhat.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "bsd@redhat.com" <bsd@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Laurent Vivier <lvivier@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--9s922KAXlWjPfK/Q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 29, 2019 at 09:34:41PM +0000, Oleinik, Alexander wrote:
> This makes it simple to swap the transport functions for qtest commands
> to and from the qtest client. For example, now it is possible to
> directly pass qtest commands to a server handler that exists within the
> same process, without the standard way of writing to a file descriptor.
>=20
> Signed-off-by: Alexander Bulekov <alxndr@bu.edu>
> ---
>  tests/libqtest.c | 50 +++++++++++++++++++++++++++++++++++++++---------
>  1 file changed, 41 insertions(+), 9 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--9s922KAXlWjPfK/Q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl4PIyQACgkQnKSrs4Gr
c8hAdwf/TcQuGq5YgWWKNyMqQkF3To3GYGEwG7QamUr78FCTCX669rnDru6wqFWx
CTFbEdSG8zYFpDTUq06god3MXFHKs43jNf/yD55tkMRaiAelqZ5rCqO/2CjLIwqD
5owZcPHKQbcgmb0E09t2CmMzeeGDVVX0CXekN4bStavuneOAUaHLlLPYOO3vTsHF
1o+FrY/1gvISOXd0W7tvsCbnKjyjiZZwe/vLWueK8Uh8wEEx4820s3kTVhPB9cm4
jTJrXRq8E7kxQIhcZc5E5lU3ZJXXoBXiLgoSOj/f2YN9XR4S75Qv110WE0kB6+cX
vEEtDB0guvU9Pwg9SCV1UxhZk3Q8tQ==
=1coy
-----END PGP SIGNATURE-----

--9s922KAXlWjPfK/Q--


