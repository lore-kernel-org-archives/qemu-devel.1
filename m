Received: from eggs.gnu.org ([2001:4830:134:3::10]:40696)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ebischoff@nerim.net>) id 1ci1PB-0008N0-2t
	for qemu-devel@nongnu.org; Sun, 26 Feb 2017 11:10:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ebischoff@nerim.net>) id 1ci1P7-0000Sm-U5
	for qemu-devel@nongnu.org; Sun, 26 Feb 2017 11:10:37 -0500
Received: from smtp-150-sunday.nerim.net ([194.79.134.150]:14727
	helo=maiev.nerim.net) by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ebischoff@nerim.net>) id 1ci1P7-0000R4-NP
	for qemu-devel@nongnu.org; Sun, 26 Feb 2017 11:10:33 -0500
From: =?ISO-8859-1?Q?=C9ric?= Bischoff <ebischoff@nerim.net>
Date: Sun, 26 Feb 2017 17:10:28 +0100
Message-ID: <1599197.qxnXlczcy2@eric>
In-Reply-To: <a26cf735-bbb6-5be7-7575-198ec55a3ecc@twiddle.net>
References: <20170223115805.16688-1-ebischoff@suse.com>
	<20170223115805.16688-2-ebischoff@suse.com>
	<a26cf735-bbb6-5be7-7575-198ec55a3ecc@twiddle.net>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
Subject: Re: [Qemu-devel] [PATCH] Adding support for LPD and LPDG
 instructions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>
Cc: Alexander Graf <agraf@suse.de>, Michal Marek <mmarek@suse.cz>, Miroslav Benes <mbenes@suse.cz>, QEmu developers <qemu-devel@nongnu.org>

Le samedi 25 f=E9vrier 2017, 10:42:43 CET Richard Henderson a =E9crit :
> On 02/23/2017 10:58 PM, Eric Bischoff wrote:
> > +/* LOAD PAIR DISJOINT */
> > +    C(0xc804, LPD,     SSF,   ILA, m1_32s, m2_32s, 0, r3_P32, movx, 0)
> > +    C(0xc805, LPDG,    SSF,   ILA, m1_64, m2_64, 0, r3_P64, movx, 0)
>=20
> Missing is the update to the condition codes.
> I think just setting CC =3D 3 (not loaded interlocked) is probably fine.

Hi Richard,


thanks a lot for the feedback.

When trying on real hardware, I was always getting CC =3D=3D 0 (loaded=20
interlocked). It seems to be the usual and simplest case, where fetch was=20
immediately succesful.

Case CC =3D=3D 3 makes it needed to use a loop:

       2. When the resulting condition code is 3, the pro-
          gram may branch back to reexecute the LOAD
          PAIR DISJOINT instruction. However, after
          repeated unsuccessful attempts to attain an
          interlocked fetch, the program should use an
          alternate means of serializing access to the stor-
          age operands. It is recommended that the pro-
          gram reexecute the LOAD PAIR DISJOINT no
          more than 10 times before branching to the alter-
          nate path.

Therefore I think that setting CC =3D 0 is the correct emulation.

I assumed that putting 0 in last column of C() macro was the way to set CC =
=3D=20
0. I apologize if that was wrong, and if so, please tell me, and I'll corre=
ct.


Best,

=2D-=20
=C9ric Bischoff
