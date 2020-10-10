Return-Path: <SRS0=BZbV=DR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E526C43457
	for <qemu-devel@archiver.kernel.org>; Sat, 10 Oct 2020 09:57:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 247E121D41
	for <qemu-devel@archiver.kernel.org>; Sat, 10 Oct 2020 09:57:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T4WY/kHh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 247E121D41
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44846 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kRBco-00015J-6J
	for qemu-devel@archiver.kernel.org; Sat, 10 Oct 2020 05:57:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60448)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kRBau-0007dL-4p
 for qemu-devel@nongnu.org; Sat, 10 Oct 2020 05:55:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:22217)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kRBaq-0002hf-Hc
 for qemu-devel@nongnu.org; Sat, 10 Oct 2020 05:55:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602323710;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nwbSkZFLhNjlGlUKypkB/L9ZdchRsEf7KjQkBXrzEKU=;
 b=T4WY/kHhpHyKZKxd6DznVZRMAZVUOzMe0OgCMCvpLTbI01nCCGLzi3cwTrzxsD1+B2tjvw
 YH2cyeBRUa4jN0xdL+KxHm9s1AS4QhRp5Q9E/N3DOiPpfYcnxDAISXcoVDSt4m7rkT7t4n
 /iOlStqYddnW131/DauCqONfyfDvUX4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-149-e-0rUu01PyyZ4A5agdsoOw-1; Sat, 10 Oct 2020 05:55:07 -0400
X-MC-Unique: e-0rUu01PyyZ4A5agdsoOw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AEC801005E5A;
 Sat, 10 Oct 2020 09:55:06 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-182.ams2.redhat.com
 [10.36.112.182])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 49C205D9FC;
 Sat, 10 Oct 2020 09:55:06 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id A0ADA112CE10; Sat, 10 Oct 2020 11:55:04 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 03/34] qapi-gen: Separate arg-parsing from generation
Date: Sat, 10 Oct 2020 11:54:33 +0200
Message-Id: <20201010095504.796182-4-armbru@redhat.com>
In-Reply-To: <20201010095504.796182-1-armbru@redhat.com>
References: <20201010095504.796182-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
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

This is a minor re-work of the entrypoint script. It isolates a
generate() method from the actual command-line mechanism.

Signed-off-by: John Snow <jsnow@redhat.com>
Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
Reviewed-by: Cleber Rosa <crosa@redhat.com>
Tested-by: Cleber Rosa <crosa@redhat.com>
Message-Id: <20201009161558.107041-4-jsnow@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
[invalid_char() renamed to invalid_prefix_char()]
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 scripts/qapi-gen.py | 89 ++++++++++++++++++++++++++++++++++-----------
 1 file changed, 67 insertions(+), 22 deletions(-)

diff --git a/scripts/qapi-gen.py b/scripts/qapi-gen.py
index 541e8c1f55..cf942d9ce3 100644
--- a/scripts/qapi-gen.py
+++ b/scripts/qapi-gen.py
@@ -1,30 +1,77 @@
 #!/usr/bin/env python3
-# QAPI generator
-#
+
 # This work is licensed under the terms of the GNU GPL, version 2 or later.
 # See the COPYING file in the top-level directory.
 
+"""
+QAPI Generator
+
+This is the main entry point for generating C code from the QAPI schema.
+"""
 
 import argparse
 import re
 import sys
+from typing import Optional
 
 from qapi.commands import gen_commands
+from qapi.error import QAPIError
 from qapi.events import gen_events
 from qapi.introspect import gen_introspect
-from qapi.schema import QAPIError, QAPISchema
+from qapi.schema import QAPISchema
 from qapi.types import gen_types
 from qapi.visit import gen_visit
 
 
-def main(argv):
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
     parser = argparse.ArgumentParser(
         description='Generate code from a QAPI schema')
     parser.add_argument('-b', '--builtins', action='store_true',
                         help="generate code for built-in types")
-    parser.add_argument('-o', '--output-dir', action='store', default='',
+    parser.add_argument('-o', '--output-dir', action='store',
+                        default='',
                         help="write output to directory OUTPUT_DIR")
-    parser.add_argument('-p', '--prefix', action='store', default='',
+    parser.add_argument('-p', '--prefix', action='store',
+                        default='',
                         help="prefix for symbols")
     parser.add_argument('-u', '--unmask-non-abi-names', action='store_true',
                         dest='unmask',
@@ -32,25 +79,23 @@ def main(argv):
     parser.add_argument('schema', action='store')
     args = parser.parse_args()
 
-    match = re.match(r'([A-Za-z_.-][A-Za-z0-9_.-]*)?', args.prefix)
-    if match.end() != len(args.prefix):
-        print("%s: 'funny character '%s' in argument of --prefix"
-              % (sys.argv[0], args.prefix[match.end()]),
-              file=sys.stderr)
-        sys.exit(1)
+    funny_char = invalid_prefix_char(args.prefix)
+    if funny_char:
+        msg = f"funny character '{funny_char}' in argument of --prefix"
+        print(f"{sys.argv[0]}: {msg}", file=sys.stderr)
+        return 1
 
     try:
-        schema = QAPISchema(args.schema)
+        generate(args.schema,
+                 output_dir=args.output_dir,
+                 prefix=args.prefix,
+                 unmask=args.unmask,
+                 builtins=args.builtins)
     except QAPIError as err:
-        print(err, file=sys.stderr)
-        exit(1)
-
-    gen_types(schema, args.output_dir, args.prefix, args.builtins)
-    gen_visit(schema, args.output_dir, args.prefix, args.builtins)
-    gen_commands(schema, args.output_dir, args.prefix)
-    gen_events(schema, args.output_dir, args.prefix)
-    gen_introspect(schema, args.output_dir, args.prefix, args.unmask)
+        print(f"{sys.argv[0]}: {str(err)}", file=sys.stderr)
+        return 1
+    return 0
 
 
 if __name__ == '__main__':
-    main(sys.argv)
+    sys.exit(main())
-- 
2.26.2


