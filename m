Return-Path: <SRS0=ZyMj=EB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3EF0C4363A
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 19:12:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 097C8207C3
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 19:12:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FQNJMFIR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 097C8207C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34426 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kX7uc-0006KP-1O
	for qemu-devel@archiver.kernel.org; Mon, 26 Oct 2020 15:12:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52350)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kX7qV-0002Qm-Rh
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 15:07:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:40442)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kX7qQ-0006qR-Bn
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 15:07:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603739269;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jbGe26nA5DAVeoeVhr1ezg+4GNEk52SyIQCQUZatzHg=;
 b=FQNJMFIR+bOcFSrOBPqzYNdGnJjFqBAEt6RwJAZEmwQycPYkyDomzy8Y1H2B5lbYYRQUVp
 00s5Z+omvesy2vu3oxJvZ3roBJHjT12Rb5AZKE6cREnL0vEQfjnosB35SaSXiUVYAIM6Zh
 pJwrHCYonu8Z7t7rK4mksdqJ59URsQ8=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-468-arphqcc0M6G70WzxVvvaAA-1; Mon, 26 Oct 2020 15:07:45 -0400
X-MC-Unique: arphqcc0M6G70WzxVvvaAA-1
Received: by mail-ej1-f72.google.com with SMTP id x12so5823503eju.22
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2020 12:07:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=jbGe26nA5DAVeoeVhr1ezg+4GNEk52SyIQCQUZatzHg=;
 b=i01EVMsQ91hmqRrEJopZyOqrj8AhcjWcxq3gOz/rVFMqBi5xU0VgnzOPLOX1TWCSb/
 O55d7aUgYPD+2lUvWEVxxGCyvM98RFZxe8VM11nrgp0awG1hYqaNDhyOeglSNwHPtPQW
 hG1Yc32JHBMwPEGwLfGohxHiZhtMX0ue9QW7RObCOpxplnWs6bLpj+D1jwroqO8dhjri
 1gwZn2KaXAEUAcjd7gMS5Ygmw85GxbbTD0qr0gG8MAQ5yXvDQ/goPJtd2354CycnKJ6G
 XoB/6AWhNxKeztGJxWWt3PRIKQr2PS0QuPqKEKxZMkkagBYmYA6GBBE8RrwPS/g7lAc8
 G5Tg==
X-Gm-Message-State: AOAM531pKPouVo1qVCKQNn+dDvcWyTvKp+sKI0m75IkTEvQ8hCQi1GwC
 vUuwfSWv0VTaHmNblXvrha3fykl/tok3EcQeoM5QW3tLTL1+h4KTKtO5uRCLrI123xMie5XzBfv
 w104tvHUhXheo85g=
X-Received: by 2002:a17:906:a38d:: with SMTP id
 k13mr17088754ejz.524.1603739264115; 
 Mon, 26 Oct 2020 12:07:44 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwnuDvxB1/IqDcGfyOgGNu9L7M0MUUZye8VOxA3jCCZPHOMI+OTO9IbaofYvZ8TJE52k0R4Tg==
X-Received: by 2002:a17:906:a38d:: with SMTP id
 k13mr17088733ejz.524.1603739263930; 
 Mon, 26 Oct 2020 12:07:43 -0700 (PDT)
Received: from x1w.redhat.com (237.red-88-18-140.staticip.rima-tde.net.
 [88.18.140.237])
 by smtp.gmail.com with ESMTPSA id 11sm6382536ejy.19.2020.10.26.12.07.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Oct 2020 12:07:43 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 3/4] tests/acceptance: Allow running Orange Pi test using
 cached artifacts
Date: Mon, 26 Oct 2020 20:07:25 +0100
Message-Id: <20201026190726.19515-4-philmd@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201026190726.19515-1-philmd@redhat.com>
References: <20201026190726.19515-1-philmd@redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/25 21:03:19
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: Bin Meng <bin.meng@windriver.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Niek Linnenbank <nieklinnenbank@gmail.com>, Cleber Rosa <crosa@redhat.com>,
 Bin Meng <bmeng.cn@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

Unfortunately the Armbian 19.11.3 image has been removed from the
dl.armbian.com file server. Developers having the artifact cached
can still run the test. Allow them to, until we find a proper
solution to share binaries with the whole community.

This avoids (when file manually added to cache):

  BootLinuxConsole.test_arm_orangepi_bionic_19_11: CANCEL: Missing asset https://dl.armbian.com/orangepipc/archive/Armbian_19.11.3_Orangepipc_bionic_current_5.3.9.7z (1.06 s)

Reported-by: Bin Meng <bmeng.cn@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Tested-by: Bin Meng <bin.meng@windriver.com>
Tested-by: Niek Linnenbank <nieklinnenbank@gmail.com>
Reviewed-by: Niek Linnenbank <nieklinnenbank@gmail.com>
Message-Id: <20201023131808.3198005-3-f4bug@amsat.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 tests/acceptance/boot_linux_console.py | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tests/acceptance/boot_linux_console.py b/tests/acceptance/boot_linux_console.py
index 415e32ef0d6..8f433a67f84 100644
--- a/tests/acceptance/boot_linux_console.py
+++ b/tests/acceptance/boot_linux_console.py
@@ -780,6 +780,8 @@ def test_arm_orangepi_sd(self):
         # Wait for VM to shut down gracefully
         self.vm.wait()
 
+    @skipUnless(os.getenv('ARMBIAN_ARTIFACTS_CACHED'),
+                'Test artifacts fetched from unreliable dl.armbian.com')
     @skipUnless(os.getenv('AVOCADO_ALLOW_LARGE_STORAGE'), 'storage limited')
     @skipUnless(P7ZIP_AVAILABLE, '7z not installed')
     def test_arm_orangepi_bionic(self):
-- 
2.26.2


