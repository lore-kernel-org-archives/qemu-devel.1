Return-Path: <SRS0=ZRpO=43=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E73AC10F25
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 02:33:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E92D820728
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 02:33:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gPdXK05o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E92D820728
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52652 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBUi2-0001PC-4L
	for qemu-devel@archiver.kernel.org; Mon, 09 Mar 2020 22:33:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36949)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <crosa@redhat.com>) id 1jBUhJ-0000tM-9c
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 22:32:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <crosa@redhat.com>) id 1jBUhH-0006Ar-Lj
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 22:32:45 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:43438
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <crosa@redhat.com>) id 1jBUhH-00069R-Hw
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 22:32:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583807562;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MiGCSfqJ2K89zw3ae9/V+P+YB/iJ0XMAG7JIz38FspI=;
 b=gPdXK05orMj7cOxSTn32JAg+JnK+H1Gtce33fBem3ZYukL1hWbiNWMXM5CoxfKy4CEfRSS
 nfoSdEkbJM7+Fqy2E4PZiy7UOTCLr7e31XJItMIrJTLVVzlDo4/lGOoS5ss6Pv+heakphA
 WSUW9CywV7CnPb3StvrtgfvcsqPTqc0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-362-MsxHRfurOKSwE9HpmiE_9g-1; Mon, 09 Mar 2020 22:32:37 -0400
X-MC-Unique: MsxHRfurOKSwE9HpmiE_9g-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8F8DA800D48;
 Tue, 10 Mar 2020 02:32:35 +0000 (UTC)
Received: from colo-mx.corp.redhat.com
 (colo-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.21])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3C8C462667;
 Tue, 10 Mar 2020 02:32:35 +0000 (UTC)
Received: from zmail17.collab.prod.int.phx2.redhat.com
 (zmail17.collab.prod.int.phx2.redhat.com [10.5.83.19])
 by colo-mx.corp.redhat.com (Postfix) with ESMTP id 9E702860D7;
 Tue, 10 Mar 2020 02:32:34 +0000 (UTC)
Date: Mon, 9 Mar 2020 22:32:34 -0400 (EDT)
From: Cleber Rosa <crosa@redhat.com>
To: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <517418432.204149.1583807554368.JavaMail.zimbra@redhat.com>
In-Reply-To: <20200310014116.GF660117@umbus.fritz.box>
References: <20200211134504.9156-1-philmd@redhat.com>
 <87eeuewv4k.fsf@linaro.org> <20200310014116.GF660117@umbus.fritz.box>
Subject: Re: [PATCH] tests/acceptance/ppc_prep_40p: Use cdn.netbsd.org hostname
MIME-Version: 1.0
X-Originating-IP: [10.10.121.175, 10.4.195.1]
Thread-Topic: tests/acceptance/ppc_prep_40p: Use cdn.netbsd.org hostname
Thread-Index: 7922ch1a2PfoghuxkvQzinqLxhNCQQ==
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org, Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Kamil Rytarowski <kamil@netbsd.org>, qemu-ppc@nongnu.org,
 Willian Rampazzo <wrampazz@redhat.com>,
 =?utf-8?Q?Herv=C3=A9?= Poussineau <hpoussin@reactos.org>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



----- Original Message -----
> From: "David Gibson" <david@gibson.dropbear.id.au>
> To: "Alex Benn=C3=A9e" <alex.bennee@linaro.org>
> Cc: qemu-devel@nongnu.org, "Wainer dos Santos Moschetta" <wainersm@redhat=
.com>, "Kamil Rytarowski"
> <kamil@netbsd.org>, "Herv=C3=A9 Poussineau" <hpoussin@reactos.org>, "Cleb=
er Rosa" <crosa@redhat.com>,
> qemu-ppc@nongnu.org, "Philippe Mathieu-Daud=C3=A9" <philmd@redhat.com>
> Sent: Monday, March 9, 2020 9:41:16 PM
> Subject: Re: [PATCH] tests/acceptance/ppc_prep_40p: Use cdn.netbsd.org ho=
stname
>=20
> On Fri, Feb 28, 2020 at 04:10:19PM +0000, Alex Benn=C3=A9e wrote:
> >=20
> > Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> writes:
> >=20
> > > Use NetBSD content delivery network to get faster downloads.
> >=20
> > Even with this patch I get failures on my big dev box:
> >=20
> >  (48/67)
> >  tests/acceptance/ppc_prep_40p.py:IbmPrep40pMachine.test_openbios_and_n=
etbsd:
> >  INTERRUPTED: Failed to fetch NetBSD-7.1.2-prep.iso.\nRunner error
> >  occurred: Timeout reached\nOriginal status: ERROR\n{'name':
> >  '48-tests/acceptance/ppc_prep_40p.py:IbmPrep40pMachine.test_openbios_a=
nd_netbsd',
> >  'logdir': '/home/alex/lsrc/qemu.git/builds/all/tests/results/jo... (60=
.31
> >  s)
> >=20
> > I think ultimately a whole ISO download is just too much for an
> > acceptance test.
>=20
> I tend to agree.  Here in a network-remote part of the world, these
> always seem to cause timeouts and other problems, in a bunch of the
> testcases.
>=20
> Those are testing useful things though, so I'd really like to see the
> downloads split out into some sort of preparation step that can be
> done just once, rather than part of the test proper.
>=20

We have added functionality in the latest Avocado that will let us
easily set a "cancel this test if the ISO has not being previously
downloaded", or "cancel if it fails to be downloaded during the test".

+Willian can explain how it works, and if found to be suitable, and work
on a patch.

-Cleber.

> > > Suggested-by: Kamil Rytarowski <kamil@netbsd.org>
> > > Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> > > ---
> > >  tests/acceptance/ppc_prep_40p.py | 4 ++--
> > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/tests/acceptance/ppc_prep_40p.py
> > > b/tests/acceptance/ppc_prep_40p.py
> > > index efe06037ba..6729d96f5e 100644
> > > --- a/tests/acceptance/ppc_prep_40p.py
> > > +++ b/tests/acceptance/ppc_prep_40p.py
> > > @@ -34,7 +34,7 @@ def test_factory_firmware_and_netbsd(self):
> > >                      '7020-40p/P12H0456.IMG')
> > >          bios_hash =3D '1775face4e6dc27f3a6ed955ef6eb331bf817f03'
> > >          bios_path =3D self.fetch_asset(bios_url, asset_hash=3Dbios_h=
ash)
> > > -        drive_url =3D ('https://ftp.netbsd.org/pub/NetBSD/NetBSD-arc=
hive/'
> > > +        drive_url =3D ('https://cdn.netbsd.org/pub/NetBSD/NetBSD-arc=
hive/'
> > >                       'NetBSD-4.0/prep/installation/floppy/generic_co=
m0.fs')
> > >          drive_hash =3D 'dbcfc09912e71bd5f0d82c7c1ee43082fb596ceb'
> > >          drive_path =3D self.fetch_asset(drive_url, asset_hash=3Ddriv=
e_hash)
> > > @@ -67,7 +67,7 @@ def test_openbios_and_netbsd(self):
> > >          :avocado: tags=3Darch:ppc
> > >          :avocado: tags=3Dmachine:40p
> > >          """
> > > -        drive_url =3D ('https://ftp.netbsd.org/pub/NetBSD/iso/7.1.2/=
'
> > > +        drive_url =3D ('https://cdn.netbsd.org/pub/NetBSD/iso/7.1.2/=
'
> > >                       'NetBSD-7.1.2-prep.iso')
> > >          drive_hash =3D 'ac6fa2707d888b36d6fa64de6e7fe48e'
> > >          drive_path =3D self.fetch_asset(drive_url, asset_hash=3Ddriv=
e_hash,
> >=20
> >=20
>=20
> --
> David Gibson=09=09=09| I'll have my music baroque, and my code
> david AT gibson.dropbear.id.au=09| minimalist, thank you.  NOT _the_ _oth=
er_
> =09=09=09=09| _way_ _around_!
> http://www.ozlabs.org/~dgibson
>=20


