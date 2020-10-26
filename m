Return-Path: <SRS0=ZyMj=EB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0632C4363A
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 19:10:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E2A94207C3
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 19:10:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CuwOtXxt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2A94207C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59930 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kX7tQ-00057K-PR
	for qemu-devel@archiver.kernel.org; Mon, 26 Oct 2020 15:10:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52274)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kX7qH-0002C0-Cv
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 15:07:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:20753)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kX7qF-0006pn-GO
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 15:07:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603739258;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7CT9njDsFv7z3bPi4MElJcX4QFjJnLsmcrJhB+d6sQ0=;
 b=CuwOtXxt2mQ8bnmEwHMssSFf+plkE2snaMZQFJlBs5mdJRoO/7tqJG0d9HArWq4V0BPEYa
 rwtTv9RrmUNP+mTkxCrG5LV6jmk0dB4o1mLBO7MgR4DRmVcjcPaaz0mFymzDWvEAMvRGNa
 2AhB1J1UfjHt/S2p8anuPEHN3D13GTg=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-461-2d1KTYOzOqOggTCVgkQRbw-1; Mon, 26 Oct 2020 15:07:36 -0400
X-MC-Unique: 2d1KTYOzOqOggTCVgkQRbw-1
Received: by mail-ed1-f72.google.com with SMTP id a73so5205685edf.16
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2020 12:07:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=7CT9njDsFv7z3bPi4MElJcX4QFjJnLsmcrJhB+d6sQ0=;
 b=PNXJFnLZW0xIlYBwK0fbB62Y5q5NeKjd8CmRddSXo/RBtU3BgtA8Zto9OWaJT0ghll
 rLp5TJN+hbnRaEBkTM2e8cnHDGjilF2ji/se4G0qIB418jEdum3jtatgLA/urpbJBYhC
 /Erry9XpnFeitJxzkOHabKmS5wuj7LNGF1sqL2OmApwi1g1tbE49saFJ2kaeZcESLbd0
 kfvnr4HCpBwZmSRSFiPR47J3zyeWABT3i8/CdKL3PCJyDMdZjyAJIYFo5x/3NuiXYrDH
 bQ3iwnS7qtOlmZnpmozHYstf1t8fHsrNZom+6jLEybXNv4INVnHQoiXg+O2qsKsD/dIZ
 eSWw==
X-Gm-Message-State: AOAM533yB5jCuXnlZMLqNRegGf/dZvc/BWz3ufWnQGvpG8UOuPysp8X/
 9v7aaZ54/La/4rYKuzXY7K5+C+ngUS4rEHrRB0yAmg8S6U5r1J5WnSqyEFXsTJsF/mTW6uGhVg4
 E1xR2KnNUDi8JwHg=
X-Received: by 2002:a50:d65c:: with SMTP id c28mr11611681edj.279.1603739254656; 
 Mon, 26 Oct 2020 12:07:34 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw7691Eoc3/823C/lNN/zwZ14iS85WxeCapR/EGFlLe2tsDoA89BHLhJrbKVwjxgADbbVqu2Q==
X-Received: by 2002:a50:d65c:: with SMTP id c28mr11611597edj.279.1603739253712; 
 Mon, 26 Oct 2020 12:07:33 -0700 (PDT)
Received: from x1w.redhat.com (237.red-88-18-140.staticip.rima-tde.net.
 [88.18.140.237])
 by smtp.gmail.com with ESMTPSA id e2sm6361275ejd.81.2020.10.26.12.07.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Oct 2020 12:07:33 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 1/4] tests/boot_linux_console: Boot Trusted Firmware-A on the
 Raspberry Pi 3
Date: Mon, 26 Oct 2020 20:07:23 +0100
Message-Id: <20201026190726.19515-2-philmd@redhat.com>
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
Received-SPF: pass client-ip=216.205.24.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/26 02:39:09
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: Luc Michel <luc.michel@greensocs.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

This test runs Trusted Firmware-A on the Raspberry Pi 3.
We deliberately stop the boot process when the EDK2 UEFI version
is displayed.

The binary is build on AppVeyor CI using Pete Batard repository [1].
ATF v2.1 binary are used (see [2]).

It is very simple and fast:

  $ avocado --show=app,console run -t atf tests/acceptance
  JOB ID     : 1e748d7c9e9011cf0af3250ddc8ebf2389d6204e
  JOB LOG    : avocado/job-results/job-2020-02-16T18.08-1e748d7/job.log
   (1/1) tests/acceptance/boot_linux_console.py:BootLinuxConsole.test_aarch64_raspi3_atf:
  console: NOTICE:  Booting Trusted Firmware
  console: NOTICE:  BL1: v2.1(release):v2.1
  console: NOTICE:  BL1: Built : 15:26:06, May 13 2019
  console: NOTICE:  rpi3: Detected: Raspberry Pi 3 Model B (1GB, Sony, UK) [0x00a02082]
  console: NOTICE:  BL1: Booting BL2
  console: ERROR:   rpi3_sdhost: timeout status 0x40
  console: NOTICE:  BL2: v2.1(release):v2.1
  console: NOTICE:  BL2: Built : 15:26:01, May 13 2019
  console: NOTICE:  BL1: Booting BL31
  console: NOTICE:  BL31: v2.1(release):v2.1
  console: NOTICE:  BL31: Built : 15:26:04, May 13 2019
  console: =UEFI firmware (version UEFI Firmware v1.15 built at 11:58:44 on Feb 14 2020)
  PASS (1.54 s)
  RESULTS    : PASS 1 | ERROR 0 | FAIL 0 | SKIP 0 | WARN 0 | INTERRUPT 0 | CANCEL 0
  JOB TIME   : 1.88 s

[1] https://github.com/pbatard/RPi3#summary
[2] https://github.com/ARM-software/arm-trusted-firmware/blob/v2.1/docs/plat/rpi3.rst

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Luc Michel <luc.michel@greensocs.com>
Message-Id: <20200217103442.30318-1-f4bug@amsat.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 tests/acceptance/boot_linux_console.py | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/tests/acceptance/boot_linux_console.py b/tests/acceptance/boot_linux_console.py
index 0118ed59156..415e32ef0d6 100644
--- a/tests/acceptance/boot_linux_console.py
+++ b/tests/acceptance/boot_linux_console.py
@@ -889,6 +889,28 @@ def test_arm_orangepi_uboot_netbsd9(self):
         # Wait for user-space
         wait_for_console_pattern(self, 'Starting root file system check')
 
+    def test_aarch64_raspi3_atf(self):
+        """
+        :avocado: tags=arch:aarch64
+        :avocado: tags=machine:raspi3
+        :avocado: tags=cpu:cortex-a53
+        :avocado: tags=device:pl011
+        :avocado: tags=atf
+        """
+        zip_url = ('https://github.com/pbatard/RPi3/releases/download/'
+                   'v1.15/RPi3_UEFI_Firmware_v1.15.zip')
+        zip_hash = '74b3bd0de92683cadb14e008a7575e1d0c3cafb9'
+        zip_path = self.fetch_asset(zip_url, asset_hash=zip_hash)
+
+        archive.extract(zip_path, self.workdir)
+        efi_fd = os.path.join(self.workdir, 'RPI_EFI.fd')
+
+        self.vm.set_console(console_index=1)
+        self.vm.add_args('-nodefaults',
+                         '-device', 'loader,file=%s,force-raw=true' % efi_fd)
+        self.vm.launch()
+        self.wait_for_console_pattern('version UEFI Firmware v1.15')
+
     def test_s390x_s390_ccw_virtio(self):
         """
         :avocado: tags=arch:s390x
-- 
2.26.2


