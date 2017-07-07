Received: from eggs.gnu.org ([2001:4830:134:3::10]:57920)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dTIjS-0007di-9h
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 22:10:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dTIjP-00044u-6I
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 22:10:58 -0400
Received: from indium.canonical.com ([91.189.90.7]:35449)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1dTIjP-00044T-01
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 22:10:55 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1dTIjN-0000Wr-50
	for <qemu-devel@nongnu.org>; Fri, 07 Jul 2017 02:10:53 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 01E5C2E8194
	for <qemu-devel@nongnu.org>; Fri,  7 Jul 2017 02:10:53 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 07 Jul 2017 02:00:34 -0000
From: pork-prince <1702798@bugs.launchpad.net>
Reply-To: Bug 1702798 <1702798@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <149938892775.6469.8247493589075671817.malonedeb@gac.canonical.com>
Message-Id: <149939283465.6077.5439391720287444212.malone@gac.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1702798] Re: colo: secondary vm can't receive any
 packet
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

The qemu version is 2.9.0 release.
The secondary vm state make me confused. I tried to add vm_stop and vm_star=
t in colo_process_incoming_thread function, but it crashed.

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1702798

Title:
  colo: secondary vm can't receive any packet

Status in QEMU:
  New

Bug description:
  Following document 'COLO-FT.txt', I test colo feature on my hosts. It see=
ms goes well,but I found the secondary vm can't receive any packets. I atta=
ched the process and find out the reason as follow, the filter-redirector(r=
ed0) didn't flush it's queue because the secondary vm in migrate state(RUN_=
STATE_INMIGRATE) :
  int qemu_can_send_packet(NetClientState *sender)
  {
      int vm_running =3D runstate_is_running():

      if (!vm_running) {         // it will return false on the secondary vm
          return 0;
      }
      ------
  }

  How does it produce outbound packets in the secondary vm as it in migrate=
 state?
  static void *qemu_kvm_cpu_thread_fn(void *arg)
  {
      ------
      do {
          if (cpu_can_run(cpu)) {      // it will return false on the secon=
dary vm
              r =3D kvm_cpu_exec(cpu);
      ------
  }

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1702798/+subscriptions
