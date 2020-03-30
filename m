Return-Path: <SRS0=g3Vr=5P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD5EAC43331
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2020 09:22:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 77B8A206E6
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2020 09:22:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jCMBWGpt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77B8A206E6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46932 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jIqdB-0001hd-Mq
	for qemu-devel@archiver.kernel.org; Mon, 30 Mar 2020 05:22:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38406)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1jIqcJ-0000lD-OL
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 05:22:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1jIqcI-0007xf-4F
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 05:21:59 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:54208)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1jIqcH-0007xD-Sb
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 05:21:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585560117;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=TTQOSi60Xg+k4c2akT3HCA42b+mAbXsd90oWRrvqAu4=;
 b=jCMBWGpts6TBZeAexRd8lto2UdnadP7xbQOsiyRo+DN26c8INHcrb6+b22gm2B6SUUPx6X
 38ISn2uvqEMSngV2Ig/juUQvFmfd7XBbRnxGZIWILftm9FKIArcFhyw5EgzdnTpEni+Pq+
 R3Yu9g3X6OUqneU81+CX4FtKcLXQJIM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-222-m7O6YrbIPMSZ3mShEjj7GA-1; Mon, 30 Mar 2020 05:21:53 -0400
X-MC-Unique: m7O6YrbIPMSZ3mShEjj7GA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 485788C02E2;
 Mon, 30 Mar 2020 09:21:33 +0000 (UTC)
Received: from localhost (ovpn-115-1.ams2.redhat.com [10.36.115.1])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 26E085C1BB;
 Mon, 30 Mar 2020 09:21:28 +0000 (UTC)
Date: Mon, 30 Mar 2020 10:21:27 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>
Subject: Re: [PATCH-for-5.0 00/12] hw: Add missing error-propagation code
Message-ID: <20200330092127.GE73285@stefanha-x1.localdomain>
References: <20200325191830.16553-1-f4bug@amsat.org>
 <CAAdtpL7rC1u=B-xW+ZbrRbpSMKvGx0kq_hug1J9-cxx6NgJR1Q@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAAdtpL7rC1u=B-xW+ZbrRbpSMKvGx0kq_hug1J9-cxx6NgJR1Q@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="KlAEzMkarCnErv5Q"
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
Cc: Paul Burton <pburton@wavecomp.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Richard Henderson <rth@twiddle.net>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Alistair Francis <alistair@alistair23.me>, qemu-arm <qemu-arm@nongnu.org>,
 David Gibson <david@gibson.dropbear.id.au>, qemu-riscv@nongnu.org,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 "qemu-ppc@nongnu.org list:PowerPC" <qemu-ppc@nongnu.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--KlAEzMkarCnErv5Q
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 25, 2020 at 08:20:49PM +0100, Philippe Mathieu-Daud=E9 wrote:
> On Wed, Mar 25, 2020 at 8:18 PM Philippe Mathieu-Daud=E9 <f4bug@amsat.org=
> wrote:
> >
> > This series is inspired of Peter fix:
> > "hw/arm/xlnx-zynqmp.c: fix some error-handling code"
> > https://www.mail-archive.com/qemu-devel@nongnu.org/msg691636.html
> >
> > Add a cocci script to fix the other places.
> >
> > Based-on: <20200324134947.15384-1-peter.maydell@linaro.org>
> >
> > Philippe Mathieu-Daud=3DC3=3DA9 (12):
>=20
> Hmm is that a git-publish bug?

Please run git-publish once more on the same branch and inspect the
$TMPDIR/0000-cover-letter.patch email in an editor when git-publish
prints "Stopping so you can inspect the patch emails:".

It would be interesting to see how your name is formatted, as well as
the MIME Content-Type and Content-Transfer-Encoding headers.

This information can be compared to the final email sent to the list
and/or received by the mailing list.

Stefan

--KlAEzMkarCnErv5Q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl6BuhcACgkQnKSrs4Gr
c8geswf/Y1RvjCrsHUzGEgB7HqO1Ava0qbCa8POIXJhTPJXepAJGAWNp5uTItRsk
VLrUAaqlKuLcmybiR+Hnb6gg9ekMxuQpa+7PYtVYf1dEANgkC70rsybvZrQNUC9v
9JipcZA9LFyhFg4GVWjXw1B6HOLwxYnpzbnV93WVaTwGgl7RUqXTZ88c6EeHY/4E
DUaAKJeKl9z6C15BwvoB59zzqwGWV71V1q14fmErmuzuqMXR+NdcgYX6bhwPQXko
APnPPhpxm7NI17P/02t7wd6BN+sdz1NhgO2mPGenrXuyvJ57/5HuoHJqEMAgK6Ud
GXignHroHnlN+wOb5juZjpxj903FAQ==
=FGvm
-----END PGP SIGNATURE-----

--KlAEzMkarCnErv5Q--


