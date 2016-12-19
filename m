Received: from eggs.gnu.org ([2001:4830:134:3::10]:59052)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cJ2ne-000508-Fn
	for qemu-devel@nongnu.org; Mon, 19 Dec 2016 13:36:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cJ2nb-00044p-DS
	for qemu-devel@nongnu.org; Mon, 19 Dec 2016 13:36:38 -0500
Received: from indium.canonical.com ([91.189.90.7]:48546)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1cJ2nb-00044P-8H
	for qemu-devel@nongnu.org; Mon, 19 Dec 2016 13:36:35 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1cJ2na-0008LX-4H
	for <qemu-devel@nongnu.org>; Mon, 19 Dec 2016 18:36:34 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 1EA232E80C2
	for <qemu-devel@nongnu.org>; Mon, 19 Dec 2016 18:36:34 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 19 Dec 2016 18:20:37 -0000
From: Thomas Huth <682326@bugs.launchpad.net>
Reply-To: Bug 682326 <682326@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20101128105835.27278.44074.malonedeb@soybean.canonical.com>
Message-Id: <20161219182038.3423.18638.malone@gac.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 682326] Re: linux-user/mmap exhaustion
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Triaging old bug tickets ... do you still have this issue with the
latest version of QEMU? If so, could you please discuss the patch on the
qemu-devel mailing list? (since we do not take patches from the
bugtracker)

** Changed in: qemu
       Status: New =3D> Incomplete

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/682326

Title:
  linux-user/mmap exhaustion

Status in QEMU:
  Incomplete

Bug description:
  Currently when executing a linux-user target, mmap.c is in use- the
  model it uses internally for figuring out what the mmap address
  actually should be basically is an accumulator, every mmap invocation
  (regardless of munmap's that cleared the previous usage) is center on
  the next page.

  The end result of this is that it'll burn it's way through the space
  soon enough, especially if it's a 64bit host w/ a 32bit target- the
  host starts giving back 64bit addresses and the emulated mmap falls
  over after failed attempts at a low MAP_FIXED range.

  Where this becomes problematic is that glibc's FILE internals mmap a
  *lot*- once per handle.  Any long running process can hit this wall-
  rpmbuild unfortunately is pretty loose in it's FILE creation/usage, so
  it hits the wall surprisingly fast- at least on an opensuse 11.2
  system w/ mmap_min_addr of 65536 (their default), building qt reliably
  hits that exhaustion during packaging.

  Attached is basically, a hack- but one that works surprisingly well
  and at least for meego building via qemu-arm, eliminates the failure
  scenario I've described above.  It doesn't remove the exhaustion as
  much as push it a fair bit back, although there are still a couple of
  ways to trigger it (http://bugs.meego.com/show_bug.cgi?id=3D10526 is the
  only remaining example I'm aware of).

  This patch simply checks to see if upon an actual, host level munmap,
  if the ending point of the munmap is where we'd allocate from next- if
  so, it shifts the starting point back to the (now) unmap'd start,
  reusing the space.  Rebuilding meego a couple of times over, thus far
  I've not managed to flush out any failures that point at this specific
  patch, so... it looks like it's doing the trick- that said the lack of
  a g2h/h2g in the calculation still seems questionable to me.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/682326/+subscriptions
