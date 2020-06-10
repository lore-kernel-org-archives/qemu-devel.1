Return-Path: <SRS0=wemX=7X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27656C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 06:01:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E48C720801
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 06:01:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P+zClJyo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E48C720801
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41278 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jitnJ-0003oa-4X
	for qemu-devel@archiver.kernel.org; Wed, 10 Jun 2020 02:01:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42642)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jitMS-0005IE-9X
 for qemu-devel@nongnu.org; Wed, 10 Jun 2020 01:33:16 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:35128
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jitMC-0003r8-VN
 for qemu-devel@nongnu.org; Wed, 10 Jun 2020 01:33:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591767179;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QMNqSXNx4us/JNCxyd5YWOdv+mB/JgX/CHnODcMbFEc=;
 b=P+zClJyoNwVM5HkYpecXjrvdmEQaVxGH0iIuEQf1PvKffqeNsKyvu2MSuxvBDqXXJ7QjGD
 cUgkMLZFZgsDGWnXE2FZ3hgkbLADRQ+GP5qjDdJUvcvl/hVDg7c3VqLCNea/ELdU2hJN5v
 hF7PcS56t5sCU5qgdw92lDeNwqczVak=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-198-ZRL-A3tfPEeZq13e6_q3oQ-1; Wed, 10 Jun 2020 01:32:57 -0400
X-MC-Unique: ZRL-A3tfPEeZq13e6_q3oQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8BB27A0BD7;
 Wed, 10 Jun 2020 05:32:56 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-121.ams2.redhat.com
 [10.36.112.121])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5C4EB5C1D2;
 Wed, 10 Jun 2020 05:32:56 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 9E325113847C; Wed, 10 Jun 2020 07:32:48 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH RESEND v3 38/58] macio: Eliminate macio_init_child_obj()
Date: Wed, 10 Jun 2020 07:32:27 +0200
Message-Id: <20200610053247.1583243-39-armbru@redhat.com>
In-Reply-To: <20200610053247.1583243-1-armbru@redhat.com>
References: <20200610053247.1583243-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=armbru@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/09 23:51:15
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
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
Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
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
2.26.2


