Return-Path: <SRS0=sZ1e=65=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AB4FC433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 06:13:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D31402054F
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 06:13:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WNGsxRm0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D31402054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43162 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZTb2-0008Kr-3k
	for qemu-devel@archiver.kernel.org; Fri, 15 May 2020 02:13:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55900)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jZTSU-00034i-AD
 for qemu-devel@nongnu.org; Fri, 15 May 2020 02:04:34 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:51408
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jZTSR-0004Qm-OL
 for qemu-devel@nongnu.org; Fri, 15 May 2020 02:04:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589522671;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BrSbp9YJO2wMm0eUyLPKhUB5JoF5C8SLfuU16DehAGk=;
 b=WNGsxRm0QVSehcm9GWj1uKWBpzAh8Sb/XvKYVvsDsCFALu10edVM0znPpb3pdm4r7w+jYU
 iJ7nZPaxMKpCQkVLNtUXz7cfP2b+9SakSGxbHys1Jobn7yTThGbqh5A5At3IIvonaZRneh
 ceQxrCLAmM5BhYiwpdKv9eR9Qx6i5TY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-417-uOLvFvfzNyqfLHboNss3Iw-1; Fri, 15 May 2020 02:04:26 -0400
X-MC-Unique: uOLvFvfzNyqfLHboNss3Iw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E1E591005510
 for <qemu-devel@nongnu.org>; Fri, 15 May 2020 06:04:25 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-113-6.ams2.redhat.com [10.36.113.6])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B2ADA2E163;
 Fri, 15 May 2020 06:04:25 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 32E8611358C0; Fri, 15 May 2020 08:04:24 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 04/21] qom: Simplify object_property_get_enum()
Date: Fri, 15 May 2020 08:04:07 +0200
Message-Id: <20200515060424.18993-5-armbru@redhat.com>
In-Reply-To: <20200515060424.18993-1-armbru@redhat.com>
References: <20200515060424.18993-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=armbru@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/14 22:56:02
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Reuse object_property_get_str().  Switches from the string to the
qobject visitor under the hood.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-Id: <20200505152926.18877-5-armbru@redhat.com>
Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
---
 qom/object.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/qom/object.c b/qom/object.c
index 3d65658059..b374af302c 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -1521,8 +1521,6 @@ typedef struct EnumProperty {
 int object_property_get_enum(Object *obj, const char *name,
                              const char *typename, Error **errp)
 {
-    Error *err = NULL;
-    Visitor *v;
     char *str;
     int ret;
     ObjectProperty *prop = object_property_find(obj, name, errp);
@@ -1541,15 +1539,10 @@ int object_property_get_enum(Object *obj, const char *name,
 
     enumprop = prop->opaque;
 
-    v = string_output_visitor_new(false, &str);
-    object_property_get(obj, v, name, &err);
-    if (err) {
-        error_propagate(errp, err);
-        visit_free(v);
+    str = object_property_get_str(obj, name, errp);
+    if (!str) {
         return 0;
     }
-    visit_complete(v, &str);
-    visit_free(v);
 
     ret = qapi_enum_parse(enumprop->lookup, str, -1, errp);
     g_free(str);
-- 
2.21.1


