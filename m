Received: from eggs.gnu.org ([2001:4830:134:3::10]:40627)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eZT4n-0000zQ-1e
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 21:58:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eZT4l-00059a-RO
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 21:58:45 -0500
Date: Thu, 11 Jan 2018 13:44:45 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180111024445.GE24770@umbus.fritz.box>
References: <16658597.jA1MYeglPg@wirbelwind>
	<CAFEAcA_V9LRUCk+nq_kz8jC8yCQSgNbV0gdGFu+CFLWsbxh=xA@mail.gmail.com>
	<3719059.PceeUxPRNs@wirbelwind>
	<CAFEAcA-8WufG_RSvra9v-Y_3qem0aDPQBg1KAMr6x6kMJgCHtA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="7CZp05NP8/gJM8Cl"
Content-Disposition: inline
In-Reply-To: <CAFEAcA-8WufG_RSvra9v-Y_3qem0aDPQBg1KAMr6x6kMJgCHtA@mail.gmail.com>
Subject: Re: [Qemu-devel] [Qemu-discuss] ppc and icount
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: steven.seeger@flightsystems.net, qemu-discuss <qemu-discuss@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, qemu-ppc@nongnu.org, Alexander Graf <agraf@suse.de>, Richard Purdie <richard.purdie@linuxfoundation.org>, Richard Henderson <rth@twiddle.net>


--7CZp05NP8/gJM8Cl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 10, 2018 at 10:34:18AM +0000, Peter Maydell wrote:
> On 10 January 2018 at 08:57, Steven Seeger
> <steven.seeger@flightsystems.net> wrote:
> > Sorry for another post. I did a bisect and found what is the bad commit=
 for
> > me:
> >
> > 044897ef4a22af89aecb8df509477beba0a2e0ce is the first bad commit
> > commit 044897ef4a22af89aecb8df509477beba0a2e0ce
> > Author: Richard Purdie <richard.purdie@linuxfoundation.org>
> > Date:   Mon Dec 4 22:25:43 2017 +0000
> >
> >     target/ppc: Fix system lockups caused by interrupt_request state
> > corruption
>=20
> Great -- thanks for the bisect. Let's take this to the -devel list;
> I've cc'd the PPC maintainers.
>=20
> Context: Steven reports that we broke -icount for PPC guests with
> this commit:
>=20
> $ ./build/all/ppc-softmmu/qemu-system-ppc  -icount auto
> qemu: fatal: Raised interrupt while not in I/O function
> NIP fff08978   LR fff08904 CTR 00000000 XER 00000000 CPU#0
> MSR 00000000 HID0 00000000  HF 00000000 iidx 3 didx 3
> Bad icount read
>=20
> The backtrace from the assert is:
>=20
> #0  tcg_handle_interrupt (cpu=3D0x7ffff7fc2010, mask=3D4) at qemu/accel/t=
cg/tcg-
> all.c:58
> #1  0x0000555555962aa4 in cpu_interrupt (cpu=3D0x7ffff7fc2010, mask=3D4) =
at qemu/
> include/qom/cpu.h:859
> #2  0x0000555555962e55 in cpu_interrupt_exittb (cs=3D0x7ffff7fc2010) at q=
emu/
> target/ppc/helper_regs.h:105
> #3  0x0000555555964505 in do_rfi (env=3D0x7ffff7fca2b0, nip=3D197460, msr=
=3D4096)
>     at qemu/target/ppc/excp_helper.c:998
> #4  0x0000555555964555 in helper_rfi (env=3D0x7ffff7fca2b0) at qemu/targe=
t/ppc/
> excp_helper.c:1008
> #5  0x00007fffe7c124b9 in code_gen_buffer ()
>=20
> The problem is that icount was relying on the previous
> handling of do_rfi() as "just set state as we know we're
> going to be last insn in the TB".
>=20
> Not sure how best to fix this (mark the insn as IO ok?)

Aw, man.  I've become target-ppc tcg maintainer by default, but tbh my
knowledge wasn't really deep enough to understand the problem that
044897ef was fixing in the first place.  And I barely know what icount
does at all.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--7CZp05NP8/gJM8Cl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlpWz5oACgkQbDjKyiDZ
s5IO9Q//W1qYqnCq2+AQ7il+sN7UchD8yueaA/PKZFMfDK8HmtpZmk4Gua91ZoFc
cWj/HjjF5inhb8SVZnADk8W4eAN/wF+dAYuJw06+Y2JNKqwYKLukvXWiO4S0ikF5
HMLogqhePcOXwBQx7qtF+u9Fzb+Fl/8DDR5EUhZ4mFUZne93SZIAy2x40Go/qyO0
fimeZnJQ3xXzC5KIdai/LfnHjNnXklwj0bVnBlApa4d93oOUvbbnvAL80oTM6n2R
4HsoiVPQ4Z+xc+h/BBIhQ8cnZGRLspN0C0K//mVaHXdL7s9Owdb67esLUupMj/I3
6iC1DLQZYd5twdcgZf83z+x+wMtIacgDr/xW98SpLo7Nsqf3V3kS0ElaRIxyb+oW
/3aMBz7hSBGk1L1uRHVtaR2LAXjqGZ5wfZEqwI3XFBNBJJR5gCcUi4PEw89w+hgQ
+w0gD3wje3cAxA/qluXkZ52a9EQxhuQ1bMQixLm+ESXkOv+XqifMO+s6F46nG44n
2XDxRnCcNfrQ8DM+cZtmfYURCA+sulMQ3fWMeVgpEzNuOa/BR27B0EIb/A19G2fE
ae3yHhpgXAqRq92TSbwTHcupXWMOVurIJVUAtPnyKZimz9lxQSAD/IqeeUXoxL92
VYDc/ZWTlG4bUE1WIDCW05SsNtRbscOTFsotthV226Hc9mo6KxE=
=LsS7
-----END PGP SIGNATURE-----

--7CZp05NP8/gJM8Cl--
