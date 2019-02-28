Received: from eggs.gnu.org ([209.51.188.92]:34105)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stephen.checkoway@oberlin.edu>) id 1gzPTC-0000ds-UZ
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 12:27:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stephen.checkoway@oberlin.edu>) id 1gzPKS-0004gL-RY
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 12:18:41 -0500
Received: from mail-it1-x12f.google.com ([2607:f8b0:4864:20::12f]:54715)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stephen.checkoway@oberlin.edu>)
	id 1gzPKS-0004f4-CO
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 12:18:40 -0500
Received: by mail-it1-x12f.google.com with SMTP id w18so15803193itj.4
	for <qemu-devel@nongnu.org>; Thu, 28 Feb 2019 09:18:40 -0800 (PST)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
From: Stephen Checkoway <stephen.checkoway@oberlin.edu>
In-Reply-To: <013f91f0-1968-1400-84b2-4d4fe2ece9a6@linaro.org>
Date: Thu, 28 Feb 2019 12:18:36 -0500
Content-Transfer-Encoding: quoted-printable
Message-Id: <8F89FA7E-E952-425F-A587-66BEECF4A295@oberlin.edu>
References: <5F2C0013-1D18-44A9-ADAF-F86EC6FD1174@oberlin.edu>
	<CAFEAcA8VzJRMSThWQ=CgNbB8BY0EAmi77oAJuHQt5iQnkiZmzg@mail.gmail.com>
	<63A30600-CCE3-4412-A3EB-8D535A8B21B3@oberlin.edu>
	<4F8E4327-9F59-4F50-A22D-20A3F939899F@oberlin.edu>
	<9108923c-076b-034c-9d68-af355861ae0c@linaro.org>
	<1FBF59F3-F256-4680-B2AD-199C197814C9@oberlin.edu>
	<013f91f0-1968-1400-84b2-4d4fe2ece9a6@linaro.org>
Subject: Re: [Qemu-devel] x86 segment limits enforcement with TCG
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: Peter Maydell <peter.maydell@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>

This is all extremely helpful! I'll dig in and try this approach soon.

> On Feb 28, 2019, at 11:11, Richard Henderson =
<richard.henderson@linaro.org> wrote:
>=20
>> Are you thinking that this should be modeled as independent sets of =
TLBs, one per mode?
>=20
> One per segment you mean?

Yes.

>  Yes, exactly.  Since each segment can have
> independent segment base + limit + permissions.  All of which would be =
taken
> into account by tlb_fill when populating the TLB.
>=20
>> It seems easier to have a linear address MMU mode and then for the =
MMU modes
>> corresponding to segment registers, perform an access and limit =
check,
>> adjust the address by the segment base, and then go through the =
linear
>> address MMU mode translation.
> Except you need to generate extra calls at runtime to perform this =
translation,
> and you are not able to cache the result of the lookup against a =
second access
> to the same page.

I see. That makes sense. I didn't realize the results of the calls were =
being cached.

>=20
>> In particular, code that uses segments spends a lot of time changing =
the
>> values of segment registers. E.g., in the movs example above, the ds =
segment
>> may be overridden but the es segment cannot be, so to use the string =
move
>> instructions within ds, es needs to be saved, modified, and then =
restored.
> You are correct that this would result in two TLB flushes.
>=20
> But if MOVS executes a non-trivial number of iterations, we still may =
win.
>=20
> The work that Emilio Cota has done in this development cycle to make =
the size
> of the softmmu TLBs dynamic will help here.  It may well be that MOVS =
is used
> with small memcpy, and there are a fair few flushes.  But in that case =
the TLB
> will be kept very small, and so the flush will not be expensive.

I wonder if it would make sense to maintain a small cache of TLBs. The =
majority of cases are likely to involving setting segment registers to =
one of a handful of segments (e.g., setting es to ds or ss). So it might =
be nice to avoid the flushes entirely.

> On the other hand, DS changes are rare (depending on the programming =
model),
> and SS changes only on context switches.  Their TLBs will keep their =
contents,
> even while ES gets flushed.  Work has been saved over adding explicit =
calls to
> a linear address helper function.

In my case, ds changes are pretty frequent=E2=80=94I count 75 instances =
of mov ds, __ and 124 instances of pop ds=E2=80=94in the executive (ring =
0) portion of this firmware. Obviously the dynamic count is more =
interesting, but I don't have that off-hand.

> The vast majority of x86 instructions have exactly one memory access, =
and it
> uses the default segment (ds/ss) or the segment override.  We can set =
this
> default mmu index as soon as we have seen any segment override.
>=20
>> Returning to the movs example, the order of operations _must_ be
>> 1. lea ds:[esi]
>> 2. load 4 bytes
>> 3. lea es:[edi]
>> 4. store 4 bytes
>=20
> MOVS is one of the rare examples of two memory accesses within one =
instruction.
> Yes, we would have to special case this, and be careful to get =
everything right.

I agree that the vast majority of x86 instructions access at most one =
segment, but off-hand, I can think of a handful that access two:

- movs=20
- cmps
- push r/m32
- pop r/m32
- call m32
- call m16:m32

I'm not sure if there are others.

--=20
Stephen Checkoway
