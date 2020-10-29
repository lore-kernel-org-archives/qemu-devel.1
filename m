Return-Path: <SRS0=EqPw=EE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17B24C2D0A3
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2020 22:17:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 70447206CB
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2020 22:17:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W8H1YuDO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70447206CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41156 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kYGEI-00055O-C8
	for qemu-devel@archiver.kernel.org; Thu, 29 Oct 2020 18:17:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42530)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kYG14-0003Pg-SJ
 for qemu-devel@nongnu.org; Thu, 29 Oct 2020 18:03:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:33919)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kYG11-0006Zt-Uy
 for qemu-devel@nongnu.org; Thu, 29 Oct 2020 18:03:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604009004;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NctMuJLA1Rf4RgP5PRiGy0e4/n5BNGh0iuXOJxgJ/F4=;
 b=W8H1YuDOtmYJirHco0p9LilqNxfX5e5zI+M49asbfYp3MqAAicTzPrcv9RIaY+pw+Gigyu
 yAVELLiaURQHrhqnHV/mxffzSdKlclmHA7sAGjAXXsTbeybtoTEbdWZa/lgPT5dYCVHepW
 h4TlzHK0xhVQyc1dvn3tM5Ot6L7FQMc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-393-4v5942gfNqqpLZGQYDAWhA-1; Thu, 29 Oct 2020 18:03:22 -0400
X-MC-Unique: 4v5942gfNqqpLZGQYDAWhA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1D830835B47;
 Thu, 29 Oct 2020 22:03:21 +0000 (UTC)
Received: from localhost (ovpn-114-68.rdu2.redhat.com [10.10.114.68])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C70EA5B4C4;
 Thu, 29 Oct 2020 22:03:17 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 12/36] qdev: Make error_set_from_qdev_prop_error() get Object*
 argument
Date: Thu, 29 Oct 2020 18:02:22 -0400
Message-Id: <20201029220246.472693-13-ehabkost@redhat.com>
In-Reply-To: <20201029220246.472693-1-ehabkost@redhat.com>
References: <20201029220246.472693-1-ehabkost@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ehabkost@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/29 00:47:54
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: Thomas Huth <thuth@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>,
 David Hildenbrand <david@redhat.com>, John Snow <jsnow@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org,
 Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Make the code more generic and not specific to TYPE_DEVICE.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: "Daniel P. Berrangé" <berrange@redhat.com>
Cc: Eduardo Habkost <ehabkost@redhat.com>
Cc: Cornelia Huck <cohuck@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>
Cc: Richard Henderson <rth@twiddle.net>
Cc: David Hildenbrand <david@redhat.com>
Cc: Halil Pasic <pasic@linux.ibm.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org
---
 include/hw/qdev-properties.h     |  2 +-
 hw/core/qdev-properties-system.c | 10 +++++-----
 hw/core/qdev-properties.c        | 10 +++++-----
 hw/s390x/css.c                   |  2 +-
 4 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/include/hw/qdev-properties.h b/include/hw/qdev-properties.h
index 7620095fed..530286e869 100644
--- a/include/hw/qdev-properties.h
+++ b/include/hw/qdev-properties.h
@@ -309,7 +309,7 @@ const GlobalProperty *qdev_find_global_prop(Object *obj,
                                             const char *name);
 int qdev_prop_check_globals(void);
 void qdev_prop_set_globals(DeviceState *dev);
-void error_set_from_qdev_prop_error(Error **errp, int ret, DeviceState *dev,
+void error_set_from_qdev_prop_error(Error **errp, int ret, Object *obj,
                                     Property *prop, const char *value);
 
 /**
diff --git a/hw/core/qdev-properties-system.c b/hw/core/qdev-properties-system.c
index 85dd38db0f..fca1b694ca 100644
--- a/hw/core/qdev-properties-system.c
+++ b/hw/core/qdev-properties-system.c
@@ -352,7 +352,7 @@ static void set_mac(Object *obj, Visitor *v, const char *name, void *opaque,
     return;
 
 inval:
-    error_set_from_qdev_prop_error(errp, EINVAL, dev, prop, str);
+    error_set_from_qdev_prop_error(errp, EINVAL, obj, prop, str);
     g_free(str);
 }
 
@@ -440,7 +440,7 @@ static void set_netdev(Object *obj, Visitor *v, const char *name,
     peers_ptr->queues = queues;
 
 out:
-    error_set_from_qdev_prop_error(errp, err, dev, prop, str);
+    error_set_from_qdev_prop_error(errp, err, obj, prop, str);
     g_free(str);
 }
 
@@ -492,7 +492,7 @@ static void set_audiodev(Object *obj, Visitor *v, const char* name,
     card->state = state;
 
 out:
-    error_set_from_qdev_prop_error(errp, err, dev, prop, str);
+    error_set_from_qdev_prop_error(errp, err, obj, prop, str);
     g_free(str);
 }
 
@@ -790,7 +790,7 @@ static void set_pci_devfn(Object *obj, Visitor *v, const char *name,
     return;
 
 invalid:
-    error_set_from_qdev_prop_error(errp, EINVAL, dev, prop, str);
+    error_set_from_qdev_prop_error(errp, EINVAL, obj, prop, str);
     g_free(str);
 }
 
@@ -913,7 +913,7 @@ static void set_pci_host_devaddr(Object *obj, Visitor *v, const char *name,
     return;
 
 inval:
-    error_set_from_qdev_prop_error(errp, EINVAL, dev, prop, str);
+    error_set_from_qdev_prop_error(errp, EINVAL, obj, prop, str);
     g_free(str);
 }
 
diff --git a/hw/core/qdev-properties.c b/hw/core/qdev-properties.c
index 41482d83d1..5e010afdb8 100644
--- a/hw/core/qdev-properties.c
+++ b/hw/core/qdev-properties.c
@@ -581,7 +581,7 @@ static void set_uuid(Object *obj, Visitor *v, const char *name, void *opaque,
     if (!strcmp(str, UUID_VALUE_AUTO)) {
         qemu_uuid_generate(uuid);
     } else if (qemu_uuid_parse(str, uuid) < 0) {
-        error_set_from_qdev_prop_error(errp, EINVAL, dev, prop, str);
+        error_set_from_qdev_prop_error(errp, EINVAL, obj, prop, str);
     }
     g_free(str);
 }
@@ -735,22 +735,22 @@ static Property *qdev_prop_find(DeviceState *dev, const char *name)
     return NULL;
 }
 
-void error_set_from_qdev_prop_error(Error **errp, int ret, DeviceState *dev,
+void error_set_from_qdev_prop_error(Error **errp, int ret, Object *obj,
                                     Property *prop, const char *value)
 {
     switch (ret) {
     case -EEXIST:
         error_setg(errp, "Property '%s.%s' can't take value '%s', it's in use",
-                  object_get_typename(OBJECT(dev)), prop->name, value);
+                  object_get_typename(obj), prop->name, value);
         break;
     default:
     case -EINVAL:
         error_setg(errp, QERR_PROPERTY_VALUE_BAD,
-                   object_get_typename(OBJECT(dev)), prop->name, value);
+                   object_get_typename(obj), prop->name, value);
         break;
     case -ENOENT:
         error_setg(errp, "Property '%s.%s' can't find value '%s'",
-                  object_get_typename(OBJECT(dev)), prop->name, value);
+                  object_get_typename(obj), prop->name, value);
         break;
     case 0:
         break;
diff --git a/hw/s390x/css.c b/hw/s390x/css.c
index 2b8f33fec2..38fd46b9a9 100644
--- a/hw/s390x/css.c
+++ b/hw/s390x/css.c
@@ -2390,7 +2390,7 @@ static void set_css_devid(Object *obj, Visitor *v, const char *name,
 
     num = sscanf(str, "%2x.%1x%n.%4x%n", &cssid, &ssid, &n1, &devid, &n2);
     if (num != 3 || (n2 - n1) != 5 || strlen(str) != n2) {
-        error_set_from_qdev_prop_error(errp, EINVAL, dev, prop, str);
+        error_set_from_qdev_prop_error(errp, EINVAL, obj, prop, str);
         goto out;
     }
     if ((cssid > MAX_CSSID) || (ssid > MAX_SSID)) {
-- 
2.28.0


