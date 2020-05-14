Return-Path: <SRS0=rzeH=64=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62A20C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 05:59:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 332B6205CB
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 05:59:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EXYki1MY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 332B6205CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47298 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZ6tu-0007nQ-BR
	for qemu-devel@archiver.kernel.org; Thu, 14 May 2020 01:59:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36484)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1jZ6pF-00055v-Lo
 for qemu-devel@nongnu.org; Thu, 14 May 2020 01:54:33 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:43705
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1jZ6pE-0001c3-A6
 for qemu-devel@nongnu.org; Thu, 14 May 2020 01:54:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589435671;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dcSV8AcRgboD0791Na12TrghYbWW2S4QzDgd970wraM=;
 b=EXYki1MYAuEX7vro3IDYfq0E6EIsOqnNAvjeVBjGG2gQ92H1QEKpeLe3F7kXIV78ZpSfSW
 xbWo88yHIFMClVdIPMqC0jmF/CFpWagGopfv/MM9H5soj7eBpH+OUhqvx9n8swegu/WynY
 qKfNbQr8W+PIc78NouLhuDFwNSR9MEA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-474-3iFNAzb_O8GPtS9Ssli7uA-1; Thu, 14 May 2020 01:54:29 -0400
X-MC-Unique: 3iFNAzb_O8GPtS9Ssli7uA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 89DF2BFC0;
 Thu, 14 May 2020 05:54:28 +0000 (UTC)
Received: from probe.redhat.com (ovpn-113-9.rdu2.redhat.com [10.10.113.9])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 29B326A977;
 Thu, 14 May 2020 05:54:27 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH RFC 11/32] python/qemu/lib: remove Python2 style super() calls
Date: Thu, 14 May 2020 01:53:42 -0400
Message-Id: <20200514055403.18902-12-jsnow@redhat.com>
In-Reply-To: <20200514055403.18902-1-jsnow@redhat.com>
References: <20200514055403.18902-1-jsnow@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/13 22:25:42
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>,
 John Snow <jsnow@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Use the Python3 style instead.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 python/qemu/lib/machine.py |  2 +-
 python/qemu/lib/qtest.py   | 15 +++++++--------
 2 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/python/qemu/lib/machine.py b/python/qemu/lib/machine.py
index 4b260fa2cb..b2f0412197 100644
--- a/python/qemu/lib/machine.py
+++ b/python/qemu/lib/machine.py
@@ -55,7 +55,7 @@ def __init__(self, reply):
             desc = reply["error"]["desc"]
         except KeyError:
             desc = reply
-        super(MonitorResponseError, self).__init__(desc)
+        super().__init__(desc)
         self.reply = reply
 
 
diff --git a/python/qemu/lib/qtest.py b/python/qemu/lib/qtest.py
index 53d814c064..7943487c2b 100644
--- a/python/qemu/lib/qtest.py
+++ b/python/qemu/lib/qtest.py
@@ -101,29 +101,28 @@ def __init__(self, binary, args=None, name=None, test_dir="/var/tmp",
             name = "qemu-%d" % os.getpid()
         if sock_dir is None:
             sock_dir = test_dir
-        super(QEMUQtestMachine,
-              self).__init__(binary, args, name=name, test_dir=test_dir,
-                             socket_scm_helper=socket_scm_helper,
-                             sock_dir=sock_dir)
+        super().__init__(binary, args, name=name, test_dir=test_dir,
+                         socket_scm_helper=socket_scm_helper,
+                         sock_dir=sock_dir)
         self._qtest = None
         self._qtest_path = os.path.join(sock_dir, name + "-qtest.sock")
 
     def _base_args(self):
-        args = super(QEMUQtestMachine, self)._base_args()
+        args = super()._base_args()
         args.extend(['-qtest', 'unix:path=' + self._qtest_path,
                      '-accel', 'qtest'])
         return args
 
     def _pre_launch(self):
-        super(QEMUQtestMachine, self)._pre_launch()
+        super()._pre_launch()
         self._qtest = QEMUQtestProtocol(self._qtest_path, server=True)
 
     def _post_launch(self):
-        super(QEMUQtestMachine, self)._post_launch()
+        super()._post_launch()
         self._qtest.accept()
 
     def _post_shutdown(self):
-        super(QEMUQtestMachine, self)._post_shutdown()
+        super()._post_shutdown()
         self._remove_if_exists(self._qtest_path)
 
     def qtest(self, cmd):
-- 
2.21.1


