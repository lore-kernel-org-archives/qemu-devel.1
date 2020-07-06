Return-Path: <SRS0=h+Ky=AR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51344C433DF
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 16:49:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1AEAD206CD
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 16:49:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="McucH8Q+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1AEAD206CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54800 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jsUIj-0007h6-6c
	for qemu-devel@archiver.kernel.org; Mon, 06 Jul 2020 12:49:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56694)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jsUBv-0002ut-Od
 for qemu-devel@nongnu.org; Mon, 06 Jul 2020 12:42:03 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:27430
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jsUBu-00032b-6F
 for qemu-devel@nongnu.org; Mon, 06 Jul 2020 12:42:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594053721;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wB2KfdBqisZtBMY/mngn0ukXhbbrFWFuRArgpJoTIRQ=;
 b=McucH8Q+7ssfrJTzPYWg+6Nnx9XSIhB8g3aF1LHaNF9gopkCymWflrtVtgTSAFIWAqDCiE
 XBtAsKK511QZBVmqw/MMVJV3CJUZaFAT0QYV618BEwVCL+MbjueUq13I7ZaNI8NRtDtXSy
 6Z4lOPf0FPsscomWJX3LydhOs0lLQPw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-51-I6YrCRVCPoClo87Eq_BfVw-1; Mon, 06 Jul 2020 12:41:59 -0400
X-MC-Unique: I6YrCRVCPoClo87Eq_BfVw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 096831005510;
 Mon,  6 Jul 2020 16:41:58 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9A02B100238C;
 Mon,  6 Jul 2020 16:41:57 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 02/53] tests: Inject test name also when the test fails
Date: Mon,  6 Jul 2020 12:41:04 -0400
Message-Id: <20200706164155.24696-3-pbonzini@redhat.com>
In-Reply-To: <20200706164155.24696-1-pbonzini@redhat.com>
References: <20200706164155.24696-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/06 01:52:41
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Havard Skinnemoen <hskinnemoen@google.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Havard Skinnemoen <hskinnemoen@google.com>

If a test is unsuccessful, the result is "not ok", which does not match
the regex because it includes a space.

This regex matches both "ok" and "not ok".

Signed-off-by: Havard Skinnemoen <hskinnemoen@google.com>
Message-Id: <20200628213046.2028271-1-hskinnemoen@google.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 tests/Makefile.include | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/Makefile.include b/tests/Makefile.include
index 3f4448a20b..09df2d3f86 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -637,7 +637,7 @@ define do_test_tap
           { export MALLOC_PERTURB_=$${MALLOC_PERTURB_:-$$(( $${RANDOM:-0} % 255 + 1))} $2; \
             $(foreach COMMAND, $1, \
 	      $(COMMAND) -m=$(SPEED) -k --tap < /dev/null \
-	      | sed "s/^[a-z][a-z]* [0-9]* /&$(notdir $(COMMAND)) /" || true; ) } \
+	      | sed "s/^\(not \)\?ok [0-9]* /&$(notdir $(COMMAND)) /" || true; ) } \
 	      | ./scripts/tap-merge.pl | tee "$@" \
 	      | ./scripts/tap-driver.pl $(if $(V),, --show-failures-only), \
 	  "TAP","$@")
-- 
2.26.2



