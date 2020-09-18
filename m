Return-Path: <SRS0=nn+c=C3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AABDEC43463
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 21:13:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 44CF720773
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 21:13:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZQW6Rf90"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44CF720773
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39910 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJNh7-0005ov-CX
	for qemu-devel@archiver.kernel.org; Fri, 18 Sep 2020 17:13:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48398)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kJNIE-0002dp-85
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 16:47:43 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:38062
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kJNI2-0006Hb-5e
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 16:47:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600462047;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hqTzKYgwmlGjAC297r5Hip0PrRg3SR35cK0Rp9DJFjw=;
 b=ZQW6Rf90bQyTSCQ8EmCTlzdLfxq6CCiipaa4NTyufHjGpOiivtzzyHmmbba9YtEQ6UWVAz
 bCO5c8Z/39wGbbpvegv/IEtBiU8pR7vf06hYuBA6j6ScsQlUFPKcT+zK8hljSJpDIq/ZnV
 eJIIXz/Xa8tXdRGQCdVwlsP1rU49r1Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-547-GU5tHh1YOuSb3KN8ydRoiA-1; Fri, 18 Sep 2020 16:47:23 -0400
X-MC-Unique: GU5tHh1YOuSb3KN8ydRoiA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0888F81CB07;
 Fri, 18 Sep 2020 20:47:22 +0000 (UTC)
Received: from localhost (unknown [10.10.67.5])
 by smtp.corp.redhat.com (Postfix) with ESMTP id BE631610F3;
 Fri, 18 Sep 2020 20:47:21 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>,
	qemu-devel@nongnu.org
Subject: [PULL 06/17] qom: Clean up object_property_get_enum()'s error value
Date: Fri, 18 Sep 2020 16:47:03 -0400
Message-Id: <20200918204714.27276-7-ehabkost@redhat.com>
In-Reply-To: <20200918204714.27276-1-ehabkost@redhat.com>
References: <20200918204714.27276-1-ehabkost@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ehabkost@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/18 03:47:33
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.999,
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
 Markus Armbruster <armbru@redhat.com>, Greg Kurz <groug@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Markus Armbruster <armbru@redhat.com>

object_property_get_enum() is the only object_property_FOO() that is
documented to return an undefined value on error.  It does no such
thing, actually: it returns 0 on some errors, and -1 on others.

Needlessly complicated.  Always return -1 on error, and adjust the
contract.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Greg Kurz <groug@kaod.org>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Message-Id: <20200917125540.597786-2-armbru@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 include/qom/object.h       | 6 +++---
 qom/object.c               | 6 +++---
 tests/check-qom-proplist.c | 2 ++
 3 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/include/qom/object.h b/include/qom/object.h
index 6c0d424b51..494827b4d1 100644
--- a/include/qom/object.h
+++ b/include/qom/object.h
@@ -1687,9 +1687,9 @@ uint64_t object_property_get_uint(Object *obj, const char *name,
  * @typename: the name of the enum data type
  * @errp: returns an error if this function fails
  *
- * Returns: the value of the property, converted to an integer, or
- * undefined if an error occurs (including when the property value is not
- * an enum).
+ * Returns: the value of the property, converted to an integer (which
+ * can't be negative), or -1 on error (including when the property
+ * value is not an enum).
  */
 int object_property_get_enum(Object *obj, const char *name,
                              const char *typename, Error **errp);
diff --git a/qom/object.c b/qom/object.c
index 387efb25eb..cecad35b99 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -1564,21 +1564,21 @@ int object_property_get_enum(Object *obj, const char *name,
     EnumProperty *enumprop;
 
     if (prop == NULL) {
-        return 0;
+        return -1;
     }
 
     if (!g_str_equal(prop->type, typename)) {
         error_setg(errp, "Property %s on %s is not '%s' enum type",
                    name, object_class_get_name(
                        object_get_class(obj)), typename);
-        return 0;
+        return -1;
     }
 
     enumprop = prop->opaque;
 
     str = object_property_get_str(obj, name, errp);
     if (!str) {
-        return 0;
+        return -1;
     }
 
     ret = qapi_enum_parse(enumprop->lookup, str, -1, errp);
diff --git a/tests/check-qom-proplist.c b/tests/check-qom-proplist.c
index 1571606c1c..1b76581980 100644
--- a/tests/check-qom-proplist.c
+++ b/tests/check-qom-proplist.c
@@ -491,6 +491,7 @@ static void test_dummy_getenum(void)
                                    "av",
                                    "BadAnimal",
                                    &err);
+    g_assert(val == -1);
     error_free_or_abort(&err);
 
     /* A non-enum property name */
@@ -498,6 +499,7 @@ static void test_dummy_getenum(void)
                                    "iv",
                                    "DummyAnimal",
                                    &err);
+    g_assert(val == -1);
     error_free_or_abort(&err);
 
     object_unparent(OBJECT(dobj));
-- 
2.26.2


