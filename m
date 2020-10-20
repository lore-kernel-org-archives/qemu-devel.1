Return-Path: <SRS0=1sPN=D3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23E88C4363A
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 17:49:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 60A8F21D6C
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 17:49:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UmzmEQ05"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60A8F21D6C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37642 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUvlD-0006Gf-4H
	for qemu-devel@archiver.kernel.org; Tue, 20 Oct 2020 13:49:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36312)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kUvR2-0003Cg-O4
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 13:28:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:48960)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kUvQo-0000Df-Uq
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 13:28:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603214897;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KoRk17fUILbdEtaVg4nN+aoYI2z78GD802D03LsPzrE=;
 b=UmzmEQ05MEQFNwCYut/XW9yt4zX3ddcXzYXrZjO3bRJ6Qn8Y2Q90BCdmI4sZ9vz2vzF1lE
 z/KdfNGinnhRXlghSLELuMGXDQVKGOBmGTZHoBc/2LBx44PtZDhJ9Rk0SfrBVj6c2JhbCK
 yK3mxs3zQyj7oM4mL5Rt+LEafoexCJc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-184-nbemKrk4MZqLxLcavn2zGQ-1; Tue, 20 Oct 2020 13:28:15 -0400
X-MC-Unique: nbemKrk4MZqLxLcavn2zGQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 10B101006C8E;
 Tue, 20 Oct 2020 17:28:14 +0000 (UTC)
Received: from scv.redhat.com (ovpn-115-172.rdu2.redhat.com [10.10.115.172])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 098E71992D;
 Tue, 20 Oct 2020 17:28:12 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 21/21] python/qemu/qmp.py: Fix settimeout operation
Date: Tue, 20 Oct 2020 13:27:42 -0400
Message-Id: <20201020172742.1483258-22-jsnow@redhat.com>
In-Reply-To: <20201020172742.1483258-1-jsnow@redhat.com>
References: <20201020172742.1483258-1-jsnow@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jsnow@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/20 01:15:43
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Max Reitz <mreitz@redhat.com>, Cleber Rosa <crosa@redhat.com>,
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
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-id: 20201009175123.249009-4-jsnow@redhat.com
Signed-off-by: John Snow <jsnow@redhat.com>
---
 python/qemu/qmp.py | 23 +++++++++++++++++------
 1 file changed, 17 insertions(+), 6 deletions(-)

diff --git a/python/qemu/qmp.py b/python/qemu/qmp.py
index 4969e5741c..f64517fb0a 100644
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


