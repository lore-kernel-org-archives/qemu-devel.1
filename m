Return-Path: <SRS0=A34B=UQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AE7EC31E44
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 04:45:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA105218A0
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 04:45:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA105218A0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44228 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hcjVw-0006mp-Ul
	for qemu-devel@archiver.kernel.org; Mon, 17 Jun 2019 00:45:04 -0400
Received: from eggs.gnu.org ([209.51.188.92]:60322)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <kraxel@redhat.com>) id 1hcjQJ-0001Sh-CY
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 00:39:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kraxel@redhat.com>) id 1hcjQH-0005xr-1v
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 00:39:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34122)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1hcjQG-0005w2-EZ
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 00:39:12 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id D24DC86658;
 Mon, 17 Jun 2019 04:39:10 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-33.ams2.redhat.com
 [10.36.116.33])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B55C57DDA0;
 Mon, 17 Jun 2019 04:39:05 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 0D95317446; Mon, 17 Jun 2019 06:38:59 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Date: Mon, 17 Jun 2019 06:38:52 +0200
Message-Id: <20190617043858.8290-6-kraxel@redhat.com>
In-Reply-To: <20190617043858.8290-1-kraxel@redhat.com>
References: <20190617043858.8290-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.26]); Mon, 17 Jun 2019 04:39:10 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v4 05/11] tests/vm: add vm-boot-{ssh,
 serial}-<guest> targets
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

For testing/troubleshooting convinience.

make vm-boot-serial-<guest>
  Boot guest, with the serial console on stdio.

make vm-boot-ssh-<guest>
  Boot guest, login via ssh.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Tested-by: Thomas Huth <thuth@redhat.com>
---
 tests/vm/Makefile.include | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/tests/vm/Makefile.include b/tests/vm/Makefile.include
index 276b870216c4..e329129bd658 100644
--- a/tests/vm/Makefile.include
+++ b/tests/vm/Makefile.include
@@ -20,6 +20,10 @@ vm-test:
 	@echo "  vm-build-all                    - Build QEMU in all VMs"
 	@echo "  vm-clean-all                    - Clean up VM images"
 	@echo
+	@echo "For trouble-shooting:"
+	@echo "  vm-boot-serial-<guest>          - Boot guest, serial console on stdio"
+	@echo "  vm-boot-ssh-<guest>             - Boot guest and login via ssh"
+	@echo
 	@echo "Special variables:"
 	@echo "    BUILD_TARGET=foo		 - Override the build target"
 	@echo "    TARGET_LIST=a,b,c    	 - Override target list in builds"
@@ -63,3 +67,18 @@ vm-build-%: $(IMAGES_DIR)/%.img
 		$(if $(EXTRA_CONFIGURE_OPTS),$(EXTRA_CONFIGURE_OPTS)), \
 		"  VM-BUILD $*")
 
+vm-boot-serial-%: $(IMAGES_DIR)/%.img
+	qemu-system-x86_64 -enable-kvm -m 4G -smp 2 -nographic \
+		-drive if=none,id=vblk,cache=writeback,file="$<" \
+		-netdev user,id=vnet \
+		-device virtio-blk-pci,drive=vblk \
+		-device virtio-net-pci,netdev=vnet \
+	|| true
+
+vm-boot-ssh-%: $(IMAGES_DIR)/%.img
+	$(call quiet-command, \
+		$(SRC_PATH)/tests/vm/$* \
+		--image "$<" \
+		--interactive \
+		false, \
+		"  VM-BOOT-SSH $*")
-- 
2.18.1


