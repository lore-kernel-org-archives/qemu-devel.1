Received: from eggs.gnu.org ([2001:4830:134:3::10]:44206)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wlosh@bsdimp.com>) id 1fBQXN-0002EK-J5
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 15:57:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wlosh@bsdimp.com>) id 1fBQXK-0000q7-GK
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 15:57:09 -0400
Received: from mail-pg0-x235.google.com ([2607:f8b0:400e:c05::235]:43132)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <wlosh@bsdimp.com>) id 1fBQXK-0000pi-5U
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 15:57:06 -0400
Received: by mail-pg0-x235.google.com with SMTP id f132so14071897pgc.10
	for <qemu-devel@nongnu.org>; Wed, 25 Apr 2018 12:57:05 -0700 (PDT)
Received: from [10.178.207.100] ([192.55.54.60])
	by smtp.gmail.com with ESMTPSA id
	z125sm33374971pfz.163.2018.04.25.12.57.02 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 25 Apr 2018 12:57:03 -0700 (PDT)
Sender: Warner Losh <wlosh@bsdimp.com>
From: Warner Losh <imp@bsdimp.com>
Content-Type: text/plain;
	charset=utf-8
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 11.3 \(3445.6.18\))
Message-Id: <AFF77CBF-01EC-494F-AA9C-9820F368EA32@gmail.com>
Date: Wed, 25 Apr 2018 13:57:01 -0600
Subject: [Qemu-devel] Large patch set advice
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Greetings,

I=E2=80=99ve foolishly volunteered to rebase all the changes that the =
bad-user mode folks have done to a recent master rev to get these =
changes upstreamed. A number of people have been working on this for a =
long time. It=E2=80=99s possible now to run almost any FreeBSD binary =
from all the architectures. We use it to do =E2=80=98native=E2=80=99 =
builds of tens of thousands of packages in a chroot (so building =
FreeBSD/arm packages on a FreeBSD amd64 box). The diffs are quite large =
(on the order of 42k lines), so I anticipate some bumps in moving this =
stuff upstream.

I=E2=80=99ve read through the Qemu patch submission material and have =
been contributing to FreeBSD for the last 20 years or so, so I have a =
notion of proper patch size. I=E2=80=99m half way through rebasing and =
curating the branch. Before I =E2=80=9Cfinish=E2=80=9D I thought I=E2=80=99=
d ask for some advise. I=E2=80=99m not the primary author of most of =
this stuff: it=E2=80=99s been accumulating for the past 4 years as =
different people come and go on the project...

Every Open Source project has its own quirks. Nobody wants the 520 =
commits on the branch that I started with (too many merged rather than =
rebases in the last 5 years). The 320 real commits are a mess. I=E2=80=99v=
e been preening them to get rid of the silly stuff like (back this out, =
put it back, all the =E2=80=98spelling/typo/white space=E2=80=99 fixes). =
At the end of the rebase, I still wasn=E2=80=99t to =E2=80=98the same=E2=80=
=99 so I had a bunch of =E2=80=98true up=E2=80=99 commits to make it the =
same...

So as with everything that=E2=80=99s developed over time, the early =
patches no longer are bistable because there=E2=80=99s later patches =
that fix the old APIs that were current at the start of the project to =
use newer APIs. That=E2=80=99s true both on the FreeBSD side as well as =
the Qemu side. Add to the mix that the original code was done by user X, =
and the fix by user Y (and sometimes Z and W, though the paper trail is =
unclear and W may just be who reported it).

Oh, and the number of SoBs in the original code is somewhat lacking. A =
tedious detail I need to chase down independent of all the other stuff.

So, there=E2=80=99s a bunch of changes at first to un-if-def-ify main.c, =
elfload.c and others to keep the MD code separate from the MI code. =
There=E2=80=99s a bunch of changes to implement this batch of system =
calls, or that batch. There=E2=80=99s some patches to implement PowerPC =
and then more to finish some architectures. Plus the above mentioned API =
chasing...

My first question seems almost rhetorical: that=E2=80=99s not an =
acceptable state of affairs, and curation is needed to upstream. Right?

My curation plans:

(1) Find where each of the bits of my =E2=80=98true up=E2=80=99 commits =
at the end are needed and to merge those bits back to those commits =
(I=E2=80=99m guessing it=E2=80=99s due to conflicts, or false conflict =
detection in git=E2=80=99s merging logic, since it was 4 hours and there =
attepts to get through the =E2=80=98git rebase -i master=E2=80=99 =
phase). These aren=E2=80=99t true changes anyway: just my screw up. Most =
of them are easy to find where they belong.

(2) back merge the API changes as best I can to as early in the stream =
as possible. One wrinkle here is that there=E2=80=99s a lot of code =
motion in the early patches to get the MI/MD stuff right, but even in =
the original commits, it never was very pure at all. And these changes =
are 2-3k lines long, but completely confined to bsd-user so maybe =
that=E2=80=99s OK. (I say completely, but sometimes there=E2=80=99s this =
or that thing added to a Makefile).

(3) Keep the classes of syscall implementation commits separate, but =
merge back the API and/or related new syscalls that were added. It=E2=80=99=
s a tradeoff between having 200 diffs that are minnows and 20 diffs that =
are related schools of fish vs one huge whale that=E2=80=99s just too =
big.

(4) Deal with the cases where multiple people have worked on a patch by =
putting SoBs for all of them (or reworking them if I can=E2=80=99t get a =
hold of the original authors) on the commits that are merged. I didn=E2=80=
=99t see a specific policy for this, but this seems sane. The =
alternative seems worse (having elements that don=E2=80=99t compile)

(5) Send them in small batches. I=E2=80=99d go insane trying to manage =
200 concurrent code reviews, and I can=E2=80=99t image that I=E2=80=99m =
unique in this. I also image that fixes in the early part of the series =
may have ripples to the later parts if my past experience with these =
things has any relevance.

Thanks for any help you can give me.

Warner Losh
imp@FreeSBD.org

P.S. Yes, I get that we should have been more engaged all along.=
