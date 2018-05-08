Received: from eggs.gnu.org ([2001:4830:134:3::10]:41281)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fGAt2-00030i-73
	for qemu-devel@nongnu.org; Tue, 08 May 2018 18:15:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fGAt1-0001Ok-8T
	for qemu-devel@nongnu.org; Tue, 08 May 2018 18:15:08 -0400
Received: from mail-wm0-x241.google.com ([2a00:1450:400c:c09::241]:33423)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1fGAt1-0001O5-1W
	for qemu-devel@nongnu.org; Tue, 08 May 2018 18:15:07 -0400
Received: by mail-wm0-x241.google.com with SMTP id x12-v6so20840485wmc.0
	for <qemu-devel@nongnu.org>; Tue, 08 May 2018 15:15:06 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed,  9 May 2018 00:14:30 +0200
Message-Id: <1525817687-34620-14-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1525817687-34620-1-git-send-email-pbonzini@redhat.com>
References: <1525817687-34620-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 13/30] accel: use g_strsplit for parsing
 accelerator names
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Daniel P. Berrangé <berrange@redhat.com>

Instead of re-using the get_opt_name() method from QemuOpts to split a
string on ':', just use g_strsplit().

Signed-off-by: Daniel P. BerrangÃ© <berrange@redhat.com>
Message-Id: <20180416111743.8473-2-berrange@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 accel/accel.c         | 16 +++++++---------
 include/qemu/option.h |  1 -
 util/qemu-option.c    |  3 ++-
 3 files changed, 9 insertions(+), 11 deletions(-)

diff --git a/accel/accel.c b/accel/accel.c
index 9cfab11..966b2d8 100644
--- a/accel/accel.c
+++ b/accel/accel.c
@@ -70,8 +70,8 @@ static int accel_init_machine(AccelClass *acc, MachineState *ms)
 
 void configure_accelerator(MachineState *ms)
 {
-    const char *accel, *p;
-    char buf[10];
+    const char *accel;
+    char **accel_list, **tmp;
     int ret;
     bool accel_initialised = false;
     bool init_failed = false;
@@ -83,13 +83,10 @@ void configure_accelerator(MachineState *ms)
         accel = "tcg";
     }
 
-    p = accel;
-    while (!accel_initialised && *p != '\0') {
-        if (*p == ':') {
-            p++;
-        }
-        p = get_opt_name(buf, sizeof(buf), p, ':');
-        acc = accel_find(buf);
+    accel_list = g_strsplit(accel, ":", 0);
+
+    for (tmp = accel_list; !accel_initialised && tmp && *tmp; tmp++) {
+        acc = accel_find(*tmp);
         if (!acc) {
             continue;
         }
@@ -107,6 +104,7 @@ void configure_accelerator(MachineState *ms)
             accel_initialised = true;
         }
     }
+    g_strfreev(accel_list);
 
     if (!accel_initialised) {
         if (!init_failed) {
diff --git a/include/qemu/option.h b/include/qemu/option.h
index 306fdb5..1cfe5cb 100644
--- a/include/qemu/option.h
+++ b/include/qemu/option.h
@@ -28,7 +28,6 @@
 
 #include "qemu/queue.h"
 
-const char *get_opt_name(char *buf, int buf_size, const char *p, char delim);
 const char *get_opt_value(char *buf, int buf_size, const char *p);
 
 void parse_option_size(const char *name, const char *value,
diff --git a/util/qemu-option.c b/util/qemu-option.c
index d0756fd..baca40f 100644
--- a/util/qemu-option.c
+++ b/util/qemu-option.c
@@ -49,7 +49,8 @@
  * The return value is the position of the delimiter/zero byte after the option
  * name in p.
  */
-const char *get_opt_name(char *buf, int buf_size, const char *p, char delim)
+static const char *get_opt_name(char *buf, int buf_size, const char *p,
+                                char delim)
 {
     char *q;
 
-- 
1.8.3.1
