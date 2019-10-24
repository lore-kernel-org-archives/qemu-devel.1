Return-Path: <SRS0=Jnn8=YR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F36A9CA9EAF
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 15:22:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7C4082064A
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 15:22:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d6heQ/OB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C4082064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45302 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNewc-0005OE-Qk
	for qemu-devel@archiver.kernel.org; Thu, 24 Oct 2019 11:22:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34825)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iNdiy-0007ry-Lh
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 10:04:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iNdit-0007ih-At
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 10:04:24 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a]:53281)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1iNdir-0007hQ-OI
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 10:04:18 -0400
Received: by mail-wm1-x32a.google.com with SMTP id n7so2166733wmc.3
 for <qemu-devel@nongnu.org>; Thu, 24 Oct 2019 07:04:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=nbdM4QsVX6w/vZF6SHA0C1caqBfc8BftNTLt4pHDGbQ=;
 b=d6heQ/OBpiVsx1ecilCPT+HUeoAdccwTZUdXs0eAT//BB9MAAL3NzqsWe8p/rFAwkm
 4gNQWW4N2VL5S8CpmYZqjdAiJGbt6RYyqZQZqI20oiL0YAqClvyVRwHU1rbl7voyX8RL
 fMWh2w1LvvYVZtF+C8G6N/DiXHC/lZIFamSNcZmlaOA4kqn0NxONoJynF5IuaQD/IHaP
 JfQi5apBa/8GZdf0PuUnm3AI8TzceISZ7AbyXSDbE9Tp12lIGZoXvIrETsPF/pm5XJzj
 8EQXB1iELmwVJiZ6c1T8cYPClSa6E4s3zBF+LNYUzv62qqKlcEGH0Yic2WxrUdLRCSdt
 bOjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=nbdM4QsVX6w/vZF6SHA0C1caqBfc8BftNTLt4pHDGbQ=;
 b=FGyVzSqzuSCQxWmv+QKCmBw/tSyYVA84WR9aKpO2MI2UjE+jvGv9wH1EqPjtq9OciT
 bIfD5jRGeIjS4Etbu0MPp7rRsV17TjJwTXYSnaY/ksjrNIT+ZyoMRexPnPi+WMwTsZq5
 tEwoQjcPLGNZSQ7MfVamNhNUtf2GWcL8Gb/JfjFaWyadlSWd4SSqMPcLxeeax15nH4ZI
 Ubk3mQO6MdjUVMe1p891CSkPinoo5wPX7jyXb1XZVWcMsPzDYGx0mqFAIkMN74eMPHe0
 gfTEaUmECx73/ZwORlY0tqiwbTUpqSF59bCTlGbGdHI/SRrK3BcbHbGtlccZBhUUksIR
 ZI7Q==
X-Gm-Message-State: APjAAAU7pu0wZob2cJRLZuiVXkO9dAneVtoz0zkrQUvLKalEwCqMQX4J
 1NSrPWE8Qm8udkDUvbvLZBhCQbzr
X-Google-Smtp-Source: APXvYqw7/VeX3i9cgxJ9iiNHwbF3RFDBrDwZ222FLJnkpUPZHsdovMjryKNglHUFm7zPnz9QkrJTSg==
X-Received: by 2002:a1c:6386:: with SMTP id x128mr4994980wmb.41.1571925855227; 
 Thu, 24 Oct 2019 07:04:15 -0700 (PDT)
Received: from 640k.localdomain ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id b7sm10610155wrn.53.2019.10.24.07.04.14
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 24 Oct 2019 07:04:14 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 16/39] fw_cfg: add "modify" functions for all types
Date: Thu, 24 Oct 2019 16:03:32 +0200
Message-Id: <1571925835-31930-17-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1571925835-31930-1-git-send-email-pbonzini@redhat.com>
References: <1571925835-31930-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32a
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
Cc: Sergio Lopez <slp@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Sergio Lopez <slp@redhat.com>

This allows to alter the contents of an already added item.

Signed-off-by: Sergio Lopez <slp@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 hw/nvram/fw_cfg.c         | 29 +++++++++++++++++++++++++++++
 include/hw/nvram/fw_cfg.h | 42 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 71 insertions(+)

diff --git a/hw/nvram/fw_cfg.c b/hw/nvram/fw_cfg.c
index 7dc3ac3..aef1727 100644
--- a/hw/nvram/fw_cfg.c
+++ b/hw/nvram/fw_cfg.c
@@ -690,6 +690,15 @@ void fw_cfg_add_string(FWCfgState *s, uint16_t key, const char *value)
     fw_cfg_add_bytes(s, key, g_memdup(value, sz), sz);
 }
 
+void fw_cfg_modify_string(FWCfgState *s, uint16_t key, const char *value)
+{
+    size_t sz = strlen(value) + 1;
+    char *old;
+
+    old = fw_cfg_modify_bytes_read(s, key, g_memdup(value, sz), sz);
+    g_free(old);
+}
+
 void fw_cfg_add_i16(FWCfgState *s, uint16_t key, uint16_t value)
 {
     uint16_t *copy;
@@ -720,6 +729,16 @@ void fw_cfg_add_i32(FWCfgState *s, uint16_t key, uint32_t value)
     fw_cfg_add_bytes(s, key, copy, sizeof(value));
 }
 
+void fw_cfg_modify_i32(FWCfgState *s, uint16_t key, uint32_t value)
+{
+    uint32_t *copy, *old;
+
+    copy = g_malloc(sizeof(value));
+    *copy = cpu_to_le32(value);
+    old = fw_cfg_modify_bytes_read(s, key, copy, sizeof(value));
+    g_free(old);
+}
+
 void fw_cfg_add_i64(FWCfgState *s, uint16_t key, uint64_t value)
 {
     uint64_t *copy;
@@ -730,6 +749,16 @@ void fw_cfg_add_i64(FWCfgState *s, uint16_t key, uint64_t value)
     fw_cfg_add_bytes(s, key, copy, sizeof(value));
 }
 
+void fw_cfg_modify_i64(FWCfgState *s, uint16_t key, uint64_t value)
+{
+    uint64_t *copy, *old;
+
+    copy = g_malloc(sizeof(value));
+    *copy = cpu_to_le64(value);
+    old = fw_cfg_modify_bytes_read(s, key, copy, sizeof(value));
+    g_free(old);
+}
+
 void fw_cfg_set_order_override(FWCfgState *s, int order)
 {
     assert(s->fw_cfg_order_override == 0);
diff --git a/include/hw/nvram/fw_cfg.h b/include/hw/nvram/fw_cfg.h
index 80e435d..b5291ee 100644
--- a/include/hw/nvram/fw_cfg.h
+++ b/include/hw/nvram/fw_cfg.h
@@ -99,6 +99,20 @@ void fw_cfg_add_bytes(FWCfgState *s, uint16_t key, void *data, size_t len);
 void fw_cfg_add_string(FWCfgState *s, uint16_t key, const char *value);
 
 /**
+ * fw_cfg_modify_string:
+ * @s: fw_cfg device being modified
+ * @key: selector key value for new fw_cfg item
+ * @value: NUL-terminated ascii string
+ *
+ * Replace the fw_cfg item available by selecting the given key. The new
+ * data will consist of a dynamically allocated copy of the provided string,
+ * including its NUL terminator. The data being replaced, assumed to have
+ * been dynamically allocated during an earlier call to either
+ * fw_cfg_add_string() or fw_cfg_modify_string(), is freed before returning.
+ */
+void fw_cfg_modify_string(FWCfgState *s, uint16_t key, const char *value);
+
+/**
  * fw_cfg_add_i16:
  * @s: fw_cfg device being modified
  * @key: selector key value for new fw_cfg item
@@ -137,6 +151,20 @@ void fw_cfg_modify_i16(FWCfgState *s, uint16_t key, uint16_t value);
 void fw_cfg_add_i32(FWCfgState *s, uint16_t key, uint32_t value);
 
 /**
+ * fw_cfg_modify_i32:
+ * @s: fw_cfg device being modified
+ * @key: selector key value for new fw_cfg item
+ * @value: 32-bit integer
+ *
+ * Replace the fw_cfg item available by selecting the given key. The new
+ * data will consist of a dynamically allocated copy of the given 32-bit
+ * value, converted to little-endian representation. The data being replaced,
+ * assumed to have been dynamically allocated during an earlier call to
+ * either fw_cfg_add_i32() or fw_cfg_modify_i32(), is freed before returning.
+ */
+void fw_cfg_modify_i32(FWCfgState *s, uint16_t key, uint32_t value);
+
+/**
  * fw_cfg_add_i64:
  * @s: fw_cfg device being modified
  * @key: selector key value for new fw_cfg item
@@ -149,6 +177,20 @@ void fw_cfg_add_i32(FWCfgState *s, uint16_t key, uint32_t value);
 void fw_cfg_add_i64(FWCfgState *s, uint16_t key, uint64_t value);
 
 /**
+ * fw_cfg_modify_i64:
+ * @s: fw_cfg device being modified
+ * @key: selector key value for new fw_cfg item
+ * @value: 64-bit integer
+ *
+ * Replace the fw_cfg item available by selecting the given key. The new
+ * data will consist of a dynamically allocated copy of the given 64-bit
+ * value, converted to little-endian representation. The data being replaced,
+ * assumed to have been dynamically allocated during an earlier call to
+ * either fw_cfg_add_i64() or fw_cfg_modify_i64(), is freed before returning.
+ */
+void fw_cfg_modify_i64(FWCfgState *s, uint16_t key, uint64_t value);
+
+/**
  * fw_cfg_add_file:
  * @s: fw_cfg device being modified
  * @filename: name of new fw_cfg file item
-- 
1.8.3.1



