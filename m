Return-Path: <SRS0=/zFi=CU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92374C43461
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2020 05:30:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C3D44206A5
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2020 05:30:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="cFcAc0yh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3D44206A5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nongnu.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33116 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGbe0-0005Kw-VW
	for qemu-devel@archiver.kernel.org; Fri, 11 Sep 2020 01:30:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52520)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3XwlbXwsKCt4HSKINNEMOENGOOGLE.COMQEMU-DEVELNONGNU.ORG@flex--hskinnemoen.bounces.google.com>)
 id 1kGbVC-0006zK-IB
 for qemu-devel@nongnu.org; Fri, 11 Sep 2020 01:21:38 -0400
Received: from mail-qt1-x849.google.com ([2607:f8b0:4864:20::849]:52303)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3XwlbXwsKCt4HSKINNEMOENGOOGLE.COMQEMU-DEVELNONGNU.ORG@flex--hskinnemoen.bounces.google.com>)
 id 1kGbVA-0002QH-RO
 for qemu-devel@nongnu.org; Fri, 11 Sep 2020 01:21:38 -0400
Received: by mail-qt1-x849.google.com with SMTP id j19so5811229qtp.19
 for <qemu-devel@nongnu.org>; Thu, 10 Sep 2020 22:21:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=sender:date:in-reply-to:message-id:mime-version:references:subject
 :from:to:cc:content-transfer-encoding;
 bh=jBZwDlWnsXv8fYpfjYXs3i4Ofn5g1IAL3EUrT3H87yo=;
 b=cFcAc0yhWKOGL9qIfC7puel5BdzOFStGI4JoclyQAyVCElDTMlWirdpx6/Foi5pQhA
 KFUBfTNSrtlm0EG08rBA6JfsrbZ204IveFdgbGtyeZGL5qf0D1N3pc2GAbKo0ZtkoFo/
 31TtOKL4YuVy36obJIP42dMOG1lKz6ccvdeowxpKqc891SmT1x/KW1cJipo91SNqQdot
 +9SFGx1Hg20qnydPNwfg025D6dCyA6z34TwtNmoAqnO/gU2pwmNdG9auGyCR6tNZkzCQ
 SkZaYrJ6ryt0XyJfvgr2S6XdVArCwWFfYT5dq42/ORPn95FMHNmZX+sqsB4exNWl9foG
 k6Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
 :references:subject:from:to:cc:content-transfer-encoding;
 bh=jBZwDlWnsXv8fYpfjYXs3i4Ofn5g1IAL3EUrT3H87yo=;
 b=l2hazGwFNRHJ3Pt7kzQchmbqzBtpqpcZx9wwZgJKZRC2dN4nb8XUYx+Le8beJlDLN1
 silCTNntK6U8QsBYaocY65mk9d9czRT7RyqEvO67kDcXPJE2uK2Id+l5Y1Reuiw6mcNz
 H9cDsNK0zzYSEni7ZIAkO94Gw1igbf0/5oUUXa9/6Okya5LcpdZcpdz5cMATa66ivra7
 kgSHrpl5Z2WxvaHakOEa/9vS/UZNa/m8/oK12DXjHBtan31YLy0Piu356ZPQ5DMJV14v
 wQtXMx1qnWdrEdUf/c7Svvpp6Wb6NBR8v3XCYJG6xkfX6YsTf/AyGzWBzb8wBHwOvxot
 BS3A==
X-Gm-Message-State: AOAM531QvmFCRCPwvwpWwlJd64FQuOQph6q0MiRsWx9S4fGOd7k4KR8q
 8CMlJiHP7kG2K93aJRIwDBmbNWXAH1elqppHNw==
X-Google-Smtp-Source: ABdhPJytc9FlwDOwIKM4ef5yS3zxFbqnaE5ja6Z5p+OqPmmaQ7olxSMS+Oo5yIYGnIifYqhdq+4G2h/rCYMNSsPb3Q==
X-Received: from skybert.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:3107])
 (user=hskinnemoen job=sendgmr) by 2002:a05:6214:10c9:: with SMTP id
 r9mr520096qvs.0.1599801695003; Thu, 10 Sep 2020 22:21:35 -0700 (PDT)
Date: Thu, 10 Sep 2020 22:21:01 -0700
In-Reply-To: <20200911052101.2602693-1-hskinnemoen@google.com>
Message-Id: <20200911052101.2602693-15-hskinnemoen@google.com>
Mime-Version: 1.0
References: <20200911052101.2602693-1-hskinnemoen@google.com>
X-Mailer: git-send-email 2.28.0.526.ge36021eeef-goog
Subject: [PATCH v9 14/14] tests/acceptance: console boot tests for quanta-gsj
To: peter.maydell@linaro.org, f4bug@amsat.org
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, Avi.Fishman@nuvoton.com, 
 kfting@nuvoton.com, Havard Skinnemoen <hskinnemoen@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::849;
 envelope-from=3XwlbXwsKCt4HSKINNEMOENGOOGLE.COMQEMU-DEVELNONGNU.ORG@flex--hskinnemoen.bounces.google.com;
 helo=mail-qt1-x849.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=unavailable autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Reply-to: Havard Skinnemoen <hskinnemoen@google.com>
From: Havard Skinnemoen via <qemu-devel@nongnu.org>

This adds two acceptance tests for the quanta-gsj machine.

One test downloads a lightly patched openbmc flash image from github and
verifies that it boots all the way to the login prompt.

The other test downloads a kernel, initrd and dtb built from the same
openbmc source and verifies that the kernel detects all CPUs and boots
to the point where it can't find the root filesystem (because we have no
flash image in this case).

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Tested-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Signed-off-by: Havard Skinnemoen <hskinnemoen@google.com>
---
 tests/acceptance/boot_linux_console.py | 83 ++++++++++++++++++++++++++
 1 file changed, 83 insertions(+)

diff --git a/tests/acceptance/boot_linux_console.py b/tests/acceptance/boot=
_linux_console.py
index aaa781a581..4a366ce93e 100644
--- a/tests/acceptance/boot_linux_console.py
+++ b/tests/acceptance/boot_linux_console.py
@@ -568,6 +568,89 @@ class BootLinuxConsole(LinuxKernelTest):
                                                 'sda')
         # cubieboard's reboot is not functioning; omit reboot test.
=20
+    def test_arm_quanta_gsj(self):
+        """
+        :avocado: tags=3Darch:arm
+        :avocado: tags=3Dmachine:quanta-gsj
+        """
+        # 25 MiB compressed, 32 MiB uncompressed.
+        image_url =3D (
+                'https://github.com/hskinnemoen/openbmc/releases/download/=
'
+                '20200711-gsj-qemu-0/obmc-phosphor-image-gsj.static.mtd.gz=
')
+        image_hash =3D '14895e634923345cb5c8776037ff7876df96f6b1'
+        image_path_gz =3D self.fetch_asset(image_url, asset_hash=3Dimage_h=
ash)
+        image_name =3D 'obmc.mtd'
+        image_path =3D os.path.join(self.workdir, image_name)
+        archive.gzip_uncompress(image_path_gz, image_path)
+
+        self.vm.set_console()
+        drive_args =3D 'file=3D' + image_path + ',if=3Dmtd,bus=3D0,unit=3D=
0'
+        self.vm.add_args('-drive', drive_args)
+        self.vm.launch()
+
+        # Disable drivers and services that stall for a long time during b=
oot,
+        # to avoid running past the 90-second timeout. These may be remove=
d
+        # as the corresponding device support is added.
+        kernel_command_line =3D self.KERNEL_COMMON_COMMAND_LINE + (
+                'console=3D${console} '
+                'mem=3D${mem} '
+                'initcall_blacklist=3Dnpcm_i2c_bus_driver_init '
+                'systemd.mask=3Dsystemd-random-seed.service '
+                'systemd.mask=3Ddropbearkey.service '
+        )
+
+        self.wait_for_console_pattern('> BootBlock by Nuvoton')
+        self.wait_for_console_pattern('>Device: Poleg BMC NPCM730')
+        self.wait_for_console_pattern('>Skip DDR init.')
+        self.wait_for_console_pattern('U-Boot ')
+        interrupt_interactive_console_until_pattern(
+                self, 'Hit any key to stop autoboot:', 'U-Boot>')
+        exec_command_and_wait_for_pattern(
+                self, "setenv bootargs ${bootargs} " + kernel_command_line=
,
+                'U-Boot>')
+        exec_command_and_wait_for_pattern(
+                self, 'run romboot', 'Booting Kernel from flash')
+        self.wait_for_console_pattern('Booting Linux on physical CPU 0x0')
+        self.wait_for_console_pattern('CPU1: thread -1, cpu 1, socket 0')
+        self.wait_for_console_pattern('OpenBMC Project Reference Distro')
+        self.wait_for_console_pattern('gsj login:')
+
+    def test_arm_quanta_gsj_initrd(self):
+        """
+        :avocado: tags=3Darch:arm
+        :avocado: tags=3Dmachine:quanta-gsj
+        """
+        initrd_url =3D (
+                'https://github.com/hskinnemoen/openbmc/releases/download/=
'
+                '20200711-gsj-qemu-0/obmc-phosphor-initramfs-gsj.cpio.xz')
+        initrd_hash =3D '98fefe5d7e56727b1eb17d5c00311b1b5c945300'
+        initrd_path =3D self.fetch_asset(initrd_url, asset_hash=3Dinitrd_h=
ash)
+        kernel_url =3D (
+                'https://github.com/hskinnemoen/openbmc/releases/download/=
'
+                '20200711-gsj-qemu-0/uImage-gsj.bin')
+        kernel_hash =3D 'fa67b2f141d56d39b3c54305c0e8a899c99eb2c7'
+        kernel_path =3D self.fetch_asset(kernel_url, asset_hash=3Dkernel_h=
ash)
+        dtb_url =3D (
+                'https://github.com/hskinnemoen/openbmc/releases/download/=
'
+                '20200711-gsj-qemu-0/nuvoton-npcm730-gsj.dtb')
+        dtb_hash =3D '18315f7006d7b688d8312d5c727eecd819aa36a4'
+        dtb_path =3D self.fetch_asset(dtb_url, asset_hash=3Ddtb_hash)
+
+        self.vm.set_console()
+        kernel_command_line =3D (self.KERNEL_COMMON_COMMAND_LINE +
+                               'console=3DttyS0,115200n8 '
+                               'earlycon=3Duart8250,mmio32,0xf0001000')
+        self.vm.add_args('-kernel', kernel_path,
+                         '-initrd', initrd_path,
+                         '-dtb', dtb_path,
+                         '-append', kernel_command_line)
+        self.vm.launch()
+
+        self.wait_for_console_pattern('Booting Linux on physical CPU 0x0')
+        self.wait_for_console_pattern('CPU1: thread -1, cpu 1, socket 0')
+        self.wait_for_console_pattern(
+                'Give root password for system maintenance')
+
     def test_arm_orangepi(self):
         """
         :avocado: tags=3Darch:arm
--=20
2.28.0.526.ge36021eeef-goog


