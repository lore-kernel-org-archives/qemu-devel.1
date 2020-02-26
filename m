Return-Path: <SRS0=zj/5=4O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDC1EC4BA10
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 11:58:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9DAA924684
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 11:58:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Rg6fMg6r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9DAA924684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43200 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6vL2-0000kp-N4
	for qemu-devel@archiver.kernel.org; Wed, 26 Feb 2020 06:58:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39266)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ovoshcha@redhat.com>) id 1j6vK4-0007mc-OM
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 06:57:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ovoshcha@redhat.com>) id 1j6vK3-0000LY-Dj
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 06:57:52 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:44868
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ovoshcha@redhat.com>) id 1j6vK3-0000L2-9x
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 06:57:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582718270;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cZZZFtNgFSqSUAScMorUibiLokP5MDGEpCKyOnxM8iM=;
 b=Rg6fMg6rlDSYbQMX9ms6BGONACs66JMmA1fT/XmnSnVtYWD3l0MAFh97NqEdLFfi22S8se
 1Z1mY6IVWUgVOTVEhmDux8/2IKMUOK4nbDRsG014GMCUIzoMIF8JNFJl1/uz048Ht187Lg
 Un/m4Dth7wJ7ipv//132yYhut0wnVPw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-290-Klkcf9kkPBGIU3rnYdZYNA-1; Wed, 26 Feb 2020 06:57:45 -0500
X-MC-Unique: Klkcf9kkPBGIU3rnYdZYNA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AD81B107ACCA
 for <qemu-devel@nongnu.org>; Wed, 26 Feb 2020 11:57:44 +0000 (UTC)
Received: from kh066.redhat.com (ovpn-117-106.ams2.redhat.com [10.36.117.106])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 09B765C102;
 Wed, 26 Feb 2020 11:57:42 +0000 (UTC)
From: Oksana Vohchana <ovoshcha@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 2/3] python/qemu/machine: Updates send_fd_scm function
Date: Wed, 26 Feb 2020 13:57:34 +0200
Message-Id: <20200226115735.857-3-ovoshcha@redhat.com>
In-Reply-To: <20200226115735.857-1-ovoshcha@redhat.com>
References: <20200226115735.857-1-ovoshcha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: ovoshcha@redhat.com, philmd@redhat.com, ehabkost@redhat.com,
 wainersm@redhat.com, crosa@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This patch upgrades the send_fd_scm function to use it in way if not provid=
e
socket_scm_helper. It uses new provided functions  _send_fds and _recv_fds =
that
depend on FD's and data that allow us to send a file/socket descriptor
(with access and permissions) from one process to another.
The parameter data include qmp message like getfd or add-fd.

Signed-off-by: Oksana Vohchana <ovoshcha@redhat.com>
---
 python/qemu/machine.py | 64 ++++++++++++++++++++++++++----------------
 1 file changed, 40 insertions(+), 24 deletions(-)

diff --git a/python/qemu/machine.py b/python/qemu/machine.py
index 976316e5f5..906ca118db 100644
--- a/python/qemu/machine.py
+++ b/python/qemu/machine.py
@@ -179,20 +179,27 @@ class QEMUMachine(object):
         return sock.sendmsg([msg], [(socket.SOL_SOCKET, socket.SCM_RIGHTS,
                                       array.array("i", fds))])
=20
-    def send_fd_scm(self, fd=3DNone, file_path=3DNone):
+    def send_fd_scm(self, fd=3DNone, file_path=3DNone, data=3DNone):
         """
-        Send an fd or file_path to socket_scm_helper.
+        Can be used in two different cases.
+        Send an fd or file_path to socket_scm_helper or
+        provide data and fd to send it to the socket.
=20
-        Exactly one of fd and file_path must be given.
-        If it is file_path, the helper will open that file and pass its ow=
n fd.
+        Exactly one of fd and file_path must be given to the case of
+        socket_scm_helper. If it is file_path, the helper will open that f=
ile
+        and pass its own fd.
+
+        To second case need adds data that include a QMP request and fd
         """
         # In iotest.py, the qmp should always use unix socket.
         assert self._qmp.is_scm_available()
-        if self._socket_scm_helper is None:
-            raise QEMUMachineError("No path to socket_scm_helper set")
-        if not os.path.exists(self._socket_scm_helper):
-            raise QEMUMachineError("%s does not exist" %
-                                   self._socket_scm_helper)
+        if data is None:
+            if self._socket_scm_helper is None:
+                raise QEMUMachineError(
+                    "No path to socket_scm_helper set or data provided")
+            if not os.path.exists(self._socket_scm_helper):
+                raise QEMUMachineError("%s does not exist" %
+                                       self._socket_scm_helper)
=20
         # This did not exist before 3.4, but since then it is
         # mandatory for our purpose
@@ -201,24 +208,33 @@ class QEMUMachine(object):
             if fd is not None:
                 os.set_inheritable(fd, True)
=20
-        fd_param =3D ["%s" % self._socket_scm_helper,
-                    "%d" % self._qmp.get_sock_fd()]
+        if data is None:
+            fd_param =3D ["%s" % self._socket_scm_helper,
+                        "%d" % self._qmp.get_sock_fd()]
+            if file_path is not None:
+                assert fd is None
+                fd_param.append(file_path)
+            else:
+                assert fd is not None
+                fd_param.append(str(fd))
=20
-        if file_path is not None:
-            assert fd is None
-            fd_param.append(file_path)
-        else:
-            assert fd is not None
-            fd_param.append(str(fd))
+            devnull =3D open(os.path.devnull, 'rb')
+            proc =3D subprocess.Popen(fd_param, stdin=3Ddevnull,
+                                    stdout=3Dsubprocess.PIPE,
+                                    stderr=3Dsubprocess.STDOUT, close_fds=
=3DFalse)
+            output =3D proc.communicate()[0]
+            if output:
+                LOG.debug(output)
=20
-        devnull =3D open(os.path.devnull, 'rb')
-        proc =3D subprocess.Popen(fd_param, stdin=3Ddevnull, stdout=3Dsubp=
rocess.PIPE,
-                                stderr=3Dsubprocess.STDOUT, close_fds=3DFa=
lse)
-        output =3D proc.communicate()[0]
-        if output:
-            LOG.debug(output)
+            return proc.returncode
=20
-        return proc.returncode
+        else:
+            sock_fd =3D socket.fromfd(self._qmp.get_sock_fd(), socket.AF_U=
NIX,
+                                    socket.SOCK_STREAM)
+            fds_param =3D [fd, self._qmp.get_sock_fd()]
+            self._send_fds(sock_fd, data, fds_param)
+            self._recv_fds(sock_fd)
+            return self
=20
     @staticmethod
     def _remove_if_exists(path):
--=20
2.21.1


