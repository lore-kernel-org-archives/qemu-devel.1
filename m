Return-Path: <SRS0=S/IU=TU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED79DC04AAC
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2019 12:56:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BA68320645
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2019 12:56:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA68320645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:35166 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hShpw-0000Ig-0l
	for qemu-devel@archiver.kernel.org; Mon, 20 May 2019 08:56:16 -0400
Received: from eggs.gnu.org ([209.51.188.92]:43409)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1hShhd-0002SC-T1
	for qemu-devel@nongnu.org; Mon, 20 May 2019 08:47:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1hShha-00060G-7V
	for qemu-devel@nongnu.org; Mon, 20 May 2019 08:47:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47516)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1hShhV-0005vK-4U
	for qemu-devel@nongnu.org; Mon, 20 May 2019 08:47:35 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id DA01030842B3;
	Mon, 20 May 2019 12:47:28 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-117-74.ams2.redhat.com
	[10.36.117.74])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 33B775DE81;
	Mon, 20 May 2019 12:47:24 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
	id 238F31753D; Mon, 20 May 2019 14:47:17 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Date: Mon, 20 May 2019 14:47:08 +0200
Message-Id: <20190520124716.30472-7-kraxel@redhat.com>
In-Reply-To: <20190520124716.30472-1-kraxel@redhat.com>
References: <20190520124716.30472-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.40]);
	Mon, 20 May 2019 12:47:28 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v3 06/14] tests/vm: proper guest shutdown
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
Cc: Fam Zheng <fam@euphon.net>, Ed Maste <emaste@freebsd.org>,
	=?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
	Kamil Rytarowski <kamil@netbsd.org>, Gerd Hoffmann <kraxel@redhat.com>,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
	Li-Wen Hsu <lwhsu@freebsd.org>, Brad Smith <brad@comstyle.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

When not running in snapshot mode ask the guest to poweroff and wait for
this to finish instead of simply quitting qemu, so the guest can flush
pending updates to disk.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Tested-by: Thomas Huth <thuth@redhat.com>
---
 tests/vm/basevm.py | 22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

diff --git a/tests/vm/basevm.py b/tests/vm/basevm.py
index 878f1a7a32b8..465c7b80d011 100755
--- a/tests/vm/basevm.py
+++ b/tests/vm/basevm.py
@@ -51,6 +51,8 @@ class BaseVM(object):
     name = "#base"
     # The guest architecture, to be overridden by subclasses
     arch = "#arch"
+    # command to halt the guest, can be overridden by subclasses
+    poweroff = "poweroff"
     def __init__(self, debug=False, vcpus=None):
         self._guest = None
         self._tmpdir = os.path.realpath(tempfile.mkdtemp(prefix="vm-test-",
@@ -201,6 +203,10 @@ class BaseVM(object):
     def wait(self):
         self._guest.wait()
 
+    def graceful_shutdown(self):
+        self.ssh_root(self.poweroff)
+        self._guest.wait()
+
     def qmp(self, *args, **kwargs):
         return self._guest.qmp(*args, **kwargs)
 
@@ -277,11 +283,13 @@ def main(vmcls):
         traceback.print_exc()
         return 2
 
-    if args.interactive:
-        if vm.ssh(*cmd) == 0:
-            return 0
+    exitcode = 0
+    if vm.ssh(*cmd) != 0:
+        exitcode = 3
+    if exitcode != 0 and args.interactive:
         vm.ssh()
-        return 3
-    else:
-        if vm.ssh(*cmd) != 0:
-            return 3
+
+    if not args.snapshot:
+        vm.graceful_shutdown()
+
+    return exitcode
-- 
2.18.1


