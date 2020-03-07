Return-Path: <SRS0=oVW3=4Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52084C10DCE
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Mar 2020 00:05:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E82A205C9
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Mar 2020 00:05:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IQykRsi7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E82A205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43680 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jAMyA-0006wT-BG
	for qemu-devel@archiver.kernel.org; Fri, 06 Mar 2020 19:05:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57060)
 by lists.gnu.org with esmtp (Exim 4.90_1) (envelope-from
 <3IeViXgYKCnAmiObnWUccUZS.QcaeSai-RSjSZbcbUbi.cfU@flex--yuanzi.bounces.google.com>)
 id 1jAMxZ-0006XT-A4
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 19:04:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from
 <3IeViXgYKCnAmiObnWUccUZS.QcaeSai-RSjSZbcbUbi.cfU@flex--yuanzi.bounces.google.com>)
 id 1jAMxY-0006CV-2E
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 19:04:53 -0500
Received: from mail-pg1-x54a.google.com ([2607:f8b0:4864:20::54a]:55434)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from
 <3IeViXgYKCnAmiObnWUccUZS.QcaeSai-RSjSZbcbUbi.cfU@flex--yuanzi.bounces.google.com>)
 id 1jAMxX-00069C-RJ
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 19:04:52 -0500
Received: by mail-pg1-x54a.google.com with SMTP id r10so2306556pgu.22
 for <qemu-devel@nongnu.org>; Fri, 06 Mar 2020 16:04:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:message-id:mime-version:subject:from:to:cc
 :content-transfer-encoding;
 bh=7gO12hBvzTq289ZTV127GnZTtvuf8N42/Yu2B/5Y5FI=;
 b=IQykRsi7/W2VmuRWWchOyDaYQcyBfIqRkq40uuO+DoIJctf9OW04W9WNfchXBXHTfs
 nqWIauXhZsIiaYNTyEBCq37G6Edh+TX+DeSyk6EhIdRhFAf1LOcgTH3SVXRwyKjMdquH
 pLtwrMjRnNoZ5+Qi1oWDY7HcveYuT/D85iJrsuXGL9mh52wYkikIZnQEs5Evsv5XrgTp
 MWeL4LqJUK9YYeyH9vCTeSiBA/nj4pBFl8IGrh+/sm5ye+GoyFWxUusvOUhrGWnXET0T
 7GL95cNi8jGNKEKlm6lV2q+ErM1REJka5Dopi+o50TRHyTkH5N4bSK2Pzu9oP498wU6d
 8dHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc
 :content-transfer-encoding;
 bh=7gO12hBvzTq289ZTV127GnZTtvuf8N42/Yu2B/5Y5FI=;
 b=JQ0/zdxExqOCmLxqItXFQs36o6uaziFTrH7ZBh1u8D2ZCOuStvtcL7iBFSN5siTYwC
 Kr9GX6g2UwEiSXhD6p7O2BKiJVB1PBJadMmpW4ra33egpvDIK88L2mOCzOqniZo8Fi24
 Lu7jVD4YbfiY+f9dMbyLDll++imXv7IjgMfqVfv33VXrZW99IngYlee7XsP9C6VaC+pD
 pt/K0fch5fCJ2P1leFReuCLePW0Ecb0lGa2RVDz2be1QuofDU4dNwmR5ZSbTdsUP7p36
 y1xuAI0aBs/qss5Z28uOCWaODZOQGzAMI0xNNEfe9bbwT3/e7jXwFwveLnZxmmOnNhBM
 LH0A==
X-Gm-Message-State: ANhLgQ3etU6SUnQz+Fuw+Qrzrm12V0zHWcMTdPEhBQotUOimJbu9k/42
 gLzMpd7AgQli9JRj16qOxJnguLJPpumdzlRs2CVudCpyT348kVBPL0xs8fxhL5Xgk8ScbDjJZ/Z
 maJR2mAmPyrZiPZjnSuqMDGfCPxnr1FldLL1yj1g8eNch0WoCYxnFwHSFGP9S
X-Google-Smtp-Source: ADFU+vvqmssXgf2sO69wklX6vW7Hhz63XIYFqgfZooM80BGty1aJF4Cr/NZ4Qjz7CdsCRsEMRmpIuyHo1iI=
X-Received: by 2002:a17:90a:c218:: with SMTP id
 e24mr6152735pjt.64.1583539489613; 
 Fri, 06 Mar 2020 16:04:49 -0800 (PST)
Date: Fri,  6 Mar 2020 16:04:45 -0800
Message-Id: <20200307000445.45265-1-yuanzi@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.25.1.481.gfbce0eb801-goog
Subject: [PATCH] gdbstub: add support to Xfer:auxv:read: packet
From: Lirong Yuan <yuanzi@google.com>
To: qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org, philmd@redhat.com, scw@google.com, jkz@google.com, 
 Lirong Yuan <yuanzi@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::54a
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
 gdbstub.c | 50 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/gdbstub.c b/gdbstub.c
index 22a2d630cd..c2865ea873 100644
--- a/gdbstub.c
+++ b/gdbstub.c
@@ -2105,6 +2105,12 @@ static void handle_query_supported(GdbCmdContext *gd=
b_ctx, void *user_ctx)
         pstrcat(gdb_ctx->str_buf, sizeof(gdb_ctx->str_buf),
                 ";qXfer:features:read+");
     }
+#ifdef CONFIG_USER_ONLY
+    if (gdb_ctx->s->c_cpu->opaque) {
+        pstrcat(gdb_ctx->str_buf, sizeof(gdb_ctx->str_buf),
+                ";qXfer:auxv:read+");
+    }
+#endif
=20
     if (gdb_ctx->num_params &&
         strstr(gdb_ctx->params[0].data, "multiprocess+")) {
@@ -2166,6 +2172,42 @@ static void handle_query_xfer_features(GdbCmdContext=
 *gdb_ctx, void *user_ctx)
     put_packet_binary(gdb_ctx->s, gdb_ctx->str_buf, len + 1, true);
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
+        put_packet(gdb_ctx->s, "E22");
+        return;
+    }
+
+    offset =3D gdb_ctx->params[0].val_ul;
+    len =3D gdb_ctx->params[1].val_ul;
+
+    ts =3D gdb_ctx->s->c_cpu->opaque;
+    saved_auxv =3D ts->info->saved_auxv;
+    auxv_len =3D ts->info->auxv_len;
+    mem =3D (const char *)(saved_auxv + offset);
+
+    if (len > (MAX_PACKET_LENGTH - 5) / 2) {
+        len =3D (MAX_PACKET_LENGTH - 5) / 2;
+    }
+
+    if (len < auxv_len - offset) {
+        gdb_ctx->str_buf[0] =3D 'm';
+        len =3D memtox(gdb_ctx->str_buf + 1, mem, len);
+    } else {
+        gdb_ctx->str_buf[0] =3D 'l';
+        len =3D memtox(gdb_ctx->str_buf + 1, mem, auxv_len - offset);
+    }
+
+    put_packet_binary(gdb_ctx->s, gdb_ctx->str_buf, len + 1, true);
+}
+#endif
+
 static void handle_query_attached(GdbCmdContext *gdb_ctx, void *user_ctx)
 {
     put_packet(gdb_ctx->s, GDB_ATTACHED);
@@ -2271,6 +2313,14 @@ static GdbCmdParseEntry gdb_gen_query_table[] =3D {
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
2.25.1.481.gfbce0eb801-goog


