Return-Path: <SRS0=Jnn8=YR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 359B3CA9EAF
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 22:47:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 08A572084C
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 22:47:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08A572084C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=keithp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52228 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNlt5-0000Q3-79
	for qemu-devel@archiver.kernel.org; Thu, 24 Oct 2019 18:47:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48791)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <keithp@keithp.com>) id 1iNlsL-0008IT-V4
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 18:46:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <keithp@keithp.com>) id 1iNlsK-000647-7d
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 18:46:37 -0400
Received: from home.keithp.com ([63.227.221.253]:36582 helo=elaine.keithp.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <keithp@keithp.com>) id 1iNlsJ-00062g-VZ
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 18:46:36 -0400
Received: from localhost (localhost [127.0.0.1])
 by elaine.keithp.com (Postfix) with ESMTP id 95DF93F22AA4
 for <qemu-devel@nongnu.org>; Thu, 24 Oct 2019 15:46:31 -0700 (PDT)
X-Virus-Scanned: Debian amavisd-new at keithp.com
Received: from elaine.keithp.com ([127.0.0.1])
 by localhost (elaine.keithp.com [127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id gPS-UOSQ_QDJ; Thu, 24 Oct 2019 15:46:31 -0700 (PDT)
Received: from keithp.com (unknown [172.58.45.131])
 by elaine.keithp.com (Postfix) with ESMTPSA id CCC4B3F22A62;
 Thu, 24 Oct 2019 15:46:30 -0700 (PDT)
Received: by keithp.com (Postfix, from userid 1000)
 id 29D23158212D; Thu, 24 Oct 2019 15:46:29 -0700 (PDT)
From: Keith Packard <keithp@keithp.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] Semihost SYS_READC implementation (v4)
Date: Thu, 24 Oct 2019 15:46:22 -0700
Message-Id: <20191024224622.12371-1-keithp@keithp.com>
X-Mailer: git-send-email 2.24.0.rc0
In-Reply-To: <89ada4b1-ee3d-a512-07c2-9bc1ba5806da@redhat.com>
References: <89ada4b1-ee3d-a512-07c2-9bc1ba5806da@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 63.227.221.253
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Keith Packard <keithp@keithp.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Provides a blocking call to read a character from the console using
semihosting.chardev, if specified. This takes some careful command
line options to use stdio successfully as the serial ports, monitor
and semihost all want to use stdio. Here's a sample set of command
line options which share stdio betwen semihost, monitor and serial
ports:

	qemu \
	-chardev stdio,mux=3Don,id=3Dstdio0 \
	-serial chardev:stdio0 \
	-semihosting-config enable=3Don,chardev=3Dstdio0 \
	-mon chardev=3Dstdio0,mode=3Dreadline

This creates a chardev hooked to stdio and then connects all of the
subsystems to it. A shorter mechanism would be good to hear about.

v2:
	Add implementation in linux-user/arm/semihost.c

v3:  (thanks to Paolo Bonzini <pbonzini@redhat.com>)
	Replace hand-rolled fifo with fifo8
	Avoid mixing code and declarations
	Remove spurious (void) cast of function parameters
	Define qemu_semihosting_console_init when CONFIG_USER_ONLY

v4:
	Add qemu_semihosting_console_init to stubs/semihost.c for
	hosts that don't support semihosting

Signed-off-by: Keith Packard <keithp@keithp.com>
---
 hw/semihosting/console.c          | 73 +++++++++++++++++++++++++++++++
 include/hw/semihosting/console.h  | 12 +++++
 include/hw/semihosting/semihost.h |  4 ++
 linux-user/arm/semihost.c         | 24 ++++++++++
 target/arm/arm-semi.c             |  3 +-
 vl.c                              |  3 ++
 6 files changed, 117 insertions(+), 2 deletions(-)

diff --git a/hw/semihosting/console.c b/hw/semihosting/console.c
index b4b17c8afb..197bff079b 100644
--- a/hw/semihosting/console.c
+++ b/hw/semihosting/console.c
@@ -98,3 +98,76 @@ void qemu_semihosting_console_outc(CPUArchState *env, =
target_ulong addr)
                       __func__, addr);
     }
 }
+
+#include <pthread.h>
+#include "chardev/char-fe.h"
+#include "sysemu/sysemu.h"
+#include "qemu/main-loop.h"
+#include "qapi/error.h"
+#include "qemu/fifo8.h"
+
+#define FIFO_SIZE   1024
+
+typedef struct SemihostingConsole {
+    CharBackend         backend;
+    pthread_mutex_t     mutex;
+    pthread_cond_t      cond;
+    bool                got;
+    Fifo8               fifo;
+} SemihostingConsole;
+
+static SemihostingConsole console =3D {
+    .mutex =3D PTHREAD_MUTEX_INITIALIZER,
+    .cond =3D PTHREAD_COND_INITIALIZER
+};
+
+static int console_can_read(void *opaque)
+{
+    SemihostingConsole *c =3D opaque;
+    int ret;
+    pthread_mutex_lock(&c->mutex);
+    ret =3D (int) fifo8_num_free(&c->fifo);
+    pthread_mutex_unlock(&c->mutex);
+    return ret;
+}
+
+static void console_read(void *opaque, const uint8_t *buf, int size)
+{
+    SemihostingConsole *c =3D opaque;
+    pthread_mutex_lock(&c->mutex);
+    while (size-- && !fifo8_is_full(&c->fifo)) {
+        fifo8_push(&c->fifo, *buf++);
+    }
+    pthread_cond_broadcast(&c->cond);
+    pthread_mutex_unlock(&c->mutex);
+}
+
+target_ulong qemu_semihosting_console_inc(CPUArchState *env)
+{
+    uint8_t ch;
+    SemihostingConsole *c =3D &console;
+    qemu_mutex_unlock_iothread();
+    pthread_mutex_lock(&c->mutex);
+    while (fifo8_is_empty(&c->fifo)) {
+        pthread_cond_wait(&c->cond, &c->mutex);
+    }
+    ch =3D fifo8_pop(&c->fifo);
+    pthread_mutex_unlock(&c->mutex);
+    qemu_mutex_lock_iothread();
+    return (target_ulong) ch;
+}
+
+void qemu_semihosting_console_init(void)
+{
+    Chardev *chr =3D semihosting_get_chardev();
+
+    if  (chr) {
+        fifo8_create(&console.fifo, FIFO_SIZE);
+        qemu_chr_fe_init(&console.backend, chr, &error_abort);
+        qemu_chr_fe_set_handlers(&console.backend,
+                                 console_can_read,
+                                 console_read,
+                                 NULL, NULL, &console,
+                                 NULL, true);
+    }
+}
diff --git a/include/hw/semihosting/console.h b/include/hw/semihosting/co=
nsole.h
index 9be9754bcd..f7d5905b41 100644
--- a/include/hw/semihosting/console.h
+++ b/include/hw/semihosting/console.h
@@ -37,6 +37,18 @@ int qemu_semihosting_console_outs(CPUArchState *env, t=
arget_ulong s);
  */
 void qemu_semihosting_console_outc(CPUArchState *env, target_ulong c);
=20
+/**
+ * qemu_semihosting_console_inc:
+ * @env: CPUArchState
+ *
+ * Receive single character from debug console. This
+ * may be the remote gdb session if a softmmu guest is currently being
+ * debugged.
+ *
+ * Returns: character read or -1 on error
+ */
+target_ulong qemu_semihosting_console_inc(CPUArchState *env);
+
 /**
  * qemu_semihosting_log_out:
  * @s: pointer to string
diff --git a/include/hw/semihosting/semihost.h b/include/hw/semihosting/s=
emihost.h
index 60fc42d851..b8ce5117ae 100644
--- a/include/hw/semihosting/semihost.h
+++ b/include/hw/semihosting/semihost.h
@@ -56,6 +56,9 @@ static inline Chardev *semihosting_get_chardev(void)
 {
     return NULL;
 }
+static inline void qemu_semihosting_console_init(void)
+{
+}
 #else /* !CONFIG_USER_ONLY */
 bool semihosting_enabled(void);
 SemihostingTarget semihosting_get_target(void);
@@ -68,6 +71,7 @@ Chardev *semihosting_get_chardev(void);
 void qemu_semihosting_enable(void);
 int qemu_semihosting_config_options(const char *opt);
 void qemu_semihosting_connect_chardevs(void);
+void qemu_semihosting_console_init(void);
 #endif /* CONFIG_USER_ONLY */
=20
 #endif /* SEMIHOST_H */
diff --git a/linux-user/arm/semihost.c b/linux-user/arm/semihost.c
index a16b525eec..13a097515b 100644
--- a/linux-user/arm/semihost.c
+++ b/linux-user/arm/semihost.c
@@ -47,3 +47,27 @@ void qemu_semihosting_console_outc(CPUArchState *env, =
target_ulong addr)
         }
     }
 }
+
+#include <poll.h>
+
+target_ulong qemu_semihosting_console_inc(CPUArchState *env)
+{
+    uint8_t c;
+    struct pollfd pollfd =3D {
+        .fd =3D STDIN_FILENO,
+        .events =3D POLLIN
+    };
+
+    if (poll(&pollfd, 1, -1) !=3D 1) {
+        qemu_log_mask(LOG_UNIMP, "%s: unexpected read from stdin failure=
",
+                      __func__);
+        return (target_ulong) -1;
+    }
+
+    if (read(STDIN_FILENO, &c, 1) !=3D 1) {
+        qemu_log_mask(LOG_UNIMP, "%s: unexpected read from stdin failure=
",
+                      __func__);
+        return (target_ulong) -1;
+    }
+    return (target_ulong) c;
+}
diff --git a/target/arm/arm-semi.c b/target/arm/arm-semi.c
index 6f7b6d801b..47d61f6fe1 100644
--- a/target/arm/arm-semi.c
+++ b/target/arm/arm-semi.c
@@ -802,8 +802,7 @@ target_ulong do_arm_semihosting(CPUARMState *env)
=20
         return guestfd_fns[gf->type].readfn(cpu, gf, arg1, len);
     case TARGET_SYS_READC:
-        qemu_log_mask(LOG_UNIMP, "%s: SYS_READC not implemented", __func=
__);
-        return 0;
+        return qemu_semihosting_console_inc(env);
     case TARGET_SYS_ISTTY:
         GET_ARG(0);
=20
diff --git a/vl.c b/vl.c
index 4489cfb2bb..ac584d97ea 100644
--- a/vl.c
+++ b/vl.c
@@ -4381,6 +4381,9 @@ int main(int argc, char **argv, char **envp)
     ds =3D init_displaystate();
     qemu_display_init(ds, &dpy);
=20
+    /* connect semihosting console input if requested */
+    qemu_semihosting_console_init();
+
     /* must be after terminal init, SDL library changes signal handlers =
*/
     os_setup_signal_handling();
=20
--=20
2.24.0.rc0


