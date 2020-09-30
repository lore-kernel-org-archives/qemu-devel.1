Return-Path: <SRS0=HfOj=DH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C92FC2D0A8
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 04:38:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9CB5B2075A
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 04:38:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P8o0npOs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CB5B2075A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44098 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNTsW-0008Qt-K8
	for qemu-devel@archiver.kernel.org; Wed, 30 Sep 2020 00:38:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36792)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kNTmr-0000H3-7t
 for qemu-devel@nongnu.org; Wed, 30 Sep 2020 00:32:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:35912)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kNTmp-0000WO-2x
 for qemu-devel@nongnu.org; Wed, 30 Sep 2020 00:32:16 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601440334;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ohrdQGTiKYwe6i4vImD7u4uMwi88xOIcSmLMqT35uAI=;
 b=P8o0npOs4pY+1dy6Yk01CXxQzr/Z2dW+IcDtOwnaCcc5ajl0T/6w3xue+kwWLVND/yiYnU
 JtOHqzrd7c9B6mcf9IzF5DdCbZOA6+2mEo1tOPcSVdLyHQEM7QorRreMmqbxmrAWaZKPco
 pjjVpj3Z61YJ2dbYaS1l5pAkq1NbrLg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-451-t6pM-hj5MWiF_ceD5qSJYA-1; Wed, 30 Sep 2020 00:32:09 -0400
X-MC-Unique: t6pM-hj5MWiF_ceD5qSJYA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9B9B61005E67;
 Wed, 30 Sep 2020 04:32:08 +0000 (UTC)
Received: from scv.redhat.com (ovpn-119-140.rdu2.redhat.com [10.10.119.140])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0AEAA73678;
 Wed, 30 Sep 2020 04:32:06 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 07/46] qapi: move generator entrypoint into module
Date: Wed, 30 Sep 2020 00:31:11 -0400
Message-Id: <20200930043150.1454766-8-jsnow@redhat.com>
In-Reply-To: <20200930043150.1454766-1-jsnow@redhat.com>
References: <20200930043150.1454766-1-jsnow@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jsnow@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=216.205.24.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/30 00:26:33
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.687,
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 John Snow <jsnow@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

As part of delinting and adding type hints to the QAPI generator, it's
helpful for the entrypoint to be part of the package, only leaving a
very tiny entrypoint shim outside of the module.

Signed-off-by: John Snow <jsnow@redhat.com>
Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
Reviewed-by: Cleber Rosa <crosa@redhat.com>
Tested-by: Cleber Rosa <crosa@redhat.com>
---
 scripts/qapi-gen.py  | 88 +++----------------------------------------
 scripts/qapi/main.py | 89 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 95 insertions(+), 82 deletions(-)
 create mode 100644 scripts/qapi/main.py

diff --git a/scripts/qapi-gen.py b/scripts/qapi-gen.py
index 117b396a595..f3518d29a54 100644
--- a/scripts/qapi-gen.py
+++ b/scripts/qapi-gen.py
@@ -4,92 +4,16 @@
 # See the COPYING file in the top-level directory.
 
 """
-QAPI Generator
+QAPI code generation execution shim.
 
-This script is the main entry point for generating C code from the QAPI schema.
+This standalone script exists primarily to facilitate the running of the QAPI
+code generator without needing to install the python module to the current
+execution environment.
 """
 
-import argparse
-import re
 import sys
 
-from qapi.commands import gen_commands
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
-    if match.end() != len(prefix):
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
+from qapi import main
 
 if __name__ == '__main__':
-    sys.exit(main())
+    sys.exit(main.main())
diff --git a/scripts/qapi/main.py b/scripts/qapi/main.py
new file mode 100644
index 00000000000..9210a0e1a80
--- /dev/null
+++ b/scripts/qapi/main.py
@@ -0,0 +1,89 @@
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
+from qapi.commands import gen_commands
+from qapi.error import QAPIError
+from qapi.events import gen_events
+from qapi.introspect import gen_introspect
+from qapi.schema import QAPISchema
+from qapi.types import gen_types
+from qapi.visit import gen_visit
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
+    if match.end() != len(prefix):
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
-- 
2.26.2


