Received: from eggs.gnu.org ([2001:4830:134:3::10]:41624)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu.bugs@whitewinterwolf.com>) id 1cpEc5-0001KS-Q3
	for qemu-devel@nongnu.org; Sat, 18 Mar 2017 09:41:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <qemu.bugs@whitewinterwolf.com>) id 1cpEc2-0006qP-Nn
	for qemu-devel@nongnu.org; Sat, 18 Mar 2017 09:41:45 -0400
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:52912)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <qemu.bugs@whitewinterwolf.com>)
	id 1cpEbj-0006eW-CW
	for qemu-devel@nongnu.org; Sat, 18 Mar 2017 09:41:42 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Sat, 18 Mar 2017 14:41:16 +0100
From: Simon <qemu.bugs@whitewinterwolf.com>
In-Reply-To: <20170316102652.GG15193@redhat.com>
References: <11569d75b61122820f186a32cdd20689@whitewinterwolf.com>
	<20170315144124.GP7770@redhat.com>
	<23d89ab3bd16ebf7a864ab75c300de7b@whitewinterwolf.com>
	<CAFEAcA-9GXiS+ByQgo+=tQ-_ZGR5egDcZMurEyfiA9vPkE9O9w@mail.gmail.com>
	<20170315180822.GU7770@redhat.com>
	<CAFEAcA-WzT80S_NJb8rSALspBZcCQbT7eounFn9HusjtLWoi_Q@mail.gmail.com>
	<20170316102652.GG15193@redhat.com>
Message-ID: <14585f602461dbefb3adaf16591ce5e5@whitewinterwolf.com>
Subject: Re: [Qemu-devel] [Bug 1217339] [PATCH v2] Unix signal to send
 ACPI-shutdown to Guest
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>

Hi,

The patch below adds the new command-line option `-powerdown' which
changes the behavior for both SIGHUP and SIGINT signals to cause a clean
power down of the guest using an ACPI shutdown request.

If this option is not used, the original behavior is kept.

Regards,
Simon.

Signed-off-by: Simon Geusebroek <qemu.bugs@whitewinterwolf.com>
---
diff -ru a/qemu-options.hx b/qemu-options.hx
--- a/qemu-options.hx	2016-12-20 21:16:49.000000000 +0100
+++ b/qemu-options.hx	2017-03-18 14:17:35.759915414 +0100
@@ -3322,6 +3322,19 @@
  disk image.
  ETEXI

+DEF("powerdown", 0, QEMU_OPTION_powerdown, \
+    "-powerdown    Cleanly power down the guest on SIGINT or SIGHUP\n", 
\
+    QEMU_ARCH_ALL)
+STEXI
+@item -powerdown
+@findex -powerdown
+Don't forcefully shutdown the guest upon SIGINT (Ctrl-C) or SIGHUP 
(terminal
+closure) signals, but instead attempt to cleanly stop them using an 
ACPI
+shutdown request.
+Non ACPI-aware and stuck guests will remain up, the SIGTERM signal will 
still
+forcefully shutdown them.
+ETEXI
+
  DEF("loadvm", HAS_ARG, QEMU_OPTION_loadvm, \
      "-loadvm [tag|id]\n" \
      "                start right away with a saved state (loadvm in 
monitor)\n",
diff -ru a/vl.c b/vl.c
--- a/vl.c	2016-12-20 21:16:54.000000000 +0100
+++ b/vl.c	2017-03-18 13:48:21.227967255 +0100
@@ -164,6 +164,7 @@
  int fd_bootchk = 1;
  static int no_reboot;
  int no_shutdown = 0;
+int powerdown = 0;
  int cursor_hide = 1;
  int graphic_rotate = 0;
  const char *watchdog;
@@ -1871,7 +1872,11 @@
      /* Cannot call qemu_system_shutdown_request directly because
       * we are in a signal handler.
       */
-    shutdown_requested = 1;
+    if (powerdown == 1 && (signal == SIGINT || signal == SIGHUP)) {
+        powerdown_requested = 1;
+    } else {
+        shutdown_requested = 1;
+    }
      qemu_notify_event();
  }

@@ -3794,6 +3799,9 @@
              case QEMU_OPTION_no_shutdown:
                  no_shutdown = 1;
                  break;
+            case QEMU_OPTION_powerdown:
+                powerdown = 1;
+                break;
              case QEMU_OPTION_show_cursor:
                  cursor_hide = 0;
                  break;
--
