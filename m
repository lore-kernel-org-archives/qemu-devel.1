Return-Path: <SRS0=oVW3=4Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5794BC10DCE
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Mar 2020 01:02:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1F9A6206D7
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Mar 2020 01:02:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nGwHdxjI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F9A6206D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44058 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jANqs-0003Vw-8n
	for qemu-devel@archiver.kernel.org; Fri, 06 Mar 2020 20:02:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50785)
 by lists.gnu.org with esmtp (Exim 4.90_1) (envelope-from
 <3UPJiXgYKCrkxtZmyhfnnfkd.bnlpdlt-cdudkmnmfmt.nqf@flex--yuanzi.bounces.google.com>)
 id 1jANq1-00031P-3S
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 20:01:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from
 <3UPJiXgYKCrkxtZmyhfnnfkd.bnlpdlt-cdudkmnmfmt.nqf@flex--yuanzi.bounces.google.com>)
 id 1jANq0-0005t0-0e
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 20:01:08 -0500
Received: from mail-pf1-x44a.google.com ([2607:f8b0:4864:20::44a]:36019)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from
 <3UPJiXgYKCrkxtZmyhfnnfkd.bnlpdlt-cdudkmnmfmt.nqf@flex--yuanzi.bounces.google.com>)
 id 1jANpz-0005lZ-RD
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 20:01:07 -0500
Received: by mail-pf1-x44a.google.com with SMTP id y20so2708551pfb.3
 for <qemu-devel@nongnu.org>; Fri, 06 Mar 2020 17:01:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:message-id:mime-version:subject:from:to:cc
 :content-transfer-encoding;
 bh=iPEeOPHtbKx2X/HJcyC/lCZW3eqhuWJ+pBtpanbsweI=;
 b=nGwHdxjIE4lX2RGsjv+3UbS9Qqh8AVkbxlX931qHre5YwxcJWcKVOSsHM6Uurpi9fu
 0z9Q2fIBNr/obKvZd88Gv9cdahi/YZS3R1r1jGHNblCyvu/7rXXMZpfJLxh235F9D+ey
 ZWnbvocnkCWhX35Lpr8xqqWgciixgLAuJ2cNl4+ozRiP1NRmFnqBxm8orPATp7NeAzFW
 75KOP3eYiCpOkXatEualUyEWb/mnSr+oTIciBP+4GuqCm7TCfs2ZMRL9W/shTwF5YLp1
 uZgGVfPbJui9ftGP2pRrXaIt86k7OK4PO2FY7SkZEVPj6NSyF99cHThDFnYaDu6XemaO
 adMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc
 :content-transfer-encoding;
 bh=iPEeOPHtbKx2X/HJcyC/lCZW3eqhuWJ+pBtpanbsweI=;
 b=RFrg6hiSjtrcYpNDU9p6CyEvn7EUvk5q+9TifGix/XEwwbcIE3+I3vwb7QjRVNU8Wl
 +9V6fyM3KoD44iFLjSBVg3F1mbH7Z/XMBIDI2uZR2P6L+Zo0RFh2Vupmsn/Hhdx+EOC5
 hd0vJM4jhsjOESwwIPqv7Bc9znS67FLqHdZfkWZ6H63knGXuZsXYiYhabkOjj8sJeVGb
 iGzyWhGcYaCQUymd/Z9SFSQhQD2s76doy9eQs2skTCubhiFDDoKpz2oYVZJmf/rnoynB
 UevvvFmAsBnJmMaLLDBphqMOR/gZ/bp58up2NcJw0ZkYodhe2VvBNRkEmbKJ9FApBq9u
 YaJw==
X-Gm-Message-State: ANhLgQ25tLPN3gn5g+vyvqG5B4QsdaMdskzqydsE1+irlSol7rRIz4aa
 897Jw5JW3yTgJM0xzPaO120rco29l4VwqrCFjRVN1vGFD6m8BGDCoqvoMoaHfDiWakG99FAIuIp
 zPXteBQiVTLKr3p7pwT9dBRT1XZZk40GJCgks5qmcR4VbKYjieSleJST5mjo7
X-Google-Smtp-Source: ADFU+vs5G4q2ZDQNWk/WzBgGTpFidkGN5CooAXIxADrifFDufJ/0NYIVyYZxGye80T07JnLOwKN3OEAdB/A=
X-Received: by 2002:a17:90a:608:: with SMTP id j8mr6104443pjj.85.1583542864585; 
 Fri, 06 Mar 2020 17:01:04 -0800 (PST)
Date: Fri,  6 Mar 2020 17:00:51 -0800
Message-Id: <20200307010051.97022-1-yuanzi@google.com>
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
X-Received-From: 2607:f8b0:4864:20::44a
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
 gdbstub.c | 55 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 55 insertions(+)

diff --git a/gdbstub.c b/gdbstub.c
index 22a2d630cd..a946af7007 100644
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
@@ -2166,6 +2172,47 @@ static void handle_query_xfer_features(GdbCmdContext=
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
+    if (offset >=3D auxv_len) {
+        put_packet(gdb_ctx->s, "E22");
+        return;
+    }
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
@@ -2271,6 +2318,14 @@ static GdbCmdParseEntry gdb_gen_query_table[] =3D {
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


