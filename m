Received: from eggs.gnu.org ([209.51.188.92]:57809)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stephen.checkoway@oberlin.edu>) id 1gy0HW-0000MU-92
	for qemu-devel@nongnu.org; Sun, 24 Feb 2019 15:21:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stephen.checkoway@oberlin.edu>) id 1gy0HU-0001Yy-Jh
	for qemu-devel@nongnu.org; Sun, 24 Feb 2019 15:21:49 -0500
Received: from mail-io1-xd2d.google.com ([2607:f8b0:4864:20::d2d]:36508)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stephen.checkoway@oberlin.edu>)
	id 1gy0HT-0001TK-JE
	for qemu-devel@nongnu.org; Sun, 24 Feb 2019 15:21:48 -0500
Received: by mail-io1-xd2d.google.com with SMTP id r136so5908202iod.3
	for <qemu-devel@nongnu.org>; Sun, 24 Feb 2019 12:21:40 -0800 (PST)
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
From: Stephen Checkoway <stephen.checkoway@oberlin.edu>
In-Reply-To: <CAFEAcA8VzJRMSThWQ=CgNbB8BY0EAmi77oAJuHQt5iQnkiZmzg@mail.gmail.com>
Date: Sun, 24 Feb 2019 15:21:37 -0500
Content-Transfer-Encoding: quoted-printable
Message-Id: <63A30600-CCE3-4412-A3EB-8D535A8B21B3@oberlin.edu>
References: <5F2C0013-1D18-44A9-ADAF-F86EC6FD1174@oberlin.edu>
	<CAFEAcA8VzJRMSThWQ=CgNbB8BY0EAmi77oAJuHQt5iQnkiZmzg@mail.gmail.com>
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



> On Feb 24, 2019, at 14:46, Peter Maydell <peter.maydell@linaro.org> =
wrote:
>=20
> On Sun, 24 Feb 2019 at 19:37, Stephen Checkoway
> <stephen.checkoway@oberlin.edu> wrote:
>> I think that something about adding the tcg_gen_brcond_tl is causing =
values to become dead and then qemu aborts.
>=20
> Yep -- all "TCG temporaries" are dead at the end
> of a basic block, and brcond ends a basic block.
> Only globals and "local temporaries" stay live
> across brcond. This is documented in tcg/README,
> though it doesn't spell it out very explicitly.

Ah yes. I see that now. I missed it on my first read through.

> This makes brcond pretty painful to use and
> almost impossible to introduce into the middle
> of some existing sequence of generated code.
> I haven't looked at what the best way to do what
> you're trying to do here is, though.

Are there other examples of straight-line code being converted to a =
conditional I might be able to use as an example? I thought INTO would =
be a good example, but it merely calls a helper. Maybe I should do that? =
I assume it'll be slow, but speed isn't really my primary concern.

> By the way, don't do this:
> +    dc->A1 =3D tcg_temp_new();
>=20
> The current use of a small number of tcg temps
> in the i386 translate.c code is an antipattern
> that is a relic from a very old version of the
> code. It's much better to simply create new
> temporaries in the code at the point where you
> need them and then free them once you're done.

Great, thanks. I saw both the A0/T0/T1 and the creation of new =
temporaries and I wasn't sure which pattern I should follow.

--=20
Stephen Checkoway
