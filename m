Return-Path: <SRS0=OzdF=4N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48E1CC35DEE
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 01:02:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0B16A2176D
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 01:02:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aSjqsUkm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B16A2176D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46932 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6OcC-0000hV-9d
	for qemu-devel@archiver.kernel.org; Mon, 24 Feb 2020 20:02:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55783)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jsnow@redhat.com>) id 1j6OWt-000267-2x
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 19:56:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jsnow@redhat.com>) id 1j6OWr-00081e-V9
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 19:56:54 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:50279
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jsnow@redhat.com>) id 1j6OWr-0007zj-Qh
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 19:56:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582592213;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zFiI11K/zhMpvmP4sNkoFe4BM6V7xKs///v037C3nNo=;
 b=aSjqsUkmf84cuyH6fUg9a8pSNdAULPbxSLujh2L3o28/pbwN0zpUFV/eEkqFF7qFEo51Tb
 mwGSVMKS5GajeFb2nNGrs7JCiDItHV5eeg4UCNN+CJRkzMkekO3QNbvOkLJ0l03GZdad6j
 QIlVGoI4dNsGk4gASpOz9N9f5GkZEB0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-357-n06VbUNZNr2iTi9tKaysSA-1; Mon, 24 Feb 2020 19:56:49 -0500
X-MC-Unique: n06VbUNZNr2iTi9tKaysSA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B100313E4;
 Tue, 25 Feb 2020 00:56:48 +0000 (UTC)
Received: from probe.bos.redhat.com (dhcp-17-182.bos.redhat.com [10.18.17.182])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C06DA1CB;
 Tue, 25 Feb 2020 00:56:47 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 5/6] qmp.py: change event_wait to use a dict
Date: Mon, 24 Feb 2020 19:56:40 -0500
Message-Id: <20200225005641.5478-6-jsnow@redhat.com>
In-Reply-To: <20200225005641.5478-1-jsnow@redhat.com>
References: <20200225005641.5478-1-jsnow@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: Kevin Wolf <kwolf@redhat.com>, vsementsov@virtuozzo.com,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>,
 pkrempa@redhat.com, Cleber Rosa <crosa@redhat.com>,
 John Snow <jsnow@redhat.com>
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
index 30c0de380d..b2fb045ddd 100755
--- a/tests/qemu-iotests/260
+++ b/tests/qemu-iotests/260
@@ -65,8 +65,9 @@ def test(persistent, restart):
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
index 5d2990a0e4..3390fab021 100644
--- a/tests/qemu-iotests/iotests.py
+++ b/tests/qemu-iotests/iotests.py
@@ -604,14 +604,14 @@ def run_job(self, job, auto_finalize=3DTrue, auto_dis=
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


