Return-Path: <SRS0=B5/Q=AS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2835FC433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 13:43:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB5DA20658
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 13:43:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VwirA2I5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB5DA20658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46422 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jsnsn-0008Lj-5J
	for qemu-devel@archiver.kernel.org; Tue, 07 Jul 2020 09:43:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50610)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jsnru-0006dQ-Oe
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 09:42:42 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:42915
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jsnrs-0004Yq-NB
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 09:42:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594129358;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:in-reply-to:in-reply-to:
 references:references; bh=tZpyUC8O0kFmGIJyFMAqx1/t3IDSz35Y6yMJtiML0fQ=;
 b=VwirA2I5NFWJ6BxzyEa+E3g6LImZq/P8RxF2tN52OfWqKXqivYjzUYHj5pvi1DhJHJ/Mm1
 hQhv9hWcQm1oHDtxzD4W3G6ubYa9p79k9sWwvdbbkM4xyuCFpK99n4RSfWEfkvrfSn7Nqy
 n+ETMsz7YYlp5bn1nbVQ9zeMwt2pA/c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-108-pz2XMtwZNGOPFlcikCCYgg-1; Tue, 07 Jul 2020 09:42:37 -0400
X-MC-Unique: pz2XMtwZNGOPFlcikCCYgg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6F6CD18829CC
 for <qemu-devel@nongnu.org>; Tue,  7 Jul 2020 13:42:36 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-112-200.ams2.redhat.com
 [10.36.112.200])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7F0A75D9F3;
 Tue,  7 Jul 2020 13:42:30 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id BCD3531F14; Tue,  7 Jul 2020 15:42:29 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 02/10] object: qom module support
Date: Tue,  7 Jul 2020 15:42:21 +0200
Message-Id: <20200707134229.9773-3-kraxel@redhat.com>
In-Reply-To: <20200707134229.9773-1-kraxel@redhat.com>
References: <20200707134229.9773-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kraxel@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Received-SPF: pass client-ip=205.139.110.61; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/07 00:31:00
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
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Little helper function to load modules on demand.  In most cases adding
module loading support for devices and other objects is just
s/object_class_by_name/module_object_class_by_name/ in the right spot.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Message-id: 20200624131045.14512-3-kraxel@redhat.com
---
 include/qom/object.h | 12 ++++++++++++
 qom/object.c         | 14 ++++++++++++++
 2 files changed, 26 insertions(+)

diff --git a/include/qom/object.h b/include/qom/object.h
index 94a61ccc3fe8..51f188137f1f 100644
--- a/include/qom/object.h
+++ b/include/qom/object.h
@@ -994,6 +994,18 @@ bool object_class_is_abstract(ObjectClass *klass);
  */
 ObjectClass *object_class_by_name(const char *typename);
 
+/**
+ * module_object_class_by_name:
+ * @typename: The QOM typename to obtain the class for.
+ *
+ * For objects which might be provided by a module.  Behaves like
+ * object_class_by_name, but additionally tries to load the module
+ * needed in case the class is not available.
+ *
+ * Returns: The class for @typename or %NULL if not found.
+ */
+ObjectClass *module_object_class_by_name(const char *typename);
+
 void object_class_foreach(void (*fn)(ObjectClass *klass, void *opaque),
                           const char *implements_type, bool include_abstract,
                           void *opaque);
diff --git a/qom/object.c b/qom/object.c
index 6ece96bc2bfc..34daaf1280f5 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -985,6 +985,20 @@ ObjectClass *object_class_by_name(const char *typename)
     return type->class;
 }
 
+ObjectClass *module_object_class_by_name(const char *typename)
+{
+    ObjectClass *oc;
+
+    oc = object_class_by_name(typename);
+#ifdef CONFIG_MODULES
+    if (!oc) {
+        module_load_qom_one(typename);
+        oc = object_class_by_name(typename);
+    }
+#endif
+    return oc;
+}
+
 ObjectClass *object_class_get_parent(ObjectClass *class)
 {
     TypeImpl *type = type_get_parent(class->type);
-- 
2.18.4


