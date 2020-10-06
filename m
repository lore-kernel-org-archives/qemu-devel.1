Return-Path: <SRS0=37Ja=DO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B17D9C4363D
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 00:04:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0DFB72054F
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 00:04:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fzlDCJwk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DFB72054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38592 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPwwf-0005AP-Ss
	for qemu-devel@archiver.kernel.org; Tue, 06 Oct 2020 20:04:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38364)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kPwqs-0007ob-CV
 for qemu-devel@nongnu.org; Tue, 06 Oct 2020 19:58:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:31666)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kPwqn-0002J2-Vp
 for qemu-devel@nongnu.org; Tue, 06 Oct 2020 19:58:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602028710;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/zSGVM2JkgSSLZO/grIC7BOqY6pXx4z7e2BAs6DDva0=;
 b=fzlDCJwkgSdOwCISNWAG1GTcPEK4qQfjfyXLh/C7DrJjf0EhkkDJRmNBizPJaB+OUtU0zY
 QxR2vCzHmYAgyIybBDXFjAwott6NW9ZufpROER+16fRyO7e1ariKZq4CnfwWJdEU0To6GC
 +RHCyHMwO4+7MFyBD+OF0G+C12RCQNA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-273-qxyx64t7OtS381zpJY5Kuw-1; Tue, 06 Oct 2020 19:58:29 -0400
X-MC-Unique: qxyx64t7OtS381zpJY5Kuw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F3A721084D6F;
 Tue,  6 Oct 2020 23:58:27 +0000 (UTC)
Received: from scv.redhat.com (ovpn-120-38.rdu2.redhat.com [10.10.120.38])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8D1CE610F3;
 Tue,  6 Oct 2020 23:58:26 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 05/20] python/machine.py: Handle None events in events_wait
Date: Tue,  6 Oct 2020 19:58:02 -0400
Message-Id: <20201006235817.3280413-6-jsnow@redhat.com>
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

If the timeout is 0, we can get None back. Handle this explicitly.

Signed-off-by: John Snow <jsnow@redhat.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
---
 python/qemu/machine.py | 27 ++++++++++++++++++++-------
 1 file changed, 20 insertions(+), 7 deletions(-)

diff --git a/python/qemu/machine.py b/python/qemu/machine.py
index 812ca7d3497..aebfa09e9de 100644
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


