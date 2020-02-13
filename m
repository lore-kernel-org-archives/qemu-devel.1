Return-Path: <SRS0=ry7b=4B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0092C2BA83
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 13:48:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A581D217F4
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 13:48:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B7LTd3NP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A581D217F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52624 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2ErR-0003NP-Qq
	for qemu-devel@archiver.kernel.org; Thu, 13 Feb 2020 08:48:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50360)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1j2EoL-00081u-AM
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 08:45:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1j2EoF-0000Yx-0p
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 08:45:41 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:51579
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1j2EoE-0000Yg-T7
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 08:45:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581601538;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=aGWb3j7hBbexZ89g551PL4PcAp6TmTiI6IUGkx8rOKQ=;
 b=B7LTd3NPPiS5y1trGs0GR3vgy1DwvCpOk6NC46+3tmi7lvyyBdqSn4Ihz8CZ/eeEje0Tes
 gwUIT/l+ZljbRMRU7mewUTd56QPpfMbjwkfi+DSj1GcmhfEKfYrTPDre2aI1wNlKJp/8MM
 qBTaa7dpxDPzjxXnitbH4/3+kQzxUlE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-436-NAQehj_4Mmm8irIRQKFGqQ-1; Thu, 13 Feb 2020 08:45:33 -0500
X-MC-Unique: NAQehj_4Mmm8irIRQKFGqQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 030E0100550E;
 Thu, 13 Feb 2020 13:45:32 +0000 (UTC)
Received: from localhost (unknown [10.36.118.21])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5FFED5C12E;
 Thu, 13 Feb 2020 13:45:28 +0000 (UTC)
Date: Thu, 13 Feb 2020 13:45:27 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Subject: Re: [PATCH] tracing: only allow -trace to override -D if set
Message-ID: <20200213134527.GF544499@stefanha-x1.localdomain>
References: <20200211111054.27538-1-alex.bennee@linaro.org>
 <20200212153459.GE432724@stefanha-x1.localdomain>
 <195b1312-e86b-3b4b-5447-29a21708c931@redhat.com>
MIME-Version: 1.0
In-Reply-To: <195b1312-e86b-3b4b-5447-29a21708c931@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="7mxbaLlpDEyR1+x6"
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: Stefan Hajnoczi <stefanha@gmail.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--7mxbaLlpDEyR1+x6
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 12, 2020 at 11:31:00PM +0100, Philippe Mathieu-Daud=E9 wrote:
> On 2/12/20 4:34 PM, Stefan Hajnoczi wrote:
> > On Tue, Feb 11, 2020 at 11:10:54AM +0000, Alex Benn=E9e wrote:
> > > Otherwise any -D settings the user may have made get ignored.
> > >=20
> > > Signed-off-by: Alex Benn=E9e <alex.bennee@linaro.org>
> > > ---
> > >   trace/control.c | 11 ++++++++---
> > >   1 file changed, 8 insertions(+), 3 deletions(-)
> >=20
> > Thanks, applied to my tracing tree:
> > https://github.com/stefanha/qemu/commits/tracing
>=20
> If possible, please add 'Fixes: e144a605a'.

Done!

Stefan

--7mxbaLlpDEyR1+x6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl5FUvcACgkQnKSrs4Gr
c8hJdggAknMfSRJ2fXYrSAJRwXoodwYDN2h7y49z296PCcfiHYxWcwt/0ZSg1O8i
v3FEn/dUGhs4UtTdW0QOSxUW3B16v8tMShPcmNuo/aeM6Hmemu0J3/3TW4PStTxj
EGuyW0m539hSuei01AIIIueezkRA5LjOZZAxvHfuXrHvaD1xIZ0zaB6kiwxlAh9x
6DSw3/3QlDrojqmlUugK5LPgIUXTTAzC/FfhFzxEom90lCWDZiZnmYAOEMsu8N71
Jewl8+f7y1pNEADJK5KtSk1BwWKiQucsLe0A7gIJawjkfhxVk4w5DSxzSqjo5LXs
bdhBeG955yVUuHxx8TxmElM2qYl8bg==
=y82C
-----END PGP SIGNATURE-----

--7mxbaLlpDEyR1+x6--


