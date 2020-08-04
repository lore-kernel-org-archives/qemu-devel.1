Return-Path: <SRS0=UEgn=BO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38321C433E0
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Aug 2020 18:23:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0E4832086A
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Aug 2020 18:23:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ECkcf6qM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E4832086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36906 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k31bK-0000Tu-A2
	for qemu-devel@archiver.kernel.org; Tue, 04 Aug 2020 14:23:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54362)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k31aN-0008PI-0u
 for qemu-devel@nongnu.org; Tue, 04 Aug 2020 14:22:51 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:27604
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k31aL-0007jV-5U
 for qemu-devel@nongnu.org; Tue, 04 Aug 2020 14:22:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596565368;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=T8wFlT/r613OvCn8ZO6ZMTm/LtsBmhVYbt34XymoCgQ=;
 b=ECkcf6qMz+z/Btf3uq0od1zMm62Xrba2z7Ysnrrhgf34fbcdNZA3BA58ynrsWCscyON9Oh
 KBjAzrFLrDqdjHfKBgAiYaOX/H2T/06/Zp270hWx1+5BFSO0WJPi9mbPgU8MRGz+eqC6vv
 Sn/weI8StK7OPgF4eFqozoKW21dbsxo=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-462-F6qbsYg_PnqzoyFpX1spOg-1; Tue, 04 Aug 2020 14:22:46 -0400
X-MC-Unique: F6qbsYg_PnqzoyFpX1spOg-1
Received: by mail-ej1-f69.google.com with SMTP id i4so931516ejk.9
 for <qemu-devel@nongnu.org>; Tue, 04 Aug 2020 11:22:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=T8wFlT/r613OvCn8ZO6ZMTm/LtsBmhVYbt34XymoCgQ=;
 b=dEPIE4FywLagqasyrtlYw8oNK+9vmzeKcCeMh4nH/TBVs3L9POXLEdicFdCnP8K4Xc
 gjUGoaItbsQQGZFnwXo7pg3CwgIoZWEBTpcMrb9NRoTvxwN7LOE6r6DAL8T+RitEIzWs
 hLA281Sy+gg4Zx07E79J8jgOIBheNEvB/gyt9mKHW4qJQ0D0aHYu9s27MU8vHI3A1PHd
 Ck3X7ltDd7qqwx5HdiyTqCQAkR+fFLx+s+uyY/AgNfVSo4ufzU2WazFU23D49ow0Eaeo
 UhNXM6t/bT0/gQJDdONjBGyyBKuz1i7hEeLKiukdkEp30fjrvaEXuhoKdXirOSOr08Ah
 WIbg==
X-Gm-Message-State: AOAM530BeKrxCGaORd3UeWX28RuIy2edl2CkHsz0JtzNJOOloHqQpv0T
 PCKZtTXetbwmKgeakZvS5+eaB7K61rb7zBJLTA8CkwQZeD1GB2rgGKkBn3hTSul3+Pjyu3CSlhS
 iqe9EpJ6Qns1KmtQ=
X-Received: by 2002:a17:906:eceb:: with SMTP id
 qt11mr22104505ejb.519.1596565365052; 
 Tue, 04 Aug 2020 11:22:45 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxmuPhIgsim8bBJPIbt4uhkTGbYYnJmMx2G/KiYMUldPEkTQQ+iHi8x6Ni2bOQvP0lE0ER0vg==
X-Received: by 2002:a17:906:eceb:: with SMTP id
 qt11mr22104493ejb.519.1596565364877; 
 Tue, 04 Aug 2020 11:22:44 -0700 (PDT)
Received: from x1w.redhat.com (214.red-88-21-68.staticip.rima-tde.net.
 [88.21.68.214])
 by smtp.gmail.com with ESMTPSA id gh25sm18895201ejb.109.2020.08.04.11.22.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Aug 2020 11:22:44 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH-for-5.1] stubs: Fix notify-event stub linkage error on MinGW
Date: Tue,  4 Aug 2020 20:22:41 +0200
Message-Id: <20200804182241.31805-1-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/04 01:28:16
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

In commit e4d6d41ce2 we reduced the user-mode object list,
but forgot to also change the notify.o stub in the next commit
dc70f80fb2. This triggers a linker error while compiling the
tests under MinGW:

  LINK    tests/test-timed-average.exe
 libqemuutil.a(main-loop.o): In function `qemu_notify_event':
 util/main-loop.c:139: multiple definition of `qemu_notify_event'
 tests/test-timed-average.o:/builds/huth/qemu/tests/../stubs/notify-event.c:5: first defined here
 collect2: error: ld returned 1 exit status
 rules.mak:124: recipe for target 'tests/test-timed-average.exe' failed

Correct by placing the stub object between the system emulation /
tools guards.

Fixes: dc70f80fb2 ("stubs/Makefile: Reduce the user-mode object list")
Reported-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 stubs/Makefile.objs | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/stubs/Makefile.objs b/stubs/Makefile.objs
index d42046afe4..4e8605a609 100644
--- a/stubs/Makefile.objs
+++ b/stubs/Makefile.objs
@@ -12,7 +12,6 @@ stub-obj-y += isa-bus.o
 stub-obj-$(CONFIG_LINUX_AIO) += linux-aio.o
 stub-obj-$(CONFIG_LINUX_IO_URING) += io_uring.o
 stub-obj-y += monitor-core.o
-stub-obj-y += notify-event.o
 stub-obj-y += pci-bus.o
 stub-obj-y += qmp_memory_device.o
 stub-obj-y += qtest.o
@@ -45,6 +44,7 @@ stub-obj-y += iothread.o
 stub-obj-y += machine-init-done.o
 stub-obj-y += migr-blocker.o
 stub-obj-y += monitor.o
+stub-obj-y += notify-event.o
 stub-obj-y += pci-host-piix.o
 stub-obj-y += ram-block.o
 stub-obj-y += replay-user.o
-- 
2.21.3


