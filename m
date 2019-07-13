Return-Path: <SRS0=hUdw=VK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D752BC742D7
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Jul 2019 14:34:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC87420838
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Jul 2019 14:34:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC87420838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56576 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hmJ6P-0000VP-9z
	for qemu-devel@archiver.kernel.org; Sat, 13 Jul 2019 10:34:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46537)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <marcandre.lureau@redhat.com>) id 1hmJ65-0008AT-Tb
 for qemu-devel@nongnu.org; Sat, 13 Jul 2019 10:33:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcandre.lureau@redhat.com>) id 1hmJ64-0006xm-Ri
 for qemu-devel@nongnu.org; Sat, 13 Jul 2019 10:33:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33744)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
 id 1hmJ64-0006bK-Lo
 for qemu-devel@nongnu.org; Sat, 13 Jul 2019 10:33:56 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 5DD5E85376;
 Sat, 13 Jul 2019 14:33:36 +0000 (UTC)
Received: from localhost (ovpn-112-50.ams2.redhat.com [10.36.112.50])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CB82E19699;
 Sat, 13 Jul 2019 14:33:28 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
To: qemu-devel@nongnu.org
Date: Sat, 13 Jul 2019 18:33:06 +0400
Message-Id: <20190713143311.17620-2-marcandre.lureau@redhat.com>
In-Reply-To: <20190713143311.17620-1-marcandre.lureau@redhat.com>
References: <20190713143311.17620-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.25]); Sat, 13 Jul 2019 14:33:36 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v3 1/6] docker.py: add --run-as-current-user
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
Cc: Fam Zheng <fam@euphon.net>, berrange@redhat.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 pbonzini@redhat.com, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Podman will need further tweaks.

Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 tests/docker/Makefile.include | 2 +-
 tests/docker/docker.py        | 5 +++++
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/tests/docker/Makefile.include b/tests/docker/Makefile.includ=
e
index aaf5396b85..f4226b79d0 100644
--- a/tests/docker/Makefile.include
+++ b/tests/docker/Makefile.include
@@ -212,7 +212,7 @@ docker-run: docker-qemu-src
 			"  COPYING $(EXECUTABLE) to $(IMAGE)"))
 	$(call quiet-command,						\
 		$(DOCKER_SCRIPT) run 					\
-			$(if $(NOUSER),,-u $(shell id -u)) 		\
+			$(if $(NOUSER),,--run-as-current-user) 		\
 			--security-opt seccomp=3Dunconfined		\
 			$(if $V,,--rm) 					\
 			$(if $(DEBUG),-ti,)				\
diff --git a/tests/docker/docker.py b/tests/docker/docker.py
index 53a8c9c801..f15545aeea 100755
--- a/tests/docker/docker.py
+++ b/tests/docker/docker.py
@@ -333,8 +333,13 @@ class RunCommand(SubCommand):
     def args(self, parser):
         parser.add_argument("--keep", action=3D"store_true",
                             help=3D"Don't remove image when command comp=
letes")
+        parser.add_argument("--run-as-current-user", action=3D"store_tru=
e",
+                            help=3D"Run container using the current user=
's uid")
=20
     def run(self, args, argv):
+        if args.run_as_current_user:
+            uid =3D os.getuid()
+            argv =3D [ "-u", str(uid) ] + argv
         return Docker().run(argv, args.keep, quiet=3Dargs.quiet)
=20
=20
--=20
2.22.0.428.g6d5b264208


