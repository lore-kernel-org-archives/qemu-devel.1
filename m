Received: from eggs.gnu.org ([2001:4830:134:3::10]:36376)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fYd36-0002DD-Ay
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 15:57:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fYd33-0000SR-RI
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 15:57:48 -0400
Received: from mail-wm0-x229.google.com ([2a00:1450:400c:c09::229]:50987)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1fYd33-0000Qk-Ki
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 15:57:45 -0400
Received: by mail-wm0-x229.google.com with SMTP id e16-v6so10965341wmd.0
	for <qemu-devel@nongnu.org>; Thu, 28 Jun 2018 12:57:45 -0700 (PDT)
Received: from 640k.lan ([82.84.124.111]) by smtp.gmail.com with ESMTPSA id
	d102-v6sm12516646wma.10.2018.06.28.12.57.43
	for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 28 Jun 2018 12:57:43 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 28 Jun 2018 21:57:33 +0200
Message-Id: <1530215858-1525-2-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1530215858-1525-1-git-send-email-pbonzini@redhat.com>
References: <1530215858-1525-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 1/6] pr-helper: fix --socket-path default in
 help
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Currently --help shows "(default '(null)')" for the -k/--socket-path
option.  Fix it by getting the default path in /var/run.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 scsi/qemu-pr-helper.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/scsi/qemu-pr-helper.c b/scsi/qemu-pr-helper.c
index d0f8317..4057cf3 100644
--- a/scsi/qemu-pr-helper.c
+++ b/scsi/qemu-pr-helper.c
@@ -74,8 +74,16 @@ static int uid = -1;
 static int gid = -1;
 #endif
 
+static void compute_default_paths(void)
+{
+    if (!socket_path) {
+        socket_path = qemu_get_local_state_pathname("run/qemu-pr-helper.sock");
+    }
+}
+
 static void usage(const char *name)
 {
+    compute_default_paths();
     (printf) (
 "Usage: %s [OPTIONS] FILE\n"
 "Persistent Reservation helper program for QEMU\n"
@@ -845,13 +853,6 @@ static const char *socket_activation_validate_opts(void)
     return NULL;
 }
 
-static void compute_default_paths(void)
-{
-    if (!socket_path) {
-        socket_path = qemu_get_local_state_pathname("run/qemu-pr-helper.sock");
-    }
-}
-
 static void termsig_handler(int signum)
 {
     atomic_cmpxchg(&state, RUNNING, TERMINATE);
-- 
1.8.3.1
