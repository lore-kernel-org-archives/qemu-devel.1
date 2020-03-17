Return-Path: <SRS0=hQJD=5C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09452C2BB1D
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 04:36:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB8C62071C
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 04:36:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WOCq50aW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB8C62071C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52452 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jE3xW-0005v1-0r
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 00:36:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49234)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jsnow@redhat.com>) id 1jE3wG-0004Ap-Cu
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 00:34:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jsnow@redhat.com>) id 1jE3wF-0007XH-0N
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 00:34:48 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:30989)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jsnow@redhat.com>) id 1jE3wE-0007TR-Sp
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 00:34:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584419686;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=W4nQG6lLHWsGZ1BSm01dCR2W4JXXj904nPobUtOWXgM=;
 b=WOCq50aWhasoj+DNB6luBYUQtUDTGuwYT+X4m33T4b/rKcPkZAQ4LcWpkft9D8DBgD/Z4U
 /0Y6psU5ti6abTGVBPKu87ZXtVxjYaL16GLkFmidpqBVf7rvNe+5qwhgmUoGTODQqdyl0X
 xA0NucKps7d3TAScePhmsxLsQ12D34Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-395-GYH0UQTFNPWUmm1EUoP0lA-1; Tue, 17 Mar 2020 00:34:40 -0400
X-MC-Unique: GYH0UQTFNPWUmm1EUoP0lA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D5DEF800D4E;
 Tue, 17 Mar 2020 04:34:39 +0000 (UTC)
Received: from probe.redhat.com (ovpn-112-191.rdu2.redhat.com [10.10.112.191])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 08FB55C1B2;
 Tue, 17 Mar 2020 04:34:38 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 1/3] qmp.py: change event_wait to use a dict
Date: Tue, 17 Mar 2020 00:34:35 -0400
Message-Id: <20200317043437.19464-2-jsnow@redhat.com>
In-Reply-To: <20200317043437.19464-1-jsnow@redhat.com>
References: <20200317043437.19464-1-jsnow@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 216.205.24.74
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

It's easier to work with than a list of tuples, because we can check the
keys for membership.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 python/qemu/machine.py        | 10 +++++-----
 tests/qemu-iotests/040        | 12 ++++++------
 tests/qemu-iotests/260        |  5 +++--
 tests/qemu-iotests/iotests.py | 16 ++++++++--------
 4 files changed, 22 insertions(+), 21 deletions(-)

diff --git a/python/qemu/machine.py b/python/qemu/machine.py
index 183d8f3d38..748de5f322 100644
--- a/python/qemu/machine.py
+++ b/python/qemu/machine.py
@@ -476,21 +476,21 @@ def event_wait(self, name, timeout=3D60.0, match=3DNo=
ne):
         timeout: QEMUMonitorProtocol.pull_event timeout parameter.
         match: Optional match criteria. See event_match for details.
         """
-        return self.events_wait([(name, match)], timeout)
+        return self.events_wait({name: match}, timeout)
=20
     def events_wait(self, events, timeout=3D60.0):
         """
         events_wait waits for and returns a named event from QMP with a ti=
meout.
=20
-        events: a sequence of (name, match_criteria) tuples.
+        events: a mapping containing {name: match_criteria}.
                 The match criteria are optional and may be None.
                 See event_match for details.
         timeout: QEMUMonitorProtocol.pull_event timeout parameter.
         """
         def _match(event):
-            for name, match in events:
-                if event['event'] =3D=3D name and self.event_match(event, =
match):
-                    return True
+            name =3D event['event']
+            if name in events:
+                return self.event_match(event, events[name])
             return False
=20
         # Search cached events
diff --git a/tests/qemu-iotests/040 b/tests/qemu-iotests/040
index 32c82b4ec6..90b59081ff 100755
--- a/tests/qemu-iotests/040
+++ b/tests/qemu-iotests/040
@@ -485,12 +485,12 @@ class TestErrorHandling(iotests.QMPTestCase):
=20
     def run_job(self, expected_events, error_pauses_job=3DFalse):
         match_device =3D {'data': {'device': 'job0'}}
-        events =3D [
-            ('BLOCK_JOB_COMPLETED', match_device),
-            ('BLOCK_JOB_CANCELLED', match_device),
-            ('BLOCK_JOB_ERROR', match_device),
-            ('BLOCK_JOB_READY', match_device),
-        ]
+        events =3D {
+            'BLOCK_JOB_COMPLETED': match_device,
+            'BLOCK_JOB_CANCELLED': match_device,
+            'BLOCK_JOB_ERROR': match_device,
+            'BLOCK_JOB_READY': match_device,
+        }
=20
         completed =3D False
         log =3D []
diff --git a/tests/qemu-iotests/260 b/tests/qemu-iotests/260
index 804a7addb9..729f031122 100755
--- a/tests/qemu-iotests/260
+++ b/tests/qemu-iotests/260
@@ -67,8 +67,9 @@ def test(persistent, restart):
=20
     vm.qmp_log('block-commit', device=3D'drive0', top=3Dtop,
                filters=3D[iotests.filter_qmp_testfiles])
-    ev =3D vm.events_wait((('BLOCK_JOB_READY', None),
-                         ('BLOCK_JOB_COMPLETED', None)))
+    ev =3D vm.events_wait({
+        'BLOCK_JOB_READY': None,
+        'BLOCK_JOB_COMPLETED': None })
     log(filter_qmp_event(ev))
     if (ev['event'] =3D=3D 'BLOCK_JOB_COMPLETED'):
         vm.shutdown()
diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests.py
index 9304066471..bc96f1ce27 100644
--- a/tests/qemu-iotests/iotests.py
+++ b/tests/qemu-iotests/iotests.py
@@ -617,14 +617,14 @@ def run_job(self, job, auto_finalize=3DTrue, auto_dis=
miss=3DFalse,
         """
         match_device =3D {'data': {'device': job}}
         match_id =3D {'data': {'id': job}}
-        events =3D [
-            ('BLOCK_JOB_COMPLETED', match_device),
-            ('BLOCK_JOB_CANCELLED', match_device),
-            ('BLOCK_JOB_ERROR', match_device),
-            ('BLOCK_JOB_READY', match_device),
-            ('BLOCK_JOB_PENDING', match_id),
-            ('JOB_STATUS_CHANGE', match_id)
-        ]
+        events =3D {
+            'BLOCK_JOB_COMPLETED': match_device,
+            'BLOCK_JOB_CANCELLED': match_device,
+            'BLOCK_JOB_ERROR': match_device,
+            'BLOCK_JOB_READY': match_device,
+            'BLOCK_JOB_PENDING': match_id,
+            'JOB_STATUS_CHANGE': match_id,
+        }
         error =3D None
         while True:
             ev =3D filter_qmp_event(self.events_wait(events, timeout=3Dwai=
t))
--=20
2.21.1


