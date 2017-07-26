Received: from eggs.gnu.org ([2001:4830:134:3::10]:34953)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <michaeljclark@mac.com>) id 1daTo4-0007DA-5O
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 17:25:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <michaeljclark@mac.com>) id 1daTo0-0006KZ-VC
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 17:25:24 -0400
Received: from pv33p33im-asmtp001.me.com ([17.142.241.8]:26028)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <michaeljclark@mac.com>)
	id 1daTo0-0006GZ-N1
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 17:25:20 -0400
Received: from process-dkim-sign-daemon.pv33p33im-asmtp001.me.com by
	pv33p33im-asmtp001.me.com
	(Oracle Communications Messaging Server 7.0.5.38.0 64bit (built Feb 26
	2016)) id <0OTP00D00VEACB00@pv33p33im-asmtp001.me.com> for
	qemu-devel@nongnu.org; Wed, 26 Jul 2017 21:25:16 +0000 (GMT)
From: Michael Clark <michaeljclark@mac.com>
Message-id: <D290B1C4-44B7-4298-9C3E-4E6239772BE4@mac.com>
MIME-version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Date: Thu, 27 Jul 2017 09:25:07 +1200
In-reply-to: <22905.636.943084.809904@KAMacBookPro2016.local>
References: <e071dd23-8d19-93ba-7962-b2e2df69a6ee@mail.uni-paderborn.de>
	<CAEz=sonvfDHymUBec0Xw3RqhiANmUvrCjqMvn2eQ4zuOu1rH5A@mail.gmail.com>
	<58da690d-03d4-2c96-469a-35ff8c25ef1d@mail.uni-paderborn.de>
	<20170726173628.GF30459@redhat.com>
	<22905.636.943084.809904@KAMacBookPro2016.local>
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [sw-dev] RFC: QEMU RISC-V modular ISA decoding
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: krste@berkeley.edu
Cc: "Richard W.M. Jones" <rjones@redhat.com>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Samuel Falvo II <sam.falvo@gmail.com>, RISC-V SW Dev <sw-dev@groups.riscv.org>, QEMU Developers <qemu-devel@nongnu.org>


> On 27 Jul 2017, at 8:58 AM, krste@berkeley.edu wrote:
>=20
>=20
> Given that one of the goals of RISC-V is extensibility, it would be
> nice if the QEMU port was done in a way to make it easier to extend by
> third parties, including other automated tools.  I'm sure that, over
> time, the preprocessor can be improved to automatically incorporate
> optimizations for better performance.

I had a look at the s390x code in more detail.

It essentially does some length and major opcode unpacking to =
construct/linearise the opcode space, and would be equivalent to =
constructing a 15-bit opcode for RISC-V. It does some pre-decoding to =
find length, majors, and has a switch on majors to find instruction =
type, and then append minors, if any.

- https://hastebin.com/taceyuyore.cpp =
<https://hastebin.com/taceyuyore.cpp>

It would be akin to something list this (at a high-level):

len =3D inst_len(inst)		/* bits[1:0] */
op =3D major_opcode(inst)	/* bits[6:2] */

switch op
	- rvc
		/* hairy bit */
	- r-type
		op2 =3D funct7 << 3 | funct3
	- i-type
	- s-type
		op2 =3D funct3
	- u-type
		op2 =3D 0

op =3D op | op2 << 5
