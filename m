Received: from eggs.gnu.org ([2001:4830:134:3::10]:40316)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cTBVU-0001D9-Jr
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 12:55:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cTBVR-0008DD-ID
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 12:55:48 -0500
Received: from indium.canonical.com ([91.189.90.7]:59225)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1cTBVR-0008D2-CJ
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 12:55:45 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1cTBVO-0005YD-QL
	for <qemu-devel@nongnu.org>; Mon, 16 Jan 2017 17:55:42 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 9171B2E80CB
	for <qemu-devel@nongnu.org>; Mon, 16 Jan 2017 17:55:42 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Jan 2017 17:46:44 -0000
From: Peter Maydell <peter.maydell@linaro.org>
Reply-To: Bug 1655700 <1655700@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20170111160632.21721.91751.malonedeb@gac.canonical.com>
Message-Id: <20170116174645.20059.33991.malone@wampee.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1655700] Re: disas/libvixl/vixl/invalset.h:
 possible dodgy code in binary search ?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

That doesn't look like a bounds check to me, so I think your checker is
producing false positives.

libvixl is third-party code in any case, so stylistic questions are
better directed to them upstream. But I think the difference between
this code and a standard binary search is (as the comment says) that it
ignores invalid elements in the array.


** Changed in: qemu
       Status: New =3D> Invalid

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1655700

Title:
  disas/libvixl/vixl/invalset.h: possible dodgy code in binary search ?

Status in QEMU:
  Invalid

Bug description:
  =

  [qemu/disas/libvixl/vixl/invalset.h:442]: (style) Array index 'low' is us=
ed before limits check.

  Source code is

      while (!IsValid(elements[low]) && (low < high)) ++low;

  Also:

  qemu/disas/libvixl/vixl/invalset.h:450]: (style) Array index 'middle'
  is used before limits check.

  The source code is

     while (!IsValid(elements[high]) && (low < high)) --high;

  Mind you, these lines of code look similar but didn't get reported:

      while (!IsValid(elements[middle]) && (middle < high - 1)) ++middle;
      while (!IsValid(elements[middle]) && (low + 1 < middle)) --middle;

  Given that binary search is notoriously tricky to get correct and a stand=
ard C library routine
  I am puzzled as to why the standard library routine didn't get used, with=
 of course a custom
  comparison function.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1655700/+subscriptions
