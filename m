Return-Path: <SRS0=0j61=C7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 082F8C4727D
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 21:06:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 71ADA206FB
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 21:06:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WYq6M6N+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71ADA206FB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45944 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKpUr-0007jN-BH
	for qemu-devel@archiver.kernel.org; Tue, 22 Sep 2020 17:06:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36914)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kKpPX-0001wO-5H
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 17:01:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:39780)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kKpPU-0004XU-3a
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 17:01:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600808471;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=637LJ33Schjo+rVEoXhJzcj6gHuGoz/oUV2e76R0FyM=;
 b=WYq6M6N+PUn4VH0KhYRQf9g0Eg2187hjDOD5S8uKoDwLPOxT1Uy5/06FkkGVZa2/3RB/en
 QQelvy3qiypE7Eit4oL6AaRw8CAPMu0QIAsqLgq+7zhge0z5IG7lkhVxkbK25gqryAK/JA
 EHfy/ZJUqOg70YX2bi5QqyiRUaH2UD8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-136-oxGLLNteM-Wt4rALAt3CEw-1; Tue, 22 Sep 2020 17:01:07 -0400
X-MC-Unique: oxGLLNteM-Wt4rALAt3CEw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6E68A64086;
 Tue, 22 Sep 2020 21:01:06 +0000 (UTC)
Received: from scv.redhat.com (ovpn-119-140.rdu2.redhat.com [10.10.119.140])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7A88A5577A;
 Tue, 22 Sep 2020 21:01:05 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: Markus Armbruster <armbru@redhat.com>,
	qemu-devel@nongnu.org
Subject: [PATCH v2 02/38] qapi-gen: Separate arg-parsing from generation
Date: Tue, 22 Sep 2020 17:00:25 -0400
Message-Id: <20200922210101.4081073-3-jsnow@redhat.com>
In-Reply-To: <20200922210101.4081073-1-jsnow@redhat.com>
References: <20200922210101.4081073-1-jsnow@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jsnow@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/22 02:07:04
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.455,
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <ehabkost@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Michael Roth <mdroth@linux.vnet.ibm.com>, Cleber Rosa <crosa@redhat.com>,
 John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is a minor re-work of the entrypoint script. It isolates a
generate() method from the actual command-line mechanism.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 scripts/qapi-gen.py | 87 ++++++++++++++++++++++++++++++++-------------
 1 file changed, 63 insertions(+), 24 deletions(-)

diff --git a/scripts/qapi-gen.py b/scripts/qapi-gen.py
index 4b03f7d53b..59becba3e1 100644
--- a/scripts/qapi-gen.py
+++ b/scripts/qapi-gen.py
@@ -1,9 +1,13 @@
 #!/usr/bin/env python3
-# QAPI generator
-#
+
 # This work is licensed under the terms of the GNU GPL, version 2 or later.
 # See the COPYING file in the top-level directory.
 
+"""
+QAPI Generator
+
+This script is the main entry point for generating C code from the QAPI schema.
+"""
 
 import argparse
 import re
@@ -11,21 +15,65 @@
 
 from qapi.commands import gen_commands
 from qapi.doc import gen_doc
+from qapi.error import QAPIError
 from qapi.events import gen_events
 from qapi.introspect import gen_introspect
-from qapi.schema import QAPIError, QAPISchema
+from qapi.schema import QAPISchema
 from qapi.types import gen_types
 from qapi.visit import gen_visit
 
 
-def main(argv):
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
     parser = argparse.ArgumentParser(
         description='Generate code from a QAPI schema')
     parser.add_argument('-b', '--builtins', action='store_true',
                         help="generate code for built-in types")
-    parser.add_argument('-o', '--output-dir', action='store', default='',
+    parser.add_argument('-o', '--output-dir', action='store',
+                        default=DEFAULT_OUTPUT_DIR,
                         help="write output to directory OUTPUT_DIR")
-    parser.add_argument('-p', '--prefix', action='store', default='',
+    parser.add_argument('-p', '--prefix', action='store',
+                        default=DEFAULT_PREFIX,
                         help="prefix for symbols")
     parser.add_argument('-u', '--unmask-non-abi-names', action='store_true',
                         dest='unmask',
@@ -33,26 +81,17 @@ def main(argv):
     parser.add_argument('schema', action='store')
     args = parser.parse_args()
 
-    match = re.match(r'([A-Za-z_.-][A-Za-z0-9_.-]*)?', args.prefix)
-    if match.end() != len(args.prefix):
-        print("%s: 'funny character '%s' in argument of --prefix"
-              % (sys.argv[0], args.prefix[match.end()]),
-              file=sys.stderr)
-        sys.exit(1)
-
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
-    gen_doc(schema, args.output_dir, args.prefix)
+        print(f"{sys.argv[0]}: {str(err)}", file=sys.stderr)
+        return 1
+    return 0
 
 
 if __name__ == '__main__':
-    main(sys.argv)
+    sys.exit(main())
-- 
2.26.2


