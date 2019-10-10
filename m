Return-Path: <SRS0=X6L9=YD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9880CECE58E
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2019 14:39:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 71882208C3
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2019 14:39:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71882208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40466 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIZan-0007KN-3g
	for qemu-devel@archiver.kernel.org; Thu, 10 Oct 2019 10:39:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52632)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <slp@redhat.com>) id 1iIZXG-0002Qy-6Q
 for qemu-devel@nongnu.org; Thu, 10 Oct 2019 10:35:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <slp@redhat.com>) id 1iIZXE-0001zi-4v
 for qemu-devel@nongnu.org; Thu, 10 Oct 2019 10:35:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52272)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <slp@redhat.com>) id 1iIZXD-0001zQ-Sy
 for qemu-devel@nongnu.org; Thu, 10 Oct 2019 10:35:20 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 1E4AB30044CE;
 Thu, 10 Oct 2019 14:35:18 +0000 (UTC)
Received: from dritchie.redhat.com (unknown [10.33.36.122])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5940960BE1;
 Thu, 10 Oct 2019 14:35:07 +0000 (UTC)
From: Sergio Lopez <slp@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v8 10/15] fw_cfg: add "modify" functions for all types
Date: Thu, 10 Oct 2019 16:31:21 +0200
Message-Id: <20191010143125.67246-12-slp@redhat.com>
In-Reply-To: <20191010143125.67246-1-slp@redhat.com>
References: <20191010143125.67246-1-slp@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.46]); Thu, 10 Oct 2019 14:35:18 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: ehabkost@redhat.com, Sergio Lopez <slp@redhat.com>, mst@redhat.com,
 lersek@redhat.com, kraxel@redhat.com, pbonzini@redhat.com, imammedo@redhat.com,
 sgarzare@redhat.com, philmd@redhat.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This allows to alter the contents of an already added item.

Signed-off-by: Sergio Lopez <slp@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/hw/nvram/fw_cfg.h | 42 +++++++++++++++++++++++++++++++++++++++
 hw/nvram/fw_cfg.c         | 29 +++++++++++++++++++++++++++
 2 files changed, 71 insertions(+)

diff --git a/include/hw/nvram/fw_cfg.h b/include/hw/nvram/fw_cfg.h
index 80e435d303..b5291eefad 100644
--- a/include/hw/nvram/fw_cfg.h
+++ b/include/hw/nvram/fw_cfg.h
@@ -98,6 +98,20 @@ void fw_cfg_add_bytes(FWCfgState *s, uint16_t key, voi=
d *data, size_t len);
  */
 void fw_cfg_add_string(FWCfgState *s, uint16_t key, const char *value);
=20
+/**
+ * fw_cfg_modify_string:
+ * @s: fw_cfg device being modified
+ * @key: selector key value for new fw_cfg item
+ * @value: NUL-terminated ascii string
+ *
+ * Replace the fw_cfg item available by selecting the given key. The new
+ * data will consist of a dynamically allocated copy of the provided str=
ing,
+ * including its NUL terminator. The data being replaced, assumed to hav=
e
+ * been dynamically allocated during an earlier call to either
+ * fw_cfg_add_string() or fw_cfg_modify_string(), is freed before return=
ing.
+ */
+void fw_cfg_modify_string(FWCfgState *s, uint16_t key, const char *value=
);
+
 /**
  * fw_cfg_add_i16:
  * @s: fw_cfg device being modified
@@ -136,6 +150,20 @@ void fw_cfg_modify_i16(FWCfgState *s, uint16_t key, =
uint16_t value);
  */
 void fw_cfg_add_i32(FWCfgState *s, uint16_t key, uint32_t value);
=20
+/**
+ * fw_cfg_modify_i32:
+ * @s: fw_cfg device being modified
+ * @key: selector key value for new fw_cfg item
+ * @value: 32-bit integer
+ *
+ * Replace the fw_cfg item available by selecting the given key. The new
+ * data will consist of a dynamically allocated copy of the given 32-bit
+ * value, converted to little-endian representation. The data being repl=
aced,
+ * assumed to have been dynamically allocated during an earlier call to
+ * either fw_cfg_add_i32() or fw_cfg_modify_i32(), is freed before retur=
ning.
+ */
+void fw_cfg_modify_i32(FWCfgState *s, uint16_t key, uint32_t value);
+
 /**
  * fw_cfg_add_i64:
  * @s: fw_cfg device being modified
@@ -148,6 +176,20 @@ void fw_cfg_add_i32(FWCfgState *s, uint16_t key, uin=
t32_t value);
  */
 void fw_cfg_add_i64(FWCfgState *s, uint16_t key, uint64_t value);
=20
+/**
+ * fw_cfg_modify_i64:
+ * @s: fw_cfg device being modified
+ * @key: selector key value for new fw_cfg item
+ * @value: 64-bit integer
+ *
+ * Replace the fw_cfg item available by selecting the given key. The new
+ * data will consist of a dynamically allocated copy of the given 64-bit
+ * value, converted to little-endian representation. The data being repl=
aced,
+ * assumed to have been dynamically allocated during an earlier call to
+ * either fw_cfg_add_i64() or fw_cfg_modify_i64(), is freed before retur=
ning.
+ */
+void fw_cfg_modify_i64(FWCfgState *s, uint16_t key, uint64_t value);
+
 /**
  * fw_cfg_add_file:
  * @s: fw_cfg device being modified
diff --git a/hw/nvram/fw_cfg.c b/hw/nvram/fw_cfg.c
index 7dc3ac378e..aef1727250 100644
--- a/hw/nvram/fw_cfg.c
+++ b/hw/nvram/fw_cfg.c
@@ -690,6 +690,15 @@ void fw_cfg_add_string(FWCfgState *s, uint16_t key, =
const char *value)
     fw_cfg_add_bytes(s, key, g_memdup(value, sz), sz);
 }
=20
+void fw_cfg_modify_string(FWCfgState *s, uint16_t key, const char *value=
)
+{
+    size_t sz =3D strlen(value) + 1;
+    char *old;
+
+    old =3D fw_cfg_modify_bytes_read(s, key, g_memdup(value, sz), sz);
+    g_free(old);
+}
+
 void fw_cfg_add_i16(FWCfgState *s, uint16_t key, uint16_t value)
 {
     uint16_t *copy;
@@ -720,6 +729,16 @@ void fw_cfg_add_i32(FWCfgState *s, uint16_t key, uin=
t32_t value)
     fw_cfg_add_bytes(s, key, copy, sizeof(value));
 }
=20
+void fw_cfg_modify_i32(FWCfgState *s, uint16_t key, uint32_t value)
+{
+    uint32_t *copy, *old;
+
+    copy =3D g_malloc(sizeof(value));
+    *copy =3D cpu_to_le32(value);
+    old =3D fw_cfg_modify_bytes_read(s, key, copy, sizeof(value));
+    g_free(old);
+}
+
 void fw_cfg_add_i64(FWCfgState *s, uint16_t key, uint64_t value)
 {
     uint64_t *copy;
@@ -730,6 +749,16 @@ void fw_cfg_add_i64(FWCfgState *s, uint16_t key, uin=
t64_t value)
     fw_cfg_add_bytes(s, key, copy, sizeof(value));
 }
=20
+void fw_cfg_modify_i64(FWCfgState *s, uint16_t key, uint64_t value)
+{
+    uint64_t *copy, *old;
+
+    copy =3D g_malloc(sizeof(value));
+    *copy =3D cpu_to_le64(value);
+    old =3D fw_cfg_modify_bytes_read(s, key, copy, sizeof(value));
+    g_free(old);
+}
+
 void fw_cfg_set_order_override(FWCfgState *s, int order)
 {
     assert(s->fw_cfg_order_override =3D=3D 0);
--=20
2.21.0


