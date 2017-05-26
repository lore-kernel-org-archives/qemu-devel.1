Received: from eggs.gnu.org ([2001:4830:134:3::10]:51644)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dE7D8-0002Wh-ML
	for qemu-devel@nongnu.org; Fri, 26 May 2017 00:50:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dE7D4-0003Gs-OQ
	for qemu-devel@nongnu.org; Fri, 26 May 2017 00:50:50 -0400
Received: from indium.canonical.com ([91.189.90.7]:51606)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1dE7D4-0003GF-IT
	for qemu-devel@nongnu.org; Fri, 26 May 2017 00:50:46 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1dE7D3-0008LK-46
	for <qemu-devel@nongnu.org>; Fri, 26 May 2017 04:50:45 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 1BC7C2E8025
	for <qemu-devel@nongnu.org>; Fri, 26 May 2017 04:50:45 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 26 May 2017 04:40:41 -0000
From: Paul Goyette <1693649@bugs.launchpad.net>
Reply-To: Bug 1693649 <1693649@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <149575946555.18286.18117412791023512529.malonedeb@chaenomeles.canonical.com>
Message-Id: <149577364154.17847.3073963205420272418.malone@chaenomeles.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1693649] Re: x86 pause misbehaves with -cpu
 haswell
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Further investigation shows that pause may be working, but very very
slowly.

The "use-case" in NetBSD is for "hatching" application CPUs.  The target
CPU runs a loop that does

    while (flag_1 not set)
        for (i =3D 0; i < 10000; i++)
            x86_pause();                 /* which is assembly code:  "pause=
; ret;" */
    ...
    set flag_2;
    return;

The boot CPU executes the following code for each application CPU:

    set flag_1;
    for (i =3D 0; i < 100000 && flag_2 not set; i++)
        i8254_delay(10);             /* this should be 10usec per iteration=
, 1.0 sec total */
    if (flag_2 not set)
        panic(cpu did not hatch);
    ....

So, the 10k executions of x86_pause are taking in excess of 1 sec to
complete.  Indeed, reducing that constant value from 10k to only 100
results in the same failure.  So it would seem that the pause
instruction is taking an extremely long time to complete.  (Further
reducing the interation count to only 50 results in success, although it
"feels" very sluggish.)

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1693649

Title:
  x86 pause misbehaves with -cpu haswell

Status in QEMU:
  New

Bug description:
  Using qemu-2.9.0

  When booting NetBSD using '-cpu haswell -smp 4', the system fails to
  initialize the additional CPUs.  It appears as though the "application
  processor" enters routine x86_pause() but never returns.

  x86_pause() is simply two assembler instructions: 'pause; ret;'

  Replacing the routine with 'nop; nop; ret;' allows the system to
  proceed, of course without the benefit of the pause instruction on
  spin-loops!

  Additionally, booting with '-cpu phenom -smp 4' also works, although
  the system does seem confused about the type of CPU being used.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1693649/+subscriptions
