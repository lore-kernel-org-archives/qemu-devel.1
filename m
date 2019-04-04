Received: from eggs.gnu.org ([209.51.188.92]:36493)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jan.bobek@gmail.com>) id 1hC6lp-0006Y6-Nf
	for qemu-devel@nongnu.org; Thu, 04 Apr 2019 14:07:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jan.bobek@gmail.com>) id 1hC6ln-0001b1-CK
	for qemu-devel@nongnu.org; Thu, 04 Apr 2019 14:07:25 -0400
Received: from mail-yb1-xb2c.google.com ([2607:f8b0:4864:20::b2c]:34780)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jan.bobek@gmail.com>) id 1hC6lm-0001Z8-Sc
	for qemu-devel@nongnu.org; Thu, 04 Apr 2019 14:07:23 -0400
Received: by mail-yb1-xb2c.google.com with SMTP id c2so1388391ybn.1
	for <qemu-devel@nongnu.org>; Thu, 04 Apr 2019 11:07:22 -0700 (PDT)
Received: from [128.61.9.21] (lawn-128-61-9-21.lawn.gatech.edu. [128.61.9.21])
	by smtp.googlemail.com with ESMTPSA id
	207sm6631646ywv.9.2019.04.04.11.07.19 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 04 Apr 2019 11:07:20 -0700 (PDT)
From: Jan Bobek <jan.bobek@gmail.com>
Message-ID: <2e81098f-dfcb-9893-c62e-9ed1e3101b24@gmail.com>
Date: Thu, 4 Apr 2019 14:07:04 -0400
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature";
	boundary="Lb0FpLeVbZG7a8m7WKJJPDyir26aybOFI"
Subject: [Qemu-devel] [GSOC] Support for AVX within TCG
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Lb0FpLeVbZG7a8m7WKJJPDyir26aybOFI
From: Jan Bobek <jan.bobek@gmail.com>
To: qemu-devel@nongnu.org
Message-ID: <2e81098f-dfcb-9893-c62e-9ed1e3101b24@gmail.com>
Subject: [GSOC] Support for AVX within TCG
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi everyone!

My name is Jan Bobek, I am a graduate student at Georgia Institute of
Technology (Atlanta, GA), currently finishing the first year of
M.S. program in Computer Science (Computing Systems).

I would like to announce that I will be submitting a QEMU project
proposal to this year's Google Summer of Code to try and improve the
current state of AVX instruction support in the x86 TCG front-ent.
You can find the proposal draft at the end of this email.

The reason I am sending out this email on qemu-devel is to ask
everyone for comments, suggestions, and feedback in general. All input
is greatly appreciated! You can reply to this email, reach me on IRC
(nick "jbobek"), or you can leave a comment in the Google Doc that
Google had me set up for this application:

https://docs.google.com/document/d/1XGz-wjHYp3B6s08FCE5XGfn7zuUIoScoWD6WD=
Jjcmok/edit

You will find more information about the project and about me in the
proposal draft.

Once again, thanks for reading this email and for all feedback that
you might provide.

Cheers,
-Jan Bobek

----

GSOC PROJECT PROPOSAL (PUBLIC DRAFT)

TITLE: Support for AVX within TCG
DATE: 04/04/2019
PROPOSER: Jan Bobek <jan.bobek@gmail.com>
MENTOR: Richard Henderson <richard.henderson@linaro.org>

1. ABSTRACT

(Taken from [1] with negligible modifications, originally written by
Nick Renieris / Richard Henderson.)

QEMU's TCG just-in-time compiler translates target CPU instructions
into host CPU instructions so that programs written for other CPU
architectures can be run on any host. Modern CPUs feature vector
processing instructions, sometimes called Single Instruction Multiple
Data (SIMD) instructions, which perform the same operation on multiple
data elements at once. Intel's SSE and AVX instruction set extensions
were introduced for x86 CPUs for this purpose.

The target/i386 front-end has support for TCG emulation of SSE4.2, but
does not feature support for later vector extensions, such as AVX. The
goal of the proposed project is to implement and test AVX instructions
that are currently not implemented in QEMU's TCG.

2. PROPOSED APPROACH

This proposal splits the project into three separate tasks, which
shall be completed in sequence as listed below.

2.1. Build an acceptance test suite for MMX / SSE / AVX instructions

As far as x86 SIMD extensions are concerned, current QEMU codebase
only includes a single TCG testcase, located in
tests/tcg/i386/test-i386-ssse3.c. As the first step, it is proposed
that a suite of tests exercising all instructions from the MMX / SSE /
AVX SIMD extensions is built. RISU [8] may serve as a suitable
starting point for this task (thanks to Alex Benn=C3=A9e for the
suggestion).

Finishing this task first poses three advantages:

- it can serve as a simple enough task to get well acquainted with
  the QEMU codebase and the overall patch contribution process,

- it assures the project has well-defined acceptance criteria right
  from the start, and

- test failures will clearly show the code flow paths which need to
  be adjusted in order to support the newer SIMD extensions.

2.2. Port the existing MMX / SSE code to the TCG gvec infrastructure

Current i386 TCG front-end appears to consist of mostly legacy code
and takes no advantage of the extended vectorization support provided
by the generic vector (a.k.a. gvec) TCG infrastructure, described in
e.g. [2].

Most of the legacy SSE code in question resides in
target/i386/{ops_sse_header.h,ops_sse.h}; some good examples of gvec
usage can be found e.g. in accel/tcg/tcg-runtime-gvec.c or the ARM
front-end (target/arm/{translate-sve.c,vec_helper.c}). General
approach to the port has been outlined by Richard Henderson earlier on
the qemu-devel mailing list [3].

This part of the project is expected to be the most time-consuming.

2.3. Extend the i386 instruction decoder with support for AVX
     extensions

AVX (AVX2, AVX-512) SIMD instructions are encoded using the (E)VEX
prefix. There already exists (some) logic in the i386 instruction
decoder (target/i386/translate.c) for decoding it; however, this logic
needs to be extended to account for greater vector lengths. (The
acceptability tests outlined above should be helpful in narrowing down
parts of the instruction decoder which need to be expanded.)

Additionally, care must be taken to correctly implement differences
between legacy and VEX-encoded SIMD instructions (as pointed out by
R.H. in [3]).

Since AVX2 / AVX-512 instructions are generally extensions of MMX /
SSE / AVX instructions to greater vector lengths, it should be
possible to leverage the gvec infrastructure and get implementation of
these SIMD extensions by simply increasing the corresponding vector
length parameter (also pointed out in [3]).

3. PROPOSED SCHEDULE

The proposed schedule for the three tasks outlined above is as
follows:

| WK # | From  | To    | Proposed task | GSoC stage          |
|------+-------+-------+---------------+---------------------|
| WK22 | 05/27 | 05/31 | Test suite    | Coding begins       |
| WK23 | 06/03 | 06/07 | Test suite    |                     |
| WK24 | 06/10 | 06/14 | (transition)  |                     |
| WK25 | 06/17 | 06/21 | SSE refactor  |                     |
| WK26 | 06/24 | 06/28 | SSE refactor  | Phase 1 Evaluations |
| WK27 | 07/01 | 07/05 | SSE refactor  |                     |
| WK28 | 07/08 | 07/12 | SSE refactor  |                     |
| WK29 | 07/15 | 07/19 | SSE refactor  |                     |
| WK30 | 07/22 | 07/26 | (transition)  | Phase 2 Evaluations |
| WK31 | 07/29 | 08/02 | AVX decode    |                     |
| WK32 | 08/05 | 08/09 | AVX decode    |                     |
| WK33 | 08/12 | 08/16 | AVX decode    |                     |
| WK34 | 08/19 | 08/26 | (buffer)      | Final deadline      |

05/27
  Coding begins

05/27--06/14 (calendar wk. 22--24)
  Build an acceptance test suite for MMX / SSE / AVX instructions

06/10--07/26 (calendar wk. 24--30)
  Port the existing MMX / SSE code to the TCG gvec infrastructure

06/24--06/28 (calendar wk. 26)
  Phase 1 Evaluations

07/22--07/26 (calendar wk. 30)
  Phase 2 Evaluations

07/22--08/16 (calendar wk. 30--33)
  Extend the i386 instruction decoder with support for AVX extensions

08/19--08/26 (calendar wk. 34)
  Reserve / buffer week
  Final deliverables and evaluation deadline

Weeks 24 and 30 are allocated as transition weeks and are factored
into both the preceding and the following task; week 34 (the last
week) is left unallocated as a reserve.

4. APPLICANT DETAILS

4.1. Motivation

4.1.1. Why FOSS?

In short, I (Jan Bobek) believe in both practical and moral
superiority of FOSS over closed-source and proprietary software. I
have had the chance to work on a project both in the OSS world and the
corporate proprietary world in the past, and the mentality of OSS and
the surrounding community is simply something that is closer to my
heart and to what I feel is right.

Philosophical aspects aside, I believe the OSS model (eventually)
produces better software for the same reasons that knowledge sharing
and peer reviews produce better research: a group of individuals who
coordinate, collaborate, share and criticize each other's ideas will
eventually achieve results and goals that none of them could achieve
on their own; the larger and more diverse this group is, the better.

4.1.2. Why QEMU?

QEMU, and TCG in particular aligns very well with my professional
interests; besides systems programming, they are cybersecurity,
reverse engineering and binary analysis, cryptography, programming
languages and compilers, and recently formal verification.

Apart from that, QEMU is obviously a very well-known and important OSS
project, and I would be highly honored by being given the opportunity
to contribute my code to it.

4.2. Previous open-source contributions

Back when I was in high school (2008--2012), I had the incredible
opportunity to regularly contribute to an open-source project called
EVEmu [4], a project dedicated to developing a server emulator for a
sci-fi MMORPG called EVE Online, made by CCP Games. For a certain
period of time, I was even one of the main developers, and I have very
fond memories of those years. Unfortunately, I was unable to continue
contributing after I entered college in Fall 2012.

4.3. Other relevant experience

I hold a B.S. degree in Theoretical Computer Science from the Czech
Technical University in Prague, so I have taken classes on computer
architecture, formal languages, compilers etc. In particular, my
classmate and I have used SSE / AVX instructions in a class project to
increase throughput of a simple n-body simulator [5], and I have also
created a simple GCC front-end for parsing a subset of Pascal [6].
Apart from these, I have also taken an elective on x86 assembly and
two electives on reverse engineering / binary analysis.

I am an avid Debian user: I have been using Debian as my main
workstation OS for ~8 years, for development and everything else. As
such, I have plenty of experience with Unix-based development (GCC,
GDB, Valgrind, CMake, Python, Bash, Emacs).

More details about my qualifications can be found on my LinkedIn
profile [7].

5. REFERENCES

[1] https://wiki.qemu.org/Google_Summer_of_Code_2019#AVX
[2] "[2017] Vectoring in on QEMU's TCG Engine by Alex Benn=C3=A9e",
    available online at https://www.youtube.com/watch?v=3DIYHTwnde0g8
[3] http://lists.nongnu.org/archive/html/qemu-devel/2018-12/msg06250.html=

[4] https://github.com/evemuproject/evemu_server
[5] https://github.com/MatejNikl/nbody
[6] https://github.com/bobekjan/pjp-gcc-sfe
[7] https://www.linkedin.com/in/jan-bobek-0544b7119
[8] http://git.linaro.org/people/peter.maydell/risu.git/


--Lb0FpLeVbZG7a8m7WKJJPDyir26aybOFI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEESPYOqtMR3qRZrEutZeg2ldrjNs8FAlymR80ACgkQZeg2ldrj
Ns/OeQ/9EvRJHb7oG7Niti6UxLE+u87Uo16Js5hHnvNuyhBZ6Nh5/DWMLypqy7IB
W8QcB4dXPM5HBjZLRu4EWxP4oveo+FhDnCEVOTHF9BHh5r0+yBhDPefUtAymjgmX
nJmTOkV8LX9XMINv2LjiXWrE7cfB5cPuQMOVSink9p3cWhbGl589JMJLk28319gI
4FgWUzzvrxfA58iJlsUoL12l0YVbX66Jk8J3eOttJTd6DEtrUqMo9aiac5RHkxWy
G1XrUAMVtmbJe82J0J2qvIZWgcqNnmrME6eEL50SWqmPar4OswcY5rKdaUav+pF0
vpmmjTxbYd1E+B4cOTKdmNou8nPzrIpuFC9SdHrtuheQnFxwkVr39yQSoqQgotnl
9iu/LW1/Z5PVmQk+NxTl5xN8i1tNAcb2XoFTZ01yO41ofMtqbifHDsIWE7ooZBB7
nNT8PSe7BYj8zYe0P3e9G4QOR6AoZflnm1KLxVFHxOklsduUWfgXJEo4i9S09Jui
pdn6QqNZ6bitb8SGRCE9xx3gsvhckL1338zjh2dqVQaqSeh1ZiNZnx87sf/xrx8u
IvIiaeQzGSqVwEveBr72UKk3t3HMPFu6HfvdRgoCGfpHiXZM3aA0SzJ2YWBTiYuq
5iG9vnic4YJdzKl8nEbCAwDJ+ZDgs5ntOGdsHM5yiBeHt8S5Drk=
=5RXt
-----END PGP SIGNATURE-----

--Lb0FpLeVbZG7a8m7WKJJPDyir26aybOFI--
