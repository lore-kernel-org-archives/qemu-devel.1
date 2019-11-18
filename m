Return-Path: <SRS0=QE2o=ZK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0988C432C0
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2019 16:50:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A128F21850
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2019 16:50:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HaWWI1tV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A128F21850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36818 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iWkEo-0003tU-O6
	for qemu-devel@archiver.kernel.org; Mon, 18 Nov 2019 11:50:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50949)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1iWkE0-0003HT-8m
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 11:50:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1iWkDx-00029T-Eg
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 11:50:02 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:54345
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1iWkDx-000293-Ag
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 11:50:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574095799;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Q9FROpFKR7ElVN7by/Ot/5wuMsif34y8M6hyNF2Ix50=;
 b=HaWWI1tVZJxh+mB6dD1Mj8lFF8CCtLuZuJV7+uQIKD97rw5OBT6tURvtVHtcOzd3f0j83z
 tEiCV0HDnAG5ClTMlvvdQsmEChnFa2/agwkCj7+cYy1LrlKjhIOwaH2idOsjr/aYyFNzV/
 veAUOhmZv71BnlR4+sQ7VuRqSPVo4cc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-152-xjhhHCAUO9uPGqdSHTuwyA-1; Mon, 18 Nov 2019 11:49:57 -0500
X-MC-Unique: xjhhHCAUO9uPGqdSHTuwyA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D9BF0116070A;
 Mon, 18 Nov 2019 16:49:55 +0000 (UTC)
Received: from linux.fritz.box (ovpn-117-108.ams2.redhat.com [10.36.117.108])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5B9A060BF4;
 Mon, 18 Nov 2019 16:49:54 +0000 (UTC)
Date: Mon, 18 Nov 2019 17:49:52 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Peter Krempa <pkrempa@redhat.com>
Subject: Re: [PATCH 0/2] block: Fix multiple blockdev-snapshot calls
Message-ID: <20191118164952.GB5325@linux.fritz.box>
References: <20191108085312.27049-1-kwolf@redhat.com>
 <20191118162636.GC3745@andariel.pipo.sk>
MIME-Version: 1.0
In-Reply-To: <20191118162636.GC3745@andariel.pipo.sk>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="gj572EiMnwbLXET9"
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
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--gj572EiMnwbLXET9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 18.11.2019 um 17:26 hat Peter Krempa geschrieben:
> On Fri, Nov 08, 2019 at 09:53:10 +0100, Kevin Wolf wrote:
> > Kevin Wolf (2):
> >   block: Remove 'backing': null from bs->{explicit_,}options
> >   iotests: Test multiple blockdev-snapshot calls
>=20
> Hi,
>=20
> I'm not sure how the freeze rules for qemu are at this point thus:
>=20
> Will this patchset make it into 4.2. I argue it's a pretty important fix
> as it ends up in image corruption.
>=20
> If it won't make into we will need to add a QMP feature flag to detect
> presence of the fix so that I can gate libvirt's support of blockdev
> with it. (This can also be done if we make it into 4.2 but I'll be okay
> infering it from other fixes present in 4.2).

Yes, this is planned for 4.2. I'm in the process of preparing a pull
request right now.

Kevin

--gj572EiMnwbLXET9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJd0suwAAoJEH8JsnLIjy/WZ3kP/2MaMp4/S+yhSmeOw1c8FMVp
sU8/f5JDjnaRSQsgOHEvLhTWnfAQ7gFWO8b9O32pNSpH0Oe7Y4OInwyPf3PLYLp/
c0+x5nBDgFY6gGSISm0cZaGt8FttqiEpILPFNKThVr95+AWLW12cBJkA92qWgj71
ovxx73UsK1az0eakf/tgVI5vXVfN0oYyi2JS9e6ZqxMBiNCrDRkIrgRKngYML82r
iF4mgsEZYjkBdTpzEIH7IklqX1xHjPVjT2kQjM6ixlFzuiDRFoHMRqGd35I76EMU
ynop4cmWFAYqj4RVWOZ7S9JVYuY2/Abgv94klOADNfbEfzDe9SBqCbjB/t2F3PzL
53HHffAOyV3iFHJ+h041sGNQ0B5H1SuQF1iDhTtjRL4jE9gAKzggWzJe7TcwgZ5l
EyzL6YDahHI2M/dNUcRPBA5smD/tvRuoh7lx1aC6kKWxUdbNHlRKEmCbZO9YzYtA
NZLNHs7VEUkuEMXI2ix/xUfH4QFNbXFIvA5OMb9ugfdjnpHND6roQkBlS2Vo1tuW
+itR+jzjmkdYiroHN5xra8orKOT0jZ2QrPbbAr4tmNrlkoMN79OstR/3YyrY36oP
xbOn3rNUZFfTyafUKSVIXRyvx0aFL2A/I68NGWLcs6/o0XP/invo4+/3DFbaTyd5
0zJtfFFi4gP5fUsMtuXk
=PGG1
-----END PGP SIGNATURE-----

--gj572EiMnwbLXET9--


