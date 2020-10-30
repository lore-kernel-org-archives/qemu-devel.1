Return-Path: <SRS0=q+n2=EF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B28EC00A89
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 20:29:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 73D1020791
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 20:29:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="as7XOvV1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73D1020791
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41678 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kYb1u-0003mq-F4
	for qemu-devel@archiver.kernel.org; Fri, 30 Oct 2020 16:29:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53062)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kYauE-0000a6-Mi
 for qemu-devel@nongnu.org; Fri, 30 Oct 2020 16:21:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:54674)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kYauC-0007iV-UX
 for qemu-devel@nongnu.org; Fri, 30 Oct 2020 16:21:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604089308;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TkzKicG/kMOdvt3TdBS42FPTR69wOOGeaV4o4fkuaW4=;
 b=as7XOvV14mxgb3N1AaZIVtKjN660L0K0I0DNlZhr6Ranu1piXdVzB84IKEex4JVMWH0v0D
 y0RcmDMQHMQeVATe/UDqX/I1xSZs5FvYDE3VZuMD2IoVSq1zWLdu5v80uXQqxtsN9cSK+3
 tSfo7I+C2g5zhqVshKuwRrf4jN1WqBA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-591-tN6AolSuOVGyszaNF52clg-1; Fri, 30 Oct 2020 16:21:46 -0400
X-MC-Unique: tN6AolSuOVGyszaNF52clg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8DBDA805EF6
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2020 20:21:45 +0000 (UTC)
Received: from localhost (ovpn-114-68.rdu2.redhat.com [10.10.114.68])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 02F075D9D2;
 Fri, 30 Oct 2020 20:21:44 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 08/20] qdev: Delete unused error_set_from_qdev_prop_error()
 function
Date: Fri, 30 Oct 2020 16:21:19 -0400
Message-Id: <20201030202131.796967-9-ehabkost@redhat.com>
In-Reply-To: <20201030202131.796967-1-ehabkost@redhat.com>
References: <20201030202131.796967-1-ehabkost@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ehabkost@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/30 16:21:37
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: "Daniel P. Berrangé" <berrange@redhat.com>
Cc: Eduardo Habkost <ehabkost@redhat.com>
Cc: qemu-devel@nongnu.org
---
 include/hw/qdev-properties.h |  2 --
 hw/core/qdev-properties.c    | 22 ----------------------
 2 files changed, 24 deletions(-)

diff --git a/include/hw/qdev-properties.h b/include/hw/qdev-properties.h
index a4ac1e6972..cca1a2153f 100644
--- a/include/hw/qdev-properties.h
+++ b/include/hw/qdev-properties.h
@@ -36,8 +36,6 @@ const GlobalProperty *qdev_find_global_prop(Object *obj,
                                             const char *name);
 int qdev_prop_check_globals(void);
 void qdev_prop_set_globals(DeviceState *dev);
-void error_set_from_qdev_prop_error(Error **errp, int ret, Object *obj,
-                                    Property *prop, const char *value);
 
 /**
  * qdev_property_add_static:
diff --git a/hw/core/qdev-properties.c b/hw/core/qdev-properties.c
index c03842e89a..5fdfb3f5cd 100644
--- a/hw/core/qdev-properties.c
+++ b/hw/core/qdev-properties.c
@@ -85,28 +85,6 @@ static Property *qdev_prop_find(DeviceState *dev, const char *name)
     return NULL;
 }
 
-void error_set_from_qdev_prop_error(Error **errp, int ret, Object *obj,
-                                    Property *prop, const char *value)
-{
-    switch (ret) {
-    case -EEXIST:
-        error_setg(errp, "Property '%s.%s' can't take value '%s', it's in use",
-                  object_get_typename(obj), prop->name, value);
-        break;
-    default:
-    case -EINVAL:
-        error_setg(errp, QERR_PROPERTY_VALUE_BAD,
-                   object_get_typename(obj), prop->name, value);
-        break;
-    case -ENOENT:
-        error_setg(errp, "Property '%s.%s' can't find value '%s'",
-                  object_get_typename(obj), prop->name, value);
-        break;
-    case 0:
-        break;
-    }
-}
-
 void qdev_prop_set_bit(DeviceState *dev, const char *name, bool value)
 {
     object_property_set_bool(OBJECT(dev), name, value, &error_abort);
-- 
2.28.0


