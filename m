Received: from eggs.gnu.org ([2001:4830:134:3::10]:46844)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eadlL-0006iL-Qk
	for qemu-devel@nongnu.org; Sun, 14 Jan 2018 03:35:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eadlG-0004x1-Mr
	for qemu-devel@nongnu.org; Sun, 14 Jan 2018 03:35:31 -0500
Received: from indium.canonical.com ([91.189.90.7]:51956)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1eadlG-0004u0-D6
	for qemu-devel@nongnu.org; Sun, 14 Jan 2018 03:35:26 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1eadlD-0003ak-Pt
	for <qemu-devel@nongnu.org>; Sun, 14 Jan 2018 08:35:23 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id BB56C2E804B
	for <qemu-devel@nongnu.org>; Sun, 14 Jan 2018 08:35:23 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sun, 14 Jan 2018 08:29:01 -0000
From: Andreas Gustafsson <gson@gson.org>
Reply-To: Bug 1743191 <1743191@bugs.launchpad.net>
Sender: bounces@canonical.com
Message-Id: <151591854188.4596.10964938100242408667.malonedeb@wampee.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1743191] [NEW] Interacting with NetBSD serial
 console boot blocks no longer works
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

The NetBSD boot blocks display a menu allowing the user to make a
selection using the keyboard.  For example, when booting a NetBSD
installation CD-ROM, the menu looks like this:

         1. Install NetBSD
         2. Install NetBSD (no ACPI)
         3. Install NetBSD (no ACPI, no SMP)
         4. Drop to boot prompt

    Choose an option; RETURN for default; SPACE to stop countdown.
    Option 1 will be chosen in 30 seconds.

When booting NetBSD in a recent qemu using an emulated serial console,
making this menu selection no longer works: when you type the selected
number, the keyboard input is ignored, and the 30-second countdown
continues.  In older versions of qemu, it works.

To reproduce the problem, run:

   wget http://ftp.netbsd.org/pub/NetBSD/NetBSD-7.1.1/amd64/installation/cd=
rom/boot-com.iso
   qemu-system-x86_64 -nographic -cdrom boot-com.iso

During the 30-second countdown, press 4

Expected behavior: The countdown stops and you get a ">" prompt

Incorrect behavior: The countdown continues

There may also be some corruption of the terminal output; for example,
"Option 1 will be chosen in 30 seconds" may be displayed as "Option 1
will be chosen in p0 seconds".

Using bisection, I have determined that the problem appeared with qemu
commit 083fab0290f2c40d3d04f7f22eed9c8f2d5b6787, in which seabios was
updated to 1.11 prerelease, and the problem is still there as of
commit 7398166ddf7c6dbbc9cae6ac69bb2feda14b40ac.  The host operating
system used for the tests was Debian 9 x86_64.

Credit for discovering this bug goes to Paul Goyette.

** Affects: qemu
     Importance: Undecided
         Status: New


** Tags: regression

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1743191

Title:
  Interacting with NetBSD serial console boot blocks no longer works

Status in QEMU:
  New

Bug description:
  The NetBSD boot blocks display a menu allowing the user to make a
  selection using the keyboard.  For example, when booting a NetBSD
  installation CD-ROM, the menu looks like this:

           1. Install NetBSD
           2. Install NetBSD (no ACPI)
           3. Install NetBSD (no ACPI, no SMP)
           4. Drop to boot prompt

      Choose an option; RETURN for default; SPACE to stop countdown.
      Option 1 will be chosen in 30 seconds.

  When booting NetBSD in a recent qemu using an emulated serial console,
  making this menu selection no longer works: when you type the selected
  number, the keyboard input is ignored, and the 30-second countdown
  continues.  In older versions of qemu, it works.

  To reproduce the problem, run:

     wget http://ftp.netbsd.org/pub/NetBSD/NetBSD-7.1.1/amd64/installation/=
cdrom/boot-com.iso
     qemu-system-x86_64 -nographic -cdrom boot-com.iso

  During the 30-second countdown, press 4

  Expected behavior: The countdown stops and you get a ">" prompt

  Incorrect behavior: The countdown continues

  There may also be some corruption of the terminal output; for example,
  "Option 1 will be chosen in 30 seconds" may be displayed as "Option 1
  will be chosen in p0 seconds".

  Using bisection, I have determined that the problem appeared with qemu
  commit 083fab0290f2c40d3d04f7f22eed9c8f2d5b6787, in which seabios was
  updated to 1.11 prerelease, and the problem is still there as of
  commit 7398166ddf7c6dbbc9cae6ac69bb2feda14b40ac.  The host operating
  system used for the tests was Debian 9 x86_64.

  Credit for discovering this bug goes to Paul Goyette.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1743191/+subscriptions
