Return-Path: <SRS0=HiY9=4H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22F60C34047
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2020 16:59:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E00782464E
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2020 16:59:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CiBvmbq+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E00782464E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56596 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4ShD-0003Hq-1t
	for qemu-devel@archiver.kernel.org; Wed, 19 Feb 2020 11:59:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41186)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ovoshcha@redhat.com>) id 1j4SIT-0007Ou-5p
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 11:34:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ovoshcha@redhat.com>) id 1j4SIR-0003TP-TJ
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 11:34:01 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:58135
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ovoshcha@redhat.com>) id 1j4SIR-0003T6-Os
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 11:33:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582130039;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ycKK3EZ7C0Wdt+5RE3QVwYTEvg2h7ONgXeE2mgOLxJg=;
 b=CiBvmbq+jpYwAsNHvcUfE5+nJv+RG0wzGA4b70Y3v/865y3MMCJyeqRHFqXOW4LnRDlRwj
 Eo/DBITy+jwGrFmPIdB8gFN3ROeL/TQ7Zw39FAk2F4z3Ml78eUMO7CFFzr8kc355tbRQii
 geZgLaxt4MFNUtx0H5aB1C/haRK3A2g=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-214-uMpzDTJxMjGwzNImdCmXpA-1; Wed, 19 Feb 2020 11:33:53 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 47953101FC67
 for <qemu-devel@nongnu.org>; Wed, 19 Feb 2020 16:33:52 +0000 (UTC)
Received: from kh066.redhat.com (ovpn-205-79.brq.redhat.com [10.40.205.79])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8090560BE1;
 Wed, 19 Feb 2020 16:33:50 +0000 (UTC)
From: Oksana Vohchana <ovoshcha@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/3] Adding functions _send_fds and _recv_fds
Date: Wed, 19 Feb 2020 18:33:42 +0200
Message-Id: <20200219163344.27651-2-ovoshcha@redhat.com>
In-Reply-To: <20200219163344.27651-1-ovoshcha@redhat.com>
References: <20200219163344.27651-1-ovoshcha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: uMpzDTJxMjGwzNImdCmXpA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: philmd@redhat.com, ehabkost@redhat.com, wainersm@redhat.com,
 crosa@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

It provides new possibilities to send or receive data through the Unix doma=
in
socket file descriptor.
This is useful for obtaining a socket that belongs to a different network
namespace.

Signed-off-by: Oksana Vohchana <ovoshcha@redhat.com>
---
 python/qemu/machine.py | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/python/qemu/machine.py b/python/qemu/machine.py
index 183d8f3d38..8c5bd64795 100644
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
@@ -155,6 +156,23 @@ class QEMUMachine(object):
         self._args.append(','.join(options))
         return self
=20
+    def _recv_fds(self, sock, msglen=3D8192, maxfds=3D4096):
+        """
+        Function from https://docs.python.org/3/library/socket.html#socket=
.socket.recvmsg
+        """
+        fds =3D array.array("i")
+        msg, ancdata, flags, addr =3D sock.recvmsg(msglen, socket.CMSG_LEN=
(maxfds * fds.itemsize))
+        for cmsg_level, cmsg_type, cmsg_data in ancdata:
+            if cmsg_level =3D=3D socket.SOL_SOCKET and cmsg_type =3D=3D so=
cket.SCM_RIGHTS:
+                fds.frombytes(cmsg_data[:len(cmsg_data) - (len(cmsg_data) =
% fds.itemsize)])
+        return msg, list(fds)
+
+    def _send_fds(self, sock, msg, fds):
+        """
+        Function from https://docs.python.org/3/library/socket.html#socket=
.socket.sendmsg
+        """
+        return sock.sendmsg([msg], [(socket.SOL_SOCKET, socket.SCM_RIGHTS,=
 array.array("i", fds))])
+
     def send_fd_scm(self, fd=3DNone, file_path=3DNone):
         """
         Send an fd or file_path to socket_scm_helper.
--=20
2.21.1


