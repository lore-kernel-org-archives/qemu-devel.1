Return-Path: <SRS0=BVCf=4W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1234CC3F2D7
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 00:12:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D0EC220842
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 00:12:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Dh60lxy8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0EC220842
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41556 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9e7w-0006X5-Rf
	for qemu-devel@archiver.kernel.org; Wed, 04 Mar 2020 19:12:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57336)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jsnow@redhat.com>) id 1j9e6w-0005HC-Ix
 for qemu-devel@nongnu.org; Wed, 04 Mar 2020 19:11:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jsnow@redhat.com>) id 1j9e6v-0003mm-7I
 for qemu-devel@nongnu.org; Wed, 04 Mar 2020 19:11:34 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:43611
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jsnow@redhat.com>) id 1j9e6v-0003l9-42
 for qemu-devel@nongnu.org; Wed, 04 Mar 2020 19:11:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583367092;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0ZfZQ10pJ54k2iJiT8688wXpeX9NUiC1yvhhBmf9H8s=;
 b=Dh60lxy86K1UAaIBOX7Vb+EXL4p7iW7qyGG8O1LlVe9SsmHiSoRo/j9O0Y4LXEwGhvz5ht
 NuBs7Yb0N6El2MZP1XkG7CLOQ57kO8uyX4Hu2dMob8d/HYYpC5826NyaqnoRq6Te+ifOPt
 lI/h07lhAZAu6vB7ayZNs55+lyx7Xes=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-80-xOkwQfp7NfGWvdD6WTyv4Q-1; Wed, 04 Mar 2020 19:11:29 -0500
X-MC-Unique: xOkwQfp7NfGWvdD6WTyv4Q-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E98F8100550E;
 Thu,  5 Mar 2020 00:11:28 +0000 (UTC)
Received: from probe.redhat.com (ovpn-120-212.rdu2.redhat.com [10.10.120.212])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D94575C1D4;
 Thu,  5 Mar 2020 00:11:27 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 1/3] qmp.py: change event_wait to use a dict
Date: Wed,  4 Mar 2020 19:11:23 -0500
Message-Id: <20200305001125.27549-2-jsnow@redhat.com>
In-Reply-To: <20200305001125.27549-1-jsnow@redhat.com>
References: <20200305001125.27549-1-jsnow@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
index 3e606c35ef..2625001978 100644
--- a/tests/qemu-iotests/iotests.py
+++ b/tests/qemu-iotests/iotests.py
@@ -614,14 +614,14 @@ def run_job(self, job, auto_finalize=3DTrue, auto_dis=
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


