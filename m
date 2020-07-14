Return-Path: <SRS0=DUFB=AZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDE0EC433E3
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 16:03:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9644922475
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 16:03:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SiD3JajM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9644922475
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33636 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jvNPI-0001zh-OB
	for qemu-devel@archiver.kernel.org; Tue, 14 Jul 2020 12:03:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54248)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jvNNn-0000MU-J5
 for qemu-devel@nongnu.org; Tue, 14 Jul 2020 12:02:15 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:59667
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jvNNi-000819-0P
 for qemu-devel@nongnu.org; Tue, 14 Jul 2020 12:02:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594742528;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=N1nzvUk7EEpzgnDqyA9M50UToID+wiZZOE4P6zSuRUQ=;
 b=SiD3JajM8cxewGqr3oah6VcspI85sJRBhkdxXlXBHAfXDR9B10Qqy9GdgMAbeM6TlbPWZy
 9sc2/59ceJTUYQ90KKvug81UvwiZ5QeL4jiC3P7l6l9dsadx1jF4shfApvl1m4B6zQMFyP
 Y0YUfpmWfDv6/Ku3TUsETKYzsbMKOz4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-228-enUGeZAkObiSeP7o9vKmqQ-1; Tue, 14 Jul 2020 12:02:06 -0400
X-MC-Unique: enUGeZAkObiSeP7o9vKmqQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 63CD718C63C9;
 Tue, 14 Jul 2020 16:02:05 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-143.ams2.redhat.com
 [10.36.112.143])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 30EA978A4B;
 Tue, 14 Jul 2020 16:02:05 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 3C09117741CD; Tue, 14 Jul 2020 18:02:02 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH for-5.1 5/5] qom: Make info qom-tree sort children more
 efficiently
Date: Tue, 14 Jul 2020 18:02:02 +0200
Message-Id: <20200714160202.3121879-6-armbru@redhat.com>
In-Reply-To: <20200714160202.3121879-1-armbru@redhat.com>
References: <20200714160202.3121879-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/14 03:57:32
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
Cc: lvivier@redhat.com, thuth@redhat.com, berrange@redhat.com,
 ehabkost@redhat.com, pbonzini@redhat.com, alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Commit e8c9e65816 "qom: Make "info qom-tree" show children sorted"
sorts children the simple, stupid, quadratic way.  I thought the
number of children would be small enough for this not to matter.  I
was wrong: there are outliers with several hundred children, e.g ARM
machines nuri and smdkc210 each have a node with 513 children.

While n^2 sorting isn't noticeable in normal, human usage even for
n=513, it can be quite noticeable in certain automated tests.  In
particular, the sort made device-introspect-test even slower.  Commit
3e7b80f84d "tests: improve performance of device-introspect-test" just
fixed that by cutting back its excessive use of "info qom-tree".
Sorting more efficiently makes sense regardless, so do it.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 qom/qom-hmp-cmds.c | 25 +++++++++++++------------
 1 file changed, 13 insertions(+), 12 deletions(-)

diff --git a/qom/qom-hmp-cmds.c b/qom/qom-hmp-cmds.c
index 4032c96089..8861a109d5 100644
--- a/qom/qom-hmp-cmds.c
+++ b/qom/qom-hmp-cmds.c
@@ -94,25 +94,23 @@ typedef struct QOMCompositionState {
 
 static void print_qom_composition(Monitor *mon, Object *obj, int indent);
 
-static int qom_composition_compare(const void *a, const void *b, void *ignore)
+static int qom_composition_compare(const void *a, const void *b)
 {
-    return g_strcmp0(object_get_canonical_path_component(a),
-                     object_get_canonical_path_component(b));
+    return g_strcmp0(object_get_canonical_path_component(*(Object **)a),
+                     object_get_canonical_path_component(*(Object **)b));
 }
 
 static int insert_qom_composition_child(Object *obj, void *opaque)
 {
-    GQueue *children = opaque;
-
-    g_queue_insert_sorted(children, obj, qom_composition_compare, NULL);
+    g_array_append_val(opaque, obj);
     return 0;
 }
 
 static void print_qom_composition(Monitor *mon, Object *obj, int indent)
 {
+    GArray *children = g_array_new(false, false, sizeof(Object *));
     const char *name;
-    GQueue children;
-    Object *child;
+    int i;
 
     if (obj == object_get_root()) {
         name = "";
@@ -122,11 +120,14 @@ static void print_qom_composition(Monitor *mon, Object *obj, int indent)
     monitor_printf(mon, "%*s/%s (%s)\n", indent, "", name,
                    object_get_typename(obj));
 
-    g_queue_init(&children);
-    object_child_foreach(obj, insert_qom_composition_child, &children);
-    while ((child = g_queue_pop_head(&children))) {
-        print_qom_composition(mon, child, indent + 2);
+    object_child_foreach(obj, insert_qom_composition_child, children);
+    g_array_sort(children, qom_composition_compare);
+
+    for (i = 0; i < children->len; i++) {
+        print_qom_composition(mon, g_array_index(children, Object *, i),
+                              indent + 2);
     }
+    g_array_free(children, TRUE);
 }
 
 void hmp_info_qom_tree(Monitor *mon, const QDict *dict)
-- 
2.26.2


