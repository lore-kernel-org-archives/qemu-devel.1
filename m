Received: from eggs.gnu.org ([2001:4830:134:3::10]:58078)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Andrew.Baumann@microsoft.com>) id 1dZifk-0006V8-2h
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 15:05:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Andrew.Baumann@microsoft.com>) id 1dZifg-0000Br-NZ
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 15:05:40 -0400
From: Andrew Baumann <Andrew.Baumann@microsoft.com>
Date: Mon, 24 Jul 2017 19:05:33 +0000
Message-ID: <DM2PR21MB0060EFC1F6B9F0883A1792369EBB0@DM2PR21MB0060.namprd21.prod.outlook.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Qemu-devel] Torn read/write possible on aarch64/x86-64 MTTCG?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>
Cc: Andrey Shedel <ashedel@microsoft.com>

Hi all,

I'm trying to track down what appears to be a translation bug in either the=
 aarch64 target or x86_64 TCG (in multithreaded mode). The symptoms are ent=
irely consistent with a torn read/write -- that is, a 64-bit load or store =
that was translated to two 32-bit loads and stores -- but that's obviously =
not what happens in the common path through the translation for this code, =
so I'm wondering: are there any cases in which qemu will split a 64-bit mem=
ory access into two 32-bit accesses?

The code:
Guest CPU A writes a 64-bit value to an aligned memory location that was pr=
eviously 0, using a regular store; e.g.:
	f9000034 str         x20,[x1]

Guest CPU B (who is busy-waiting) reads a value from the same location:
	f9400280 ldr         x0,[x20]

The symptom:
CPU B loads a value that is neither NULL nor the value written. Instead, x0=
 gets only the low 32-bits of the value written (high bits are all zero). B=
y the time this value is dereferenced (a few instructions later) and the ex=
ception handlers run, the memory location from which it was loaded has the =
correct 64-bit value with a non-zero upper half.

Obviously on a real ARM memory barriers are critical, and indeed the code h=
as such barriers in it, but I'm assuming that any possible mistranslation o=
f the barriers is irrelevant because for a 64-bit load and a 64-bit store y=
ou should get all or nothing. Other clues that may be relevant: the code is=
 _near_ a LDREX/STREX pair (the busy-waiting is used to resolve a race when=
 updating another variable), and the busy-wait loop has a yield instruction=
 in it (although those appear to be no-ops with MTTCG).

The bug repros more easily with more guest VCPUs, and more load on the host=
 (i.e. more context switching to expose the race). It doesn't repro for the=
 single-threaded TCG. Unfortunately it's hard to get detailed trace informa=
tion, because the bug only repros roughly every one in 40 attempts, and it'=
s a long way into the guest OS boot before it arises.

I'm not yet 100% convinced this is a qemu bug -- the obvious path through t=
he translator for those instructions does 64-bit memory accesses on the hos=
t -- but at the same time, it has never been seen outside qemu, and after s=
taring long and hard at the guest code, we're pretty sure it's correct. It'=
s also extremely unlikely to be a wild write, given that it occurs on a wid=
e variety of guest call-stacks, and the memory is later inconsistent with w=
hat was loaded.

Any clues or debugging suggestions appreciated!

Thanks,
Andrew
