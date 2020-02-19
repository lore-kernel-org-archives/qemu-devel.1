Return-Path: <SRS0=HiY9=4H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CAF0C34031
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2020 00:58:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DFE4C2173E
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2020 00:58:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DFE4C2173E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=virtualroadside.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43748 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4Dgp-0008KK-1e
	for qemu-devel@archiver.kernel.org; Tue, 18 Feb 2020 19:58:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42430)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bounces@canonical.com>) id 1j4Cwx-00083O-Hp
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 19:10:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1j4Cww-0006uT-3M
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 19:10:47 -0500
Received: from indium.canonical.com ([91.189.90.7]:32774)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1j4Cwv-0006tk-U9
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 19:10:46 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1j4Cwu-0005qW-6A
 for <qemu-devel@nongnu.org>; Wed, 19 Feb 2020 00:10:44 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 2388A2E80C0
 for <qemu-devel@nongnu.org>; Wed, 19 Feb 2020 00:10:44 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 19 Feb 2020 00:01:47 -0000
From: Dustin Spicuzza <dustin@virtualroadside.com>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: dustin-virtualroadside
X-Launchpad-Bug-Reporter: Dustin Spicuzza (dustin-virtualroadside)
X-Launchpad-Bug-Modifier: Dustin Spicuzza (dustin-virtualroadside)
Message-Id: <158207050809.30858.5545792366181447140.malonedeb@wampee.canonical.com>
Subject: [Bug 1863819] [NEW] repeated KVM single step crashes leaks into SMP
 guest and crashes guest application
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="19413b719a8df7423ab1390528edadce9e0e4aca";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: d149ff8d74021ba68dc6a0cae8e44165e7027616
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 91.189.90.7
X-Mailman-Approved-At: Tue, 18 Feb 2020 19:57:12 -0500
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-To: Bug 1863819 <1863819@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Public bug reported:

Guest: Windows 7 x64
Host: Ubuntu 18.04.4 (kernel 5.3.0-40-generic)
QEMU: master 6c599282f8ab382fe59f03a6cae755b89561a7b3

If I try to use GDB to repeatedly single-step a userspace process while
running a KVM guest, the userspace process will eventually crash with a
0x80000004 exception (single step). This is easily reproducible on a
Windows guest, I've not tried another guest type but I've been told it's
the same there also.

On a Ubuntu 16 host with an older kernel, this will hang the entire
machine. However, it seems it may have been fixed by
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?=
id=3D5cc244a20b86090c087073c124284381cdf47234
?

It's not clear to me whether this is a KVM or a QEMU bug. A TCG guest
does not crash the userspace process in the same way, but it does hang
the VM.

I've tried a variety of QEMU versions (3.0, 4.2, master) and they all
exhibit the same behavior. I'm happy to dig into this more if someone
can point me in the right direction.

Here's the outline for reproducing the bug:

* Compile iloop.cpp (attached) as a 32-bit application using MSVC
* Start Windows 7 x64 guest under GDB
  * Pass '-enable-kvm -smp 4,cores=3D2 -gdb tcp::4567' to QEMU along with o=
ther typical options

(need to get CR3 to ensure we're in the right application context -- if the=
re's an easier way to do this I'd love to hear it!)
* Install WinDBG on guest
* Copy SysInternals LiveKD to guest
* Start iloop.exe in guest, note loop address
* Run LiveKD from administrative prompt
  * livekd64.exe -w
* In WinDBG:
  * !process 0 0
  * Search for iloop.exe, note DirBase (this is CR3)

In GDB:
* Execute 'target remote tcp::4567'
* Execute 'c'
* Hit CTRL-C to pause the VM
* Execute 'p/x $cr3'
  .. continue if not equal to DirBase in WinDBG, keep stopping until it is =
equal
* Once $cr3 is correct value, if you 'stepi' a few times you'll note the pr=
ocess going in a loop, it should keep hitting the address echoed to the con=
sole by iloop.exe

Crash the process from GDB:
* Execute 'stepi 100000000'
* Watch the process, eventually it'll die with an 0x80000004 error

** Affects: qemu
     Importance: Undecided
         Status: New

** Attachment added: "iloop.cpp"
   https://bugs.launchpad.net/bugs/1863819/+attachment/5329416/+files/iloop=
.cpp

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1863819

Title:
  repeated KVM single step crashes leaks into SMP guest and crashes
  guest application

Status in QEMU:
  New

Bug description:
  Guest: Windows 7 x64
  Host: Ubuntu 18.04.4 (kernel 5.3.0-40-generic)
  QEMU: master 6c599282f8ab382fe59f03a6cae755b89561a7b3

  If I try to use GDB to repeatedly single-step a userspace process
  while running a KVM guest, the userspace process will eventually crash
  with a 0x80000004 exception (single step). This is easily reproducible
  on a Windows guest, I've not tried another guest type but I've been
  told it's the same there also.

  On a Ubuntu 16 host with an older kernel, this will hang the entire
  machine. However, it seems it may have been fixed by
  https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit=
/?id=3D5cc244a20b86090c087073c124284381cdf47234
  ?

  It's not clear to me whether this is a KVM or a QEMU bug. A TCG guest
  does not crash the userspace process in the same way, but it does hang
  the VM.

  I've tried a variety of QEMU versions (3.0, 4.2, master) and they all
  exhibit the same behavior. I'm happy to dig into this more if someone
  can point me in the right direction.

  Here's the outline for reproducing the bug:

  * Compile iloop.cpp (attached) as a 32-bit application using MSVC
  * Start Windows 7 x64 guest under GDB
    * Pass '-enable-kvm -smp 4,cores=3D2 -gdb tcp::4567' to QEMU along with=
 other typical options

  (need to get CR3 to ensure we're in the right application context -- if t=
here's an easier way to do this I'd love to hear it!)
  * Install WinDBG on guest
  * Copy SysInternals LiveKD to guest
  * Start iloop.exe in guest, note loop address
  * Run LiveKD from administrative prompt
    * livekd64.exe -w
  * In WinDBG:
    * !process 0 0
    * Search for iloop.exe, note DirBase (this is CR3)

  In GDB:
  * Execute 'target remote tcp::4567'
  * Execute 'c'
  * Hit CTRL-C to pause the VM
  * Execute 'p/x $cr3'
    .. continue if not equal to DirBase in WinDBG, keep stopping until it i=
s equal
  * Once $cr3 is correct value, if you 'stepi' a few times you'll note the =
process going in a loop, it should keep hitting the address echoed to the c=
onsole by iloop.exe

  Crash the process from GDB:
  * Execute 'stepi 100000000'
  * Watch the process, eventually it'll die with an 0x80000004 error

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1863819/+subscriptions

