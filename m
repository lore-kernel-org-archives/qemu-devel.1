Return-Path: <SRS0=T5iq=DQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81748C433E7
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 16:15:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 062562227E
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 16:15:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N9gjiUA1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 062562227E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55008 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQv3B-0002Ym-4D
	for qemu-devel@archiver.kernel.org; Fri, 09 Oct 2020 12:15:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59054)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kQuq4-0003m7-22
 for qemu-devel@nongnu.org; Fri, 09 Oct 2020 12:01:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:48920)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kQuq1-000190-5m
 for qemu-devel@nongnu.org; Fri, 09 Oct 2020 12:01:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602259304;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=slIUVKk0+8beFrLh45o20cBpi9FInCOQBDpM1t0b5mc=;
 b=N9gjiUA1My0j0nQgRVaWJghslq5syCuk7MSaATK9z+nGXID45nS+bxkEt1MgpcglRAt2UV
 e/95/B5hLFFGi4lNXnufMCj4w7dd+jj2V0kLWeE6feL434n3iiFX47LYk2hYa7fa60la5/
 Wv9IxRUc8olScgU+1R9WLto5Y1qckEA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-488-xqKz9e7tMqK1I_X1i2Qvug-1; Fri, 09 Oct 2020 12:01:42 -0400
X-MC-Unique: xqKz9e7tMqK1I_X1i2Qvug-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7F8B31019631;
 Fri,  9 Oct 2020 16:01:41 +0000 (UTC)
Received: from localhost (ovpn-119-102.rdu2.redhat.com [10.10.119.102])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6AA997664F;
 Fri,  9 Oct 2020 16:01:38 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 05/12] rng: Use class properties
Date: Fri,  9 Oct 2020 12:01:15 -0400
Message-Id: <20201009160122.1662082-6-ehabkost@redhat.com>
In-Reply-To: <20201009160122.1662082-1-ehabkost@redhat.com>
References: <20201009160122.1662082-1-ehabkost@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ehabkost@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=63.128.21.124; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/09 02:34:40
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
Cc: Kevin Wolf <kwolf@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Amit Shah <amit@kernel.org>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Instance properties make introspection hard and are not shown by
"-object ...,help".  Convert them to class properties.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
Cc: Laurent Vivier <lvivier@redhat.com>
Cc: Amit Shah <amit@kernel.org>
Cc: qemu-devel@nongnu.org
---
 backends/rng-egd.c    | 10 +++-------
 backends/rng-random.c |  8 ++++----
 backends/rng.c        |  6 +++---
 3 files changed, 10 insertions(+), 14 deletions(-)

diff --git a/backends/rng-egd.c b/backends/rng-egd.c
index 20198ff26e..600eef3f75 100644
--- a/backends/rng-egd.c
+++ b/backends/rng-egd.c
@@ -135,12 +135,6 @@ static char *rng_egd_get_chardev(Object *obj, Error **errp)
     return NULL;
 }
 
-static void rng_egd_init(Object *obj)
-{
-    object_property_add_str(obj, "chardev",
-                            rng_egd_get_chardev, rng_egd_set_chardev);
-}
-
 static void rng_egd_finalize(Object *obj)
 {
     RngEgd *s = RNG_EGD(obj);
@@ -153,6 +147,9 @@ static void rng_egd_class_init(ObjectClass *klass, void *data)
 {
     RngBackendClass *rbc = RNG_BACKEND_CLASS(klass);
 
+    object_class_property_add_str(klass, "chardev",
+                                  rng_egd_get_chardev, rng_egd_set_chardev);
+
     rbc->request_entropy = rng_egd_request_entropy;
     rbc->opened = rng_egd_opened;
 }
@@ -162,7 +159,6 @@ static const TypeInfo rng_egd_info = {
     .parent = TYPE_RNG_BACKEND,
     .instance_size = sizeof(RngEgd),
     .class_init = rng_egd_class_init,
-    .instance_init = rng_egd_init,
     .instance_finalize = rng_egd_finalize,
 };
 
diff --git a/backends/rng-random.c b/backends/rng-random.c
index 245b12ab24..27152b8cdb 100644
--- a/backends/rng-random.c
+++ b/backends/rng-random.c
@@ -108,10 +108,6 @@ static void rng_random_init(Object *obj)
 {
     RngRandom *s = RNG_RANDOM(obj);
 
-    object_property_add_str(obj, "filename",
-                            rng_random_get_filename,
-                            rng_random_set_filename);
-
     s->filename = g_strdup("/dev/urandom");
     s->fd = -1;
 }
@@ -132,6 +128,10 @@ static void rng_random_class_init(ObjectClass *klass, void *data)
 {
     RngBackendClass *rbc = RNG_BACKEND_CLASS(klass);
 
+    object_class_property_add_str(klass, "filename",
+                                  rng_random_get_filename,
+                                  rng_random_set_filename);
+
     rbc->request_entropy = rng_random_request_entropy;
     rbc->opened = rng_random_opened;
 }
diff --git a/backends/rng.c b/backends/rng.c
index 484f04e891..f018c380da 100644
--- a/backends/rng.c
+++ b/backends/rng.c
@@ -106,9 +106,6 @@ static void rng_backend_init(Object *obj)
 
     QSIMPLEQ_INIT(&s->requests);
 
-    object_property_add_bool(obj, "opened",
-                             rng_backend_prop_get_opened,
-                             rng_backend_prop_set_opened);
 }
 
 static void rng_backend_finalize(Object *obj)
@@ -122,6 +119,9 @@ static void rng_backend_class_init(ObjectClass *oc, void *data)
 {
     UserCreatableClass *ucc = USER_CREATABLE_CLASS(oc);
 
+    object_class_property_add_bool(oc, "opened",
+                                   rng_backend_prop_get_opened,
+                                   rng_backend_prop_set_opened);
     ucc->complete = rng_backend_complete;
 }
 
-- 
2.26.2


