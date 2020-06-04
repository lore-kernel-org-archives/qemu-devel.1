Return-Path: <SRS0=1Qun=7R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0A3BC433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 08:57:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD77A206C3
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 08:57:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mail.uni-paderborn.de header.i=@mail.uni-paderborn.de header.b="mHxgRRr3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD77A206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mail.uni-paderborn.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43548 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jglgu-0004Xk-0v
	for qemu-devel@archiver.kernel.org; Thu, 04 Jun 2020 04:57:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52078)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kbastian@mail.uni-paderborn.de>)
 id 1jgleN-00081u-1n
 for qemu-devel@nongnu.org; Thu, 04 Jun 2020 04:54:59 -0400
Received: from shirlock.uni-paderborn.de ([2001:638:502:c003::15]:42270)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kbastian@mail.uni-paderborn.de>)
 id 1jgleL-0002DV-Nb
 for qemu-devel@nongnu.org; Thu, 04 Jun 2020 04:54:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=mail.uni-paderborn.de; s=20170601; h=Content-Transfer-Encoding:MIME-Version
 :References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=brvcnHsal6sJ680XabMQNi2CBWTShykr93dT+gbawPM=; b=mHxgRRr3l19Q6554eLSOIp7wKz
 1YTk8o7HX+8JxlBMfrUm0hlxwMx2KetenGgYu0pWjSukAxfaKVHLw2YuKj9BCuxdmFA1pkAZoqIQo
 hHAeaNq4VbRjzQrARig+mMvB6utb0jxS7t3072obeEuXEFhSsUsrOC+iKUe2Y8FZYUeo=;
From: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 02/15] tests/tcg: Add docker_as and docker_ld cmds
Date: Thu,  4 Jun 2020 10:54:28 +0200
Message-Id: <20200604085441.103087-3-kbastian@mail.uni-paderborn.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200604085441.103087-1-kbastian@mail.uni-paderborn.de>
References: <20200604085441.103087-1-kbastian@mail.uni-paderborn.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-IMT-Spam-Score: 0.0 ()
X-PMX-Version: 6.4.9.2830568, Antispam-Engine: 2.7.2.2107409,
 Antispam-Data: 2020.6.4.84518, AntiVirus-Engine: 5.74.0,
 AntiVirus-Data: 2020.6.4.5740000
X-Sophos-SenderHistory: ip=2a02:908:2214:e5bc::95d, fs=6898279, da=78869960,
 mc=173, sc=3, hc=170, sp=1, fso=6898279, re=0, sd=0, hd=0
X-IMT-Authenticated-Sender: uid=kbastian,ou=People,o=upb,c=de
Received-SPF: pass client-ip=2001:638:502:c003::15;
 envelope-from=kbastian@mail.uni-paderborn.de; helo=shirlock.uni-paderborn.de
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_PASS=-0.001,
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
Cc: alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

At least for the TriCore target no easily available c compiler exists.
Thus we need to rely on "as" and "ld". This allows us to run them
through the docker image.

Signed-off-by: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
---
 tests/tcg/Makefile.qemu | 11 +++++++++++
 tests/tcg/configure.sh  |  2 ++
 2 files changed, 13 insertions(+)

diff --git a/tests/tcg/Makefile.qemu b/tests/tcg/Makefile.qemu
index 9c23aeaa2a..e5b3a4bacc 100644
--- a/tests/tcg/Makefile.qemu
+++ b/tests/tcg/Makefile.qemu
@@ -50,11 +50,22 @@ DOCKER_COMPILE_CMD="$(DOCKER_SCRIPT) cc \
 		-i qemu:$(DOCKER_IMAGE) \
 		-s $(SRC_PATH) -- "
 
+DOCKER_AS_CMD="$(DOCKER_SCRIPT) cc \
+		--cc $(DOCKER_CROSS_AS_GUEST) \
+		-i qemu:$(DOCKER_IMAGE) \
+		-s $(SRC_PATH) -- "
+
+DOCKER_LD_CMD="$(DOCKER_SCRIPT) cc \
+		--cc $(DOCKER_CROSS_LD_GUEST) \
+		-i qemu:$(DOCKER_IMAGE) \
+		-s $(SRC_PATH) -- "
+
 .PHONY: docker-build-guest-tests
 docker-build-guest-tests: docker-image-$(DOCKER_IMAGE)
 	$(call quiet-command, \
 	  (mkdir -p tests/tcg/$(TARGET) && cd tests/tcg/$(TARGET) && \
 	   $(MAKE) -f $(TCG_MAKE) TARGET="$(TARGET)" CC=$(DOCKER_COMPILE_CMD) \
+			AS=$(DOCKER_AS_CMD) LD=$(DOCKER_LD_CMD) \
 			SRC_PATH="$(SRC_PATH)" BUILD_STATIC=y \
 			EXTRA_CFLAGS="$(CROSS_CC_GUEST_CFLAGS)"), \
 	"BUILD","$(TARGET) guest-tests with docker qemu:$(DOCKER_IMAGE)")
diff --git a/tests/tcg/configure.sh b/tests/tcg/configure.sh
index 2326f97856..6e8659d488 100755
--- a/tests/tcg/configure.sh
+++ b/tests/tcg/configure.sh
@@ -242,6 +242,8 @@ for target in $target_list; do
   if test $got_cross_cc = no && test "$container" != no && test -n "$container_image"; then
     echo "DOCKER_IMAGE=$container_image" >> $config_target_mak
     echo "DOCKER_CROSS_CC_GUEST=$container_cross_cc" >> $config_target_mak
+    echo "DOCKER_CROSS_AS_GUEST=$container_cross_as" >> $config_target_mak
+    echo "DOCKER_CROSS_LD_GUEST=$container_cross_ld" >> $config_target_mak
   fi
 done
 
-- 
2.26.2


