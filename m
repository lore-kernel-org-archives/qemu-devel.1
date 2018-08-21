Received: from eggs.gnu.org ([2001:4830:134:3::10]:54976)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fs0Le-0001Zt-Em
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 02:41:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fs0La-0000j6-BG
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 02:41:02 -0400
Received: from indium.canonical.com ([91.189.90.7]:38766)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1fs0La-0000i9-4t
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 02:40:58 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1fs0LZ-00032x-07
	for <qemu-devel@nongnu.org>; Tue, 21 Aug 2018 06:40:57 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id E82B42E8525
	for <qemu-devel@nongnu.org>; Tue, 21 Aug 2018 06:40:56 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 21 Aug 2018 06:25:41 -0000
From: Thomas Huth <1781280@bugs.launchpad.net>
Reply-To: Bug 1781280 <1781280@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <153134024411.21119.3686305138505928817.malonedeb@soybean.canonical.com>
Message-Id: <153483274249.3620.3814027971746247078.launchpad@gac.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1781280] Re: QEMU ignores all but the first
 control message sent over a Unix socket
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
       Status: Fix Committed =3D> Fix Released

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1781280

Title:
  QEMU ignores all but the first control message sent over a Unix socket

Status in QEMU:
  Fix Released

Bug description:
  I've written a test program that sends both an SCM_CREDENTIALS and an
  SCM_RIGHTS cmsg in the same sendmsg call. On native x86-64, armv6 and
  armv7 Linux, this works as expected (the recvmsg receives both control
  messages). On QEMU (both qemu-x86_64 and qemu-arm), only the first
  message is received.

  I've traced the problem back to a glibc bug:
  https://sourceware.org/bugzilla/show_bug.cgi?id=3D13500

  This means that writing control messages into an uninitialized buffer
  makes CMSG_NXTHDR erroneously return NULL even though there's still
  space inside the allocated buffer. QEMU's logic inside
  `target_to_host_cmsg` is a bit questionable here, since it stops
  encoding cmsgs as soon as *either* the host or the target buffer
  reaches its end, so we lose the target's cmsgs when the host's buffer
  runs out. However, the host buffer should *never* reach its end before
  the target buffer does, so an assertion might be more useful there.
  Anyway, the actual fix for this bug is simply zeroing out the buffer
  created for the host. I've attached a patch doing that and verified
  that it fixes the issue.

  The test program I used can be found here: https://gist.github.com
  /jonas-schievink/cb6e6584a055539d2113f22d91068e2d

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1781280/+subscriptions
