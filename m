Return-Path: <SRS0=zj/5=4O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DF49C4BA0B
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 11:58:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 48A8724684
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 11:58:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dbmNk0IV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48A8724684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43198 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6vL2-0000jG-CS
	for qemu-devel@archiver.kernel.org; Wed, 26 Feb 2020 06:58:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39253)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ovoshcha@redhat.com>) id 1j6vK4-0007mC-Bo
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 06:57:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ovoshcha@redhat.com>) id 1j6vK2-0000K7-5P
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 06:57:52 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:58665
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ovoshcha@redhat.com>) id 1j6vK2-0000Gk-0p
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 06:57:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582718269;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/TvQ0iHXZ1hJ2ThIawEHE+YDl4xRkzH85zp+EiAeC2Q=;
 b=dbmNk0IVgT5fZSVDEEFiX0qP3i+OSKiJzbR9LejVk04JeIPb6fExbxla8b5lCKrBWKnMOR
 IV82muAc4ftOtd5T9jWREDrBOMwGkB9/dkDishwqQdkViBSumBS56kkb6uSe+EPdAtJinI
 uob7K4uRziFmWTKT7+urjopVKgk3qD8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-58-740QFTS0Mlmz6Kvf5Wfy2w-1; Wed, 26 Feb 2020 06:57:43 -0500
X-MC-Unique: 740QFTS0Mlmz6Kvf5Wfy2w-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9DEC9800D54
 for <qemu-devel@nongnu.org>; Wed, 26 Feb 2020 11:57:42 +0000 (UTC)
Received: from kh066.redhat.com (ovpn-117-106.ams2.redhat.com [10.36.117.106])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E517A5C102;
 Wed, 26 Feb 2020 11:57:40 +0000 (UTC)
From: Oksana Vohchana <ovoshcha@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 1/3] python/qemu/machine: Adding functions _send_fds and
 _recv_fds
Date: Wed, 26 Feb 2020 13:57:33 +0200
Message-Id: <20200226115735.857-2-ovoshcha@redhat.com>
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

To pass the fd via SCM_RIGHT we should use socket_scm_helper file. And the
path to it file should be provided on starting the virtual machine.
For acceptance tests, this is not convenient, but sometimes not possible to
get this binary file during the testing.
This patch provides new possibilities to send or receive data through the
Unix domain socket file descriptor.
This is useful for obtaining a socket that belongs to a different
network namespace.

Signed-off-by: Oksana Vohchana <ovoshcha@redhat.com>
---
 python/qemu/machine.py | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/python/qemu/machine.py b/python/qemu/machine.py
index 183d8f3d38..976316e5f5 100644
--- a/python/qemu/machine.py
+++ b/python/qemu/machine.py
@@ -24,6 +24,7 @@ import subprocess
 import shutil
 import socket
 import tempfile
+import array
=20
 from . import qmp
=20
@@ -155,6 +156,29 @@ class QEMUMachine(object):
         self._args.append(','.join(options))
         return self
=20
+    def _recv_fds(self, sock, msglen=3D8192, maxfds=3D4096):
+        """
+        Function from:
+        https://docs.python.org/3/library/socket.html#socket.socket.recvms=
g
+        """
+        fds =3D array.array("i")
+        msg, ancdata, flags, addr =3D sock.recvmsg(msglen, socket.CMSG_LEN=
(
+            maxfds * fds.itemsize))
+        for cmsg_level, cmsg_type, cmsg_data in ancdata:
+            if (cmsg_level =3D=3D socket.SOL_SOCKET and
+                    cmsg_type =3D=3D socket.SCM_RIGHTS):
+                fds.frombytes(cmsg_data[:len(cmsg_data) - (len(cmsg_data)
+                    % fds.itemsize)])
+        return msg, list(fds)
+
+    def _send_fds(self, sock, msg, fds):
+        """
+        Function from:
+        https://docs.python.org/3/library/socket.html#socket.socket.sendms=
g
+        """
+        return sock.sendmsg([msg], [(socket.SOL_SOCKET, socket.SCM_RIGHTS,
+                                      array.array("i", fds))])
+
     def send_fd_scm(self, fd=3DNone, file_path=3DNone):
         """
         Send an fd or file_path to socket_scm_helper.
--=20
2.21.1


