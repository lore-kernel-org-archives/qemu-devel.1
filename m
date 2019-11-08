Return-Path: <SRS0=73np=ZA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 855F2C5DF60
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 12:58:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D258222C2
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 12:58:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=greensocs.com header.i=@greensocs.com header.b="LDqbLWwo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D258222C2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=greensocs.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53366 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iT3qQ-0000nX-9f
	for qemu-devel@archiver.kernel.org; Fri, 08 Nov 2019 07:58:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48038)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <damien.hedde@greensocs.com>) id 1iT3ng-0000Ax-Tx
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 07:55:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <damien.hedde@greensocs.com>) id 1iT3nf-0003Mw-IW
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 07:55:40 -0500
Received: from beetle.greensocs.com ([5.135.226.135]:55632)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <damien.hedde@greensocs.com>)
 id 1iT3nf-0003JI-4I
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 07:55:39 -0500
Received: from crumble.bar.greensocs.com (crumble.bar.greensocs.com
 [172.16.11.102])
 by beetle.greensocs.com (Postfix) with ESMTPS id 45B8B96EF0;
 Fri,  8 Nov 2019 12:55:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com;
 s=mail; t=1573217736;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=uBAIGING6GHSPD3RtNAZAtENTduFCSOlXmknrLi40VU=;
 b=LDqbLWwoTOYgreCMXH7TOnLr6OqBTG3NxAjXCLrJTpd6CGnrFE5T/hmlj+3B7V5iYtvNe4
 +2ZXUXnrFQThPuJa5kar/mSU0KEqSpNo1H02U6W1VqWfTRrzsYvuypw5OT4i8YyBKMdHLk
 siVN7i2e+nNh8mlBNlZLU4icV1uFo4c=
From: Damien Hedde <damien.hedde@greensocs.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] gdbstub: Fix buffer overflow in handle_read_all_regs
Date: Fri,  8 Nov 2019 13:55:34 +0100
Message-Id: <20191108125534.114474-1-damien.hedde@greensocs.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com; 
 s=mail; t=1573217736;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=uBAIGING6GHSPD3RtNAZAtENTduFCSOlXmknrLi40VU=;
 b=5F/GFt3Jjx7+NUCvkPlCfHlp9UwggQ+ZrEODrRcnzqeoXyhxcb21BXy7NUeghLR1+SXqKK
 vE4j7baxZiidt+//Z5EceEhkiujEJhXcq5a3H5BgIJ1VlM1L/Jyr7S4lo4xseDUMOXhJPl
 Yf6StHW1ODL6rNNQ30XjmRYiaVIzaZk=
ARC-Seal: i=1; s=mail; d=greensocs.com; t=1573217736; a=rsa-sha256; cv=none;
 b=Wu6wBDbIwAjC3G8Uo0NtH+4CJ8ST5lVIYxYG/zLRXN1vyTFKy1eYH7jQXceKkc5hZjtkpd
 +O0PXjk5ruo8zHMDMtmqN4D4+ZDfMdTld+brWI77dc6O+i++v9j/b3SpD54rijP8tXQ+S5
 EJD70DwHj2FX7bafyUZ2kJwpzlEou3c=
ARC-Authentication-Results: i=1;
	beetle.greensocs.com;
	none
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 5.135.226.135
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
Cc: Damien Hedde <damien.hedde@greensocs.com>, philmd@redhat.com,
 alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Ensure we don't put too much register data in buffers. This avoids
a buffer overflow (and stack corruption) when a target has lots
of registers.

Signed-off-by: Damien Hedde <damien.hedde@greensocs.com>
---

Hi all,

While working on a target with many registers. I found out the gdbstub
may do buffer overflows when receiving a 'g' query (to read general
registers). This patch prevents that.

Gdb is pretty happy with a partial set of registers and queries
remaining registers one by one when needed.

Regards,
Damien
---
 gdbstub.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/gdbstub.c b/gdbstub.c
index 4cf8af365e..dde0cfe0fe 100644
--- a/gdbstub.c
+++ b/gdbstub.c
@@ -1810,8 +1810,17 @@ static void handle_read_all_regs(GdbCmdContext *gd=
b_ctx, void *user_ctx)
     cpu_synchronize_state(gdb_ctx->s->g_cpu);
     len =3D 0;
     for (addr =3D 0; addr < gdb_ctx->s->g_cpu->gdb_num_g_regs; addr++) {
-        len +=3D gdb_read_register(gdb_ctx->s->g_cpu, gdb_ctx->mem_buf +=
 len,
-                                 addr);
+        int size =3D gdb_read_register(gdb_ctx->s->g_cpu, gdb_ctx->mem_b=
uf + len,
+                                     addr);
+        if (len + size > MAX_PACKET_LENGTH / 2) {
+            /*
+             * Prevent gdb_ctx->str_buf overflow in memtohex() below.
+             * As a consequence, send only the first registers content.
+             * Gdb will query remaining ones if/when needed.
+             */
+            break;
+        }
+        len +=3D size;
     }
=20
     memtohex(gdb_ctx->str_buf, gdb_ctx->mem_buf, len);
--=20
2.24.0


