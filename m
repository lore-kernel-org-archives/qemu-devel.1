Return-Path: <SRS0=ff1W=CL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89F6DC433E6
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 08:09:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 549FD2084C
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 08:09:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RbyLJH4R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 549FD2084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39986 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDNpV-0007Jk-A0
	for qemu-devel@archiver.kernel.org; Wed, 02 Sep 2020 04:09:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41586)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kDNoV-0005LE-SJ
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 04:08:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:43775)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kDNoT-0001hr-J5
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 04:08:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599034092;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IPF1JmHQsw2mw4z7BQY/4JOe6Rk75NCWTSoQBVL6aXM=;
 b=RbyLJH4RXi2VcDu7JSpuqS7RIOtiyaEfdh4Prv6Bpfix9yaaAt8d6/vmZQuNJUwU9rSnvm
 K6HNGgvDrlK4vm1IoeZhUBJQfI+VXYpNhB1RWrPdQnjoaBOMqc3/B8xQUJnoqN3xcvjxWL
 OGd6549vCft1y6HFBdKGy4bAoZ5Ih+Y=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-276-8gA_yGWpPbaWwBafFIZSJA-1; Wed, 02 Sep 2020 04:08:10 -0400
X-MC-Unique: 8gA_yGWpPbaWwBafFIZSJA-1
Received: by mail-wr1-f69.google.com with SMTP id 3so1652314wrm.4
 for <qemu-devel@nongnu.org>; Wed, 02 Sep 2020 01:08:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=IPF1JmHQsw2mw4z7BQY/4JOe6Rk75NCWTSoQBVL6aXM=;
 b=V3qTSpKdWLbKa3Jn+5LRR96EvPDdqOwaRznfSW2hAGL0gQCxQ1a5J7w7cyOWJY+ymI
 xwuDyvxDpaFRvMg+6gw/szDoMUGsJUnAy0/bu+AhtdLjUJT8gSYaC56W2LNWc22tKB0N
 rNsMa3V4YfLMyVXyqjfckn2Htm5rIVHtVepgdXE1ktLVL3M8xUvrzonHR9NxoOsv55I2
 YhiZXPrqcoqL/bVf28AUnvTG78tQ2pT91a/v2CUVfK6tZr5YbbuJ2RSF2nUE7ioERWyC
 8t4Is82KRmAdwRYouC5DZQHm3oBlbdIo3MIfdW/EQFbLPt1xDw1enHPLvWL7O9L2kNLZ
 tZMA==
X-Gm-Message-State: AOAM531UL7C0YT8b5rsEnZH73c5ctzFbEWV08ImsiTwJcMNj7IMJDMRM
 pmw12s0EPIyirKioiw7/t4i655w5aVnolPjYH7bPrAVHsojGHqvaoIMBPaaygZ2Z28Vp0a2CF0i
 G/9FOls0+zB947gM=
X-Received: by 2002:a1c:3c42:: with SMTP id j63mr5834688wma.53.1599034089485; 
 Wed, 02 Sep 2020 01:08:09 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxW0XYpgcnPnvy8YKh/9V5gsyJxMZdgNgUKfw5PiBuuQ1ZE0VXGs6olHM8kzbTBpoZq7XIpfw==
X-Received: by 2002:a1c:3c42:: with SMTP id j63mr5834649wma.53.1599034089270; 
 Wed, 02 Sep 2020 01:08:09 -0700 (PDT)
Received: from localhost.localdomain (50.red-83-52-54.dynamicip.rima-tde.net.
 [83.52.54.50])
 by smtp.gmail.com with ESMTPSA id q6sm5093038wmq.19.2020.09.02.01.08.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Sep 2020 01:08:08 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/5] tests/qtest/ipmi-kcs: Fix assert side-effect
Date: Wed,  2 Sep 2020 10:07:57 +0200
Message-Id: <20200902080801.160652-2-philmd@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200902080801.160652-1-philmd@redhat.com>
References: <20200902080801.160652-1-philmd@redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/02 02:42:29
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Corey Minyard <minyard@acm.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 qemu-trivial@nongnu.org, qemu-ppc@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Fix assert side-effect reported by Coverity:

  /qemu/tests/qtest/ipmi-kcs-test.c: 84 in kcs_wait_obf()
  83         while (IPMI_KCS_CMDREG_GET_OBF() == 0) {
  >>>     CID 1432368:  Incorrect expression  (ASSERT_SIDE_EFFECT)
  >>>     Argument "--count" of g_assert() has a side effect.  The containing function might work differently in a non-debug build.
  84             g_assert(--count != 0);

Reported-by: Coverity (CID 1432368)
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 tests/qtest/ipmi-kcs-test.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tests/qtest/ipmi-kcs-test.c b/tests/qtest/ipmi-kcs-test.c
index 693a6aacb52..fc0a918c8d1 100644
--- a/tests/qtest/ipmi-kcs-test.c
+++ b/tests/qtest/ipmi-kcs-test.c
@@ -81,7 +81,8 @@ static void kcs_wait_obf(void)
 {
     unsigned int count = 1000;
     while (IPMI_KCS_CMDREG_GET_OBF() == 0) {
-        g_assert(--count != 0);
+        --count;
+        g_assert(count != 0);
     }
 }
 
-- 
2.26.2


