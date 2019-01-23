Received: from eggs.gnu.org ([209.51.188.92]:40889)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1gmKvM-0006tv-I0
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 10:58:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1gmKvL-0005Rj-Bx
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 10:58:44 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59494)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1gmKvL-0005QY-1X
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 10:58:43 -0500
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Wed, 23 Jan 2019 15:58:22 +0000
Message-Id: <20190123155830.8459-2-dgilbert@redhat.com>
In-Reply-To: <20190123155830.8459-1-dgilbert@redhat.com>
References: <20190123155830.8459-1-dgilbert@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 1/9] Fix segmentation fault when
 qemu_signal_init fails
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: quintela@redhat.com, peterx@redhat.com, xiaoguangrong@tencent.com, marcandre.lureau@redhat.com, shirley17fei@gmail.com, lifei1214@126.com

From: Fei Li <fli@suse.com>

When qemu_signal_init() fails in qemu_init_main_loop(), we return
without setting an error.  Its callers crash then when they try to
report the error with error_report_err().

To avoid such segmentation fault, add a new Error parameter to make
the call trace to propagate the err to the final caller.

Fixes: 2f78e491d7b46542158ce0b8132ee4e05bc0ade4
Cc: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Fei Li <fli@suse.com>
Reviewed-by: Fam Zheng <famz@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Message-Id: <20190113140849.38339-2-lifei1214@126.com>
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 util/main-loop.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/util/main-loop.c b/util/main-loop.c
index affe0403c5..443cb4cfe8 100644
--- a/util/main-loop.c
+++ b/util/main-loop.c
@@ -71,7 +71,7 @@ static void sigfd_handler(void *opaque)
     }
 }
=20
-static int qemu_signal_init(void)
+static int qemu_signal_init(Error **errp)
 {
     int sigfd;
     sigset_t set;
@@ -96,7 +96,7 @@ static int qemu_signal_init(void)
     sigdelset(&set, SIG_IPI);
     sigfd =3D qemu_signalfd(&set);
     if (sigfd =3D=3D -1) {
-        fprintf(stderr, "failed to create signalfd\n");
+        error_setg_errno(errp, errno, "failed to create signalfd");
         return -errno;
     }
=20
@@ -109,7 +109,7 @@ static int qemu_signal_init(void)
=20
 #else /* _WIN32 */
=20
-static int qemu_signal_init(void)
+static int qemu_signal_init(Error **errp)
 {
     return 0;
 }
@@ -148,7 +148,7 @@ int qemu_init_main_loop(Error **errp)
=20
     init_clocks(qemu_timer_notify_cb);
=20
-    ret =3D qemu_signal_init();
+    ret =3D qemu_signal_init(errp);
     if (ret) {
         return ret;
     }
--=20
2.20.1
