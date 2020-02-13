Return-Path: <SRS0=ry7b=4B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E964BC2BA83
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 18:11:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AFC04206CC
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 18:11:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ii2QTKba"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AFC04206CC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57418 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2IxT-0003kj-V0
	for qemu-devel@archiver.kernel.org; Thu, 13 Feb 2020 13:11:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34851)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j2Ik3-00015L-3t
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 12:57:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j2Ik0-0003V7-4Z
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 12:57:35 -0500
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:51700)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j2Ijz-0003Sw-OD
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 12:57:32 -0500
Received: by mail-wm1-x344.google.com with SMTP id t23so7261584wmi.1
 for <qemu-devel@nongnu.org>; Thu, 13 Feb 2020 09:57:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=JrrTtIs4qMcc2oqixEEJxg51omh1H7hc+6Gul7Fkbac=;
 b=ii2QTKbaTvykl9LQovxsz47jBR0+/bgpHwWhajTwwebJcyc0oc7MBDJKockcbhSOvn
 SzY93YqNLvCkxV5iYoZiAhOvQRlu04U8oDKfwFhaPWWqtLGe8KUMzEfg9Aw+D5/wVm1o
 Meixyao+vZPYLUB4wluecf3RfZoVxGBZz0kVqfaJ8tX2g37S6wawOJ8pAOhws4evr/8j
 gOU6ZJ+pQU7NtNkz93rEf8YaFI5lOM8p74Xh9yN/ki1rV7YeF6+B5LwpQF+NPy5N6bps
 mx2ZozRIvhusYTKVw+TeQPz/aW5DEB5af2Z+0MbDPSrOCmlIAd9/cuj0nqv8YpWC8try
 wE0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=JrrTtIs4qMcc2oqixEEJxg51omh1H7hc+6Gul7Fkbac=;
 b=Wj6JRtIBIN50LTGpI9Ds2fdqT8M7bM3G+tlQ4Y0uJn/Q1DA9SjOhZjEo1bwKTDXbmF
 CAdNg6YUocoPpk4HorovugRbRlE/jQUnfLheaJqOxKzURjKPx4DKqxEpnWSUHXSHR/Rm
 8+eowKF4QHHg4DEC6dIh4Jdyo1r87j22DrV8C+gvDb5M3U2qsrftIb+fAzAD+01wY1XM
 nvJlH/uKqjSizcVbdghoxt82RShreN2njq6KBxcGOLlkI0sPthFAVO8DDG8tGrWFb3rJ
 G33MAYr8Pa/KaCG4H88J1t0t3pxgBr8kq8CMM3NASYDG2Roif0qg738So4N9lcn+/GgM
 ImkQ==
X-Gm-Message-State: APjAAAXRthOcvxQ9+9EWEIWXqLs1HMlWQ8lFrjofagmTX+NSTUCGLcvR
 O+hbQHBJkI6nkPxUJ1gX+YkuextqQDk=
X-Google-Smtp-Source: APXvYqySzdAMSzeAn3MmL+CFBZ75qNqoBS7WcCDNrNnRdlb62p6EvksGj1NpBV0Fj1SgbELdH7t4Yw==
X-Received: by 2002:a7b:cbcf:: with SMTP id n15mr6931613wmi.21.1581616649804; 
 Thu, 13 Feb 2020 09:57:29 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id p26sm3692913wmc.24.2020.02.13.09.57.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Feb 2020 09:57:29 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 29/30] scripts/qapi: Remove texinfo generation support
Date: Thu, 13 Feb 2020 17:56:46 +0000
Message-Id: <20200213175647.17628-30-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200213175647.17628-1-peter.maydell@linaro.org>
References: <20200213175647.17628-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::344
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
 Makefile                        |   1 -
 tests/Makefile.include          |  15 +-
 scripts/qapi-gen.py             |   2 -
 scripts/qapi/doc.py             | 302 --------------------------------
 scripts/qapi/gen.py             |   7 -
 tests/qapi-schema/doc-good.texi | 281 -----------------------------
 6 files changed, 1 insertion(+), 607 deletions(-)
 delete mode 100644 scripts/qapi/doc.py
 delete mode 100644 tests/qapi-schema/doc-good.texi

diff --git a/Makefile b/Makefile
index f708eb8dc44..687a17dc0cb 100644
--- a/Makefile
+++ b/Makefile
@@ -598,7 +598,6 @@ qemu-keymap$(EXESUF): QEMU_CFLAGS += $(XKBCOMMON_CFLAGS)
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
index 4b03f7d53be..541e8c1f55d 100755
--- a/scripts/qapi-gen.py
+++ b/scripts/qapi-gen.py
@@ -10,7 +10,6 @@ import re
 import sys
 
 from qapi.commands import gen_commands
-from qapi.doc import gen_doc
 from qapi.events import gen_events
 from qapi.introspect import gen_introspect
 from qapi.schema import QAPIError, QAPISchema
@@ -51,7 +50,6 @@ def main(argv):
     gen_commands(schema, args.output_dir, args.prefix)
     gen_events(schema, args.output_dir, args.prefix)
     gen_introspect(schema, args.output_dir, args.prefix, args.unmask)
-    gen_doc(schema, args.output_dir, args.prefix)
 
 
 if __name__ == '__main__':
diff --git a/scripts/qapi/doc.py b/scripts/qapi/doc.py
deleted file mode 100644
index 26cd1a1751e..00000000000
--- a/scripts/qapi/doc.py
+++ /dev/null
@@ -1,302 +0,0 @@
-# QAPI texi generator
-#
-# This work is licensed under the terms of the GNU LGPL, version 2+.
-# See the COPYING file in the top-level directory.
-"""This script produces the documentation of a qapi schema in texinfo format"""
-
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
diff --git a/tests/qapi-schema/doc-good.texi b/tests/qapi-schema/doc-good.texi
deleted file mode 100644
index 1e8063c8579..00000000000
--- a/tests/qapi-schema/doc-good.texi
+++ /dev/null
@@ -1,281 +0,0 @@
-@c AUTOMATICALLY GENERATED, DO NOT MODIFY
-
-@section Section
-
-@subsection Subsection
-
-@strong{strong} @emph{with emphasis}
-@code{var} @{in braces@}
-
-@itemize @bullet
-@item
-List item one
-@item
-Two, multiple
-lines
-
-@item
-Three
-Still in list
-
-@end itemize
-
-Not in list
-
-@itemize @minus
-@item
-Second list
-Note: still in list
-
-@end itemize
-
-Note: not in list
-
-@enumerate
-@item
-Third list
-is numbered
-
-@item
-another item
-
-@end enumerate
-
-Returns: the King
-Since: the first age
-Notes:
-
-@enumerate
-@item
-Lorem ipsum dolor sit amet
-
-@item
-Ut enim ad minim veniam
-
-@end enumerate
-
-Duis aute irure dolor
-
-Example:
-
--> in
-<- out
-Examples:
-@itemize @minus
-@item
-@strong{verbatim}
-@item
-@{braces@}
-@end itemize
-
-
-
-@deftp {Enum} Enum
-
-
-
-@b{Values:}
-@table @asis
-@item @code{one}
-The @emph{one} @{and only@}
-@*@b{If:} @code{defined(IFONE)}
-@item @code{two}
-Not documented
-@end table
-@code{two} is undocumented
-
-@b{If:} @code{defined(IFCOND)}
-@end deftp
-
-
-
-@deftp {Object} Base
-
-
-
-@b{Members:}
-@table @asis
-@item @code{base1: Enum}
-the first member
-@end table
-
-@end deftp
-
-
-
-@deftp {Object} Variant1
-
-A paragraph
-
-Another paragraph (but no @code{var}: line)
-
-@b{Members:}
-@table @asis
-@item @code{var1: string}
-Not documented
-@*@b{If:} @code{defined(IFSTR)}
-@end table
-
-@b{Features:}
-@table @asis
-@item @code{variant1-feat}
-a feature
-@end table
-
-@end deftp
-
-
-
-@deftp {Object} Variant2
-
-
-
-@end deftp
-
-
-
-@deftp {Object} Object
-
-
-
-@b{Members:}
-@table @asis
-@item The members of @code{Base}
-@item The members of @code{Variant1} when @code{base1} is @t{"one"}
-@item The members of @code{Variant2} when @code{base1} is @t{"two"} (@b{If:} @code{IFTWO})
-@end table
-
-@end deftp
-
-
-
-@deftp {Object} SugaredUnion
-
-
-
-@b{Members:}
-@table @asis
-@item @code{type}
-One of @t{"one"}, @t{"two"}
-@item @code{data: Variant1} when @code{type} is @t{"one"}
-@item @code{data: Variant2} when @code{type} is @t{"two"} (@b{If:} @code{IFTWO})
-@end table
-
-@end deftp
-
-
-
-@deftp {Alternate} Alternate
-
-
-
-@b{Members:}
-@table @asis
-@item @code{i: int}
-an integer
-@code{b} is undocumented
-@item @code{b: boolean}
-Not documented
-@end table
-
-@end deftp
-
-
-@subsection Another subsection
-
-
-@deftypefn Command {} cmd
-
-
-
-@b{Arguments:}
-@table @asis
-@item @code{arg1: int}
-the first argument
-@item @code{arg2: string} (optional)
-the second
-argument
-@item @code{arg3: boolean}
-Not documented
-@end table
-
-@b{Features:}
-@table @asis
-@item @code{cmd-feat1}
-a feature
-@item @code{cmd-feat2}
-another feature
-@end table
-
-@b{Note:}
-@code{arg3} is undocumented
-
-@b{Returns:}
-@code{Object}
-
-@b{TODO:}
-frobnicate
-
-@b{Notes:}
-@itemize @minus
-@item
-Lorem ipsum dolor sit amet
-@item
-Ut enim ad minim veniam
-
-@end itemize
-
-Duis aute irure dolor
-
-@b{Example:}
-@example
--> in
-<- out
-@end example
-
-@b{Examples:}
-@example
-- *verbatim*
-- @{braces@}
-@end example
-
-@b{Since:}
-2.10
-
-@end deftypefn
-
-
-
-@deftypefn Command {} cmd-boxed
-
-If you're bored enough to read this, go see a video of boxed cats
-
-@b{Arguments:} the members of @code{Object}
-
-@b{Features:}
-@table @asis
-@item @code{cmd-feat1}
-a feature
-@item @code{cmd-feat2}
-another feature
-@end table
-
-@b{Example:}
-@example
--> in
-
-<- out
-@end example
-
-@end deftypefn
-
-
-
-@deftypefn Event {} EVT-BOXED
-
-
-
-@b{Arguments:} the members of @code{Object}
-
-@end deftypefn
-
-- 
2.20.1


