Return-Path: <SRS0=2GMi=CD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34DE3C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 19:51:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 06DD02074D
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 19:51:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NIfHzi5F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06DD02074D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42784 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAeyd-00034b-A5
	for qemu-devel@archiver.kernel.org; Tue, 25 Aug 2020 15:51:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40800)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kAeXV-0002yQ-Qm
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 15:23:25 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:28804
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kAeXR-0006Mr-P3
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 15:23:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598383401;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qAIO+FM8bmGDgJ6mrYK4G2T8EMAPtzgKmNDUavixQ98=;
 b=NIfHzi5FA7ZFTxJgzjFl3BF3MuFUPlgs6JzU8DSDkr74t/NLo23NOLgEFgZz8RGgGT4ySi
 hoqLYDTAee6mb9/QnOoQHdUiVQlZZH03h6rTSXHd8dikubJqXDEVu/wyizk07NR7CVA0Be
 HLabQGyWGO4Yn68sK5VjtVE7uVmW8Kg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-348-0-crcQ3XOWWx1dPXRNyP3A-1; Tue, 25 Aug 2020 15:23:19 -0400
X-MC-Unique: 0-crcQ3XOWWx1dPXRNyP3A-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 607501074641
 for <qemu-devel@nongnu.org>; Tue, 25 Aug 2020 19:23:18 +0000 (UTC)
Received: from localhost (unknown [10.10.67.254])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2865F808B7;
 Tue, 25 Aug 2020 19:23:18 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 59/74] qom: TYPE_INFO macro
Date: Tue, 25 Aug 2020 15:20:55 -0400
Message-Id: <20200825192110.3528606-60-ehabkost@redhat.com>
In-Reply-To: <20200825192110.3528606-1-ehabkost@redhat.com>
References: <20200825192110.3528606-1-ehabkost@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ehabkost@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/25 10:39:45
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.958,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
 "Daniel P. Berrange" <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Provide a TYPE_INFO macro that can be used to register a TypeInfo
struct declaratively.  This will allow QOM type registration to
be 100% declarative.

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
Changes v2 -> v3: none

Changes v1 -> v2: none
---
 include/qom/object.h | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/include/qom/object.h b/include/qom/object.h
index 3626ae3c65..3c8fe1b603 100644
--- a/include/qom/object.h
+++ b/include/qom/object.h
@@ -653,6 +653,14 @@ struct Object
     struct InstanceType##Class { ParentClassType parent_class; };
 
 
+#define TYPE_INFO(type_info_var) \
+    static void \
+    register_type_info_##type_info_var(void) \
+    { \
+        type_register_static(&type_info_var); \
+    } \
+    type_init(register_type_info_##type_info_var);
+
 /**
  * OBJECT_DEFINE_TYPE_EXTENDED:
  * @ModuleObjName: the object name with initial caps
@@ -698,12 +706,7 @@ struct Object
         .interfaces = (InterfaceInfo[]) { __VA_ARGS__ } , \
     }; \
     \
-    static void \
-    module_obj_name##_register_types(void) \
-    { \
-        type_register_static(&module_obj_name##_info); \
-    } \
-    type_init(module_obj_name##_register_types);
+    TYPE_INFO(module_obj_name##_info)
 
 /**
  * OBJECT_DEFINE_TYPE:
-- 
2.26.2


