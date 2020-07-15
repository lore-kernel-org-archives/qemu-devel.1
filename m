Return-Path: <SRS0=mmJ2=A2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CD03C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2020 18:03:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D88820656
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2020 18:03:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KjWHh+Gc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D88820656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35492 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jvlkt-0005Ll-DO
	for qemu-devel@archiver.kernel.org; Wed, 15 Jul 2020 14:03:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55900)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jvlgK-0001FQ-Nx
 for qemu-devel@nongnu.org; Wed, 15 Jul 2020 13:59:00 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:60994
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jvlgI-0005jD-J1
 for qemu-devel@nongnu.org; Wed, 15 Jul 2020 13:59:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594835937;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GX+Pu6ihdI/d+64Mnf3A4R4YJSyS5RVjuFow1cl3BQ0=;
 b=KjWHh+GcWpyb5JMKJGJIPM0cY5nqyOCt33/vnbit5nFyDOeR7u7XUPe5ZhOtQVeZQ0TcrN
 LMs6zD2vywVcXXCnMXo+4KZGHYKKU2FgZtJbgAAc+vya2eMn3zFl4S0bnDkWToHQAV4ePL
 wSix4TZS1y9ncr1Q/K3dnApBPnxzbxw=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-303-h985qMByPNK4CJMb3ZnIAQ-1; Wed, 15 Jul 2020 13:58:53 -0400
X-MC-Unique: h985qMByPNK4CJMb3ZnIAQ-1
Received: by mail-wr1-f70.google.com with SMTP id b14so1851956wrp.0
 for <qemu-devel@nongnu.org>; Wed, 15 Jul 2020 10:58:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=GX+Pu6ihdI/d+64Mnf3A4R4YJSyS5RVjuFow1cl3BQ0=;
 b=smvK9NzO2HMzB8uZaP7bLNrpg3eXwWTCYdD3AxUSNT5qTYQJ25zdLHNF5q27O45T22
 /jtQvkJJ6Xs10SS+J6HXRO9baYtJ+OX2EJm2e/A40V2bccWCG5J2lezXYbJlIQJzxBEC
 xhP01UmuX1U6uEkQE7qWGnLtbGY+YEANzrhtSlPmhLsUG3ajXwRINFvzsy0iEojZW8c9
 p0WubKERlaRT64CUFfq9kyQ7aBIItUwYZ/9KrFumqxrDof2euqa9WRSBtoydXuURH7uA
 68E2Nli6oQRsRt+arF7GQB+jXi+ji6i4DeBB/qTmlFHbzNA6c/A/au15jYaxSpUbhBZm
 J9tQ==
X-Gm-Message-State: AOAM530nh3G/JcABE8Jz7LxXYmcDC54LvTdjiq2csUdJK4eV0R22ArxA
 epltRJCuQWYyoOLZzyyqtcnJaPXArVhynvUHr7Mh4faG9/vy2+VcPgdqg/FR2eFa0ml6fxXCc2n
 +DFL9WhYf3B4PMgg=
X-Received: by 2002:adf:82a1:: with SMTP id 30mr609520wrc.210.1594835932403;
 Wed, 15 Jul 2020 10:58:52 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzIVDI2Un16qgSYjlCxH4EP4ADqAA3AXmUk0lb3q51HUTWjkxbzBIIt5cYGHvwzbikcb5FeRg==
X-Received: by 2002:adf:82a1:: with SMTP id 30mr609498wrc.210.1594835932110;
 Wed, 15 Jul 2020 10:58:52 -0700 (PDT)
Received: from x1w.redhat.com (138.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.138])
 by smtp.gmail.com with ESMTPSA id m4sm4246164wmi.48.2020.07.15.10.58.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jul 2020 10:58:51 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH-for-5.2 3/5] qom: Use g_autofree in ObjectPropertyGet functions
Date: Wed, 15 Jul 2020 19:58:33 +0200
Message-Id: <20200715175835.27744-4-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200715175835.27744-1-philmd@redhat.com>
References: <20200715175835.27744-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/15 02:01:40
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

By using g_autofree we make it easier to have ObjectPropertyGet
methods return a value (see next commit).

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 backends/tpm/tpm_util.c          |  3 +--
 hw/block/xen-block.c             |  3 +--
 hw/core/qdev-properties-system.c | 13 +++++--------
 hw/mem/nvdimm.c                  |  3 +--
 hw/ppc/spapr_caps.c              |  3 +--
 qom/object.c                     |  6 ++----
 6 files changed, 11 insertions(+), 20 deletions(-)

diff --git a/backends/tpm/tpm_util.c b/backends/tpm/tpm_util.c
index b58d298c1a..235b006498 100644
--- a/backends/tpm/tpm_util.c
+++ b/backends/tpm/tpm_util.c
@@ -37,11 +37,10 @@ static void get_tpm(Object *obj, Visitor *v, const char *name, void *opaque,
 {
     DeviceState *dev = DEVICE(obj);
     TPMBackend **be = qdev_get_prop_ptr(dev, opaque);
-    char *p;
+    g_autofree char *p;
 
     p = g_strdup(*be ? (*be)->id : "");
     visit_type_str(v, name, &p, errp);
-    g_free(p);
 }
 
 static void set_tpm(Object *obj, Visitor *v, const char *name, void *opaque,
diff --git a/hw/block/xen-block.c b/hw/block/xen-block.c
index 8a7a3f5452..8c23b895d9 100644
--- a/hw/block/xen-block.c
+++ b/hw/block/xen-block.c
@@ -338,7 +338,7 @@ static void xen_block_get_vdev(Object *obj, Visitor *v, const char *name,
     DeviceState *dev = DEVICE(obj);
     Property *prop = opaque;
     XenBlockVdev *vdev = qdev_get_prop_ptr(dev, prop);
-    char *str;
+    g_autofree char *str = NULL;
 
     switch (vdev->type) {
     case XEN_BLOCK_VDEV_TYPE_DP:
@@ -366,7 +366,6 @@ static void xen_block_get_vdev(Object *obj, Visitor *v, const char *name,
     }
 
     visit_type_str(v, name, &str, errp);
-    g_free(str);
 }
 
 static int vbd_name_to_disk(const char *name, const char **endp,
diff --git a/hw/core/qdev-properties-system.c b/hw/core/qdev-properties-system.c
index 3e4f16fc21..28682eda31 100644
--- a/hw/core/qdev-properties-system.c
+++ b/hw/core/qdev-properties-system.c
@@ -56,7 +56,7 @@ static void get_drive(Object *obj, Visitor *v, const char *name, void *opaque,
     Property *prop = opaque;
     void **ptr = qdev_get_prop_ptr(dev, prop);
     const char *value;
-    char *p;
+    g_autofree char *p;
 
     if (*ptr) {
         value = blk_name(*ptr);
@@ -72,7 +72,6 @@ static void get_drive(Object *obj, Visitor *v, const char *name, void *opaque,
 
     p = g_strdup(value);
     visit_type_str(v, name, &p, errp);
-    g_free(p);
 }
 
 static void set_drive_helper(Object *obj, Visitor *v, const char *name,
@@ -213,11 +212,10 @@ static void get_chr(Object *obj, Visitor *v, const char *name, void *opaque,
 {
     DeviceState *dev = DEVICE(obj);
     CharBackend *be = qdev_get_prop_ptr(dev, opaque);
-    char *p;
+    g_autofree char *p;
 
     p = g_strdup(be->chr && be->chr->label ? be->chr->label : "");
     visit_type_str(v, name, &p, errp);
-    g_free(p);
 }
 
 static void set_chr(Object *obj, Visitor *v, const char *name, void *opaque,
@@ -287,10 +285,10 @@ static void get_netdev(Object *obj, Visitor *v, const char *name,
     DeviceState *dev = DEVICE(obj);
     Property *prop = opaque;
     NICPeers *peers_ptr = qdev_get_prop_ptr(dev, prop);
-    char *p = g_strdup(peers_ptr->ncs[0] ? peers_ptr->ncs[0]->name : "");
+    g_autofree char *p;
 
+    p = g_strdup(peers_ptr->ncs[0] ? peers_ptr->ncs[0]->name : "");
     visit_type_str(v, name, &p, errp);
-    g_free(p);
 }
 
 static void set_netdev(Object *obj, Visitor *v, const char *name,
@@ -367,10 +365,9 @@ static void get_audiodev(Object *obj, Visitor *v, const char* name,
     DeviceState *dev = DEVICE(obj);
     Property *prop = opaque;
     QEMUSoundCard *card = qdev_get_prop_ptr(dev, prop);
-    char *p = g_strdup(audio_get_id(card));
+    g_autofree char *p = g_strdup(audio_get_id(card));
 
     visit_type_str(v, name, &p, errp);
-    g_free(p);
 }
 
 static void set_audiodev(Object *obj, Visitor *v, const char* name,
diff --git a/hw/mem/nvdimm.c b/hw/mem/nvdimm.c
index d0d6e553cf..b55de7dbe1 100644
--- a/hw/mem/nvdimm.c
+++ b/hw/mem/nvdimm.c
@@ -69,12 +69,11 @@ static void nvdimm_get_uuid(Object *obj, Visitor *v, const char *name,
                                   void *opaque, Error **errp)
 {
     NVDIMMDevice *nvdimm = NVDIMM(obj);
-    char *value = NULL;
+    g_autofree char *value = NULL;
 
     value = qemu_uuid_unparse_strdup(&nvdimm->uuid);
 
     visit_type_str(v, name, &value, errp);
-    g_free(value);
 }
 
 
diff --git a/hw/ppc/spapr_caps.c b/hw/ppc/spapr_caps.c
index 7558db0c8b..cbc09b24b6 100644
--- a/hw/ppc/spapr_caps.c
+++ b/hw/ppc/spapr_caps.c
@@ -101,7 +101,7 @@ static void  spapr_cap_get_string(Object *obj, Visitor *v, const char *name,
 {
     SpaprCapabilityInfo *cap = opaque;
     SpaprMachineState *spapr = SPAPR_MACHINE(obj);
-    char *val = NULL;
+    g_autofree char *val = NULL;
     uint8_t value = spapr_get_cap(spapr, cap->index);
 
     if (value >= cap->possible->num) {
@@ -112,7 +112,6 @@ static void  spapr_cap_get_string(Object *obj, Visitor *v, const char *name,
     val = g_strdup(cap->possible->vals[value]);
 
     visit_type_str(v, name, &val, errp);
-    g_free(val);
 }
 
 static void spapr_cap_set_string(Object *obj, Visitor *v, const char *name,
diff --git a/qom/object.c b/qom/object.c
index e5324f2af7..7c13117f7d 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -1649,11 +1649,10 @@ static void object_get_child_property(Object *obj, Visitor *v,
                                       Error **errp)
 {
     Object *child = opaque;
-    char *path;
+    g_autofree char *path;
 
     path = object_get_canonical_path(child);
     visit_type_str(v, name, &path, errp);
-    g_free(path);
 }
 
 static Object *object_resolve_child_property(Object *parent, void *opaque,
@@ -2099,7 +2098,7 @@ static void property_get_str(Object *obj, Visitor *v, const char *name,
                              void *opaque, Error **errp)
 {
     StringProperty *prop = opaque;
-    char *value;
+    g_autofree char *value = NULL;
     Error *err = NULL;
 
     value = prop->get(obj, &err);
@@ -2109,7 +2108,6 @@ static void property_get_str(Object *obj, Visitor *v, const char *name,
     }
 
     visit_type_str(v, name, &value, errp);
-    g_free(value);
 }
 
 static void property_set_str(Object *obj, Visitor *v, const char *name,
-- 
2.21.3


