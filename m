Received: from eggs.gnu.org ([2001:4830:134:3::10]:55795)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fyLIT-0007dJ-Ma
	for qemu-devel@nongnu.org; Fri, 07 Sep 2018 14:15:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fyLIO-0005wj-PM
	for qemu-devel@nongnu.org; Fri, 07 Sep 2018 14:15:57 -0400
Received: from indium.canonical.com ([91.189.90.7]:40342)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1fyLIO-0005tM-Ay
	for qemu-devel@nongnu.org; Fri, 07 Sep 2018 14:15:52 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1fyLIL-0005y1-RF
	for <qemu-devel@nongnu.org>; Fri, 07 Sep 2018 18:15:49 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id A35762E80CC
	for <qemu-devel@nongnu.org>; Fri,  7 Sep 2018 18:15:49 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 07 Sep 2018 18:04:14 -0000
From: Yan-Jie Wang <1776920@bugs.launchpad.net>
Reply-To: Bug 1776920 <1776920@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <152898515528.25954.5483198787570860596.malonedeb@soybean.canonical.com>
Message-Id: <153634345465.24629.12107192195596244951.malone@gac.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1776920] Re: qemu-img convert on Mac OSX creates
 corrupt images
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

I have done some experiments and find out that =

the behavior of lseek with whence set to SEEK_DATA is different from the be=
havior of Linux's lseek.

If the supplied offset is in the middle of a data region, it returns the
start of the next data region.  There may be many data regions in a big
file even though it has no hole.

return value of lseek with whence set to SEEK_DATA:

|--(offset)--Data----|(return value)----Data----|
|--(offset)--Data----|----Hole----|(return value)----Data----|


** Patch added: "macOS-lseek.patch"
   https://bugs.launchpad.net/qemu/+bug/1776920/+attachment/5186138/+files/=
macOS-lseek.patch

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1776920

Title:
  qemu-img convert on Mac OSX creates corrupt images

Status in QEMU:
  New

Bug description:
  An image created by qemu-img create, then modified by another program
  is converted to bad/corrupt image when using convert sub command on
  Mac OSX. The same convert works on Linux. The version of qemu-img is
  2.12.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1776920/+subscriptions
