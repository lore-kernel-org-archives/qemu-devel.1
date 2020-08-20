Return-Path: <SRS0=Dndf=B6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67B9AC433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2020 00:29:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 35D48207DA
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2020 00:29:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d9d2Bc7m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35D48207DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55788 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k8YSK-0002NK-F3
	for qemu-devel@archiver.kernel.org; Wed, 19 Aug 2020 20:29:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49840)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1k8YDs-00089K-1E
 for qemu-devel@nongnu.org; Wed, 19 Aug 2020 20:14:28 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:35206
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1k8YDp-0002Ur-1L
 for qemu-devel@nongnu.org; Wed, 19 Aug 2020 20:14:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597882464;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=awg9JZ57ssouxAqwCxUf5tiQK0t/pyZG0TdMDrF6LBc=;
 b=d9d2Bc7mWzG01EuBMEv3FqdXonT7QxAekyvhVf/QkPU+12bodYgTEU+sZ7aIIJgnSMxqpc
 MpTeyoQYJup9sqovNFWOwgGy5BsP7s7uxnrlVEN3Hvy1awmmqSPwV0UnbbuEcQkd/9PKZo
 p1tXLfM7P7GnlaFBy2eNm1GLTwXmVms=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-495-bGRya__gNAKswbpbOI-M9A-1; Wed, 19 Aug 2020 20:14:22 -0400
X-MC-Unique: bGRya__gNAKswbpbOI-M9A-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 91B821084C8C
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2020 00:14:21 +0000 (UTC)
Received: from localhost (ovpn-117-244.rdu2.redhat.com [10.10.117.244])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5A257747B0;
 Thu, 20 Aug 2020 00:14:21 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 43/58] qom: make object_ref/unref use a void * instead of
 Object *.
Date: Wed, 19 Aug 2020 20:12:21 -0400
Message-Id: <20200820001236.1284548-44-ehabkost@redhat.com>
In-Reply-To: <20200820001236.1284548-1-ehabkost@redhat.com>
References: <20200820001236.1284548-1-ehabkost@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
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
 "Daniel P. Berrange" <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Daniel P. Berrangé <berrange@redhat.com>

The object_ref/unref methods are intended for use with any subclass of
the base Object. Using "Object *" in the signature is not adding any
meaningful level of type safety, since callers simply use "OBJECT(ptr)"
and this expands to an unchecked cast "(Object *)".

By using "void *" we enable the object_unref() method to be used to
provide support for g_autoptr() with any subclass.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
Message-Id: <20200723181410.3145233-2-berrange@redhat.com>
---
Changes v1 -> v2: none
---
 include/qom/object.h | 4 ++--
 qom/object.c         | 6 ++++--
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/include/qom/object.h b/include/qom/object.h
index 0f3a60617c..1f8aa2d48e 100644
--- a/include/qom/object.h
+++ b/include/qom/object.h
@@ -1035,7 +1035,7 @@ GSList *object_class_get_list_sorted(const char *implements_type,
  * as its reference count is greater than zero.
  * Returns: @obj
  */
-Object *object_ref(Object *obj);
+Object *object_ref(void *obj);
 
 /**
  * object_unref:
@@ -1044,7 +1044,7 @@ Object *object_ref(Object *obj);
  * Decrease the reference count of a object.  A object cannot be freed as long
  * as its reference count is greater than zero.
  */
-void object_unref(Object *obj);
+void object_unref(void *obj);
 
 /**
  * object_property_try_add:
diff --git a/qom/object.c b/qom/object.c
index 00fdf89b3b..b1822a2ef4 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -1124,8 +1124,9 @@ GSList *object_class_get_list_sorted(const char *implements_type,
                         object_class_cmp);
 }
 
-Object *object_ref(Object *obj)
+Object *object_ref(void *objptr)
 {
+    Object *obj = OBJECT(objptr);
     if (!obj) {
         return NULL;
     }
@@ -1133,8 +1134,9 @@ Object *object_ref(Object *obj)
     return obj;
 }
 
-void object_unref(Object *obj)
+void object_unref(void *objptr)
 {
+    Object *obj = OBJECT(objptr);
     if (!obj) {
         return;
     }
-- 
2.26.2


