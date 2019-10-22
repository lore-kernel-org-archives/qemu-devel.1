Return-Path: <SRS0=tSBD=YP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95211CA9EB9
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 04:51:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6D3972184C
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 04:51:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D3972184C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=keithp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50250 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMm8c-0006f9-Fs
	for qemu-devel@archiver.kernel.org; Tue, 22 Oct 2019 00:51:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45989)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <keithp@keithp.com>) id 1iMkcR-0003as-2X
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 23:14:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <keithp@keithp.com>) id 1iMkcP-0004cS-JB
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 23:13:59 -0400
Received: from home.keithp.com ([63.227.221.253]:60146 helo=elaine.keithp.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <keithp@keithp.com>)
 id 1iMkcM-0004aI-7P; Mon, 21 Oct 2019 23:13:54 -0400
Received: from localhost (localhost [127.0.0.1])
 by elaine.keithp.com (Postfix) with ESMTP id 718A43F21CC4;
 Mon, 21 Oct 2019 20:13:50 -0700 (PDT)
X-Virus-Scanned: Debian amavisd-new at keithp.com
Received: from elaine.keithp.com ([127.0.0.1])
 by localhost (elaine.keithp.com [127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id D560BGZa7Q4f; Mon, 21 Oct 2019 20:13:50 -0700 (PDT)
Received: from keithp.com (koto.keithp.com [10.0.0.2])
 by elaine.keithp.com (Postfix) with ESMTPSA id DDEBB3F21BD9;
 Mon, 21 Oct 2019 20:13:49 -0700 (PDT)
Received: by keithp.com (Postfix, from userid 1000)
 id 7D0A11582187; Mon, 21 Oct 2019 20:13:49 -0700 (PDT)
From: Keith Packard <keithp@keithp.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] Semihost SYS_READC implementation
Date: Mon, 21 Oct 2019 20:13:35 -0700
Message-Id: <20191022031335.9880-1-keithp@keithp.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 63.227.221.253
X-Mailman-Approved-At: Tue, 22 Oct 2019 00:50:14 -0400
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Keith Packard <keithp@keithp.com>,
 qemu-arm@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Provides a blocking call to read a character from the console by hooking
into the console input chain. This happens *after* any uart has hooked in=
,
so specifying -semihost overrides input to any emulated uarts.

Signed-off-by: Keith Packard <keithp@keithp.com>
---
 hw/semihosting/console.c          | 92 +++++++++++++++++++++++++++++++
 include/hw/semihosting/console.h  | 12 ++++
 include/hw/semihosting/semihost.h |  1 +
 stubs/semihost.c                  |  4 ++
 target/arm/arm-semi.c             |  3 +-
 vl.c                              |  3 +
 6 files changed, 113 insertions(+), 2 deletions(-)

diff --git a/hw/semihosting/console.c b/hw/semihosting/console.c
index b4b17c8afb..7345e2cce0 100644
--- a/hw/semihosting/console.c
+++ b/hw/semihosting/console.c
@@ -98,3 +98,95 @@ void qemu_semihosting_console_outc(CPUArchState *env, =
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
+
+#define FIFO_SIZE   1024
+
+typedef struct SemihostingFifo {
+    unsigned int     insert, remove;
+
+    uint8_t fifo[FIFO_SIZE];
+} SemihostingFifo;
+
+#define fifo_insert(f, c) do { \
+    (f)->fifo[(f)->insert] =3D (c); \
+    (f)->insert =3D ((f)->insert + 1) & (FIFO_SIZE - 1); \
+} while (0)
+
+#define fifo_remove(f, c) do {\
+    c =3D (f)->fifo[(f)->remove]; \
+    (f)->remove =3D ((f)->remove + 1) & (FIFO_SIZE - 1); \
+} while (0)
+
+#define fifo_full(f)        ((((f)->insert + 1) & (FIFO_SIZE - 1)) =3D=3D=
 \
+                             (f)->remove)
+#define fifo_empty(f)       ((f)->insert =3D=3D (f)->remove)
+#define fifo_space(f)       (((f)->remove - ((f)->insert + 1)) & \
+                             (FIFO_SIZE - 1))
+
+typedef struct SemihostingConsole {
+    CharBackend         backend;
+    pthread_mutex_t     mutex;
+    pthread_cond_t      cond;
+    bool                got;
+    SemihostingFifo     fifo;
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
+    ret =3D fifo_space(&c->fifo);
+    pthread_mutex_unlock(&c->mutex);
+    return ret;
+}
+
+static void console_read(void *opaque, const uint8_t *buf, int size)
+{
+    SemihostingConsole *c =3D opaque;
+    pthread_mutex_lock(&c->mutex);
+    while (size-- && !fifo_full(&c->fifo)) {
+        fifo_insert(&c->fifo, *buf++);
+    }
+    pthread_cond_broadcast(&c->cond);
+    pthread_mutex_unlock(&c->mutex);
+}
+
+target_ulong qemu_semihosting_console_inc(CPUArchState *env)
+{
+    (void) env;
+    SemihostingConsole *c =3D &console;
+    qemu_mutex_unlock_iothread();
+    pthread_mutex_lock(&c->mutex);
+    while (fifo_empty(&c->fifo)) {
+        pthread_cond_wait(&c->cond, &c->mutex);
+    }
+    uint8_t ch;
+    fifo_remove(&c->fifo, ch);
+    pthread_mutex_unlock(&c->mutex);
+    qemu_mutex_lock_iothread();
+    return (target_ulong) ch;
+}
+
+void qemu_semihosting_console_init(void)
+{
+    if (semihosting_enabled()) {
+        qemu_chr_fe_init(&console.backend, serial_hd(0), &error_abort);
+        qemu_chr_fe_set_handlers(&console.backend,
+                                 console_can_read,
+                                 console_read,
+                                 NULL, NULL, &console,
+                                 NULL, true);
+    }
+}
diff --git a/include/hw/semihosting/console.h b/include/hw/semihosting/co=
nsole.h
index 9be9754bcd..56f3606a2a 100644
--- a/include/hw/semihosting/console.h
+++ b/include/hw/semihosting/console.h
@@ -37,6 +37,18 @@ int qemu_semihosting_console_outs(CPUArchState *env, t=
arget_ulong s);
  */
 void qemu_semihosting_console_outc(CPUArchState *env, target_ulong c);
=20
+/**
+ * qemu_semihosting_console_outc:
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
index 60fc42d851..a13d17c087 100644
--- a/include/hw/semihosting/semihost.h
+++ b/include/hw/semihosting/semihost.h
@@ -68,6 +68,7 @@ Chardev *semihosting_get_chardev(void);
 void qemu_semihosting_enable(void);
 int qemu_semihosting_config_options(const char *opt);
 void qemu_semihosting_connect_chardevs(void);
+void qemu_semihosting_console_init(void);
 #endif /* CONFIG_USER_ONLY */
=20
 #endif /* SEMIHOST_H */
diff --git a/stubs/semihost.c b/stubs/semihost.c
index f90589259c..1d8b37f7b2 100644
--- a/stubs/semihost.c
+++ b/stubs/semihost.c
@@ -69,3 +69,7 @@ void semihosting_arg_fallback(const char *file, const c=
har *cmd)
 void qemu_semihosting_connect_chardevs(void)
 {
 }
+
+void qemu_semihosting_console_init(void)
+{
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
2.23.0


