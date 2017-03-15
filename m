Received: from eggs.gnu.org ([2001:4830:134:3::10]:46879)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu.bugs@whitewinterwolf.com>) id 1coD09-0007cv-JQ
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 13:46:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <qemu.bugs@whitewinterwolf.com>) id 1coD04-0000Hu-Ek
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 13:46:21 -0400
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:60509)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <qemu.bugs@whitewinterwolf.com>)
	id 1coD04-0000Em-7i
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 13:46:16 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Wed, 15 Mar 2017 18:46:11 +0100
From: Simon <qemu.bugs@whitewinterwolf.com>
In-Reply-To: <20170315144124.GP7770@redhat.com>
References: <11569d75b61122820f186a32cdd20689@whitewinterwolf.com>
	<20170315144124.GP7770@redhat.com>
Message-ID: <23d89ab3bd16ebf7a864ab75c300de7b@whitewinterwolf.com>
Subject: Re: [Qemu-devel] [Bug 1217339] [PATCH] Unix signal to send
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
Cc: qemu-devel@nongnu.org

Daniel P. Berrange:
> 
> While I understand your motivation this creates a semantic change for
> existing users of QEMU. IOW anyone who is currently relying on use
> of SIGHUP will experiance a regression when upgrading QEMU.
> 
> So if we want to signal to generate a clean shutdown, we need to pick
> one that QEMU hasn't already set a specific behaviour for.
> 
> SIGQUIT could be a valid option, or the super generic SIGUSR1
> 
> Regards,
> Daniel

Thanks for your answer Daniel.

OK for not using SIGHUP and keep SIGTERM, SIGINT and SIGHUP to have the
same behavior.

SIGQUIT is reserved for core files generation.

SIGUSR1 is already used in 'util/qemu-progress.c' to trigger a report
on ongoing jobs, so it does not seem usable.

SIGUSR2 is temporarily used in 'util/coroutine-sigaltstack.c' which
takes care however to preserve the original handler. I did not saw
any other place where it is used, so it seems to be a better candidate.

Here is a second version of my patch using SIGUSR2 to cleanly power off
the guest:

Signed-off-by: Simon Geusebroek <qemu.bugs@whitewinterwolf.com>
---
diff -ru qemu-2.8.0/os-posix.c qemu-new/os-posix.c
--- qemu-2.8.0/os-posix.c	2016-12-20 21:16:48.000000000 +0100
+++ qemu-new/os-posix.c	2017-03-15 17:45:28.290737575 +0100
@@ -72,6 +72,7 @@
      sigaction(SIGINT,  &act, NULL);
      sigaction(SIGHUP,  &act, NULL);
      sigaction(SIGTERM, &act, NULL);
+    sigaction(SIGUSR2, &act, NULL);
  }

  /* Find a likely location for support files using the location of the 
binary.
diff -ru qemu-2.8.0/vl.c qemu-new/vl.c
--- qemu-2.8.0/vl.c	2016-12-20 21:16:54.000000000 +0100
+++ qemu-new/vl.c	2017-03-15 17:45:20.866737459 +0100
@@ -1871,7 +1871,11 @@
      /* Cannot call qemu_system_shutdown_request directly because
       * we are in a signal handler.
       */
-    shutdown_requested = 1;
+    if (signal == SIGUSR2) {
+        powerdown_requested = 1;
+    } else {
+        shutdown_requested = 1;
+    }
      qemu_notify_event();
  }

--
