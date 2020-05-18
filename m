Return-Path: <SRS0=vczr=7A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B91DCC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 05:22:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 883F120715
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 05:22:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X0B4cXbj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 883F120715
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44114 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jaYEV-0002mQ-I1
	for qemu-devel@archiver.kernel.org; Mon, 18 May 2020 01:22:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50502)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jaYBs-0006FP-T1
 for qemu-devel@nongnu.org; Mon, 18 May 2020 01:19:52 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:43231
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jaYBr-0007IU-3N
 for qemu-devel@nongnu.org; Mon, 18 May 2020 01:19:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589779189;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lrjdkoqq59m3gm70wai2XBaHaN/BcEgROdns7yTJmXE=;
 b=X0B4cXbjZIDqi8R5s+1RJCBkqumwfeqP+oZRTheI7wZMurib5eLplxzkjmYlc+PxpIDSqJ
 9Wxy0UXJyOK9/gMrWKACoIfRH0jnC3YerYIjpFAqXaH+BfOch8cGLBg2xHxDZYx5dHjUJ3
 lwbQa35DenWpuGKkCc7J3nmavUHivcw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-433-oDkRMBiwPva-GOxctlLE7w-1; Mon, 18 May 2020 01:19:48 -0400
X-MC-Unique: oDkRMBiwPva-GOxctlLE7w-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1EFD91800D42
 for <qemu-devel@nongnu.org>; Mon, 18 May 2020 05:19:47 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-32.ams2.redhat.com
 [10.36.112.32])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E189F5C1B2;
 Mon, 18 May 2020 05:19:46 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 6097011358BE; Mon, 18 May 2020 07:19:45 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH not-for-merge 2/5] qom: Make "info qom-tree" show children
 sorted
Date: Mon, 18 May 2020 07:19:42 +0200
Message-Id: <20200518051945.8621-3-armbru@redhat.com>
In-Reply-To: <20200518051945.8621-1-armbru@redhat.com>
References: <20200518051945.8621-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/17 22:52:27
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
Cc: pbonzini@redhat.com, berrange@redhat.com, ehabkost@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

"info qom-tree" prints children in unstable order.  This is a pain
when diffing output for different versions to find change.  Print it
sorted.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 qom/qom-hmp-cmds.c | 40 +++++++++++++++++++++++++++++++++++++++-
 1 file changed, 39 insertions(+), 1 deletion(-)

diff --git a/qom/qom-hmp-cmds.c b/qom/qom-hmp-cmds.c
index 4a61ee1b8c..cf0af8f6b5 100644
--- a/qom/qom-hmp-cmds.c
+++ b/qom/qom-hmp-cmds.c
@@ -78,6 +78,35 @@ static int print_qom_composition_child(Object *obj, void *opaque)
     return 0;
 }
 
+static int qom_composition_compare(const void *a, const void *b, void *ignore)
+{
+    Object *obja = (void *)a, *objb = (void *)b;
+    const char *namea, *nameb;
+
+    if (obja == object_get_root()) {
+        namea = g_strdup("");
+    } else {
+        namea = object_get_canonical_path_component(obja);
+    }
+
+    if (objb == object_get_root()) {
+        nameb = g_strdup("");
+    } else {
+        nameb = object_get_canonical_path_component(objb);
+    }
+
+
+    return strcmp(namea, nameb);
+}
+
+static int insert_qom_composition_child(Object *obj, void *opaque)
+{
+    GQueue *children = opaque;
+
+     g_queue_insert_sorted(children, obj, qom_composition_compare, NULL);
+     return 0;
+}
+
 static void print_qom_composition(Monitor *mon, Object *obj, int indent)
 {
     QOMCompositionState s = {
@@ -105,7 +134,16 @@ static void print_qom_composition(Monitor *mon, Object *obj, int indent)
     monitor_printf(mon, "%*s/%s (%s)\n", indent, "", name,
                    object_get_typename(obj));
     g_free(name);
-    object_child_foreach(obj, print_qom_composition_child, &s);
+
+    GQueue children;
+    Object *child;
+    g_queue_init(&children);
+    object_child_foreach(obj, insert_qom_composition_child, &children);
+    while ((child = g_queue_pop_head(&children))) {
+        print_qom_composition(mon, child, indent + 2);
+    }
+    (void)s;
+    (void)print_qom_composition_child;
 }
 
 void hmp_info_qom_tree(Monitor *mon, const QDict *dict)
-- 
2.21.1


