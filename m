Return-Path: <SRS0=QvPl=BU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC3DDC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2020 09:32:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A83012063A
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2020 09:32:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OXp9fSNl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A83012063A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46820 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k54A3-0001Rj-Sv
	for qemu-devel@archiver.kernel.org; Mon, 10 Aug 2020 05:32:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59954)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k549A-0000K8-8Q
 for qemu-devel@nongnu.org; Mon, 10 Aug 2020 05:31:12 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:57601
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k5497-0000zQ-F4
 for qemu-devel@nongnu.org; Mon, 10 Aug 2020 05:31:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597051868;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Y4qGEkANL4ybRRof06KC4oTuwK6+LCAyq8WC6bjPwjU=;
 b=OXp9fSNlXnod2F5fGyI9fITAocTpDfDKsIEfG3enhzjQKNXCDYmS+MD8XsWAVUs+B/kdZ8
 13a7//Tpyd8/OijHhlK/zMybXpkYWun86l0n6UgTHr/hoRReAFMmmbL71RJlD0zhdEFPdi
 AoBqZ7O2cq0mO5ZPX/wUoa3CpbklW5Q=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-35-clCY1knMO-q7DGFVDCpRog-1; Mon, 10 Aug 2020 05:31:04 -0400
X-MC-Unique: clCY1knMO-q7DGFVDCpRog-1
Received: by mail-wm1-f70.google.com with SMTP id s4so2559539wmh.1
 for <qemu-devel@nongnu.org>; Mon, 10 Aug 2020 02:31:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Y4qGEkANL4ybRRof06KC4oTuwK6+LCAyq8WC6bjPwjU=;
 b=kOC3tuj4bhCDlgiPsIuDzi0VA5vRgG88PcZATxfssgJ1+J3rErw6r3CzkzAF1QcnIB
 Z9zKXiDR6LiWsjE2NrJE812FifmUmEImEmKNmFiua4TR8wfyYrgV1MJHoYAb1Xq9v7+J
 bpZPKWFenKpsyIWdrQNZZIAUA3BVfEZpQGYl1xNEzzm90jcqRzYBImJvIZbNR7HuWa0+
 Wled+chTsxm4db9z5uJVB0tvBpmzzLBGjLYigkW6Hp3LPBCkXZGUsn8JIz9y2Ihc1Uoi
 GOM/Sl0S6wJ1qnJk9VfHpRgRR9GVq//+J7lfY5XYv9dzeXPt2Ap4bllOoPcGBNvP5gaL
 QcCg==
X-Gm-Message-State: AOAM532xftjfeyF+EgKHRRG9xgwuMAXnb7Ug8GJff1+xft8Or27dg5NK
 X5aZPrjkjPOrXyiiGnF0ROtnLghY4VuAXSSmC8Z1MTHQW89IwxYGFdgx6kq5ZqTCh154SXG14E5
 TFo/iMIdKf9npCzA=
X-Received: by 2002:a5d:610a:: with SMTP id v10mr23312502wrt.8.1597051862936; 
 Mon, 10 Aug 2020 02:31:02 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy/IzkPfSUoNKWDj642SwSby6Xr4kEMOfgiQ176KtF8wukxKv9sdvjVH0Q80vgbMB/KEDwB5Q==
X-Received: by 2002:a5d:610a:: with SMTP id v10mr23312488wrt.8.1597051862729; 
 Mon, 10 Aug 2020 02:31:02 -0700 (PDT)
Received: from localhost.localdomain (121.red-81-40-121.staticip.rima-tde.net.
 [81.40.121.121])
 by smtp.gmail.com with ESMTPSA id t14sm21659889wrg.38.2020.08.10.02.31.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Aug 2020 02:31:02 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
	qemu-devel@nongnu.org
Subject: [PATCH v2 2/2] tests/acceptance/boot_linux: Use stable URL for
 xlnx-versal test
Date: Mon, 10 Aug 2020 11:30:50 +0200
Message-Id: <20200810093050.28744-3-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200810093050.28744-1-philmd@redhat.com>
References: <20200810093050.28744-1-philmd@redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/10 03:31:01
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

In commit 27dfbafaa7 we added an acceptance test for the
xlnx-versal-virt machine but used an unstable URL (no guarantee
the files would be updated during the next release, which occured
last week on Wednesday, Aug 5). Fix by using the stable directory
name containing the release date.

Reported-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 tests/acceptance/boot_linux_console.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/acceptance/boot_linux_console.py b/tests/acceptance/boot_linux_console.py
index 2f22eddd0d..742dc30bc1 100644
--- a/tests/acceptance/boot_linux_console.py
+++ b/tests/acceptance/boot_linux_console.py
@@ -337,7 +337,7 @@ def test_aarch64_xlnx_versal_virt(self):
         """
         images_url = ('http://ports.ubuntu.com/ubuntu-ports/dists/'
                       'bionic-updates/main/installer-arm64/'
-                      'current/images/')
+                      '20101020ubuntu543.15/images/')
         kernel_url = images_url + 'netboot/ubuntu-installer/arm64/linux'
         kernel_hash = '5bfc54cf7ed8157d93f6e5b0241e727b6dc22c50'
         kernel_path = self.fetch_asset(kernel_url, asset_hash=kernel_hash)
-- 
2.21.3


