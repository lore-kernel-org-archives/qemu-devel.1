Return-Path: <SRS0=OdKR=D6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93B18C388F9
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 10:18:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F2BB224248
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 10:18:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CECMFLxD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2BB224248
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48882 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVu9F-000381-UC
	for qemu-devel@archiver.kernel.org; Fri, 23 Oct 2020 06:18:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37784)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1kVu4O-0005oC-Gm
 for qemu-devel@nongnu.org; Fri, 23 Oct 2020 06:13:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:49791)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1kVu4H-0001e9-1S
 for qemu-devel@nongnu.org; Fri, 23 Oct 2020 06:13:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603447984;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QXd6dJYpb/1Bwt14bYnbXhWwsGXX1sqMYzVDrAjYroc=;
 b=CECMFLxDk75WZ9EXvmNgRlkvqHKX97xKSZ74WV5eN1cumPjKyP540jA41iurZFv7rkTeo+
 zN4D8WGrxmJIvvXI1HMv1QAPbzyDKvHD5qfcpBxg9Oo6R5yW+sEmOEc6BXtxRUUXLvjXuc
 Wwj8XdrTkICMyRk7gLSx2QL+kkyG5aQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-232-d2DPz0x5Mj6k1sw5mRjWkQ-1; Fri, 23 Oct 2020 06:13:02 -0400
X-MC-Unique: d2DPz0x5Mj6k1sw5mRjWkQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 30FE2804B6E;
 Fri, 23 Oct 2020 10:13:01 +0000 (UTC)
Received: from merkur.redhat.com (ovpn-113-206.ams2.redhat.com [10.36.113.206])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5731E6EF41;
 Fri, 23 Oct 2020 10:12:59 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH 4/6] qapi: Optionally parse simple unions as flat
Date: Fri, 23 Oct 2020 12:12:20 +0200
Message-Id: <20201023101222.250147-5-kwolf@redhat.com>
In-Reply-To: <20201023101222.250147-1-kwolf@redhat.com>
References: <20201023101222.250147-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kwolf@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=63.128.21.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/23 02:46:25
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: kwolf@redhat.com, qemu-devel@nongnu.org, armbru@redhat.com,
 marcandre.lureau@redhat.com, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This extends the Visitor interface with an option that can enable flat
representation (without the 'data' wrapper) for simple unions. This way,
a command line parser can enable a more user friendly syntax while QMP
doesn't enable the option and uses the same representation as before.

We need to disable flat representation for ChardevSpiceChannel, which
has a 'type' option that conflicts with the ChardevBackend 'type'. This
variant will get nesting even when flat parsing is enabled in the
Visitor.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 qapi/char.json               |  3 ++-
 docs/devel/qapi-code-gen.txt | 11 ++++++++++-
 include/qapi/visitor-impl.h  |  3 +++
 include/qapi/visitor.h       | 10 ++++++++++
 qapi/qapi-visit-core.c       | 10 ++++++++++
 scripts/qapi/expr.py         |  7 ++++++-
 scripts/qapi/schema.py       | 25 ++++++++++++++++++-------
 scripts/qapi/visit.py        | 20 ++++++++++++++------
 8 files changed, 73 insertions(+), 16 deletions(-)

diff --git a/qapi/char.json b/qapi/char.json
index 43486d1daa..57ec18220b 100644
--- a/qapi/char.json
+++ b/qapi/char.json
@@ -414,7 +414,8 @@
             'stdio': 'ChardevStdio',
             'console': 'ChardevCommon',
             'spicevmc': { 'type': 'ChardevSpiceChannel',
-                          'if': 'defined(CONFIG_SPICE)' },
+                          'if': 'defined(CONFIG_SPICE)',
+                          'allow-flat': false },
             'spiceport': { 'type': 'ChardevSpicePort',
                            'if': 'defined(CONFIG_SPICE)' },
             'vc': 'ChardevVC',
diff --git a/docs/devel/qapi-code-gen.txt b/docs/devel/qapi-code-gen.txt
index 9722c1a204..ee34d39a20 100644
--- a/docs/devel/qapi-code-gen.txt
+++ b/docs/devel/qapi-code-gen.txt
@@ -295,7 +295,9 @@ Syntax:
               '*features': FEATURES }
     BRANCHES = { BRANCH, ... }
     BRANCH = STRING : TYPE-REF
-           | STRING : { 'type': TYPE-REF, '*if': COND }
+           | STRING : { 'type': TYPE-REF,
+                        '*if': COND,
+                        '*allow-flat': BOOL }
 
 Member 'union' names the union type.
 
@@ -334,6 +336,13 @@ values to data types like in this example:
    'data': { 'file': 'BlockdevOptionsFile',
              'qcow2': 'BlockdevOptionsQcow2' } }
 
+Simple unions can support both wrapped and flat representation of
+branches that have a struct type, unless it is explicitly disabled in
+the schema with 'allow-flat': false.  Branches of other types are
+always wrapped.  Which representation is used in the generated visitor
+C code can be configured per visitor.  Flat representation is
+appropriate when parsing command line options.
+
 In the Client JSON Protocol, all simple union branches have wrapped
 representation, as in these examples:
 
diff --git a/include/qapi/visitor-impl.h b/include/qapi/visitor-impl.h
index 7362c043be..f628b6eb36 100644
--- a/include/qapi/visitor-impl.h
+++ b/include/qapi/visitor-impl.h
@@ -121,6 +121,9 @@ struct Visitor
 
     /* Must be set */
     void (*free)(Visitor *v);
+
+    /* Set to true to make simple unions look like flat unions */
+    bool flat_simple_unions;
 };
 
 #endif
diff --git a/include/qapi/visitor.h b/include/qapi/visitor.h
index ebc19ede7f..d41be4df48 100644
--- a/include/qapi/visitor.h
+++ b/include/qapi/visitor.h
@@ -496,6 +496,16 @@ bool visit_is_input(Visitor *v);
  */
 bool visit_is_dealloc(Visitor *v);
 
+/*
+ * Check if simple unions should be treated as flat.
+ */
+bool visit_flat_simple_unions(Visitor *v);
+
+/*
+ * Set if simple unions should be treated as flat.
+ */
+void visit_set_flat_simple_unions(Visitor *v, bool flat);
+
 /*** Visiting built-in types ***/
 
 /*
diff --git a/qapi/qapi-visit-core.c b/qapi/qapi-visit-core.c
index 7e5f40e7f0..dc6fd78b8c 100644
--- a/qapi/qapi-visit-core.c
+++ b/qapi/qapi-visit-core.c
@@ -145,6 +145,16 @@ bool visit_is_dealloc(Visitor *v)
     return v->type == VISITOR_DEALLOC;
 }
 
+bool visit_flat_simple_unions(Visitor *v)
+{
+    return v->flat_simple_unions;
+}
+
+void visit_set_flat_simple_unions(Visitor *v, bool flat)
+{
+    v->flat_simple_unions = flat;
+}
+
 bool visit_type_int(Visitor *v, const char *name, int64_t *obj, Error **errp)
 {
     assert(obj);
diff --git a/scripts/qapi/expr.py b/scripts/qapi/expr.py
index 2fcaaa2497..a39092e4a9 100644
--- a/scripts/qapi/expr.py
+++ b/scripts/qapi/expr.py
@@ -248,7 +248,12 @@ def check_union(expr, info):
     for (key, value) in members.items():
         source = "'data' member '%s'" % key
         check_name_str(key, info, source)
-        check_keys(value, info, source, ['type'], ['if'])
+        check_keys(value, info, source, ['type'], ['if', 'allow-flat'])
+        if 'allow-flat' in value:
+            if discriminator is not None:
+                raise QAPISemError(info, "'allow-flat' requires simple union")
+            if not isinstance(value['allow-flat'], bool):
+                raise QAPISemError(info, "'allow-flat' must be a boolean")
         check_if(value, info, source)
         check_type(value['type'], info, source, allow_array=not base)
 
diff --git a/scripts/qapi/schema.py b/scripts/qapi/schema.py
index 17525b4216..981d0d659f 100644
--- a/scripts/qapi/schema.py
+++ b/scripts/qapi/schema.py
@@ -721,9 +721,9 @@ class QAPISchemaVariant(QAPISchemaObjectTypeMember):
         self.wrapped = bool(wrapper_type)
         self.wrapper_type = wrapper_type
 
-        # For now, unions are either flat or wrapped, never both
+        # Unions that are both flat and wrapped can look like either one,
+        # depending on Visitor.flat_simple_unions
         assert self.flat or self.wrapped
-        assert not (self.flat and self.wrapped)
 
     def check(self, schema):
         super().check(schema)
@@ -1038,7 +1038,7 @@ class QAPISchema:
     def _make_variant(self, case, typ, ifcond, info):
         return QAPISchemaVariant(case, info, typ, ifcond)
 
-    def _make_simple_variant(self, union_name, case, typ, ifcond, info):
+    def _make_simple_variant(self, union_name, case, typ, ifcond, flat, info):
         if isinstance(typ, list):
             assert len(typ) == 1
             typ = self._make_array_type(typ[0], info)
@@ -1049,7 +1049,14 @@ class QAPISchema:
         wrapper_member = self._make_member('data', typ, None, None, info)
         wrapper_type = QAPISchemaObjectType(wrapper_name, info, None, ifcond,
                                             None, None, [wrapper_member], None)
-        return QAPISchemaVariant(case, info, typ, ifcond, flat=False,
+
+        # Default to allowing flat representation for object types.
+        # Other types require a wrapper, so disable flat for them by default.
+        if flat is None:
+            variant_type = self.resolve_type(typ, info, 'variant type')
+            flat = isinstance(variant_type, QAPISchemaObjectType)
+
+        return QAPISchemaVariant(case, info, typ, ifcond, flat=flat,
                                  wrapper_type=wrapper_type)
 
     def _def_union_type(self, expr, info, doc):
@@ -1070,9 +1077,13 @@ class QAPISchema:
                         for (key, value) in data.items()]
             members = []
         else:
-            variants = [self._make_simple_variant(name, key, value['type'],
-                                                  value.get('if'), info)
-                        for (key, value) in data.items()]
+            variants = [
+                self._make_simple_variant(name, key, value['type'],
+                                          value.get('if'),
+                                          value.get('allow-flat'),
+                                          info)
+                for (key, value) in data.items()
+            ]
             enum = [{'name': v.name, 'if': v.ifcond} for v in variants]
             typ = self._make_implicit_enum_type(name, info, ifcond, enum)
             tag_member = QAPISchemaObjectTypeMember('type', info, typ, False)
diff --git a/scripts/qapi/visit.py b/scripts/qapi/visit.py
index f72567cbcc..9d05d6bd08 100644
--- a/scripts/qapi/visit.py
+++ b/scripts/qapi/visit.py
@@ -127,23 +127,31 @@ bool visit_type_%(c_name)s_members(Visitor *v, %(c_name)s *obj, Error **errp)
                              case=case_str,
                              c_type=var.type.c_name(), c_name=c_name(var.name))
             elif var.wrapped:
+                if var.flat:
+                    cond = "!visit_flat_simple_unions(v)"
+                else:
+                    cond = "true"
                 ret += mcgen('''
     case %(case)s:
     {
         bool ok;
 
-        if (!visit_start_struct(v, "data", NULL, 0, errp)) {
-            return false;
+        if (%(cond)s) {
+            if (!visit_start_struct(v, "data", NULL, 0, errp)) {
+                return false;
+            }
         }
         ok = visit_type_%(c_type)s_members(v, &obj->u.%(c_name)s, errp);
-        if (ok) {
-            ok = visit_check_struct(v, errp);
+        if (%(cond)s) {
+            if (ok) {
+                ok = visit_check_struct(v, errp);
+            }
+            visit_end_struct(v, NULL);
         }
-        visit_end_struct(v, NULL);
         return ok;
     }
 ''',
-                             case=case_str,
+                             case=case_str, cond=cond,
                              c_type=var.type.c_name(), c_name=c_name(var.name))
 
             else:
-- 
2.28.0


