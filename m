Return-Path: <SRS0=+Fwv=DS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74E0DC433DF
	for <qemu-devel@archiver.kernel.org>; Sun, 11 Oct 2020 20:44:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ED07420578
	for <qemu-devel@archiver.kernel.org>; Sun, 11 Oct 2020 20:44:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G+MNG+0Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED07420578
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48834 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kRiDB-0004eu-2Y
	for qemu-devel@archiver.kernel.org; Sun, 11 Oct 2020 16:44:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57498)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1kRi57-0001Lz-0I
 for qemu-devel@nongnu.org; Sun, 11 Oct 2020 16:36:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:48402)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1kRi54-0005Vg-5S
 for qemu-devel@nongnu.org; Sun, 11 Oct 2020 16:36:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602448593;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=//HZmmfSPMGK7ml0gSGQZp5T/TptKbriYwAwFbDujNk=;
 b=G+MNG+0ZC3lP0EYoWpqrkASKhIwdcZPfYLd/qU87zavq2VvS4gCwQ35SsWLsyqVqbj4cV4
 0gO8EOQGqwFen4XXmIJRU8cTf+dq8A5xsnUP2qkxiVEnFRng4x3IoIo0lonLEhiFYW2D0W
 RN0nXGBLbbt51gCY3x/9f3DhsLgInY4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-262-F5R_kDxNOm-V_xii7kjIeg-1; Sun, 11 Oct 2020 16:36:30 -0400
X-MC-Unique: F5R_kDxNOm-V_xii7kjIeg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 44F1D10066FB
 for <qemu-devel@nongnu.org>; Sun, 11 Oct 2020 20:36:29 +0000 (UTC)
Received: from localhost (unknown [10.36.110.19])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C7F106EF7E;
 Sun, 11 Oct 2020 20:36:21 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Subject: [PoCv2 07/15] scripts/qapi: add Rust sys bindings generation
Date: Mon, 12 Oct 2020 00:35:05 +0400
Message-Id: <20201011203513.1621355-8-marcandre.lureau@redhat.com>
In-Reply-To: <20201011203513.1621355-1-marcandre.lureau@redhat.com>
References: <20201011203513.1621355-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=marcandre.lureau@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/11 16:23:51
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: pbonzini@redhat.com, berrange@redhat.com, armbru@redhat.com,
 stefanha@redhat.com,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Generate the C QAPI types in Rust, with a few common niceties to
Debug/Clone/Copy the Rust type.

An important question that remains unsolved to be usable with the QEMU
schema in this version, is the handling of the 'if' compilation
conditions. Since the 'if' value is a C pre-processor condition, it is
hard to evaluate from Rust (we could implement a minimalistic CPP
evaluator, or invoke CPP and somehow parse the output...).

The normal Rust way of handling conditional compilation is via #[cfg]
features, which rely on feature arguments being passed to rustc from
Cargo. This would require a long Rust feature list, and new 'if-cfg'
conditions in the schema (an idea would be for Cargo to read features
from meson in the future?)

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 meson.build            |   4 +-
 scripts/qapi-gen.py    |  16 ++-
 scripts/qapi/rs.py     | 126 ++++++++++++++++++++
 scripts/qapi/rs_sys.py | 254 +++++++++++++++++++++++++++++++++++++++++
 4 files changed, 394 insertions(+), 6 deletions(-)
 create mode 100644 scripts/qapi/rs.py
 create mode 100644 scripts/qapi/rs_sys.py

diff --git a/meson.build b/meson.build
index c30bb290c5..b6b8330b97 100644
--- a/meson.build
+++ b/meson.build
@@ -1147,7 +1147,9 @@ qapi_gen_depends = [ meson.source_root() / 'scripts/qapi/__init__.py',
                      meson.source_root() / 'scripts/qapi/types.py',
                      meson.source_root() / 'scripts/qapi/visit.py',
                      meson.source_root() / 'scripts/qapi/common.py',
-                     meson.source_root() / 'scripts/qapi-gen.py'
+                     meson.source_root() / 'scripts/qapi/rs.py',
+                     meson.source_root() / 'scripts/qapi/rs_sys.py',
+                     meson.source_root() / 'scripts/qapi-gen.py',
 ]
 
 tracetool = [
diff --git a/scripts/qapi-gen.py b/scripts/qapi-gen.py
index 541e8c1f55..5bfe9c8cd1 100644
--- a/scripts/qapi-gen.py
+++ b/scripts/qapi-gen.py
@@ -16,10 +16,13 @@ from qapi.schema import QAPIError, QAPISchema
 from qapi.types import gen_types
 from qapi.visit import gen_visit
 
+from qapi.rs_sys import gen_rs_systypes
 
 def main(argv):
     parser = argparse.ArgumentParser(
         description='Generate code from a QAPI schema')
+    parser.add_argument('-r', '--rust', action='store_true',
+                        help="generate Rust code")
     parser.add_argument('-b', '--builtins', action='store_true',
                         help="generate code for built-in types")
     parser.add_argument('-o', '--output-dir', action='store', default='',
@@ -45,11 +48,14 @@ def main(argv):
         print(err, file=sys.stderr)
         exit(1)
 
-    gen_types(schema, args.output_dir, args.prefix, args.builtins)
-    gen_visit(schema, args.output_dir, args.prefix, args.builtins)
-    gen_commands(schema, args.output_dir, args.prefix)
-    gen_events(schema, args.output_dir, args.prefix)
-    gen_introspect(schema, args.output_dir, args.prefix, args.unmask)
+    if args.rust:
+        gen_rs_systypes(schema, args.output_dir, args.prefix, args.builtins)
+    else:
+        gen_types(schema, args.output_dir, args.prefix, args.builtins)
+        gen_visit(schema, args.output_dir, args.prefix, args.builtins)
+        gen_commands(schema, args.output_dir, args.prefix)
+        gen_events(schema, args.output_dir, args.prefix)
+        gen_introspect(schema, args.output_dir, args.prefix, args.unmask)
 
 
 if __name__ == '__main__':
diff --git a/scripts/qapi/rs.py b/scripts/qapi/rs.py
new file mode 100644
index 0000000000..daa946580b
--- /dev/null
+++ b/scripts/qapi/rs.py
@@ -0,0 +1,126 @@
+# This work is licensed under the terms of the GNU GPL, version 2.
+# See the COPYING file in the top-level directory.
+"""
+QAPI Rust generator
+"""
+
+import os
+import subprocess
+
+from qapi.common import *
+from qapi.gen import QAPIGen, QAPISchemaVisitor
+
+
+rs_name_trans = str.maketrans('.-', '__')
+
+# Map @name to a valid Rust identifier.
+# If @protect, avoid returning certain ticklish identifiers (like
+# keywords) by prepending raw identifier prefix 'r#'.
+def rs_name(name, protect=True):
+    name = name.translate(rs_name_trans)
+    if name[0].isnumeric():
+        name = '_' + name
+    if not protect:
+        return name
+    # based from the list:
+    # https://doc.rust-lang.org/reference/keywords.html
+    if name in ('Self', 'abstract', 'as', 'async',
+                'await','become', 'box', 'break',
+                'const', 'continue', 'crate', 'do',
+                'dyn', 'else', 'enum', 'extern',
+                'false', 'final', 'fn', 'for',
+                'if', 'impl', 'in', 'let',
+                'loop', 'macro', 'match', 'mod',
+                'move', 'mut', 'override', 'priv',
+                'pub', 'ref', 'return', 'self',
+                'static', 'struct', 'super', 'trait',
+                'true', 'try', 'type', 'typeof',
+                'union', 'unsafe', 'unsized', 'use',
+                'virtual', 'where', 'while', 'yield',
+                ):
+        name = 'r#' + name
+    return name
+
+
+def rs_ctype_parse(c_type):
+    is_pointer = False
+    if c_type.endswith(pointer_suffix):
+        is_pointer = True
+        c_type = c_type.rstrip(pointer_suffix).strip()
+    is_list = c_type.endswith('List')
+    is_const = False
+    if c_type.startswith('const '):
+        is_const = True
+        c_type = c_type[6:]
+
+    return (is_pointer, is_const, is_list, c_type)
+
+
+def rs_systype(c_type, sys_ns='qapi_sys::', list_as_newp=False):
+    (is_pointer, is_const, is_list, c_type) = rs_ctype_parse(c_type)
+
+    to_rs = {
+        'char': 'libc::c_char',
+        'int8_t': 'i8',
+        'uint8_t': 'u8',
+        'int16_t': 'i16',
+        'uint16_t': 'u16',
+        'int32_t': 'i32',
+        'uint32_t': 'u32',
+        'int64_t': 'libc::c_longlong',
+        'uint64_t': 'libc::c_ulonglong',
+        'double': 'libc::c_double',
+        'bool': 'bool',
+    }
+
+    rs = ''
+    if is_const and is_pointer:
+        rs += '*const '
+    elif is_pointer:
+        rs += '*mut '
+    if c_type in to_rs:
+        rs += to_rs[c_type]
+    else:
+        rs += sys_ns + c_type
+
+    if is_list and list_as_newp:
+        rs = 'NewPtr<{}>'.format(rs)
+
+    return rs
+
+
+def to_camel_case(value):
+    if value[0] == '_':
+        return value
+    raw_id = False
+    if value.startswith('r#'):
+        raw_id = True
+        value = value[2:]
+    value = ''.join(word.title() for word in filter(None, re.split("[-_]+", value)))
+    if raw_id:
+        return 'r#' + value
+    else:
+        return value
+
+
+class QAPIGenRs(QAPIGen):
+
+    def __init__(self, fname):
+        super().__init__(fname)
+
+
+class QAPISchemaRsVisitor(QAPISchemaVisitor):
+
+    def __init__(self, prefix, what):
+        self._prefix = prefix
+        self._what = what
+        self._gen = QAPIGenRs(self._prefix + self._what + '.rs')
+
+    def write(self, output_dir):
+        self._gen.write(output_dir)
+
+        pathname = os.path.join(output_dir, self._gen.fname)
+        try:
+            subprocess.check_call(['rustfmt', pathname])
+        except FileNotFoundError:
+            pass
diff --git a/scripts/qapi/rs_sys.py b/scripts/qapi/rs_sys.py
new file mode 100644
index 0000000000..551a910c57
--- /dev/null
+++ b/scripts/qapi/rs_sys.py
@@ -0,0 +1,254 @@
+# This work is licensed under the terms of the GNU GPL, version 2.
+# See the COPYING file in the top-level directory.
+"""
+QAPI Rust sys/ffi generator
+"""
+
+from qapi.common import *
+from qapi.rs import *
+from qapi.schema import QAPISchemaEnumMember, QAPISchemaObjectType
+
+
+objects_seen = set()
+
+
+def gen_rs_sys_enum(name, ifcond, members, prefix=None):
+    if ifcond:
+        raise NotImplementedError("ifcond are not implemented")
+    # append automatically generated _max value
+    enum_members = members + [QAPISchemaEnumMember('_MAX', None)]
+
+    ret = mcgen('''
+
+#[derive(Copy, Clone, Debug, PartialEq, Eq)]
+#[repr(C)]
+pub enum %(rs_name)s {
+''',
+    rs_name=rs_name(name))
+
+    for m in enum_members:
+        if m.ifcond:
+            raise NotImplementedError("ifcond are not implemented")
+        ret += mcgen('''
+    %(c_enum)s,
+''',
+                     c_enum=to_camel_case(rs_name(m.name, False)))
+    ret += mcgen('''
+}
+''')
+    return ret
+
+
+def gen_rs_sys_struct_members(members):
+    ret = ''
+    for memb in members:
+        if memb.ifcond:
+            raise NotImplementedError("ifcond are not implemented")
+        if memb.optional:
+            ret += mcgen('''
+    pub has_%(rs_name)s: bool,
+''',
+                         rs_name=rs_name(memb.name, protect=False))
+        ret += mcgen('''
+    pub %(rs_name)s: %(rs_systype)s,
+''',
+                     rs_systype=rs_systype(memb.type.c_type(), ''), rs_name=rs_name(memb.name))
+    return ret
+
+
+def gen_rs_sys_free(ty):
+    return mcgen('''
+
+extern "C" {
+    pub fn qapi_free_%(ty)s(obj: *mut %(ty)s);
+}
+''', ty=ty)
+
+
+def gen_rs_sys_variants(name, variants):
+    ret = mcgen('''
+
+#[repr(C)]
+#[derive(Copy, Clone)]
+pub union %(rs_name)s { /* union tag is @%(tag_name)s */
+''',
+                tag_name=rs_name(variants.tag_member.name),
+                rs_name=name)
+
+    for var in variants.variants:
+        if var.ifcond:
+            raise NotImplementedError("ifcond are not implemented")
+        if var.type.name == 'q_empty':
+            continue
+        ret += mcgen('''
+    pub %(rs_name)s: %(rs_systype)s,
+''',
+                     rs_systype=rs_systype(var.type.c_unboxed_type(), ''),
+                     rs_name=rs_name(var.name))
+
+    ret += mcgen('''
+}
+
+impl ::std::fmt::Debug for %(rs_name)s {
+    fn fmt(&self, f: &mut ::std::fmt::Formatter) -> ::std::fmt::Result {
+        f.debug_struct(&format!("%(rs_name)s @ {:?}", self as *const _))
+            .finish()
+    }
+}
+''', rs_name=name)
+
+    return ret
+
+
+def gen_rs_sys_object(name, ifcond, base, members, variants):
+    if ifcond:
+        raise NotImplementedError("ifcond are not implemented")
+    if name in objects_seen:
+        return ''
+
+    ret = ''
+    objects_seen.add(name)
+    unionty = name + 'Union'
+    if variants:
+        for v in variants.variants:
+            if v.ifcond:
+                raise NotImplementedError("ifcond are not implemented")
+            if isinstance(v.type, QAPISchemaObjectType):
+                ret += gen_rs_sys_object(v.type.name, v.type.ifcond, v.type.base,
+                                         v.type.local_members, v.type.variants)
+        ret += gen_rs_sys_variants(unionty, variants)
+
+    ret += gen_rs_sys_free(rs_name(name))
+    ret += mcgen('''
+
+#[repr(C)]
+#[derive(Copy, Clone, Debug)]
+pub struct %(rs_name)s {
+''',
+                 rs_name=rs_name(name))
+
+    if base:
+        if not base.is_implicit():
+            ret += mcgen('''
+    // Members inherited:
+''')
+        ret += gen_rs_sys_struct_members(base.members)
+        if not base.is_implicit():
+            ret += mcgen('''
+    // Own members:
+''')
+
+    ret += gen_rs_sys_struct_members(members)
+    if variants:
+        ret += mcgen('''
+        pub u: %(unionty)s
+''', unionty=unionty)
+    ret += mcgen('''
+}
+''')
+    return ret
+
+
+def gen_rs_sys_variant(name, ifcond, variants):
+    if ifcond:
+        raise NotImplementedError("ifcond are not implemented")
+    if name in objects_seen:
+        return ''
+
+    objects_seen.add(name)
+
+    vs = ''
+    for var in variants.variants:
+        if var.type.name == 'q_empty':
+            continue
+        vs += mcgen('''
+    pub %(mem_name)s: %(rs_systype)s,
+''',
+                     rs_systype=rs_systype(var.type.c_unboxed_type(), ''),
+                     mem_name=rs_name(var.name))
+
+    return mcgen('''
+
+#[repr(C)]
+#[derive(Copy,Clone)]
+pub union %(rs_name)sUnion {
+    %(variants)s
+}
+
+impl ::std::fmt::Debug for %(rs_name)sUnion {
+    fn fmt(&self, f: &mut ::std::fmt::Formatter) -> ::std::fmt::Result {
+        f.debug_struct(&format!("%(rs_name)sUnion @ {:?}", self as *const _))
+            .finish()
+    }
+}
+
+#[repr(C)]
+#[derive(Copy,Clone,Debug)]
+pub struct %(rs_name)s {
+    pub ty: QType,
+    pub u: %(rs_name)sUnion,
+}
+''',
+                 rs_name=rs_name(name), variants=vs)
+
+
+def gen_rs_sys_array(name, ifcond, element_type):
+    if ifcond:
+        raise NotImplementedError("ifcond are not implemented")
+    ret = mcgen('''
+
+#[repr(C)]
+#[derive(Copy,Clone)]
+pub struct %(rs_name)s {
+    pub next: *mut %(rs_name)s,
+    pub value: %(rs_systype)s,
+}
+
+impl ::std::fmt::Debug for %(rs_name)s {
+    fn fmt(&self, f: &mut ::std::fmt::Formatter) -> ::std::fmt::Result {
+        f.debug_struct(&format!("%(rs_name)s @ {:?}", self as *const _))
+            .finish()
+    }
+}
+''',
+                 rs_name=rs_name(name), rs_systype=rs_systype(element_type.c_type(), ''))
+    ret += gen_rs_sys_free(rs_name(name))
+    return ret
+
+
+class QAPISchemaGenRsSysTypeVisitor(QAPISchemaRsVisitor):
+
+    def __init__(self, prefix):
+        super().__init__(prefix, 'qapi-sys-types')
+
+    def visit_begin(self, schema):
+        # gen_object() is recursive, ensure it doesn't visit the empty type
+        objects_seen.add(schema.the_empty_object_type.name)
+        self._gen.preamble_add(
+            mcgen('''
+// generated by qapi-gen, DO NOT EDIT
+
+use common::sys::{QNull, QObject};
+
+'''))
+
+    def visit_enum_type(self, name, info, ifcond, features, members, prefix):
+        self._gen.add(gen_rs_sys_enum(name, ifcond, members, prefix))
+
+    def visit_array_type(self, name, info, ifcond, element_type):
+        self._gen.add(gen_rs_sys_array(name, ifcond, element_type))
+
+    def visit_object_type(self, name, info, ifcond, features,
+                          base, members, variants):
+        if name.startswith('q_'):
+            return
+        self._gen.add(gen_rs_sys_object(name, ifcond, base, members, variants))
+
+    def visit_alternate_type(self, name, info, ifcond, features, variants):
+        self._gen.add(gen_rs_sys_variant(name, ifcond, variants))
+
+
+def gen_rs_systypes(schema, output_dir, prefix, opt_builtins):
+    vis = QAPISchemaGenRsSysTypeVisitor(prefix)
+    schema.visit(vis)
+    vis.write(output_dir)
-- 
2.28.0


