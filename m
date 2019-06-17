Return-Path: <SRS0=A34B=UQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 306D5C31E44
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 04:41:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F18CB2187F
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 04:41:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F18CB2187F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44204 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hcjSa-0003NJ-5P
	for qemu-devel@archiver.kernel.org; Mon, 17 Jun 2019 00:41:36 -0400
Received: from eggs.gnu.org ([209.51.188.92]:60162)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <kraxel@redhat.com>) id 1hcjQE-0001P0-Fj
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 00:39:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kraxel@redhat.com>) id 1hcjQC-0005rm-5y
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 00:39:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35642)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1hcjQB-0005oM-Dd
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 00:39:07 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id E78223086222;
 Mon, 17 Jun 2019 04:39:04 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-33.ams2.redhat.com
 [10.36.116.33])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C057582A0C;
 Mon, 17 Jun 2019 04:38:59 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id E184816E19; Mon, 17 Jun 2019 06:38:58 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Date: Mon, 17 Jun 2019 06:38:48 +0200
Message-Id: <20190617043858.8290-2-kraxel@redhat.com>
In-Reply-To: <20190617043858.8290-1-kraxel@redhat.com>
References: <20190617043858.8290-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.42]); Mon, 17 Jun 2019 04:39:05 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v4 01/11] tests/vm: send proxy environment
 variables over ssh
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
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Tested-by: Thomas Huth <thuth@redhat.com>
---
 tests/vm/basevm.py | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/tests/vm/basevm.py b/tests/vm/basevm.py
index 4847549592d5..5e30bac66154 100755
--- a/tests/vm/basevm.py
+++ b/tests/vm/basevm.py
@@ -38,6 +38,13 @@ class BaseVM(object):
     GUEST_PASS =3D "qemupass"
     ROOT_PASS =3D "qemupass"
=20
+    envvars =3D [
+        "https_proxy",
+        "http_proxy",
+        "ftp_proxy",
+        "no_proxy",
+    ]
+
     # The script to run in the guest that builds QEMU
     BUILD_SCRIPT =3D ""
     # The guest name, to be overridden by subclasses
@@ -106,6 +113,8 @@ class BaseVM(object):
                    "-o", "UserKnownHostsFile=3D" + os.devnull,
                    "-o", "ConnectTimeout=3D1",
                    "-p", self.ssh_port, "-i", self._ssh_key_file]
+        for var in self.envvars:
+            ssh_cmd +=3D ['-o', "SendEnv=3D%s" % var ]
         if interactive:
             ssh_cmd +=3D ['-t']
         assert not isinstance(cmd, str)
--=20
2.18.1


