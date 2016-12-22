Received: from eggs.gnu.org ([2001:4830:134:3::10]:54019)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cK4OY-0007ZA-70
	for qemu-devel@nongnu.org; Thu, 22 Dec 2016 09:30:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cK4OT-00084M-0L
	for qemu-devel@nongnu.org; Thu, 22 Dec 2016 09:30:58 -0500
Received: from indium.canonical.com ([91.189.90.7]:49723)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1cK4OS-00083v-Qd
	for qemu-devel@nongnu.org; Thu, 22 Dec 2016 09:30:52 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1cK4OR-00036u-AC
	for <qemu-devel@nongnu.org>; Thu, 22 Dec 2016 14:30:51 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 3DC902E80CC
	for <qemu-devel@nongnu.org>; Thu, 22 Dec 2016 14:30:51 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 22 Dec 2016 14:25:05 -0000
From: cminyard <minyard@acm.org>
Reply-To: Bug 1651167 <1651167@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20161219154752.14563.46483.malonedeb@wampee.canonical.com>
Message-Id: <20161222142506.1229.42090.launchpad@soybean.canonical.com>
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

** Changed in: qemu
     Assignee: (unassigned) =3D> cminyard (minyard)

** Changed in: qemu
       Status: New =3D> In Progress

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1651167

Title:
  hw/ipmi/isa_ipmi_bt.c:283: suspect use of macro ?

Status in QEMU:
  In Progress

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
