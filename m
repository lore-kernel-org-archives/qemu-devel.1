Return-Path: <SRS0=zTTU=TP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32BBDC04E53
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2019 20:19:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F38562070D
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2019 20:19:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F38562070D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:41928 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hR0NI-0000e5-8j
	for qemu-devel@archiver.kernel.org; Wed, 15 May 2019 16:19:40 -0400
Received: from eggs.gnu.org ([209.51.188.92]:45167)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hR0JF-0005ti-A9
	for qemu-devel@nongnu.org; Wed, 15 May 2019 16:15:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hR0JC-0007lG-HJ
	for qemu-devel@nongnu.org; Wed, 15 May 2019 16:15:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40311)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mreitz@redhat.com>)
	id 1hR0J0-0007aV-Bh; Wed, 15 May 2019 16:15:16 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id AF4DF3071524;
	Wed, 15 May 2019 20:15:10 +0000 (UTC)
Received: from localhost (unknown [10.40.205.95])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 4876010013D9;
	Wed, 15 May 2019 20:15:10 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Date: Wed, 15 May 2019 22:15:01 +0200
Message-Id: <20190515201503.19069-3-mreitz@redhat.com>
In-Reply-To: <20190515201503.19069-1-mreitz@redhat.com>
References: <20190515201503.19069-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.49]);
	Wed, 15 May 2019 20:15:10 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH 2/4] iotests.py: Let assert_qmp() accept an
 array
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Kevin Wolf <kwolf@redhat.com>, Alberto Garcia <berto@igalia.com>,
	qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Sometimes we cannot tell which error message qemu will emit, and we do
not care.  With this change, we can then just pass an array of all
possible messages to assert_qmp() and it will choose the right one.

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 tests/qemu-iotests/iotests.py | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests.p=
y
index f811f69135..d96ba1f63c 100644
--- a/tests/qemu-iotests/iotests.py
+++ b/tests/qemu-iotests/iotests.py
@@ -596,9 +596,23 @@ class QMPTestCase(unittest.TestCase):
         self.fail('path "%s" has value "%s"' % (path, str(result)))
=20
     def assert_qmp(self, d, path, value):
-        '''Assert that the value for a specific path in a QMP dict match=
es'''
+        '''Assert that the value for a specific path in a QMP dict
+           matches.  When given a list of values, assert that any of
+           them matches.'''
+
         result =3D self.dictpath(d, path)
-        self.assertEqual(result, value, 'values not equal "%s" and "%s"'=
 % (str(result), str(value)))
+
+        # [] makes no sense as a list of valid values, so treat it as
+        # an actual single value.
+        if isinstance(value, list) and value !=3D []:
+            for v in value:
+                if result =3D=3D v:
+                    return
+            self.fail('no match for "%s" in %s' % (str(result), str(valu=
e)))
+        else:
+            self.assertEqual(result, value,
+                             'values not equal "%s" and "%s"'
+                                 % (str(result), str(value)))
=20
     def assert_no_active_block_jobs(self):
         result =3D self.vm.qmp('query-block-jobs')
--=20
2.21.0


