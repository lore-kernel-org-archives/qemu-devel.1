Return-Path: <SRS0=q+n2=EF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DD5BC00A89
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 20:23:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 75C0120739
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 20:23:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JDEz2L9A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75C0120739
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44648 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kYavb-0001rp-FN
	for qemu-devel@archiver.kernel.org; Fri, 30 Oct 2020 16:23:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52956)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kYau3-0000AV-QR
 for qemu-devel@nongnu.org; Fri, 30 Oct 2020 16:21:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:41711)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kYau2-0007gy-7J
 for qemu-devel@nongnu.org; Fri, 30 Oct 2020 16:21:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604089297;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kbIlRTm+g9R66uhaUJCj2lh/+Y5iGPaNhJsZTxBhXm8=;
 b=JDEz2L9ATinqIVUggOqW3IDpgp4uCU5t4F8KybEq02CnvpOzgUonVs+eaNHQBAMIpvdzLv
 jE9ki9PesrGMrkc91EmJzKvRV+76AXARFAk9tRtPdQliJpcGvGGGNplAILti8mBWXdW7mR
 +9JL+m64XgatHnNIW2GK5MY8Bxwb/BI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-26-3zW1hjSoOD6pOC8elCznyw-1; Fri, 30 Oct 2020 16:21:35 -0400
X-MC-Unique: 3zW1hjSoOD6pOC8elCznyw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3D4EE1019632
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2020 20:21:34 +0000 (UTC)
Received: from localhost (ovpn-114-68.rdu2.redhat.com [10.10.114.68])
 by smtp.corp.redhat.com (Postfix) with ESMTP id F1A9F18E51;
 Fri, 30 Oct 2020 20:21:33 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 01/20] qom: Add prefix to error message inside
 object_property_parse()
Date: Fri, 30 Oct 2020 16:21:12 -0400
Message-Id: <20201030202131.796967-2-ehabkost@redhat.com>
In-Reply-To: <20201030202131.796967-1-ehabkost@redhat.com>
References: <20201030202131.796967-1-ehabkost@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ehabkost@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/30 01:22:25
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Make object_property_parse() automatically add a error message
prefix mentioning the QOM type and property name when
encountering errors.

As we have a large number of functions that add their own
"Property '...'" to the error messages, add a temporary check for
existing prefixes before prepending our own.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: "Daniel P. Berrangé" <berrange@redhat.com>
Cc: Eduardo Habkost <ehabkost@redhat.com>
Cc: qemu-devel@nongnu.org
---
 qom/object.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/qom/object.c b/qom/object.c
index 20726e4584..6fb1657724 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -1635,9 +1635,20 @@ int object_property_get_enum(Object *obj, const char *name,
 bool object_property_parse(Object *obj, const char *name,
                            const char *string, Error **errp)
 {
+    ERRP_GUARD();
     Visitor *v = string_input_visitor_new(string);
     bool ok = object_property_set(obj, name, v, errp);
 
+    if (!ok) {
+        /*
+         * Temporary check for existing prefix, until all error reporting
+         * functions remove their own prefix.
+         */
+        if (!g_str_has_prefix(error_get_pretty(*errp), "Property '")) {
+            error_prepend(errp, "Property '%s.%s' can't take value '%s': ",
+                        object_get_typename(obj), name, string);
+        }
+    }
     visit_free(v);
     return ok;
 }
-- 
2.28.0


