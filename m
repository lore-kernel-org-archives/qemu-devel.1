Return-Path: <SRS0=2Sdx=UN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28392C31E4C
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2019 13:44:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F29A52168B
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2019 13:44:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F29A52168B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51682 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbmVh-00042H-8r
	for qemu-devel@archiver.kernel.org; Fri, 14 Jun 2019 09:44:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46393)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mreitz@redhat.com>) id 1hbmRl-0001fH-TF
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 09:40:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1hbmRk-0005vW-1U
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 09:40:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49952)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1hbmRe-0005pq-7q; Fri, 14 Jun 2019 09:40:44 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 5D750C058CBA;
 Fri, 14 Jun 2019 13:40:31 +0000 (UTC)
Received: from localhost (unknown [10.40.205.125])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E6BA6601AC;
 Fri, 14 Jun 2019 13:40:30 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Date: Fri, 14 Jun 2019 15:40:04 +0200
Message-Id: <20190614134021.32486-4-mreitz@redhat.com>
In-Reply-To: <20190614134021.32486-1-mreitz@redhat.com>
References: <20190614134021.32486-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.32]); Fri, 14 Jun 2019 13:40:36 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 03/20] QEMUMachine: add events_wait method
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
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: John Snow <jsnow@redhat.com>

Instead of event_wait which looks for a single event, add an events_wait
which can look for any number of events simultaneously. However, it
will still only return one at a time, whichever happens first.

Signed-off-by: John Snow <jsnow@redhat.com>
Message-id: 20190523170643.20794-4-jsnow@redhat.com
Reviewed-by: Max Reitz <mreitz@redhat.com>
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 python/qemu/__init__.py | 69 +++++++++++++++++++++++++++++------------
 1 file changed, 49 insertions(+), 20 deletions(-)

diff --git a/python/qemu/__init__.py b/python/qemu/__init__.py
index 81d9657ec0..98ed8a2e28 100644
--- a/python/qemu/__init__.py
+++ b/python/qemu/__init__.py
@@ -402,42 +402,71 @@ class QEMUMachine(object):
         self._qmp.clear_events()
         return events
=20
-    def event_wait(self, name, timeout=3D60.0, match=3DNone):
+    @staticmethod
+    def event_match(event, match=3DNone):
         """
-        Wait for specified timeout on named event in QMP; optionally fil=
ter
-        results by match.
+        Check if an event matches optional match criteria.
=20
-        The 'match' is checked to be a recursive subset of the 'event'; =
skips
-        branch processing on match's value None
-           {"foo": {"bar": 1}} matches {"foo": None}
-           {"foo": {"bar": 1}} does not matches {"foo": {"baz": None}}
+        The match criteria takes the form of a matching subdict. The eve=
nt is
+        checked to be a superset of the subdict, recursively, with match=
ing
+        values whenever those values are not None.
+
+        Examples, with the subdict queries on the left:
+         - None matches any object.
+         - {"foo": None} matches {"foo": {"bar": 1}}
+         - {"foo": {"baz": None}} does not match {"foo": {"bar": 1}}
+         - {"foo": {"baz": 2}} matches {"foo": {"bar": 1, "baz": 2}}
         """
-        def event_match(event, match=3DNone):
-            if match is None:
-                return True
+        if match is None:
+            return True
=20
-            for key in match:
-                if key in event:
-                    if isinstance(event[key], dict):
-                        if not event_match(event[key], match[key]):
-                            return False
-                    elif event[key] !=3D match[key]:
+        for key in match:
+            if key in event:
+                if isinstance(event[key], dict):
+                    if not QEMUMachine.event_match(event[key], match[key=
]):
                         return False
-                else:
+                elif event[key] !=3D match[key]:
                     return False
+            else:
+                return False
+        return True
=20
-            return True
+    def event_wait(self, name, timeout=3D60.0, match=3DNone):
+        """
+        event_wait waits for and returns a named event from QMP with a t=
imeout.
+
+        name: The event to wait for.
+        timeout: QEMUMonitorProtocol.pull_event timeout parameter.
+        match: Optional match criteria. See event_match for details.
+        """
+        return self.events_wait([(name, match)], timeout)
+
+    def events_wait(self, events, timeout=3D60.0):
+        """
+        events_wait waits for and returns a named event from QMP with a =
timeout.
+
+        events: a sequence of (name, match_criteria) tuples.
+                The match criteria are optional and may be None.
+                See event_match for details.
+        timeout: QEMUMonitorProtocol.pull_event timeout parameter.
+        """
+        def _match(event):
+            for name, match in events:
+                if (event['event'] =3D=3D name and
+                    self.event_match(event, match)):
+                    return True
+            return False
=20
         # Search cached events
         for event in self._events:
-            if (event['event'] =3D=3D name) and event_match(event, match=
):
+            if _match(event):
                 self._events.remove(event)
                 return event
=20
         # Poll for new events
         while True:
             event =3D self._qmp.pull_event(wait=3Dtimeout)
-            if (event['event'] =3D=3D name) and event_match(event, match=
):
+            if _match(event):
                 return event
             self._events.append(event)
=20
--=20
2.21.0


