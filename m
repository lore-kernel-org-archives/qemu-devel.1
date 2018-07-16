Received: from eggs.gnu.org ([2001:4830:134:3::10]:52760)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1ff1oH-0005X1-Qv
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 07:36:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1ff1oE-0004J4-Dv
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 07:36:57 -0400
Received: from mail-eopbgr700112.outbound.protection.outlook.com
	([40.107.70.112]:16099
	helo=NAM04-SN1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <amarkovic@wavecomp.com>)
	id 1ff1oD-0004IW-Vy
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 07:36:54 -0400
From: Aleksandar Markovic <amarkovic@wavecomp.com>
Date: Mon, 16 Jul 2018 11:36:50 +0000
Message-ID: <BN7PR08MB4868A93EDEAA419282D376D9C65D0@BN7PR08MB4868.namprd08.prod.outlook.com>
References: <BN7PR08MB4868F5BE2EBF580CE8F1C244C65D0@BN7PR08MB4868.namprd08.prod.outlook.com>,
	<5368d20b-2b39-2fee-8851-f749f97071f8@vivier.eu>
In-Reply-To: <5368d20b-2b39-2fee-8851-f749f97071f8@vivier.eu>
Content-Language: en-US
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] tcg_register_jit_int() interface problem
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>, Richard Henderson <rth@twiddle.net>, Peter Maydell <peter.maydell@linaro.org>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Petar Jovanovic <pjovanovic@wavecomp.com>, Riku Voipio <riku.voipio@iki.fi>, Stefan Markovic <smarkovic@wavecomp.com>

> From: Laurent Vivier <laurent@vivier.eu>
> Sent: Monday, July 16, 2018 1:30 PM
>
> Le 16/07/2018 =E0 13:10, Aleksandar Markovic a =E9crit :
> > Hello, all.
> >
> >
> > Just a little background:
> >
> >
> > One of the fields in an ELF header is e_machine. It is meant to contain
> > "machine architecture". The numerical value is approved by a committee.
> > Some values for common targets are: EM_PPC, EM_PPC64, EM_ARM,
> > EM_AARCH64, etc.
> >
> >
> > The TCG function tcg_register_jit_int() expects that the preprocessor
> > constant ELF_HOST_MACHINE is defined, and uses internally the value of
> > that constant.
> >
> >
> > Consider, let's say, ARM: It definesELF_HOST_MACHINE in
> > tcg/arm/tcg-target.inc.c as
> >
> >
> > #define ELF_HOST_MACHINE EM_ARM
> >
> >
> > while in tcg/aarch64/tcg-target.inc.c it defines it as
> >
> >
> > #define ELF_HOST_MACHINE EM_AARCH64
> >
> >
> > For MIPS, the situation is different: Up until recently, MIPS had only
> > one value for e_machine: that was EM_MIPS (used for both 32-bit and
> > 64-bit MIPS systems). However, new nanoMIPS systems have a new value in
> > that field: EM_NANOMIPS (that is to be applied for both 32-bit and
> > 64-bit nanoMIPS systems).
> >
> >
> > The situation described above represent a problem for us developing
> > nanoMIPS support, forcing us to have different compilations (and
> > executables) for MIPS and nanoMIPS.
> >
> >
> > Is there a possibility to refactor tcg_register_jit_int() to receive
> > "e_machine" value as an argument, instead of expecting preprocessor
> > constant to be set?
>
> I don't know this par of code, but for PPC we have:
>
> #if TCG_TARGET_REG_BITS =3D=3D 64
> # define ELF_HOST_MACHINE EM_PPC64
> #else
> # define ELF_HOST_MACHINE EM_PPC
> #endif
>
> So perhaps you could have something like:
>
> #if defined(HOST_NANOMIPS)
> # define ELF_HOST_MACHINE EM_NANOMIPS
> #else
> # define ELF_HOST_MACHINE EM_MIPS
> #endif

The problem is, this means there will be separate executables for QEMU for =
MIPS and QEMU for nanoMIPS. Would that be acceptable from overall QEMU desi=
gn point of view? Peter, Richard?

Regards,
Aleksandar
