Return-Path: <SRS0=N3Ri=EI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99772C388F2
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2020 14:46:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E37322453
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2020 14:46:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G6lBXEbc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E37322453
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34838 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZb6j-0007V9-8F
	for qemu-devel@archiver.kernel.org; Mon, 02 Nov 2020 09:46:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42654)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kZb36-00027m-2o
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 09:43:09 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:43131)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kZb33-00059Z-NN
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 09:43:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604328183;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=j3HaWimA2sQhV0m5yDO0w67enm5B0faDw85mk9Xsiio=;
 b=G6lBXEbcTxcy38IKL4wZpYPKNL0bpA5crNLeK2ey5LgE/KJ/CAEVZLVQB6e1dqUkdwaLzt
 xFQilriODF9Ga6uZZgrl3zd9x+jP7kLgXl7Ex79XFka3iZF3qLcJjg1yeYDr+54qfauV8m
 RsmP95Ld45+fYW63yQyiCEjb0/fir54=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-184-zYAJKrWUPA-CnM_xmEbOSw-1; Mon, 02 Nov 2020 09:43:02 -0500
X-MC-Unique: zYAJKrWUPA-CnM_xmEbOSw-1
Received: by mail-wm1-f69.google.com with SMTP id z7so3414092wme.8
 for <qemu-devel@nongnu.org>; Mon, 02 Nov 2020 06:43:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=j3HaWimA2sQhV0m5yDO0w67enm5B0faDw85mk9Xsiio=;
 b=dm94oege8vn1Qrid0zA4yONaCtCE9NPHWaWTlvbCHwls4TtfNko+iIQnrSGp8TXiEP
 rv97ObsL4zfL8O2ms0gV2RpPMetE+lZvcTAZpeDZnB/3uZzZHXp4eyWd0ARLhgXh1Pkp
 Yp+dq4po4xq8RlRcQxZJ3HTAR48ZYxEA2zibZ0VJTrDKST+Agz5knlWyQOtfZfQdoKXP
 mOxz8F4un+IOm6tbnX21vgs0vjUay3f8vxuCHXANzHzxMdxCwl1sYBXFmdbl60tIHxk7
 v0jbiFdFsY6fA3ih4s9u5WDgQ0S23glssFPuuNUHDJZ0LKGMcWShavVmBRcCdfNqTxdj
 5dhQ==
X-Gm-Message-State: AOAM530mUwRgXqnR1+wwmltPghXtyOmTZtlJ+RJWSnleS35ymtI1hX6R
 aL8YmRQkZUtALGBgkKrJeXE5f73WsQrHwQ5VX2tB6WBz73nx4iIoxVQO/Tl0dxC7KK34VB38p+1
 FhmmEhDeJvuvKJ1I=
X-Received: by 2002:adf:a303:: with SMTP id c3mr20547925wrb.417.1604328180671; 
 Mon, 02 Nov 2020 06:43:00 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzKqSrSnCfKuauKcpuql6Y2lxNqP4TC9X/JlJSZuojLMeDbMpjmMXhALtoOf8Y76G/uZTVX5Q==
X-Received: by 2002:adf:a303:: with SMTP id c3mr20547894wrb.417.1604328180546; 
 Mon, 02 Nov 2020 06:43:00 -0800 (PST)
Received: from localhost.localdomain (234.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.234])
 by smtp.gmail.com with ESMTPSA id o186sm16176699wmb.12.2020.11.02.06.42.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2020 06:42:59 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: "Daniel P . Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Cleber Rosa <crosa@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>
Subject: [PATCH-for-5.2? 2/5] tests/acceptance: Restore MIPS Malta multicore
 tests
Date: Mon,  2 Nov 2020 15:42:42 +0100
Message-Id: <20201102144245.2134077-3-philmd@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201102144245.2134077-1-philmd@redhat.com>
References: <20201102144245.2134077-1-philmd@redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/02 03:02:24
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Sarah Harris <S.E.Harris@kent.ac.uk>, Michael Rolnik <mrolnik@gmail.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Fabien Chouteau <chouteau@adacore.com>, Aurelien Jarno <aurelien@aurel32.net>,
 KONRAD Frederic <frederic.konrad@adacore.com>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 qemu-ppc@nongnu.org, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 Antony Pavlov <antonynpavlov@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Since 42a052333a6 ("hw/misc/mips_cpc: Start vCPU when powered on")
the multicore support of the MIPS Malta board has been fixed.

This reverts commit 61bbce96fe4c8e3a2b7df5a67ba7dc6ba418e54b.

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 tests/acceptance/machine_mips_malta.py | 2 --
 1 file changed, 2 deletions(-)

diff --git a/tests/acceptance/machine_mips_malta.py b/tests/acceptance/machine_mips_malta.py
index 7c9a4ee4d2d..eea046141d6 100644
--- a/tests/acceptance/machine_mips_malta.py
+++ b/tests/acceptance/machine_mips_malta.py
@@ -100,7 +100,6 @@ def test_mips_malta_i6400_framebuffer_logo_1core(self):
         """
         self.do_test_i6400_framebuffer_logo(1)
 
-    @skipIf(os.getenv('GITLAB_CI'), 'Running on GitLab')
     def test_mips_malta_i6400_framebuffer_logo_7cores(self):
         """
         :avocado: tags=arch:mips64el
@@ -110,7 +109,6 @@ def test_mips_malta_i6400_framebuffer_logo_7cores(self):
         """
         self.do_test_i6400_framebuffer_logo(7)
 
-    @skipIf(os.getenv('GITLAB_CI'), 'Running on GitLab')
     def test_mips_malta_i6400_framebuffer_logo_8cores(self):
         """
         :avocado: tags=arch:mips64el
-- 
2.26.2


