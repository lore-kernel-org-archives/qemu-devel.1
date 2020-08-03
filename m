Return-Path: <SRS0=TdIk=BN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43451C433E0
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Aug 2020 06:58:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0E5442068F
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Aug 2020 06:58:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hDEjQliU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E5442068F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57252 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k2UQz-0008GW-VG
	for qemu-devel@archiver.kernel.org; Mon, 03 Aug 2020 02:58:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51890)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1k2UQI-0007du-Kz
 for qemu-devel@nongnu.org; Mon, 03 Aug 2020 02:58:14 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:57340
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1k2UQH-00029B-3G
 for qemu-devel@nongnu.org; Mon, 03 Aug 2020 02:58:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596437892;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type;
 bh=XHtRpZbafRzfIrkhS2bX9LAwbFZ6A9TAXtUhYRS1IgA=;
 b=hDEjQliUnm+gBtQlaJ6WNg7Ufm+/IwPO0kBlSRjnBWXeeIzc04CqKsVa/2f0qj+3lzey02
 Y9QL1A4VKEeDPc9p9X7gY4JtzzkYBoJ9q/PUx34TPl7UDVh2MJtwUUOXIfVQCB8XHhBpi6
 LDIOwxotd9hpHe58y4gGRFQW7UHTTYo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-302-6U5WZtHiM72lQWJfgksZ8g-1; Mon, 03 Aug 2020 02:58:08 -0400
X-MC-Unique: 6U5WZtHiM72lQWJfgksZ8g-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B093C57;
 Mon,  3 Aug 2020 06:58:07 +0000 (UTC)
Received: from thuth.com (ovpn-112-113.ams2.redhat.com [10.36.112.113])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4685F712EB;
 Mon,  3 Aug 2020 06:58:06 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] tests/Makefile: test-image-locking needs CONFIG_POSIX
Date: Mon,  3 Aug 2020 08:58:03 +0200
Message-Id: <20200803065803.20836-1-thuth@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Received-SPF: pass client-ip=205.139.110.61; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/03 02:56:11
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: qemu-trivial@nongnu.org, Fam Zheng <fam@euphon.net>, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

test-image-locking.c uses the qemu_lock_fd_test() function which is
only available on Posix-like systems.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/Makefile.include | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tests/Makefile.include b/tests/Makefile.include
index 5ff731be2b..430119db74 100644
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
2.18.1


