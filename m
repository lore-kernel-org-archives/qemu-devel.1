Return-Path: <SRS0=tJVC=74=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B468BC433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2020 20:42:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7BAE52078E
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2020 20:42:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Yz6uGiDE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BAE52078E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38854 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jkvvd-0004OM-Fy
	for qemu-devel@archiver.kernel.org; Mon, 15 Jun 2020 16:42:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33084)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jkvty-0002IO-2g
 for qemu-devel@nongnu.org; Mon, 15 Jun 2020 16:40:18 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:60599
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jkvtw-0000Qt-2p
 for qemu-devel@nongnu.org; Mon, 15 Jun 2020 16:40:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592253615;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XXhsYAc1sImCT0pApL2R+GfUcSbdeXmhcKh5DC7hMK0=;
 b=Yz6uGiDEdmo7gT8Sy+IKrNoy4ZI3AcB8HHkoiO/6wy6Z2/7mVBIQkkAKd6pOKw/DMogw8c
 RkLjhzlNa76FW5v582apuoj2RDWgGs6nA/zWTmIf9UssXfJPnW83iLVbQKzOLCiDJHfYbX
 tYlRJMnTf8M9ENGDrFPR+4/9Hzz8gUw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-161-su0K3nrOOcSne34IGGjxoA-1; Mon, 15 Jun 2020 16:40:12 -0400
X-MC-Unique: su0K3nrOOcSne34IGGjxoA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CCCC21091320;
 Mon, 15 Jun 2020 20:40:11 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-121.ams2.redhat.com
 [10.36.112.121])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9D0725D9D7;
 Mon, 15 Jun 2020 20:40:11 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 1FCB611385F1; Mon, 15 Jun 2020 22:40:08 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 02/84] qom: Make "info qom-tree" show children sorted
Date: Mon, 15 Jun 2020 22:38:46 +0200
Message-Id: <20200615204008.3069956-3-armbru@redhat.com>
In-Reply-To: <20200615204008.3069956-1-armbru@redhat.com>
References: <20200615204008.3069956-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/15 15:33:04
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

"info qom-tree" prints children in unstable order.  This is a pain
when diffing output for different versions to find change.  Print it
sorted.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-Id: <20200527084754.7531-3-armbru@redhat.com>
Tested-by: Cédric Le Goater <clg@kaod.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 qom/qom-hmp-cmds.c | 24 ++++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/qom/qom-hmp-cmds.c b/qom/qom-hmp-cmds.c
index f704b6949a..99385b6ad2 100644
--- a/qom/qom-hmp-cmds.c
+++ b/qom/qom-hmp-cmds.c
@@ -81,22 +81,25 @@ typedef struct QOMCompositionState {
 
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
@@ -106,7 +109,12 @@ static void print_qom_composition(Monitor *mon, Object *obj, int indent)
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
2.26.2


