Received: from eggs.gnu.org ([209.51.188.92]:48945)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gzfMM-0006ej-9i
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 05:25:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gzfMJ-0005Js-Sn
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 05:25:42 -0500
Received: from indium.canonical.com ([91.189.90.7]:40524)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1gzfMI-0005Ir-HJ
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 05:25:38 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1gzfMG-0002Xq-L5
	for <qemu-devel@nongnu.org>; Fri, 01 Mar 2019 10:25:36 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 9C1DF2E8073
	for <qemu-devel@nongnu.org>; Fri,  1 Mar 2019 10:25:36 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 01 Mar 2019 10:14:23 -0000
From: Huan Xiong <1818207@bugs.launchpad.net>
Reply-To: Bug 1818207 <1818207@bugs.launchpad.net>
Sender: bounces@canonical.com
Message-Id: <155143526311.31693.6210776474492711183.malonedeb@wampee.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1818207] [NEW] [aarch64] VM status remains
 "running" after it's suspended
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

The issue is observed on aarch64 (I didn't check x86) with latest
upstream QEMU bits.

Steps to reproduce:

1) start guest

2) suspend guest with this command:

# echo mem > /sys/power/state

  Check console messages, which should indicate that guest has been
suspended.

3) check guest status through HMP command "info status":

  (qemu) info status
   info status
   VM status: running

Note it's "running", which is incorrect.

QEMU version:

# qemu-system-aarch64 --version
QEMU emulator version 3.1.50 (v3.1.0-2203-g9403bcc)
Copyright (c) 2003-2019 Fabrice Bellard and the QEMU Project developers

The issue prevents user from resuming a suspended guest through
"system_wakeup" HMP command, because QEMU thinks the guest is in running
state and does nothing.

I think the issues occurs because qemu_system_wakeup_request() doesn't
get called. It seems the root cause is with ACPI related code.

** Affects: qemu
     Importance: Undecided
         Status: New


** Tags: aarch64

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1818207

Title:
  [aarch64] VM status remains "running" after it's suspended

Status in QEMU:
  New

Bug description:
  The issue is observed on aarch64 (I didn't check x86) with latest
  upstream QEMU bits.

  Steps to reproduce:

  1) start guest

  2) suspend guest with this command:

  # echo mem > /sys/power/state

    Check console messages, which should indicate that guest has been
  suspended.

  3) check guest status through HMP command "info status":

    (qemu) info status
     info status
     VM status: running

  Note it's "running", which is incorrect.

  QEMU version:

  # qemu-system-aarch64 --version
  QEMU emulator version 3.1.50 (v3.1.0-2203-g9403bcc)
  Copyright (c) 2003-2019 Fabrice Bellard and the QEMU Project developers

  The issue prevents user from resuming a suspended guest through
  "system_wakeup" HMP command, because QEMU thinks the guest is in
  running state and does nothing.

  I think the issues occurs because qemu_system_wakeup_request() doesn't
  get called. It seems the root cause is with ACPI related code.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1818207/+subscriptions
