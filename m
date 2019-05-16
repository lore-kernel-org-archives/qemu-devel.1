Return-Path: <SRS0=H6GY=TQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 839F6C04E84
	for <qemu-devel@archiver.kernel.org>; Thu, 16 May 2019 11:40:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A64121473
	for <qemu-devel@archiver.kernel.org>; Thu, 16 May 2019 11:40:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A64121473
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:52581 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hREkC-0005KF-AX
	for qemu-devel@archiver.kernel.org; Thu, 16 May 2019 07:40:16 -0400
Received: from eggs.gnu.org ([209.51.188.92]:36945)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1hREjS-00051A-2P
	for qemu-devel@nongnu.org; Thu, 16 May 2019 07:39:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1hREjQ-0005AN-47
	for qemu-devel@nongnu.org; Thu, 16 May 2019 07:39:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:14903)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1hREjP-000590-UP
	for qemu-devel@nongnu.org; Thu, 16 May 2019 07:39:28 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id DDDBD30917F1;
	Thu, 16 May 2019 11:39:25 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-112-59.ams2.redhat.com
	[10.36.112.59])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 504BE60DC8;
	Thu, 16 May 2019 11:39:23 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Date: Thu, 16 May 2019 12:39:22 +0100
Message-Id: <20190516113922.8383-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.41]);
	Thu, 16 May 2019 11:39:25 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH] configure: only link capstone to emulation
 targets
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	Richard Henderson <richard.henderson@linaro.org>,
	=?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Only the emulators link to code that uses capstone, so adding it to the
global LIBs places undesirable dependancies on other binaries, in
particular the tools.

There is no variable that covers both user emulation and machine
emulation, so add a new "$libs_cpu" for this purpose.

In particular this removes the 8 MB capstone dep from the things
qemu-img links against, allowing for a more minimal installation
in scenarios that don't want system emulators installed.

Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
---
 Makefile.target | 1 +
 configure       | 6 ++++--
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/Makefile.target b/Makefile.target
index ae02495951..15e5191f36 100644
--- a/Makefile.target
+++ b/Makefile.target
@@ -117,6 +117,7 @@ obj-$(CONFIG_TCG) +=3D fpu/softfloat.o
 obj-y +=3D target/$(TARGET_BASE_ARCH)/
 obj-y +=3D disas.o
 obj-$(call notempty,$(TARGET_XML_FILES)) +=3D gdbstub-xml.o
+LIBS :=3D $(libs_cpu) $(LIBS)
=20
 #########################################################
 # Linux user emulator target
diff --git a/configure b/configure
index 8999698bc2..64f09c5905 100755
--- a/configure
+++ b/configure
@@ -289,6 +289,7 @@ audio_drv_list=3D""
 block_drv_rw_whitelist=3D""
 block_drv_ro_whitelist=3D""
 host_cc=3D"cc"
+libs_cpu=3D""
 libs_softmmu=3D""
 libs_tools=3D""
 audio_pt_int=3D""
@@ -5015,12 +5016,12 @@ case "$capstone" in
     else
       LIBCAPSTONE=3Dlibcapstone.a
     fi
-    LIBS=3D"-L\$(BUILD_DIR)/capstone -lcapstone $LIBS"
+    libs_cpu=3D"-L\$(BUILD_DIR)/capstone -lcapstone $libs_cpu"
     ;;
=20
   system)
     QEMU_CFLAGS=3D"$QEMU_CFLAGS $($pkg_config --cflags capstone)"
-    LIBS=3D"$($pkg_config --libs capstone) $LIBS"
+    libs_cpu=3D"$($pkg_config --libs capstone) $libs_cpu"
     ;;
=20
   no)
@@ -6488,6 +6489,7 @@ echo "qemu_helperdir=3D$libexecdir" >> $config_host=
_mak
 echo "qemu_localedir=3D$qemu_localedir" >> $config_host_mak
 echo "qemu_icondir=3D$qemu_icondir" >> $config_host_mak
 echo "qemu_desktopdir=3D$qemu_desktopdir" >> $config_host_mak
+echo "libs_cpu=3D$libs_cpu" >> $config_host_mak
 echo "libs_softmmu=3D$libs_softmmu" >> $config_host_mak
 echo "GIT=3D$git" >> $config_host_mak
 echo "GIT_SUBMODULES=3D$git_submodules" >> $config_host_mak
--=20
2.21.0


