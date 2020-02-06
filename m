Return-Path: <SRS0=rlpO=32=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F599C33CAC
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 17:50:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF69820659
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 17:50:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="URAL6PBe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF69820659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43792 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izlIc-0005HR-17
	for qemu-devel@archiver.kernel.org; Thu, 06 Feb 2020 12:50:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43717)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1izl0E-00076T-EM
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 12:31:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1izl0B-0007JN-TR
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 12:31:46 -0500
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:45392)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1izl0B-0007ES-Iq
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 12:31:43 -0500
Received: by mail-wr1-x442.google.com with SMTP id a6so8165428wrx.12
 for <qemu-devel@nongnu.org>; Thu, 06 Feb 2020 09:31:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=De2wmukXywbOCB6BvE2Tm39fg1QJNVUGNIoqYOFA1D8=;
 b=URAL6PBeeD9a92918b1Gau8IfxinhB7yb2xxpkK0zkfodhnWjOKlsxUCzVzm4clG7W
 iEc24+h5lrzlZEr2Eb1glo0Nn9ThzKIGnMhqc+j1XaQX33hd5ahbUHqkklbUciwctawm
 cEMs8lGKFdaJSBiZqguPltWjNk8Vw7kwW58YwCgqOnx1PbrSMQ3AqOM8OcE5MKpxYy07
 LQ+wPZYZtMk3ppWwr/P7MGgsxvcr4zFKuEZyqXu9EujxlqQPcrDWTe/NskpuCJvJe50x
 WGf6AfWX3Zg0Nz+XELbOaImC+Kx9897necJniNdbRJs6voeDv1oOnhU0OXgvW2EfyjU6
 ZeiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=De2wmukXywbOCB6BvE2Tm39fg1QJNVUGNIoqYOFA1D8=;
 b=DnT+uhyGZ8C768h8XjVUYTOQcKuoGb1fcCzEIcmpRwO+3cOWFMkB2rfOBtB1oNS4e5
 uuy4xwkMGL493JZ5Y4XMPOdLOp7Bsq4i0gkLTJg7Efwxij/2JqAe7K/gGZ+i4Hq7NHW0
 rfNlMRXIYkA/Ym1i/6gluaSxdO3C6AR4Sa7nBXErzgJFlLXwOwgpkrs+ru2vPyg5gHJa
 CBd9OwJ0csFikjt1vIQvv08H4ctbthjnxKQiZ/vrR4aCOtUmrNV5/UVTClpiHvp70w1H
 1GSLNkl+lq4FWE/xVnI3ZUgTrY1yHp9vl467kZ1XT1GeSYCr0JIQvwpBYbdstifEzPtR
 qJlg==
X-Gm-Message-State: APjAAAW5EK6ZM7nbxJyBNi61kqg/G6nw0lJH3xAAfAPn9hTf5nfPv1sx
 Wi9r0EdlcGWFj4102N9ZhrJb+Z38Xxc=
X-Google-Smtp-Source: APXvYqzd8dke85mytdcs4ITI4eBbzjFd72eItfuNwLKOOVAASyPfb52bMJP93mhdWNRYtXP4eK5Yaw==
X-Received: by 2002:adf:f1c6:: with SMTP id z6mr4640238wro.279.1581010301883; 
 Thu, 06 Feb 2020 09:31:41 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id w15sm5204214wrs.80.2020.02.06.09.31.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Feb 2020 09:31:41 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 28/29] scripts/qapi: Remove texinfo generation support
Date: Thu,  6 Feb 2020 17:30:39 +0000
Message-Id: <20200206173040.17337-29-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200206173040.17337-1-peter.maydell@linaro.org>
References: <20200206173040.17337-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
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
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Michael Roth <mdroth@linux.vnet.ibm.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We no longer use the generated texinfo format documentation,
so delete the code that generates it, and the test case for
the generation.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 Makefile               |   1 -
 tests/Makefile.include |  15 +-
 scripts/qapi-gen.py    |   2 -
 scripts/qapi/doc.py    | 303 -----------------------------------------
 scripts/qapi/gen.py    |   7 -
 5 files changed, 1 insertion(+), 327 deletions(-)
 delete mode 100644 scripts/qapi/doc.py

diff --git a/Makefile b/Makefile
index 159ac78dd24..8213dfec013 100644
--- a/Makefile
+++ b/Makefile
@@ -595,7 +595,6 @@ qemu-keymap$(EXESUF): QEMU_CFLAGS += $(XKBCOMMON_CFLAGS)
 qapi-py = $(SRC_PATH)/scripts/qapi/__init__.py \
 $(SRC_PATH)/scripts/qapi/commands.py \
 $(SRC_PATH)/scripts/qapi/common.py \
-$(SRC_PATH)/scripts/qapi/doc.py \
 $(SRC_PATH)/scripts/qapi/error.py \
 $(SRC_PATH)/scripts/qapi/events.py \
 $(SRC_PATH)/scripts/qapi/expr.py \
diff --git a/tests/Makefile.include b/tests/Makefile.include
index 2f1cafed720..ee766a77091 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -32,7 +32,6 @@ export SRC_PATH
 qapi-py = $(SRC_PATH)/scripts/qapi/__init__.py \
 $(SRC_PATH)/scripts/qapi/commands.py \
 $(SRC_PATH)/scripts/qapi/common.py \
-$(SRC_PATH)/scripts/qapi/doc.py \
 $(SRC_PATH)/scripts/qapi/error.py \
 $(SRC_PATH)/scripts/qapi/events.py \
 $(SRC_PATH)/scripts/qapi/expr.py \
@@ -486,16 +485,8 @@ tests/test-qapi-gen-timestamp: \
 	$(call quiet-command,$(PYTHON) $(SRC_PATH)/scripts/qapi-gen.py \
 		-o tests -p "test-" $<, \
 		"GEN","$(@:%-timestamp=%)")
-	@rm -f tests/test-qapi-doc.texi
 	@>$@
 
-tests/qapi-schema/doc-good.test.texi: $(SRC_PATH)/tests/qapi-schema/doc-good.json $(qapi-py)
-	$(call quiet-command,$(PYTHON) $(SRC_PATH)/scripts/qapi-gen.py \
-		-o tests/qapi-schema -p "doc-good-" $<, \
-		"GEN","$@")
-	@mv tests/qapi-schema/doc-good-qapi-doc.texi $@
-	@rm -f tests/qapi-schema/doc-good-qapi-*.[ch] tests/qapi-schema/doc-good-qmp-*.[ch]
-
 tests/qtest/dbus-vmstate1.h tests/qtest/dbus-vmstate1.c: tests/qtest/dbus-vmstate1-gen-timestamp ;
 tests/qtest/dbus-vmstate1-gen-timestamp: $(SRC_PATH)/tests/qtest/dbus-vmstate1.xml
 	$(call quiet-command,$(GDBUS_CODEGEN) $< \
@@ -847,10 +838,6 @@ check-tests/qapi-schema/frontend: $(addprefix $(SRC_PATH)/, $(check-qapi-schema-
 	  PYTHONIOENCODING=utf-8 $(PYTHON) $(SRC_PATH)/tests/qapi-schema/test-qapi.py $^, \
 	  TEST, check-qapi-schema)
 
-.PHONY: check-tests/qapi-schema/doc-good.texi
-check-tests/qapi-schema/doc-good.texi: tests/qapi-schema/doc-good.test.texi
-	@diff -u $(SRC_PATH)/tests/qapi-schema/doc-good.texi $<
-
 .PHONY: check-decodetree
 check-decodetree:
 	$(call quiet-command, \
@@ -898,7 +885,7 @@ check-acceptance: check-venv $(TESTS_RESULTS_DIR)
 # Consolidated targets
 
 .PHONY: check-block check-qapi-schema check-qtest check-unit check check-clean
-check-qapi-schema: check-tests/qapi-schema/frontend check-tests/qapi-schema/doc-good.texi
+check-qapi-schema: check-tests/qapi-schema/frontend
 check-qtest: $(patsubst %,check-qtest-%, $(QTEST_TARGETS))
 ifeq ($(CONFIG_TOOLS),y)
 check-block: $(patsubst %,check-%, $(check-block-y))
diff --git a/scripts/qapi-gen.py b/scripts/qapi-gen.py
index f93f3c7c233..2d39714fa36 100755
--- a/scripts/qapi-gen.py
+++ b/scripts/qapi-gen.py
@@ -11,7 +11,6 @@ import re
 import sys
 
 from qapi.commands import gen_commands
-from qapi.doc import gen_doc
 from qapi.events import gen_events
 from qapi.introspect import gen_introspect
 from qapi.schema import QAPIError, QAPISchema
@@ -52,7 +51,6 @@ def main(argv):
     gen_commands(schema, args.output_dir, args.prefix)
     gen_events(schema, args.output_dir, args.prefix)
     gen_introspect(schema, args.output_dir, args.prefix, args.unmask)
-    gen_doc(schema, args.output_dir, args.prefix)
 
 
 if __name__ == '__main__':
diff --git a/scripts/qapi/doc.py b/scripts/qapi/doc.py
deleted file mode 100644
index 96346c9b14f..00000000000
--- a/scripts/qapi/doc.py
+++ /dev/null
@@ -1,303 +0,0 @@
-# QAPI texi generator
-#
-# This work is licensed under the terms of the GNU LGPL, version 2+.
-# See the COPYING file in the top-level directory.
-"""This script produces the documentation of a qapi schema in texinfo format"""
-
-from __future__ import print_function
-import re
-from qapi.gen import QAPIGenDoc, QAPISchemaVisitor
-
-
-MSG_FMT = """
-@deftypefn {type} {{}} {name}
-
-{body}{members}{features}{sections}
-@end deftypefn
-
-""".format
-
-TYPE_FMT = """
-@deftp {{{type}}} {name}
-
-{body}{members}{features}{sections}
-@end deftp
-
-""".format
-
-EXAMPLE_FMT = """@example
-{code}
-@end example
-""".format
-
-
-def subst_strong(doc):
-    """Replaces *foo* by @strong{foo}"""
-    return re.sub(r'\*([^*\n]+)\*', r'@strong{\1}', doc)
-
-
-def subst_emph(doc):
-    """Replaces _foo_ by @emph{foo}"""
-    return re.sub(r'\b_([^_\n]+)_\b', r'@emph{\1}', doc)
-
-
-def subst_vars(doc):
-    """Replaces @var by @code{var}"""
-    return re.sub(r'@([\w-]+)', r'@code{\1}', doc)
-
-
-def subst_braces(doc):
-    """Replaces {} with @{ @}"""
-    return doc.replace('{', '@{').replace('}', '@}')
-
-
-def texi_example(doc):
-    """Format @example"""
-    # TODO: Neglects to escape @ characters.
-    # We should probably escape them in subst_braces(), and rename the
-    # function to subst_special() or subs_texi_special().  If we do that, we
-    # need to delay it until after subst_vars() in texi_format().
-    doc = subst_braces(doc).strip('\n')
-    return EXAMPLE_FMT(code=doc)
-
-
-def texi_format(doc):
-    """
-    Format documentation
-
-    Lines starting with:
-    - |: generates an @example
-    - =: generates @section
-    - ==: generates @subsection
-    - 1. or 1): generates an @enumerate @item
-    - */-: generates an @itemize list
-    """
-    ret = ''
-    doc = subst_braces(doc)
-    doc = subst_vars(doc)
-    doc = subst_emph(doc)
-    doc = subst_strong(doc)
-    inlist = ''
-    lastempty = False
-    for line in doc.split('\n'):
-        line = line.strip()
-        empty = line == ''
-
-        # FIXME: Doing this in a single if / elif chain is
-        # problematic.  For instance, a line without markup terminates
-        # a list if it follows a blank line (reaches the final elif),
-        # but a line with some *other* markup, such as a = title
-        # doesn't.
-        #
-        # Make sure to update section "Documentation markup" in
-        # docs/devel/qapi-code-gen.txt when fixing this.
-        if line.startswith('| '):
-            line = EXAMPLE_FMT(code=line[2:])
-        elif line.startswith('= '):
-            line = '@section ' + line[2:]
-        elif line.startswith('== '):
-            line = '@subsection ' + line[3:]
-        elif re.match(r'^([0-9]*\.) ', line):
-            if not inlist:
-                ret += '@enumerate\n'
-                inlist = 'enumerate'
-            ret += '@item\n'
-            line = line[line.find(' ')+1:]
-        elif re.match(r'^[*-] ', line):
-            if not inlist:
-                ret += '@itemize %s\n' % {'*': '@bullet',
-                                          '-': '@minus'}[line[0]]
-                inlist = 'itemize'
-            ret += '@item\n'
-            line = line[2:]
-        elif lastempty and inlist:
-            ret += '@end %s\n\n' % inlist
-            inlist = ''
-
-        lastempty = empty
-        ret += line + '\n'
-
-    if inlist:
-        ret += '@end %s\n\n' % inlist
-    return ret
-
-
-def texi_body(doc):
-    """Format the main documentation body"""
-    return texi_format(doc.body.text)
-
-
-def texi_if(ifcond, prefix='\n', suffix='\n'):
-    """Format the #if condition"""
-    if not ifcond:
-        return ''
-    return '%s@b{If:} @code{%s}%s' % (prefix, ', '.join(ifcond), suffix)
-
-
-def texi_enum_value(value, desc, suffix):
-    """Format a table of members item for an enumeration value"""
-    return '@item @code{%s}\n%s%s' % (
-        value.name, desc, texi_if(value.ifcond, prefix='@*'))
-
-
-def texi_member(member, desc, suffix):
-    """Format a table of members item for an object type member"""
-    typ = member.type.doc_type()
-    membertype = ': ' + typ if typ else ''
-    return '@item @code{%s%s}%s%s\n%s%s' % (
-        member.name, membertype,
-        ' (optional)' if member.optional else '',
-        suffix, desc, texi_if(member.ifcond, prefix='@*'))
-
-
-def texi_members(doc, what, base=None, variants=None,
-                 member_func=texi_member):
-    """Format the table of members"""
-    items = ''
-    for section in doc.args.values():
-        # TODO Drop fallbacks when undocumented members are outlawed
-        if section.text:
-            desc = texi_format(section.text)
-        elif (variants and variants.tag_member == section.member
-              and not section.member.type.doc_type()):
-            values = section.member.type.member_names()
-            members_text = ', '.join(['@t{"%s"}' % v for v in values])
-            desc = 'One of ' + members_text + '\n'
-        else:
-            desc = 'Not documented\n'
-        items += member_func(section.member, desc, suffix='')
-    if base:
-        items += '@item The members of @code{%s}\n' % base.doc_type()
-    if variants:
-        for v in variants.variants:
-            when = ' when @code{%s} is @t{"%s"}%s' % (
-                variants.tag_member.name, v.name, texi_if(v.ifcond, " (", ")"))
-            if v.type.is_implicit():
-                assert not v.type.base and not v.type.variants
-                for m in v.type.local_members:
-                    items += member_func(m, desc='', suffix=when)
-            else:
-                items += '@item The members of @code{%s}%s\n' % (
-                    v.type.doc_type(), when)
-    if not items:
-        return ''
-    return '\n@b{%s:}\n@table @asis\n%s@end table\n' % (what, items)
-
-
-def texi_arguments(doc, boxed_arg_type):
-    if boxed_arg_type:
-        assert not doc.args
-        return ('\n@b{Arguments:} the members of @code{%s}\n'
-                % boxed_arg_type.name)
-    return texi_members(doc, 'Arguments')
-
-
-def texi_features(doc):
-    """Format the table of features"""
-    items = ''
-    for section in doc.features.values():
-        desc = texi_format(section.text)
-        items += '@item @code{%s}\n%s' % (section.name, desc)
-    if not items:
-        return ''
-    return '\n@b{Features:}\n@table @asis\n%s@end table\n' % (items)
-
-
-def texi_sections(doc, ifcond):
-    """Format additional sections following arguments"""
-    body = ''
-    for section in doc.sections:
-        if section.name:
-            # prefer @b over @strong, so txt doesn't translate it to *Foo:*
-            body += '\n@b{%s:}\n' % section.name
-        if section.name and section.name.startswith('Example'):
-            body += texi_example(section.text)
-        else:
-            body += texi_format(section.text)
-    body += texi_if(ifcond, suffix='')
-    return body
-
-
-def texi_type(typ, doc, ifcond, members):
-    return TYPE_FMT(type=typ,
-                    name=doc.symbol,
-                    body=texi_body(doc),
-                    members=members,
-                    features=texi_features(doc),
-                    sections=texi_sections(doc, ifcond))
-
-
-def texi_msg(typ, doc, ifcond, members):
-    return MSG_FMT(type=typ,
-                   name=doc.symbol,
-                   body=texi_body(doc),
-                   members=members,
-                   features=texi_features(doc),
-                   sections=texi_sections(doc, ifcond))
-
-
-class QAPISchemaGenDocVisitor(QAPISchemaVisitor):
-    def __init__(self, prefix):
-        self._prefix = prefix
-        self._gen = QAPIGenDoc(self._prefix + 'qapi-doc.texi')
-        self.cur_doc = None
-
-    def write(self, output_dir):
-        self._gen.write(output_dir)
-
-    def visit_enum_type(self, name, info, ifcond, members, prefix):
-        doc = self.cur_doc
-        self._gen.add(texi_type('Enum', doc, ifcond,
-                                texi_members(doc, 'Values',
-                                             member_func=texi_enum_value)))
-
-    def visit_object_type(self, name, info, ifcond, base, members, variants,
-                          features):
-        doc = self.cur_doc
-        if base and base.is_implicit():
-            base = None
-        self._gen.add(texi_type('Object', doc, ifcond,
-                                texi_members(doc, 'Members', base, variants)))
-
-    def visit_alternate_type(self, name, info, ifcond, variants):
-        doc = self.cur_doc
-        self._gen.add(texi_type('Alternate', doc, ifcond,
-                                texi_members(doc, 'Members')))
-
-    def visit_command(self, name, info, ifcond, arg_type, ret_type, gen,
-                      success_response, boxed, allow_oob, allow_preconfig,
-                      features):
-        doc = self.cur_doc
-        self._gen.add(texi_msg('Command', doc, ifcond,
-                               texi_arguments(doc,
-                                              arg_type if boxed else None)))
-
-    def visit_event(self, name, info, ifcond, arg_type, boxed):
-        doc = self.cur_doc
-        self._gen.add(texi_msg('Event', doc, ifcond,
-                               texi_arguments(doc,
-                                              arg_type if boxed else None)))
-
-    def symbol(self, doc, entity):
-        if self._gen._body:
-            self._gen.add('\n')
-        self.cur_doc = doc
-        entity.visit(self)
-        self.cur_doc = None
-
-    def freeform(self, doc):
-        assert not doc.args
-        if self._gen._body:
-            self._gen.add('\n')
-        self._gen.add(texi_body(doc) + texi_sections(doc, None))
-
-
-def gen_doc(schema, output_dir, prefix):
-    vis = QAPISchemaGenDocVisitor(prefix)
-    vis.visit_begin(schema)
-    for doc in schema.docs:
-        if doc.symbol:
-            vis.symbol(doc, schema.lookup_entity(doc.symbol))
-        else:
-            vis.freeform(doc)
-    vis.write(output_dir)
diff --git a/scripts/qapi/gen.py b/scripts/qapi/gen.py
index 95afae0615a..7712d2d49f7 100644
--- a/scripts/qapi/gen.py
+++ b/scripts/qapi/gen.py
@@ -177,13 +177,6 @@ def ifcontext(ifcond, *args):
         arg.end_if()
 
 
-class QAPIGenDoc(QAPIGen):
-
-    def _top(self):
-        return (QAPIGen._top(self)
-                + '@c AUTOMATICALLY GENERATED, DO NOT MODIFY\n\n')
-
-
 class QAPISchemaMonolithicCVisitor(QAPISchemaVisitor):
 
     def __init__(self, prefix, what, blurb, pydoc):
-- 
2.20.1


