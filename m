Return-Path: <SRS0=Szrt=YV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44D44CA9EA0
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2019 07:48:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D6AA420650
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2019 07:48:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Xl2XCcIU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6AA420650
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51496 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iOzkX-0006TY-65
	for qemu-devel@archiver.kernel.org; Mon, 28 Oct 2019 03:47:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47144)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iOzc8-00082O-9y
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 03:38:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iOzc5-0003ra-Vp
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 03:38:56 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:56396
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iOzc5-0003qm-CM
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 03:38:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1572248332;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5sLCgOX6S3H5yolM93+Jj0jDwGQx0Cw1bIx+0eop0eM=;
 b=Xl2XCcIUO9uAHNx28eW1Z8tnpt6borcZSh8nOsRYxyKfR3dRJxVbFGrHDfWfB6UG5616Tw
 JSW8tYpLf05MbPL5EdbBDeaaxRVBQqNSmYmB+uF0IAq7RoD+pM1TCkZpSNo463+ueehpzZ
 DrkggIScnSLSHJ+GblKb2QEdQ1uisJ4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-365-jYY4rhNDNv-g8yRVwj6Z6g-1; Mon, 28 Oct 2019 03:38:45 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7BC9D1800D7E;
 Mon, 28 Oct 2019 07:38:44 +0000 (UTC)
Received: from x1w.redhat.com (ovpn-204-86.brq.redhat.com [10.40.204.86])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C2C3919C69;
 Mon, 28 Oct 2019 07:38:33 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 24/26] tests/boot_linux_console: Add initrd test for the
 Exynos4210
Date: Mon, 28 Oct 2019 08:34:39 +0100
Message-Id: <20191028073441.6448-25-philmd@redhat.com>
In-Reply-To: <20191028073441.6448-1-philmd@redhat.com>
References: <20191028073441.6448-1-philmd@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: jYY4rhNDNv-g8yRVwj6Z6g-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: Fam Zheng <fam@euphon.net>, Eduardo Habkost <ehabkost@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 KONRAD Frederic <frederic.konrad@adacore.com>,
 Fabien Chouteau <chouteau@adacore.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Kamil Rytarowski <kamil@netbsd.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Cleber Rosa <crosa@redhat.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

This test boots a Linux kernel on a smdkc210 board and verify
the serial output is working.

The cpio image used comes from the linux-build-test project:
https://github.com/groeck/linux-build-test

If ARM is a target being built, "make check-acceptance" will
automatically include this test by the use of the "arch:arm" tags.

This test can be run using:

  $ IGNORE_AVOCADO_CONSOLE_BUG=3Dyes \
    avocado --show=3Dapp,console run -t machine:smdkc210 \
      tests/acceptance/boot_linux_console.py
  console: Booting Linux on physical CPU 0x900
  console: Linux version 4.19.0-6-armmp (debian-kernel@lists.debian.org) (g=
cc version 8.3.0 (Debian 8.3.0-6)) #1 SMP Debian 4.19.67-2+deb10u1 (2019-09=
-20)
  console: CPU: ARMv7 Processor [410fc090] revision 0 (ARMv7), cr=3D10c5387=
d
  console: CPU: PIPT / VIPT nonaliasing data cache, VIPT nonaliasing instru=
ction cache
  console: OF: fdt: Machine model: Samsung smdkv310 evaluation board based =
on Exynos4210
  [...]
  console: Samsung CPU ID: 0x43210211
  console: random: get_random_bytes called from start_kernel+0xa0/0x504 wit=
h crng_init=3D0
  console: percpu: Embedded 17 pages/cpu s39756 r8192 d21684 u69632
  console: Built 1 zonelists, mobility grouping on.  Total pages: 249152
  console: Kernel command line: printk.time=3D0 console=3DttySAC0,115200n8 =
earlyprintk random.trust_cpu=3Doff cryptomgr.notests cpuidle.off=3D1 panic=
=3D-1 noreboot
  [...]
  console: L2C: platform modifies aux control register: 0x02020000 -> 0x3e4=
20001
  console: L2C: platform provided aux values permit register corruption.
  console: L2C: DT/platform modifies aux control register: 0x02020000 -> 0x=
3e420001
  console: L2C-310 erratum 769419 enabled
  console: L2C-310 enabling early BRESP for Cortex-A9
  console: L2C-310: enabling full line of zeros but not enabled in Cortex-A=
9
  console: L2C-310 ID prefetch enabled, offset 1 lines
  console: L2C-310 dynamic clock gating disabled, standby mode disabled
  console: L2C-310 cache controller enabled, 8 ways, 128 kB
  console: L2C-310: CACHE_ID 0x410000c8, AUX_CTRL 0x7e420001
  console: Exynos4210 clocks: sclk_apll =3D 12000000, sclk_mpll =3D 1200000=
0
  console: sclk_epll =3D 12000000, sclk_vpll =3D 12000000, arm_clk =3D 1200=
0000
  [...]
  console: s3c-i2c 13860000.i2c: slave address 0x00
  console: s3c-i2c 13860000.i2c: bus frequency set to 93 KHz
  console: s3c-i2c 13860000.i2c: i2c-0: S3C I2C adapter
  [...]
  console: dma-pl330 12680000.pdma: Loaded driver for PL330 DMAC-241330
  console: dma-pl330 12680000.pdma:       DBUFF-256x8bytes Num_Chans-8 Num_=
Peri-32 Num_Events-16
  console: dma-pl330 12690000.pdma: Loaded driver for PL330 DMAC-241330
  console: dma-pl330 12690000.pdma:       DBUFF-256x8bytes Num_Chans-8 Num_=
Peri-32 Num_Events-16
  console: dma-pl330 12850000.mdma: Loaded driver for PL330 DMAC-241330
  console: dma-pl330 12850000.mdma:       DBUFF-256x8bytes Num_Chans-8 Num_=
Peri-1 Num_Events-16
  console: dma-pl330 12850000.mdma: PM domain LCD0 will not be powered off
  console: Serial: 8250/16550 driver, 4 ports, IRQ sharing disabled
  console: Serial: AMBA driver
  console: 13800000.serial: ttySAC0 at MMIO 0x13800000 (irq =3D 40, base_ba=
ud =3D 0) is a S3C6400/10
  console: console [ttySAC0] enabled
  console: 13810000.serial: ttySAC1 at MMIO 0x13810000 (irq =3D 41, base_ba=
ud =3D 0) is a S3C6400/10
  console: 13820000.serial: ttySAC2 at MMIO 0x13820000 (irq =3D 42, base_ba=
ud =3D 0) is a S3C6400/10
  console: 13830000.serial: ttySAC3 at MMIO 0x13830000 (irq =3D 43, base_ba=
ud =3D 0) is a S3C6400/10
  [...]
  console: Freeing unused kernel memory: 2048K
  console: Run /init as init process
  console: mount: mounting devtmpfs on /dev failed: Device or resource busy
  console: Starting logging: OK
  console: Initializing random number generator... random: dd: uninitialize=
d urandom read (512 bytes read)
  console: done.
  console: Starting network: OK
  console: Found console ttySAC0
  console: Linux version 4.19.0-6-armmp (debian-kernel@lists.debian.org) (g=
cc version 8.3.0 (Debian 8.3.0-6)) #1 SMP Debian 4.19.67-2+deb10u1 (2019-09=
-20)
  console: Boot successful.
  PASS (37.98 s)

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
---
v2: use archive.gzip_uncompress (Cleber)

serial input is not working :(

I sometime get (not always):

Starting network: OK
[   70.403690] rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
[   70.423212] rcu:     0-...!: (36 GPs behind) idle=3Dc7a/1/0x40000000 sof=
tirq=3D287/288 fqs=3D1
[   70.428209] rcu:     (detected by 1, t=3D2602 jiffies, g=3D-443, q=3D220=
9)
[   70.432826] Sending NMI from CPU 1 to CPUs 0:
[   70.473866] NMI backtrace for cpu 0
[   70.476621] CPU: 0 PID: 112 Comm: cat Not tainted 4.19.0 #1
[   70.476711] Hardware name: SAMSUNG EXYNOS (Flattened Device Tree)
[   70.476916] PC is at mntput_no_expire+0x88/0x464
[   70.476996] LR is at rcu_is_watching+0x24/0x78
[   70.477074] pc : [<c02b256c>]    lr : [<c01a2fb4>]    psr: a0000013
[   70.477150] sp : ee2afdb0  ip : 9dff9a2f  fp : ee2aff70
[   70.477225] r10: 00000142  r9 : ee219dc0  r8 : ee2afec0
[   70.477302] r7 : ee2afec0  r6 : c0298d6c  r5 : ef02c400  r4 : ef018200
[   70.477385] r3 : c0f99274  r2 : 00000031  r1 : 2e87c000  r0 : a0000013
[   70.477461] Flags: NzCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment=
 none
[   70.477537] Control: 10c5387d  Table: 6e30806a  DAC: 00000051
[   70.477613] CPU: 0 PID: 112 Comm: cat Not tainted 4.19.0 #1
[   70.477688] Hardware name: SAMSUNG EXYNOS (Flattened Device Tree)
[   70.477765] [<c01128f4>] (unwind_backtrace) from [<c010e5b4>] (show_stac=
k+0x10/0x14)
[   70.477847] [<c010e5b4>] (show_stack) from [<c0a36160>] (dump_stack+0x98=
/0xc4)
[   70.477925] [<c0a36160>] (dump_stack) from [<c0a3cc90>] (nmi_cpu_backtra=
ce+0x6c/0xb4)
[   70.478000] [<c0a3cc90>] (nmi_cpu_backtrace) from [<c0111530>] (handle_I=
PI+0x108/0x420)
[   70.478076] [<c0111530>] (handle_IPI) from [<c04950a8>] (gic_handle_irq+=
0x98/0x9c)
[   70.478151] [<c04950a8>] (gic_handle_irq) from [<c01019f0>] (__irq_svc+0=
x70/0xb0)
[   70.478226] Exception stack(0xee2afd60 to 0xee2afda8)
[   70.478303] fd60: a0000013 2e87c000 00000031 c0f99274 ef018200 ef02c400 =
c0298d6c ee2afec0
[   70.478378] fd80: ee2afec0 ee219dc0 00000142 ee2aff70 9dff9a2f ee2afdb0 =
c01a2fb4 c02b256c
[   70.478453] fda0: a0000013 ffffffff
[   70.478529] [<c01019f0>] (__irq_svc) from [<c02b256c>] (mntput_no_expire=
+0x88/0x464)
[   70.478605] [<c02b256c>] (mntput_no_expire) from [<c0298d6c>] (terminate=
_walk+0x154/0x160)
[   70.478681] [<c0298d6c>] (terminate_walk) from [<c029ce3c>] (path_openat=
+0x324/0xfe4)
[   70.478759] [<c029ce3c>] (path_openat) from [<c029ea9c>] (do_filp_open+0=
x70/0xdc)
[   70.478835] [<c029ea9c>] (do_filp_open) from [<c028b36c>] (do_sys_open+0=
x134/0x1e4)
[   70.478911] [<c028b36c>] (do_sys_open) from [<c0101000>] (ret_fast_sysca=
ll+0x0/0x28)
[   70.478989] Exception stack(0xee2affa8 to 0xee2afff0)
[   70.479064] ffa0:                   b6fc7d6c 0000000a ffffff9c bebbf268 =
000a0000 00000000
[   70.479139] ffc0: b6fc7d6c 0000000a 00000050 00000142 bebbf268 b6fc6970 =
b6fc6b28 bebbf254
[   70.479214] ffe0: b6fc6970 bebbf1e0 b6f9dd94 b6fb0c0c
[   70.484892] rcu: rcu_preempt kthread starved for 2600 jiffies! g-443 f0x=
0 RCU_GP_WAIT_FQS(5) ->state=3D0x402 ->cpu=3D0
[   70.514943] rcu: RCU grace-period kthread stack dump:
[   70.516687] rcu_preempt     I    0    10      2 0x00000000
[   70.523711] [<c0a4caac>] (__schedule) from [<c0a4d28c>] (schedule+0x4c/0=
xac)
[   70.525103] [<c0a4d28c>] (schedule) from [<c0a52c34>] (schedule_timeout+=
0x230/0x564)
[   70.526472] [<c0a52c34>] (schedule_timeout) from [<c01a7818>] (rcu_gp_kt=
hread+0x6e4/0xbf0)
[   70.527784] [<c01a7818>] (rcu_gp_kthread) from [<c014d7f0>] (kthread+0x1=
38/0x168)
[   70.528989] [<c014d7f0>] (kthread) from [<c01010b4>] (ret_from_fork+0x14=
/0x20)
[   70.530387] Exception stack(0xef111fb0 to 0xef111ff8)
[   70.532556] 1fa0:                                     00000000 00000000 =
00000000 00000000
[   70.534904] 1fc0: 00000000 00000000 00000000 00000000 00000000 00000000 =
00000000 00000000
[   70.536920] 1fe0: 00000000 00000000 00000000 00000000 00000013 00000000
Found console ttySAC0

Linux version 4.19.0 (root@591d0a36fd03) (gcc version 6.3.0 20170516 (Debia=
n 6.3.0-18)) #1 SMP PREEMPT Fri Oct 4 19:53:43 UTC 2019
Boot successful.
/ #

Also:

[   73.000405] [<c01128f4>] (unwind_backtrace) from [<c010e5b4>] (show_stac=
k+0x10/0x14)
[   73.000537] [<c010e5b4>] (show_stack) from [<c0a36160>] (dump_stack+0x98=
/0xc4)
[   73.000631] [<c0a36160>] (dump_stack) from [<c0a3cc90>] (nmi_cpu_backtra=
ce+0x6c/0xb4)
[   73.000701] [<c0a3cc90>] (nmi_cpu_backtrace) from [<c0111530>] (handle_I=
PI+0x108/0x420)
[   73.000823] [<c0111530>] (handle_IPI) from [<c04950a8>] (gic_handle_irq+=
0x98/0x9c)
[   73.000924] [<c04950a8>] (gic_handle_irq) from [<c01019f0>] (__irq_svc+0=
x70/0xb0)
[   73.000990] Exception stack(0xef123f80 to 0xef123fc8)
[   73.001064] 3f80: 00000001 00000001 00000000 ef11b300 ef122000 c1007470 =
c10074b4 00000002
[   73.001131] 3fa0: 4000406a 410fc090 00000000 00000000 00000000 ef123fd0 =
c018759c c010a4c8
[   73.001196] 3fc0: 20000013 ffffffff
[   73.001262] [<c01019f0>] (__irq_svc) from [<c010a4c8>] (arch_cpu_idle+0x=
24/0x3c)
[   73.001328] [<c010a4c8>] (arch_cpu_idle) from [<c015f1f0>] (do_idle+0xcc=
/0x168)
[   73.001394] [<c015f1f0>] (do_idle) from [<c015f60c>] (cpu_startup_entry+=
0x18/0x1c)
[   73.001462] [<c015f60c>] (cpu_startup_entry) from [<4010276c>] (0x401027=
6c)

Based-on: 20190926173428.10713-16-f4bug@amsat.org
"tests/boot_linux_console: Extract the gunzip() helper"
---
 tests/acceptance/boot_linux_console.py | 42 ++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/tests/acceptance/boot_linux_console.py b/tests/acceptance/boot=
_linux_console.py
index 44a046bd64..cbb8cddf47 100644
--- a/tests/acceptance/boot_linux_console.py
+++ b/tests/acceptance/boot_linux_console.py
@@ -432,6 +432,48 @@ class BootLinuxConsole(MachineTest):
         exec_command_and_wait_for_pattern(self, 'reboot',
                                                 'reboot: Restarting system=
')
=20
+    @skipUnless(os.getenv('IGNORE_AVOCADO_CONSOLE_BUG'), 'Console buggy')
+    def test_arm_exynos4210_initrd(self):
+        """
+        :avocado: tags=3Darch:arm
+        :avocado: tags=3Dmachine:smdkc210
+        """
+        deb_url =3D ('https://snapshot.debian.org/archive/debian/'
+                   '20190928T224601Z/pool/main/l/linux/'
+                   'linux-image-4.19.0-6-armmp_4.19.67-2+deb10u1_armhf.deb=
')
+        deb_hash =3D 'fa9df4a0d38936cb50084838f2cb933f570d7d82'
+        deb_path =3D self.fetch_asset(deb_url, asset_hash=3Ddeb_hash)
+        kernel_path =3D self.extract_from_deb(deb_path,
+                                            '/boot/vmlinuz-4.19.0-6-armmp'=
)
+        dtb_path =3D '/usr/lib/linux-image-4.19.0-6-armmp/exynos4210-smdkv=
310.dtb'
+        dtb_path =3D self.extract_from_deb(deb_path, dtb_path)
+
+        initrd_url =3D ('https://github.com/groeck/linux-build-test/raw/'
+                      '2eb0a73b5d5a28df3170c546ddaaa9757e1e0848/rootfs/'
+                      'arm/rootfs-armv5.cpio.gz')
+        initrd_hash =3D '2b50f1873e113523967806f4da2afe385462ff9b'
+        initrd_path_gz =3D self.fetch_asset(initrd_url, asset_hash=3Dinitr=
d_hash)
+        initrd_path =3D os.path.join(self.workdir, 'rootfs.cpio')
+        archive.gzip_uncompress(initrd_path_gz, initrd_path)
+
+        self.vm.set_machine('smdkc210')
+        self.vm.set_console()
+        kernel_command_line =3D (self.KERNEL_COMMON_COMMAND_LINE +
+                               'earlycon=3Dexynos4210,0x13800000 earlyprin=
tk ' +
+                               'console=3DttySAC0,115200n8 ' +
+                               'random.trust_cpu=3Doff cryptomgr.notests '=
 +
+                               'cpuidle.off=3D1 panic=3D-1 noreboot')
+
+        self.vm.add_args('-kernel', kernel_path,
+                         '-dtb', dtb_path,
+                         '-initrd', initrd_path,
+                         '-append', kernel_command_line,
+                         '-no-reboot')
+        self.vm.launch()
+
+        self.wait_for_console_pattern('Boot successful.')
+        # TODO user command, for now the uart is stuck
+
     def test_s390x_s390_ccw_virtio(self):
         """
         :avocado: tags=3Darch:s390x
--=20
2.21.0


