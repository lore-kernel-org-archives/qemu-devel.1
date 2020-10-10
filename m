Return-Path: <SRS0=BZbV=DR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30549C433DF
	for <qemu-devel@archiver.kernel.org>; Sat, 10 Oct 2020 09:59:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C600D21D41
	for <qemu-devel@archiver.kernel.org>; Sat, 10 Oct 2020 09:59:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="STPb430k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C600D21D41
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53288 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kRBf8-0004Xb-QV
	for qemu-devel@archiver.kernel.org; Sat, 10 Oct 2020 05:59:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60512)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kRBay-0007gx-8D
 for qemu-devel@nongnu.org; Sat, 10 Oct 2020 05:55:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:34304)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kRBaq-0002hq-LT
 for qemu-devel@nongnu.org; Sat, 10 Oct 2020 05:55:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602323710;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3G4eikzq6DxjOBhxq5Wm6XT1RSr4HRM653GK1NVGeBY=;
 b=STPb430k5umblQtFhFbzlkwYD48e99MllP8oim6MRUt8O1EL4lYSErTl+uVzjVFv811yCv
 9X0Ha5fjMs9LknqXOQLGFFLzpCNdZu7YAR+SNJT7j8m7Ob6SRUJXyQ8pKh2aF3ErBGxUJd
 v2FHKuB8PLniR2eIn4+zygppwQk9XHA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-225-N3hZLLFLOr2iZz9Gim-WrA-1; Sat, 10 Oct 2020 05:55:07 -0400
X-MC-Unique: N3hZLLFLOr2iZz9Gim-WrA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B26D451B4;
 Sat, 10 Oct 2020 09:55:06 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-182.ams2.redhat.com
 [10.36.112.182])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 29D5E55760;
 Sat, 10 Oct 2020 09:55:06 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id A52A4112CE12; Sat, 10 Oct 2020 11:55:04 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 04/34] qapi: move generator entrypoint into package
Date: Sat, 10 Oct 2020 11:54:34 +0200
Message-Id: <20201010095504.796182-5-armbru@redhat.com>
In-Reply-To: <20201010095504.796182-1-armbru@redhat.com>
References: <20201010095504.796182-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=216.205.24.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/10 02:57:53
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: peter.maydell@linaro.org, John Snow <jsnow@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: John Snow <jsnow@redhat.com>

As part of delinting and adding type hints to the QAPI generator, it's
helpful for the entrypoint to be part of the package, only leaving a
very tiny entrypoint shim outside of the package.

Signed-off-by: John Snow <jsnow@redhat.com>
Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
Reviewed-by: Cleber Rosa <crosa@redhat.com>
Tested-by: Cleber Rosa <crosa@redhat.com>
Message-Id: <20201009161558.107041-5-jsnow@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
[invalid_char() renamed to invalid_prefix_char()]
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 scripts/qapi-gen.py  | 94 +++----------------------------------------
 scripts/qapi/main.py | 95 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 101 insertions(+), 88 deletions(-)
 create mode 100644 scripts/qapi/main.py

diff --git a/scripts/qapi-gen.py b/scripts/qapi-gen.py
index cf942d9ce3..f3518d29a5 100644
--- a/scripts/qapi-gen.py
+++ b/scripts/qapi-gen.py
@@ -4,98 +4,16 @@
 # See the COPYING file in the top-level directory.
 
 """
-QAPI Generator
+QAPI code generation execution shim.
 
-This is the main entry point for generating C code from the QAPI schema.
+This standalone script exists primarily to facilitate the running of the QAPI
+code generator without needing to install the python module to the current
+execution environment.
 """
 
-import argparse
-import re
 import sys
-from typing import Optional
-
-from qapi.commands import gen_commands
-from qapi.error import QAPIError
-from qapi.events import gen_events
-from qapi.introspect import gen_introspect
-from qapi.schema import QAPISchema
-from qapi.types import gen_types
-from qapi.visit import gen_visit
-
-
-def invalid_prefix_char(prefix: str) -> Optional[str]:
-    match = re.match(r'([A-Za-z_.-][A-Za-z0-9_.-]*)?', prefix)
-    if match.end() != len(prefix):
-        return prefix[match.end()]
-    return None
-
-
-def generate(schema_file: str,
-             output_dir: str,
-             prefix: str,
-             unmask: bool = False,
-             builtins: bool = False) -> None:
-    """
-    Generate C code for the given schema into the target directory.
-
-    :param schema_file: The primary QAPI schema file.
-    :param output_dir: The output directory to store generated code.
-    :param prefix: Optional C-code prefix for symbol names.
-    :param unmask: Expose non-ABI names through introspection?
-    :param builtins: Generate code for built-in types?
-
-    :raise QAPIError: On failures.
-    """
-    assert invalid_prefix_char(prefix) is None
-
-    schema = QAPISchema(schema_file)
-    gen_types(schema, output_dir, prefix, builtins)
-    gen_visit(schema, output_dir, prefix, builtins)
-    gen_commands(schema, output_dir, prefix)
-    gen_events(schema, output_dir, prefix)
-    gen_introspect(schema, output_dir, prefix, unmask)
-
-
-def main() -> int:
-    """
-    gapi-gen executable entry point.
-    Expects arguments via sys.argv, see --help for details.
-
-    :return: int, 0 on success, 1 on failure.
-    """
-    parser = argparse.ArgumentParser(
-        description='Generate code from a QAPI schema')
-    parser.add_argument('-b', '--builtins', action='store_true',
-                        help="generate code for built-in types")
-    parser.add_argument('-o', '--output-dir', action='store',
-                        default='',
-                        help="write output to directory OUTPUT_DIR")
-    parser.add_argument('-p', '--prefix', action='store',
-                        default='',
-                        help="prefix for symbols")
-    parser.add_argument('-u', '--unmask-non-abi-names', action='store_true',
-                        dest='unmask',
-                        help="expose non-ABI names in introspection")
-    parser.add_argument('schema', action='store')
-    args = parser.parse_args()
-
-    funny_char = invalid_prefix_char(args.prefix)
-    if funny_char:
-        msg = f"funny character '{funny_char}' in argument of --prefix"
-        print(f"{sys.argv[0]}: {msg}", file=sys.stderr)
-        return 1
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
 
+from qapi import main
 
 if __name__ == '__main__':
-    sys.exit(main())
+    sys.exit(main.main())
diff --git a/scripts/qapi/main.py b/scripts/qapi/main.py
new file mode 100644
index 0000000000..92a2a31ca1
--- /dev/null
+++ b/scripts/qapi/main.py
@@ -0,0 +1,95 @@
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
+from typing import Optional
+
+from qapi.commands import gen_commands
+from qapi.error import QAPIError
+from qapi.events import gen_events
+from qapi.introspect import gen_introspect
+from qapi.schema import QAPISchema
+from qapi.types import gen_types
+from qapi.visit import gen_visit
+
+
+def invalid_prefix_char(prefix: str) -> Optional[str]:
+    match = re.match(r'([A-Za-z_.-][A-Za-z0-9_.-]*)?', prefix)
+    if match.end() != len(prefix):
+        return prefix[match.end()]
+    return None
+
+
+def generate(schema_file: str,
+             output_dir: str,
+             prefix: str,
+             unmask: bool = False,
+             builtins: bool = False) -> None:
+    """
+    Generate C code for the given schema into the target directory.
+
+    :param schema_file: The primary QAPI schema file.
+    :param output_dir: The output directory to store generated code.
+    :param prefix: Optional C-code prefix for symbol names.
+    :param unmask: Expose non-ABI names through introspection?
+    :param builtins: Generate code for built-in types?
+
+    :raise QAPIError: On failures.
+    """
+    assert invalid_prefix_char(prefix) is None
+
+    schema = QAPISchema(schema_file)
+    gen_types(schema, output_dir, prefix, builtins)
+    gen_visit(schema, output_dir, prefix, builtins)
+    gen_commands(schema, output_dir, prefix)
+    gen_events(schema, output_dir, prefix)
+    gen_introspect(schema, output_dir, prefix, unmask)
+
+
+def main() -> int:
+    """
+    gapi-gen executable entry point.
+    Expects arguments via sys.argv, see --help for details.
+
+    :return: int, 0 on success, 1 on failure.
+    """
+    parser = argparse.ArgumentParser(
+        description='Generate code from a QAPI schema')
+    parser.add_argument('-b', '--builtins', action='store_true',
+                        help="generate code for built-in types")
+    parser.add_argument('-o', '--output-dir', action='store',
+                        default='',
+                        help="write output to directory OUTPUT_DIR")
+    parser.add_argument('-p', '--prefix', action='store',
+                        default='',
+                        help="prefix for symbols")
+    parser.add_argument('-u', '--unmask-non-abi-names', action='store_true',
+                        dest='unmask',
+                        help="expose non-ABI names in introspection")
+    parser.add_argument('schema', action='store')
+    args = parser.parse_args()
+
+    funny_char = invalid_prefix_char(args.prefix)
+    if funny_char:
+        msg = f"funny character '{funny_char}' in argument of --prefix"
+        print(f"{sys.argv[0]}: {msg}", file=sys.stderr)
+        return 1
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
-- 
2.26.2


