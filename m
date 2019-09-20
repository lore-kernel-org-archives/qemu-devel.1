Return-Path: <SRS0=N0XV=XP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62165C4CECE
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2019 08:40:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3B797207E0
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2019 08:40:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B797207E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56422 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iBET6-00041k-8t
	for qemu-devel@archiver.kernel.org; Fri, 20 Sep 2019 04:40:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45636)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <lersek@redhat.com>) id 1iBEQm-0001Z4-3d
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 04:38:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <lersek@redhat.com>) id 1iBEQk-0002ie-Q6
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 04:38:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46206)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <lersek@redhat.com>) id 1iBEQk-0002iP-LL
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 04:38:18 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 01F48C057F31
 for <qemu-devel@nongnu.org>; Fri, 20 Sep 2019 08:38:18 +0000 (UTC)
Received: from lacos-laptop-7.usersys.redhat.com (ovpn-120-165.rdu2.redhat.com
 [10.10.120.165])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 43BE960BF1;
 Fri, 20 Sep 2019 08:38:17 +0000 (UTC)
From: Laszlo Ersek <lersek@redhat.com>
To: qemu devel list <qemu-devel@nongnu.org>
Subject: [PATCH v2 1/2] edk2 build scripts: honor external BaseTools flags
 with uefi-test-tools
Date: Fri, 20 Sep 2019 10:38:07 +0200
Message-Id: <20190920083808.21399-2-lersek@redhat.com>
In-Reply-To: <20190920083808.21399-1-lersek@redhat.com>
References: <20190920083808.21399-1-lersek@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.32]); Fri, 20 Sep 2019 08:38:18 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Unify the recipe for "build-edk2-tools" in
"tests/uefi-test-tools/Makefile" with the recipe for "edk2-basetools" in
"roms/Makefile".

Cc: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Signed-off-by: Laszlo Ersek <lersek@redhat.com>
---

Notes:
    v2:
    - new patch

 tests/uefi-test-tools/Makefile | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tests/uefi-test-tools/Makefile b/tests/uefi-test-tools/Makef=
ile
index 1d78bc14d51a..7e0177d7337e 100644
--- a/tests/uefi-test-tools/Makefile
+++ b/tests/uefi-test-tools/Makefile
@@ -99,7 +99,9 @@ Build/bios-tables-test.%.efi: build-edk2-tools
 	+./build.sh $(edk2_dir) BiosTablesTest $* $@
=20
 build-edk2-tools:
-	$(MAKE) -C $(edk2_dir)/BaseTools
+	$(MAKE) -C $(edk2_dir)/BaseTools \
+		EXTRA_OPTFLAGS=3D'$(EDK2_BASETOOLS_OPTFLAGS)' \
+		EXTRA_LDFLAGS=3D'$(EDK2_BASETOOLS_LDFLAGS)'
=20
 clean:
 	rm -rf Build Conf log
--=20
2.19.1.3.g30247aa5d201



