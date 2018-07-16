Received: from eggs.gnu.org ([2001:4830:134:3::10]:47862)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1ff1PC-0000Yv-Fn
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 07:11:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1ff1P7-0005V9-Eq
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 07:11:02 -0400
Received: from mail-eopbgr700135.outbound.protection.outlook.com
	([40.107.70.135]:22992
	helo=NAM04-SN1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <amarkovic@wavecomp.com>)
	id 1ff1P7-0005Ty-2X
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 07:10:57 -0400
From: Aleksandar Markovic <amarkovic@wavecomp.com>
Date: Mon, 16 Jul 2018 11:10:54 +0000
Message-ID: <BN7PR08MB4868F5BE2EBF580CE8F1C244C65D0@BN7PR08MB4868.namprd08.prod.outlook.com>
Content-Language: en-US
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] tcg_register_jit_int() interface problem
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>, Peter Maydell <peter.maydell@linaro.org>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Petar Jovanovic <pjovanovic@wavecomp.com>, Laurent Vivier <laurent@vivier.eu>, Riku Voipio <riku.voipio@iki.fi>Petar Jovanovic <pjovanovic@wavecomp.com>, Stefan Markovic <smarkovic@wavecomp.com>

Hello, all.


Just a little background:


One of the fields in an ELF header is e_machine. It is meant to contain "ma=
chine architecture". The numerical value is approved by a committee. Some v=
alues for common targets are: EM_PPC, EM_PPC64, EM_ARM, EM_AARCH64, etc.


The TCG function tcg_register_jit_int() expects that the preprocessor const=
ant ELF_HOST_MACHINE is defined, and uses internally the value of that cons=
tant.


Consider, let's say, ARM: It defines ELF_HOST_MACHINE in tcg/arm/tcg-target=
.inc.c as


#define ELF_HOST_MACHINE EM_ARM


while in tcg/aarch64/tcg-target.inc.c it defines it as


#define ELF_HOST_MACHINE EM_AARCH64


For MIPS, the situation is different: Up until recently, MIPS had only one =
value for e_machine: that was EM_MIPS (used for both 32-bit and 64-bit MIPS=
 systems). However, new nanoMIPS systems have a new value in that field: EM=
_NANOMIPS (that is to be applied for both 32-bit and 64-bit nanoMIPS system=
s).


The situation described above represent a problem for us developing nanoMIP=
S support, forcing us to have different compilations (and executables) for =
MIPS and nanoMIPS.


Is there a possibility to refactor tcg_register_jit_int() to receive "e_mac=
hine" value as an argument, instead of expecting preprocessor constant to b=
e set?


Please advice if you have something better in mind.


Yours,

Aleksandar


(cc. Laurent and Riku since this is also indirectly related to handling ELF=
 headers linux user mode, and there will be a couple other nanoMIPS patches=
 comming related to that.)
