Received: from eggs.gnu.org ([209.51.188.92]:55382)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1hM2rZ-0001s7-Td
	for qemu-devel@nongnu.org; Wed, 01 May 2019 23:58:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1hM2r9-0004Ot-Jf
	for qemu-devel@nongnu.org; Wed, 01 May 2019 23:58:08 -0400
Received: from indium.canonical.com ([91.189.90.7]:36054)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1hM2qt-000385-Cr
	for qemu-devel@nongnu.org; Wed, 01 May 2019 23:57:50 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1hM2ot-0000MZ-Dg
	for <qemu-devel@nongnu.org>; Thu, 02 May 2019 03:55:39 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 627942E805D
	for <qemu-devel@nongnu.org>; Thu,  2 May 2019 03:55:39 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 02 May 2019 03:47:21 -0000
From: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <1809291@bugs.launchpad.net>
Reply-To: Bug 1809291 <1809291@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <154532874183.18487.10011391612831676105.malonedeb@gac.canonical.com>
Message-Id: <155676884172.7126.9630836176931912332.malone@chaenomeles.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1809291] Re: SD Card not working in Ubuntu 18.10
 (CMD 2,
 3 timeout). The device worked fine in Ubuntu 18.04 and earlier versions but
 not in Ubuntu 18.10
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

The offending code is:

$ git diff -w 4e5cc6756586e967993187657dfcdde4e00288d9~..4e5cc6756586e96799=
3187657dfcdde4e00288d9
diff --git a/hw/sd/sd.c b/hw/sd/sd.c
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -1537,7 +1537,7 @@ static sd_rsp_type_t sd_app_command(SDState *sd,
             }
         }
 =

-        if (req.arg & ACMD41_ENQUIRY_MASK) {
+        if (FIELD_EX32(sd->ocr & req.arg, OCR, VDD_VOLTAGE_WINDOW)) {
             /* We accept any voltage.  10000 V is nothing.
              *
              * Once we're powered up, we advance straight to ready state

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1809291

Title:
  SD Card not working in Ubuntu 18.10 (CMD 2,3 timeout).  The device
  worked fine in Ubuntu 18.04 and earlier versions but not in Ubuntu
  18.10

Status in QEMU:
  Confirmed

Bug description:
  ARM PL181 MMC card no longer working in qemu-system-arm in Ubuntu 18.10
  The MMC driver code worked fine in Ubuntu 15.10 to 18.04.
  The command to run qemu-system-arm is

      qemu-system-arm -M versatilepb -m 256M -sd sdimage -kernel t.bin
  -serial mon:stdio

  During SDC initialization, SDC commands 2, 3, 9, 13, 7, 16 all timeout, =

  which cause subsequent read/write commands 17/24 to fail also.

  Tried both ARM versatilepb and realview-pb-a8, realview-pbx-a9 boards:
  all the same.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1809291/+subscriptions
