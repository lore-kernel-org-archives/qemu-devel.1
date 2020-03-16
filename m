Return-Path: <SRS0=yzMV=5B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2469BC0044D
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 19:18:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DFE7820674
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 19:18:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dswHuwkp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DFE7820674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47390 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDvFT-0005T7-17
	for qemu-devel@archiver.kernel.org; Mon, 16 Mar 2020 15:18:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37131)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jDuod-0006jx-BS
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 14:50:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jDuoc-0005Ld-97
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 14:50:19 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:38826)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jDuoc-0005JT-3z
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 14:50:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584384617;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ToHM1bRcSu3o42IHguqQBrZI8fvHPvcqixZhQVzTz6E=;
 b=dswHuwkp/soGaKzAvCFQs0qfpLSSrFvINcLEV2QgeIePdCV79VzUzSJdFZJEFGPVpwirdP
 bm0nf2FCv7iqPPfD08swIiY0k6qfE895vQ2vzj+AMpXZxpkp+fVHW66fP0a+/xyG+JynR2
 Uy0Mt1fNRhl3CoPlegEZZq5LAyl4+ac=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-11-1eibFGHpPlGov-kvsdwdCw-1; Mon, 16 Mar 2020 14:50:15 -0400
X-MC-Unique: 1eibFGHpPlGov-kvsdwdCw-1
Received: by mail-wr1-f72.google.com with SMTP id v7so8264wrp.0
 for <qemu-devel@nongnu.org>; Mon, 16 Mar 2020 11:50:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=dnVDi3pCdMDNavjfPIsCqusO2Yp3WpdN6v4oPIcWzd4=;
 b=ZVl5RtbGMoUKrD+ozn0yHPDhRr0MPpV3T/BIejJpUnHleevWvnKmeg041po4I0ZA+2
 2/riSQu+Q2is7qneVKjzLe2hFH+8RmH2Wl+YwNmgeIqVIxtS9u1ZNyIq7kzeIsVSTcV3
 /evKjjhLh1CtcxRIbeMxX0xhC9ONDqHOERRqLf8TvW0rwpONcbDsvevD0TgTutGiuIvK
 qpt1260rn/2nhV929Vv/of+XXrNp0TEO1J0INwc9wg9ga9OI15hywqd5O7wHxypgkUPs
 vYJa/Bs0uVJzKcAj+HGsFqmP38cMBPT/2oHimXMWkMG6EpKSZ6KwcjxZoymc05RmBRXK
 OvLA==
X-Gm-Message-State: ANhLgQ29kCD16T+SFE88ghQLYV6w65Se8XQpK8MpOw4uCIXnDxhxIPhz
 M1tbx/zB94Ke/ZUbof7IsOqtPef9v2+JJm70iI73dqIIW2/wtMGc/X/ek9oA9ik3qDkgnFxofvV
 v+NqX+NnpJX4Sbm0=
X-Received: by 2002:a5d:694e:: with SMTP id r14mr761147wrw.312.1584384614279; 
 Mon, 16 Mar 2020 11:50:14 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vumt0/zyQegs7BCttH3meap4BjY3y8njKNdvv230mwaaJmL4cZHHdg7RC6AUxKvB+enCsS0Uw==
X-Received: by 2002:a5d:694e:: with SMTP id r14mr761126wrw.312.1584384614058; 
 Mon, 16 Mar 2020 11:50:14 -0700 (PDT)
Received: from localhost.localdomain (96.red-83-59-163.dynamicip.rima-tde.net.
 [83.59.163.96])
 by smtp.gmail.com with ESMTPSA id v10sm763990wmh.17.2020.03.16.11.50.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Mar 2020 11:50:13 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
	qemu-devel@nongnu.org
Subject: [PATCH v3 01/25] memory: Correctly return alias region type
Date: Mon, 16 Mar 2020 19:49:42 +0100
Message-Id: <20200316185006.576-2-philmd@redhat.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200316185006.576-1-philmd@redhat.com>
References: <20200316185006.576-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 216.205.24.74
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Since memory region aliases are neither rom nor ram, they are
described as i/o, which is often incorrect. Return instead the
type of the original region we are aliasing.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 memory.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/memory.c b/memory.c
index 09be40edd2..3ea0afada9 100644
--- a/memory.c
+++ b/memory.c
@@ -2830,6 +2830,9 @@ void address_space_destroy(AddressSpace *as)
=20
 static const char *memory_region_type(MemoryRegion *mr)
 {
+    if (mr->alias) {
+        return memory_region_type(mr->alias);
+    }
     if (memory_region_is_ram_device(mr)) {
         return "ramd";
     } else if (memory_region_is_romd(mr)) {
--=20
2.21.1


