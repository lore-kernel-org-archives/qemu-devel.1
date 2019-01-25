Received: from eggs.gnu.org ([209.51.188.92]:58074)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gn2QP-0004RT-Ry
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 09:25:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gn2QM-0006Ls-2c
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 09:25:41 -0500
Received: from indium.canonical.com ([91.189.90.7]:54310)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1gn2QK-0006Id-8T
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 09:25:37 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1gn2QH-0006Af-QL
	for <qemu-devel@nongnu.org>; Fri, 25 Jan 2019 14:25:33 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 8E1BD2E80D2
	for <qemu-devel@nongnu.org>; Fri, 25 Jan 2019 14:25:33 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 25 Jan 2019 14:17:10 -0000
From: Christophe Lyon <christophe.lyon+launchpad@gmail.com>
Reply-To: Bug 1813307 <1813307@bugs.launchpad.net>
Sender: bounces@canonical.com
Message-Id: <154842583020.19428.9970935732154630086.malonedeb@gac.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1813307] [NEW] util/path.c/follow_path() does not
 handle "/" well
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Public bug reported:

Hello,

I noticed that qemu does not handle "/" very well in follow_path().

Specifically, I was trying to run gdbserver under qemu, and it failed
inside its implementation of __getcwd.

Indeed it does something like
  if (__lstat ("/", &st) < 0)
.....
and then loops from current dir toward the top using lstat("..")

On qemu side, lstat forwards the request to follow_path() in util/path.c, a=
nd when passed "/", it returns the path in QEMU_LD_PREFIX (which was the to=
p of my sysroot).
OTHT, the series of lstat("..") finally reaches the real device root becaus=
e it's not recognized as "/" in follow_path(), so this is inconsistent and =
__getcwd fails.

I suppose there's a good reason for returning QEMU_LD_PREFIX when asking
for "/", but why is it so?

If there's no good reason, maybe the behaviour could be changed to map
"/" to "/" ?

Thanks

** Affects: qemu
     Importance: Undecided
         Status: New

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1813307

Title:
  util/path.c/follow_path() does not handle "/" well

Status in QEMU:
  New

Bug description:
  Hello,

  I noticed that qemu does not handle "/" very well in follow_path().

  Specifically, I was trying to run gdbserver under qemu, and it failed
  inside its implementation of __getcwd.

  Indeed it does something like
    if (__lstat ("/", &st) < 0)
  .....
  and then loops from current dir toward the top using lstat("..")

  On qemu side, lstat forwards the request to follow_path() in util/path.c,=
 and when passed "/", it returns the path in QEMU_LD_PREFIX (which was the =
top of my sysroot).
  OTHT, the series of lstat("..") finally reaches the real device root beca=
use it's not recognized as "/" in follow_path(), so this is inconsistent an=
d __getcwd fails.

  I suppose there's a good reason for returning QEMU_LD_PREFIX when
  asking for "/", but why is it so?

  If there's no good reason, maybe the behaviour could be changed to map
  "/" to "/" ?

  Thanks

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1813307/+subscriptions
