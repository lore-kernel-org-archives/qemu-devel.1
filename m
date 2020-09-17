Return-Path: <SRS0=BocF=C2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76FE5C433E2
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 02:50:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E06B52075E
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 02:50:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SM95GklK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E06B52075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57732 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIk0c-00051d-2W
	for qemu-devel@archiver.kernel.org; Wed, 16 Sep 2020 22:50:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42906)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kIjzg-0003yO-PA
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 22:49:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:46810)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kIjzf-0007Vk-47
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 22:49:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600310994;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6t4NlHhdwKw5BoVu7DFbPOCXPgJgsEb6LzNcdyFk6oA=;
 b=SM95GklKBkZAxthuQzbjayHPmCB7aDAkf2+F776RWTi1dSPixiMX1gFCkLquWZSTu5ER+D
 oHYK8p+Kca9Wg86vVNzPdJdcXmzwSjvhlbm61GXQ5SedNWJwHgru4saQnWkmmMNLb8CcKW
 gJn+6xNQI2dR7KRXvAmLZ2LqMF1ZMKc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-594-WaY2an4wNxqU4fSalvQT8Q-1; Wed, 16 Sep 2020 22:49:50 -0400
X-MC-Unique: WaY2an4wNxqU4fSalvQT8Q-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B7A5F100746D;
 Thu, 17 Sep 2020 02:49:49 +0000 (UTC)
Received: from localhost (ovpn-119-217.rdu2.redhat.com [10.10.119.217])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5E4D719D61;
 Thu, 17 Sep 2020 02:49:49 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 1/2] qom: DECLARE_INTERFACE_CHECKER macro
Date: Wed, 16 Sep 2020 22:49:46 -0400
Message-Id: <20200917024947.707586-2-ehabkost@redhat.com>
In-Reply-To: <20200917024947.707586-1-ehabkost@redhat.com>
References: <20200917024947.707586-1-ehabkost@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ehabkost@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/16 20:51:18
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.999,
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
Cc: "Daniel P. Berrange" <berrange@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The new macro will be similar to DECLARE_INSTANCE_CHECKER,
but for interface types (that use INTEFACE_CHECK instead of
OBJECT_CHECK).

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
Changes series v1 -> v2: none
---
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: "Daniel P. Berrangé" <berrange@redhat.com>
Cc: Eduardo Habkost <ehabkost@redhat.com>
Cc: qemu-devel@nongnu.org
---
 include/qom/object.h | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/include/qom/object.h b/include/qom/object.h
index 056f67ab3b..faf96aed3c 100644
--- a/include/qom/object.h
+++ b/include/qom/object.h
@@ -571,6 +571,20 @@ struct Object
     OBJ_NAME(const void *obj) \
     { return OBJECT_CHECK(InstanceType, obj, TYPENAME); }
 
+/**
+ * DECLARE_INTERFACE_CHECKER:
+ * @InstanceType: instance type
+ * @OBJ_NAME: the object name in uppercase with underscore separators
+ * @TYPENAME: type name
+ *
+ * This macro will provide the instance type cast functions for a
+ * QOM interface type.
+ */
+#define DECLARE_INTERFACE_CHECKER(InstanceType, OBJ_NAME, TYPENAME) \
+    static inline G_GNUC_UNUSED InstanceType * \
+    OBJ_NAME(const void *obj) \
+    { return INTERFACE_CHECK(InstanceType, obj, TYPENAME); }
+
 /**
  * DECLARE_CLASS_CHECKERS:
  * @ClassType: class struct name
-- 
2.26.2


