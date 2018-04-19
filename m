Received: from eggs.gnu.org ([2001:4830:134:3::10]:60653)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=6403088e3=Ian.Jackson@citrix.com>)
	id 1f9Ch1-0002I5-Az
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 12:45:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=6403088e3=Ian.Jackson@citrix.com>)
	id 1f9Ch0-0006Ie-Dh
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 12:45:55 -0400
Received: from smtp03.citrix.com ([162.221.156.55]:53463)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <prvs=6403088e3=Ian.Jackson@citrix.com>)
	id 1f9Cgz-00069l-Sa
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 12:45:54 -0400
From: Ian Jackson <ian.jackson@eu.citrix.com>
Date: Thu, 19 Apr 2018 17:45:18 +0100
Message-ID: <1524156319-11465-16-git-send-email-ian.jackson@eu.citrix.com>
In-Reply-To: <1524156319-11465-1-git-send-email-ian.jackson@eu.citrix.com>
References: <1524156319-11465-1-git-send-email-ian.jackson@eu.citrix.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH 15/16] os-posix: cleanup: Replace perror with
 error_report
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Ross Lagerwall <ross.lagerwall@citrix.com>, Anthony PERARD <anthony.perard@citrix.com>, Juergen Gross <jgross@suse.com>, Stefano Stabellini <sstabellini@kernel.org>, xen-devel@lists.xenproject.org, Ian Jackson <ian.jackson@eu.citrix.com>, Ian Jackson <Ian.Jackson@eu.citrix.com>, Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>, Alistair Francis <alistair.francis@xilinx.com>

perror() is defined to fprintf(stderr,...).  HACKING says
fprintf(stderr,...) is wrong.  So perror() is too.

Signed-off-by: Ian Jackson <Ian.Jackson@eu.citrix.com>
CC: Paolo Bonzini <pbonzini@redhat.com>
CC: Markus Armbruster <armbru@redhat.com>
CC: Daniel P. Berrange <berrange@redhat.com>
CC: Michael Tokarev <mjt@tls.msk.ru>
CC: Alistair Francis <alistair.francis@xilinx.com>
---
v7: New patch
---
 os-posix.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/os-posix.c b/os-posix.c
index d4cf466..0108028 100644
--- a/os-posix.c
+++ b/os-posix.c
@@ -125,7 +125,7 @@ void os_set_proc_name(const char *s)
     /* Could rewrite argv[0] too, but that's a bit more complicated.
        This simple way is enough for `top'. */
     if (prctl(PR_SET_NAME, name)) {
-        perror("unable to change process name");
+        error_report("unable to change process name: %s", strerror(errno));
         exit(1);
     }
 #else
@@ -247,7 +247,7 @@ static void change_root(void)
             exit(1);
         }
         if (chdir("/")) {
-            perror("not able to chdir to /");
+            error_report("not able to chdir to /: %s", strerror(errno));
             exit(1);
         }
     }
@@ -309,7 +309,7 @@ void os_setup_post(void)
 
     if (daemonize) {
         if (chdir("/")) {
-            perror("not able to chdir to /");
+            error_report("not able to chdir to /: %s", strerror(errno));
             exit(1);
         }
         TFR(fd = qemu_open("/dev/null", O_RDWR));
@@ -383,7 +383,7 @@ int os_mlock(void)
 
     ret = mlockall(MCL_CURRENT | MCL_FUTURE);
     if (ret < 0) {
-        perror("mlockall");
+        error_report("mlockall: %s", strerror(errno));
     }
 
     return ret;
-- 
2.1.4
