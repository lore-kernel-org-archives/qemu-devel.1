Return-Path: <SRS0=37Ja=DO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66EDBC4363D
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 00:13:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E3F11206F0
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 00:13:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q08b7KQ3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3F11206F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57122 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPx5S-0004oB-Hj
	for qemu-devel@archiver.kernel.org; Tue, 06 Oct 2020 20:13:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38902)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kPwrW-0000IF-2u
 for qemu-devel@nongnu.org; Tue, 06 Oct 2020 19:59:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:24645)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kPwrT-0002PV-Hk
 for qemu-devel@nongnu.org; Tue, 06 Oct 2020 19:59:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602028754;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=F4ZYfw0wyKC8llwQk6ARzElo7AwPPnxB7wz0BCPwLXc=;
 b=Q08b7KQ3E4TeGsz5o3WHRR+KZpjM6GMLNYULAGq7+6sOEP/xyyxO9lZ8BwAujUFeMeh330
 sTLWlKGWhzsqEQAUVhQpWmuja/2g0Me8/Msz6bkd2xYf4V+JcjzMdvlrV39zNHciEbp07E
 vVfEXdVB4zhtLhj9loQcZATsayNNzec=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-343-M_FEkTBzO_SqNJ3nrawBlw-1; Tue, 06 Oct 2020 19:59:12 -0400
X-MC-Unique: M_FEkTBzO_SqNJ3nrawBlw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9B3C210866A8;
 Tue,  6 Oct 2020 23:59:10 +0000 (UTC)
Received: from scv.redhat.com (ovpn-120-38.rdu2.redhat.com [10.10.120.38])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9189E60BFA;
 Tue,  6 Oct 2020 23:59:09 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 19/20] python/qemu/qmp.py: Straighten out exception hierarchy
Date: Tue,  6 Oct 2020 19:58:16 -0400
Message-Id: <20201006235817.3280413-20-jsnow@redhat.com>
In-Reply-To: <20201006235817.3280413-1-jsnow@redhat.com>
References: <20201006235817.3280413-1-jsnow@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jsnow@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=216.205.24.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/06 00:55:20
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.733,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Kevin Wolf <kwolf@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Cleber Rosa <crosa@redhat.com>, John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Be a little more rigorous about which exception we use, and when.
Primarily, this makes QMPCapabilitiesError an extension of
QMPprotocolError.

The family of errors:

QMPError (generic base)
  QMPConnectError (For connection issues)
  QMPTimeoutError (when waiting for an event expires)
  QMPProtocolError (unexpected/garbled responses)
    QMPCapabilitiesError (handshake problems)
  QMPResponseError (For in-band QMP error returns)

Signed-off-by: John Snow <jsnow@redhat.com>
---
 python/qemu/qmp.py | 45 ++++++++++++++++++++++++++++++---------------
 1 file changed, 30 insertions(+), 15 deletions(-)

diff --git a/python/qemu/qmp.py b/python/qemu/qmp.py
index bdbd1e9bdbb..1349632c101 100644
--- a/python/qemu/qmp.py
+++ b/python/qemu/qmp.py
@@ -41,7 +41,7 @@
 
 class QMPError(Exception):
     """
-    QMP base exception
+    QMP base exception; all QMP errors derive from this.
     """
 
 
@@ -51,7 +51,13 @@ class QMPConnectError(QMPError):
     """
 
 
-class QMPCapabilitiesError(QMPError):
+class QMPProtocolError(QMPError):
+    """
+    QMP protocol error; unexpected response
+    """
+
+
+class QMPCapabilitiesError(QMPProtocolError):
     """
     QMP negotiate capabilities exception
     """
@@ -63,15 +69,9 @@ class QMPTimeoutError(QMPError):
     """
 
 
-class QMPProtocolError(QMPError):
-    """
-    QMP protocol error; unexpected response
-    """
-
-
 class QMPResponseError(QMPError):
     """
-    Represents erroneous QMP monitor reply
+    Represents in-band QMP replies indicating command failure
     """
     def __init__(self, reply: QMPMessage):
         try:
@@ -125,14 +125,23 @@ def __get_sock(self) -> socket.socket:
         return socket.socket(family, socket.SOCK_STREAM)
 
     def __negotiate_capabilities(self) -> QMPMessage:
+        """
+        @raise QMPConnectError on failure to receive the greeting.
+        @raise QMPCapabilitiesError on malformed greeting, or malformed
+                                    capabilities handshake response.
+        """
         greeting = self.__json_read()
-        if greeting is None or "QMP" not in greeting:
-            raise QMPConnectError
+        if greeting is None:
+            raise QMPConnectError("Did not receive QMP greeting")
+        if 'QMP' not in greeting:
+            msg = f"Did not understand greeting: '{str(greeting)}'"
+            raise QMPCapabilitiesError(msg)
         # Greeting seems ok, negotiate capabilities
         resp = self.cmd('qmp_capabilities')
         if resp and "return" in resp:
             return greeting
-        raise QMPCapabilitiesError
+        msg = "Did not understand capabilities reply"
+        raise QMPCapabilitiesError(f"{msg}: {str(resp)}")
 
     def __json_read(self, only_event: bool = False) -> Optional[QMPMessage]:
         assert self.__sockfile is not None
@@ -158,10 +167,12 @@ def __get_events(self, wait: Union[bool, float] = False) -> None:
         @param wait (bool): block until an event is available.
         @param wait (float): If wait is a float, treat it as a timeout value.
 
+        @raise OSError: For backing socket connection errors
         @raise QMPTimeoutError: If a timeout float is provided and the timeout
                                 period elapses.
         @raise QMPConnectError: If wait is True but no events could be
                                 retrieved or if some other error occurred.
+        @raise QMPProtocolError: If a garbled message is received.
         """
 
         # Check for new events regardless and pull them into the cache:
@@ -187,7 +198,7 @@ def __get_events(self, wait: Union[bool, float] = False) -> None:
                 msg = "Error while reading from socket"
                 raise QMPConnectError(msg) from err
             if ret is None:
-                raise QMPConnectError("Error while reading from socket")
+                raise QMPProtocolError("Unexpected empty message from server")
             self.__sock.settimeout(None)
 
     def __enter__(self) -> 'QEMUMonitorProtocol':
@@ -245,12 +256,13 @@ def cmd_obj(self, qmp_cmd: QMPMessage) -> QMPMessage:
 
         @param qmp_cmd: QMP command to be sent as a Python dict
         @return QMP response as a Python dict
+        @raise QMPProtocolError on unexpected empty messages.
         """
         self.logger.debug(">>> %s", qmp_cmd)
         self.__sock.sendall(json.dumps(qmp_cmd).encode('utf-8'))
         resp = self.__json_read()
         if resp is None:
-            raise QMPConnectError("Unexpected empty reply from server")
+            raise QMPProtocolError("Unexpected empty reply from server")
         self.logger.debug("<<< %s", resp)
         return resp
 
@@ -274,13 +286,16 @@ def cmd(self, name: str,
     def command(self, cmd: str, **kwds: Any) -> QMPReturnValue:
         """
         Build and send a QMP command to the monitor, report errors if any
+
+        @raise QMPResponseError if the server returns an in-band error reply.
+        @raise QMPProtocolError if the server reply is not understood.
         """
         ret = self.cmd(cmd, kwds)
         if 'error' in ret:
             raise QMPResponseError(ret)
         if 'return' not in ret:
             raise QMPProtocolError(
-                "'return' key not found in QMP response '{}'".format(str(ret))
+                f"'return' key not found in QMP response '{str(ret)}'"
             )
         return cast(QMPReturnValue, ret['return'])
 
-- 
2.26.2


