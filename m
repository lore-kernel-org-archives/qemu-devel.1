Return-Path: <SRS0=JiPe=DG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F105CC4727C
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 22:45:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E16020756
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 22:45:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P2gRsD4z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E16020756
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33174 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNONL-0006nt-5Z
	for qemu-devel@archiver.kernel.org; Tue, 29 Sep 2020 18:45:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60702)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kNOLx-0004yq-Rx
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 18:44:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:20740)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kNOLv-0004Z0-Be
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 18:44:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601419446;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=66DSIrlhCeV+xyo2otn2L+hQAxSXyWg/ic5Sp/vZwto=;
 b=P2gRsD4zgeBbihXz4fdnsT263Af1b1iWdxljRPd2Imco4dBS/Q97k+XbZjEvctfXCOp+BI
 ErFSt0zN/xtYeIgiPkbAYakV7L5o9vvFA30drPAr221/duEBx6LopbDz5XMS2XUD2eX6Wi
 mSw05E4yybQ1YlC4YHpdYERyC9wgkes=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-42-ABZxz2n9PNSPWjI_cnOcRg-1; Tue, 29 Sep 2020 18:44:04 -0400
X-MC-Unique: ABZxz2n9PNSPWjI_cnOcRg-1
Received: by mail-wr1-f70.google.com with SMTP id w7so2370078wrp.2
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2020 15:44:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=66DSIrlhCeV+xyo2otn2L+hQAxSXyWg/ic5Sp/vZwto=;
 b=s9sB1aYHwhYRY+j7rq9jcsl3nz3nu1INSV8smQRYzDHkgoC57KAi/Kr72b0Szxz0mf
 thQDoIoo+0KQJNI13O5C3F9g4hP5dqxQLrK/KKI5n8AUv/3sz0SkfHKopLY9dC0bunHe
 e2z/89vWONnNe82L80lBC3xj7qOR95aByPOz3tclibW5OOxjpAGzUToykDGOsFLPbC70
 xwFBAt6LuffnJ68nxAv3nqhpYfK12KXvHnos1Zhi9UidmZzP+xNTfFSgqp9faz4nBPoQ
 UWlHpK1ZQkJkZZsXQTtWUAjeR5Idr/beAf78Va73t7eIpKUPWRof2/mh6Tl1erRZwsLs
 /9gQ==
X-Gm-Message-State: AOAM531W8g2/YzMlQ0AKwQpnS+ZekHBiMNZMSC3iks3GtIt44WK9is2T
 eMURvM+4JRhxV73DJJm2LPUti/J2nKLS8zcpoPExgvqpq+0h97QCh774DM0OfOIXCK9KhcVKogr
 oDdIdGnRrCZlML38=
X-Received: by 2002:adf:efc9:: with SMTP id i9mr6933044wrp.187.1601419443279; 
 Tue, 29 Sep 2020 15:44:03 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw/JFirmQq0FLOkZYRppQAwyrCFiFhW/sOaJqe1ygyRV//BqkXnJHjtm0eIPBJooqWr+G3TNQ==
X-Received: by 2002:adf:efc9:: with SMTP id i9mr6933012wrp.187.1601419442929; 
 Tue, 29 Sep 2020 15:44:02 -0700 (PDT)
Received: from x1w.redhat.com (74.red-83-53-161.dynamicip.rima-tde.net.
 [83.53.161.74])
 by smtp.gmail.com with ESMTPSA id t202sm7798963wmt.14.2020.09.29.15.44.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2020 15:44:02 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 01/12] accel/tcg: Add stub for cpu_loop_exit()
Date: Wed, 30 Sep 2020 00:43:44 +0200
Message-Id: <20200929224355.1224017-2-philmd@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200929224355.1224017-1-philmd@redhat.com>
References: <20200929224355.1224017-1-philmd@redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/28 22:47:55
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.687,
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
Cc: Fam Zheng <fam@euphon.net>, Peter Maydell <peter.maydell@linaro.org>,
 Thomas Huth <thuth@redhat.com>, kvm@vger.kernel.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Keith Packard <keithp@keithp.com>, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Since the support of SYS_READC in commit 8de702cb67 the
semihosting code is strongly depedent of the TCG accelerator
via a call to cpu_loop_exit().

Ideally we would only build semihosting support when TCG
is available, but unfortunately this is not trivial because
semihosting is used by many targets in different configurations.
For now add a simple stub to avoid link failure when building
with --disable-tcg:

  hw/semihosting/console.c:160: undefined reference to `cpu_loop_exit'

Cc: Keith Packard <keithp@keithp.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 accel/stubs/tcg-stub.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/accel/stubs/tcg-stub.c b/accel/stubs/tcg-stub.c
index e4bbf997aa..1eec7fb90e 100644
--- a/accel/stubs/tcg-stub.c
+++ b/accel/stubs/tcg-stub.c
@@ -29,3 +29,8 @@ void *probe_access(CPUArchState *env, target_ulong addr, int size,
      /* Handled by hardware accelerator. */
      g_assert_not_reached();
 }
+
+void cpu_loop_exit(CPUState *cpu)
+{
+    g_assert_not_reached();
+}
-- 
2.26.2


