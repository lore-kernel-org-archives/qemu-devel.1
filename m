Return-Path: <SRS0=cs6B=3X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3F05C3524D
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 08:01:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C02D12080D
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 08:01:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NMHnZyKk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C02D12080D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35810 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iyWfg-00028V-W1
	for qemu-devel@archiver.kernel.org; Mon, 03 Feb 2020 03:01:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55387)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ldoktor@redhat.com>) id 1iyWeg-00016J-N8
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 03:00:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ldoktor@redhat.com>) id 1iyWee-00009V-Gp
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 03:00:26 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:51163
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ldoktor@redhat.com>) id 1iyWed-00007P-CC
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 03:00:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580716822;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=xkBoonYcKRQROr+DRp42k1MGbfmZikdv142cBq+qw84=;
 b=NMHnZyKkiJU/XM3HCjT+aU4s/DFcX1AdVFjpMxLv7NQhzZHn6eYFO2EET6AqqYgo1e4dpl
 ZD0ftzqOmXCyBybgm2owKCm/empEeSY7ZEzd0899wPPcRyvgeweuj0qNLYfKRWutZiyns6
 4JNZHSqHEk5YVGjXDWVjI4eFow30uQQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-109-CJKEbaBiMVm59YndRjsmbA-1; Mon, 03 Feb 2020 03:00:16 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 07CCD8024DC;
 Mon,  3 Feb 2020 08:00:15 +0000 (UTC)
Received: from localhost.localdomain (ovpn-204-124.brq.redhat.com
 [10.40.204.124])
 by smtp.corp.redhat.com (Postfix) with ESMTP id ADEAF89F30;
 Mon,  3 Feb 2020 08:00:05 +0000 (UTC)
From: =?UTF-8?q?Luk=C3=A1=C5=A1=20Doktor?= <ldoktor@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH] tests/qemu_iotests: Minimize usage of used ports
Date: Mon,  3 Feb 2020 08:59:55 +0100
Message-Id: <20200203075955.28861-1-ldoktor@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: CJKEbaBiMVm59YndRjsmbA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: ldoktor@redhat.com, kwolf@redhat.com, qemu-devel@nongnu.org,
 mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Using a range of ports from 32768 to 65538 is dangerous as some
application might already be listening there and interfere with the
testing. There is no way to reserve ports, but let's decrease the chance
of interactions by only using ports that were free at the time of
importing this module.

Without this patch CI occasionally fails with used ports. Additionally I
tried listening on the first port to be tried via "nc -l localhost
$port" and no matter how many other ports were available it always
hanged for infinity.

Signed-off-by: Luk=C3=A1=C5=A1 Doktor <ldoktor@redhat.com>
---
 tests/qemu-iotests/147        | 43 ++++++++++++++++-------
 tests/qemu-iotests/iotests.py | 64 +++++++++++++++++++++++++++++++++++
 2 files changed, 94 insertions(+), 13 deletions(-)

diff --git a/tests/qemu-iotests/147 b/tests/qemu-iotests/147
index 2b6f859a09..4d0e1418bb 100755
--- a/tests/qemu-iotests/147
+++ b/tests/qemu-iotests/147
@@ -26,10 +26,8 @@ import time
 import iotests
 from iotests import cachemode, aiomode, imgfmt, qemu_img, qemu_nbd, qemu_n=
bd_early_pipe
=20
-NBD_PORT_START      =3D 32768
-NBD_PORT_END        =3D NBD_PORT_START + 1024
-NBD_IPV6_PORT_START =3D NBD_PORT_END
-NBD_IPV6_PORT_END   =3D NBD_IPV6_PORT_START + 1024
+NBD_PORTS =3D iotests.find_free_ports(32768, 65536, 1024)
+NBD_IPV6_PORTS =3D iotests.find_free_ports(NBD_PORTS[-1] + 1, 65536, 1024)
=20
 test_img =3D os.path.join(iotests.test_dir, 'test.img')
 unix_socket =3D os.path.join(iotests.sock_dir, 'nbd.socket')
@@ -104,11 +102,15 @@ class QemuNBD(NBDBlockdevAddBase):
         self.assertTrue(self._try_server_up(*args))
=20
     def test_inet(self):
-        while True:
-            nbd_port =3D random.randrange(NBD_PORT_START, NBD_PORT_END)
+        nbd_port =3D None
+        nbd_ports =3D NBD_PORTS[:]
+        random.shuffle(nbd_ports)
+        for nbd_port in nbd_ports:
             if self._try_server_up('-b', 'localhost', '-p', str(nbd_port))=
:
                 break
-
+        else:
+            raise AssertionError("NBD not listening on any port: %s"
+                                 % NBD_PORTS)
         address =3D { 'type': 'inet',
                     'data': {
                         'host': 'localhost',
@@ -178,8 +180,10 @@ class BuiltinNBD(NBDBlockdevAddBase):
         self.assert_qmp(result, 'return', {})
=20
     def do_test_inet(self, export_name=3DNone):
-        while True:
-            nbd_port =3D random.randrange(NBD_PORT_START, NBD_PORT_END)
+        nbd_port =3D None
+        nbd_ports =3D NBD_PORTS[:]
+        random.shuffle(nbd_ports)
+        for nbd_port in nbd_ports:
             address =3D { 'type': 'inet',
                         'data': {
                             'host': 'localhost',
@@ -187,6 +191,9 @@ class BuiltinNBD(NBDBlockdevAddBase):
                         } }
             if self._try_server_up(address, export_name):
                 break
+        else:
+            raise AssertionError("NBD not listening on any port: %s"
+                                 % NBD_PORTS)
=20
         export_name =3D export_name or 'nbd-export'
         self.client_test('nbd://localhost:%i/%s' % (nbd_port, export_name)=
,
@@ -203,8 +210,10 @@ class BuiltinNBD(NBDBlockdevAddBase):
         self.do_test_inet('shadow')
=20
     def test_inet_two_exports(self):
-        while True:
-            nbd_port =3D random.randrange(NBD_PORT_START, NBD_PORT_END)
+        nbd_port =3D None
+        nbd_ports =3D NBD_PORTS[:]
+        random.shuffle(nbd_ports)
+        for nbd_port in nbd_ports:
             address =3D { 'type': 'inet',
                         'data': {
                             'host': 'localhost',
@@ -212,6 +221,9 @@ class BuiltinNBD(NBDBlockdevAddBase):
                         } }
             if self._try_server_up(address, 'exp1', 'exp2'):
                 break
+        else:
+            raise AssertionError("NBD not listening on any port: %s"
+                                 % NBD_PORTS)
=20
         self.client_test('nbd://localhost:%i/%s' % (nbd_port, 'exp1'),
                          flatten_sock_addr(address), 'exp1', 'node1', Fals=
e)
@@ -232,8 +244,10 @@ class BuiltinNBD(NBDBlockdevAddBase):
             # IPv6 not available, skip
             return
=20
-        while True:
-            nbd_port =3D random.randrange(NBD_IPV6_PORT_START, NBD_IPV6_PO=
RT_END)
+        nbd_port =3D None
+        nbd_ports =3D NBD_IPV6_PORTS[:]
+        random.shuffle(nbd_ports)
+        for nbd_port in nbd_ports:
             address =3D { 'type': 'inet',
                         'data': {
                             'host': '::1',
@@ -243,6 +257,9 @@ class BuiltinNBD(NBDBlockdevAddBase):
                         } }
             if self._try_server_up(address):
                 break
+        else:
+            raise AssertionError("NBD not listening on any port: %s"
+                                 % NBD_IPV6_PORTS)
=20
         filename =3D { 'driver': 'raw',
                      'file': {
diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests.py
index 89aa2df2f3..d5a3ce2d39 100644
--- a/tests/qemu-iotests/iotests.py
+++ b/tests/qemu-iotests/iotests.py
@@ -20,6 +20,7 @@ from __future__ import print_function
 import errno
 import os
 import re
+import socket
 import subprocess
 import string
 import unittest
@@ -75,6 +76,69 @@ luks_default_secret_object =3D 'secret,id=3Dkeysec0,data=
=3D' + \
 luks_default_key_secret_opt =3D 'key-secret=3Dkeysec0'
=20
=20
+def is_port_free(port, address):
+    """
+    Return True if the given port is available for use.
+
+    Currently we only check for TCP/UDP connections on IPv4/6
+    Backported from avocado.utils.network
+
+    :param port: Port number
+    :param address: Socket address to bind or connect
+    """
+    families =3D (socket.AF_INET, socket.AF_INET6)
+    if address =3D=3D "localhost" or not address:
+        localhost =3D True
+        protocols =3D (socket.SOCK_STREAM, socket.SOCK_DGRAM)
+    else:
+        localhost =3D False
+        # sock.connect always connects for UDP
+        protocols =3D (socket.SOCK_STREAM, )
+    sock =3D None
+    try:
+        for family in families:
+            for protocol in protocols:
+                try:
+                    sock =3D socket.socket(family, protocol)
+                    if localhost:
+                        sock.bind(("", port))
+                    else:
+                        sock.connect((address, port))
+                        return False
+                except socket.error as exc:
+                    if exc.errno in (93, 94):   # Unsupported combinations
+                        continue
+                    if localhost:
+                        return False
+                sock.close()
+        return True
+    finally:
+        if sock is not None:
+            sock.close()
+
+
+def find_free_ports(start_port, end_port, count, address=3D"localhost"):
+    """
+    Return count of host free ports in the range [start_port, end_port].
+
+    Backported from avocado.utils.network
+
+    :param start_port: header of candidate port range
+    :param end_port: ender of candidate port range
+    :param count: Initial number of ports known to be free in the range.
+    :param address: Socket address to bind or connect
+    """
+    ports =3D []
+    port_range =3D range(start_port, end_port)
+    for i in port_range:
+        if is_port_free(i, address):
+            ports.append(i)
+        if len(ports) >=3D count:
+            break
+
+    return ports
+
+
 def qemu_img(*args):
     '''Run qemu-img and return the exit code'''
     devnull =3D open('/dev/null', 'r+')
--=20
2.21.1


