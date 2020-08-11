Return-Path: <SRS0=wQM/=BV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D490C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2020 15:18:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 43A96206C3
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2020 15:18:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Gg6TNV5E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43A96206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60746 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k5W2U-0007wD-BO
	for qemu-devel@archiver.kernel.org; Tue, 11 Aug 2020 11:18:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52622)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k5W1O-0006FR-3E
 for qemu-devel@nongnu.org; Tue, 11 Aug 2020 11:17:02 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:45960
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k5W1M-0000cL-I5
 for qemu-devel@nongnu.org; Tue, 11 Aug 2020 11:17:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597159019;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zhnHxfxiUERu1MREU1ntOMjckPxtITbDsV/Q25LHat4=;
 b=Gg6TNV5Eufknt1cq7yftFMqccxpi7Q4gR8xKmUTnkc2ZdB4Su6vPU0B2G69Ahp+V7USyil
 sqN6vfwjQiJkfzeG5aQOO1NXiB0Cto7uNpRgcNwHZpY4iaFl8X709m9GZG8ZP06xCbLr5m
 fLwoM8S+bvU6kZUbgxka1+tU/a5CTiQ=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-4-NapvUJwAPbizSakTT1k_vw-1; Tue, 11 Aug 2020 11:16:58 -0400
X-MC-Unique: NapvUJwAPbizSakTT1k_vw-1
Received: by mail-wm1-f70.google.com with SMTP id c186so1036957wmd.9
 for <qemu-devel@nongnu.org>; Tue, 11 Aug 2020 08:16:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=zhnHxfxiUERu1MREU1ntOMjckPxtITbDsV/Q25LHat4=;
 b=GbR8mafpjZu1Ato0q+68LrXNLYkRvnz7rjgFrs+CfQJ0Js/SvlIkV2qlepfsHMw8UC
 sVuKnsxGK35Nlg7NOGZSHkQ/zxJWVcK33Iz6NVK9m5DUi5iMnjTXUTgessXvP0FGVY7w
 fsMOG0ccxD2wxa/FpzCTABq7B6X0r591/yAifeSGuWjxIXeRBT8/b3Q2ZZBrdsAj2xnQ
 QCK3gzQ8rjCfL3zUKePWzQ8Tiu8JfPgdTStyaZeFQEd4uqkmxn6JnWvoidi06V7A8Wpe
 edPh9YwArUqtGpe/+RmBY6dIo9rXXdT591mMnDfpm9WMfhKzA/Tlt26yxK8pqHkJVX55
 T12A==
X-Gm-Message-State: AOAM533YIekDTtInLVTvFEw/3ODvJ5Iw1BMYQn7qVlRP7wQaovw2WloP
 AHjyJbdi22bJlPbMipGTxvv/MxQ2yINneOdqwBQOW78yOwLLRMg9SF6c79GZzPKOmHKDrkiv5/a
 YrQdftkHSSKnEha4=
X-Received: by 2002:adf:eb05:: with SMTP id s5mr32578586wrn.0.1597159015922;
 Tue, 11 Aug 2020 08:16:55 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzjU8A+PUDTZ7CGt0LIPryNFYYQYhT4QbWMdPawoZPb9jzJkjSE6ZMB1koKFRqW14G9TJSLFQ==
X-Received: by 2002:adf:eb05:: with SMTP id s5mr32578577wrn.0.1597159015765;
 Tue, 11 Aug 2020 08:16:55 -0700 (PDT)
Received: from localhost.localdomain (121.red-81-40-121.staticip.rima-tde.net.
 [81.40.121.121])
 by smtp.gmail.com with ESMTPSA id s8sm5542671wmc.1.2020.08.11.08.16.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Aug 2020 08:16:55 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH-for-5.2 2/3] util/qemu-timer: Fix typo in description
Date: Tue, 11 Aug 2020 17:16:42 +0200
Message-Id: <20200811151643.21293-3-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200811151643.21293-1-philmd@redhat.com>
References: <20200811151643.21293-1-philmd@redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/11 06:40:20
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
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
Cc: Corey Minyard <cminyard@mvista.com>, qemu-trivial@nongnu.org,
 Michael Tokarev <mjt@tls.msk.ru>, Laurent Vivier <laurent@vivier.eu>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Remove the second 'and' introduced in commit e81f86790f ("qemu-timer:
avoid checkpoints for virtual clock timers in external subsystems").

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 util/qemu-timer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/util/qemu-timer.c b/util/qemu-timer.c
index f62b4feecd..878d80fd5e 100644
--- a/util/qemu-timer.c
+++ b/util/qemu-timer.c
@@ -530,7 +530,7 @@ bool timerlist_run_timers(QEMUTimerList *timer_list)
     }
 
     /*
-     * Extract expired timers from active timers list and and process them.
+     * Extract expired timers from active timers list and process them.
      *
      * In rr mode we need "filtered" checkpointing for virtual clock.  The
      * checkpoint must be recorded/replayed before processing any non-EXTERNAL timer,
-- 
2.21.3


