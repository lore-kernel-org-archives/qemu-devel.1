Return-Path: <SRS0=d4IR=4I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A110C11D05
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2020 15:13:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1A66F208CD
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2020 15:13:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dNAOU9kN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A66F208CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44078 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4nVj-000609-8w
	for qemu-devel@archiver.kernel.org; Thu, 20 Feb 2020 10:13:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46605)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ovoshcha@redhat.com>) id 1j4nTc-0002jD-0Z
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 10:10:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ovoshcha@redhat.com>) id 1j4nTa-0006qA-PR
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 10:10:55 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:41957
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ovoshcha@redhat.com>) id 1j4nTa-0006nV-La
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 10:10:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582211453;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yMcsuqrYa1e/c6WIxi9XC5EJlGhyeHPg8JOTNTCllQ8=;
 b=dNAOU9kNtnXOIG6zeHm63Xv8XC3s6N1Jt+EvBReH3JeK5qyKF89Eb8HI0XWVXG7E921iyI
 c5e77c0wI5ft951TulYVQYwH9YQEkAaMpBKjZ7Blj4tijuB/0BfS28OtfjmUNQ/Ipi0BEt
 +ioGXqS8bsSWm5g5ZKE8nwTrppcaZc4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-97-ns8n_V4hOvmoE9yMw6s2hA-1; Thu, 20 Feb 2020 10:10:48 -0500
X-MC-Unique: ns8n_V4hOvmoE9yMw6s2hA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 08D8B1937FC9
 for <qemu-devel@nongnu.org>; Thu, 20 Feb 2020 15:10:47 +0000 (UTC)
Received: from kh066.redhat.com (ovpn-204-205.brq.redhat.com [10.40.204.205])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 602C38ED1E;
 Thu, 20 Feb 2020 15:10:45 +0000 (UTC)
From: Oksana Vohchana <ovoshcha@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 1/3] Adding functions _send_fds and _recv_fds
Date: Thu, 20 Feb 2020 17:10:37 +0200
Message-Id: <20200220151039.20552-2-ovoshcha@redhat.com>
In-Reply-To: <20200220151039.20552-1-ovoshcha@redhat.com>
References: <20200220151039.20552-1-ovoshcha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
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

It provides new possibilities to send or receive data through the Unix doma=
in
socket file descriptor.
This is useful for obtaining a socket that belongs to a different network
namespace.

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


