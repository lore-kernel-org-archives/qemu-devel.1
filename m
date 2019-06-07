Return-Path: <SRS0=3yEa=UG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E763EC2BCA1
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 16:49:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B46BC207E0
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 16:49:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B46BC207E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49534 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hZI3f-0003vj-NG
	for qemu-devel@archiver.kernel.org; Fri, 07 Jun 2019 12:49:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53389)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hZGzq-0003Yj-IP
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 11:41:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hZGxv-0003Az-QA
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 11:39:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:31227)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hZGxt-00035t-TV
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 11:39:38 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 3233B3B72D;
 Fri,  7 Jun 2019 15:39:31 +0000 (UTC)
Received: from x1w.redhat.com (unknown [10.40.205.135])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id EF6D080882;
 Fri,  7 Jun 2019 15:39:25 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: Yoshinori Sato <ysato@users.sourceforge.jp>, qemu-devel@nongnu.org,
 Igor Mammedov <imammedo@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Date: Fri,  7 Jun 2019 17:37:20 +0200
Message-Id: <20190607153725.18055-25-philmd@redhat.com>
In-Reply-To: <20190607153725.18055-1-philmd@redhat.com>
References: <20190607153725.18055-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.30]); Fri, 07 Jun 2019 15:39:31 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v18 24/29] target/rx: Collect all bytes during
 disassembly
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Richard Henderson <richard.henderson@linaro.org>

Collected, to be used in the next patch.

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Reviewed-by: Yoshinori Sato <ysato@users.sourceforge.jp>
Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
Message-Id: <20190607091116.49044-23-ysato@users.sourceforge.jp>
Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/rx/disas.c | 62 ++++++++++++++++++++++++++++++++---------------
 1 file changed, 42 insertions(+), 20 deletions(-)

diff --git a/target/rx/disas.c b/target/rx/disas.c
index ebc1a44249..5a32a87534 100644
--- a/target/rx/disas.c
+++ b/target/rx/disas.c
@@ -25,43 +25,59 @@ typedef struct DisasContext {
     disassemble_info *dis;
     uint32_t addr;
     uint32_t pc;
+    uint8_t len;
+    uint8_t bytes[8];
 } DisasContext;
=20
=20
 static uint32_t decode_load_bytes(DisasContext *ctx, uint32_t insn,
-                           int i, int n)
+                                  int i, int n)
 {
-    bfd_byte buf;
+    uint32_t addr =3D ctx->addr;
+
+    g_assert(ctx->len =3D=3D i);
+    g_assert(n <=3D ARRAY_SIZE(ctx->bytes));
+
     while (++i <=3D n) {
-        ctx->dis->read_memory_func(ctx->addr++, &buf, 1, ctx->dis);
-        insn |=3D buf << (32 - i * 8);
+        ctx->dis->read_memory_func(addr++, &ctx->bytes[i - 1], 1, ctx->d=
is);
+        insn |=3D ctx->bytes[i - 1] << (32 - i * 8);
     }
+    ctx->addr =3D addr;
+    ctx->len =3D n;
+
     return insn;
 }
=20
 static int32_t li(DisasContext *ctx, int sz)
 {
-    int32_t addr;
-    bfd_byte buf[4];
-    addr =3D ctx->addr;
+    uint32_t addr =3D ctx->addr;
+    uintptr_t len =3D ctx->len;
=20
     switch (sz) {
     case 1:
+        g_assert(len + 1 <=3D ARRAY_SIZE(ctx->bytes));
         ctx->addr +=3D 1;
-        ctx->dis->read_memory_func(addr, buf, 1, ctx->dis);
-        return (int8_t)buf[0];
+        ctx->len +=3D 1;
+        ctx->dis->read_memory_func(addr, ctx->bytes + len, 1, ctx->dis);
+        return (int8_t)ctx->bytes[len];
     case 2:
+        g_assert(len + 2 <=3D ARRAY_SIZE(ctx->bytes));
         ctx->addr +=3D 2;
-        ctx->dis->read_memory_func(addr, buf, 2, ctx->dis);
-        return ldsw_le_p(buf);
+        ctx->len +=3D 2;
+        ctx->dis->read_memory_func(addr, ctx->bytes + len, 2, ctx->dis);
+        return ldsw_le_p(ctx->bytes + len);
     case 3:
+        g_assert(len + 3 <=3D ARRAY_SIZE(ctx->bytes));
         ctx->addr +=3D 3;
-        ctx->dis->read_memory_func(addr, buf, 3, ctx->dis);
-        return (int8_t)buf[2] << 16 | lduw_le_p(buf);
+        ctx->len +=3D 3;
+        ctx->dis->read_memory_func(addr, ctx->bytes + len, 3, ctx->dis);
+        return (int8_t)ctx->bytes[len + 2] << 16 | lduw_le_p(ctx->bytes =
+ len);
     case 0:
+        g_assert(len + 4 <=3D ARRAY_SIZE(ctx->bytes));
         ctx->addr +=3D 4;
-        ctx->dis->read_memory_func(addr, buf, 4, ctx->dis);
-        return ldl_le_p(buf);
+        ctx->len +=3D 4;
+        ctx->dis->read_memory_func(addr, ctx->bytes + len, 4, ctx->dis);
+        return ldl_le_p(ctx->bytes + len);
     default:
         g_assert_not_reached();
     }
@@ -110,7 +126,7 @@ static const char psw[] =3D {
 static void rx_index_addr(DisasContext *ctx, char out[8], int ld, int mi=
)
 {
     uint32_t addr =3D ctx->addr;
-    uint8_t buf[2];
+    uintptr_t len =3D ctx->len;
     uint16_t dsp;
=20
     switch (ld) {
@@ -119,14 +135,18 @@ static void rx_index_addr(DisasContext *ctx, char o=
ut[8], int ld, int mi)
         out[0] =3D '\0';
         return;
     case 1:
+        g_assert(len + 1 <=3D ARRAY_SIZE(ctx->bytes));
         ctx->addr +=3D 1;
-        ctx->dis->read_memory_func(addr, buf, 1, ctx->dis);
-        dsp =3D buf[0];
+        ctx->len +=3D 1;
+        ctx->dis->read_memory_func(addr, ctx->bytes + len, 1, ctx->dis);
+        dsp =3D ctx->bytes[len];
         break;
     case 2:
+        g_assert(len + 2 <=3D ARRAY_SIZE(ctx->bytes));
         ctx->addr +=3D 2;
-        ctx->dis->read_memory_func(addr, buf, 2, ctx->dis);
-        dsp =3D lduw_le_p(buf);
+        ctx->len +=3D 2;
+        ctx->dis->read_memory_func(addr, ctx->bytes + len, 2, ctx->dis);
+        dsp =3D lduw_le_p(ctx->bytes + len);
         break;
     default:
         g_assert_not_reached();
@@ -1392,8 +1412,10 @@ int print_insn_rx(bfd_vma addr, disassemble_info *=
dis)
     DisasContext ctx;
     uint32_t insn;
     int i;
+
     ctx.dis =3D dis;
     ctx.pc =3D ctx.addr =3D addr;
+    ctx.len =3D 0;
=20
     insn =3D decode_load(&ctx);
     if (!decode(&ctx, insn)) {
--=20
2.20.1


