Return-Path: <SRS0=/2J2=CK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5615C433E7
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 17:42:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 74AA3207D3
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 17:42:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z6q6hTHb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74AA3207D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38484 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDAIP-0007Ey-LL
	for qemu-devel@archiver.kernel.org; Tue, 01 Sep 2020 13:42:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33474)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kDAFB-0003b4-OR
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 13:38:53 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:54418
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kDAFA-00017a-2h
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 13:38:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598981931;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/5ElC+IDQzjUEB+U6vEV/euV5M7/eAdI/JpuxnYjyxU=;
 b=Z6q6hTHbhybR3iiHFVXTLr7poCzd1pVyp6OpU3xmEQ6Z7lzwY6FainKFXFL8iG8sWgc6Wt
 /ijODDwbF2SKUmmrKU/3OJUnVxycakzZA96b97i67m0uFtsMHSXtliMYjD7BnMKymLAVBl
 LLViFFwlKetMidhWYVbRAJwQJLWNODU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-232-KsZxm3LfMLqSJuqh-OOOzw-1; Tue, 01 Sep 2020 13:38:48 -0400
X-MC-Unique: KsZxm3LfMLqSJuqh-OOOzw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BDC64100746D;
 Tue,  1 Sep 2020 17:38:47 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7B30151C4F;
 Tue,  1 Sep 2020 17:38:47 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 26/26] Makefile: Fix in-tree clean/distclean
Date: Tue,  1 Sep 2020 13:38:42 -0400
Message-Id: <20200901173842.5882-5-pbonzini@redhat.com>
In-Reply-To: <20200901173842.5882-1-pbonzini@redhat.com>
References: <20200901173842.5882-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/01 05:11:36
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
Cc: Greg Kurz <groug@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Greg Kurz <groug@kaod.org>

Doing 'make clean' or 'make distclean' in a freshly cloned tree results in:

make: *** No rule to make target 'ninja-clean', needed by 'clean'.  Stop.

Make the fallback rules global. While here, change the ninjatool recipe to
always have a zero exit status and thus prevent make to emit a warning.

Fixes: a56650518f5b ("configure: integrate Meson in the build system")
Signed-off-by: Greg Kurz <groug@kaod.org>
Message-Id: <159897001659.442705.15538955005543395950.stgit@bahia.lan>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 Makefile | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/Makefile b/Makefile
index 049e2ffa03..ed354c43b0 100644
--- a/Makefile
+++ b/Makefile
@@ -54,13 +54,6 @@ export NINJA=./ninjatool
 # enough to prime the rest of the build.
 ninjatool: build.ninja
 
-# Only needed in case Makefile.ninja does not exist.
-.PHONY: ninja-clean ninja-distclean clean-ctlist
-clean-ctlist:
-ninja-clean::
-ninja-distclean::
-build.ninja: config-host.mak
-
 Makefile.ninja: build.ninja ninjatool
 	./ninjatool -t ninja2make --omit clean dist uninstall cscope TAGS ctags < $< > $@
 -include Makefile.ninja
@@ -115,6 +108,13 @@ ifneq ($(filter-out $(UNCHECKED_GOALS),$(MAKECMDGOALS)),$(if $(MAKECMDGOALS),,fa
 endif
 endif
 
+# Only needed in case Makefile.ninja does not exist.
+.PHONY: ninja-clean ninja-distclean clean-ctlist
+clean-ctlist:
+ninja-clean::
+ninja-distclean::
+build.ninja: config-host.mak
+
 include $(SRC_PATH)/rules.mak
 
 # lor is defined in rules.mak
@@ -195,7 +195,7 @@ recurse-clean: $(addsuffix /clean, $(ROM_DIRS))
 ######################################################################
 
 clean: recurse-clean ninja-clean clean-ctlist
-	-test -f ninjatool && ./ninjatool $(if $(V),-v,) -t clean
+	if test -f ninjatool; then ./ninjatool $(if $(V),-v,) -t clean; fi
 # avoid old build problems by removing potentially incorrect old files
 	rm -f config.mak op-i386.h opc-i386.h gen-op-i386.h op-arm.h opc-arm.h gen-op-arm.h
 	find . \( -name '*.so' -o -name '*.dll' -o -name '*.[oda]' \) -type f \
-- 
2.26.2


