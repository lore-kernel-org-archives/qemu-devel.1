Return-Path: <SRS0=gE17=CB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83E0DC433DF
	for <qemu-devel@archiver.kernel.org>; Sun, 23 Aug 2020 11:21:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4CCA82067C
	for <qemu-devel@archiver.kernel.org>; Sun, 23 Aug 2020 11:21:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OXoeS4BU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CCA82067C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36588 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k9o3f-0002P0-Eq
	for qemu-devel@archiver.kernel.org; Sun, 23 Aug 2020 07:21:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45210)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1k9o0z-0006Gr-4d
 for qemu-devel@nongnu.org; Sun, 23 Aug 2020 07:18:21 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:36616
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1k9o0x-0001gc-Lo
 for qemu-devel@nongnu.org; Sun, 23 Aug 2020 07:18:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598181499;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:in-reply-to:in-reply-to:
 references:references; bh=J+CitJfPbt2EThF7a0J0F0eHAT8/w+MaREbR+uKJZjs=;
 b=OXoeS4BUDmtx6uCV8XkahjsOf59yOmfCn6KPmyzrFBZItYS/c3bEc9ZviVBI0rCLjNBwpB
 fPWnaO8JHi5xz1FS+YXfEDrCmGY7OZHMEYsow/LhQSNz7ab+2lO6TwfUEebKH988froNc+
 rm1Mj9VqLW2rk4buVtf4b+Gr0dx/aOU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-449-DuV3rvNfPKuoxh2BZeSsMw-1; Sun, 23 Aug 2020 07:18:13 -0400
X-MC-Unique: DuV3rvNfPKuoxh2BZeSsMw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 521CB1885D9C;
 Sun, 23 Aug 2020 11:18:12 +0000 (UTC)
Received: from thuth.com (ovpn-112-57.ams2.redhat.com [10.36.112.57])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 836385BAC3;
 Sun, 23 Aug 2020 11:18:10 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH v2 3/7] tests/Makefile: test-image-locking needs CONFIG_POSIX
Date: Sun, 23 Aug 2020 13:17:53 +0200
Message-Id: <20200823111757.72002-4-thuth@redhat.com>
In-Reply-To: <20200823111757.72002-1-thuth@redhat.com>
References: <20200823111757.72002-1-thuth@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=thuth@redhat.com
X-Mimecast-Spam-Score: 0.0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Received-SPF: pass client-ip=207.211.31.120; envelope-from=thuth@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/23 07:18:14
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.959,
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
Cc: =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Stefan Weil <sw@weilnetz.de>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>, luoyonggang@gmail.com,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

test-image-locking.c uses the qemu_lock_fd_test() function which is
only available on POSIX-like systems.

Reviewed-by: John Snow <jsnow@redhat.com>
Message-Id: <20200804170055.2851-4-thuth@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/Makefile.include | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tests/Makefile.include b/tests/Makefile.include
index 9ac8f5b86a..497f1f21ff 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -87,7 +87,9 @@ check-unit-$(CONFIG_BLOCK) += tests/test-blockjob$(EXESUF)
 check-unit-$(CONFIG_BLOCK) += tests/test-blockjob-txn$(EXESUF)
 check-unit-$(CONFIG_BLOCK) += tests/test-block-backend$(EXESUF)
 check-unit-$(CONFIG_BLOCK) += tests/test-block-iothread$(EXESUF)
+ifeq ($(CONFIG_POSIX),y)
 check-unit-$(CONFIG_BLOCK) += tests/test-image-locking$(EXESUF)
+endif
 check-unit-y += tests/test-x86-cpuid$(EXESUF)
 # all code tested by test-x86-cpuid is inside topology.h
 ifeq ($(CONFIG_SOFTMMU),y)
-- 
2.18.2


