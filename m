Received: from eggs.gnu.org ([2001:4830:134:3::10]:49985)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=771b48d5d=jancraig@amazon.com>)
	id 1fukhq-0006TI-Mt
	for qemu-devel@nongnu.org; Tue, 28 Aug 2018 16:35:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=771b48d5d=jancraig@amazon.com>)
	id 1fukYx-0002hG-Gf
	for qemu-devel@nongnu.org; Tue, 28 Aug 2018 16:26:10 -0400
Received: from smtp-fw-9101.amazon.com ([207.171.184.25]:34286)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <prvs=771b48d5d=jancraig@amazon.com>)
	id 1fukYx-0002gS-4f
	for qemu-devel@nongnu.org; Tue, 28 Aug 2018 16:26:07 -0400
From: "Janeczek, Craig" <jancraig@amazon.com>
Date: Tue, 28 Aug 2018 20:22:28 +0000
Message-ID: <a8a8a9fd52124f56ac3be7e991b3b39a@EX13D12UEA003.ant.amazon.com>
References: <20180828130041.26445-1-jancraig@amazon.com>,
	<20180828130041.26445-3-jancraig@amazon.com>
	<BN7PR08MB48680621D40A0A8800E9AEF6C60A0@BN7PR08MB4868.namprd08.prod.outlook.com>,
	<b9eab9396a6e4270b9e536a4fe84a54d@EX13D12UEA003.ant.amazon.com>
	<BN7PR08MB4868B217B1104A75673CE58EC60A0@BN7PR08MB4868.namprd08.prod.outlook.com>,
	<a89f839cb02647ae865382f060bc29f0@EX13D12UEA003.ant.amazon.com>
	<BN7PR08MB4868B3C34EB2307D4EAE9722C60A0@BN7PR08MB4868.namprd08.prod.outlook.com>
In-Reply-To: <BN7PR08MB4868B3C34EB2307D4EAE9722C60A0@BN7PR08MB4868.namprd08.prod.outlook.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v3 2/8] target/mips: Add all MXU opcodes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aleksandar Markovic <amarkovic@wavecomp.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "aurelien@aurel32.net" <aurelien@aurel32.net>

To clarify, if MXU is present (a cpu defined to have MXU instructions is se=
lected) we will never run any of the other special2 commands? That would ac=
tually simplify the implementation.

Also I understand the want for clean code, I appreciate the comments.

-----Original Message-----
From: Aleksandar Markovic <amarkovic@wavecomp.com>=20
Sent: Tuesday, August 28, 2018 3:35 PM
To: Janeczek, Craig <jancraig@amazon.com>; qemu-devel@nongnu.org
Cc: aurelien@aurel32.net
Subject: Re: [PATCH v3 2/8] target/mips: Add all MXU opcodes

> From: Janeczek, Craig <jancraig@amazon.com>
> Sent: Tuesday, August 28, 2018 8:54 PM
>
> Subject: RE: [PATCH v3 2/8] target/mips: Add all MXU opcodes
>
> I will re-work each of the mxu_gen_<ins> functions to check for MXUEN and=
 jump over the implementation of the instruction if not enabled.
>=20
> I would like to clarify the structure of the switch statement before impl=
ementing it.
>
> I was originally planning on checking if there was a MXU hit and MXUEN wa=
s set, in that case use the MXU instruction, else use the original switch. =
This will not work as MXUEN is in a TCGv and cant be used in an if statemen=
t at that level. That is why I plan on putting the MXUEN check in each of t=
he mxu_gen_<ins> functions.
>=20
> What should the re-worked switch statement look like which runs the mxu_g=
en_<ins> functions?

I didn't study these code segments in depth, but at this moment it seems to=
 me that the cleanest organization would be to leave current decode_opc_spe=
cial2_legacy(env, ctx); as is, and, however, to change the part with its in=
vocation:

    case OPC_SPECIAL2:
        decode_opc_special2_legacy(env, ctx);
        break;
to

    case OPC_SPECIAL2:
        if (<MXU is present>) {
                decode_opc_special2_mxu(env, ctx);
        } else if (<LOONGSON_2F>) {
                decode_opc_special2_legacy(env, ctx);
        }
        break;

where decode_opc_special2_mxu(env, ctx); is the function that you will writ=
e.

Or something along these lines...

But I may be mistaken regrding details...

Again, overall, this series is very good. We are arguing about some technic=
al details, out of which many are, frankly, unimportant. I just want to tel=
l you that don't misunderstand my and Richard's critiques - we want this co=
de in QEMU, just want it to be nice, clean, and correct, and we definitely =
appreciate your work very much!
