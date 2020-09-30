Return-Path: <SRS0=HfOj=DH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFF8BC4727E
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 17:06:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DFD7120754
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 17:06:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fzHzhtou"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DFD7120754
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46820 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNfZ5-0007Em-V2
	for qemu-devel@archiver.kernel.org; Wed, 30 Sep 2020 13:06:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39864)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kNfJS-0006Y3-EQ
 for qemu-devel@nongnu.org; Wed, 30 Sep 2020 12:50:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:33450)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kNfJL-0007BM-R1
 for qemu-devel@nongnu.org; Wed, 30 Sep 2020 12:50:42 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601484634;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ex4gpJ0pAFE1dfNikKPuxcXqvVmymiM2aiqFym1Iy/Y=;
 b=fzHzhtoulxwssc742+zu7HpOQ5UIaL5za750vytoKpr+jc8lxuEeLXcMrSWEesubck0fmO
 x4E6OF9Hr2TK1bXnsrAJ/dyhwELarL6pYQrQvnwWDtJTS6nmt5xZ9k5I6NQ/DODShRht9K
 CGin5QBAjKuMpDn0fbJc41Kw+LmQUzQ=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-300-1LJ5i_eOMPy91xPm8Hu6fw-1; Wed, 30 Sep 2020 12:50:30 -0400
X-MC-Unique: 1LJ5i_eOMPy91xPm8Hu6fw-1
Received: by mail-wr1-f72.google.com with SMTP id l9so817021wrq.20
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2020 09:50:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ex4gpJ0pAFE1dfNikKPuxcXqvVmymiM2aiqFym1Iy/Y=;
 b=FK582+Ln/N+VPEvrmUTv7JxNCyCHofUtBYapDTcbA4b7XXablygeFZjHKlbUVpN9Re
 1hfc8mjG+jUu28KyqUpMdTOrjZjfIz1DxjWGUZ94HR/UUQ0m56qMdbYjsFpygEouW/o7
 1xT3uSPhDXmTd9kQiwv+MWkpNk0WuOIq3H46A8R+nTC1jkil/qNdExtsPzAiWP/kQAou
 BTKoZpOHvEo43qyqr1pcxAJdYCF3li2WLJsrS5Mvs39RV/vmw6r48J2xlkW+UuttWWhv
 c02R/APjaMhlSnwzf3XlhxBp1nWx3QEAsfrW5/3KQWVOdfF9yJ3cV7ieVomjNAaGvjMp
 Vyzg==
X-Gm-Message-State: AOAM530AVfNtblTbBLod/Wc7kNLdA7isMg/XXYDNC0MlHOx8F/Q6FGMV
 78AlU2sFSTADuZZZWG/zdPFaoFS9VCQ4t799v8i8Nm2GT1UiZhrl9KomIKk+gmlqw0dNp7D65n1
 g8dQiyISOSwflPhE=
X-Received: by 2002:a5d:4591:: with SMTP id p17mr4087798wrq.408.1601484629280; 
 Wed, 30 Sep 2020 09:50:29 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzaxdidazBw5vpOugL9EXkBK5RJseRGSh4EGDFBeaOMYTSn9rB+tfKYUFxKWLnmit7u398T8g==
X-Received: by 2002:a5d:4591:: with SMTP id p17mr4087771wrq.408.1601484629067; 
 Wed, 30 Sep 2020 09:50:29 -0700 (PDT)
Received: from x1w.redhat.com (74.red-83-53-161.dynamicip.rima-tde.net.
 [83.53.161.74])
 by smtp.gmail.com with ESMTPSA id l19sm3842702wmi.8.2020.09.30.09.50.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Sep 2020 09:50:28 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org,
	Laurent Vivier <laurent@vivier.eu>
Subject: [PATCH v3 07/11] hw/core/qdev-properties: Export some integer-related
 functions
Date: Wed, 30 Sep 2020 18:49:45 +0200
Message-Id: <20200930164949.1425294-8-philmd@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200930164949.1425294-1-philmd@redhat.com>
References: <20200930164949.1425294-1-philmd@redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/30 00:31:59
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.469,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Ronnie Sahlberg <ronniesahlberg@gmail.com>, qemu-block@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Peter Lieven <pl@kamp.de>, Michael Roth <mdroth@linux.vnet.ibm.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We are going to split this file and reuse these static functions.
Declare them in the local "qdev-prop-internal.h" header.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
v3:
Also export qdev_propinfo_get_size32 introduced in commits
914e74cda9 ("qdev-properties: add size32 property type") and
031ffd9a61 ("qdev-properties: add getter for size32 and blocksize").
---
 hw/core/qdev-prop-internal.h | 11 +++++++++
 hw/core/qdev-properties.c    | 46 +++++++++++++++++++-----------------
 2 files changed, 35 insertions(+), 22 deletions(-)

diff --git a/hw/core/qdev-prop-internal.h b/hw/core/qdev-prop-internal.h
index 2a8c9a306a..9cf5cc1d51 100644
--- a/hw/core/qdev-prop-internal.h
+++ b/hw/core/qdev-prop-internal.h
@@ -15,5 +15,16 @@ void qdev_propinfo_set_enum(Object *obj, Visitor *v, const char *name,
 
 void qdev_propinfo_set_default_value_enum(ObjectProperty *op,
                                           const Property *prop);
+void qdev_propinfo_set_default_value_int(ObjectProperty *op,
+                                         const Property *prop);
+void qdev_propinfo_set_default_value_uint(ObjectProperty *op,
+                                          const Property *prop);
+
+void qdev_propinfo_get_uint16(Object *obj, Visitor *v, const char *name,
+                              void *opaque, Error **errp);
+void qdev_propinfo_get_int32(Object *obj, Visitor *v, const char *name,
+                             void *opaque, Error **errp);
+void qdev_propinfo_get_size32(Object *obj, Visitor *v, const char *name,
+                              void *opaque, Error **errp);
 
 #endif
diff --git a/hw/core/qdev-properties.c b/hw/core/qdev-properties.c
index 31dfe441e2..37e309077a 100644
--- a/hw/core/qdev-properties.c
+++ b/hw/core/qdev-properties.c
@@ -271,12 +271,14 @@ static void set_uint8(Object *obj, Visitor *v, const char *name, void *opaque,
     visit_type_uint8(v, name, ptr, errp);
 }
 
-static void set_default_value_int(ObjectProperty *op, const Property *prop)
+void qdev_propinfo_set_default_value_int(ObjectProperty *op,
+                                         const Property *prop)
 {
     object_property_set_default_int(op, prop->defval.i);
 }
 
-static void set_default_value_uint(ObjectProperty *op, const Property *prop)
+void qdev_propinfo_set_default_value_uint(ObjectProperty *op,
+                                          const Property *prop)
 {
     object_property_set_default_uint(op, prop->defval.u);
 }
@@ -285,13 +287,13 @@ const PropertyInfo qdev_prop_uint8 = {
     .name  = "uint8",
     .get   = get_uint8,
     .set   = set_uint8,
-    .set_default_value = set_default_value_uint,
+    .set_default_value = qdev_propinfo_set_default_value_uint,
 };
 
 /* --- 16bit integer --- */
 
-static void get_uint16(Object *obj, Visitor *v, const char *name,
-                       void *opaque, Error **errp)
+void qdev_propinfo_get_uint16(Object *obj, Visitor *v, const char *name,
+                              void *opaque, Error **errp)
 {
     DeviceState *dev = DEVICE(obj);
     Property *prop = opaque;
@@ -317,9 +319,9 @@ static void set_uint16(Object *obj, Visitor *v, const char *name,
 
 const PropertyInfo qdev_prop_uint16 = {
     .name  = "uint16",
-    .get   = get_uint16,
+    .get   = qdev_propinfo_get_uint16,
     .set   = set_uint16,
-    .set_default_value = set_default_value_uint,
+    .set_default_value = qdev_propinfo_set_default_value_uint,
 };
 
 /* --- 32bit integer --- */
@@ -349,8 +351,8 @@ static void set_uint32(Object *obj, Visitor *v, const char *name,
     visit_type_uint32(v, name, ptr, errp);
 }
 
-static void get_int32(Object *obj, Visitor *v, const char *name, void *opaque,
-                      Error **errp)
+void qdev_propinfo_get_int32(Object *obj, Visitor *v, const char *name,
+                             void *opaque, Error **errp)
 {
     DeviceState *dev = DEVICE(obj);
     Property *prop = opaque;
@@ -378,14 +380,14 @@ const PropertyInfo qdev_prop_uint32 = {
     .name  = "uint32",
     .get   = get_uint32,
     .set   = set_uint32,
-    .set_default_value = set_default_value_uint,
+    .set_default_value = qdev_propinfo_set_default_value_uint,
 };
 
 const PropertyInfo qdev_prop_int32 = {
     .name  = "int32",
-    .get   = get_int32,
+    .get   = qdev_propinfo_get_int32,
     .set   = set_int32,
-    .set_default_value = set_default_value_int,
+    .set_default_value = qdev_propinfo_set_default_value_int,
 };
 
 /* --- 64bit integer --- */
@@ -444,14 +446,14 @@ const PropertyInfo qdev_prop_uint64 = {
     .name  = "uint64",
     .get   = get_uint64,
     .set   = set_uint64,
-    .set_default_value = set_default_value_uint,
+    .set_default_value = qdev_propinfo_set_default_value_uint,
 };
 
 const PropertyInfo qdev_prop_int64 = {
     .name  = "int64",
     .get   = get_int64,
     .set   = set_int64,
-    .set_default_value = set_default_value_int,
+    .set_default_value = qdev_propinfo_set_default_value_int,
 };
 
 /* --- string --- */
@@ -820,8 +822,8 @@ const PropertyInfo qdev_prop_pci_devfn = {
 
 /* --- 32bit unsigned int 'size' type --- */
 
-static void get_size32(Object *obj, Visitor *v, const char *name, void *opaque,
-                       Error **errp)
+void qdev_propinfo_get_size32(Object *obj, Visitor *v, const char *name,
+                              void *opaque, Error **errp)
 {
     DeviceState *dev = DEVICE(obj);
     Property *prop = opaque;
@@ -861,9 +863,9 @@ static void set_size32(Object *obj, Visitor *v, const char *name, void *opaque,
 
 const PropertyInfo qdev_prop_size32 = {
     .name  = "size",
-    .get = get_size32,
+    .get = qdev_propinfo_get_size32,
     .set = set_size32,
-    .set_default_value = set_default_value_uint,
+    .set_default_value = qdev_propinfo_set_default_value_uint,
 };
 
 /* --- blocksize --- */
@@ -919,9 +921,9 @@ const PropertyInfo qdev_prop_blocksize = {
     .name  = "size",
     .description = "A power of two between " MIN_BLOCK_SIZE_STR
                    " and " MAX_BLOCK_SIZE_STR,
-    .get   = get_size32,
+    .get   = qdev_propinfo_get_size32,
     .set   = set_blocksize,
-    .set_default_value = set_default_value_uint,
+    .set_default_value = qdev_propinfo_set_default_value_uint,
 };
 
 /* --- pci host address --- */
@@ -1190,7 +1192,7 @@ const PropertyInfo qdev_prop_arraylen = {
     .name = "uint32",
     .get = get_uint32,
     .set = set_prop_arraylen,
-    .set_default_value = set_default_value_uint,
+    .set_default_value = qdev_propinfo_set_default_value_uint,
 };
 
 /* --- public helpers --- */
@@ -1401,7 +1403,7 @@ const PropertyInfo qdev_prop_size = {
     .name  = "size",
     .get = get_size,
     .set = set_size,
-    .set_default_value = set_default_value_uint,
+    .set_default_value = qdev_propinfo_set_default_value_uint,
 };
 
 /* --- object link property --- */
-- 
2.26.2


