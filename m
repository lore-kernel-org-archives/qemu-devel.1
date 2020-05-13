Return-Path: <SRS0=Qw6D=63=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F212CC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2020 21:42:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D9F952054F
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2020 21:42:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dEeNTr6d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9F952054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44648 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYz9E-0007yk-U5
	for qemu-devel@archiver.kernel.org; Wed, 13 May 2020 17:42:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34078)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1jYz8J-0006uY-85
 for qemu-devel@nongnu.org; Wed, 13 May 2020 17:41:43 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:38042
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1jYz8I-0005bY-8n
 for qemu-devel@nongnu.org; Wed, 13 May 2020 17:41:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589406101;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AQPoy5tHkY9or+yZngAsI3Otf/N2lSJ/rV5CdZXMGCw=;
 b=dEeNTr6dvKaHWg49m0ZvOTh/LAh+rWB3C5ojJrc8n3VJpztp87FkOIAHFgmRidKX8fnyNW
 h2TWBdPrAND/7Ghh0/hRD6BBb3kq263i7DzvIgWbshTdv1mGG4+WbMGQ5u589jTm8ftuN2
 uE4skqS45X3CRc4tSdDK3pVXuj72g3s=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-52-QpuKz1NNMhWdpQqL5AO6mw-1; Wed, 13 May 2020 17:41:35 -0400
X-MC-Unique: QpuKz1NNMhWdpQqL5AO6mw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AE4A5108BD09;
 Wed, 13 May 2020 21:41:34 +0000 (UTC)
Received: from probe.redhat.com (ovpn-113-80.rdu2.redhat.com [10.10.113.80])
 by smtp.corp.redhat.com (Postfix) with ESMTP id EBB512E034;
 Wed, 13 May 2020 21:41:33 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH RFC WIP 3/6] nbd-fault-injector: delint
Date: Wed, 13 May 2020 17:41:27 -0400
Message-Id: <20200513214130.15375-4-jsnow@redhat.com>
In-Reply-To: <20200513214130.15375-1-jsnow@redhat.com>
References: <20200513214130.15375-1-jsnow@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=jsnow@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/13 01:56:38
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Kevin Wolf <kwolf@redhat.com>, ehabkost@redhat.com, qemu-block@nongnu.org,
 philmd@redhat.com, Max Reitz <mreitz@redhat.com>, John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: John Snow <jsnow@redhat.com>
---
 tests/qemu-iotests/Makefile              |  2 +-
 tests/qemu-iotests/nbd-fault-injector.py | 34 ++++++++++++++----------
 2 files changed, 21 insertions(+), 15 deletions(-)

diff --git a/tests/qemu-iotests/Makefile b/tests/qemu-iotests/Makefile
index 7dbb7f0fff..64db48342f 100644
--- a/tests/qemu-iotests/Makefile
+++ b/tests/qemu-iotests/Makefile
@@ -1,6 +1,6 @@
 PYMODULES = $(wildcard *.py)
 
-KNOWN_GOOD = iotests.py
+KNOWN_GOOD = iotests.py nbd-fault-injector.py
 
 CLEANFILES= *.out.bad *.notrun check.log check.time*
 
diff --git a/tests/qemu-iotests/nbd-fault-injector.py b/tests/qemu-iotests/nbd-fault-injector.py
index 588d62aebf..0de6bc643e 100755
--- a/tests/qemu-iotests/nbd-fault-injector.py
+++ b/tests/qemu-iotests/nbd-fault-injector.py
@@ -47,10 +47,7 @@
 import socket
 import struct
 import collections
-if sys.version_info.major >= 3:
-    import configparser
-else:
-    import ConfigParser as configparser
+import configparser
 
 FAKE_DISK_SIZE = 8 * 1024 * 1024 * 1024 # 8 GB
 
@@ -71,7 +68,9 @@
 export_tuple = collections.namedtuple('Export', 'reserved magic opt len')
 export_struct = struct.Struct('>IQII')
 neg2_struct = struct.Struct('>QH124x')
-request_tuple = collections.namedtuple('Request', 'magic type handle from_ len')
+request_tuple = collections.namedtuple(
+    'Request', 'magic type handle from_ len'
+)
 request_struct = struct.Struct('>IIQQI')
 reply_struct = struct.Struct('>IIQ')
 
@@ -84,13 +83,13 @@ def recvall(sock, bufsize):
     chunks = []
     while received < bufsize:
         chunk = sock.recv(bufsize - received)
-        if len(chunk) == 0:
+        if not chunk:
             raise Exception('unexpected disconnect')
         chunks.append(chunk)
         received += len(chunk)
     return b''.join(chunks)
 
-class Rule(object):
+class Rule:
     def __init__(self, name, event, io, when):
         self.name = name
         self.event = event
@@ -104,7 +103,7 @@ def match(self, event, io):
             return False
         return True
 
-class FaultInjectionSocket(object):
+class FaultInjectionSocket:
     def __init__(self, sock, rules):
         self.sock = sock
         self.rules = rules
@@ -150,7 +149,7 @@ def negotiate_export(conn):
     export = export_tuple._make(export_struct.unpack(buf))
     assert export.magic == NBD_OPTS_MAGIC
     assert export.opt == NBD_OPT_EXPORT_NAME
-    name = conn.recv(export.len, event='export-name')
+    _name = conn.recv(export.len, event='export-name')
 
     # Send negotiation part 2
     buf = neg2_struct.pack(FAKE_DISK_SIZE, 0)
@@ -200,7 +199,8 @@ def parse_inject_error(name, options):
     if 'event' not in options:
         err('missing \"event\" option in %s' % name)
     event = options['event']
-    if event not in ('neg-classic', 'neg1', 'export', 'neg2', 'request', 'reply', 'data'):
+    if event not in ('neg-classic', 'neg1', 'export',
+                     'neg2', 'request', 'reply', 'data'):
         err('invalid \"event\" option value \"%s\" in %s' % (event, name))
     io = options.get('io', 'readwrite')
     if io not in ('read', 'write', 'readwrite'):
@@ -229,8 +229,8 @@ def parse_config(config):
 
 def load_rules(filename):
     config = configparser.RawConfigParser()
-    with open(filename, 'rt') as f:
-        config.readfp(f, filename)
+    with open(filename, 'rt') as infile:
+        config.read_file(infile)
     return parse_config(config)
 
 def open_socket(path):
@@ -252,8 +252,14 @@ def open_socket(path):
     return sock
 
 def usage(args):
-    sys.stderr.write('usage: %s [--classic-negotiation] <tcp-port>|<unix-path> <config-file>\n' % args[0])
-    sys.stderr.write('Run an fault injector NBD server with rules defined in a config file.\n')
+    name = args[0]
+    sys.stderr.write(
+        f'usage: {name} [--classic-negotiation] '
+        '<tcp-port>|<unix-path> <config-file>\n'
+    )
+    sys.stderr.write(
+        'Run a fault injector NBD server with '
+        'rules defined in a config file.\n')
     sys.exit(1)
 
 def main(args):
-- 
2.21.1


