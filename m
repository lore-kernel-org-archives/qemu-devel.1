Return-Path: <SRS0=sZ1e=65=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A629C433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 06:05:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E7C782075F
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 06:05:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="deElYU+F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7C782075F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44926 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZTTa-0004Uh-42
	for qemu-devel@archiver.kernel.org; Fri, 15 May 2020 02:05:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55888)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jZTST-00033a-Am
 for qemu-devel@nongnu.org; Fri, 15 May 2020 02:04:33 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:60400
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jZTSP-0004Ou-S2
 for qemu-devel@nongnu.org; Fri, 15 May 2020 02:04:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589522668;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lt8R5u2qvAG9ZvHgtAUti+Ik3jMxOid5B7cFrh7KYV4=;
 b=deElYU+FQnb3SWuq3qOxLH5kRIKIxml+5JFe3j+/MhROyef6ahbuviERLiKd5Fqb+CVu9d
 BQCyKqBbSpycSINa32LQEZ+6omh4sUfinJApTNomVqAZ1tVIiP/9M0VHqZOiSdCNPlQFDi
 p3xWZzLwyg5oKHGc66wyc7tR1f0x6G8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-357-oTztjXpLOEqX8E5B9gBq-A-1; Fri, 15 May 2020 02:04:27 -0400
X-MC-Unique: oTztjXpLOEqX8E5B9gBq-A-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 39D4D8015CF
 for <qemu-devel@nongnu.org>; Fri, 15 May 2020 06:04:26 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-113-6.ams2.redhat.com [10.36.113.6])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B28FB78B24;
 Fri, 15 May 2020 06:04:25 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 2C99811358BE; Fri, 15 May 2020 08:04:24 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 02/21] qom: Clean up inconsistent use of gchar * vs. char *
Date: Fri, 15 May 2020 08:04:05 +0200
Message-Id: <20200515060424.18993-3-armbru@redhat.com>
In-Reply-To: <20200515060424.18993-1-armbru@redhat.com>
References: <20200515060424.18993-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
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

Uses of gchar * in qom/object.h:

* ObjectProperty member @name

  Functions that take a property name argument all use char *.  Change
  the member to match.

* ObjectProperty member @type

  Functions that take a property type argument or return it all use
  char *.  Change the member to match.

* ObjectProperty member @description

  Functions that take a property description argument all use char *.
  Change the member to match.

* object_resolve_path_component() parameter @part

  Path components are property names.  Most callers pass char *
  arguments.  Change the parameter to match.  Adjust the few callers
  that pass gchar * to pass char *.

* Return value of object_get_canonical_path_component(),
  object_get_canonical_path()

  Most callers convert their return values right back to char *.
  Change the return value to match.  Adjust the few callers where that
  would add a conversion to gchar * to use char * instead.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
Message-Id: <20200505152926.18877-3-armbru@redhat.com>
---
 include/qom/object.h       | 12 +++++-----
 monitor/monitor-internal.h |  2 +-
 hw/dma/xlnx-zdma.c         |  4 ++--
 hw/net/virtio-net.c        |  2 +-
 hw/ppc/spapr_drc.c         |  2 +-
 memory.c                   |  4 ++--
 qom/container.c            |  2 +-
 qom/object.c               | 46 ++++++++++++++++++++------------------
 8 files changed, 38 insertions(+), 36 deletions(-)

diff --git a/include/qom/object.h b/include/qom/object.h
index 784c97c0e1..ccfa82e33d 100644
--- a/include/qom/object.h
+++ b/include/qom/object.h
@@ -369,9 +369,9 @@ typedef void (ObjectPropertyInit)(Object *obj, ObjectProperty *prop);
 
 struct ObjectProperty
 {
-    gchar *name;
-    gchar *type;
-    gchar *description;
+    char *name;
+    char *type;
+    char *description;
     ObjectPropertyAccessor *get;
     ObjectPropertyAccessor *set;
     ObjectPropertyResolve *resolve;
@@ -1421,7 +1421,7 @@ Object *object_get_internal_root(void);
  * path is the path within the composition tree starting from the root.
  * %NULL if the object doesn't have a parent (and thus a canonical path).
  */
-gchar *object_get_canonical_path_component(Object *obj);
+char *object_get_canonical_path_component(Object *obj);
 
 /**
  * object_get_canonical_path:
@@ -1429,7 +1429,7 @@ gchar *object_get_canonical_path_component(Object *obj);
  * Returns: The canonical path for a object.  This is the path within the
  * composition tree starting from the root.
  */
-gchar *object_get_canonical_path(Object *obj);
+char *object_get_canonical_path(Object *obj);
 
 /**
  * object_resolve_path:
@@ -1487,7 +1487,7 @@ Object *object_resolve_path_type(const char *path, const char *typename,
  *
  * Returns: The resolved object or NULL on path lookup failure.
  */
-Object *object_resolve_path_component(Object *parent, const gchar *part);
+Object *object_resolve_path_component(Object *parent, const char *part);
 
 /**
  * object_property_add_child:
diff --git a/monitor/monitor-internal.h b/monitor/monitor-internal.h
index 8f60ccc70a..b39e03b744 100644
--- a/monitor/monitor-internal.h
+++ b/monitor/monitor-internal.h
@@ -91,7 +91,7 @@ struct Monitor {
     bool skip_flush;
     bool use_io_thread;
 
-    gchar *mon_cpu_path;
+    char *mon_cpu_path;
     QTAILQ_ENTRY(Monitor) entry;
 
     /*
diff --git a/hw/dma/xlnx-zdma.c b/hw/dma/xlnx-zdma.c
index 4121a1b489..2dec4a2643 100644
--- a/hw/dma/xlnx-zdma.c
+++ b/hw/dma/xlnx-zdma.c
@@ -719,7 +719,7 @@ static uint64_t zdma_read(void *opaque, hwaddr addr, unsigned size)
     RegisterInfo *r = &s->regs_info[addr / 4];
 
     if (!r->data) {
-        gchar *path = object_get_canonical_path(OBJECT(s));
+        char *path = object_get_canonical_path(OBJECT(s));
         qemu_log("%s: Decode error: read from %" HWADDR_PRIx "\n",
                  path,
                  addr);
@@ -738,7 +738,7 @@ static void zdma_write(void *opaque, hwaddr addr, uint64_t value,
     RegisterInfo *r = &s->regs_info[addr / 4];
 
     if (!r->data) {
-        gchar *path = object_get_canonical_path(OBJECT(s));
+        char *path = object_get_canonical_path(OBJECT(s));
         qemu_log("%s: Decode error: write to %" HWADDR_PRIx "=%" PRIx64 "\n",
                  path,
                  addr, value);
diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index 3301869d4f..e51231e795 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -399,7 +399,7 @@ static void rxfilter_notify(NetClientState *nc)
     VirtIONet *n = qemu_get_nic_opaque(nc);
 
     if (nc->rxfilter_notify_enabled) {
-        gchar *path = object_get_canonical_path(OBJECT(n->qdev));
+        char *path = object_get_canonical_path(OBJECT(n->qdev));
         qapi_event_send_nic_rx_filter_changed(!!n->netclient_name,
                                               n->netclient_name, path);
         g_free(path);
diff --git a/hw/ppc/spapr_drc.c b/hw/ppc/spapr_drc.c
index 47e6bb12f9..0b66d59867 100644
--- a/hw/ppc/spapr_drc.c
+++ b/hw/ppc/spapr_drc.c
@@ -518,7 +518,7 @@ static void realize(DeviceState *d, Error **errp)
     SpaprDrc *drc = SPAPR_DR_CONNECTOR(d);
     Object *root_container;
     gchar *link_name;
-    gchar *child_name;
+    char *child_name;
     Error *err = NULL;
 
     trace_spapr_drc_realize(spapr_drc_index(drc));
diff --git a/memory.c b/memory.c
index 601b749906..936c1b23d4 100644
--- a/memory.c
+++ b/memory.c
@@ -1175,7 +1175,7 @@ static void memory_region_get_container(Object *obj, Visitor *v,
                                         Error **errp)
 {
     MemoryRegion *mr = MEMORY_REGION(obj);
-    gchar *path = (gchar *)"";
+    char *path = (char *)"";
 
     if (mr->container) {
         path = object_get_canonical_path(OBJECT(mr->container));
@@ -2845,7 +2845,7 @@ static void mtree_expand_owner(const char *label, Object *obj)
     if (dev && dev->id) {
         qemu_printf(" id=%s", dev->id);
     } else {
-        gchar *canonical_path = object_get_canonical_path(obj);
+        char *canonical_path = object_get_canonical_path(obj);
         if (canonical_path) {
             qemu_printf(" path=%s", canonical_path);
             g_free(canonical_path);
diff --git a/qom/container.c b/qom/container.c
index f6ccaf7ea7..e635e8ee76 100644
--- a/qom/container.c
+++ b/qom/container.c
@@ -28,7 +28,7 @@ static void container_register_types(void)
 Object *container_get(Object *root, const char *path)
 {
     Object *obj, *child;
-    gchar **parts;
+    char **parts;
     int i;
 
     parts = g_strsplit(path, "/", 0);
diff --git a/qom/object.c b/qom/object.c
index 5511649502..07762cc331 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -1357,7 +1357,7 @@ void object_property_set_link(Object *obj, Object *value,
                               const char *name, Error **errp)
 {
     if (value) {
-        gchar *path = object_get_canonical_path(value);
+        char *path = object_get_canonical_path(value);
         object_property_set_str(obj, path, name, errp);
         g_free(path);
     } else {
@@ -1651,14 +1651,15 @@ static void object_get_child_property(Object *obj, Visitor *v,
                                       Error **errp)
 {
     Object *child = opaque;
-    gchar *path;
+    char *path;
 
     path = object_get_canonical_path(child);
     visit_type_str(v, name, &path, errp);
     g_free(path);
 }
 
-static Object *object_resolve_child_property(Object *parent, void *opaque, const gchar *part)
+static Object *object_resolve_child_property(Object *parent, void *opaque,
+                                             const char *part)
 {
     return opaque;
 }
@@ -1679,7 +1680,7 @@ void object_property_add_child(Object *obj, const char *name,
                                Object *child, Error **errp)
 {
     Error *local_err = NULL;
-    gchar *type;
+    char *type;
     ObjectProperty *op;
 
     if (child->parent != NULL) {
@@ -1738,14 +1739,14 @@ static void object_get_link_property(Object *obj, Visitor *v,
 {
     LinkProperty *lprop = opaque;
     Object **targetp = object_link_get_targetp(obj, lprop);
-    gchar *path;
+    char *path;
 
     if (*targetp) {
         path = object_get_canonical_path(*targetp);
         visit_type_str(v, name, &path, errp);
         g_free(path);
     } else {
-        path = (gchar *)"";
+        path = (char *)"";
         visit_type_str(v, name, &path, errp);
     }
 }
@@ -1763,7 +1764,7 @@ static Object *object_resolve_link(Object *obj, const char *name,
                                    const char *path, Error **errp)
 {
     const char *type;
-    gchar *target_type;
+    char *target_type;
     bool ambiguous = false;
     Object *target;
 
@@ -1826,7 +1827,8 @@ static void object_set_link_property(Object *obj, Visitor *v,
     }
 }
 
-static Object *object_resolve_link_property(Object *parent, void *opaque, const gchar *part)
+static Object *object_resolve_link_property(Object *parent, void *opaque,
+                                            const char *part)
 {
     LinkProperty *lprop = opaque;
 
@@ -1856,7 +1858,7 @@ static void object_add_link_prop(Object *obj, const char *name,
 {
     Error *local_err = NULL;
     LinkProperty *prop = g_malloc(sizeof(*prop));
-    gchar *full_type;
+    char *full_type;
     ObjectProperty *op;
 
     if (flags & OBJ_PROP_LINK_DIRECT) {
@@ -1908,7 +1910,7 @@ object_class_property_add_link(ObjectClass *oc,
 {
     Error *local_err = NULL;
     LinkProperty *prop = g_new0(LinkProperty, 1);
-    gchar *full_type;
+    char *full_type;
     ObjectProperty *op;
 
     prop->offset = offset;
@@ -1943,7 +1945,7 @@ void object_property_add_const_link(Object *obj, const char *name,
                          NULL, OBJ_PROP_LINK_DIRECT, errp);
 }
 
-gchar *object_get_canonical_path_component(Object *obj)
+char *object_get_canonical_path_component(Object *obj)
 {
     ObjectProperty *prop = NULL;
     GHashTableIter iter;
@@ -1968,7 +1970,7 @@ gchar *object_get_canonical_path_component(Object *obj)
     return NULL;
 }
 
-gchar *object_get_canonical_path(Object *obj)
+char *object_get_canonical_path(Object *obj)
 {
     Object *root = object_get_root();
     char *newpath, *path = NULL;
@@ -1998,7 +2000,7 @@ gchar *object_get_canonical_path(Object *obj)
     return path;
 }
 
-Object *object_resolve_path_component(Object *parent, const gchar *part)
+Object *object_resolve_path_component(Object *parent, const char *part)
 {
     ObjectProperty *prop = object_property_find(parent, part, NULL);
     if (prop == NULL) {
@@ -2013,9 +2015,9 @@ Object *object_resolve_path_component(Object *parent, const gchar *part)
 }
 
 static Object *object_resolve_abs_path(Object *parent,
-                                          gchar **parts,
-                                          const char *typename,
-                                          int index)
+                                       char **parts,
+                                       const char *typename,
+                                       int index)
 {
     Object *child;
 
@@ -2036,9 +2038,9 @@ static Object *object_resolve_abs_path(Object *parent,
 }
 
 static Object *object_resolve_partial_path(Object *parent,
-                                              gchar **parts,
-                                              const char *typename,
-                                              bool *ambiguous)
+                                           char **parts,
+                                           const char *typename,
+                                           bool *ambiguous)
 {
     Object *obj;
     GHashTableIter iter;
@@ -2076,7 +2078,7 @@ Object *object_resolve_path_type(const char *path, const char *typename,
                                  bool *ambiguousp)
 {
     Object *obj;
-    gchar **parts;
+    char **parts;
 
     parts = g_strsplit(path, "/", 0);
     assert(parts);
@@ -2767,7 +2769,7 @@ static void property_set_alias(Object *obj, Visitor *v, const char *name,
 }
 
 static Object *property_resolve_alias(Object *obj, void *opaque,
-                                      const gchar *part)
+                                      const char *part)
 {
     AliasProperty *prop = opaque;
 
@@ -2789,7 +2791,7 @@ void object_property_add_alias(Object *obj, const char *name,
     AliasProperty *prop;
     ObjectProperty *op;
     ObjectProperty *target_prop;
-    gchar *prop_type;
+    char *prop_type;
     Error *local_err = NULL;
 
     target_prop = object_property_find(target_obj, target_name, errp);
-- 
2.21.1


