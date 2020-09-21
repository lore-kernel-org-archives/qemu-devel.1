Return-Path: <SRS0=MAm8=C6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 442E4C43469
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 16:44:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD02623976
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 16:44:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FGZ0okMv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD02623976
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34770 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKOvY-00005p-QT
	for qemu-devel@archiver.kernel.org; Mon, 21 Sep 2020 12:44:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58106)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kKOlu-0006zN-5z
 for qemu-devel@nongnu.org; Mon, 21 Sep 2020 12:34:34 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:33169
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kKOlq-00081r-F9
 for qemu-devel@nongnu.org; Mon, 21 Sep 2020 12:34:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600706069;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=mxyU2UsYIapLWeI/m9pnErkY5BZXXfsVIe9axCDHUxk=;
 b=FGZ0okMvBce2Iuaj/t60PU5rXt2QJ8UoUg+Oqrbr36FCctTyVsMM4NuQyP4f75VF4wMefN
 pCqQQI/CEKOXNkp7p140GdNZFvP3hAkhaJUJZ3rOaHcfBx0ti0AuujXQqd3vMG9MlPgax0
 y63y955CIRgvqcRnNndmW2X5WQcoH+4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-512-VublQqc6P2OYMyk9CIkJqA-1; Mon, 21 Sep 2020 12:34:27 -0400
X-MC-Unique: VublQqc6P2OYMyk9CIkJqA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 416051005504;
 Mon, 21 Sep 2020 16:34:26 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 014EC5576C;
 Mon, 21 Sep 2020 16:34:25 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] tests/tcg: reinstate or replace desired parts of rules.mak
Date: Mon, 21 Sep 2020 12:34:25 -0400
Message-Id: <20200921163425.1410280-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/21 04:38:49
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.455,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Commit 660f79309303d696531ffb394719dfab3e0c42c0 was a bit overzealous
with respect to tests/tcg, which needed quiet-command and $(BUILD_DIR).
Reinstate quiet-command, and replace $(BUILD_DIR) with just the
current directory.

Reported-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 tests/tcg/Makefile.qemu | 13 ++++++++++++-
 tests/tcg/configure.sh  |  4 ++--
 2 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/tests/tcg/Makefile.qemu b/tests/tcg/Makefile.qemu
index 0332bad10f..c096c611a2 100644
--- a/tests/tcg/Makefile.qemu
+++ b/tests/tcg/Makefile.qemu
@@ -11,9 +11,20 @@
 # The configure script fills in extra information about
 # useful docker images or alternative compiler flags.
 
+# Usage: $(call quiet-command,command and args,"NAME","args to print")
+# This will run "command and args", and either:
+#  if V=1 just print the whole command and args
+#  otherwise print the 'quiet' output in the format "  NAME     args to print"
+# NAME should be a short name of the command, 7 letters or fewer.
+# If called with only a single argument, will print nothing in quiet mode.
+quiet-command-run = $(if $(V),,$(if $2,printf "  %-7s %s\n" $2 $3 && ))$1
+quiet-@ = $(if $(V),,@)
+quiet-command = $(quiet-@)$(call quiet-command-run,$1,$2,$3)
+
 CROSS_CC_GUEST:=
 DOCKER_IMAGE:=
--include $(BUILD_DIR)/tests/tcg/config-$(TARGET).mak
+
+-include tests/tcg/config-$(TARGET).mak
 
 GUEST_BUILD=
 TCG_MAKE=../Makefile.target
diff --git a/tests/tcg/configure.sh b/tests/tcg/configure.sh
index 598a50cd4f..be51bdb5a4 100755
--- a/tests/tcg/configure.sh
+++ b/tests/tcg/configure.sh
@@ -193,11 +193,11 @@ for target in $target_list; do
   case $target in
     *-linux-user | *-bsd-user)
       echo "CONFIG_USER_ONLY=y" >> $config_target_mak
-      echo "QEMU=\$(BUILD_DIR)/qemu-$arch" >> $config_target_mak
+      echo "QEMU=$PWD/qemu-$arch" >> $config_target_mak
       ;;
     *-softmmu)
       echo "CONFIG_SOFTMMU=y" >> $config_target_mak
-      echo "QEMU=\$(BUILD_DIR)/qemu-system-$arch" >> $config_target_mak
+      echo "QEMU=$PWD/qemu-system-$arch" >> $config_target_mak
       ;;
   esac
 
-- 
2.26.2


