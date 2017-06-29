Received: from eggs.gnu.org ([2001:4830:134:3::10]:36924)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sw@weilnetz.de>) id 1dQdss-0007b0-T1
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 14:09:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sw@weilnetz.de>) id 1dQdsp-0005K1-Md
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 14:09:42 -0400
Received: from mail.weilnetz.de ([37.120.169.71]:37816
	helo=v2201612906741603.powersrv.de)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sw@weilnetz.de>) id 1dQdsp-0005Ip-Bp
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 14:09:39 -0400
References: <20170629010300.2848-1-f4bug@amsat.org>
From: Stefan Weil <sw@weilnetz.de>
Message-ID: <6b33a0d9-524c-6125-4623-2eb9ef5f36a6@weilnetz.de>
Date: Thu, 29 Jun 2017 20:09:37 +0200
MIME-Version: 1.0
In-Reply-To: <20170629010300.2848-1-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH 0/8] removal of tci (tcg interpreter)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, "Emilio G . Cota" <cota@braap.org>, Peter Maydell <peter.maydell@linaro.org>

Am 29.06.2017 um 03:02 schrieb Philippe Mathieu-Daud=C3=A9:
> There have been some comments on the ML about the usefulness of tci.
>=20
> https://lists.nongnu.org/archive/html/qemu-devel/2017-06/msg04551.html
>=20
>   Peter Maydell> I'd prefer we just got rid of it.
>=20
> https://lists.nongnu.org/archive/html/qemu-devel/2017-06/msg04296.html
>=20
>   Richard Henderson> Is it time to remove it? I'm pretty sure the only =
hosts
>                      for which it will work have proper backends...
>=20
> Richard quotes are way clearer than me trying to paraphrase what he tol=
d me:
> - it doesn't use libffi, and as such the way it makes calls to helpers =
doesn't work for many hosts.
> - we already cover almost everthing that debian does. if debian or gent=
oo doesn't support it, one can confidently say there's little interest.
> - if someone *does* want to run qemu on something else, it isn't diffic=
ult to port tcg.
>=20
> I figured out MAINTAINERS was unsync, so added patches 1-4, they are no=
t really
> tci-related.
>=20
> Patches 5,6 are trivial fixes to let the codebase quite sane if there i=
s future
> need to revert/reimport tci.
>=20
> Patches 7,8 are the removal, marked RFC... let's debate!
>=20
> Regards,
>=20
> Phil.


Hi,

as Peter already has written, there are different perspectives on QEMU.

My conclusion is that depending on those perspectives people come to
different results whether certain code parts are useful or not.

When I started using (and contributing) to QEMU in 2006, I wanted to
analyse code running on an embedded MIPS system. With real hardware
that was impossible, but with QEMU I could watch and debug that code
(as soon as the MIPS emulation was sufficiently good, so that was
my initial motivation).

Later I was responsible for automated software tests. Those tests
included software written for embedded PCs. The only missing components
for an emulation with QEMU were the network cards, so I wrote the
eepro100 (part of official QEMU) and dp8381x (only in my fork)
network hardware emulations.

Later I wanted to build and run QEMU on platforms which were not
implemented. So that was the motivation to write TCI. I also used
TCI to analyse TCG commands with Valgrind. It is for example very
easy to count the frequency of the different TCG opcodes executed
in an emulation run. TCI could also be used to monitor register
usage with minimal code changes. And I still think that it is
the easiest way to build QEMU on a completely new platform
(that should work out of the box) and to make emulation work
there (that might require some efforts).

In my current role I'm interested in the emulation of old computer
systems. Therefore my fork still includes some hardware emulations
which were removed in the official QEMU, and especially emulation
of all generations of the Intel PC platform is important for me.

I am aware that neither of those applications is in the primary
focus of most QEMU developers who want to have a stable, well
performing platform for server virtualisation. My server
qemu.weilnetz.de also uses that technology, so I want that, too.

Nevertheless QEMU is the only software which I know which not
only addresses the needs for server / PC virtualisation, but
also is useful for researchers and scientists, archivists,
learners and teachers or experimenters.

Up to now, I had the impression that QEMU is sufficiently modular
so that the different perspectives and expectations could be
supported without harming each other too much. The only drawback
was additional code (which would not be needed when focussing on
a single perspective) causing additional compilation time
and more (formal, mostly automated) file changes for code clean
ups and API=E2=80=8C changes.

Cheers
Stefan
