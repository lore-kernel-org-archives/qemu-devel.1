Return-Path: <SRS0=aBJE=ZL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 362F5C33C8C
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2019 03:10:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 046892070E
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2019 03:10:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gqLPjaIN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 046892070E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41252 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iWtu2-0003Zx-S9
	for qemu-devel@archiver.kernel.org; Mon, 18 Nov 2019 22:10:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42687)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1iWtsE-0001sI-Ig
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 22:08:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1iWtsB-0004dO-Mg
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 22:08:13 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:54865
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1iWtsB-0004aV-33
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 22:08:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574132887;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=i34Oo7GWbgLMaRioPWWxMyTFZuyFz5Xdmin/1Z00VXI=;
 b=gqLPjaINbKLpHnqlAi7arV+9MLrdGzgwD/FfZn0+1723/Yy2z4856iuMxOQv/YncSiWPvc
 5qR68DXnYBrrjPfw/LHuyDow1yqL7mbDEFIrojU15qKweUoyoN8kL3C8cM5onmezVIvwzG
 kBaOK04xWnGtyFQCGVXO046uOYp6RIA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-261-tTXBiknZOMmPZpoWTidsMA-1; Mon, 18 Nov 2019 22:08:05 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 72D40477;
 Tue, 19 Nov 2019 03:08:03 +0000 (UTC)
Received: from blue.redhat.com (ovpn-116-221.phx2.redhat.com [10.3.116.221])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6C6BF7BFAA;
 Tue, 19 Nov 2019 03:08:02 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 01/10] iotests: Test NBD client reconnection
Date: Mon, 18 Nov 2019 21:07:50 -0600
Message-Id: <20191119030759.24907-2-eblake@redhat.com>
In-Reply-To: <20191119030759.24907-1-eblake@redhat.com>
References: <20191119030759.24907-1-eblake@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: tTXBiknZOMmPZpoWTidsMA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "open list:Block layer core" <qemu-block@nongnu.org>,
 Max Reitz <mreitz@redhat.com>, "Denis V . Lunev" <den@openvz.org>,
 Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>

The test for an NBD client. The NBD server is disconnected after the
client write request. The NBD client should reconnect and complete
the write operation.

Suggested-by: Denis V. Lunev <den@openvz.org>
Suggested-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Tested-by: Eric Blake <eblake@redhat.com>
Message-Id: <1573529976-815699-1-git-send-email-andrey.shinkevich@virtuozzo=
.com>
---
 tests/qemu-iotests/277                   | 96 ++++++++++++++++++++++++
 tests/qemu-iotests/277.out               |  6 ++
 tests/qemu-iotests/group                 |  1 +
 tests/qemu-iotests/iotests.py            |  5 ++
 tests/qemu-iotests/nbd-fault-injector.py |  3 +-
 5 files changed, 110 insertions(+), 1 deletion(-)
 create mode 100755 tests/qemu-iotests/277
 create mode 100644 tests/qemu-iotests/277.out

diff --git a/tests/qemu-iotests/277 b/tests/qemu-iotests/277
new file mode 100755
index 000000000000..1f72dca2d423
--- /dev/null
+++ b/tests/qemu-iotests/277
@@ -0,0 +1,96 @@
+#!/usr/bin/env python
+#
+# Test NBD client reconnection
+#
+# Copyright (c) 2019 Virtuozzo International GmbH
+#
+# This program is free software; you can redistribute it and/or modify
+# it under the terms of the GNU General Public License as published by
+# the Free Software Foundation; either version 2 of the License, or
+# (at your option) any later version.
+#
+# This program is distributed in the hope that it will be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU General Public License for more details.
+#
+# You should have received a copy of the GNU General Public License
+# along with this program.  If not, see <http://www.gnu.org/licenses/>.
+#
+
+import os
+import subprocess
+import iotests
+from iotests import file_path, log
+
+
+nbd_sock, conf_file =3D file_path('nbd-sock', 'nbd-fault-injector.conf')
+
+
+def make_conf_file(event):
+    """
+    Create configuration file for the nbd-fault-injector.py
+
+    :param event: which event the server should close a connection on
+    """
+    with open(conf_file, 'w') as conff:
+        conff.write('[inject-error]\nevent=3D{}\nwhen=3Dafter'.format(even=
t))
+
+
+def start_server_NBD(event):
+    make_conf_file(event)
+
+    srv =3D subprocess.Popen(['nbd-fault-injector.py', '--classic-negotiat=
ion',
+                           nbd_sock, conf_file], stdout=3Dsubprocess.PIPE,
+                           stderr=3Dsubprocess.STDOUT, universal_newlines=
=3DTrue)
+    line =3D srv.stdout.readline()
+    if 'Listening on ' in line:
+        log('NBD server: started')
+    else:
+        log('NBD server: ' + line.rstrip())
+
+    return srv
+
+
+def start_client_NBD():
+    log('NBD client: QEMU-IO write')
+    args =3D iotests.qemu_io_args_no_fmt + \
+        ['-c', 'write -P 0x7 0 3M', '--image-opts',
+         'driver=3Dnbd,server.type=3Dunix,server.path=3D{},'
+         'reconnect-delay=3D7'.format(nbd_sock)]
+    clt =3D subprocess.Popen(args, stdout=3Dsubprocess.PIPE,
+                           stderr=3Dsubprocess.STDOUT,
+                           universal_newlines=3DTrue)
+    return clt
+
+
+def check_proc_NBD(proc, connector):
+    try:
+        outs, errs =3D proc.communicate(timeout=3D10)
+
+        if proc.returncode < 0:
+            log('NBD {}: EXIT SIGNAL {}\n'.format(connector, proc.returnco=
de))
+            log(outs)
+        else:
+            msg =3D outs.split('\n', 1)
+            log('NBD {}: {}'.format(connector, msg[0]))
+
+    except subprocess.TimeoutExpired:
+        proc.kill()
+        log('NBD {}: ERROR timeout expired'.format(connector))
+    finally:
+        if connector =3D=3D 'server':
+            os.remove(nbd_sock)
+            os.remove(conf_file)
+
+
+srv =3D start_server_NBD('data')
+clt =3D start_client_NBD()
+# The server should close the connection after a client write request
+check_proc_NBD(srv, 'server')
+# Start the NBD server again
+srv =3D start_server_NBD('reply')
+# The client should reconnect and complete the write operation
+check_proc_NBD(clt, 'client')
+# Make it sure that server terminated
+check_proc_NBD(srv, 'server')
diff --git a/tests/qemu-iotests/277.out b/tests/qemu-iotests/277.out
new file mode 100644
index 000000000000..45404b34ebcf
--- /dev/null
+++ b/tests/qemu-iotests/277.out
@@ -0,0 +1,6 @@
+NBD server: started
+NBD client: QEMU-IO write
+NBD server: Closing connection on rule match inject-error
+NBD server: started
+NBD client: wrote 3145728/3145728 bytes at offset 0
+NBD server: Closing connection on rule match inject-error
diff --git a/tests/qemu-iotests/group b/tests/qemu-iotests/group
index c56bb6903180..6b10a6a76214 100644
--- a/tests/qemu-iotests/group
+++ b/tests/qemu-iotests/group
@@ -285,3 +285,4 @@
 270 rw backing quick
 272 rw
 273 backing quick
+277 rw quick
diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests.py
index 6a248472b9e2..df0708923d06 100644
--- a/tests/qemu-iotests/iotests.py
+++ b/tests/qemu-iotests/iotests.py
@@ -47,6 +47,11 @@ qemu_io_args =3D [os.environ.get('QEMU_IO_PROG', 'qemu-i=
o')]
 if os.environ.get('QEMU_IO_OPTIONS'):
     qemu_io_args +=3D os.environ['QEMU_IO_OPTIONS'].strip().split(' ')

+qemu_io_args_no_fmt =3D [os.environ.get('QEMU_IO_PROG', 'qemu-io')]
+if os.environ.get('QEMU_IO_OPTIONS_NO_FMT'):
+    qemu_io_args_no_fmt +=3D \
+        os.environ['QEMU_IO_OPTIONS_NO_FMT'].strip().split(' ')
+
 qemu_nbd_args =3D [os.environ.get('QEMU_NBD_PROG', 'qemu-nbd')]
 if os.environ.get('QEMU_NBD_OPTIONS'):
     qemu_nbd_args +=3D os.environ['QEMU_NBD_OPTIONS'].strip().split(' ')
diff --git a/tests/qemu-iotests/nbd-fault-injector.py b/tests/qemu-iotests/=
nbd-fault-injector.py
index 6b2d659dee1f..7e2dab6ea442 100755
--- a/tests/qemu-iotests/nbd-fault-injector.py
+++ b/tests/qemu-iotests/nbd-fault-injector.py
@@ -115,7 +115,8 @@ class FaultInjectionSocket(object):
             if rule.match(event, io):
                 if rule.when =3D=3D 0 or bufsize is None:
                     print('Closing connection on rule match %s' % rule.nam=
e)
-                    self.sock.flush()
+                    self.sock.close()
+                    sys.stdout.flush()
                     sys.exit(0)
                 if rule.when !=3D -1:
                     return rule.when
--=20
2.21.0


