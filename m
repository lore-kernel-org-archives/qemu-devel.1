Return-Path: <SRS0=8N/K=Z4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9116AC43603
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2019 16:53:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D64B206DF
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2019 16:53:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hvAJLmL6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D64B206DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41272 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1idGqu-0006tz-V0
	for qemu-devel@archiver.kernel.org; Fri, 06 Dec 2019 11:53:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59202)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1idFAa-0005EG-HL
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 10:05:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1idFAZ-0003PC-6V
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 10:05:24 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:43705
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1idFAZ-0003NN-0F
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 10:05:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575644722;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=nWrqnXoXs6MGj2JyXlLNfXNWdIwaB31OYyhVEPLjPc4=;
 b=hvAJLmL6xwm79Y7g7PkwCTRcVd9V86gH4AXshVvzbIEyC3ynBkz1S7NDNiz348dNrEdofc
 3jox6pJOCV83Tr0SUoq8htwpEdgZGHwVp31N0YpnMluwjrvZJtmO+Pxm5DXjgA/MboxnF7
 h7+vOfHLa9d2LKoFC8GmBGnfkzldgPQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-344-9e8UrNvUNSilsbD_nt04Hg-1; Fri, 06 Dec 2019 06:04:00 -0500
X-MC-Unique: 9e8UrNvUNSilsbD_nt04Hg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C6C84183B703;
 Fri,  6 Dec 2019 11:03:59 +0000 (UTC)
Received: from localhost (ovpn-117-102.ams2.redhat.com [10.36.117.102])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3B6595D6A3;
 Fri,  6 Dec 2019 11:03:59 +0000 (UTC)
Date: Fri, 6 Dec 2019 11:03:54 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Subject: Re: [PATCH  v2 6/6] trace: replace hand-crafted pattern_glob with
 g_pattern_match_simple
Message-ID: <20191206110354.GA775461@stefanha-x1.localdomain>
References: <20191205122518.10010-1-alex.bennee@linaro.org>
 <20191205122518.10010-7-alex.bennee@linaro.org>
MIME-Version: 1.0
In-Reply-To: <20191205122518.10010-7-alex.bennee@linaro.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="ikeVEW9yuYc//A+q"
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--ikeVEW9yuYc//A+q
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 05, 2019 at 12:25:17PM +0000, Alex Benn=E9e wrote:
> We already use g_pattern_match elsewhere so remove the duplication.
>=20
> Signed-off-by: Alex Benn=E9e <alex.bennee@linaro.org>
> ---
>  trace/control.c | 35 +----------------------------------
>  1 file changed, 1 insertion(+), 34 deletions(-)

Is g_pattern_match() a superset of pattern_glob()?  Existing patterns
should continue to work.

Stefan

--ikeVEW9yuYc//A+q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl3qNZoACgkQnKSrs4Gr
c8jUZgf+MiAkREkLubaqfNACn4BUxLHVfI+L2FWBD3i2QJ6npRc/mNdDvSZF9RQM
yyzSLg2jt25enDILh8KCMrfNlbKXHr1nD8s/so/+MfDoy2V/abzsfbfnIhdUAF5l
Aeen63hw78vfTHkuGCS9042RPQAPYdQdd/NnYrxEyfzVUnpmHxiUY8WvUSi7Zk+x
N5ejYKeHtsp3j7PjxhpOtitmf4yT6z76w6JBYICUSbt7I/TuuZcOjMPFWyCyc4t7
7Qkd47TDYiGgHPrl3AcvuPZcnEguIxaiZw71/eBP2MC/HYPiKx9BR3ALhwGZI3kl
Zr+M2j8NO327wHaww3WVryIREnoiAQ==
=7iuc
-----END PGP SIGNATURE-----

--ikeVEW9yuYc//A+q--


