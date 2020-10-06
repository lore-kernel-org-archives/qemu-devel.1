Return-Path: <SRS0=37Ja=DO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64DCBC4363D
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 00:01:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E3FF6212CC
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 00:01:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bR48DZNm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3FF6212CC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59042 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPwtQ-0001uo-Nv
	for qemu-devel@archiver.kernel.org; Tue, 06 Oct 2020 20:01:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38498)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kPwqw-0007tS-F0
 for qemu-devel@nongnu.org; Tue, 06 Oct 2020 19:58:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:46496)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kPwqs-0002Jr-3Y
 for qemu-devel@nongnu.org; Tue, 06 Oct 2020 19:58:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602028715;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aXtAa28vJz2L/wQ3Jh/YpBLJMIWsXeQxkfChMSZykRs=;
 b=bR48DZNmc0U7oersonoSPfIEhR4t06S1IWJrfZ9nYNJYqyReU5P0wFxwI34eCqt/PF/ZOD
 GmOi9WY75G1vOgMzVkq8nNkAC0MlrhkGRsVfucpAjHZzFavSPgNWZoUPrxOq23TMIg0aPT
 CRRgGhOdYnPAiRK40Hq7LiphqdbnKxU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-377-EkqOACcdN7iQEezyTsYhgg-1; Tue, 06 Oct 2020 19:58:33 -0400
X-MC-Unique: EkqOACcdN7iQEezyTsYhgg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 60EBA802ED5;
 Tue,  6 Oct 2020 23:58:32 +0000 (UTC)
Received: from scv.redhat.com (ovpn-120-38.rdu2.redhat.com [10.10.120.38])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9DFE6BABA;
 Tue,  6 Oct 2020 23:58:31 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 07/20] python/machine.py: Add _qmp access shim
Date: Tue,  6 Oct 2020 19:58:04 -0400
Message-Id: <20201006235817.3280413-8-jsnow@redhat.com>
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

Like many other Optional[] types, it's not always a given that this
object will be set. Wrap it in a type-shim that raises a meaningful
error and will always return a concrete type.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 python/qemu/machine.py | 24 +++++++++++++-----------
 1 file changed, 13 insertions(+), 11 deletions(-)

diff --git a/python/qemu/machine.py b/python/qemu/machine.py
index d788e8aba8c..3e9cf09fd2d 100644
--- a/python/qemu/machine.py
+++ b/python/qemu/machine.py
@@ -135,7 +135,7 @@ def __init__(self, binary, args=None, wrapper=None, name=None,
         self._events = []
         self._iolog = None
         self._qmp_set = True   # Enable QMP monitor by default.
-        self._qmp = None
+        self._qmp_connection: Optional[qmp.QEMUMonitorProtocol] = None
         self._qemu_full_args = None
         self._temp_dir = None
         self._launched = False
@@ -302,14 +302,14 @@ def _pre_launch(self):
             if self._remove_monitor_sockfile:
                 assert isinstance(self._monitor_address, str)
                 self._remove_files.append(self._monitor_address)
-            self._qmp = qmp.QEMUMonitorProtocol(
+            self._qmp_connection = qmp.QEMUMonitorProtocol(
                 self._monitor_address,
                 server=True,
                 nickname=self._name
             )
 
     def _post_launch(self):
-        if self._qmp:
+        if self._qmp_connection:
             self._qmp.accept()
 
     def _post_shutdown(self):
@@ -320,9 +320,9 @@ def _post_shutdown(self):
         # Comprehensive reset for the failed launch case:
         self._early_cleanup()
 
-        if self._qmp:
+        if self._qmp_connection:
             self._qmp.close()
-            self._qmp = None
+            self._qmp_connection = None
 
         self._load_io_log()
 
@@ -434,7 +434,7 @@ def _soft_shutdown(self, timeout: Optional[int],
         """
         self._early_cleanup()
 
-        if self._qmp is not None:
+        if self._qmp_connection:
             if not has_quit:
                 # Might raise ConnectionReset
                 self._qmp.cmd('quit')
@@ -515,11 +515,13 @@ def set_qmp_monitor(self, enabled=True):
                         line. Default is True.
         @note: call this function before launch().
         """
-        if enabled:
-            self._qmp_set = True
-        else:
-            self._qmp_set = False
-            self._qmp = None
+        self._qmp_set = enabled
+
+    @property
+    def _qmp(self) -> qmp.QEMUMonitorProtocol:
+        if self._qmp_connection is None:
+            raise QEMUMachineError("Attempt to access QMP with no connection")
+        return self._qmp_connection
 
     @classmethod
     def _qmp_args(cls, _conv_keys: bool = True, **args: Any) -> Dict[str, Any]:
-- 
2.26.2


