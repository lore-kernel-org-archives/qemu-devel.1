Return-Path: <SRS0=EqPw=EE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B267C2D0A3
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2020 22:24:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7CD6020782
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2020 22:24:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="c5P7dPfp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CD6020782
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36810 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kYGL9-0006Wc-GF
	for qemu-devel@archiver.kernel.org; Thu, 29 Oct 2020 18:24:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42842)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kYG1c-0003tQ-43
 for qemu-devel@nongnu.org; Thu, 29 Oct 2020 18:04:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:36889)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kYG1S-0006ef-T8
 for qemu-devel@nongnu.org; Thu, 29 Oct 2020 18:04:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604009034;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YlrQfX4SrTqb2wRaaHzDfQvREutcnRbIOnsEs/Qo0zw=;
 b=c5P7dPfpXl1FyokmJbymKQC11Sy/l3QJ4vSZ5qs8YUFVT0blU8XE0ciUsc/hd4Sok5GCYh
 fRCQyS1pIq1aQ4HMciI+zciTG8TokKjiQXbmHC3z1nFYao4fCgyzLCLnzZ77tSBo4fkkiT
 rGBAUsEfbogfOR5/3irTUoyrOn0hDFI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-268-sap6O4vUMKm_zFt7d3q6lA-1; Thu, 29 Oct 2020 18:03:51 -0400
X-MC-Unique: sap6O4vUMKm_zFt7d3q6lA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1358A184215B
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2020 22:03:51 +0000 (UTC)
Received: from localhost (ovpn-114-68.rdu2.redhat.com [10.10.114.68])
 by smtp.corp.redhat.com (Postfix) with ESMTP id AE3EE1001281;
 Thu, 29 Oct 2020 22:03:50 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 27/36] qdev: Reuse DEFINE_PROP in all DEFINE_PROP_* macros
Date: Thu, 29 Oct 2020 18:02:37 -0400
Message-Id: <20201029220246.472693-28-ehabkost@redhat.com>
In-Reply-To: <20201029220246.472693-1-ehabkost@redhat.com>
References: <20201029220246.472693-1-ehabkost@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ehabkost@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/29 01:47:28
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: "Daniel P. Berrange" <berrange@redhat.com>, John Snow <jsnow@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Instead of duplicating the code that sets name, info, offset,
and does type checking, make DEFINE_PROP accept a variable number
of arguments and reuse it in all DEFINE_PROP_* macros.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: "Daniel P. Berrangé" <berrange@redhat.com>
Cc: Eduardo Habkost <ehabkost@redhat.com>
Cc: qemu-devel@nongnu.org
---
 include/hw/qdev-properties.h | 132 ++++++++++++-----------------------
 1 file changed, 45 insertions(+), 87 deletions(-)

diff --git a/include/hw/qdev-properties.h b/include/hw/qdev-properties.h
index 3a7b4c8643..f9a4c132e7 100644
--- a/include/hw/qdev-properties.h
+++ b/include/hw/qdev-properties.h
@@ -62,73 +62,46 @@ extern const PropertyInfo qdev_prop_uuid;
 extern const PropertyInfo qdev_prop_arraylen;
 extern const PropertyInfo qdev_prop_link;
 
-#define DEFINE_PROP(_name, _state, _field, _prop, _type) { \
+#define DEFINE_PROP(_name, _state, _field, _prop, _type, ...) {  \
         .name      = (_name),                                    \
         .info      = &(_prop),                                   \
         .offset    = offsetof(_state, _field)                    \
             + type_check(_type, typeof_field(_state, _field)),   \
+        __VA_ARGS__                                              \
         }
 
-#define DEFINE_PROP_SIGNED(_name, _state, _field, _defval, _prop, _type) { \
-        .name      = (_name),                                           \
-        .info      = &(_prop),                                          \
-        .offset    = offsetof(_state, _field)                           \
-            + type_check(_type,typeof_field(_state, _field)),           \
-        .set_default = true,                                            \
-        .defval.i  = (_type)_defval,                                    \
-        }
+#define DEFINE_PROP_SIGNED(_name, _state, _field, _defval, _prop, _type) \
+    DEFINE_PROP(_name, _state, _field, _prop, _type,                     \
+                .set_default = true,                                     \
+                .defval.i    = (_type)_defval)
 
-#define DEFINE_PROP_SIGNED_NODEFAULT(_name, _state, _field, _prop, _type) { \
-        .name      = (_name),                                           \
-        .info      = &(_prop),                                          \
-        .offset    = offsetof(_state, _field)                           \
-            + type_check(_type, typeof_field(_state, _field)),          \
-        }
+#define DEFINE_PROP_SIGNED_NODEFAULT(_name, _state, _field, _prop, _type) \
+    DEFINE_PROP(_name, _state, _field, _prop, _type)
 
-#define DEFINE_PROP_BIT(_name, _state, _field, _bit, _defval) {  \
-        .name      = (_name),                                    \
-        .info      = &(qdev_prop_bit),                           \
-        .bitnr    = (_bit),                                      \
-        .offset    = offsetof(_state, _field)                    \
-            + type_check(uint32_t,typeof_field(_state, _field)), \
-        .set_default = true,                                     \
-        .defval.u  = (bool)_defval,                              \
-        }
+#define DEFINE_PROP_BIT(_name, _state, _field, _bit, _defval)   \
+    DEFINE_PROP(_name, _state, _field, qdev_prop_bit, uint32_t, \
+                .bitnr       = (_bit),                          \
+                .set_default = true,                            \
+                .defval.u    = (bool)_defval)
 
-#define DEFINE_PROP_UNSIGNED(_name, _state, _field, _defval, _prop, _type) { \
-        .name      = (_name),                                           \
-        .info      = &(_prop),                                          \
-        .offset    = offsetof(_state, _field)                           \
-            + type_check(_type, typeof_field(_state, _field)),          \
-        .set_default = true,                                            \
-        .defval.u  = (_type)_defval,                                    \
-        }
+#define DEFINE_PROP_UNSIGNED(_name, _state, _field, _defval, _prop, _type) \
+    DEFINE_PROP(_name, _state, _field, _prop, _type,                       \
+                .set_default = true,                                       \
+                .defval.u  = (_type)_defval)
 
-#define DEFINE_PROP_UNSIGNED_NODEFAULT(_name, _state, _field, _prop, _type) { \
-        .name      = (_name),                                           \
-        .info      = &(_prop),                                          \
-        .offset    = offsetof(_state, _field)                           \
-            + type_check(_type, typeof_field(_state, _field)),          \
-        }
+#define DEFINE_PROP_UNSIGNED_NODEFAULT(_name, _state, _field, _prop, _type) \
+    DEFINE_PROP(_name, _state, _field, _prop, _type)
 
-#define DEFINE_PROP_BIT64(_name, _state, _field, _bit, _defval) {       \
-        .name      = (_name),                                           \
-        .info      = &(qdev_prop_bit64),                                \
-        .bitnr    = (_bit),                                             \
-        .offset    = offsetof(_state, _field)                           \
-            + type_check(uint64_t, typeof_field(_state, _field)),       \
-        .set_default = true,                                            \
-        .defval.u  = (bool)_defval,                                     \
-        }
+#define DEFINE_PROP_BIT64(_name, _state, _field, _bit, _defval)   \
+    DEFINE_PROP(_name, _state, _field, qdev_prop_bit64, uint64_t, \
+                .bitnr    = (_bit),                               \
+                .set_default = true,                              \
+                .defval.u  = (bool)_defval)
 
-#define DEFINE_PROP_BOOL(_name, _state, _field, _defval) {       \
-        .name      = (_name),                                    \
-        .info      = &(qdev_prop_bool),                          \
-        .offset    = offsetof(_state, _field)                    \
-            + type_check(bool, typeof_field(_state, _field)),    \
-        .set_default = true,                                     \
-        .defval.u    = (bool)_defval,                            \
-        }
+#define DEFINE_PROP_BOOL(_name, _state, _field, _defval)     \
+    DEFINE_PROP(_name, _state, _field, qdev_prop_bool, bool, \
+                .set_default = true,                         \
+                .defval.u    = (bool)_defval)
 
 #define PROP_ARRAY_LEN_PREFIX "len-"
 
@@ -156,26 +129,19 @@ extern const PropertyInfo qdev_prop_link;
  * It is the responsibility of the device deinit code to free the
  * @_arrayfield memory.
  */
-#define DEFINE_PROP_ARRAY(_name, _state, _field,                        \
-                          _arrayfield, _arrayprop, _arraytype) {        \
-        .name = (PROP_ARRAY_LEN_PREFIX _name),                          \
-        .info = &(qdev_prop_arraylen),                                  \
-        .set_default = true,                                            \
-        .defval.u = 0,                                                  \
-        .offset = offsetof(_state, _field)                              \
-            + type_check(uint32_t, typeof_field(_state, _field)),       \
-        .arrayinfo = &(_arrayprop),                                     \
-        .arrayfieldsize = sizeof(_arraytype),                           \
-        .arrayoffset = offsetof(_state, _arrayfield),                   \
-        }
+#define DEFINE_PROP_ARRAY(_name, _state, _field,               \
+                          _arrayfield, _arrayprop, _arraytype) \
+    DEFINE_PROP((PROP_ARRAY_LEN_PREFIX _name),                 \
+                _state, _field, qdev_prop_arraylen, uint32_t,  \
+                .set_default = true,                           \
+                .defval.u = 0,                                 \
+                .arrayinfo = &(_arrayprop),                    \
+                .arrayfieldsize = sizeof(_arraytype),          \
+                .arrayoffset = offsetof(_state, _arrayfield))
 
-#define DEFINE_PROP_LINK(_name, _state, _field, _type, _ptr_type) {     \
-        .name = (_name),                                                \
-        .info = &(qdev_prop_link),                                      \
-        .offset = offsetof(_state, _field)                              \
-            + type_check(_ptr_type, typeof_field(_state, _field)),      \
-        .link_type  = _type,                                            \
-        }
+#define DEFINE_PROP_LINK(_name, _state, _field, _type, _ptr_type)     \
+    DEFINE_PROP(_name, _state, _field, qdev_prop_link, _ptr_type,     \
+                .link_type  = _type)
 
 #define DEFINE_PROP_UINT8(_n, _s, _f, _d)                       \
     DEFINE_PROP_UNSIGNED(_n, _s, _f, _d, qdev_prop_uint8, uint8_t)
@@ -197,19 +163,11 @@ extern const PropertyInfo qdev_prop_link;
     DEFINE_PROP_SIGNED(_n, _s, _f, _d, qdev_prop_on_off_auto, OnOffAuto)
 #define DEFINE_PROP_SIZE32(_n, _s, _f, _d)                       \
     DEFINE_PROP_UNSIGNED(_n, _s, _f, _d, qdev_prop_size32, uint32_t)
-#define DEFINE_PROP_UUID(_name, _state, _field) {                  \
-        .name      = (_name),                                      \
-        .info      = &qdev_prop_uuid,                              \
-        .offset    = offsetof(_state, _field)                      \
-            + type_check(QemuUUID, typeof_field(_state, _field)),  \
-        .set_default = true,                                       \
-        }
-#define DEFINE_PROP_UUID_NODEFAULT(_name, _state, _field) {        \
-        .name      = (_name),                                      \
-        .info      = &qdev_prop_uuid,                              \
-        .offset    = offsetof(_state, _field)                      \
-            + type_check(QemuUUID, typeof_field(_state, _field)),  \
-        }
+#define DEFINE_PROP_UUID(_name, _state, _field)                      \
+    DEFINE_PROP(_name, _state, _field, qdev_prop_uuid, QemuUUID,     \
+                .set_default = true)
+#define DEFINE_PROP_UUID_NODEFAULT(_name, _state, _field) \
+    DEFINE_PROP(_name, _state, _field, qdev_prop_uuid, QemuUUID)
 
 #define DEFINE_PROP_END_OF_LIST()               \
     {}
-- 
2.28.0


