Return-Path: <SRS0=d4IR=4I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C3ECC11D05
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2020 15:13:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5BA44208CD
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2020 15:13:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S5SVQy/3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5BA44208CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44080 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4nVp-00067d-JD
	for qemu-devel@archiver.kernel.org; Thu, 20 Feb 2020 10:13:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46626)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ovoshcha@redhat.com>) id 1j4nTd-0002m8-RQ
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 10:10:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ovoshcha@redhat.com>) id 1j4nTb-0006sz-LC
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 10:10:57 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:28030
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ovoshcha@redhat.com>) id 1j4nTb-0006ri-HC
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 10:10:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582211455;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=heDlndT4Vn36W18ursSUZuZUPiNVz/9nzMrCO7RbA5E=;
 b=S5SVQy/3N83sN1KFtt3C5Qo5ZHXKPLmi94ozI6iTOAIem/rSFPMUqni7+czYTheBWQaOEJ
 eX6D6ys1yIpdlXzhtcfapVkmK3cDRrfqMrVjQqGOkpaeBLSQaLSscdFaHiCd+TWdP64HxY
 YuzPKNMgPtN/+HvTJOWDXk90cmrnuGo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-337-vSbbs7lWMvWHTW8IDydEdQ-1; Thu, 20 Feb 2020 10:10:50 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 104B58017CC
 for <qemu-devel@nongnu.org>; Thu, 20 Feb 2020 15:10:49 +0000 (UTC)
Received: from kh066.redhat.com (ovpn-204-205.brq.redhat.com [10.40.204.205])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 67BB18ECFC;
 Thu, 20 Feb 2020 15:10:47 +0000 (UTC)
From: Oksana Vohchana <ovoshcha@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 2/3] Updates send_fd_scm function
Date: Thu, 20 Feb 2020 17:10:38 +0200
Message-Id: <20200220151039.20552-3-ovoshcha@redhat.com>
In-Reply-To: <20200220151039.20552-1-ovoshcha@redhat.com>
References: <20200220151039.20552-1-ovoshcha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: vSbbs7lWMvWHTW8IDydEdQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
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
Cc: ovoshcha@redhat.com, philmd@redhat.com, ehabkost@redhat.com,
 wainersm@redhat.com, crosa@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

A qemu-iotest uses for FD-migration test a helper program "socket_scm_helpe=
r".
And it makes some problems if you didn't build it with a QEMU. And now we c=
an
use new methods for the socket that allow us to send a file/socket descript=
or
(with access and permissions) from one process to another.

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


