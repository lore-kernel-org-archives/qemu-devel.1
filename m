Received: from eggs.gnu.org ([2001:4830:134:3::10]:47987)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1etXyb-0001c9-Cz
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 07:15:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1etXya-0003v3-67
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 07:15:21 -0500
Received: from mail-oi0-x22c.google.com ([2607:f8b0:4003:c06::22c]:45638)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mjc@sifive.com>) id 1etXyZ-0003uo-Ue
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 07:15:20 -0500
Received: by mail-oi0-x22c.google.com with SMTP id j79so1468859oib.12
	for <qemu-devel@nongnu.org>; Wed, 07 Mar 2018 04:15:19 -0800 (PST)
MIME-Version: 1.0
References: <1520365586-30384-1-git-send-email-mjc@sifive.com>
	<CAHNT7NsMoYNNXyPPqWaDD4op8vtQAZGHKnjWtpTpb8xv80CaUg@mail.gmail.com>
	<20180307101139.GK2787@redhat.com>
In-Reply-To: <20180307101139.GK2787@redhat.com>
From: Michael Clark <mjc@sifive.com>
Date: Wed, 07 Mar 2018 12:15:08 +0000
Message-ID: <CAHNT7Nu_3nhd9FDGt-HHTHbGZ-zV=Mms+gnCpy_bKiX3MKj8Pw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL] RISC-V QEMU Port Submission v8.2
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Richard W.M. Jones" <rjones@redhat.com>
Cc: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Palmer Dabbelt <palmer@sifive.com>, QEMU Developers <qemu-devel@nongnu.org>, RISC-V Patches <patches@groups.riscv.org>, Sagar Karandikar <sagark@eecs.berkeley.edu>

On Wed, 7 Mar 2018 at 11:11 PM, Richard W.M. Jones <rjones@redhat.com>
wrote:

> On Wed, Mar 07, 2018 at 01:09:29PM +1300, Michael Clark wrote:
> > Hopefully, this PR gets merged...
>
> I hope so too.  We've been testing v8 (substantially the same as v8.2)
> extensively, including SMP.  It's building hundreds of packages a day
> in the autobuilder, and being used for manual builds by several
> people.
>
> Please don't forget about the softfloat fix!  Although it's not
> specific to riscv-qemu, it is required for reliable operation and I
> don't see if in the v8.2 tree.


I=E2=80=99ll try to get it in. I=E2=80=99ve reviewed the new minmax code an=
d it should not
be difficult to add IEEE-754 201x minimumNumber/maximumNumber. I just ran
out of time today.

It=E2=80=99s a relatively rare corner case where the RISC-V behaviour is di=
fferent
when an sNaN operand and a valid operand are provided to fmin/fmax. The
IEEE-754 201x minimumNumber/maximumNumber always returns the valid operand
when passed anyNaN and a valid operand however an sNaN operand causes the
invalid flag to be raised, whereas iirc the IEEE-764 2008 minNum/maxNum
will raise the invalid flag and return the sNaN when one operand is an sNaN
and the other is valid. Both of their behaviours are the same when passed
qNaN and a valid operand.

I have the test suite which includes both signalling and quiet NaN
fmin/fmax test cases so it is easy to verify and RISC-V is the only QEMU
port to use the IEEE-754 201x  minimumNumber/maximumNumber semantics so we
can easily isolate and test the change without affecting existing code.

Michael
