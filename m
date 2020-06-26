Return-Path: <SRS0=ZkAM=AH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50C92C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 20:48:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1EDCB2075D
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 20:48:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Cv5qGzMk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1EDCB2075D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52320 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jovHG-00009J-D7
	for qemu-devel@archiver.kernel.org; Fri, 26 Jun 2020 16:48:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33928)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1jovAf-00078G-3M
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 16:42:01 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:22033
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1jovAc-0005rm-0T
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 16:42:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593204117;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VGhfiTXbiXd+kEnKFvL/DKq9TUWbI6mf0WxW/E8MJ8E=;
 b=Cv5qGzMkQvRNKXBRDYQGvLzQvnA2na2pCqFmPjoLjY/ofaVAycsdDivxuD2N6Z+nXz5rey
 FxVC4plzFTr4OmtmT1dGoYfZf4zkQjiPxCGzPqWeAAKjbn/JwpoPfBXUNTvuG7N01Mwro/
 LTn543pVP7I8YVC1Sl25efaN5+ytk/w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-223-UiOS-Z6LNuSRkgzxosSuCQ-1; Fri, 26 Jun 2020 16:41:55 -0400
X-MC-Unique: UiOS-Z6LNuSRkgzxosSuCQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 91559107ACCA;
 Fri, 26 Jun 2020 20:41:54 +0000 (UTC)
Received: from probe.redhat.com (ovpn-119-184.rdu2.redhat.com [10.10.119.184])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9C5F219C58;
 Fri, 26 Jun 2020 20:41:53 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 10/16] python/machine.py: Handle None events in events_wait
Date: Fri, 26 Jun 2020 16:41:27 -0400
Message-Id: <20200626204133.14500-11-jsnow@redhat.com>
In-Reply-To: <20200626204133.14500-1-jsnow@redhat.com>
References: <20200626204133.14500-1-jsnow@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/26 03:23:21
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
index 8eb10a4bc1..f65bd18c1a 100644
--- a/python/qemu/machine.py
+++ b/python/qemu/machine.py
@@ -33,7 +33,7 @@
 from types import TracebackType
 
 from . import qmp
-from .qmp import SocketAddrT
+from .qmp import SocketAddrT, QMPMessage
 
 LOG = logging.getLogger(__name__)
 
@@ -552,13 +552,20 @@ def event_wait(self, name, timeout=60.0, match=None):
 
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
@@ -566,6 +573,8 @@ def _match(event):
                     return True
             return False
 
+        event: Optional[QMPMessage]
+
         # Search cached events
         for event in self._events:
             if _match(event):
@@ -575,6 +584,10 @@ def _match(event):
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


