Return-Path: <SRS0=Dndf=B6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D466DC433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2020 00:40:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B0C720578
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2020 00:40:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QzPjsj7m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B0C720578
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45804 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k8YdF-0004p8-Sd
	for qemu-devel@archiver.kernel.org; Wed, 19 Aug 2020 20:40:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49888)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1k8YDv-0008Jj-Jl
 for qemu-devel@nongnu.org; Wed, 19 Aug 2020 20:14:31 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:43447
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1k8YDt-0002Vb-TB
 for qemu-devel@nongnu.org; Wed, 19 Aug 2020 20:14:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597882469;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qX29hC/Revp186AL5RYuW7GsP3iJP1Oc/vaLfb0DA7U=;
 b=QzPjsj7mizNDODN7sqktz05UtUsjETLhGpCvDZHxw7bBNv+IAr7BQqXqUZcfDdRz7Jjjy/
 +rXytTD5uWiCgL3NzRzlj+UVsMdqsU8BV4dUvlpPnBJsEkmA2+m4wQRLyytTOplAlhe3NX
 U2q9KP0YmxY1LFuMbeVO18lC6Y+YlCY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-339-2z8oyffwM-ifLaSjP4Aiuw-1; Wed, 19 Aug 2020 20:14:27 -0400
X-MC-Unique: 2z8oyffwM-ifLaSjP4Aiuw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2C780186A577;
 Thu, 20 Aug 2020 00:14:26 +0000 (UTC)
Received: from localhost (ovpn-117-244.rdu2.redhat.com [10.10.117.244])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D0AFA60BEC;
 Thu, 20 Aug 2020 00:14:25 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 47/58] qom: Make type checker functions accept const
 pointers
Date: Wed, 19 Aug 2020 20:12:25 -0400
Message-Id: <20200820001236.1284548-48-ehabkost@redhat.com>
In-Reply-To: <20200820001236.1284548-1-ehabkost@redhat.com>
References: <20200820001236.1284548-1-ehabkost@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ehabkost@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/19 20:12:44
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
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
 "Daniel P. Berrange" <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The existing type check macros all unconditionally drop const
qualifiers from their arguments.  Keep this behavior in the
macros generated by DECLARE_*CHECKER* by now.

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
Changes v1 -> v2:
* Removed note about _Generic from commit message, because it
  won't be possible to do what I was planning without manual
  #defines
---
 include/qom/object.h | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/include/qom/object.h b/include/qom/object.h
index 4cd84998c2..1d6a520d35 100644
--- a/include/qom/object.h
+++ b/include/qom/object.h
@@ -567,7 +567,7 @@ struct Object
  */
 #define DECLARE_INSTANCE_CHECKER(InstanceType, OBJ_NAME, TYPENAME) \
     static inline G_GNUC_UNUSED InstanceType * \
-    OBJ_NAME(void *obj) \
+    OBJ_NAME(const void *obj) \
     { return OBJECT_CHECK(InstanceType, obj, TYPENAME); }
 
 /**
@@ -581,14 +581,16 @@ struct Object
  *
  * This macro will provide the three standard type cast functions for a
  * QOM type.
+ *
+ *FIXME: Use _Generic to make this const-safe
  */
 #define DECLARE_CLASS_CHECKERS(ClassType, OBJ_NAME, TYPENAME) \
     static inline G_GNUC_UNUSED ClassType * \
-    OBJ_NAME##_GET_CLASS(void *obj) \
+    OBJ_NAME##_GET_CLASS(const void *obj) \
     { return OBJECT_GET_CLASS(ClassType, obj, TYPENAME); } \
     \
     static inline G_GNUC_UNUSED ClassType * \
-    OBJ_NAME##_CLASS(void *klass) \
+    OBJ_NAME##_CLASS(const void *klass) \
     { return OBJECT_CLASS_CHECK(ClassType, klass, TYPENAME); }
 
 /**
-- 
2.26.2


