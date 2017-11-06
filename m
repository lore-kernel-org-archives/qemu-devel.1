Received: from eggs.gnu.org ([2001:4830:134:3::10]:56161)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eBjNa-0007vT-Mq
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 10:32:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eBjNW-0001cm-OB
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 10:32:02 -0500
Received: from indium.canonical.com ([91.189.90.7]:42156)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1eBjNW-0001cA-Hx
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 10:31:58 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1eBjNU-00049R-A4
	for <qemu-devel@nongnu.org>; Mon, 06 Nov 2017 15:31:56 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 214902E81FF
	for <qemu-devel@nongnu.org>; Mon,  6 Nov 2017 15:31:47 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 06 Nov 2017 15:22:41 -0000
From: Peter Maydell <peter.maydell@linaro.org>
Reply-To: Bug 1637974 <1637974@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20161031104836.30100.23885.malonedeb@wampee.canonical.com>
Message-Id: <150998176191.9131.14639145998367707924.launchpad@wampee.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1637974] Re: dead code in pl080 functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

** Changed in: qemu
       Status: New =3D> Confirmed

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1637974

Title:
  dead code in pl080 functions

Status in QEMU:
  Confirmed

Bug description:
  pl080 is arm dma controller virtual device.
  source code path: hw/dma/pl080.c
  I find there are two same dead code in pl080_read and pl080_write,
  Here's the code, comments are my opinion:
  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
  240 static uint64_t pl080_read(void *opaque, hwaddr offset,
  241                            unsigned size)
  242 {
  243     PL080State *s =3D (PL080State *)opaque;
  244     uint32_t i;
  245     uint32_t mask;
  246
  247     if (offset >=3D 0xfe0 && offset < 0x1000) {
  248         if (s->nchannels =3D=3D 8) {
  249             return pl080_id[(offset - 0xfe0) >> 2];
  250         } else {
  251             return pl081_id[(offset - 0xfe0) >> 2];
  252         }
  253     }
  254     if (offset >=3D 0x100 && offset < 0x200) {   //// here offset is =
limited in 0x100~0x200
  255         i =3D (offset & 0xe0) >> 5;
  256         if (i >=3D s->nchannels)
  257             goto bad_offset;
  258         switch (offset >> 2) {                 //// then here, offset=
>>2 is in range  64~128
  259         case 0: /* SrcAddr */                  //// while the switch =
case is 0,1,2,3,4,
  260             return s->chan[i].src;             //// so, NONE of the s=
witch case would be selected !
  261         case 1: /* DestAddr */                 //// this switch is A =
DEAD CODE, it is contradictory with if.
  262             return s->chan[i].dest;
  263         case 2: /* LLI */
  264             return s->chan[i].lli;
  265         case 3: /* Control */
  266             return s->chan[i].ctrl;
  267         case 4: /* Configuration */
  268             return s->chan[i].conf;
  269         default:
  270             goto bad_offset;
  271         }
  272     }
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.........................=
............
  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

  I guess, switch statement should like this :
  switch((offset-0x100)>>2)
  {
  ...
  }
  if this DEADCODE is not the author's original purpose,
  Then there must be something in logic goes wrong, pl080 have NEVER works =
correctly ?

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1637974/+subscriptions
