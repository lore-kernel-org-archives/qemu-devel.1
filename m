Return-Path: <SRS0=g3Vr=5P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21DE7C43331
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2020 17:15:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D8D7420578
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2020 17:15:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aq5QaIAR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8D7420578
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53472 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jIy0B-0005al-1s
	for qemu-devel@archiver.kernel.org; Mon, 30 Mar 2020 13:15:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58464)
 by lists.gnu.org with esmtp (Exim 4.90_1) (envelope-from
 <3pCiCXgYKCvcxtZmyhfnnfkd.bnlpdlt-cdudkmnmfmt.nqf@flex--yuanzi.bounces.google.com>)
 id 1jIxyK-0003CD-Cv
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 13:13:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from
 <3pCiCXgYKCvcxtZmyhfnnfkd.bnlpdlt-cdudkmnmfmt.nqf@flex--yuanzi.bounces.google.com>)
 id 1jIxyJ-0000BK-65
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 13:13:12 -0400
Received: from mail-pl1-x64a.google.com ([2607:f8b0:4864:20::64a]:39300)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from
 <3pCiCXgYKCvcxtZmyhfnnfkd.bnlpdlt-cdudkmnmfmt.nqf@flex--yuanzi.bounces.google.com>)
 id 1jIxyI-000074-U2
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 13:13:11 -0400
Received: by mail-pl1-x64a.google.com with SMTP id d11so13445754pll.6
 for <qemu-devel@nongnu.org>; Mon, 30 Mar 2020 10:13:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:message-id:mime-version:subject:from:to:cc
 :content-transfer-encoding;
 bh=V2/yr/VBBSMjsJvpyuugUBT+oN88BgSB7L0XM+2U0UY=;
 b=aq5QaIARv5Yyi0jPYXtoM1OtUv0J4rBLvjVohBxRcKqKy4dVlPYtpplxIxGt28prf7
 KMjfmZPo1IxahMyQ1YMlqxCn55fp1K0q6rNxy1U/TSAfDS9w2d+R1qXHfGqiy6vDUtfG
 1e1LGg1c4mmBiTEUX0nT95pVPdvaRFgSxlU31lPuLVUMJZFn+6bmj/O0IEKP5CdXgEhI
 qHE9I2J0fWpdMjxEuxK9VdZo+nd+EXMQ+jx8NhCMmgPy2yZ4ThlLMPw4jgUx/zCyAFHf
 7geql4WIhQ7ayP2s5BLy+Fa+dZfIAAwASc32dJ51lRvMnO6mvXzbPsF1pRgoIHulUZQB
 yTlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc
 :content-transfer-encoding;
 bh=V2/yr/VBBSMjsJvpyuugUBT+oN88BgSB7L0XM+2U0UY=;
 b=bImhV7AEP52De2cHedEYgxMrZeEpEsZlkMM7d5gEqsnH9hIDJe8E1qCm1gJaMf+tVf
 8itEYTGu2JO/gqX7eLcEjBa58dTApRa4AlL38kPKzHfMi+mkhUUbOc3n5jaJ1AsyHN8l
 hjvnxymLAIjWfA1TLyBzONu6ppC/QGcc85SyGR9JTEDv5tHzD7UJd0kRL6+6k4rVORJ+
 b9xDUVkw9GeG5IDQ7IcLAvEBXvHO4t13BohlqEclqYCEzj1/50rVE92vqRgR9LFQ6+i2
 IAPvIHMmhvOv6QVDQ5P2gl7QWwYP3Ra6sy4fW7Ib6oO77ElorcFL6WqFrmzDvOtQf5Oh
 I+IA==
X-Gm-Message-State: AGi0PuaOOZKhamg7+FYjKg2vxWBnvwcbfqbiYAZ9sTwbgVtmOcv0G0Ko
 wdtqA2bFlnt21UfCe2R9AnHWOd+Ts3/4a4JHN5LDHS1Pbm2pLtb7Uj7smZPKf9ZGBVRcEe6F629
 AIPyTaNiiT6VIiJVKuQZB1PPVvV31rNsvM9NWktmA0o7ayvkmzSx0hp9/JcsP
X-Google-Smtp-Source: APiQypJTSUXcxSr57qAhMq1a5XW5qIrIQDmdOVzh/ndFvg8yesJQRAgILLvzPPbm8SeK8K68HcNlRJfAhbE=
X-Received: by 2002:a17:90a:cb0e:: with SMTP id
 z14mr376555pjt.156.1585588388226; 
 Mon, 30 Mar 2020 10:13:08 -0700 (PDT)
Date: Mon, 30 Mar 2020 13:13:03 -0400
Message-Id: <20200330171303.107131-1-yuanzi@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.26.0.rc2.310.g2932bb562d-goog
Subject: [PATCH] gdbstub: add support to Xfer:auxv:read: packet
From: Lirong Yuan <yuanzi@google.com>
To: qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org, philmd@redhat.com, scw@google.com, jkz@google.com, 
 Lirong Yuan <yuanzi@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::64a
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
 gdbstub.c | 56 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 56 insertions(+)

diff --git a/gdbstub.c b/gdbstub.c
index 013fb1ac0f..f7a08263c6 100644
--- a/gdbstub.c
+++ b/gdbstub.c
@@ -2125,6 +2125,12 @@ static void handle_query_supported(GdbCmdContext *gd=
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
@@ -2186,6 +2192,48 @@ static void handle_query_xfer_features(GdbCmdContext=
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
+
+    ts =3D gdbserver_state.c_cpu->opaque;
+    saved_auxv =3D ts->info->saved_auxv;
+    auxv_len =3D ts->info->auxv_len;
+    mem =3D (const char *)(saved_auxv + offset);
+
+    if (offset >=3D auxv_len) {
+        put_packet("E22");
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
@@ -2291,6 +2339,14 @@ static GdbCmdParseEntry gdb_gen_query_table[] =3D {
         .cmd_startswith =3D 1,
         .schema =3D "s:l,l0"
     },
+#ifdef CONFIG_USER_ONLY
+    {
+        .handler =3D handle_query_xfer_auxv,
+        .cmd =3D "Xfer:auxv:read:",
+        .cmd_startswith =3D 1,
+        .schema =3D "l,l0"
+    },
+#endif
     {
         .handler =3D handle_query_attached,
         .cmd =3D "Attached:",
--=20
2.26.0.rc2.310.g2932bb562d-goog


