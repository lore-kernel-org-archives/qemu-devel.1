Return-Path: <SRS0=hH57=EK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D205AC4742C
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 00:52:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 55E70223C7
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 00:52:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OadDj5ua"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55E70223C7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56214 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ka727-00042y-DQ
	for qemu-devel@archiver.kernel.org; Tue, 03 Nov 2020 19:52:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35768)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1ka6nW-0006tD-KE
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 19:37:10 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:31836)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1ka6nU-0004v4-0F
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 19:37:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604450227;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GMqE1AyxFYAnSfxpx9j63puyEBG10ftch/58FhUYqHA=;
 b=OadDj5uafHYr+SfS48Siz1ZVMHaA/iETgBhNLi52ONFI/Q5i6I+ZN6o0IFhCBDXNmJMo4L
 kYRHN+o65XXkR0nCQQDOezVn2oleqTHkduucuRt+yyV3M84+qiRzx2+wrde+enWDdVRDBH
 b2vOoj8IhAO5m8gAaW53mM/tiJ/rNuE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-589-6LG_tDASOayNRU28llR5uA-1; Tue, 03 Nov 2020 19:37:05 -0500
X-MC-Unique: 6LG_tDASOayNRU28llR5uA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B3B3980474F
 for <qemu-devel@nongnu.org>; Wed,  4 Nov 2020 00:37:04 +0000 (UTC)
Received: from scv.redhat.com (ovpn-119-97.rdu2.redhat.com [10.10.119.97])
 by smtp.corp.redhat.com (Postfix) with ESMTP id BE21F747C6;
 Wed,  4 Nov 2020 00:37:03 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 45/72] scripts/qmp-shell: use argparse
Date: Tue,  3 Nov 2020 19:35:35 -0500
Message-Id: <20201104003602.1293560-46-jsnow@redhat.com>
In-Reply-To: <20201104003602.1293560-1-jsnow@redhat.com>
References: <20201104003602.1293560-1-jsnow@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jsnow@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=216.205.24.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/03 00:03:41
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
Cc: Cleber Rosa <crosa@redhat.com>, John Snow <jsnow@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Use argparse instead of an open-coded CLI parser, for consistency with
everything else.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 scripts/qmp/qmp-shell | 82 +++++++++++++++++--------------------------
 1 file changed, 32 insertions(+), 50 deletions(-)

diff --git a/scripts/qmp/qmp-shell b/scripts/qmp/qmp-shell
index 0cd3ed7d43c7..d5496aeac0bd 100755
--- a/scripts/qmp/qmp-shell
+++ b/scripts/qmp/qmp-shell
@@ -64,7 +64,7 @@
 # Use the -v and -p options to activate the verbose and pretty-print options,
 # which will echo back the properly formatted JSON-compliant QMP that is being
 # sent to QEMU, which is useful for debugging and documentation generation.
-
+import argparse
 import ast
 import atexit
 import json
@@ -421,65 +421,47 @@ def die(msg):
     sys.exit(1)
 
 
-def fail_cmdline(option=None):
-    if option:
-        sys.stderr.write('ERROR: bad command-line option \'%s\'\n' % option)
-    sys.stderr.write(
-        'qmp-shell [ -v ] [ -p ] [ -H ] [ -N ] '
-        '< UNIX socket path> | < TCP address:port >\n'
-    )
-    sys.stderr.write('    -v     Verbose (echo command sent and received)\n')
-    sys.stderr.write('    -p     Pretty-print JSON\n')
-    sys.stderr.write('    -H     Use HMP interface\n')
-    sys.stderr.write('    -N     Skip negotiate (for qemu-ga)\n')
-    sys.exit(1)
-
-
 def main():
-    addr = ''
-    qemu = None
-    hmp = False
-    pretty = False
-    verbose = False
-    negotiate = True
+    parser = argparse.ArgumentParser()
+    parser.add_argument('-H', '--hmp', action='store_true',
+                        help='Use HMP interface')
+    parser.add_argument('-N', '--skip-negotiation', action='store_true',
+                        help='Skip negotiate (for qemu-ga)')
+    parser.add_argument('-v', '--verbose', action='store_true',
+                        help='Verbose (echo commands sent and received)')
+    parser.add_argument('-p', '--pretty', action='store_true',
+                        help='Pretty-print JSON')
 
+    default_server = os.environ.get('QMP_SOCKET')
+    parser.add_argument('qmp_server', action='store',
+                        default=default_server,
+                        help='< UNIX socket path | TCP address:port >')
+
+    args = parser.parse_args()
+    if args.qmp_server is None:
+        parser.error("QMP socket or TCP address must be specified")
+
+    qemu: QMPShell
     try:
-        for arg in sys.argv[1:]:
-            if arg == "-H":
-                if qemu is not None:
-                    fail_cmdline(arg)
-                hmp = True
-            elif arg == "-p":
-                pretty = True
-            elif arg == "-N":
-                negotiate = False
-            elif arg == "-v":
-                verbose = True
-            else:
-                if qemu is not None:
-                    fail_cmdline(arg)
-                if hmp:
-                    qemu = HMPShell(arg)
-                else:
-                    qemu = QMPShell(arg, pretty)
-                addr = arg
-
-        if qemu is None:
-            fail_cmdline()
+        if args.hmp:
+            qemu = HMPShell(args.qmp_server)
+        else:
+            qemu = QMPShell(args.qmp_server, args.pretty)
     except QMPShellBadPort:
-        die('bad port number in command-line')
+        parser.error(f"Bad port number: {args.qmp_server}")
+        return  # pycharm doesn't know error() is noreturn
 
     try:
-        qemu.connect(negotiate)
+        qemu.connect(negotiate=not args.skip_negotiation)
     except qmp.QMPConnectError:
-        die('Didn\'t get QMP greeting message')
+        die("Didn't get QMP greeting message")
     except qmp.QMPCapabilitiesError:
-        die('Could not negotiate capabilities')
-    except OSError:
-        die('Could not connect to %s' % addr)
+        die("Couldn't negotiate capabilities")
+    except OSError as err:
+        die(f"Couldn't connect to {args.qmp_server}: {err!s}")
 
     qemu.show_banner()
-    qemu.set_verbosity(verbose)
+    qemu.set_verbosity(args.verbose)
     while qemu.read_exec_command(qemu.get_prompt()):
         pass
     qemu.close()
-- 
2.26.2


