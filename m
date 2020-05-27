Return-Path: <SRS0=ACoC=7J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC30AC433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2020 08:48:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A56C5206F1
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2020 08:48:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WKFskxuD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A56C5206F1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59540 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdrk1-0006us-RY
	for qemu-devel@archiver.kernel.org; Wed, 27 May 2020 04:48:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33102)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jdrjH-00063q-Cg
 for qemu-devel@nongnu.org; Wed, 27 May 2020 04:48:03 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:23372
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jdrjG-00035C-K8
 for qemu-devel@nongnu.org; Wed, 27 May 2020 04:48:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590569282;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mkLidLYMI/hYlZ/RLPHB3aO0IzGW92pcRxzL41t8cow=;
 b=WKFskxuD2prMJA1EEdp6osYjzP/hkfIFzrEFQaeHCTOLs1ean5e8fxtXlfxaVX1db75nSd
 Q+se3KYnIZaVddh+PC0RrEde/eQymYqMqK9ADS05kWxFaPOIB2vuKjLh0QhwZWfYwm+rOl
 yyhy4yFoxbPwdx12nrRqqhwqlgvKd50=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-337-6CpgoGUFODWRKWsHYbNt-A-1; Wed, 27 May 2020 04:48:00 -0400
X-MC-Unique: 6CpgoGUFODWRKWsHYbNt-A-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7C832107ACCA;
 Wed, 27 May 2020 08:47:59 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-32.ams2.redhat.com
 [10.36.112.32])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C768D74E82;
 Wed, 27 May 2020 08:47:55 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 30F6C11386A3; Wed, 27 May 2020 10:47:54 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 2/2] qom: Make "info qom-tree" show children sorted
Date: Wed, 27 May 2020 10:47:54 +0200
Message-Id: <20200527084754.7531-3-armbru@redhat.com>
In-Reply-To: <20200527084754.7531-1-armbru@redhat.com>
References: <20200527084754.7531-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=armbru@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/27 01:25:42
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: berrange@redhat.com, ehabkost@redhat.com, philmd@redhat.com,
 mark.cave-ayland@ilande.co.uk, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

"info qom-tree" prints children in unstable order.  This is a pain
when diffing output for different versions to find change.  Print it
sorted.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 qom/qom-hmp-cmds.c | 24 ++++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/qom/qom-hmp-cmds.c b/qom/qom-hmp-cmds.c
index cd08233a4c..94bdee9a90 100644
--- a/qom/qom-hmp-cmds.c
+++ b/qom/qom-hmp-cmds.c
@@ -69,22 +69,25 @@ typedef struct QOMCompositionState {
 
 static void print_qom_composition(Monitor *mon, Object *obj, int indent);
 
-static int print_qom_composition_child(Object *obj, void *opaque)
+static int qom_composition_compare(const void *a, const void *b, void *ignore)
 {
-    QOMCompositionState *s = opaque;
+    return g_strcmp0(a ? object_get_canonical_path_component(a) : NULL,
+                     b ? object_get_canonical_path_component(b) : NULL);
+}
 
-    print_qom_composition(s->mon, obj, s->indent);
+static int insert_qom_composition_child(Object *obj, void *opaque)
+{
+    GQueue *children = opaque;
 
+    g_queue_insert_sorted(children, obj, qom_composition_compare, NULL);
     return 0;
 }
 
 static void print_qom_composition(Monitor *mon, Object *obj, int indent)
 {
-    QOMCompositionState s = {
-        .mon = mon,
-        .indent = indent + 2,
-    };
     char *name;
+    GQueue children;
+    Object *child;
 
     if (obj == object_get_root()) {
         name = g_strdup("");
@@ -94,7 +97,12 @@ static void print_qom_composition(Monitor *mon, Object *obj, int indent)
     monitor_printf(mon, "%*s/%s (%s)\n", indent, "", name,
                    object_get_typename(obj));
     g_free(name);
-    object_child_foreach(obj, print_qom_composition_child, &s);
+
+    g_queue_init(&children);
+    object_child_foreach(obj, insert_qom_composition_child, &children);
+    while ((child = g_queue_pop_head(&children))) {
+        print_qom_composition(mon, child, indent + 2);
+    }
 }
 
 void hmp_info_qom_tree(Monitor *mon, const QDict *dict)
-- 
2.21.3


