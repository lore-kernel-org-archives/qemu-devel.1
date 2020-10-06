Return-Path: <SRS0=37Ja=DO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB338C4363D
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 00:13:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 707CB206F0
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 00:13:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QAmWXHpr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 707CB206F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56772 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPx5A-0004fU-FY
	for qemu-devel@archiver.kernel.org; Tue, 06 Oct 2020 20:13:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38820)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kPwrT-0000AZ-1U
 for qemu-devel@nongnu.org; Tue, 06 Oct 2020 19:59:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:26688)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kPwrP-0002Oa-0T
 for qemu-devel@nongnu.org; Tue, 06 Oct 2020 19:59:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602028750;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bi8KTrLebYMpML/77oR/Ex/2wVBs+0QzkhpIjMNk71Y=;
 b=QAmWXHprdqs72GAvdwWL4JdzT7V/9LFPv+PpCClk2D6VfPcUWzsyalqFydBcqMZOFNbAu7
 AC9bdeQYecZQgYLzCMH5g6Df/mGiIR8r8tbcOvo5yPAw/L+IdL26rKBRB2Syttlm3Vfcuw
 Ne4XymvFWC9dWDEEfeoY34Xv8pZU/lg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-435-AYpSl5aLNwmVyVnM7StgUg-1; Tue, 06 Oct 2020 19:59:08 -0400
X-MC-Unique: AYpSl5aLNwmVyVnM7StgUg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A1CFE8064BD;
 Tue,  6 Oct 2020 23:59:07 +0000 (UTC)
Received: from scv.redhat.com (ovpn-120-38.rdu2.redhat.com [10.10.120.38])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A6EF460BFA;
 Tue,  6 Oct 2020 23:59:06 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 16/20] python/console_socket: avoid encoding to/from string
Date: Tue,  6 Oct 2020 19:58:13 -0400
Message-Id: <20201006235817.3280413-17-jsnow@redhat.com>
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
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Cleber Rosa <crosa@redhat.com>, John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We can work directly in bytes instead of translating back and forth to
string, which removes the question of which encodings to use.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 python/qemu/console_socket.py | 20 +++++---------------
 1 file changed, 5 insertions(+), 15 deletions(-)

diff --git a/python/qemu/console_socket.py b/python/qemu/console_socket.py
index 57e6eee0176..f060d79e06d 100644
--- a/python/qemu/console_socket.py
+++ b/python/qemu/console_socket.py
@@ -34,12 +34,12 @@ def __init__(self, address: str, file: Optional[str] = None,
                  drain: bool = False):
         self._recv_timeout_sec = 300.0
         self._sleep_time = 0.5
-        self._buffer: Deque[str] = deque()
+        self._buffer: Deque[int] = deque()
         socket.socket.__init__(self, socket.AF_UNIX, socket.SOCK_STREAM)
         self.connect(address)
         self._logfile = None
         if file:
-            self._logfile = open(file, "w")
+            self._logfile = open(file, "bw")
         self._open = True
         self._drain_thread = None
         if drain:
@@ -83,15 +83,10 @@ def close(self) -> None:
     def _drain_socket(self) -> None:
         """process arriving characters into in memory _buffer"""
         data = socket.socket.recv(self, 1)
-        # latin1 is needed since there are some chars
-        # we are receiving that cannot be encoded to utf-8
-        # such as 0xe2, 0x80, 0xA6.
-        string = data.decode("latin1")
         if self._logfile:
-            self._logfile.write("{}".format(string))
+            self._logfile.write(data)
             self._logfile.flush()
-        for c in string:
-            self._buffer.extend(c)
+        self._buffer.extend(data)
 
     def recv(self, bufsize: int = 1, flags: int = 0) -> bytes:
         """Return chars from in memory buffer.
@@ -107,12 +102,7 @@ def recv(self, bufsize: int = 1, flags: int = 0) -> bytes:
             elapsed_sec = time.time() - start_time
             if elapsed_sec > self._recv_timeout_sec:
                 raise socket.timeout
-        chars = ''.join([self._buffer.popleft() for i in range(bufsize)])
-        # We choose to use latin1 to remain consistent with
-        # handle_read() and give back the same data as the user would
-        # receive if they were reading directly from the
-        # socket w/o our intervention.
-        return chars.encode("latin1")
+        return bytes((self._buffer.popleft() for i in range(bufsize)))
 
     def setblocking(self, value: bool) -> None:
         """When not draining we pass thru to the socket,
-- 
2.26.2


