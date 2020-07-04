Return-Path: <SRS0=gOAu=AP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD1DEC433DF
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Jul 2020 18:33:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AD99620720
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Jul 2020 18:33:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NHra7ET9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD99620720
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38994 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrmyQ-0007tt-TA
	for qemu-devel@archiver.kernel.org; Sat, 04 Jul 2020 14:33:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39470)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jrmuw-0002bQ-0I
 for qemu-devel@nongnu.org; Sat, 04 Jul 2020 14:29:38 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:25977
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jrmuu-0001IH-DP
 for qemu-devel@nongnu.org; Sat, 04 Jul 2020 14:29:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593887373;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AZqj3bTam91VJKMgXj5mJaby8iNVg3MqxY1e+jpggf8=;
 b=NHra7ET9G5+qx5yleOxYt/Qb15ad6AO4UgQNTozLH0663kwOHOVMbyk5wV/19fIy7ysF/T
 EOzFTOvHiFceyhvePkha9g0gMelpvb/ROUSPBsSEt50ji7xvwls1dR2WbScbrbWjOWww3P
 WMfxhX4hklKTzLB3lYyOUi/dD1ybDVc=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-457-Zlir96KaP_Ka9eOGpHsFjg-1; Sat, 04 Jul 2020 14:29:32 -0400
X-MC-Unique: Zlir96KaP_Ka9eOGpHsFjg-1
Received: by mail-wr1-f69.google.com with SMTP id e11so36458936wrs.2
 for <qemu-devel@nongnu.org>; Sat, 04 Jul 2020 11:29:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=AZqj3bTam91VJKMgXj5mJaby8iNVg3MqxY1e+jpggf8=;
 b=oU/3ui8nNztknGikUU8r0WGuusDt/OzPuAQp9FQqnIUGp4ntxyQU48HX8iFiV44i0+
 ByIqXi+ZZ21h62TaTSIYn/078G0tj09zWxR+mhnF40LvG9l+y2QewS6nMTShQWkAa8Hj
 WW+1aj8T5eEmweGXwq92M+sBzdoGr0dyBhT+6nr1hTWvusTQF1LPSBsz4QYwV8q6m9Mm
 dk1ZD49dvXi9ap26h7txLqc1MDTdwzl1ZqT3rs3jU+mVhO0QdU9tQT61W1O0JDdunSaO
 0cGEYnbq/L9nmlMR2r/3ZjaDaKJs0le2eGtafNGqJaLdpA0wVPCOTB5nEaIeFCfjsEae
 rgpQ==
X-Gm-Message-State: AOAM530pNuBYfRc6tTKJuxPaOulD7Ns3hQF4zmnZ9lThmuuOAjEFZvUN
 VD8x9e49xzQfW9b0jCBlDVeEQG0YYJ0nShDQKw3NBVwfWF4NXQE1yZHc8IXX8zvc1cobCId+X2+
 xq1/VQeo3EbZQQVs=
X-Received: by 2002:a7b:c403:: with SMTP id k3mr37895742wmi.35.1593887370310; 
 Sat, 04 Jul 2020 11:29:30 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyy1KiF1TbW4Vvp2AgUuk6Td4M2xK/Cf2znN9w9drf2fO/hzzSs8kXo/tFL0CgvJqycCmPvPQ==
X-Received: by 2002:a7b:c403:: with SMTP id k3mr37895729wmi.35.1593887370142; 
 Sat, 04 Jul 2020 11:29:30 -0700 (PDT)
Received: from redhat.com (bzq-79-182-31-92.red.bezeqint.net. [79.182.31.92])
 by smtp.gmail.com with ESMTPSA id
 j15sm8656956wrx.69.2020.07.04.11.29.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 04 Jul 2020 11:29:29 -0700 (PDT)
Date: Sat, 4 Jul 2020 14:29:27 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v2 02/41] Revert "tests/migration: Reduce autoconverge initial
 bandwidth"
Message-ID: <20200704182750.1088103-3-mst@redhat.com>
References: <20200704182750.1088103-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200704182750.1088103-1-mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/04 08:57:02
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Laurent Vivier <lvivier@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Juan Quintela <quintela@redhat.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This reverts commit 6d1da867e65f ("tests/migration: Reduce autoconverge initial bandwidth")
since that change makes unit tests much slower for all developers, while it's not
a robust way to fix migration tests. Migration tests need to find
a more robust way to discover a reasonable bandwidth without slowing
things down for everyone.

Fixes: 6d1da867e65f ("tests/migration: Reduce autoconverge initial bandwidth")
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Acked-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Acked-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Acked-by: Thomas Huth <thuth@redhat.com>
---
 tests/qtest/migration-test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
index dc3490c9fa..21ea5ba1d2 100644
--- a/tests/qtest/migration-test.c
+++ b/tests/qtest/migration-test.c
@@ -1211,7 +1211,7 @@ static void test_migrate_auto_converge(void)
      * without throttling.
      */
     migrate_set_parameter_int(from, "downtime-limit", 1);
-    migrate_set_parameter_int(from, "max-bandwidth", 1000000); /* ~1Mb/s */
+    migrate_set_parameter_int(from, "max-bandwidth", 100000000); /* ~100Mb/s */
 
     /* To check remaining size after precopy */
     migrate_set_capability(from, "pause-before-switchover", true);
-- 
MST


