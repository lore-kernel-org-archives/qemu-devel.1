Received: from eggs.gnu.org ([2001:4830:134:3::10]:59851)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cwWKk-0007Ye-8k
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 12:01:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cwWKg-0005U7-AH
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 12:01:58 -0400
Received: from indium.canonical.com ([91.189.90.7]:44158)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1cwWKg-0005U3-4k
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 12:01:54 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1cwWKe-0008KQ-2V
	for <qemu-devel@nongnu.org>; Fri, 07 Apr 2017 16:01:52 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id C60272E81D1
	for <qemu-devel@nongnu.org>; Fri,  7 Apr 2017 16:01:44 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 07 Apr 2017 15:48:18 -0000
From: Gerd Hoffmann <1635339@bugs.launchpad.net>
Reply-To: Bug 1635339 <1635339@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20161020160532.23339.63373.malonedeb@soybean.canonical.com>
Message-Id: <20170407154818.30114.84071.malone@soybean.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1635339] Re: qxl_pre_save assertion failure on vm
 "save"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Well.  qxl commands are expected to live in bar 0 (same bar where the
rings are too).  vram bar was added as surface storage.

Now the windows drivers started to us vram for qxl commands.  Problem is
we simply can't live-migrate such a guest.  At least not without
changing the vmstate format.  Which isn't something I would attempt just
a few days before release.

We can't throw an error in qxl_pre_save either (and fail migration
instead of aborting).

I don't see an easy way out for 2.9.

Long term options are (a) revert the driver change, and probably add
some checks to qxl to make sure guests don't use vram for commands, or
(b) extend qxl vmstate so we can handle that case.

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1635339

Title:
  qxl_pre_save assertion failure on vm "save"

Status in QEMU:
  Confirmed

Bug description:
  When I try and save my Windows 10 VM, I see an assertion failure, and
  the machine is shut down.

  I see the following in the log:

  main_channel_handle_parsed: agent start
  qemu-system-x86_64: /build/qemu-Zwynhi/qemu-2.5+dfsg/hw/display/qxl.c:210=
1: qxl_pre_save: Assertion `d->last_release_offset < d->vga.vram_size' fail=
ed.
  2016-10-20 11:52:42.713+0000: shutting down

  Please let me know what other information would be relevant!

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1635339/+subscriptions
