Received: from eggs.gnu.org ([2001:4830:134:3::10]:51868)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu.bugs@whitewinterwolf.com>) id 1co9Ff-00058p-7b
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 09:46:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <qemu.bugs@whitewinterwolf.com>) id 1co9Fa-0001GV-Bh
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 09:46:07 -0400
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:36967)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <qemu.bugs@whitewinterwolf.com>)
	id 1co9Fa-0001Ec-3n
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 09:46:02 -0400
Received: from mfilter49-d.gandi.net (mfilter49-d.gandi.net [217.70.178.180])
	by relay6-d.mail.gandi.net (Postfix) with ESMTP id 180C1FB882
	for <qemu-devel@nongnu.org>; Wed, 15 Mar 2017 14:45:59 +0100 (CET)
Received: from relay6-d.mail.gandi.net ([IPv6:::ffff:217.70.183.198])
	by mfilter49-d.gandi.net (mfilter49-d.gandi.net [::ffff:10.0.15.180])
	(amavisd-new, port 10024)
	with ESMTP id 3JW_rLvvvIRW for <qemu-devel@nongnu.org>;
	Wed, 15 Mar 2017 14:45:57 +0100 (CET)
Received: from webmail.eu.com (webmail5-d.mgt.gandi.net [10.58.1.145])
	(Authenticated sender: lists@whitewinterwolf.com)
	by relay6-d.mail.gandi.net (Postfix) with ESMTPA id A8323FB8A3
	for <qemu-devel@nongnu.org>; Wed, 15 Mar 2017 14:45:57 +0100 (CET)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Wed, 15 Mar 2017 14:45:57 +0100
From: Simon <qemu.bugs@whitewinterwolf.com>
Message-ID: <11569d75b61122820f186a32cdd20689@whitewinterwolf.com>
Subject: [Qemu-devel] [Bug 1217339] [PATCH] Unix signal to send
 ACPI-shutdown to Guest
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Hello,

Here is a short patch answering to Qemu wish-list issue 1217339.
<https://bugs.launchpad.net/qemu/+bug/1217339>
It makes Qemu to cleanly power off the guest when receiving a SIGHUP
signal, thus without requiring any monitor access which is currently
impossible (AFAIK).

The original issue mentions using SIGQUIT in its title, however as
Laszlo explained in the bug thread SIGQUIT is designed for debugging
purposes and is less about quitting than generating a core file. The
original request also explicitly mentioned that:

> If, for some reason SIGQUIT would not be accepted as the signal, take
> any free to use signal, like USR1.

Qemu currently maps SIGTERM, SIGINT and SIGHUP to a brutal shutdown of
the guest. This patch does not alter Qemu behavior for SIGTERM and
SIGQUIT, and maps SIGHUP to the clean power off of the guest.

IMHO SIGTERM and SIGINT behavior should not be altered:

- SIGTERM is the preferred alternative to a SIGKILL to shutdown a stuck
   guest.
- SIGINT is mostly a matter of user expectation as it handles the Ctrl-C
   sequence, I suppose that most users expect a brutal shutdown as it is
   now but this is just a random guess.

SIGHUP is a more versatile signal, also used for instance to tell a
daemon to reload its configuration files. From a functional point-of-
view, for me it makes sense to use a "hang-up" signal to power off a
guest, more than an impersonal USR1 signal, but this remains easily
changeable would SIGHUP not be suitable for this purpose.

With this patch applied, it becomes possible to easily and cleanly shut-
down Qemu virtual machines system-wide without involving any monitor:

1. Send SIGHUP to all Qemu processes so the guests power off cleanly.
2. After a few time send SIGTERM to the remaining Qemu processes to
    forcefully close stuck guests.
3. After a few time send SIGKILL to the remaining Qemu processes to
    forcefully close stuck Qemu hypervisor processes.

I find this more convenient than having to tinker with Qemu monitor to
implement step 1 as it must currently be done.

Signed-off-by: Simon Geusebroek <qemu.bugs@whitewinterwolf.com>
---
diff -ur a/vl.c b/vl.c
--- a/vl.c	2016-12-20 21:16:54.000000000 +0100
+++ b/vl.c	2017-03-14 16:02:51.959911847 +0100
@@ -1871,7 +1871,11 @@
      /* Cannot call qemu_system_shutdown_request directly because
       * we are in a signal handler.
       */
-    shutdown_requested = 1;
+    if (signal == SIGHUP) {
+        powerdown_requested = 1;
+    } else {
+        shutdown_requested = 1;
+    }
      qemu_notify_event();
  }

--
