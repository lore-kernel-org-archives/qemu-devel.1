Return-Path: <SRS0=xVqP=Z2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8179C43603
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2019 22:13:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 918E4206DF
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2019 22:13:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="feLFmfNC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 918E4206DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47624 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iccu2-0002Pn-OO
	for qemu-devel@archiver.kernel.org; Wed, 04 Dec 2019 17:13:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48014)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1icct8-0001sg-ET
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 17:12:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1icct3-000282-Uu
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 17:12:48 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:47053
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iccsz-0001yZ-P5
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 17:12:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575497559;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=oisQGT+zu/XqbpDrQdC6TgXtb67Tncg2LO7THUXe4cw=;
 b=feLFmfNCS/WUtGMQZdwg72h4kic8O0K54kHbm6KOy5Q6Aqxh847fzTKdbWwYt7Uf27sKJ7
 DRlhpomY/hpNfThPJ7aMJ4cJVlN7tO6gG0qErjvew4E2hLv+0J/I+AKileXQ9nNu7ACGDr
 JVp8Lr++tWc4WozCM/mkN5m5zqtM7SE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-119-D4cGCC1xPViPnRjRH8TJ1g-1; Wed, 04 Dec 2019 17:12:38 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9F144801E76
 for <qemu-devel@nongnu.org>; Wed,  4 Dec 2019 22:12:35 +0000 (UTC)
Received: from x1w.redhat.com (ovpn-205-76.brq.redhat.com [10.40.205.76])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E31A95D9C5;
 Wed,  4 Dec 2019 22:12:31 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH-for-5.0] roms/edk2-funcs.sh: Use available GCC for ARM/Aarch64
 targets
Date: Wed,  4 Dec 2019 23:12:29 +0100
Message-Id: <20191204221229.30612-1-philmd@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: D4cGCC1xPViPnRjRH8TJ1g-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Laszlo Ersek <lersek@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Centos 7.7 only provides cross GCC 4.8.5, but the script forces
us to use GCC5. Since the same machinery is valid to check the
GCC version, remove the $emulation_target check.

  $ cat /etc/redhat-release
  CentOS Linux release 7.7.1908 (Core)

  $ aarch64-linux-gnu-gcc -v 2>&1 | tail -1
  gcc version 4.8.5 20150623 (Red Hat 4.8.5-16) (GCC)

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
Patch to review with --ignore-all-space
---
 roms/edk2-funcs.sh | 48 +++++++++++++++++++---------------------------
 1 file changed, 20 insertions(+), 28 deletions(-)

diff --git a/roms/edk2-funcs.sh b/roms/edk2-funcs.sh
index 3f4485b201..a455611c0d 100644
--- a/roms/edk2-funcs.sh
+++ b/roms/edk2-funcs.sh
@@ -135,35 +135,27 @@ qemu_edk2_get_toolchain()
     return 1
   fi
=20
-  case "$emulation_target" in
-    (arm|aarch64)
-      printf 'GCC5\n'
+  if ! cross_prefix=3D$(qemu_edk2_get_cross_prefix "$emulation_target"); t=
hen
+    return 1
+  fi
+
+  gcc_version=3D$("${cross_prefix}gcc" -v 2>&1 | tail -1 | awk '{print $3}=
')
+  # Run "git-blame" on "OvmfPkg/build.sh" in edk2 for more information on
+  # the mapping below.
+  case "$gcc_version" in
+    ([1-3].*|4.[0-7].*)
+      printf '%s: unsupported gcc version "%s"\n' \
+        "$program_name" "$gcc_version" >&2
+      return 1
       ;;
-
-    (i386|x86_64)
-      if ! cross_prefix=3D$(qemu_edk2_get_cross_prefix "$emulation_target"=
); then
-        return 1
-      fi
-
-      gcc_version=3D$("${cross_prefix}gcc" -v 2>&1 | tail -1 | awk '{print=
 $3}')
-      # Run "git-blame" on "OvmfPkg/build.sh" in edk2 for more information=
 on
-      # the mapping below.
-      case "$gcc_version" in
-        ([1-3].*|4.[0-7].*)
-          printf '%s: unsupported gcc version "%s"\n' \
-            "$program_name" "$gcc_version" >&2
-          return 1
-          ;;
-        (4.8.*)
-          printf 'GCC48\n'
-          ;;
-        (4.9.*|6.[0-2].*)
-          printf 'GCC49\n'
-          ;;
-        (*)
-          printf 'GCC5\n'
-          ;;
-      esac
+    (4.8.*)
+      printf 'GCC48\n'
+      ;;
+    (4.9.*|6.[0-2].*)
+      printf 'GCC49\n'
+      ;;
+    (*)
+      printf 'GCC5\n'
       ;;
   esac
 }
--=20
2.21.0


