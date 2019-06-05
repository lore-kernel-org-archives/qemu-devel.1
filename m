Return-Path: <SRS0=3v23=UE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0270CC28CC5
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2019 16:17:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB33D206B8
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2019 16:17:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB33D206B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:45787 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYYbZ-0003NI-3n
	for qemu-devel@archiver.kernel.org; Wed, 05 Jun 2019 12:17:37 -0400
Received: from eggs.gnu.org ([209.51.188.92]:60071)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hYYVw-0007Zy-K7
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 12:11:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hYYVv-00036A-LJ
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 12:11:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39492)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mreitz@redhat.com>)
	id 1hYYVp-0002fj-IU; Wed, 05 Jun 2019 12:11:43 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
	[10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id CCC3730860BD;
	Wed,  5 Jun 2019 16:11:35 +0000 (UTC)
Received: from localhost (unknown [10.40.205.15])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 629672DE98;
	Wed,  5 Jun 2019 16:11:35 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Date: Wed,  5 Jun 2019 18:11:17 +0200
Message-Id: <20190605161118.14544-4-mreitz@redhat.com>
In-Reply-To: <20190605161118.14544-1-mreitz@redhat.com>
References: <20190605161118.14544-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.44]);
	Wed, 05 Jun 2019 16:11:35 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH 3/4] iotests: Add @has_quit to vm.shutdown()
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org,
	Stefan Hajnoczi <stefanha@redhat.com>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

If a test has issued a quit command already (which may be useful to do
explicitly because the test wants to show its effects),
QEMUMachine.shutdown() should not do so again.  Otherwise, the VM may
well return an ECONNRESET which will lead QEMUMachine.shutdown() to
killing it, which then turns into a "qemu received signal 9" line.

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 python/qemu/__init__.py | 5 +++--
 tests/qemu-iotests/255  | 2 +-
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/python/qemu/__init__.py b/python/qemu/__init__.py
index dbaf8a5311..25207a2970 100644
--- a/python/qemu/__init__.py
+++ b/python/qemu/__init__.py
@@ -332,13 +332,14 @@ class QEMUMachine(object):
         self._load_io_log()
         self._post_shutdown()
=20
-    def shutdown(self):
+    def shutdown(self, has_quit=3DFalse):
         """
         Terminate the VM and clean up
         """
         if self.is_running():
             try:
-                self._qmp.cmd('quit')
+                if not has_quit:
+                    self._qmp.cmd('quit')
                 self._qmp.close()
             except:
                 self._popen.kill()
diff --git a/tests/qemu-iotests/255 b/tests/qemu-iotests/255
index 49433ec122..3632d507d0 100755
--- a/tests/qemu-iotests/255
+++ b/tests/qemu-iotests/255
@@ -132,4 +132,4 @@ with iotests.FilePath('src.qcow2') as src_path, \
     vm.qmp_log('block-job-cancel', device=3D'job0')
     vm.qmp_log('quit')
=20
-    vm.shutdown()
+    vm.shutdown(has_quit=3DTrue)
--=20
2.21.0


