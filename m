Received: from eggs.gnu.org ([2001:4830:134:3::10]:58504)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cUHSw-00047e-HN
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 13:29:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cUHSt-0000D7-F0
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 13:29:42 -0500
Received: from indium.canonical.com ([91.189.90.7]:47527)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1cUHSt-0000Ct-8o
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 13:29:39 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1cUHSr-0005Lx-Qb
	for <qemu-devel@nongnu.org>; Thu, 19 Jan 2017 18:29:37 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id C77B82E80C6
	for <qemu-devel@nongnu.org>; Thu, 19 Jan 2017 18:29:37 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 19 Jan 2017 18:17:32 -0000
From: Francois Gouget <1174654@bugs.launchpad.net>
Reply-To: Bug 1174654 <1174654@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20130430080722.32341.54160.malonedeb@gac.canonical.com>
Message-Id: <20170119181732.20152.75495.malone@wampee.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1174654] Re: qemu-system-x86_64 takes 100% CPU
 after host machine resumed from suspend to ram
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

This sounds sort of like a problem I have with reverting to live snapshots.
What I found out is that this is related to restoring the clock in the gues=
t. You can find out more about it there:
https://bugs.launchpad.net/qemu/+bug/1505041

The takeaway is that a workaround is to set track=3D'guest' on the rtc
timer. For instance:

    <clock offset=3D'localtime'>
      <timer name=3D'rtc' track=3D'guest'/>
    </clock>

If you have track=3D'catchup' QEMU seems to try to send millions of
interrupts so the guest clock will catch up to the current time, which
can take minutes during which the guest is unusable.

It is possible this no longer happens though as I have had this
workaround in place for quite some time but nobody formally said this is
fixed or pointed to a commit fixing this.

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1174654

Title:
  qemu-system-x86_64 takes 100% CPU after host machine resumed from
  suspend to ram

Status in QEMU:
  Confirmed
Status in qemu package in Ubuntu:
  Invalid

Bug description:
  I have Windows XP SP3  inside qemu VM. All works fine in 12.10. But
  after upgraiding to 13.04 i have to restart the VM each time i
  resuming my host machine, because qemu process starts to take CPU
  cycles and OS inside VM is very slow and sluggish. However it's still
  controllable and could be shutdown by itself.

  According to the taskmgr any active process takes 99% CPU. It's not
  stuck on some single process.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1174654/+subscriptions
