Return-Path: <SRS0=LLOU=EL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42EAAC00A89
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2020 12:47:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 89D772083B
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2020 12:47:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HJD9sQ+m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89D772083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44064 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kaefk-0006fK-8E
	for qemu-devel@archiver.kernel.org; Thu, 05 Nov 2020 07:47:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47234)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kaee7-0005Fd-Ue
 for qemu-devel@nongnu.org; Thu, 05 Nov 2020 07:45:43 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:30070)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kaee6-0001Sm-8T
 for qemu-devel@nongnu.org; Thu, 05 Nov 2020 07:45:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604580337;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=vcgxZJwI/c7varJiP8+ZtbOFfGw+5olrMRJpbJ8raes=;
 b=HJD9sQ+mtRFDi5hFl5ZcjHE6wT54gkcFPfhUMCkArwj/EZ07GUm8fq2SiTuX8PG8GEeQBJ
 I8N67HWWMk2b4HrgH3u1hfIUcoia8SwedrjEI5Q8RTDgeaRHwxNt3+joENKm2bZuS2X0Go
 cUMaRF/OQm9gjuqpZkWNnmeZrkQEr2Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-147-1jMTwQlFMHyz9fqldp1hoA-1; Thu, 05 Nov 2020 07:45:35 -0500
X-MC-Unique: 1jMTwQlFMHyz9fqldp1hoA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F0AB8107464B
 for <qemu-devel@nongnu.org>; Thu,  5 Nov 2020 12:45:34 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A2CC85D98F;
 Thu,  5 Nov 2020 12:45:34 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] fix make clean/distclean
Date: Thu,  5 Nov 2020 07:45:34 -0500
Message-Id: <20201105124534.620635-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/05 01:14:53
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

A misplaced $(quiet-@) meant that "make clean" and "make distclean" did
not work properly.

Reported-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 Makefile | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Makefile b/Makefile
index 9465720696..6f2da3e7dc 100644
--- a/Makefile
+++ b/Makefile
@@ -212,8 +212,8 @@ recurse-clean: $(addsuffix /clean, $(ROM_DIRS))
 ######################################################################
 
 clean: recurse-clean
-	-@test -f build.ninja && $(quiet-@)$(NINJA) $(NINJAFLAGS) -t clean || :
-	-@test -f build.ninja && $(NINJA) $(NINJAFLAGS) clean-ctlist || :
+	-$(quiet-@)test -f build.ninja && $(NINJA) $(NINJAFLAGS) -t clean || :
+	-$(quiet-@)test -f build.ninja && $(NINJA) $(NINJAFLAGS) clean-ctlist || :
 # avoid old build problems by removing potentially incorrect old files
 	rm -f config.mak op-i386.h opc-i386.h gen-op-i386.h op-arm.h opc-arm.h gen-op-arm.h
 	find . \( -name '*.so' -o -name '*.dll' -o -name '*.[oda]' \) -type f \
@@ -231,7 +231,7 @@ qemu-%.tar.bz2:
 	$(SRC_PATH)/scripts/make-release "$(SRC_PATH)" "$(patsubst qemu-%.tar.bz2,%,$@)"
 
 distclean: clean
-	-@test -f build.ninja && $(quiet-@)$(NINJA) $(NINJAFLAGS) -t clean -g || :
+	-$(quiet-@)test -f build.ninja && $(NINJA) $(NINJAFLAGS) -t clean -g || :
 	rm -f config-host.mak config-host.h*
 	rm -f tests/tcg/config-*.mak
 	rm -f config-all-disas.mak config.status
-- 
2.26.2


