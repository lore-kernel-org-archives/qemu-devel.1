Received: from eggs.gnu.org ([2001:4830:134:3::10]:48610)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <knut.omang@oracle.com>) id 1defJA-0000hN-Bb
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 06:30:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <knut.omang@oracle.com>) id 1defJ6-00015t-7Z
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 06:30:48 -0400
Received: from userp1040.oracle.com ([156.151.31.81]:27346)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <knut.omang@oracle.com>)
	id 1defJ5-00015h-JF
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 06:30:44 -0400
Message-ID: <1502101838.3624.8.camel@oracle.com>
From: Knut Omang <knut.omang@oracle.com>
Date: Mon, 07 Aug 2017 12:30:38 +0200
In-Reply-To: <20170807102729.GG18259@redhat.com>
References: <cover.14d7e60ae019b1418a70bacc4e7d240fadf9c96c.1501362828.git-series.knut.omang@oracle.com>
	<7c4ddf95a57f7dfa546c11f8a08a9091b8bd1ceb.1501362828.git-series.knut.omang@oracle.com>
	<20170807084524.GF18259@redhat.com>
	<1502097685.3624.6.camel@oracle.com>
	<20170807102729.GG18259@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v6 1/4] tests: Add test-listen - a stress
 test for QEMU socket listen
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org

On Mon, 2017-08-07 at 11:27 +0100, Daniel P. Berrange wrote:
> On Mon, Aug 07, 2017 at 11:21:25AM +0200, Knut Omang wrote:
> > On Mon, 2017-08-07 at 09:45 +0100, Daniel P. Berrange wrote:
> > > On Sat, Jul 29, 2017 at 11:18:15PM +0200, Knut Omang wrote:
> > > > There's a potential race condition between multiple bind()'s
> > > > attempting to bind to the same port, which occasionally
> > > > allows more than one bind to succeed against the same port.
> > > >=20
> > > > When a subsequent listen() call is made with the same socket
> > > > only one will succeed.
> > > >=20
> > > > The current QEMU code does however not take this situation into acc=
ount
> > > > and the listen will cause the code to break out and fail even
> > > > when there are actually available ports to use.
> > > >=20
> > > > This test exposes two subtests:
> > > >=20
> > > > /socket/listen-serial
> > > > /socket/listen-compete
> > > >=20
> > > > The "compete" subtest creates a number of threads and have them all=
 trying to bind
> > > > to the same port with a large enough offset input to
> > > > allow all threads to get it's own port.
> > > > The "serial" subtest just does the same, except in series in a
> > > > single thread.
> > > >=20
> > > > The serial version passes, probably in most versions of QEMU.
> > > >=20
> > > > The parallel version exposes the problem in a relatively reliable w=
ay,
> > > > eg. it fails a majority of times, but not with a 100% rate, occasio=
nal
> > > > passes can be seen. Nevertheless this is quite good given that
> > > > the bug was tricky to reproduce and has been left undetected for
> > > > a while.
> > > >=20
> > > > The problem seems to be present in all versions of QEMU.
> > > >=20
> > > > The original failure scenario occurred with VNC port allocation
> > > > in a traditional Xen based build, in different code
> > > > but with similar functionality.
> > > >=20
> > > > Reported-by: Bhavesh Davda <bhavesh.davda@oracle.com>
> > > > Signed-off-by: Knut Omang <knut.omang@oracle.com>
> > > > Reviewed-by: Yuval Shaia <yuval.shaia@oracle.com>
> > > > Reviewed-by: Bhavesh Davda <bhavesh.davda@oracle.com>
> > > > Reviewed-by: Girish Moodalbail <girish.moodalbail@oracle.com>
> > > > ---
> > > > =C2=A0tests/Makefile.include |=C2=A0=C2=A0=C2=A02 +-
> > > > =C2=A0tests/test-listen.c=C2=A0=C2=A0=C2=A0=C2=A0| 253 ++++++++++++=
++++++++++++++++++++++++++++++-
> > > > =C2=A02 files changed, 255 insertions(+)
> > > > =C2=A0create mode 100644 tests/test-listen.c
> > > >=20
> > > > diff --git a/tests/Makefile.include b/tests/Makefile.include
> > > > index 7af278d..b37c0c8 100644
> > > > --- a/tests/Makefile.include
> > > > +++ b/tests/Makefile.include
> > > > @@ -128,6 +128,7 @@ check-unit-y +=3D tests/test-bufferiszero$(EXES=
UF)
> > > > =C2=A0gcov-files-check-bufferiszero-y =3D util/bufferiszero.c
> > > > =C2=A0check-unit-y +=3D tests/test-uuid$(EXESUF)
> > > > =C2=A0check-unit-y +=3D tests/ptimer-test$(EXESUF)
> > > > +#check-unit-y +=3D tests/test-listen$(EXESUF)
> > > > =C2=A0gcov-files-ptimer-test-y =3D hw/core/ptimer.c
> > > > =C2=A0check-unit-y +=3D tests/test-qapi-util$(EXESUF)
> > > > =C2=A0gcov-files-test-qapi-util-y =3D qapi/qapi-util.c
> > > > @@ -769,6 +770,7 @@ tests/test-arm-mptimer$(EXESUF): tests/test-arm=
-mptimer.o
> > > > =C2=A0tests/test-qapi-util$(EXESUF): tests/test-qapi-util.o $(test-=
util-obj-y)
> > > > =C2=A0tests/numa-test$(EXESUF): tests/numa-test.o
> > > > =C2=A0tests/vmgenid-test$(EXESUF): tests/vmgenid-test.o tests/boot-=
sector.o tests/acpi-utils.o
> > > > +tests/test-listen$(EXESUF): tests/test-listen.o $(test-util-obj-y)
> > > > =C2=A0
> > > > =C2=A0tests/migration/stress$(EXESUF): tests/migration/stress.o
> > > > =C2=A0	$(call quiet-command, $(LINKPROG) -static -O3 $(PTHREAD_LIB)=
 -o $@ $< ,"LINK","$(TARGET_DIR)$@")
> > > > diff --git a/tests/test-listen.c b/tests/test-listen.c
> > > > new file mode 100644
> > > > index 0000000..5c07537
> > > > --- /dev/null
> > > > +++ b/tests/test-listen.c
> > > > @@ -0,0 +1,253 @@
> > > > +/*
> > > > + * Copyright (c) 2017, Oracle and/or its affiliates. All rights re=
served.
> > > > + *=C2=A0=C2=A0=C2=A0=C2=A0Author: Knut Omang <knut.omang@oracle.co=
m>
> > > > + *
> > > > + * This program is free software; you can redistribute it and/or m=
odify
> > > > + * it under the terms of the GNU General Public License version 2
> > > > + * as published by the Free Software Foundation.
> > >=20
> > > Can you change that to "version 2 or later" - per the LICENSE file, w=
e don't
> > > accept contributions under "version 2 only" except for 4 specific sub=
dirs:
> > >=20
> > >=20
> > > =C2=A0 "As of July 2013, contributions under version 2 of the GNU Gen=
eral Public
> > > =C2=A0=C2=A0=C2=A0License (and no later version) are only accepted fo=
r the following files
> > > =C2=A0=C2=A0=C2=A0or directories: bsd-user/, linux-user/, hw/vfio/, h=
w/xen/xen_pt*."
> >=20
> > Oh, sorry - I wasn't aware of this, +"...or later" is fine with me.
> > Would you like me to send a v7 of the set with only that change, or can=
 you amend=C2=A0
> > it as part of the merge?
>=20
> Since its a copyright statement, I'd prefer if you just sent a v7. I've n=
o
> other comments, so will queue it for merge once you resend, and send a pu=
ll
> request once 2.11 opens up.

Ok, will do,

Thanks,
Knut

> Regards,
> Daniel
