Return-Path: <SRS0=T5iq=DQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E567CC43457
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 17:53:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 510562076E
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 17:53:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Kw6X44LU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 510562076E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35514 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQwZi-0000pZ-UJ
	for qemu-devel@archiver.kernel.org; Fri, 09 Oct 2020 13:53:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55728)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kQwYJ-000812-Ku
 for qemu-devel@nongnu.org; Fri, 09 Oct 2020 13:51:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:37273)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kQwYH-0007Il-NL
 for qemu-devel@nongnu.org; Fri, 09 Oct 2020 13:51:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602265893;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oyzenvM/Pbt+6CygNYoQChDMErS4knDfk+/2CMuuh5Y=;
 b=Kw6X44LU6VDPadc2UNLcSAavydfBa0oM5v+4s6ljXRZHfspDslmN3W6T/VcRZUjynh/Bit
 lAg+xGhFzTiiBTq3jrUJ8vBRyhywYH5OhZ55UPNb7nVslcn7dCaTocEjBMp5SZr8Ba2G3y
 CqVuky8FncoHeZlZMmrmSloS8LCL7ic=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-493-ssSSxA1rO1620982LAYJ5w-1; Fri, 09 Oct 2020 13:51:31 -0400
X-MC-Unique: ssSSxA1rO1620982LAYJ5w-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 40BBCADC22
 for <qemu-devel@nongnu.org>; Fri,  9 Oct 2020 17:51:30 +0000 (UTC)
Received: from scv.redhat.com (ovpn-112-203.rdu2.redhat.com [10.10.112.203])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8477376649;
 Fri,  9 Oct 2020 17:51:29 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 3/3] python/qemu/qmp.py: Fix settimeout operation
Date: Fri,  9 Oct 2020 13:51:23 -0400
Message-Id: <20201009175123.249009-4-jsnow@redhat.com>
In-Reply-To: <20201009175123.249009-1-jsnow@redhat.com>
References: <20201009175123.249009-1-jsnow@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jsnow@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=216.205.24.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/09 02:34:37
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: Kevin Wolf <kwolf@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Cleber Rosa <crosa@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We enabled callers to interface directly with settimeout, but this
reacts poorly with blocking/nonblocking operation; as they are using the
same internal mechanism.

1. Whenever we change the blocking mechanism temporarily, always set it
back to what it was afterwards.

2. Disallow callers from setting a timeout of "0", which means
Non-blocking mode. This is going to create more weird problems than
anybody wants, so just forbid it.

I opt not to coerce '0' to 'None' to maintain the principal of least
surprise in mirroring the semantics of Python's interface.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 python/qemu/qmp.py | 23 +++++++++++++++++------
 1 file changed, 17 insertions(+), 6 deletions(-)

diff --git a/python/qemu/qmp.py b/python/qemu/qmp.py
index 4969e5741cb..f64517fb0a7 100644
--- a/python/qemu/qmp.py
+++ b/python/qemu/qmp.py
@@ -164,16 +164,19 @@ def __get_events(self, wait: Union[bool, float] = False) -> None:
                                 retrieved or if some other error occurred.
         """
 
+        # Current timeout and blocking status
+        current_timeout = self.__sock.gettimeout()
+
         # Check for new events regardless and pull them into the cache:
         try:
-            self.__sock.setblocking(False)
+            self.__sock.settimeout(0)  # i.e. setblocking(False)
             self.__json_read()
         except OSError as err:
             # EAGAIN: No data available; not critical
             if err.errno != errno.EAGAIN:
                 raise
         finally:
-            self.__sock.setblocking(True)
+            self.__sock.settimeout(current_timeout)
 
         # Wait for new events, if needed.
         # if wait is 0.0, this means "no wait" and is also implicitly false.
@@ -187,9 +190,11 @@ def __get_events(self, wait: Union[bool, float] = False) -> None:
             except Exception as err:
                 msg = "Error while reading from socket"
                 raise QMPConnectError(msg) from err
+            finally:
+                self.__sock.settimeout(current_timeout)
+
             if ret is None:
                 raise QMPConnectError("Error while reading from socket")
-            self.__sock.settimeout(None)
 
     def __enter__(self) -> 'QEMUMonitorProtocol':
         # Implement context manager enter function.
@@ -219,7 +224,7 @@ def connect(self, negotiate: bool = True) -> Optional[QMPMessage]:
             return self.__negotiate_capabilities()
         return None
 
-    def accept(self, timeout: float = 15.0) -> QMPMessage:
+    def accept(self, timeout: Optional[float] = 15.0) -> QMPMessage:
         """
         Await connection from QMP Monitor and perform capabilities negotiation.
 
@@ -338,13 +343,19 @@ def close(self) -> None:
         if self.__sockfile:
             self.__sockfile.close()
 
-    def settimeout(self, timeout: float) -> None:
+    def settimeout(self, timeout: Optional[float]) -> None:
         """
         Set the socket timeout.
 
-        @param timeout (float): timeout in seconds, or None.
+        @param timeout (float): timeout in seconds (non-zero), or None.
         @note This is a wrap around socket.settimeout
+
+        @raise ValueError: if timeout was set to 0.
         """
+        if timeout == 0:
+            msg = "timeout cannot be 0; this engages non-blocking mode."
+            msg += " Use 'None' instead to disable timeouts."
+            raise ValueError(msg)
         self.__sock.settimeout(timeout)
 
     def get_sock_fd(self) -> int:
-- 
2.26.2


