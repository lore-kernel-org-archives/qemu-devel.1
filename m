Return-Path: <SRS0=WSdW=BJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32F31C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2020 19:40:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EE4402072A
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2020 19:40:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DeV6rh9k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE4402072A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58778 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k1EQB-0006wG-8d
	for qemu-devel@archiver.kernel.org; Thu, 30 Jul 2020 15:40:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57704)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3ACIjXwYKCs8JFv8K319916z.x97Bz7F-yzGz689818F.9C1@flex--yuanzi.bounces.google.com>)
 id 1k1EP6-0005zK-5x
 for qemu-devel@nongnu.org; Thu, 30 Jul 2020 15:39:48 -0400
Received: from mail-yb1-xb49.google.com ([2607:f8b0:4864:20::b49]:36531)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3ACIjXwYKCs8JFv8K319916z.x97Bz7F-yzGz689818F.9C1@flex--yuanzi.bounces.google.com>)
 id 1k1EP4-0005Rk-C2
 for qemu-devel@nongnu.org; Thu, 30 Jul 2020 15:39:47 -0400
Received: by mail-yb1-xb49.google.com with SMTP id a5so18649485ybh.3
 for <qemu-devel@nongnu.org>; Thu, 30 Jul 2020 12:39:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:message-id:mime-version:subject:from:to:cc
 :content-transfer-encoding;
 bh=RI06ojqCn92Gvgv71lQNnqCHXVDWRl7OifmYHTUYNc8=;
 b=DeV6rh9kc10mzWrtj7GluJ/2vbZl7UqjKU+LvLnrYJS3AREg8Kw+Wuu2tM+dV773mG
 vNxlaXrlQnM2vBiVuKiQr9jyTvjbm8fMQTL1BkG/vlOsDYG8dfbtMiF6Zf5yXuAZxQnj
 hgysEG2MIlMBm0yEB0Cprdeie3NUWtpeMB4TADKH8OJBX3YN20W0L4idGVGUxklfY0pe
 rYl2mK1aDtU6aOts5MVfAu/uAsTlVbOVVsLwvBuYSclftxDCGH6L2mgCJgEB6jQCeyp/
 xhRAYUl9a5iQk3aqDWG3Dh24yN0Y/whQumnUmlzS+liszrXxs9oXX45WBScfGy0MXiI8
 korg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc
 :content-transfer-encoding;
 bh=RI06ojqCn92Gvgv71lQNnqCHXVDWRl7OifmYHTUYNc8=;
 b=Xc0hxj7VrRa+VJjET1VAEDAHfFgX0FujcZaGAFyuAOUp6eIgeHAKH7tg20cYAsJyo0
 EkOjIeOJQ99rFML2oM7NotO+clR718up6eotCgAo7NHkLT9aO/AgLJhScAxXi88QPV+x
 9pMglmxC1mzqyGuGw8sSvBTv3Hf+yxx0E+QZP+U+bwAusuWU6rWAmdNf+AXR31XDYX2n
 hmQNFxlo9gZaJYP5xB8jP4ZxTYxoM8I32lRw7U6i+1CudDyuBio30GPcw2t3Dt335EQJ
 xUJD8sSvK08AD2xfe3/e9BC/U4k49cfl/LZkDuNv9r43zotaTsyjFSovyuspPSvyoZGq
 FYYQ==
X-Gm-Message-State: AOAM5322uSZhswUJrxpZht9Esu/6FnXQgYtPG1bkY3iZq10yvmqAP0y7
 v0Fryd2rG1I4F8g0uzYTJaY59QxQFR1gBjZi2nIRD1zKiLFn245crFbEfg5D4vnz1bvZiUUfzuD
 zyu53Yl0u1jrwbJ/oRKFhuQPlcyjQgfZgyHSaGRd9UsNkpgAp7Yc/QLmXFYcT
X-Google-Smtp-Source: ABdhPJyGF+7ZoKJEgJN02pDiKnX2gYjt/xyZPut8yHkv/l+BPRpjkZg4rc1MavY6LKe+REfd2Hjt06YTeC0=
X-Received: by 2002:a5b:4ca:: with SMTP id u10mr813175ybp.128.1596137984014;
 Thu, 30 Jul 2020 12:39:44 -0700 (PDT)
Date: Thu, 30 Jul 2020 12:39:32 -0700
Message-Id: <20200730193932.3654677-1-yuanzi@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.28.0.163.g6104cc2f0b6-goog
Subject: [PATCH] [PATCH v2] gdbstub: add support to Xfer:auxv:read: packet
From: Lirong Yuan <yuanzi@google.com>
To: qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org, philmd@redhat.com, Lirong Yuan <yuanzi@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b49;
 envelope-from=3ACIjXwYKCs8JFv8K319916z.x97Bz7F-yzGz689818F.9C1@flex--yuanzi.bounces.google.com;
 helo=mail-yb1-xb49.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -105
X-Spam_score: -10.6
X-Spam_bar: ----------
X-Spam_report: (-10.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001, USER_IN_DEF_DKIM_WL=-7.5 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This allows gdb to access the target=E2=80=99s auxiliary vector,
which can be helpful for telling system libraries important details
about the hardware, operating system, and process.

Signed-off-by: Lirong Yuan <yuanzi@google.com>
---
Changelog since v1:
 - Added a multiarch gdbstub test to verify this is working properly.
---
 gdbstub.c                                     | 54 ++++++++++++++++
 tests/tcg/multiarch/Makefile.target           |  9 ++-
 .../multiarch/gdbstub/test-qxfer-auxv-read.py | 64 +++++++++++++++++++
 3 files changed, 126 insertions(+), 1 deletion(-)
 create mode 100644 tests/tcg/multiarch/gdbstub/test-qxfer-auxv-read.py

diff --git a/gdbstub.c b/gdbstub.c
index f3a318cd7f..e1e1a2c1e6 100644
--- a/gdbstub.c
+++ b/gdbstub.c
@@ -2124,6 +2124,12 @@ static void handle_query_supported(GdbCmdContext *gd=
b_ctx, void *user_ctx)
         g_string_append(gdbserver_state.str_buf, ";qXfer:features:read+");
     }
=20
+#ifdef CONFIG_USER_ONLY
+    if (gdbserver_state.c_cpu->opaque) {
+        g_string_append(gdbserver_state.str_buf, ";qXfer:auxv:read+");
+    }
+#endif
+
     if (gdb_ctx->num_params &&
         strstr(gdb_ctx->params[0].data, "multiprocess+")) {
         gdbserver_state.multiprocess =3D true;
@@ -2185,6 +2191,46 @@ static void handle_query_xfer_features(GdbCmdContext=
 *gdb_ctx, void *user_ctx)
                       gdbserver_state.str_buf->len, true);
 }
=20
+#ifdef CONFIG_USER_ONLY
+static void handle_query_xfer_auxv(GdbCmdContext *gdb_ctx, void *user_ctx)
+{
+    TaskState *ts;
+    unsigned long offset, len, saved_auxv, auxv_len;
+    const char *mem;
+
+    if (gdb_ctx->num_params < 2) {
+        put_packet("E22");
+        return;
+    }
+
+    offset =3D gdb_ctx->params[0].val_ul;
+    len =3D gdb_ctx->params[1].val_ul;
+    ts =3D gdbserver_state.c_cpu->opaque;
+    saved_auxv =3D ts->info->saved_auxv;
+    auxv_len =3D ts->info->auxv_len;
+    mem =3D (const char *)(saved_auxv + offset);
+    if (offset > auxv_len) {
+        put_packet("E00");
+        return;
+    }
+
+    if (len > (MAX_PACKET_LENGTH - 5) / 2) {
+        len =3D (MAX_PACKET_LENGTH - 5) / 2;
+    }
+
+    if (len < auxv_len - offset) {
+        g_string_assign(gdbserver_state.str_buf, "m");
+        memtox(gdbserver_state.str_buf, mem, len);
+    } else {
+        g_string_assign(gdbserver_state.str_buf, "l");
+        memtox(gdbserver_state.str_buf, mem, auxv_len - offset);
+    }
+
+    put_packet_binary(gdbserver_state.str_buf->str,
+                      gdbserver_state.str_buf->len, true);
+}
+#endif
+
 static void handle_query_attached(GdbCmdContext *gdb_ctx, void *user_ctx)
 {
     put_packet(GDB_ATTACHED);
@@ -2290,6 +2336,14 @@ static GdbCmdParseEntry gdb_gen_query_table[] =3D {
         .cmd_startswith =3D 1,
         .schema =3D "s:l,l0"
     },
+#ifdef CONFIG_USER_ONLY
+    {
+        .handler =3D handle_query_xfer_auxv,
+        .cmd =3D "Xfer:auxv:read::",
+        .cmd_startswith =3D 1,
+        .schema =3D "l,l0"
+    },
+#endif
     {
         .handler =3D handle_query_attached,
         .cmd =3D "Attached:",
diff --git a/tests/tcg/multiarch/Makefile.target b/tests/tcg/multiarch/Make=
file.target
index cb49cc9ccb..c8cdb1e04d 100644
--- a/tests/tcg/multiarch/Makefile.target
+++ b/tests/tcg/multiarch/Makefile.target
@@ -54,7 +54,14 @@ run-gdbstub-sha1: sha1
 		--bin $< --test $(MULTIARCH_SRC)/gdbstub/sha1.py, \
 	"basic gdbstub support")
=20
-EXTRA_RUNS +=3D run-gdbstub-sha1
+run-gdbstub-qxfer-auxv-read: sha1
+	$(call run-test, $@, $(GDB_SCRIPT) \
+		--gdb $(HAVE_GDB_BIN) \
+		--qemu $(QEMU) --qargs "$(QEMU_OPTS)" \
+		--bin $< --test $(MULTIARCH_SRC)/gdbstub/test-qxfer-auxv-read.py, \
+	"basic gdbstub qXfer:auxv:read support")
+
+EXTRA_RUNS +=3D run-gdbstub-sha1 run-gdbstub-qxfer-auxv-read
 endif
=20
=20
diff --git a/tests/tcg/multiarch/gdbstub/test-qxfer-auxv-read.py b/tests/tc=
g/multiarch/gdbstub/test-qxfer-auxv-read.py
new file mode 100644
index 0000000000..88049dd330
--- /dev/null
+++ b/tests/tcg/multiarch/gdbstub/test-qxfer-auxv-read.py
@@ -0,0 +1,64 @@
+from __future__ import print_function
+#
+# Test the SVE ZReg reports the right amount of data. It uses the
+from __future__ import print_function
+#
+# Test auxiliary vector is loaded via gdbstub
+#
+# This is launched via tests/guest-debug/run-test.py
+#
+
+import gdb
+import sys
+
+failcount =3D 0
+
+def report(cond, msg):
+    "Report success/fail of test"
+    if cond:
+        print ("PASS: %s" % (msg))
+    else:
+        print ("FAIL: %s" % (msg))
+        global failcount
+        failcount +=3D 1
+
+def run_test():
+    "Run through the tests one by one"
+
+    cond =3D True
+    try:
+      gdb.execute("info auxv")
+    except (gdb.error, AttributeError):
+      cond =3D False
+
+    report(cond, "Display the auxiliary vector of the inferior.")
+
+#
+# This runs as the script it sourced (via -x, via run-test.py)
+#
+try:
+    inferior =3D gdb.selected_inferior()
+    arch =3D inferior.architecture()
+    print("ATTACHED: %s" % arch.name())
+except (gdb.error, AttributeError):
+    print("SKIPPING (not connected)", file=3Dsys.stderr)
+    exit(0)
+
+if gdb.parse_and_eval('$pc') =3D=3D 0:
+    print("SKIP: PC not set")
+    exit(0)
+
+try:
+    # These are not very useful in scripts
+    gdb.execute("set pagination off")
+    gdb.execute("set confirm off")
+
+    # Run the actual tests
+    run_test()
+except (gdb.error):
+    print ("GDB Exception: %s" % (sys.exc_info()[0]))
+    failcount +=3D 1
+    pass
+
+print("All tests complete: %d failures" % failcount)
+exit(failcount)
--=20
2.28.0.163.g6104cc2f0b6-goog


