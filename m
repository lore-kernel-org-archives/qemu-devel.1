Return-Path: <SRS0=WkHy=5I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD763C4332B
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2020 11:06:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 97C3F20781
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2020 11:06:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IzjtOkB6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97C3F20781
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60232 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGKus-0005LK-Ms
	for qemu-devel@archiver.kernel.org; Mon, 23 Mar 2020 07:06:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39542)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1jGKuD-0004rT-A5
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 07:06:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1jGKuC-00055e-2l
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 07:06:05 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:48543)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1jGKuB-00055K-UY
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 07:06:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584961563;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FQVeJ2o4xxEGaBVLzBPhSj3ybl0U6VD8rhvKnoCBc8w=;
 b=IzjtOkB6ZYvJNOv93nRGDW7nGKKWkoOx6jW2RrTCAcUehobUExoUCyDJZaoA9LyHqeDVDN
 +bh3IcefbEehOS078QZCn3RDCHNxlNtBPgH+jO5kJooLjiT6qms+N9AMpMRqgZSvafYIOk
 mCJFiXdxJg4wGkTHeqfrzkjXeYuqMj4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-104-K-Qm5OEbMIaAvGtjgbRhwA-1; Mon, 23 Mar 2020 07:05:59 -0400
X-MC-Unique: K-Qm5OEbMIaAvGtjgbRhwA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 93A66107ACC7;
 Mon, 23 Mar 2020 11:05:58 +0000 (UTC)
Received: from localhost (ovpn-115-37.ams2.redhat.com [10.36.115.37])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7926B171B1;
 Mon, 23 Mar 2020 11:05:55 +0000 (UTC)
Date: Mon, 23 Mar 2020 11:05:53 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Subject: Re: [PATCH] aio-posix: fix io_uring with external events
Message-ID: <20200323110553.GC261260@stefanha-x1.localdomain>
References: <20200319163559.117903-1-stefanha@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200319163559.117903-1-stefanha@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="yVhtmJPUSI46BTXb"
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 63.128.21.74
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
 Julia Suvorova <jusual@redhat.com>, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--yVhtmJPUSI46BTXb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 19, 2020 at 04:35:59PM +0000, Stefan Hajnoczi wrote:
> When external event sources are disabled fdmon-io_uring falls back to
> fdmon-poll.  The ->need_wait() callback needs to watch for this so it
> can return true when external event sources are disabled.
>=20
> It is also necessary to call ->wait() when AioHandlers have changed
> because io_uring is asynchronous and we must submit new sqes.
>=20
> Both of these changes to ->need_wait() together fix tests/test-aio -p
> /aio/external-client, which failed with:
>=20
>   test-aio: tests/test-aio.c:404: test_aio_external_client: Assertion `ai=
o_poll(ctx, false)' failed.
>=20
> Reported-by: Julia Suvorova <jusual@redhat.com>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  util/fdmon-io_uring.c | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)

Thanks, applied to my block tree:
https://github.com/stefanha/qemu/commits/block

Stefan

--yVhtmJPUSI46BTXb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl54mBEACgkQnKSrs4Gr
c8i1NggAqnMxoG+YJab3ikEdwTMJvnLNKd7X72g61mH49mgSxVDf44X12x0N+74k
NtNR/TyTmEhtOa/52Des3+qnM6yVNizbpODY1XQeAlKOVlt9ji9W/c3l079LWNHQ
reN/2SMxGnt/JaLXCjzzqz0BNCaTnp4ruWHvs18IaVKs9KYH9+66rtjUBBOjIjR0
9vFj9fB0ylgSge2iorznNx0vC8lR3QIciesT163VLfFHMVKsYKSxhxcx4TK2u0Uo
iMFi/ZFZ8QQ5DfhZPr1qMNUdHwAj78pl/VGVc8yeADYOmtUXGPgMVyLdcrftZEjv
TCcorUuqWgsMRdGmOCufLZGY43+SXg==
=/W2q
-----END PGP SIGNATURE-----

--yVhtmJPUSI46BTXb--


