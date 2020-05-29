Return-Path: <SRS0=UjLb=7L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0B3AC433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2020 13:54:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6877B206A1
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2020 13:54:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fiekUtTg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6877B206A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52136 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jefTM-0003N6-GW
	for qemu-devel@archiver.kernel.org; Fri, 29 May 2020 09:54:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49238)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jefKQ-0002pH-9D
 for qemu-devel@nongnu.org; Fri, 29 May 2020 09:45:42 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:51688
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jefKK-00074q-Rw
 for qemu-devel@nongnu.org; Fri, 29 May 2020 09:45:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590759935;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VC3iWxC5cHejzquo9EOrkAWenZ5Dd7GkOEj2r7AQLyU=;
 b=fiekUtTgM7AzAH4MJEdYNjTSgslawmKsZheZIXiOMAySTSWKZTSF26fMKyCvIOYvu0wHLy
 rEf/PKCsVTUN/5YAxWjVnVmLs+phHuHNcPD+pwdT21kp+bNuhjorUnqDaFbL90z4gVhCIt
 /wmlcwzZjNoFDmdMez7iZojI1/8RbI8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-36-_JUngpKJPmOnEsQlvgvfBA-1; Fri, 29 May 2020 09:45:33 -0400
X-MC-Unique: _JUngpKJPmOnEsQlvgvfBA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9A6EF8005AA;
 Fri, 29 May 2020 13:45:32 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-32.ams2.redhat.com
 [10.36.112.32])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6D5CD5C1B0;
 Fri, 29 May 2020 13:45:32 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 602DF1135230; Fri, 29 May 2020 15:45:24 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 38/58] macio: Eliminate macio_init_child_obj()
Date: Fri, 29 May 2020 15:45:03 +0200
Message-Id: <20200529134523.8477-39-armbru@redhat.com>
In-Reply-To: <20200529134523.8477-1-armbru@redhat.com>
References: <20200529134523.8477-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/29 03:05:19
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

macio_init_child_obj() has become a trivial wrapper around
object_initialize_child_with_props().  Eliminate it, since the general
convenience wrapper object_initialize_child() is just as convenient
already.

Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: David Gibson <david@gibson.dropbear.id.au>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 hw/misc/macio/macio.c | 30 +++++++++---------------------
 1 file changed, 9 insertions(+), 21 deletions(-)

diff --git a/hw/misc/macio/macio.c b/hw/misc/macio/macio.c
index 1a07ca2ca5..8ba7af073c 100644
--- a/hw/misc/macio/macio.c
+++ b/hw/misc/macio/macio.c
@@ -94,14 +94,6 @@ static void macio_bar_setup(MacIOState *s)
     macio_escc_legacy_setup(s);
 }
 
-static void macio_init_child_obj(MacIOState *s, const char *childname,
-                                 void *child, size_t childsize,
-                                 const char *childtype)
-{
-    object_initialize_child_with_props(OBJECT(s), childname, child, childsize,
-                                       childtype, &error_abort, NULL);
-}
-
 static void macio_common_realize(PCIDevice *d, Error **errp)
 {
     MacIOState *s = MACIO(d);
@@ -218,13 +210,12 @@ static void macio_oldworld_realize(PCIDevice *d, Error **errp)
     }
 }
 
-static void macio_init_ide(MacIOState *s, MACIOIDEState *ide, size_t ide_size,
-                           int index)
+static void macio_init_ide(MacIOState *s, MACIOIDEState *ide, int index)
 {
     gchar *name = g_strdup_printf("ide[%i]", index);
     uint32_t addr = 0x1f000 + ((index + 1) * 0x1000);
 
-    macio_init_child_obj(s, name, ide, ide_size, TYPE_MACIO_IDE);
+    object_initialize_child(OBJECT(s), name, ide, TYPE_MACIO_IDE);
     qdev_prop_set_uint32(DEVICE(ide), "addr", addr);
     memory_region_add_subregion(&s->bar, addr, &ide->mem);
     g_free(name);
@@ -242,16 +233,15 @@ static void macio_oldworld_init(Object *obj)
                              qdev_prop_allow_set_link_before_realize,
                              0);
 
-    macio_init_child_obj(s, "cuda", &s->cuda, sizeof(s->cuda), TYPE_CUDA);
+    object_initialize_child(OBJECT(s), "cuda", &s->cuda, TYPE_CUDA);
 
-    macio_init_child_obj(s, "nvram", &os->nvram, sizeof(os->nvram),
-                         TYPE_MACIO_NVRAM);
+    object_initialize_child(OBJECT(s), "nvram", &os->nvram, TYPE_MACIO_NVRAM);
     dev = DEVICE(&os->nvram);
     qdev_prop_set_uint32(dev, "size", 0x2000);
     qdev_prop_set_uint32(dev, "it_shift", 4);
 
     for (i = 0; i < 2; i++) {
-        macio_init_ide(s, &os->ide[i], sizeof(os->ide[i]), i);
+        macio_init_ide(s, &os->ide[i], i);
     }
 }
 
@@ -396,11 +386,10 @@ static void macio_newworld_init(Object *obj)
                              qdev_prop_allow_set_link_before_realize,
                              0);
 
-    macio_init_child_obj(s, "gpio", &ns->gpio, sizeof(ns->gpio),
-                         TYPE_MACIO_GPIO);
+    object_initialize_child(OBJECT(s), "gpio", &ns->gpio, TYPE_MACIO_GPIO);
 
     for (i = 0; i < 2; i++) {
-        macio_init_ide(s, &ns->ide[i], sizeof(ns->ide[i]), i);
+        macio_init_ide(s, &ns->ide[i], i);
     }
 }
 
@@ -413,10 +402,9 @@ static void macio_instance_init(Object *obj)
     qbus_create_inplace(&s->macio_bus, sizeof(s->macio_bus), TYPE_MACIO_BUS,
                         DEVICE(obj), "macio.0");
 
-    macio_init_child_obj(s, "dbdma", &s->dbdma, sizeof(s->dbdma),
-                         TYPE_MAC_DBDMA);
+    object_initialize_child(OBJECT(s), "dbdma", &s->dbdma, TYPE_MAC_DBDMA);
 
-    macio_init_child_obj(s, "escc", &s->escc, sizeof(s->escc), TYPE_ESCC);
+    object_initialize_child(OBJECT(s), "escc", &s->escc, TYPE_ESCC);
 }
 
 static const VMStateDescription vmstate_macio_oldworld = {
-- 
2.21.3


