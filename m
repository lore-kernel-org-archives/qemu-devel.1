Return-Path: <SRS0=FSHi=DM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5701C4363A
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2020 15:10:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F4912078A
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2020 15:10:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PJs19vdp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F4912078A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47554 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPS7n-0003Iz-Vo
	for qemu-devel@archiver.kernel.org; Mon, 05 Oct 2020 11:10:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44390)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kPS6k-0001tX-9W
 for qemu-devel@nongnu.org; Mon, 05 Oct 2020 11:08:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:40118)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kPS6i-00029m-T1
 for qemu-devel@nongnu.org; Mon, 05 Oct 2020 11:08:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601910535;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aWd71ogHtYewaamIi/tkfKcZc1RnBugAKZi98CKq8rQ=;
 b=PJs19vdpPJwDbjulMTm4qkGHaoBsPcZqv3zYytno9R+jhFb2EWGKm9U7ZXXjc5dUzaYtFQ
 gPoD73hgipqrxEi6AXqZZUB+D9M6OuVFEotlKMGCFuYeC3Z3WzlP0MB7LfuJ3Y3t9lShJS
 4Z+HrKEy21SuJg5+xrnITG7p1H/8SDI=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-149-8kbNCXKWOtGM9nKq5REqgg-1; Mon, 05 Oct 2020 11:08:54 -0400
X-MC-Unique: 8kbNCXKWOtGM9nKq5REqgg-1
Received: by mail-wm1-f70.google.com with SMTP id u82so2562711wmu.4
 for <qemu-devel@nongnu.org>; Mon, 05 Oct 2020 08:08:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=aWd71ogHtYewaamIi/tkfKcZc1RnBugAKZi98CKq8rQ=;
 b=XqUvsytQ2yki2Y+Zf31kRp+U//7j02hQ0oSIs0Kz6MYWoiSEIlaOVfpte/1ZnHxlkj
 l237uJPI5/99iixI0PSvtsD+WByF9Y11lg+CtVTN52ymwxXj84HfbtBmTna/4/HoahvC
 38kvvKkNbuoXKJZ/oY0Z2f0oQeUziWfIE5ghemm+jL4gOqB1ew0uCptZglBgP1Bmefeb
 FF0KWqIHl3O5KWvWAa8vy2W8xVbBfHEwnl6UzUvMH9qmN6vQ0ugajLVrH3oXCSpjuV0/
 EhQoVw0Iv3puqark8TNaPjbSU4x77ptNrVi3suAGFtdxaIqi2y5yiD5sav4EET26ga/R
 WOWw==
X-Gm-Message-State: AOAM531uz/5Z0ltFMue0fOiSlHZW0Dg7n6Xwaj+H4Y+y0nFtMuT6L0LR
 6ptFUqZvKjqvi6UKhkWnXiFTsvA0tIOqKav4L90P+7MPSUImpiEAUMMLZXGVHdha400LaXMKY3I
 9GTt1l9L+XqSSMBc=
X-Received: by 2002:a7b:cf30:: with SMTP id m16mr97440wmg.0.1601910532735;
 Mon, 05 Oct 2020 08:08:52 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwa67i5tTRJVR9kDCdSOpQ8YgFiRpySTCz29au7+qn2HXEMHW8w6ziZ0UCZ0o3JbYzHetkJzQ==
X-Received: by 2002:a7b:cf30:: with SMTP id m16mr97415wmg.0.1601910532531;
 Mon, 05 Oct 2020 08:08:52 -0700 (PDT)
Received: from x1w.redhat.com (106.red-83-59-162.dynamicip.rima-tde.net.
 [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id s6sm271609wrg.92.2020.10.05.08.08.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Oct 2020 08:08:51 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH 1/4] Kconfig.host: Declare FDT symbol
Date: Mon,  5 Oct 2020 17:08:42 +0200
Message-Id: <20201005150845.2124381-2-philmd@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201005150845.2124381-1-philmd@redhat.com>
References: <20201005150845.2124381-1-philmd@redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/05 02:11:31
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.733,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>, qemu-ppc@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Declare FDT symbol in the root Kconfig as it is
- dependent of libfdt
- used by various targets

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 Kconfig.host | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Kconfig.host b/Kconfig.host
index a9a55a9c31..c07a27220f 100644
--- a/Kconfig.host
+++ b/Kconfig.host
@@ -37,3 +37,7 @@ config VIRTFS
 
 config PVRDMA
     bool
+
+config FDT
+    bool
+    #depends on LIBFDT
-- 
2.26.2


