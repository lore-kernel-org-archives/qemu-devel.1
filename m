Received: from eggs.gnu.org ([2001:4830:134:3::10]:38194)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fYdAp-0007RC-9Y
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 16:05:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fYdAo-0000mx-FC
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 16:05:47 -0400
Received: from mail-wr0-x243.google.com ([2a00:1450:400c:c0c::243]:46660)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1fYdAo-0000lb-8u
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 16:05:46 -0400
Received: by mail-wr0-x243.google.com with SMTP id t6-v6so6665863wrq.13
	for <qemu-devel@nongnu.org>; Thu, 28 Jun 2018 13:05:46 -0700 (PDT)
Received: from 640k.lan ([82.84.124.111]) by smtp.gmail.com with ESMTPSA id
	127-v6sm6211110wmd.18.2018.06.28.13.05.44 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 28 Jun 2018 13:05:44 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 28 Jun 2018 22:04:42 +0200
Message-Id: <1530216310-52873-33-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1530216310-52873-1-git-send-email-pbonzini@redhat.com>
References: <1530216310-52873-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 32/60] pr-helper: fix --socket-path default in
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
