Return-Path: <SRS0=sZ1e=65=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49098C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 06:05:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 135902065C
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 06:05:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h2MZvoJw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 135902065C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44776 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZTTY-0004Qe-6f
	for qemu-devel@archiver.kernel.org; Fri, 15 May 2020 02:05:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55876)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jZTSS-000325-Ba
 for qemu-devel@nongnu.org; Fri, 15 May 2020 02:04:32 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:51409
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jZTSQ-0004Q1-PU
 for qemu-devel@nongnu.org; Fri, 15 May 2020 02:04:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589522670;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bv5LTCZ65KOI088oT5YONi+7yD0EENHd0Gp/slVCUno=;
 b=h2MZvoJwu8O2d1g6j92er3ZcuQjt9h490ZbemMNt4bRQmndb3vCcLJZDUblJfrbI2Q80B6
 hk20HBV6f/J+Iq/lrJHaRNCoyjaOzSKqWmnuG8Qa0RCOxgfyYFAhPsNWAT2zRrr9qIEH2A
 hCUdxKfsIqi3Ieo34qMFTuOiuAn7s8U=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-487-VG0APY7gMmGIDVXUsAiKMA-1; Fri, 15 May 2020 02:04:28 -0400
X-MC-Unique: VG0APY7gMmGIDVXUsAiKMA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 83649100962E
 for <qemu-devel@nongnu.org>; Fri, 15 May 2020 06:04:27 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-113-6.ams2.redhat.com [10.36.113.6])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2F9095D9F3;
 Fri, 15 May 2020 06:04:27 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 3630C11358C1; Fri, 15 May 2020 08:04:24 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 05/21] qom: Drop convenience method
 object_property_get_uint16List()
Date: Fri, 15 May 2020 08:04:08 +0200
Message-Id: <20200515060424.18993-6-armbru@redhat.com>
In-Reply-To: <20200515060424.18993-1-armbru@redhat.com>
References: <20200515060424.18993-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/15 00:39:12
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

qom/object.c provides object_property_get_TYPE() and
object_property_set_TYPE() for a number of common types.  These are
all convenience wrappers around object_property_get_qobject() and
object_property_set_qobject().

Except for object_property_get_uint16List(), which is unusual in two ways:

* It bypasses object_property_get_qobject().  Fixable; the previous
  commit did it for object_property_get_enum())

* It stores the value through a parameter.  Its contract claims it
  returns the value, like the other functions do.  Also fixable.

Fixing is not worthwhile, though: object_property_get_uint16List() has
seen exactly one user in six years.

Convert the lone user to do its job with the generic
object_property_get_qobject(), and drop object_property_get_uint16List().

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-Id: <20200505152926.18877-6-armbru@redhat.com>
Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
[Commit message typo fixed]
---
 include/qom/object.h       | 14 --------------
 hw/core/machine-qmp-cmds.c | 16 +++++++++++++---
 qom/object.c               | 23 -----------------------
 3 files changed, 13 insertions(+), 40 deletions(-)

diff --git a/include/qom/object.h b/include/qom/object.h
index ccfa82e33d..4df9ecebad 100644
--- a/include/qom/object.h
+++ b/include/qom/object.h
@@ -1320,20 +1320,6 @@ uint64_t object_property_get_uint(Object *obj, const char *name,
 int object_property_get_enum(Object *obj, const char *name,
                              const char *typename, Error **errp);
 
-/**
- * object_property_get_uint16List:
- * @obj: the object
- * @name: the name of the property
- * @list: the returned int list
- * @errp: returns an error if this function fails
- *
- * Returns: the value of the property, converted to integers, or
- * undefined if an error occurs (including when the property value is not
- * an list of integers).
- */
-void object_property_get_uint16List(Object *obj, const char *name,
-                                    uint16List **list, Error **errp);
-
 /**
  * object_property_set:
  * @obj: the object
diff --git a/hw/core/machine-qmp-cmds.c b/hw/core/machine-qmp-cmds.c
index eed5aeb2f7..2c5da8413d 100644
--- a/hw/core/machine-qmp-cmds.c
+++ b/hw/core/machine-qmp-cmds.c
@@ -11,9 +11,13 @@
 #include "cpu.h"
 #include "hw/boards.h"
 #include "qapi/error.h"
+#include "qapi/qapi-builtin-visit.h"
 #include "qapi/qapi-commands-machine.h"
 #include "qapi/qmp/qerror.h"
+#include "qapi/qmp/qobject.h"
+#include "qapi/qobject-input-visitor.h"
 #include "qemu/main-loop.h"
+#include "qom/qom-qobject.h"
 #include "sysemu/hostmem.h"
 #include "sysemu/hw_accel.h"
 #include "sysemu/numa.h"
@@ -303,6 +307,8 @@ static int query_memdev(Object *obj, void *opaque)
 {
     MemdevList **list = opaque;
     MemdevList *m = NULL;
+    QObject *host_nodes;
+    Visitor *v;
 
     if (object_dynamic_cast(obj, TYPE_MEMORY_BACKEND)) {
         m = g_malloc0(sizeof(*m));
@@ -325,9 +331,13 @@ static int query_memdev(Object *obj, void *opaque)
                                                     "policy",
                                                     "HostMemPolicy",
                                                     &error_abort);
-        object_property_get_uint16List(obj, "host-nodes",
-                                       &m->value->host_nodes,
-                                       &error_abort);
+        host_nodes = object_property_get_qobject(obj,
+                                                 "host-nodes",
+                                                 &error_abort);
+        v = qobject_input_visitor_new(host_nodes);
+        visit_type_uint16List(v, NULL, &m->value->host_nodes, &error_abort);
+        visit_free(v);
+        qobject_unref(host_nodes);
 
         m->next = *list;
         *list = m;
diff --git a/qom/object.c b/qom/object.c
index b374af302c..54a26ed16a 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -1550,29 +1550,6 @@ int object_property_get_enum(Object *obj, const char *name,
     return ret;
 }
 
-void object_property_get_uint16List(Object *obj, const char *name,
-                                    uint16List **list, Error **errp)
-{
-    Error *err = NULL;
-    Visitor *v;
-    char *str;
-
-    v = string_output_visitor_new(false, &str);
-    object_property_get(obj, v, name, &err);
-    if (err) {
-        error_propagate(errp, err);
-        goto out;
-    }
-    visit_complete(v, &str);
-    visit_free(v);
-    v = string_input_visitor_new(str);
-    visit_type_uint16List(v, NULL, list, errp);
-
-    g_free(str);
-out:
-    visit_free(v);
-}
-
 void object_property_parse(Object *obj, const char *string,
                            const char *name, Error **errp)
 {
-- 
2.21.1


