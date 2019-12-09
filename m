Return-Path: <SRS0=fi8h=Z7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 129B1C43603
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2019 16:00:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D17592077B
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2019 16:00:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QlJVpWFf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D17592077B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41878 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ieLSU-0003Ob-Ts
	for qemu-devel@archiver.kernel.org; Mon, 09 Dec 2019 11:00:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57523)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1ieLQb-0001rS-Ry
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 10:58:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1ieLQa-0000fE-RO
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 10:58:29 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:40541
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1ieLQa-0000et-NN
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 10:58:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575907108;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=t8vTHH4HBhkWg0cbygOOz8+F4/V2krGYZWgqsVVFEeU=;
 b=QlJVpWFfzIMl1zEx9WPKIx5hzmWDHQadX3LX9STWw8q2E3Y2y7zvXT52b4+RiE9uWHpRIz
 OOh+uqgMH9XobhH7jIih0eHdNhFdkNc4hYetrn79zifzti3Y3T325DRC+CjIyiD54bxoMX
 P2y0wFL2rzHwtcGxdXO1e3FiNA+XE5c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-170-cNeTgh6jMFC7sufh0f1wyw-1; Mon, 09 Dec 2019 10:58:23 -0500
X-MC-Unique: cNeTgh6jMFC7sufh0f1wyw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D5D95A3824;
 Mon,  9 Dec 2019 15:58:22 +0000 (UTC)
Received: from localhost (ovpn-117-247.ams2.redhat.com [10.36.117.247])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 33DAA165DA;
 Mon,  9 Dec 2019 15:58:22 +0000 (UTC)
Date: Mon, 9 Dec 2019 15:58:20 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Subject: Re: [PATCH  v2 6/6] trace: replace hand-crafted pattern_glob with
 g_pattern_match_simple
Message-ID: <20191209155820.GA47525@stefanha-x1.localdomain>
References: <20191205122518.10010-1-alex.bennee@linaro.org>
 <20191205122518.10010-7-alex.bennee@linaro.org>
MIME-Version: 1.0
In-Reply-To: <20191205122518.10010-7-alex.bennee@linaro.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="y0ulUmNC+osPPQO6"
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

--y0ulUmNC+osPPQO6
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

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--y0ulUmNC+osPPQO6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl3ubxwACgkQnKSrs4Gr
c8ipkwf6A+h/XFfL5wHGs1/BQsMiwTH8Gjda3TfkckANEXwCRw0lgn07lo8iFZkc
aERi3uK+Qyjwh9obSrcNTToWS3rc2Efvuw8FCTFSrAADTat86EqaGM7fbYDa+ke4
bfkKgdlMhVUcLdj4Iz2ti4gbFFrUk+bFL2/CSR4hzufE9XeaFHkxOckyVslzWauH
Sk9QvJu2SfA4qKgK1BGVVP5lHVQRLSvupIV4N9eQWT/h4nQ7WAfUjsDMFVDz4fFu
l7O8do2w3DnNHrHNZYDyTtVIdkWFajIJuU7iJjYnHpiRzyD2haajVV39ECNwWobt
IpHXLMERIRcfx/ui4HDCufVKqcf30Q==
=QRjM
-----END PGP SIGNATURE-----

--y0ulUmNC+osPPQO6--


