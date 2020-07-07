Return-Path: <SRS0=/TnL=AT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01F2BC433DF
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2020 21:41:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BC18E206A1
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2020 21:41:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UchfUsQr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC18E206A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43766 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtHoe-0002ZK-1b
	for qemu-devel@archiver.kernel.org; Wed, 08 Jul 2020 17:41:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34164)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jtHbs-000060-Nk
 for qemu-devel@nongnu.org; Wed, 08 Jul 2020 17:28:08 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:42112
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jtHbo-00026d-Tm
 for qemu-devel@nongnu.org; Wed, 08 Jul 2020 17:28:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594243684;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gyAj+m9FGQ4ZyEa17z5k7IGW8C2lrjYDtXyfC2hA8f8=;
 b=UchfUsQr/eKP1aj6lc9D9RmgAyaRvz27QWyfv+ciN5H/1ePoOO4DhXb57khPAnQPq2MqeY
 pyf4re2I0V9+puW2mADu8gcFMnJgfWwuWgR3r0QuVSRQTiYSjdnKiO1sRz84lTAPpYWTIM
 FSIMRehvckAeF2sPZHLL8Qdz9FMXQWU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-59-nKnJSR0-PAG9k6oRC5kaew-1; Tue, 07 Jul 2020 17:25:17 -0400
X-MC-Unique: nKnJSR0-PAG9k6oRC5kaew-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6E47A80183C;
 Tue,  7 Jul 2020 21:25:16 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-143.ams2.redhat.com
 [10.36.112.143])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3FC9473FC0;
 Tue,  7 Jul 2020 21:25:16 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 6372D114425B; Tue,  7 Jul 2020 23:25:04 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 25/53] qom: Use return values to check for error where that's
 simpler
Date: Tue,  7 Jul 2020 23:24:35 +0200
Message-Id: <20200707212503.1495927-26-armbru@redhat.com>
In-Reply-To: <20200707212503.1495927-1-armbru@redhat.com>
References: <20200707212503.1495927-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/07 17:25:10
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
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

When using the Error object to check for error, we need to receive it
into a local variable, then propagate() it to @errp.

Using the return value permits allows receiving it straight to @errp.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-Id: <20200707160613.848843-26-armbru@redhat.com>
---
 qom/object.c | 25 ++++++++++++++-----------
 1 file changed, 14 insertions(+), 11 deletions(-)

diff --git a/qom/object.c b/qom/object.c
index 0808da2767..3a7c062f8e 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -549,8 +549,7 @@ void object_initialize_child_with_propsv(Object *parentobj,
     object_initialize(childobj, size, type);
     obj = OBJECT(childobj);
 
-    object_set_propv(obj, &local_err, vargs);
-    if (local_err) {
+    if (object_set_propv(obj, errp, vargs) < 0) {
         goto out;
     }
 
@@ -743,7 +742,7 @@ Object *object_new_with_propv(const char *typename,
     }
     obj = object_new_with_type(klass->type);
 
-    if (object_set_propv(obj, &local_err, vargs) < 0) {
+    if (object_set_propv(obj, errp, vargs) < 0) {
         goto error;
     }
 
@@ -1763,20 +1762,24 @@ static void object_set_link_property(Object *obj, Visitor *v,
     LinkProperty *prop = opaque;
     Object **targetp = object_link_get_targetp(obj, prop);
     Object *old_target = *targetp;
-    Object *new_target = NULL;
+    Object *new_target;
     char *path = NULL;
 
-    visit_type_str(v, name, &path, &local_err);
+    if (!visit_type_str(v, name, &path, errp)) {
+        return;
+    }
 
-    if (!local_err && strcmp(path, "") != 0) {
-        new_target = object_resolve_link(obj, name, path, &local_err);
+    if (*path) {
+        new_target = object_resolve_link(obj, name, path, errp);
+        if (!new_target) {
+            g_free(path);
+            return;
+        }
+    } else {
+        new_target = NULL;
     }
 
     g_free(path);
-    if (local_err) {
-        error_propagate(errp, local_err);
-        return;
-    }
 
     prop->check(obj, name, new_target, &local_err);
     if (local_err) {
-- 
2.26.2


