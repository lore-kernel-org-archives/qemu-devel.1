Return-Path: <SRS0=1sPN=D3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CAEAC4363A
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 17:48:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7606D21D6C
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 17:48:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hanO8ZgB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7606D21D6C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35076 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUvkj-0005Dh-Al
	for qemu-devel@archiver.kernel.org; Tue, 20 Oct 2020 13:48:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35880)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kUvQZ-0002oJ-7D
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 13:28:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:54206)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kUvQW-00007r-Id
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 13:28:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603214878;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=20FmI42QTcBODBnrVTLW/uUn9qmr/W6lBuDyI2mPFRU=;
 b=hanO8ZgBCbvYS8wvtJw2z4CHm9R4Hz2Rw87MEn+Nzy/OizDApSeL7W0SNmT2s4beZ7Iy6i
 N9HTqg436zPCiqDfK6tUU9EGNcXd2Wngbl+sqeooiIoH/bwGMyWWOACGm3dfeCBM+Dl8ae
 9sNcBbK/yTLaUYHbxp0A2Qb0v/Iz4vc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-407-gfNxqOpTOJqlOtVBBP-zwQ-1; Tue, 20 Oct 2020 13:27:55 -0400
X-MC-Unique: gfNxqOpTOJqlOtVBBP-zwQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C2EDF186DD20;
 Tue, 20 Oct 2020 17:27:54 +0000 (UTC)
Received: from scv.redhat.com (ovpn-115-172.rdu2.redhat.com [10.10.115.172])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D066127C2A;
 Tue, 20 Oct 2020 17:27:53 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 06/21] python/machine.py: Handle None events in events_wait
Date: Tue, 20 Oct 2020 13:27:27 -0400
Message-Id: <20201020172742.1483258-7-jsnow@redhat.com>
In-Reply-To: <20201020172742.1483258-1-jsnow@redhat.com>
References: <20201020172742.1483258-1-jsnow@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jsnow@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=216.205.24.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/20 01:16:16
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org,
 Max Reitz <mreitz@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

If the timeout is 0, we can get None back. Handle this explicitly.

Signed-off-by: John Snow <jsnow@redhat.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Message-id: 20201006235817.3280413-6-jsnow@redhat.com
Signed-off-by: John Snow <jsnow@redhat.com>
---
 python/qemu/machine.py | 27 ++++++++++++++++++++-------
 1 file changed, 20 insertions(+), 7 deletions(-)

diff --git a/python/qemu/machine.py b/python/qemu/machine.py
index 812ca7d349..aebfa09e9d 100644
--- a/python/qemu/machine.py
+++ b/python/qemu/machine.py
@@ -28,7 +28,7 @@
 from typing import List, Optional, Type
 
 from . import console_socket, qmp
-from .qmp import SocketAddrT
+from .qmp import QMPMessage, SocketAddrT
 
 
 LOG = logging.getLogger(__name__)
@@ -604,13 +604,20 @@ def event_wait(self, name, timeout=60.0, match=None):
 
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
@@ -618,6 +625,8 @@ def _match(event):
                     return True
             return False
 
+        event: Optional[QMPMessage]
+
         # Search cached events
         for event in self._events:
             if _match(event):
@@ -627,6 +636,10 @@ def _match(event):
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
2.26.2


