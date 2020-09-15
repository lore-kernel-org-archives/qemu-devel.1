Return-Path: <SRS0=sZ46=CY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA805C2D0E3
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 22:42:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 81CE021D91
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 22:42:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ni9fraw6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81CE021D91
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51912 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIJeq-0008Rj-J0
	for qemu-devel@archiver.kernel.org; Tue, 15 Sep 2020 18:42:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59126)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kIJdA-0006Wx-L5
 for qemu-devel@nongnu.org; Tue, 15 Sep 2020 18:40:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:58037)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kIJd7-0002Ze-Fp
 for qemu-devel@nongnu.org; Tue, 15 Sep 2020 18:40:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600209652;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pKWXybqPMTufCJpdDD0MNwo0LrgnbAsBE/Dw/0uGbLY=;
 b=Ni9fraw6MxyiopUaUD2VCpaeKXLsBGhmCls97NNN7A5ErIFUgwr3vC3CYVnFaFEO0kgfhg
 DJGMihNTQyejpTqDQgJVcXYNgBvbUGoTz7pi/qLOHytf94+J8Cp4W7DqpTenJHlfiwQfJ0
 sb5kbaO1kacG+KSt9fPGwnRgyIwf4w0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-281-U612FO2aOfSTQoSKjOmwXg-1; Tue, 15 Sep 2020 18:40:50 -0400
X-MC-Unique: U612FO2aOfSTQoSKjOmwXg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 68A4D8B5DE1;
 Tue, 15 Sep 2020 22:40:45 +0000 (UTC)
Received: from scv.redhat.com (ovpn-119-140.rdu2.redhat.com [10.10.119.140])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 15FB581C43;
 Tue, 15 Sep 2020 22:40:42 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org,
	Markus Armbruster <armbru@redhat.com>
Subject: [PATCH 04/37] qapi: move generator entrypoint into module
Date: Tue, 15 Sep 2020 18:39:54 -0400
Message-Id: <20200915224027.2529813-5-jsnow@redhat.com>
In-Reply-To: <20200915224027.2529813-1-jsnow@redhat.com>
References: <20200915224027.2529813-1-jsnow@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jsnow@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/15 02:10:32
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.999,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: John Snow <jsnow@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Eduardo Habkost <ehabkost@redhat.com>, Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

As part of delinting and adding type hints to the QAPI generator, it's
helpful for the entrypoint to be part of the module, only leaving a very
tiny entrypoint shim outside of the module.

As a result, all of the include statements are reworked to be module-aware,
as explicit relative imports.

This is done primarily for the benefit of python tooling (pylint, mypy,
flake8, et al) which otherwise has trouble consistently resolving
"qapi.x" to mean "a sibling file in this folder."

Signed-off-by: John Snow <jsnow@redhat.com>
---
 scripts/qapi-gen.py        | 94 +++-----------------------------------
 scripts/qapi/commands.py   |  4 +-
 scripts/qapi/doc.py        |  2 +-
 scripts/qapi/events.py     |  8 ++--
 scripts/qapi/expr.py       |  4 +-
 scripts/qapi/gen.py        |  4 +-
 scripts/qapi/introspect.py |  8 ++--
 scripts/qapi/parser.py     |  4 +-
 scripts/qapi/schema.py     |  8 ++--
 scripts/qapi/script.py     | 91 ++++++++++++++++++++++++++++++++++++
 scripts/qapi/types.py      |  6 +--
 scripts/qapi/visit.py      |  6 +--
 12 files changed, 124 insertions(+), 115 deletions(-)
 create mode 100644 scripts/qapi/script.py

diff --git a/scripts/qapi-gen.py b/scripts/qapi-gen.py
index 59becba3e1..e649f8dd44 100644
--- a/scripts/qapi-gen.py
+++ b/scripts/qapi-gen.py
@@ -1,97 +1,15 @@
 #!/usr/bin/env python3
-
-# This work is licensed under the terms of the GNU GPL, version 2 or later.
-# See the COPYING file in the top-level directory.
-
 """
-QAPI Generator
+QAPI code generation execution shim.
 
-This script is the main entry point for generating C code from the QAPI schema.
+This file exists primarily to facilitate the running of the QAPI code
+generator without needing to install the python module to the current
+execution environment.
 """
 
-import argparse
-import re
 import sys
 
-from qapi.commands import gen_commands
-from qapi.doc import gen_doc
-from qapi.error import QAPIError
-from qapi.events import gen_events
-from qapi.introspect import gen_introspect
-from qapi.schema import QAPISchema
-from qapi.types import gen_types
-from qapi.visit import gen_visit
-
-
-DEFAULT_OUTPUT_DIR = ''
-DEFAULT_PREFIX = ''
-
-
-def generate(schema_file: str,
-             output_dir: str,
-             prefix: str,
-             unmask: bool = False,
-             builtins: bool = False) -> None:
-    """
-    generate uses a given schema to produce C code in the target directory.
-
-    :param schema_file: The primary QAPI schema file.
-    :param output_dir: The output directory to store generated code.
-    :param prefix: Optional C-code prefix for symbol names.
-    :param unmask: Expose non-ABI names through introspection?
-    :param builtins: Generate code for built-in types?
-
-    :raise QAPIError: On failures.
-    """
-    match = re.match(r'([A-Za-z_.-][A-Za-z0-9_.-]*)?', prefix)
-    if match and match.end() != len(prefix):
-        msg = "funny character '{:s}' in prefix '{:s}'".format(
-            prefix[match.end()], prefix)
-        raise QAPIError('', None, msg)
-
-    schema = QAPISchema(schema_file)
-    gen_types(schema, output_dir, prefix, builtins)
-    gen_visit(schema, output_dir, prefix, builtins)
-    gen_commands(schema, output_dir, prefix)
-    gen_events(schema, output_dir, prefix)
-    gen_introspect(schema, output_dir, prefix, unmask)
-    gen_doc(schema, output_dir, prefix)
-
-
-def main() -> int:
-    """
-    gapi-gen shell script entrypoint.
-    Expects arguments via sys.argv, see --help for details.
-
-    :return: int, 0 on success, 1 on failure.
-    """
-    parser = argparse.ArgumentParser(
-        description='Generate code from a QAPI schema')
-    parser.add_argument('-b', '--builtins', action='store_true',
-                        help="generate code for built-in types")
-    parser.add_argument('-o', '--output-dir', action='store',
-                        default=DEFAULT_OUTPUT_DIR,
-                        help="write output to directory OUTPUT_DIR")
-    parser.add_argument('-p', '--prefix', action='store',
-                        default=DEFAULT_PREFIX,
-                        help="prefix for symbols")
-    parser.add_argument('-u', '--unmask-non-abi-names', action='store_true',
-                        dest='unmask',
-                        help="expose non-ABI names in introspection")
-    parser.add_argument('schema', action='store')
-    args = parser.parse_args()
-
-    try:
-        generate(args.schema,
-                 output_dir=args.output_dir,
-                 prefix=args.prefix,
-                 unmask=args.unmask,
-                 builtins=args.builtins)
-    except QAPIError as err:
-        print(f"{sys.argv[0]}: {str(err)}", file=sys.stderr)
-        return 1
-    return 0
-
+from qapi import script
 
 if __name__ == '__main__':
-    sys.exit(main())
+    sys.exit(script.main())
diff --git a/scripts/qapi/commands.py b/scripts/qapi/commands.py
index 3cf9e1110b..ce5926146a 100644
--- a/scripts/qapi/commands.py
+++ b/scripts/qapi/commands.py
@@ -13,8 +13,8 @@
 See the COPYING file in the top-level directory.
 """
 
-from qapi.common import *
-from qapi.gen import QAPIGenCCode, QAPISchemaModularCVisitor, ifcontext
+from .common import *
+from .gen import QAPIGenCCode, QAPISchemaModularCVisitor, ifcontext
 
 
 def gen_command_decl(name, arg_type, boxed, ret_type):
diff --git a/scripts/qapi/doc.py b/scripts/qapi/doc.py
index 92f584edcf..cbf7076ed9 100644
--- a/scripts/qapi/doc.py
+++ b/scripts/qapi/doc.py
@@ -5,7 +5,7 @@
 """This script produces the documentation of a qapi schema in texinfo format"""
 
 import re
-from qapi.gen import QAPIGenDoc, QAPISchemaVisitor
+from .gen import QAPIGenDoc, QAPISchemaVisitor
 
 
 MSG_FMT = """
diff --git a/scripts/qapi/events.py b/scripts/qapi/events.py
index b544af5a1c..0467272438 100644
--- a/scripts/qapi/events.py
+++ b/scripts/qapi/events.py
@@ -12,10 +12,10 @@
 See the COPYING file in the top-level directory.
 """
 
-from qapi.common import *
-from qapi.gen import QAPISchemaModularCVisitor, ifcontext
-from qapi.schema import QAPISchemaEnumMember
-from qapi.types import gen_enum, gen_enum_lookup
+from .common import *
+from .gen import QAPISchemaModularCVisitor, ifcontext
+from .schema import QAPISchemaEnumMember
+from .types import gen_enum, gen_enum_lookup
 
 
 def build_event_send_proto(name, arg_type, boxed):
diff --git a/scripts/qapi/expr.py b/scripts/qapi/expr.py
index 2942520399..03b31ecfc1 100644
--- a/scripts/qapi/expr.py
+++ b/scripts/qapi/expr.py
@@ -16,8 +16,8 @@
 
 import re
 from collections import OrderedDict
-from qapi.common import c_name
-from qapi.error import QAPISemError
+from .common import c_name
+from .error import QAPISemError
 
 
 # Names must be letters, numbers, -, and _.  They must start with letter,
diff --git a/scripts/qapi/gen.py b/scripts/qapi/gen.py
index bf5552a4e7..8df19a0df0 100644
--- a/scripts/qapi/gen.py
+++ b/scripts/qapi/gen.py
@@ -17,8 +17,8 @@
 import re
 from contextlib import contextmanager
 
-from qapi.common import *
-from qapi.schema import QAPISchemaVisitor
+from .common import *
+from .schema import QAPISchemaVisitor
 
 
 class QAPIGen:
diff --git a/scripts/qapi/introspect.py b/scripts/qapi/introspect.py
index 23652be810..2a34cd1e8e 100644
--- a/scripts/qapi/introspect.py
+++ b/scripts/qapi/introspect.py
@@ -10,10 +10,10 @@
 See the COPYING file in the top-level directory.
 """
 
-from qapi.common import *
-from qapi.gen import QAPISchemaMonolithicCVisitor
-from qapi.schema import (QAPISchemaArrayType, QAPISchemaBuiltinType,
-                         QAPISchemaType)
+from .common import *
+from .gen import QAPISchemaMonolithicCVisitor
+from .schema import (QAPISchemaArrayType, QAPISchemaBuiltinType,
+                     QAPISchemaType)
 
 
 def _make_tree(obj, ifcond, features, extra=None):
diff --git a/scripts/qapi/parser.py b/scripts/qapi/parser.py
index 165925ca72..327cf05736 100644
--- a/scripts/qapi/parser.py
+++ b/scripts/qapi/parser.py
@@ -18,8 +18,8 @@
 import re
 from collections import OrderedDict
 
-from qapi.error import QAPIParseError, QAPISemError
-from qapi.source import QAPISourceInfo
+from .error import QAPIParseError, QAPISemError
+from .source import QAPISourceInfo
 
 
 class QAPISchemaParser:
diff --git a/scripts/qapi/schema.py b/scripts/qapi/schema.py
index 78309a00f0..a835ee6fde 100644
--- a/scripts/qapi/schema.py
+++ b/scripts/qapi/schema.py
@@ -18,10 +18,10 @@
 import re
 from collections import OrderedDict
 
-from qapi.common import c_name, pointer_suffix
-from qapi.error import QAPIError, QAPISemError
-from qapi.expr import check_exprs
-from qapi.parser import QAPISchemaParser
+from .common import c_name, pointer_suffix
+from .error import QAPIError, QAPISemError
+from .expr import check_exprs
+from .parser import QAPISchemaParser
 
 
 class QAPISchemaEntity:
diff --git a/scripts/qapi/script.py b/scripts/qapi/script.py
new file mode 100644
index 0000000000..3f8338ade8
--- /dev/null
+++ b/scripts/qapi/script.py
@@ -0,0 +1,91 @@
+# This work is licensed under the terms of the GNU GPL, version 2 or later.
+# See the COPYING file in the top-level directory.
+
+"""
+QAPI Generator
+
+This is the main entry point for generating C code from the QAPI schema.
+"""
+
+import argparse
+import re
+import sys
+
+from .commands import gen_commands
+from .doc import gen_doc
+from .error import QAPIError
+from .events import gen_events
+from .introspect import gen_introspect
+from .schema import QAPISchema
+from .types import gen_types
+from .visit import gen_visit
+
+
+DEFAULT_OUTPUT_DIR = ''
+DEFAULT_PREFIX = ''
+
+
+def generate(schema_file: str,
+             output_dir: str,
+             prefix: str,
+             unmask: bool = False,
+             builtins: bool = False) -> None:
+    """
+    generate uses a given schema to produce C code in the target directory.
+
+    :param schema_file: The primary QAPI schema file.
+    :param output_dir: The output directory to store generated code.
+    :param prefix: Optional C-code prefix for symbol names.
+    :param unmask: Expose non-ABI names through introspection?
+    :param builtins: Generate code for built-in types?
+
+    :raise QAPIError: On failures.
+    """
+    match = re.match(r'([A-Za-z_.-][A-Za-z0-9_.-]*)?', prefix)
+    if match and match.end() != len(prefix):
+        msg = "funny character '{:s}' in prefix '{:s}'".format(
+            prefix[match.end()], prefix)
+        raise QAPIError('', None, msg)
+
+    schema = QAPISchema(schema_file)
+    gen_types(schema, output_dir, prefix, builtins)
+    gen_visit(schema, output_dir, prefix, builtins)
+    gen_commands(schema, output_dir, prefix)
+    gen_events(schema, output_dir, prefix)
+    gen_introspect(schema, output_dir, prefix, unmask)
+    gen_doc(schema, output_dir, prefix)
+
+
+def main() -> int:
+    """
+    gapi-gen shell script entrypoint.
+    Expects arguments via sys.argv, see --help for details.
+
+    :return: int, 0 on success, 1 on failure.
+    """
+    parser = argparse.ArgumentParser(
+        description='Generate code from a QAPI schema')
+    parser.add_argument('-b', '--builtins', action='store_true',
+                        help="generate code for built-in types")
+    parser.add_argument('-o', '--output-dir', action='store',
+                        default=DEFAULT_OUTPUT_DIR,
+                        help="write output to directory OUTPUT_DIR")
+    parser.add_argument('-p', '--prefix', action='store',
+                        default=DEFAULT_PREFIX,
+                        help="prefix for symbols")
+    parser.add_argument('-u', '--unmask-non-abi-names', action='store_true',
+                        dest='unmask',
+                        help="expose non-ABI names in introspection")
+    parser.add_argument('schema', action='store')
+    args = parser.parse_args()
+
+    try:
+        generate(args.schema,
+                 output_dir=args.output_dir,
+                 prefix=args.prefix,
+                 unmask=args.unmask,
+                 builtins=args.builtins)
+    except QAPIError as err:
+        print(f"{sys.argv[0]}: {str(err)}", file=sys.stderr)
+        return 1
+    return 0
diff --git a/scripts/qapi/types.py b/scripts/qapi/types.py
index 3640f17cd6..ca9a5aacb3 100644
--- a/scripts/qapi/types.py
+++ b/scripts/qapi/types.py
@@ -13,9 +13,9 @@
 # See the COPYING file in the top-level directory.
 """
 
-from qapi.common import *
-from qapi.gen import QAPISchemaModularCVisitor, ifcontext
-from qapi.schema import QAPISchemaEnumMember, QAPISchemaObjectType
+from .common import *
+from .gen import QAPISchemaModularCVisitor, ifcontext
+from .schema import QAPISchemaEnumMember, QAPISchemaObjectType
 
 
 # variants must be emitted before their container; track what has already
diff --git a/scripts/qapi/visit.py b/scripts/qapi/visit.py
index cdabc5fa28..7850f6e848 100644
--- a/scripts/qapi/visit.py
+++ b/scripts/qapi/visit.py
@@ -13,9 +13,9 @@
 See the COPYING file in the top-level directory.
 """
 
-from qapi.common import *
-from qapi.gen import QAPISchemaModularCVisitor, ifcontext
-from qapi.schema import QAPISchemaObjectType
+from .common import *
+from .gen import QAPISchemaModularCVisitor, ifcontext
+from .schema import QAPISchemaObjectType
 
 
 def gen_visit_decl(name, scalar=False):
-- 
2.26.2


