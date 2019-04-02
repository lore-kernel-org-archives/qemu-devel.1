Received: from eggs.gnu.org ([209.51.188.92]:60881)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1hBFde-00026P-5N
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 05:23:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1hBFb8-0006HR-Ag
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 05:20:51 -0400
Received: from indium.canonical.com ([91.189.90.7]:33476)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1hBFb8-00068F-1O
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 05:20:50 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1hBFb6-0004qd-2Q
	for <qemu-devel@nongnu.org>; Tue, 02 Apr 2019 09:20:48 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id ED9DC2E86B8
	for <qemu-devel@nongnu.org>; Tue,  2 Apr 2019 09:20:47 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 02 Apr 2019 09:08:29 -0000
From: Huan Xiong <1818207@bugs.launchpad.net>
Reply-To: Bug 1818207 <1818207@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <155143526311.31693.6210776474492711183.malonedeb@wampee.canonical.com>
Message-Id: <155419610933.853.5858813581276958009.malone@wampee.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1818207] Re: [aarch64] VM status remains
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

Hi Laszlo,

Thanks much for your detailed explanation. It has been very helpful.

> In order for the guest kernel to expose ACPI S3 suspend to a privileged
> guest user, the guest kernel first checks if the platform (hardware and
> firmware) support ACPI S3. This in turn depends on whether the DSDT
> offers a package called _S3.
>
> ...
> =

> On the "virt" machine type, the "_S3" package is not generated at all,
> in the DSDT. For this reason, ACPI S3 is never valid for the guest
> kernel to expose.

Now that you said that, I googled about this and found ARM has PSCI,
which is an ARM specific PM interface standard and can be used together
with ACPI or FDT:

http://infocenter.arm.com/help/topic/com.arm.doc.den0022d/Power_State_Coord=
ination_Interface_PDD_v1_1_DEN0022D.pdf

The spec defines SYSTEM_SUSPEND in section 5.19. The command was =

introduced in PSCI 1.0 for similar purpose as ACPI S3. It's optional.

Then I find the following:

1) My VM's firmware supports PCSI v1.0. The following were from dmesg:

[    0.000000] psci: probing for conduit method from ACPI.
[    0.000000] psci: PSCIv1.0 detected in firmware.
[    0.000000] psci: Using standard PSCI v0.2 function IDs
[    0.000000] psci: Trusted OS migration not required

2) The PSCI code in QEMU supports 0.2 version only. See
target/arm/psci.c.

I don't completely understand how they work together (for example, I think
PSCI requests should be handled by firmware, how come QEMU gets a chance
to handle them), but I guess the issue might be with QEMU not supporting PS=
CI 1.0.

> # cat /sys/power/mem_sleep
> [s2idle] =


Yes, I observed the same on both my VM and host (my host's firmware supports
PSCI 1.0 also, not sure why kernel thinks it doesn't support suspend-to-RAM=
).

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1818207

Title:
  [aarch64] VM status remains "running" after it's suspended

Status in QEMU:
  Invalid

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
