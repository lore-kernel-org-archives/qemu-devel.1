Return-Path: <SRS0=BocF=C2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 431B8C433E2
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 12:57:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D2E4A206CA
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 12:57:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I1L8rF64"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2E4A206CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39644 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kItTx-0005Ou-OR
	for qemu-devel@archiver.kernel.org; Thu, 17 Sep 2020 08:57:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44746)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kItSh-00046c-IX
 for qemu-devel@nongnu.org; Thu, 17 Sep 2020 08:56:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:54545)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kItSf-00088p-PX
 for qemu-devel@nongnu.org; Thu, 17 Sep 2020 08:56:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600347388;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=obmJ0KeESULi/hgxDtnBfOOj724RUrftZtPg5W4xKw4=;
 b=I1L8rF64h+t0UqBfU8gHz8GoFhK1VeKjr7AhCfnLBthyCZ6w/F5kpElAlzWfjIPuEv17al
 lqIpZExpEjwjnpRMkGe3p2rqHbXgbHT1qZPhWFP59OosEmcJScEcl3tDMEWobQLii7S0s3
 sKTckCUNtRGgxH3nG1iL5fZm9eY67tc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-263-UXnOU7PuMnCBa71688tj3Q-1; Thu, 17 Sep 2020 08:56:25 -0400
X-MC-Unique: UXnOU7PuMnCBa71688tj3Q-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5F0508DEA4F;
 Thu, 17 Sep 2020 12:55:43 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-114-66.ams2.redhat.com
 [10.36.114.66])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 06E567880F;
 Thu, 17 Sep 2020 12:55:43 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 7856611386A0; Thu, 17 Sep 2020 14:55:40 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/2] qom: Clean up object_property_get_enum()'s error value
Date: Thu, 17 Sep 2020 14:55:39 +0200
Message-Id: <20200917125540.597786-2-armbru@redhat.com>
In-Reply-To: <20200917125540.597786-1-armbru@redhat.com>
References: <20200917125540.597786-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/17 02:01:40
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.997,
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
Cc: pbonzini@redhat.com, berrange@redhat.com, ehabkost@redhat.com,
 groug@kaod.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

object_property_get_enum() is the only object_property_FOO() that is
documented to return an undefined value on error.  It does no such
thing, actually: it returns 0 on some errors, and -1 on others.

Needlessly complicated.  Always return -1 on error, and adjust the
contract.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 include/qom/object.h       | 6 +++---
 qom/object.c               | 6 +++---
 tests/check-qom-proplist.c | 2 ++
 3 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/include/qom/object.h b/include/qom/object.h
index 056f67ab3b..f75547a3fe 100644
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


