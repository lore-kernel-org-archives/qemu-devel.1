Return-Path: <SRS0=xKZ8=TK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11125C04A6B
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 10:55:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD05920881
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 10:55:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD05920881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:41041 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hP3BD-0006NA-45
	for qemu-devel@archiver.kernel.org; Fri, 10 May 2019 06:55:07 -0400
Received: from eggs.gnu.org ([209.51.188.92]:59702)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1hP332-0008I2-Vw
	for qemu-devel@nongnu.org; Fri, 10 May 2019 06:46:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1hP332-00043D-3r
	for qemu-devel@nongnu.org; Fri, 10 May 2019 06:46:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41568)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1hP331-00042d-Ux
	for qemu-devel@nongnu.org; Fri, 10 May 2019 06:46:40 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 062BA3082B02;
	Fri, 10 May 2019 10:46:39 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-117-74.ams2.redhat.com
	[10.36.117.74])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 413FA5C29A;
	Fri, 10 May 2019 10:46:34 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
	id 6DEFEA1E8; Fri, 10 May 2019 12:46:33 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Date: Fri, 10 May 2019 12:46:22 +0200
Message-Id: <20190510104633.9428-3-kraxel@redhat.com>
In-Reply-To: <20190510104633.9428-1-kraxel@redhat.com>
References: <20190510104633.9428-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.45]);
	Fri, 10 May 2019 10:46:39 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v2 02/13] tests/vm: send proxy environment
 variables over ssh
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

Packages are fetched via proxy that way, if configured on the host.
That might be required to pass firewalls, and it allows to route
package downloads through a caching proxy server.

Needs AcceptEnv setup in sshd_config on the guest side to work.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 tests/vm/basevm.py | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/tests/vm/basevm.py b/tests/vm/basevm.py
index 0556bdcf9e9f..6b46674f4497 100755
--- a/tests/vm/basevm.py
+++ b/tests/vm/basevm.py
@@ -38,6 +38,13 @@ class BaseVM(object):
     GUEST_PASS = "qemupass"
     ROOT_PASS = "qemupass"
 
+    envvars = [
+        "https_proxy",
+        "http_proxy",
+        "ftp_proxy",
+        "no_proxy",
+    ]
+
     # The script to run in the guest that builds QEMU
     BUILD_SCRIPT = ""
     # The guest name, to be overridden by subclasses
@@ -105,6 +112,8 @@ class BaseVM(object):
                    "-o", "UserKnownHostsFile=" + os.devnull,
                    "-o", "ConnectTimeout=1",
                    "-p", self.ssh_port, "-i", self._ssh_key_file]
+        for var in self.envvars:
+            ssh_cmd += ['-o', "SendEnv=%s" % var ]
         if interactive:
             ssh_cmd += ['-t']
         assert not isinstance(cmd, str)
-- 
2.18.1


