Return-Path: <SRS0=U615=7Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0CFAC433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 20:38:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7C3C82073E
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 20:38:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ErHJ0H+f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C3C82073E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58266 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jjTy3-0002gc-OL
	for qemu-devel@archiver.kernel.org; Thu, 11 Jun 2020 16:38:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55632)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jjTA1-0001A6-1g
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 15:46:49 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:52709
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jjT9z-0001K1-5N
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 15:46:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591904806;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EOhD+kEwR0sebMN8wXXLh51QpMb6b/YnSudGWFN1vA8=;
 b=ErHJ0H+fflcvOFW2CTFxvCSixCwsfUiXt4X6krlUXeVqqO3SO5g3latsXWyrvljcyNkweZ
 I7ZiDPbkZ3pSj54GGety1kg9D7Mkt/HBAGAaAYCDXuiqevhYCvndXZtm9zIbl54TS/vX7T
 emITpIfoA6xlcLDJi2IA2gfEFoPYs2w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-259-ql388yY0NtitnaJADjIubQ-1; Thu, 11 Jun 2020 15:45:27 -0400
X-MC-Unique: ql388yY0NtitnaJADjIubQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D8526100A8EC;
 Thu, 11 Jun 2020 19:45:26 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 936E35C1B2;
 Thu, 11 Jun 2020 19:45:26 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 040/115] qom: remove index from object_resolve_abs_path()
Date: Thu, 11 Jun 2020 15:43:34 -0400
Message-Id: <20200611194449.31468-41-pbonzini@redhat.com>
In-Reply-To: <20200611194449.31468-1-pbonzini@redhat.com>
References: <20200611194449.31468-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/11 08:37:10
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
Cc: Masahiro Yamada <masahiroy@kernel.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Masahiro Yamada <masahiroy@kernel.org>

You can advance 'parts' to track the current path fragment.
The 'index' parameter is unneeded.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
Message-Id: <20200510013235.954906-1-masahiroy@kernel.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 qom/object.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/qom/object.c b/qom/object.c
index 484465f1c8..ea16680051 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -1956,26 +1956,25 @@ Object *object_resolve_path_component(Object *parent, const char *part)
 }
 
 static Object *object_resolve_abs_path(Object *parent,
-                                       char **parts,
-                                       const char *typename,
-                                       int index)
+                                          char **parts,
+                                          const char *typename)
 {
     Object *child;
 
-    if (parts[index] == NULL) {
+    if (*parts == NULL) {
         return object_dynamic_cast(parent, typename);
     }
 
-    if (strcmp(parts[index], "") == 0) {
-        return object_resolve_abs_path(parent, parts, typename, index + 1);
+    if (strcmp(*parts, "") == 0) {
+        return object_resolve_abs_path(parent, parts + 1, typename);
     }
 
-    child = object_resolve_path_component(parent, parts[index]);
+    child = object_resolve_path_component(parent, *parts);
     if (!child) {
         return NULL;
     }
 
-    return object_resolve_abs_path(child, parts, typename, index + 1);
+    return object_resolve_abs_path(child, parts + 1, typename);
 }
 
 static Object *object_resolve_partial_path(Object *parent,
@@ -1987,7 +1986,7 @@ static Object *object_resolve_partial_path(Object *parent,
     GHashTableIter iter;
     ObjectProperty *prop;
 
-    obj = object_resolve_abs_path(parent, parts, typename, 0);
+    obj = object_resolve_abs_path(parent, parts, typename);
 
     g_hash_table_iter_init(&iter, parent->properties);
     while (g_hash_table_iter_next(&iter, NULL, (gpointer *)&prop)) {
@@ -2032,7 +2031,7 @@ Object *object_resolve_path_type(const char *path, const char *typename,
             *ambiguousp = ambiguous;
         }
     } else {
-        obj = object_resolve_abs_path(object_get_root(), parts, typename, 1);
+        obj = object_resolve_abs_path(object_get_root(), parts + 1, typename);
     }
 
     g_strfreev(parts);
-- 
2.26.2



