Received: from eggs.gnu.org ([209.51.188.92]:43704)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1gjpQe-0006vf-KA
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 12:56:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1gjpQc-0004Kz-IC
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 12:56:40 -0500
Received: from mail-eopbgr700094.outbound.protection.outlook.com
	([40.107.70.94]:41952
	helo=NAM04-SN1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <amarkovic@wavecomp.com>)
	id 1gjpQa-0004CE-IJ
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 12:56:38 -0500
From: Aleksandar Markovic <amarkovic@wavecomp.com>
Date: Wed, 16 Jan 2019 17:56:17 +0000
Message-ID: <BN6PR2201MB1251A3C6C43C6A1274406795C6820@BN6PR2201MB1251.namprd22.prod.outlook.com>
References: <20190114215225.GA16760@habkost.net>
	<CAL1e-=iBx0Dt=S5fyLs8v-XN+2Zmx5hb7StQBJhquUmmdw6uNA@mail.gmail.com>,
	<20190116153011.GB14807@habkost.net>
In-Reply-To: <20190116153011.GB14807@habkost.net>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] Meaning of "-smp threads" on mips_malta
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>, Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Aleksandar Rikalo <arikalo@wavecomp.com>, Stefan Markovic <smarkovic@wavecomp.com>, Aurelien Jarno <aurelien@aurel32.net>, Igor Mammedov <imammedo@redhat.com>

> From: Eduardo Habkost <ehabkost@redhat.com>
> Sent: Wednesday, January 16, 2019 4:30 PM
> To: Aleksandar Markovic
> Cc: qemu-devel@nongnu.org; Aleksandar Rikalo; Stefan Markovic; Aleksandar=
 Markovic; Aurelien > Jarno; Igor Mammedov
> Subject: Re: [Qemu-devel] Meaning of "-smp threads" on mips_malta
>=20
> On Tue, Jan 15, 2019 at 03:28:50AM +0100, Aleksandar Markovic wrote:
> > On Monday, January 14, 2019, Eduardo Habkost <ehabkost@redhat.com> wrot=
e:
> >
> > > Hi,
> > >
> > > I'm trying to refactor the SMP topology code in QEMU
> >
> >
> > >
> > Eduardo, I truly appreciate your interest in details of Malta
> > implementations, but before I answer your questions, could you please
> > outline the motivation and the current concept of your envisioned
> > refactoring of SMP, so that I have some picture of the whole context?
>=20
> I don't have any concrete plans right now.  I'm trying to
> understand how existing code uses the -smp options, before
> deciding what to do.
>=20
> My goal is to make features like
>   "[PATCH v1 0/5] Introduce cpu die topology and enable CPUID.1F for i386=
"
> easier, less intrusive, and less risky.
>=20
> My current impression is that things will be better if we move
> the complex PC-specific topology rules from vl.c to PC-specific
> code.  Most of the other architectures seem to have different
> assumptions and expectations about -smp/cores/threads.
>=20

Eduardo, thanks for giving me this background info and details.

I completely understand your concerns, and also frustration with the
current situation in the multi-core area of your (and many other)
platforms. What appears to be a simple thing suddenly becomes
a major issue - very annoying, isn't it?

Your observation on different assumptions and expectations
between targets in this area is so true.

I feel this topic deserves wider discussion, and I think we need better
possibilities and solutions for future endeavors across the board for
all targets, not only in your or mine case.

As for MIPS smp/threads combinations, they are valid, although truly
unusual, and this is because of certain MIPS-specific features of
so-called hardware multithreading and core virtualization, where a
core can present itself as multiple cores - even theoretically run
different OSs on such cores. The code snippet is very old by itself
(almost obsolete), since MIPS architecture meanwhile evolved, so
the code snippet is actually ripe for rewriting, but this is what we
have now, and I am against just throwing it away. I gather the
authors of the code did not have any better choice at the time
of writing.

Again, I am with you regarding your concerns. However, let's not
rush, let's not jump to quick conclusions. Let me think for a while,
try to come up with some suggestions that will make life easier
for both of us and hopefully for majority of the community.

Speak to you later, I'll be back soon, give me some time, and
thanks for bringing this to my (and everybody else's) attention.

Regards,
Aleksandar

>=20
> >
> > Sincerely, Aleksandar
> >
> >
> >
> > >
> > > and I found
> > > some suspicious code on mips_malta.c:
> > >
> > > static void malta_mips_config(MIPSCPU *cpu)
> > > {
> > >     CPUMIPSState *env =3D &cpu->env;
> > >     CPUState *cs =3D CPU(cpu);
> > >
> > >     env->mvp->CP0_MVPConf0 |=3D ((smp_cpus - 1) << CP0MVPC0_PVPE) |
> > >                          ((smp_cpus * cs->nr_threads - 1) << CP0MVPC0=
_PTC);
> > > }
> > >
> > >
> > > The (smp_cpus * cs->nr_threads) expression here doesn't make
> > > sense to me (because smp_cpus is already supposed to be a
> > > multiple of smp_threads), and seems to indicate that the code has
> > > some unusual assumptions about the semantics of the -smp option.
> > >
> > > So, I'd like to know: do all the examples below make sense for
> > > Malta?
> > >
> > >  -smp 1
> > >  -smp 2
> > >  -smp 2,threads=3D1
> > >  -smp 2,threads=3D2
> > >  -smp 1,threads=3D2 [*]
> > >  -smp 2,threads=3D3 [*]
> > >
> > > The generic -smp parsing code considers the last 2 entries
> > > above[*] to be invalid.  If they make sense for Malta, we need to
> > > find a way to fix that.  Replacing "-smp threads=3D..." with a
> > > "-cpu" or "-machine" option seems like the best alternative.
> > >
> > > --
> > > Eduardo
> > >
> > >
>=20
> --
> Eduardo
> =
