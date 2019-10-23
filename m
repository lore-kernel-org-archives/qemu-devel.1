Return-Path: <SRS0=brme=YQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99361CA9EB6
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2019 08:59:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 60953205C9
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2019 08:59:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i9qwA9nl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60953205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57596 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNCUf-0005I6-Ff
	for qemu-devel@archiver.kernel.org; Wed, 23 Oct 2019 04:59:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49902)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1iNC9F-0000G0-QN
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 04:37:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1iNC9D-0007BT-SL
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 04:37:41 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:27101
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1iNC9B-00076V-Re
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 04:37:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1571819855;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FIqCARfcVW9wuiOKaI1ga1uSM/PJ7/4To4/XNBhaQOM=;
 b=i9qwA9nlQMhAnqKtPxqBKY4k3UTg0VGH7h+72NUadDZZ/7Cnk2ih8QydAop1fTJUINiMSo
 BzwIR0oY2TbQEH/FelSA7+jt5YJugQcTWpW+l/E+zpnmGtWuXuHmhf8WoT4bPSjiVVCXY0
 g2pEZtZEzG49RmdvdEwAvoFEWW5xy/8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-348-ufJBc-1bMMyTl94Z0Xs-3g-1; Wed, 23 Oct 2019 04:37:32 -0400
X-MC-Unique: ufJBc-1bMMyTl94Z0Xs-3g-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6D25B800D49;
 Wed, 23 Oct 2019 08:37:31 +0000 (UTC)
Received: from localhost (unknown [10.36.118.70])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 301D0600CC;
 Wed, 23 Oct 2019 08:37:23 +0000 (UTC)
Date: Wed, 23 Oct 2019 09:37:22 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Christophe de Dinechin <dinechin@redhat.com>
Subject: Re: [PATCH v3 09/16] libqos: access VIRTIO 1.0 vring in little-endian
Message-ID: <20191023083722.GB9574@stefanha-x1.localdomain>
References: <20191019063810.6944-1-stefanha@redhat.com>
 <20191019063810.6944-10-stefanha@redhat.com>
 <m136fkoh9g.fsf@redhat.com>
MIME-Version: 1.0
In-Reply-To: <m136fkoh9g.fsf@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="tjCHc7DPkfUGtrlw"
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
Cc: Fam Zheng <fam@euphon.net>, Laurent Vivier <lvivier@redhat.com>,
 Thomas Huth <thuth@redhat.com>, qemu-block@nongnu.org, slp@redhat.com,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--tjCHc7DPkfUGtrlw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 22, 2019 at 06:51:39PM +0200, Christophe de Dinechin wrote:
>=20
> Stefan Hajnoczi writes:
> [...]
> > +static uint16_t qvirtio_readw(QVirtioDevice *d, QTestState *qts, uint6=
4_t addr)
> > +{
> > +    uint16_t val =3D qtest_readw(qts, addr);
> > +
> > +    if (d->features & (1ull << VIRTIO_F_VERSION_1) && qtest_big_endian=
(qts)) {
>=20
> For my education, I was wondering why tests use the (1ull << FEATURE)
> notation and not an equivalent of virtio_has_feature()? Is this
> intentional, or just legacy?

It's historical, libqos never defined an equivalent helper function.

Stefan

--tjCHc7DPkfUGtrlw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl2wEUIACgkQnKSrs4Gr
c8j/pwgAn1feplUcaId3D0UmhGGu6XRKjD81wabPxaFeh/nLM51VjlRzXMu8bubc
Xyo2NffI+Rnc4Tp2wMFaQ5tWgY+vugIscW6eZw340WQU6bc8ja1c6N+3//tywrjA
HBt4U6+6MUPIL8beVU2umD9+s+ta5iXluNWgwwAGP6yLgrF4STRAqWCip2FfbGuX
+yb4ccbuT18jmiSPECOVH8U/+t4sTfNxrOLAw41OZ0fqHJQHzKi2sGvoj6IHcZgY
Bal03fr2ZYL1PfGdr6I/PY9uC9ZvbNpPPPIdnCSFbmitCcQTt5S3P5RfbOM9ssoG
hHk6Q9qcrGk6NWunoO/7eDubgKpLrw==
=nQrg
-----END PGP SIGNATURE-----

--tjCHc7DPkfUGtrlw--


