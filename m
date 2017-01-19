Received: from eggs.gnu.org ([2001:4830:134:3::10]:59445)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cUHYB-0007GX-91
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 13:35:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cUHY6-0003BG-Gv
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 13:35:07 -0500
Received: from indium.canonical.com ([91.189.90.7]:48276)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1cUHY6-0003AA-Ax
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 13:35:02 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1cUHY5-0005vU-Fo
	for <qemu-devel@nongnu.org>; Thu, 19 Jan 2017 18:35:01 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 60FA32E80C3
	for <qemu-devel@nongnu.org>; Thu, 19 Jan 2017 18:35:01 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 19 Jan 2017 18:23:46 -0000
From: Francois Gouget <1505041@bugs.launchpad.net>
Reply-To: Bug 1505041 <1505041@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20151012003458.26359.57214.malonedeb@chaenomeles.canonical.com>
Message-Id: <20170119182346.21353.22832.malone@gac.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1505041] Re: Live snapshot revert times increases
 linearly with snapshot age
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

See also:
https://bugs.launchpad.net/qemu/+bug/1174654

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1505041

Title:
  Live snapshot revert times increases linearly with snapshot age

Status in QEMU:
  New

Bug description:
  The WineTestBot (https://testbot.winehq.org/) uses QEmu live snapshots
  to ensure the Wine tests are always run in a pristine Windows
  environment. However the revert times keep increasing linearly with
  the age of the snapshot, going from tens of seconds to thousands.
  While the revert takes place the qemu process takes 100% of a core and
  there is no disk activity. Obviously waiting over 20 minutes before
  being able to run a 10 second test is not viable.

  Only some VMs are impacted. Based on libvirt's XML files the common
  point appears to be the presence of the following <timer> tags:

      <clock offset=3D'localtime'>
        <timer name=3D'rtc' tickpolicy=3D'delay'/>
        <timer name=3D'pit' tickpolicy=3D'delay'/>
        <timer name=3D'hpet' present=3D'no'/>
      </clock>

  Where the unaffected VMs have the following clock definition instead:

      <clock offset=3D'localtime'/>

  Yet shutting down the affected VMs, changing the clock definition,
  creating a live snapshot and trying to revert to it 6 months later
  results in slow revert times (>400 seconds).

  Changing the tickpolicy to catchup for rtc and/or pit has no effect on
  the revert time (and unsurprisingly causes the clock to run fast in
  the guest).

  =

  To reproduce this problem do the following:
  * Create a Windows VM (either 32 or 64 bits). This is known to happen wit=
h at least Windows 2000, XP, 2003, 2008 and 10.
  * That VM will have the <timer> tags shown above, with the possible addit=
ion of an hypervclock timer.
  * Shut down the VM.
  * date -s "2014/04/01"
  * Start the VM.
  * Take a live snapshot.
  * Shut down the VM.
  * date -s "<your current date>"
  * Revert to the live snapshot.

  If the revert takes more than 2 minutes then there is a problem.

  =

  A workaround is to set track=3D'guest' on the rtc timer. This makes the r=
evert fast and may even be the correct solution. But why is it not the defa=
ult or better documented?
   * It setting track=3D'wall' or omitting track, then the revert is slow a=
nd the clock in the guest is not updated.
   * It setting track=3D'guest' the revert is fast and the clock in the gue=
st is not updated.

  =

  I found three past mentions of this issue but as far as I can tell none o=
f them got anywhere:

  * [Qemu-discuss] massive slowdown for reverts after given amount of time =
on any newer versions
     https://lists.gnu.org/archive/html/qemu-discuss/2013-02/msg00000.html

  * The above post references another one from 2011 wrt qemu 0.14:
     https://lists.gnu.org/archive/html/qemu-devel/2011-03/msg02645.html

  * Comment #9 of Launchpad bug 1174654 matches this slow revert issue. How=
ever
     the bug was really about another issue so this was not followed on.
     https://bugs.launchpad.net/qemu/+bug/1174654/comments/9

  =

  I'm currently running into this issue with QEmu 2.1 but it looks like thi=
s bug has been there all along.
  1:2.1+dfsg-12+deb8u2 qemu-kvm
  1:2.1+dfsg-12+deb8u2 qemu-system-common
  1:2.1+dfsg-12+deb8u2 qemu-system-x86

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1505041/+subscriptions
