Return-Path: <SRS0=d88l=CM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FF08C2D0E0
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 20:54:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D8C0206EB
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 20:54:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gHSkOVYc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D8C0206EB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42500 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDwFM-00028s-8j
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 16:54:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56140)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kDwEF-0000Pl-KF
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 16:53:07 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:45991
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kDwEE-0006ZM-16
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 16:53:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599166384;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IKrAJ1lE8wDUKrGRDLZjEqdt41c0+h5LgFOaBdrpxUU=;
 b=gHSkOVYcBWLFnpzzAwG6yE2xX+fCFs4MMSg0xtqlGDJIJAW8BbCWZgXvpEiM5r/iEUfEzf
 qPK+GxmBqPYRC6ojYWIsYqLGIwDCH8Tc712hxoQXvtX7kitfmVyKAgzWm34jHhs2MpQKyd
 BUiPf7bWvWD4kjxk8YlOz4oLkRBwSAw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-404-neypLMVdMky5zEPHAjUD1Q-1; Thu, 03 Sep 2020 16:53:00 -0400
X-MC-Unique: neypLMVdMky5zEPHAjUD1Q-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C9B5F18BA285;
 Thu,  3 Sep 2020 20:52:59 +0000 (UTC)
Received: from localhost (ovpn-66-226.rdu2.redhat.com [10.10.66.226])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 92B155D9EF;
 Thu,  3 Sep 2020 20:52:59 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 05/27] qom: Make type checker functions accept const pointers
Date: Thu,  3 Sep 2020 16:52:25 -0400
Message-Id: <20200903205247.1667472-6-ehabkost@redhat.com>
In-Reply-To: <20200903205247.1667472-1-ehabkost@redhat.com>
References: <20200903205247.1667472-1-ehabkost@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ehabkost@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/03 01:58:20
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
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
Message-Id: <20200831210740.126168-6-ehabkost@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 include/qom/object.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/qom/object.h b/include/qom/object.h
index 4cd84998c2..3626ae3c65 100644
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
@@ -584,11 +584,11 @@ struct Object
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


