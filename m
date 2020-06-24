Return-Path: <SRS0=4Hnu=AF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80897C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 16:53:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D5E920738
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 16:53:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Zzwdh7XX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D5E920738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48118 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jo8eS-0002q9-Gy
	for qemu-devel@archiver.kernel.org; Wed, 24 Jun 2020 12:53:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51626)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jo8VM-0003Re-Am
 for qemu-devel@nongnu.org; Wed, 24 Jun 2020 12:44:08 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:41537
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jo8VA-00055s-RP
 for qemu-devel@nongnu.org; Wed, 24 Jun 2020 12:44:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593017034;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eGOq8fnUQZlei51A7RHg6OWdweGXDeqrTWKxfQptO+A=;
 b=Zzwdh7XXTlMkI1cxra8nVGREBbAHzWuZ0leApSfWr/Uv0C5+JFK2ciD9vai0CL88r6Iqcz
 BZb0FIKmuprjzkQ/KNIn0DgTBzYxzddCsJtcFlXKFGpwPhGC8n67jYryav60imE4JmDQEC
 +SkgJLFjj2Kq6NCncSGoJ/HkP5+7bQY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-145-Os9XWQabMEiyT_G-XxCINA-1; Wed, 24 Jun 2020 12:43:51 -0400
X-MC-Unique: Os9XWQabMEiyT_G-XxCINA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9DD662DA1;
 Wed, 24 Jun 2020 16:43:50 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-121.ams2.redhat.com
 [10.36.112.121])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 677BE79317;
 Wed, 24 Jun 2020 16:43:50 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 46C4B1138488; Wed, 24 Jun 2020 18:43:45 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 27/46] qapi: Purge error_propagate() from QAPI core
Date: Wed, 24 Jun 2020 18:43:25 +0200
Message-Id: <20200624164344.3778251-28-armbru@redhat.com>
In-Reply-To: <20200624164344.3778251-1-armbru@redhat.com>
References: <20200624164344.3778251-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=armbru@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/24 02:33:25
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: peter.maydell@linaro.org, vsementsov@virtuozzo.com, berrange@redhat.com,
 ehabkost@redhat.com, qemu-block@nongnu.org, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 qapi/qapi-visit-core.c | 40 +++++++++++++++++++---------------------
 1 file changed, 19 insertions(+), 21 deletions(-)

diff --git a/qapi/qapi-visit-core.c b/qapi/qapi-visit-core.c
index 5a9c47aabf..7e5f40e7f0 100644
--- a/qapi/qapi-visit-core.c
+++ b/qapi/qapi-visit-core.c
@@ -39,19 +39,18 @@ void visit_free(Visitor *v)
 bool visit_start_struct(Visitor *v, const char *name, void **obj,
                         size_t size, Error **errp)
 {
-    Error *err = NULL;
+    bool ok;
 
     trace_visit_start_struct(v, name, obj, size);
     if (obj) {
         assert(size);
         assert(!(v->type & VISITOR_OUTPUT) || *obj);
     }
-    v->start_struct(v, name, obj, size, &err);
+    ok = v->start_struct(v, name, obj, size, errp);
     if (obj && (v->type & VISITOR_INPUT)) {
-        assert(!err != !*obj);
+        assert(ok != !*obj);
     }
-    error_propagate(errp, err);
-    return !err;
+    return ok;
 }
 
 bool visit_check_struct(Visitor *v, Error **errp)
@@ -69,16 +68,15 @@ void visit_end_struct(Visitor *v, void **obj)
 bool visit_start_list(Visitor *v, const char *name, GenericList **list,
                       size_t size, Error **errp)
 {
-    Error *err = NULL;
+    bool ok;
 
     assert(!list || size >= sizeof(GenericList));
     trace_visit_start_list(v, name, list, size);
-    v->start_list(v, name, list, size, &err);
+    ok = v->start_list(v, name, list, size, errp);
     if (list && (v->type & VISITOR_INPUT)) {
-        assert(!(err && *list));
+        assert(ok || !*list);
     }
-    error_propagate(errp, err);
-    return !err;
+    return ok;
 }
 
 GenericList *visit_next_list(Visitor *v, GenericList *tail, size_t size)
@@ -104,19 +102,20 @@ bool visit_start_alternate(Visitor *v, const char *name,
                            GenericAlternate **obj, size_t size,
                            Error **errp)
 {
-    Error *err = NULL;
+    bool ok;
 
     assert(obj && size >= sizeof(GenericAlternate));
     assert(!(v->type & VISITOR_OUTPUT) || *obj);
     trace_visit_start_alternate(v, name, obj, size);
-    if (v->start_alternate) {
-        v->start_alternate(v, name, obj, size, &err);
+    if (!v->start_alternate) {
+        assert(!(v->type & VISITOR_INPUT));
+        return true;
     }
+    ok = v->start_alternate(v, name, obj, size, errp);
     if (v->type & VISITOR_INPUT) {
-        assert(v->start_alternate && !err != !*obj);
+        assert(ok != !*obj);
     }
-    error_propagate(errp, err);
-    return !err;
+    return ok;
 }
 
 void visit_end_alternate(Visitor *v, void **obj)
@@ -309,7 +308,7 @@ bool visit_type_bool(Visitor *v, const char *name, bool *obj, Error **errp)
 
 bool visit_type_str(Visitor *v, const char *name, char **obj, Error **errp)
 {
-    Error *err = NULL;
+    bool ok;
 
     assert(obj);
     /* TODO: Fix callers to not pass NULL when they mean "", so that we
@@ -317,12 +316,11 @@ bool visit_type_str(Visitor *v, const char *name, char **obj, Error **errp)
     assert(!(v->type & VISITOR_OUTPUT) || *obj);
      */
     trace_visit_type_str(v, name, obj);
-    v->type_str(v, name, obj, &err);
+    ok = v->type_str(v, name, obj, errp);
     if (v->type & VISITOR_INPUT) {
-        assert(!err != !*obj);
+        assert(ok != !*obj);
     }
-    error_propagate(errp, err);
-    return !err;
+    return ok;
 }
 
 bool visit_type_number(Visitor *v, const char *name, double *obj,
-- 
2.26.2


