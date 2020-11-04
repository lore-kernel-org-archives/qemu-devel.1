Return-Path: <SRS0=hH57=EK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2AA8C55178
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 00:41:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F86F22404
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 00:41:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Up3vRmok"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F86F22404
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41872 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ka6rb-0003E2-8f
	for qemu-devel@archiver.kernel.org; Tue, 03 Nov 2020 19:41:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35208)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1ka6ml-00060i-Fb
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 19:36:23 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:47623)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1ka6mi-0004n7-S7
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 19:36:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604450179;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pWo0qZcLTd/XRbHuj4Syg08TijkYWoqG5hzND40eqf0=;
 b=Up3vRmokQth1FmeOTEjQmX267u8osDsOIN+E/Zdc6uedGcaGabVQGG+374B+L/GYER2psf
 Jyy0Z9cz7l1zZsa+5atADfjG9shOX+siR8VqXWsKpSIVw9jv2S+ySx97KxOLQIUeRFAiQo
 YqapBapZhGtDDwCmlR4wa+ZOd0LO598=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-62-jp0Ox0YSPpWHkoCKtISfbg-1; Tue, 03 Nov 2020 19:36:16 -0500
X-MC-Unique: jp0Ox0YSPpWHkoCKtISfbg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E592018A2257
 for <qemu-devel@nongnu.org>; Wed,  4 Nov 2020 00:36:15 +0000 (UTC)
Received: from scv.redhat.com (ovpn-119-97.rdu2.redhat.com [10.10.119.97])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1DF0A55766;
 Wed,  4 Nov 2020 00:36:15 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 03/72] scripts/qmp: redirect qom-xxx scripts to
 python/qemu/qmp/
Date: Tue,  3 Nov 2020 19:34:53 -0500
Message-Id: <20201104003602.1293560-4-jsnow@redhat.com>
In-Reply-To: <20201104003602.1293560-1-jsnow@redhat.com>
References: <20201104003602.1293560-1-jsnow@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jsnow@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/03 01:02:05
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Cleber Rosa <crosa@redhat.com>, John Snow <jsnow@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Redirect to the new qom scripts. These forwarders can be deleted
eventually when there has been more time for the dust on the Python
packaging to settle and people understand how to find these commands.

Note: You can run these by setting $PYTHONPATH in your shell and then
running "python3 -m qemu.qmp.qom", or you can install the qemu namespace
package and use the "qom" or "qom-set" scripts.

I've written how to install the package elsewhere, but for the sake of
git-blame, cd to ./python, and then do:

- pip3 install [--user] [-e] .

--user will install to your local user install (will not work inside of
  a venv), omitting this flag installs to your system-wide packages
  (outside of a venv) or to your current virtual environment (inside the
  venv).

  When installing to a venv or to your system-wide packages, "qom"
  should be in your $PATH already. If you do a user install, you may
  need to add ~/.local/bin to your $PATH if you haven't already.

-e installs in editable mode: the installed package is effectively just
 a symlink to this folder; so changes to your git working tree are
 reflected in the installed package.

Alternatively to the above, If you have `pipenv` installed (`pip3
install --user pipenv`), you may also invoke 'pipenv shell' to enter a
pipenv-managed virtual environment (as a shell process that you may
leave with ctrt+d) that has 'qom' already in $PATH.

Signed-off-by: John Snow <jsnow@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 scripts/qmp/qom-get  | 66 +++------------------------------------
 scripts/qmp/qom-list | 63 +++----------------------------------
 scripts/qmp/qom-set  | 63 +++----------------------------------
 scripts/qmp/qom-tree | 74 +++-----------------------------------------
 4 files changed, 16 insertions(+), 250 deletions(-)

diff --git a/scripts/qmp/qom-get b/scripts/qmp/qom-get
index 666df718320c..e4f3e0c01381 100755
--- a/scripts/qmp/qom-get
+++ b/scripts/qmp/qom-get
@@ -1,69 +1,11 @@
 #!/usr/bin/env python3
-##
-# QEMU Object Model test tools
-#
-# Copyright IBM, Corp. 2011
-#
-# Authors:
-#  Anthony Liguori   <aliguori@us.ibm.com>
-#
-# This work is licensed under the terms of the GNU GPL, version 2 or later.  See
-# the COPYING file in the top-level directory.
-##
 
-import sys
 import os
+import sys
 
 sys.path.append(os.path.join(os.path.dirname(__file__), '..', '..', 'python'))
-from qemu.qmp import QEMUMonitorProtocol
+from qemu.qmp.qom import QOMGet
 
-cmd, args = sys.argv[0], sys.argv[1:]
-socket_path = None
-path = None
-prop = None
 
-def usage():
-    return '''environment variables:
-    QMP_SOCKET=<path | addr:port>
-usage:
-    %s [-h] [-s <QMP socket path | addr:port>] <path>.<property>
-''' % cmd
-
-def usage_error(error_msg = "unspecified error"):
-    sys.stderr.write('%s\nERROR: %s\n' % (usage(), error_msg))
-    exit(1)
-
-if len(args) > 0:
-    if args[0] == "-h":
-        print(usage())
-        exit(0);
-    elif args[0] == "-s":
-        try:
-            socket_path = args[1]
-        except:
-            usage_error("missing argument: QMP socket path or address");
-        args = args[2:]
-
-if not socket_path:
-    if 'QMP_SOCKET' in os.environ:
-        socket_path = os.environ['QMP_SOCKET']
-    else:
-        usage_error("no QMP socket path or address given");
-
-if len(args) > 0:
-    try:
-        path, prop = args[0].rsplit('.', 1)
-    except:
-        usage_error("invalid format for path/property/value")
-else:
-    usage_error("not enough arguments")
-
-srv = QEMUMonitorProtocol(socket_path)
-srv.connect()
-
-rsp = srv.command('qom-get', path=path, property=prop)
-if type(rsp) == dict:
-    for i in rsp.keys():
-        print('%s: %s' % (i, rsp[i]))
-else:
-    print(rsp)
+if __name__ == '__main__':
+    sys.exit(QOMGet.entry_point())
diff --git a/scripts/qmp/qom-list b/scripts/qmp/qom-list
index 5074fd939f4a..7a071a54e1e7 100755
--- a/scripts/qmp/qom-list
+++ b/scripts/qmp/qom-list
@@ -1,66 +1,11 @@
 #!/usr/bin/env python3
-##
-# QEMU Object Model test tools
-#
-# Copyright IBM, Corp. 2011
-#
-# Authors:
-#  Anthony Liguori   <aliguori@us.ibm.com>
-#
-# This work is licensed under the terms of the GNU GPL, version 2 or later.  See
-# the COPYING file in the top-level directory.
-##
 
-import sys
 import os
+import sys
 
 sys.path.append(os.path.join(os.path.dirname(__file__), '..', '..', 'python'))
-from qemu.qmp import QEMUMonitorProtocol
+from qemu.qmp.qom import QOMList
 
-cmd, args = sys.argv[0], sys.argv[1:]
-socket_path = None
-path = None
-prop = None
 
-def usage():
-    return '''environment variables:
-    QMP_SOCKET=<path | addr:port>
-usage:
-    %s [-h] [-s <QMP socket path | addr:port>] [<path>]
-''' % cmd
-
-def usage_error(error_msg = "unspecified error"):
-    sys.stderr.write('%s\nERROR: %s\n' % (usage(), error_msg))
-    exit(1)
-
-if len(args) > 0:
-    if args[0] == "-h":
-        print(usage())
-        exit(0);
-    elif args[0] == "-s":
-        try:
-            socket_path = args[1]
-        except:
-            usage_error("missing argument: QMP socket path or address");
-        args = args[2:]
-
-if not socket_path:
-    if 'QMP_SOCKET' in os.environ:
-        socket_path = os.environ['QMP_SOCKET']
-    else:
-        usage_error("no QMP socket path or address given");
-
-srv = QEMUMonitorProtocol(socket_path)
-srv.connect()
-
-if len(args) == 0:
-    print('/')
-    sys.exit(0)
-
-for item in srv.command('qom-list', path=args[0]):
-    if item['type'].startswith('child<'):
-        print('%s/' % item['name'])
-    elif item['type'].startswith('link<'):
-        print('@%s/' % item['name'])
-    else:
-        print('%s' % item['name'])
+if __name__ == '__main__':
+    sys.exit(QOMList.entry_point())
diff --git a/scripts/qmp/qom-set b/scripts/qmp/qom-set
index 240a78187f9b..9ca9e2ba106b 100755
--- a/scripts/qmp/qom-set
+++ b/scripts/qmp/qom-set
@@ -1,66 +1,11 @@
 #!/usr/bin/env python3
-##
-# QEMU Object Model test tools
-#
-# Copyright IBM, Corp. 2011
-#
-# Authors:
-#  Anthony Liguori   <aliguori@us.ibm.com>
-#
-# This work is licensed under the terms of the GNU GPL, version 2 or later.  See
-# the COPYING file in the top-level directory.
-##
 
-import sys
 import os
+import sys
 
 sys.path.append(os.path.join(os.path.dirname(__file__), '..', '..', 'python'))
-from qemu.qmp import QEMUMonitorProtocol
+from qemu.qmp.qom import QOMSet
 
-cmd, args = sys.argv[0], sys.argv[1:]
-socket_path = None
-path = None
-prop = None
-value = None
 
-def usage():
-    return '''environment variables:
-    QMP_SOCKET=<path | addr:port>
-usage:
-    %s [-h] [-s <QMP socket path | addr:port>] <path>.<property> <value>
-''' % cmd
-
-def usage_error(error_msg = "unspecified error"):
-    sys.stderr.write('%s\nERROR: %s\n' % (usage(), error_msg))
-    exit(1)
-
-if len(args) > 0:
-    if args[0] == "-h":
-        print(usage())
-        exit(0);
-    elif args[0] == "-s":
-        try:
-            socket_path = args[1]
-        except:
-            usage_error("missing argument: QMP socket path or address");
-        args = args[2:]
-
-if not socket_path:
-    if 'QMP_SOCKET' in os.environ:
-        socket_path = os.environ['QMP_SOCKET']
-    else:
-        usage_error("no QMP socket path or address given");
-
-if len(args) > 1:
-    try:
-        path, prop = args[0].rsplit('.', 1)
-    except:
-        usage_error("invalid format for path/property/value")
-    value = args[1]
-else:
-    usage_error("not enough arguments")
-
-srv = QEMUMonitorProtocol(socket_path)
-srv.connect()
-
-print(srv.command('qom-set', path=path, property=prop, value=value))
+if __name__ == '__main__':
+    sys.exit(QOMSet.entry_point())
diff --git a/scripts/qmp/qom-tree b/scripts/qmp/qom-tree
index 25b0781323cc..7d0ccca3a4dd 100755
--- a/scripts/qmp/qom-tree
+++ b/scripts/qmp/qom-tree
@@ -1,77 +1,11 @@
 #!/usr/bin/env python3
-##
-# QEMU Object Model test tools
-#
-# Copyright IBM, Corp. 2011
-# Copyright (c) 2013 SUSE LINUX Products GmbH
-#
-# Authors:
-#  Anthony Liguori   <aliguori@amazon.com>
-#  Andreas Faerber   <afaerber@suse.de>
-#
-# This work is licensed under the terms of the GNU GPL, version 2 or later.  See
-# the COPYING file in the top-level directory.
-##
 
-import sys
 import os
+import sys
 
 sys.path.append(os.path.join(os.path.dirname(__file__), '..', '..', 'python'))
-from qemu.qmp import QEMUMonitorProtocol
+from qemu.qmp.qom import QOMTree
 
-cmd, args = sys.argv[0], sys.argv[1:]
-socket_path = None
-path = None
-prop = None
 
-def usage():
-    return '''environment variables:
-    QMP_SOCKET=<path | addr:port>
-usage:
-    %s [-h] [-s <QMP socket path | addr:port>] [<path>]
-''' % cmd
-
-def usage_error(error_msg = "unspecified error"):
-    sys.stderr.write('%s\nERROR: %s\n' % (usage(), error_msg))
-    exit(1)
-
-if len(args) > 0:
-    if args[0] == "-h":
-        print(usage())
-        exit(0);
-    elif args[0] == "-s":
-        try:
-            socket_path = args[1]
-        except:
-            usage_error("missing argument: QMP socket path or address");
-        args = args[2:]
-
-if not socket_path:
-    if 'QMP_SOCKET' in os.environ:
-        socket_path = os.environ['QMP_SOCKET']
-    else:
-        usage_error("no QMP socket path or address given");
-
-srv = QEMUMonitorProtocol(socket_path)
-srv.connect()
-
-def list_node(path):
-    print('%s' % path)
-    items = srv.command('qom-list', path=path)
-    for item in items:
-        if not item['type'].startswith('child<'):
-            try:
-                print('  %s: %s (%s)' % (item['name'], srv.command('qom-get', path=path, property=item['name']), item['type']))
-            except:
-                print('  %s: <EXCEPTION> (%s)' % (item['name'], item['type']))
-    print('')
-    for item in items:
-        if item['type'].startswith('child<'):
-            list_node((path if (path != '/') else '')  + '/' + item['name'])
-
-if len(args) == 0:
-    path = '/'
-else:
-    path = args[0]
-
-list_node(path)
+if __name__ == '__main__':
+    sys.exit(QOMTree.entry_point())
-- 
2.26.2


