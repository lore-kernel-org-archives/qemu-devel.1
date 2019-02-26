Received: from eggs.gnu.org ([209.51.188.92]:39575)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stephen.checkoway@oberlin.edu>) id 1gyQfr-0000r4-HU
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 19:32:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stephen.checkoway@oberlin.edu>) id 1gyQfq-0008LP-G8
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 19:32:43 -0500
Received: from mail-it1-x129.google.com ([2607:f8b0:4864:20::129]:40779)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stephen.checkoway@oberlin.edu>)
	id 1gyQfo-0008FF-9X
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 19:32:40 -0500
Received: by mail-it1-x129.google.com with SMTP id i2so1470194ite.5
	for <qemu-devel@nongnu.org>; Mon, 25 Feb 2019 16:32:39 -0800 (PST)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
From: Stephen Checkoway <stephen.checkoway@oberlin.edu>
In-Reply-To: <63A30600-CCE3-4412-A3EB-8D535A8B21B3@oberlin.edu>
Date: Mon, 25 Feb 2019 19:32:37 -0500
Content-Transfer-Encoding: quoted-printable
Message-Id: <4F8E4327-9F59-4F50-A22D-20A3F939899F@oberlin.edu>
References: <5F2C0013-1D18-44A9-ADAF-F86EC6FD1174@oberlin.edu>
	<CAFEAcA8VzJRMSThWQ=CgNbB8BY0EAmi77oAJuHQt5iQnkiZmzg@mail.gmail.com>
	<63A30600-CCE3-4412-A3EB-8D535A8B21B3@oberlin.edu>
Subject: Re: [Qemu-devel] x86 segment limits enforcement with TCG
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

FWIW, I figured out an approach to this. Essentially, I'm reusing the =
function which computes linear addresses to enforce not only segment =
limits (in everything but long mode), but also read/write access (in =
protected mode).

Unfortunately, that meant every call to the linear address computation =
has to be augmented with an access size and whether it's a store or not. =
The patch is pretty large so I won't include it here, but you can view =
it at =
<https://github.com/stevecheckoway/qemu/commit/ac58652efacedc53f3831301ea0=
326ac8f882b18>.

If this is something that qemu would like, then I think two additional =
things are definitely required:
1. Tests. make check passes and the firmware I have which necessitated =
the checks appears to work, but that change touches the almost every =
guest-memory-accessing x86 instruction.
2. This is going to slow down the common case=E2=80=94where segments =
have a 0 base address and a limit of 0xFFFFFFFF=E2=80=94and there's no =
real need to do that. It seems like something akin to addseg could be =
used to decide when to insert the checks. I don't really understand how =
that works and in my case, segments with nonzero bases and =
non-0xFFFFFFFF limits are the norm so I didn't investigate that. =
Something similar could probably be done to omit the writable segment =
checks.

Finally, there are some limitations. The amount of memory touched by =
xsave (and the related instructions) depends on edx:eax. I didn't bother =
checking that at all. Similarly, there are some MPX instructions that =
don't do any access checks when they really should. And finally, there's =
one place that checks for an access size of 8 bytes when, in some cases, =
it should be 16.

I'm happy to work to upstream this, if the approach is broadly =
acceptable and the functionality is desired.

If not, thank you Peter for answering my questions which enabled me to =
solve my problem.

Cheers,

Steve

> On Feb 24, 2019, at 15:21, Stephen Checkoway =
<stephen.checkoway@oberlin.edu> wrote:
>=20
>=20
>=20
>> On Feb 24, 2019, at 14:46, Peter Maydell <peter.maydell@linaro.org> =
wrote:
>>=20
>> On Sun, 24 Feb 2019 at 19:37, Stephen Checkoway
>> <stephen.checkoway@oberlin.edu> wrote:
>>> I think that something about adding the tcg_gen_brcond_tl is causing =
values to become dead and then qemu aborts.
>>=20
>> Yep -- all "TCG temporaries" are dead at the end
>> of a basic block, and brcond ends a basic block.
>> Only globals and "local temporaries" stay live
>> across brcond. This is documented in tcg/README,
>> though it doesn't spell it out very explicitly.
>=20
> Ah yes. I see that now. I missed it on my first read through.
>=20
>> This makes brcond pretty painful to use and
>> almost impossible to introduce into the middle
>> of some existing sequence of generated code.
>> I haven't looked at what the best way to do what
>> you're trying to do here is, though.
>=20
> Are there other examples of straight-line code being converted to a =
conditional I might be able to use as an example? I thought INTO would =
be a good example, but it merely calls a helper. Maybe I should do that? =
I assume it'll be slow, but speed isn't really my primary concern.
>=20
>> By the way, don't do this:
>> +    dc->A1 =3D tcg_temp_new();
>>=20
>> The current use of a small number of tcg temps
>> in the i386 translate.c code is an antipattern
>> that is a relic from a very old version of the
>> code. It's much better to simply create new
>> temporaries in the code at the point where you
>> need them and then free them once you're done.
>=20
> Great, thanks. I saw both the A0/T0/T1 and the creation of new =
temporaries and I wasn't sure which pattern I should follow.
>=20
> --=20
> Stephen Checkoway
>=20
>=20
>=20
>=20
>=20

--=20
Stephen Checkoway
