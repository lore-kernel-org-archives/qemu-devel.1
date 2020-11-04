Return-Path: <SRS0=hH57=EK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A12F5C2D0A3
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 16:17:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EFC7F2064C
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 16:17:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aDqbaKmR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EFC7F2064C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48242 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kaLTp-000863-TP
	for qemu-devel@archiver.kernel.org; Wed, 04 Nov 2020 11:17:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42598)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kaLFU-00033e-RJ
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 11:03:00 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:22503)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kaLFP-0005f5-2B
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 11:03:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604505774;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VlFRwt8OIy6a5qSZ8j2nB9K/LvlPasl/8PYZPuHbUtM=;
 b=aDqbaKmRMoLpWyLUjiqrsYAmae/gNKaz1xHkYcAqYYc5CQFY5gD3Vpka97GMANsrTYdZlp
 sygeDAtT7o1XDQx9NnKWa8xnAFwRhVTk/axcP10JrfR0Z0CYrPS+1+1awBeWf+dCBwmcMS
 Ypchr0otrgOSEdnSumAYP0gda4IVAgQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-304-dbA46SjHNYObLs4NGivbww-1; Wed, 04 Nov 2020 11:02:52 -0500
X-MC-Unique: dbA46SjHNYObLs4NGivbww-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 90464106B307;
 Wed,  4 Nov 2020 16:01:46 +0000 (UTC)
Received: from localhost (ovpn-114-68.rdu2.redhat.com [10.10.114.68])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 557D773676;
 Wed,  4 Nov 2020 16:01:46 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 23/44] qdev: Make PropertyInfo.create return ObjectProperty*
Date: Wed,  4 Nov 2020 11:00:00 -0500
Message-Id: <20201104160021.2342108-24-ehabkost@redhat.com>
In-Reply-To: <20201104160021.2342108-1-ehabkost@redhat.com>
References: <20201104160021.2342108-1-ehabkost@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ehabkost@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/03 22:09:52
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
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Stefan Berger <stefanb@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Returning ObjectProperty* will be useful for new property
registration code that will add additional callbacks
to ObjectProperty after registering it.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
Changes v1 -> v2:
* Redone patch on top of additional changes in series v2
* Commit message reword
---
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: "Daniel P. Berrangé" <berrange@redhat.com>
Cc: Eduardo Habkost <ehabkost@redhat.com>
Cc: qemu-devel@nongnu.org
---
 include/hw/qdev-properties.h |  3 ++-
 hw/core/qdev-properties.c    | 12 ++++++------
 2 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/include/hw/qdev-properties.h b/include/hw/qdev-properties.h
index ab9c538ba4..aae882317a 100644
--- a/include/hw/qdev-properties.h
+++ b/include/hw/qdev-properties.h
@@ -34,7 +34,8 @@ struct PropertyInfo {
     const QEnumLookup *enum_table;
     int (*print)(Object *obj, Property *prop, char *dest, size_t len);
     void (*set_default_value)(ObjectProperty *op, const Property *prop);
-    void (*create)(ObjectClass *oc, const char *name, Property *prop);
+    ObjectProperty *(*create)(ObjectClass *oc, const char *name,
+                              Property *prop);
     ObjectPropertyAccessor *get;
     ObjectPropertyAccessor *set;
     ObjectPropertyRelease *release;
diff --git a/hw/core/qdev-properties.c b/hw/core/qdev-properties.c
index ff36eb250e..510b3f3fb5 100644
--- a/hw/core/qdev-properties.c
+++ b/hw/core/qdev-properties.c
@@ -821,13 +821,13 @@ const PropertyInfo qdev_prop_size = {
 
 /* --- object link property --- */
 
-static void create_link_property(ObjectClass *oc, const char *name,
-                                 Property *prop)
+static ObjectProperty *create_link_property(ObjectClass *oc, const char *name,
+                                            Property *prop)
 {
-    object_class_property_add_link(oc, name, prop->link_type,
-                                   prop->offset,
-                                   qdev_prop_allow_set_link_before_realize,
-                                   OBJ_PROP_LINK_STRONG);
+    return object_class_property_add_link(oc, name, prop->link_type,
+                                          prop->offset,
+                                          qdev_prop_allow_set_link_before_realize,
+                                          OBJ_PROP_LINK_STRONG);
 }
 
 const PropertyInfo qdev_prop_link = {
-- 
2.28.0


