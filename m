Received: from eggs.gnu.org ([2001:4830:134:3::10]:34311)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fXq57-0008Ni-C8
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 11:40:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fXq54-0005db-A0
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 11:40:37 -0400
Received: from mail-wr0-x241.google.com ([2a00:1450:400c:c0c::241]:45951)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1fXq54-0005dE-3y
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 11:40:34 -0400
Received: by mail-wr0-x241.google.com with SMTP id u7-v6so2464136wrn.12
	for <qemu-devel@nongnu.org>; Tue, 26 Jun 2018 08:40:33 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 26 Jun 2018 17:40:24 +0200
Message-Id: <20180626154028.11133-2-pbonzini@redhat.com>
In-Reply-To: <20180626154028.11133-1-pbonzini@redhat.com>
References: <20180626154028.11133-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 1/5] pr-helper: fix --socket-path default in
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
Cc: mprivozn@redhat.com

Currently --help shows "(default '(null)')" for the -k/--socket-path
option.  Fix it by getting the default path in /var/run.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 scsi/qemu-pr-helper.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/scsi/qemu-pr-helper.c b/scsi/qemu-pr-helper.c
index d0f83176e1..4057cf355c 100644
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
2.17.1
