Received: from eggs.gnu.org ([2001:4830:134:3::10]:58004)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1d2YhG-00086M-PY
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 03:46:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1d2YhD-000356-Jp
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 03:46:10 -0400
Received: from indium.canonical.com ([91.189.90.7]:37451)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1d2YhD-00034v-EB
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 03:46:07 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1d2YhB-0005hm-Jw
	for <qemu-devel@nongnu.org>; Mon, 24 Apr 2017 07:46:05 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id A4E152E80C1
	for <qemu-devel@nongnu.org>; Mon, 24 Apr 2017 07:46:01 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 24 Apr 2017 07:38:25 -0000
From: Thomas Huth <1651167@bugs.launchpad.net>
Reply-To: Bug 1651167 <1651167@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20161219154752.14563.46483.malonedeb@wampee.canonical.com>
Message-Id: <20170424073825.16058.69060.malone@wampee.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1651167] Re: hw/ipmi/isa_ipmi_bt.c:283: suspect
 use of macro ?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Fix has been included here:
http://git.qemu.org/?p=3Dqemu.git;a=3Dcommitdiff;h=3Dcb9a05a4f169347f85

** Changed in: qemu
       Status: In Progress =3D> Fix Released

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1651167

Title:
  hw/ipmi/isa_ipmi_bt.c:283: suspect use of macro ?

Status in QEMU:
  Fix Released

Bug description:
  I just had a go at compiling qemu trunk with
  llvm trunk. It said:

  hw/ipmi/isa_ipmi_bt.c:283:31: warning: logical not is only applied to
  the left hand side of this bitwise operator [-Wlogical-not-
  parentheses]

  Source code is

             IPMI_BT_SET_HBUSY(ib->control_reg,
                                !IPMI_BT_GET_HBUSY(ib->control_reg));

  That use of ! causes trouble. The SET and GET
  macros are defined as:

  #define IPMI_BT_GET_HBUSY(d)       (((d) >> IPMI_BT_HBUSY_BIT) & 0x1)
  #define IPMI_BT_SET_HBUSY(d, v)    (d) =3D (((d) & ~IPMI_BT_HBUSY_MASK) |=
 \
                                         (((v & 1) << IPMI_BT_HBUSY_BIT)))

  I can make the compiler shut up by adding extra () in the last
  use of v in the SET macro, like this:

  #define IPMI_BT_SET_HBUSY(d, v)    (d) =3D (((d) & ~IPMI_BT_HBUSY_MASK) |=
 \
                                         ((((v) & 1) << IPMI_BT_HBUSY_BIT)))

  I think this is standard good practice when using macro parameters
  anyway.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1651167/+subscriptions
