Return-Path: <SRS0=+Fwv=DS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36C21C433E7
	for <qemu-devel@archiver.kernel.org>; Sun, 11 Oct 2020 20:44:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6D58A20578
	for <qemu-devel@archiver.kernel.org>; Sun, 11 Oct 2020 20:44:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XCPIuZoI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D58A20578
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46064 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kRiCG-0003U1-H4
	for qemu-devel@archiver.kernel.org; Sun, 11 Oct 2020 16:44:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57576)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1kRi5R-0001oZ-9E
 for qemu-devel@nongnu.org; Sun, 11 Oct 2020 16:36:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:32448)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1kRi5O-0005XF-KA
 for qemu-devel@nongnu.org; Sun, 11 Oct 2020 16:36:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602448613;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HYWZkMKWHLktsWqLRuW6+7g2bKU6rV7ednfYnjWHwEY=;
 b=XCPIuZoIn15R/aYGSpqsiiF09wZzIcaLySGz19Gzu12bvjovCfwTF0CqXNPSWkaBSCTc5A
 +TnufGqGMGstW2HM9V/KbPYbhg5278/KtJB3mBR/ikaU2QOFH19xFdX0+C5xhSFLyC1SgO
 JeHeIeiFMjkBXjfiSUFAbqXL/7UatC8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-462-TQEGmjTcPP6s_u58-mq1Hg-1; Sun, 11 Oct 2020 16:36:51 -0400
X-MC-Unique: TQEGmjTcPP6s_u58-mq1Hg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7CB1110066FE
 for <qemu-devel@nongnu.org>; Sun, 11 Oct 2020 20:36:50 +0000 (UTC)
Received: from localhost (unknown [10.36.110.19])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4F2B660C05;
 Sun, 11 Oct 2020 20:36:42 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Subject: [PoCv2 09/15] scripts/qapi: add generation of Rust bindings for types
Date: Mon, 12 Oct 2020 00:35:07 +0400
Message-Id: <20201011203513.1621355-10-marcandre.lureau@redhat.com>
In-Reply-To: <20201011203513.1621355-1-marcandre.lureau@redhat.com>
References: <20201011203513.1621355-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
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

Generate high-level idiomatic Rust code for the QAPI types, with to/from
translations for C FFI.

- no conditional support yet

- C FFI types are mapped to higher-level types (char*->String,
  Foo*->Foo, has_foo/foo->Option<foo> etc)

- C enums are simply aliased

- C structures have corresponding Rust structures

- alternate are represented as Rust enum (TODO: to/from conversion)

- variants A are represented as Rust AEnum enums. A AEnum::kind() method
  allows to easily get the variant C kind enum value. The translation code
  also uses a helper enum ACEnum to hold the C pointer variant. There
  might be better ways to achieve the translation, but that one works
  for now.

- unions are represented in a similar way as C, as a struct S with a "u"
  member (since S may have extra 'base' fields). However, the discriminant
  isn't a member of S, as Rust enum variant don't need that.

- lists are represented as Vec and translated thanks to vec_to/from
  translate macros

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 meson.build              |   1 +
 scripts/qapi-gen.py      |   2 +
 scripts/qapi/rs.py       |  78 +++++++
 scripts/qapi/rs_types.py | 447 +++++++++++++++++++++++++++++++++++++++
 4 files changed, 528 insertions(+)
 create mode 100644 scripts/qapi/rs_types.py

diff --git a/meson.build b/meson.build
index b6b8330b97..666e38033e 100644
--- a/meson.build
+++ b/meson.build
@@ -1149,6 +1149,7 @@ qapi_gen_depends = [ meson.source_root() / 'scripts/qapi/__init__.py',
                      meson.source_root() / 'scripts/qapi/common.py',
                      meson.source_root() / 'scripts/qapi/rs.py',
                      meson.source_root() / 'scripts/qapi/rs_sys.py',
+                     meson.source_root() / 'scripts/qapi/rs_types.py',
                      meson.source_root() / 'scripts/qapi-gen.py',
 ]
 
diff --git a/scripts/qapi-gen.py b/scripts/qapi-gen.py
index 5bfe9c8cd1..556bfe9e7b 100644
--- a/scripts/qapi-gen.py
+++ b/scripts/qapi-gen.py
@@ -17,6 +17,7 @@ from qapi.types import gen_types
 from qapi.visit import gen_visit
 
 from qapi.rs_sys import gen_rs_systypes
+from qapi.rs_types import gen_rs_types
 
 def main(argv):
     parser = argparse.ArgumentParser(
@@ -50,6 +51,7 @@ def main(argv):
 
     if args.rust:
         gen_rs_systypes(schema, args.output_dir, args.prefix, args.builtins)
+        gen_rs_types(schema, args.output_dir, args.prefix, args.builtins)
     else:
         gen_types(schema, args.output_dir, args.prefix, args.builtins)
         gen_visit(schema, args.output_dir, args.prefix, args.builtins)
diff --git a/scripts/qapi/rs.py b/scripts/qapi/rs.py
index daa946580b..cab5bb9b72 100644
--- a/scripts/qapi/rs.py
+++ b/scripts/qapi/rs.py
@@ -11,6 +11,8 @@ from qapi.common import *
 from qapi.gen import QAPIGen, QAPISchemaVisitor
 
 
+rs_lists = set()
+
 rs_name_trans = str.maketrans('.-', '__')
 
 # Map @name to a valid Rust identifier.
@@ -42,12 +44,55 @@ def rs_name(name, protect=True):
     return name
 
 
+def rs_type(c_type, ns='qapi::', optional=False):
+    vec = False
+    to_rs = {
+        'char': 'i8',
+        'int8_t': 'i8',
+        'uint8_t': 'u8',
+        'int16_t': 'i16',
+        'uint16_t': 'u16',
+        'int32_t': 'i32',
+        'uint32_t': 'u32',
+        'int64_t': 'i64',
+        'uint64_t': 'u64',
+        'double': 'f64',
+        'bool': 'bool',
+        'str': 'String',
+    }
+    if c_type.startswith('const '):
+        c_type = c_type[6:]
+    if c_type.endswith(pointer_suffix):
+        c_type = c_type.rstrip(pointer_suffix).strip()
+        if c_type.endswith('List'):
+            c_type = c_type[:-4]
+            vec = True
+        else:
+            to_rs = {
+                'char': 'String',
+            }
+
+    if c_type in to_rs:
+        ret = to_rs[c_type]
+    else:
+        ret = ns + c_type
+
+    if vec:
+        ret = 'Vec<%s>' % ret
+    if optional:
+        return 'Option<%s>' % ret
+    else:
+        return ret
+
+
 def rs_ctype_parse(c_type):
     is_pointer = False
     if c_type.endswith(pointer_suffix):
         is_pointer = True
         c_type = c_type.rstrip(pointer_suffix).strip()
     is_list = c_type.endswith('List')
+    if is_list:
+        rs_lists.add(c_type)
     is_const = False
     if c_type.startswith('const '):
         is_const = True
@@ -103,6 +148,39 @@ def to_camel_case(value):
         return value
 
 
+def to_qemu_none(c_type, name):
+    (is_pointer, _, is_list, _) = rs_ctype_parse(c_type)
+
+    if is_pointer:
+        if c_type == 'char':
+            return mcgen('''
+    let %(name)s_ = CString::new(%(name)s).unwrap();
+    let %(name)s = %(name)s_.as_ptr();
+''', name=name)
+        elif is_list:
+            return mcgen('''
+    let %(name)s_ = NewPtr(%(name)s).to_qemu_none();
+    let %(name)s = %(name)s_.0.0;
+''', name=name)
+        else:
+            return mcgen('''
+    let %(name)s_ = %(name)s.to_qemu_none();
+    let %(name)s = %(name)s_.0;
+''', name=name)
+    return ''
+
+
+def from_qemu(var_name, c_type, full=False):
+    (is_pointer, _, is_list, _) = rs_ctype_parse(c_type)
+    ptr = '{} as *{} _'.format(var_name, 'mut' if full else 'const')
+    if is_list:
+        ptr = 'NewPtr({})'.format(ptr)
+    if is_pointer:
+        return 'from_qemu_{}({})'.format('full' if full else 'none', ptr)
+    else:
+        return var_name
+
+
 class QAPIGenRs(QAPIGen):
 
     def __init__(self, fname):
diff --git a/scripts/qapi/rs_types.py b/scripts/qapi/rs_types.py
new file mode 100644
index 0000000000..3a7d8914c8
--- /dev/null
+++ b/scripts/qapi/rs_types.py
@@ -0,0 +1,447 @@
+# This work is licensed under the terms of the GNU GPL, version 2.
+# See the COPYING file in the top-level directory.
+"""
+QAPI Rust types generator
+"""
+
+from qapi.common import *
+from qapi.rs import *
+
+
+objects_seen = set()
+
+
+def gen_rs_variants_enum_kind(name, kind_arms):
+    return mcgen('''
+
+impl %(rs_name)sEnum {
+    pub fn kind(&self) -> %(rs_name)sKind {
+        match self {
+            %(kind_arms)s
+        }
+    }
+}
+''', rs_name=rs_name(name), kind_arms=kind_arms)
+
+
+def gen_rs_variants_to_qemu(name, variants):
+    ret = mcgen('''
+
+pub enum %(rs_name)sCEnum<'a> {
+''', rs_name=rs_name(name))
+
+    none_arms = ''
+    full_arms = ''
+    for var in variants.variants:
+        var_name = to_camel_case(rs_name(var.name, False))
+        type_name = var.type.name
+        if type_name == 'q_empty':
+            continue
+        if type_name.endswith('-wrapper'):
+            type_name = type_name[6:-8]
+        ret += mcgen('''
+    %(var_name)s(<%(rs_type)s as ToQemuPtr<'a, *mut %(rs_systype)s>>::Storage),
+''', var_name=var_name, rs_type=rs_type(type_name, ''), rs_systype=rs_systype(type_name))
+        none_arms += mcgen('''
+             %(rs_name)sEnum::%(var_name)s(v) => {
+                 let stash_ = v.to_qemu_none();
+                 (stash_.0 as *mut std::ffi::c_void, %(rs_name)sCEnum::%(var_name)s(stash_.1))
+             },
+''', rs_name=rs_name(name), var_name=var_name)
+        full_arms += mcgen('''
+             %(rs_name)sEnum::%(var_name)s(v) => {
+                 let ptr = v.to_qemu_full();
+                 ptr as *mut std::ffi::c_void
+             },
+''', rs_name=rs_name(name), var_name=var_name)
+
+    ret += mcgen('''
+}
+
+impl QemuPtrDefault for %(rs_name)sEnum {
+    type QemuType = *mut std::ffi::c_void;
+}
+
+impl<'a> ToQemuPtr<'a, *mut std::ffi::c_void> for %(rs_name)sEnum {
+    type Storage = %(rs_name)sCEnum<'a>;
+
+    #[inline]
+    fn to_qemu_none(&'a self) -> Stash<'a, *mut std::ffi::c_void, %(rs_name)sEnum> {
+        let (ptr_, cenum_) = match self {
+             %(none_arms)s
+        };
+
+        Stash(ptr_, cenum_)
+    }
+
+    #[inline]
+    fn to_qemu_full(&self) -> *mut std::ffi::c_void {
+        match self {
+            %(full_arms)s
+        }
+    }
+}
+''', rs_name=rs_name(name), none_arms=none_arms, full_arms=full_arms)
+    return ret
+
+
+def gen_rs_variants(name, variants):
+    ret = mcgen('''
+
+#[derive(Clone,Debug)]
+pub enum %(rs_name)sEnum {
+''', rs_name=rs_name(name))
+
+    kind_arms = ''
+    for var in variants.variants:
+        if var.ifcond:
+            raise NotImplementedError("ifcond are not implemented")
+        type_name = var.type.name
+        var_name = to_camel_case(rs_name(var.name, False))
+        if type_name == 'q_empty':
+            continue
+        if type_name.endswith('-wrapper'):
+            type_name = type_name[6:-8] # remove q_obj*-wrapper
+        kind_arms += mcgen('''
+        Self::%(var_name)s(_) => { %(rs_name)sKind::%(var_name)s },
+''', var_name=var_name, rs_name=rs_name(name))
+        ret += mcgen('''
+    %(var_name)s(%(rs_type)s),
+''', var_name=var_name, rs_type=rs_type(type_name, ''))
+
+    ret += mcgen('''
+}
+''')
+
+    ret += gen_rs_variants_enum_kind(name, kind_arms)
+    ret += gen_rs_variants_to_qemu(name, variants)
+    # TODO FromQemu
+    return ret
+
+
+def gen_rs_object_to_qemu(name, base, members, variants):
+    storage = []
+    stash = []
+    sys_memb = []
+    memb_none = ''
+    memb_full = ''
+    for memb in members:
+        memb_name = rs_name(memb.name)
+        c_type = memb.type.c_type()
+        (is_pointer, _, is_list, _) = rs_ctype_parse(c_type)
+        if is_pointer:
+            t = rs_type(memb.type.c_type(), optional=memb.optional, ns='')
+            p = rs_systype(memb.type.c_type(), list_as_newp=True)
+            s = "Stash<'a, %s, %s>" % (p, t)
+            storage.append(s)
+        if memb.optional:
+            has_memb_name = 'has_%s' % rs_name(memb.name, protect=False)
+            sys_memb.append(has_memb_name)
+            has_memb = mcgen('''
+    let %(has_memb_name)s = self.%(memb_name)s.is_some();
+''', memb_name=memb_name, has_memb_name=has_memb_name)
+            memb_none += has_memb
+            memb_full += has_memb
+
+        if is_pointer:
+            stash_name = '{}_stash_'.format(memb_name)
+            stash.append(stash_name)
+            var = 'NewPtr({})'.format(memb_name) if is_list else memb_name
+            memb_none += mcgen('''
+    let %(stash_name)s = self.%(memb_name)s.to_qemu_none();
+    let %(var)s = %(stash_name)s.0;
+''', stash_name=stash_name, memb_name=memb_name, var=var)
+            memb_full += mcgen('''
+    let %(var)s = self.%(memb_name)s.to_qemu_full();
+''', memb_name=memb_name, var=var)
+        else:
+            unwrap = ''
+            if memb.optional:
+                unwrap = '.unwrap_or_default()'
+            memb = mcgen('''
+    let %(memb_name)s = self.%(memb_name)s%(unwrap)s;
+''', memb_name=memb_name, unwrap=unwrap)
+            memb_none += memb
+            memb_full += memb
+
+        sys_memb.append(memb_name)
+
+    if variants:
+        tag_name = rs_name(variants.tag_member.name)
+        sys_memb.append(tag_name)
+        sys_memb.append('u')
+        p = '*mut std::ffi::c_void'
+        s = "Stash<'a, %s, %sEnum>" % (p, name)
+        storage.append(s)
+        tag = mcgen('''
+    let %(tag_name)s = self.u.kind();
+''', sys=rs_systype(name), tag_name=tag_name)
+        memb_none += tag
+        memb_full += tag
+        arms = ''
+        for var in variants.variants:
+            if var.type.name == 'q_empty':
+                continue
+            arms += mcgen('%(rs_name)sEnum::%(kind_name)s(_) => qapi_sys::%(rs_name)sUnion { %(var_name)s: %(var_type)s { data: u_ptr_ as *mut _ } },',
+                          rs_name=rs_name(name), kind_name=to_camel_case(var.name), var_name=rs_name(var.name), var_type=rs_systype(var.type.c_name()))
+        memb_none += mcgen('''
+    let u_stash_ = self.u.to_qemu_none();
+    let u_ptr_ = u_stash_.0;
+    let u = match self.u {
+        %(arms)s
+    };
+''', arms=arms)
+        stash.append('u_stash_')
+        memb_full += mcgen('''
+    let u_ptr_ = self.u.to_qemu_full();
+    let u = match self.u {
+        %(arms)s
+    };
+''', arms=arms)
+
+    return mcgen('''
+
+impl QemuPtrDefault for %(rs_name)s {
+    type QemuType = *mut qapi_sys::%(rs_name)s;
+}
+
+impl<'a> ToQemuPtr<'a, *mut qapi_sys::%(rs_name)s> for %(rs_name)s {
+    type Storage = (Box<qapi_sys::%(rs_name)s>, %(storage)s);
+
+    #[inline]
+    fn to_qemu_none(&'a self) -> Stash<'a, *mut qapi_sys::%(rs_name)s, %(rs_name)s> {
+        %(memb_none)s
+        let mut box_ = Box::new(qapi_sys::%(rs_name)s { %(sys_memb)s });
+
+        Stash(&mut *box_, (box_, %(stash)s))
+    }
+
+    #[inline]
+    fn to_qemu_full(&self) -> *mut qapi_sys::%(rs_name)s {
+        unsafe {
+            %(memb_full)s
+            let ptr = sys::g_malloc0(std::mem::size_of::<*const %(rs_name)s>()) as *mut _;
+            *ptr = qapi_sys::%(rs_name)s { %(sys_memb)s };
+            ptr
+        }
+    }
+}
+''',
+                 rs_name=rs_name(name), storage=', '.join(storage),
+                 sys_memb=', '.join(sys_memb), memb_none=memb_none, memb_full=memb_full, stash=', '.join(stash))
+
+
+def gen_rs_object_from_qemu(name, base, members, variants):
+    memb_names = []
+    if base:
+        memb_names.extend([rs_name(memb.name) for memb in base.members])
+    memb_names.extend([rs_name(memb.name) for memb in members])
+
+    ret = mcgen('''
+}
+
+impl FromQemuPtrFull<*mut qapi_sys::%(rs_name)s> for %(rs_name)s {
+    unsafe fn from_qemu_full(sys: *mut qapi_sys::%(rs_name)s) -> Self {
+        let ret = from_qemu_none(sys as *const _);
+        qapi_sys::qapi_free_%(rs_name)s(sys);
+        ret
+    }
+}
+
+impl FromQemuPtrNone<*const qapi_sys::%(rs_name)s> for %(rs_name)s {
+    unsafe fn from_qemu_none(sys: *const qapi_sys::%(rs_name)s) -> Self {
+        let sys = & *sys;
+''', rs_name=rs_name(name))
+
+    for memb in members:
+        memb_name = rs_name(memb.name)
+        val = from_qemu('sys.' + memb_name, memb.type.c_type())
+        if memb.optional:
+            val = mcgen('''{
+            if sys.has_%(memb_name)s {
+                Some(%(val)s)
+            } else {
+                None
+            }
+}''', memb_name=rs_name(memb.name, protect=False), val=val)
+
+        ret += mcgen('''
+        let %(memb_name)s = %(val)s;
+''', memb_name=memb_name, val=val)
+
+    if variants:
+        arms = ''
+        for variant in variants.tag_member.type.member_names():
+            arms += mcgen('''
+            %(enum)s::%(variant)s => { %(rs_name)sEnum::%(variant)s(from_qemu_none(sys.u.%(memb)s.data as *const _)) },
+''', enum=variants.tag_member.type.name, memb=rs_name(variant),
+                          variant=to_camel_case(variant), rs_name=rs_name(name))
+        ret += mcgen('''
+        let u = match sys.%(tag)s {
+            %(arms)s
+            _ => panic!("Variant with invalid tag"),
+        };
+''', tag=rs_name(variants.tag_member.name), arms=arms)
+        memb_names.append('u')
+
+    ret += mcgen('''
+            Self { %(memb_names)s }
+        }
+}
+''', rs_name=rs_name(name), memb_names=', '.join(memb_names))
+    return ret
+
+
+def gen_struct_members(members):
+    ret = ''
+    for memb in members:
+        if memb.ifcond:
+            raise NotImplementedError("ifcond are not implemented")
+        rsname = rs_name(memb.name)
+        ret += mcgen('''
+    pub %(rs_name)s: %(rs_type)s,
+''',
+                     rs_type=rs_type(memb.type.c_type(), '', optional=memb.optional), rs_name=rsname)
+    return ret
+
+
+def gen_rs_object(name, base, members, variants):
+    if name in objects_seen:
+        return ''
+
+    if variants:
+        members = [m for m in members if m.name != variants.tag_member.name]
+
+    ret = ''
+    objects_seen.add(name)
+
+    if variants:
+        ret += gen_rs_variants(name, variants)
+
+    ret += mcgen('''
+
+#[derive(Clone, Debug)]
+pub struct %(rs_name)s {
+''',
+                 rs_name=rs_name(name))
+
+    if base:
+        if not base.is_implicit():
+            ret += mcgen('''
+    // Members inherited:
+''',
+                         c_name=base.c_name())
+        ret += gen_struct_members(base.members)
+        if not base.is_implicit():
+            ret += mcgen('''
+    // Own members:
+''')
+
+    ret += gen_struct_members(members)
+
+    if variants:
+        ret += mcgen('''
+    pub u: %(rs_type)sEnum,
+''', rs_type=name)
+
+    ret += gen_rs_object_from_qemu(name, base, members, variants)
+    ret += gen_rs_object_to_qemu(name, base, members, variants)
+    return ret
+
+
+def gen_rs_alternate(name, variants):
+    if name in objects_seen:
+        return ''
+
+    ret = ''
+    objects_seen.add(name)
+
+    ret += mcgen('''
+
+#[derive(Clone,Debug)]
+pub enum %(rs_name)s {
+''',
+                 rs_name=rs_name(name))
+
+    for var in variants.variants:
+        if var.ifcond:
+            raise NotImplementedError("ifcond are not implemented")
+        if var.type.name == 'q_empty':
+            continue
+        ret += mcgen('''
+        %(mem_name)s(%(rs_type)s),
+''',
+                     rs_type=rs_type(var.type.c_unboxed_type(), ''),
+                     mem_name=to_camel_case(rs_name(var.name)))
+    ret += mcgen('''
+}
+''')
+    # TODO: add to/from conversion
+    return ret
+
+
+def gen_rs_enum(name):
+        return mcgen('''
+
+pub type %(rs_name)s = qapi_sys::%(rs_name)s;
+''', rs_name=rs_name(name))
+
+
+class QAPISchemaGenRsTypeVisitor(QAPISchemaRsVisitor):
+
+    def __init__(self, prefix):
+        super().__init__(prefix, 'qapi-types')
+
+    def visit_begin(self, schema):
+        # gen_object() is recursive, ensure it doesn't visit the empty type
+        objects_seen.add(schema.the_empty_object_type.name)
+        self._gen.preamble_add(
+            mcgen('''
+// generated by qapi-gen, DO NOT EDIT
+
+use crate::qapi_sys;
+
+'''))
+
+    def visit_end(self):
+        for name in rs_lists:
+            self._gen.add(mcgen('''
+
+vec_from_qemu!(%(rs)s, %(sys)s, qapi_free_%(sys)s);
+vec_to_qemu!(%(rs)s, %(sys)s);
+''', sys=name, rs=name[:-4]))
+
+    def visit_command(self, name, info, ifcond, features,
+                      arg_type, ret_type, gen, success_response, boxed,
+                      allow_oob, allow_preconfig, coroutine):
+        if ifcond:
+            raise NotImplementedError("ifcond are not implemented")
+        if not gen:
+            return
+        # call from_qemu() to eventually register a list
+        if ret_type:
+            from_qemu('', ret_type.c_type())
+
+    def visit_object_type(self, name, info, ifcond, features,
+                          base, members, variants):
+        if ifcond:
+            raise NotImplementedError("ifcond are not implemented")
+        if name.startswith('q_'):
+            return
+        self._gen.add(gen_rs_object(name, base, members, variants))
+
+    def visit_enum_type(self, name, info, ifcond, features, members, prefix):
+        if ifcond:
+            raise NotImplementedError("ifcond are not implemented")
+        self._gen.add(gen_rs_enum(name))
+
+    def visit_alternate_type(self, name, info, ifcond, features, variants):
+        if ifcond:
+            raise NotImplementedError("ifcond are not implemented")
+        self._gen.add(gen_rs_alternate(name, variants))
+
+
+def gen_rs_types(schema, output_dir, prefix, opt_builtins):
+    vis = QAPISchemaGenRsTypeVisitor(prefix)
+    schema.visit(vis)
+    vis.write(output_dir)
-- 
2.28.0


