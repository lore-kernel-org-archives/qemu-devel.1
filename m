Return-Path: <SRS0=e3er=AV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62906C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 05:25:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2C69B20720
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 05:25:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jWRHCCoy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C69B20720
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50426 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtlXi-0005MN-CJ
	for qemu-devel@archiver.kernel.org; Fri, 10 Jul 2020 01:25:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50830)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1jtlUe-0007de-8R
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 01:22:40 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:45901
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1jtlUb-0008Ej-PV
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 01:22:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594358557;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Gt5bdR8o0JAhInkTgPVMvDF+0bcSYyhERKJO3jGGaJE=;
 b=jWRHCCoyqnUbVX+y+zNo+OPko/mz7EXovWBw9K7/aHrWdAe5S+BYlfM5BDCdVoSn5JwQja
 Nq31LqKir4CZngVgCyaTyHlmGzrCWK2hLc0k4mqXeF4qUhHnNzLqIiOWk03nUGSdX5HYcx
 Ea58Z1/InVt0xxPoRjNYoeQyun/Vvd4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-494-vRjlN3tHNc235PiY77egTA-1; Fri, 10 Jul 2020 01:22:34 -0400
X-MC-Unique: vRjlN3tHNc235PiY77egTA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 07B9019057A4;
 Fri, 10 Jul 2020 05:22:34 +0000 (UTC)
Received: from probe.redhat.com (ovpn-118-196.rdu2.redhat.com [10.10.118.196])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 02FC3920CA;
 Fri, 10 Jul 2020 05:22:32 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 10/16] python/machine.py: Handle None events in events_wait
Date: Fri, 10 Jul 2020 01:22:14 -0400
Message-Id: <20200710052220.3306-11-jsnow@redhat.com>
In-Reply-To: <20200710052220.3306-1-jsnow@redhat.com>
References: <20200710052220.3306-1-jsnow@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/09 22:08:55
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=unavailable autolearn_force=no
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
 qemu-block@nongnu.org, John Snow <jsnow@redhat.com>,
 Max Reitz <mreitz@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

If the timeout is 0, we can get None back. Handle this explicitly.

Signed-off-by: John Snow <jsnow@redhat.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
---
 python/qemu/machine.py | 27 ++++++++++++++++++++-------
 1 file changed, 20 insertions(+), 7 deletions(-)

diff --git a/python/qemu/machine.py b/python/qemu/machine.py
index 37e859f6d2..48e70253fa 100644
--- a/python/qemu/machine.py
+++ b/python/qemu/machine.py
@@ -33,7 +33,7 @@
 from types import TracebackType
 
 from . import qmp
-from .qmp import SocketAddrT
+from .qmp import SocketAddrT, QMPMessage
 
 LOG = logging.getLogger(__name__)
 
@@ -594,13 +594,20 @@ def event_wait(self, name, timeout=60.0, match=None):
 
     def events_wait(self, events, timeout=60.0):
         """
-        events_wait waits for and returns a named event
-        from QMP with a timeout.
+        events_wait waits for and returns a single named event from QMP.
+        In the case of multiple qualifying events, this function returns the
+        first one.
 
-        events: a sequence of (name, match_criteria) tuples.
-                The match criteria are optional and may be None.
-                See event_match for details.
-        timeout: QEMUMonitorProtocol.pull_event timeout parameter.
+        :param events: A sequence of (name, match_criteria) tuples.
+                       The match criteria are optional and may be None.
+                       See event_match for details.
+        :param timeout: Optional timeout, in seconds.
+                        See QEMUMonitorProtocol.pull_event.
+
+        :raise QMPTimeoutError: If timeout was non-zero and no matching events
+                                were found.
+        :return: A QMP event matching the filter criteria.
+                 If timeout was 0 and no event matched, None.
         """
         def _match(event):
             for name, match in events:
@@ -608,6 +615,8 @@ def _match(event):
                     return True
             return False
 
+        event: Optional[QMPMessage]
+
         # Search cached events
         for event in self._events:
             if _match(event):
@@ -617,6 +626,10 @@ def _match(event):
         # Poll for new events
         while True:
             event = self._qmp.pull_event(wait=timeout)
+            if event is None:
+                # NB: None is only returned when timeout is false-ish.
+                # Timeouts raise QMPTimeoutError instead!
+                break
             if _match(event):
                 return event
             self._events.append(event)
-- 
2.21.3


