Return-Path: <SRS0=egLd=BX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08892C433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2020 22:46:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C34D420771
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2020 22:46:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="azcTuwVq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C34D420771
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37054 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k6LzM-00039v-Vk
	for qemu-devel@archiver.kernel.org; Thu, 13 Aug 2020 18:46:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36484)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1k6Lgk-0005pM-TI
 for qemu-devel@nongnu.org; Thu, 13 Aug 2020 18:27:10 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:20560
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1k6Lgj-0002vd-4k
 for qemu-devel@nongnu.org; Thu, 13 Aug 2020 18:27:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597357628;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QLkhYwIjKOcsX+gqfx6NBOr7j4QovayhCeZ+HkY7vB8=;
 b=azcTuwVqTu+hPJgKAfKxXWkocoTpbihLvzlgR/IBO4t7hbOapAaP9g9BtWqEdo/6IqO0TE
 1HJSEw+H2AdWdOCTpMijC4shHVK+NMLCQGTtDWVa6kvG3QkCvoiFycdQl552IweQ/Dek0F
 hgIbYMrV12B2MYzKzSzuSvABaWS6rhQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-179-9uHj67N1Nk69AlwQAAvHFA-1; Thu, 13 Aug 2020 18:27:06 -0400
X-MC-Unique: 9uHj67N1Nk69AlwQAAvHFA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C280C807324
 for <qemu-devel@nongnu.org>; Thu, 13 Aug 2020 22:27:05 +0000 (UTC)
Received: from localhost (ovpn-117-153.rdu2.redhat.com [10.10.117.153])
 by smtp.corp.redhat.com (Postfix) with ESMTP id BC878100EBC1;
 Thu, 13 Aug 2020 22:27:04 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 31/41] qom: TYPE_INFO macro
Date: Thu, 13 Aug 2020 18:26:15 -0400
Message-Id: <20200813222625.243136-32-ehabkost@redhat.com>
In-Reply-To: <20200813222625.243136-1-ehabkost@redhat.com>
References: <20200813222625.243136-1-ehabkost@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ehabkost@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/13 18:26:36
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
 "Daniel P. Berrange" <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Provide a TYPE_INFO macro that can be used to register a TypeInfo
struct declaratively.  This will allow QOM type registration to
be 100% declarative.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 include/qom/object.h | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/include/qom/object.h b/include/qom/object.h
index 1d6a520d35..81bea3b4ed 100644
--- a/include/qom/object.h
+++ b/include/qom/object.h
@@ -655,6 +655,14 @@ struct Object
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
@@ -700,12 +708,7 @@ struct Object
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


