Return-Path: <SRS0=HheB=ZZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 284B5C432C0
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2019 08:50:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D41C320640
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2019 08:50:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VB3sgqOo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D41C320640
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50154 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ic3sx-0001fA-RV
	for qemu-devel@archiver.kernel.org; Tue, 03 Dec 2019 03:50:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43527)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1ic3qc-0000U1-UZ
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 03:47:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1ic3qY-0006FE-37
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 03:47:52 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:57042
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1ic3qX-000641-TN
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 03:47:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575362865;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=H3dr6TtuA5/tPQSFVW8r6iBmmUYoH6HL1p52q4C7aQw=;
 b=VB3sgqOoMow3VvHJEkxkS4o547POiM2uTXdMroDM+38USP1PVONlhQlzlBsUJQjaSolKYo
 M0dg5x4/a+qlqC69YBwRFnKqs+FLs/8Edyf0Z+cD/fvHPMBBnYtbREP+kXC+5/WgoNOu+L
 nLC8ZKNXcm+OLmk6CDZXRdqNfA3YOw0=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-173-wvQkvktjOk2Nvm1Mzn5xUg-1; Tue, 03 Dec 2019 03:47:43 -0500
Received: by mail-wm1-f72.google.com with SMTP id v8so640219wml.4
 for <qemu-devel@nongnu.org>; Tue, 03 Dec 2019 00:47:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=H3dr6TtuA5/tPQSFVW8r6iBmmUYoH6HL1p52q4C7aQw=;
 b=LwsrvalvlkvU6CSxB8wrIHJACf2ejD56RpYInFZZNCpJYKAwiQL+FqzJgkW37W/ZE3
 uKnpnu9tLjoS/rr4LEJMt7N4IHvSAJXlNauTz5G63qX/k+1hnOq080mGfobUVD2P9anm
 9Yr46cOkk0IPQQVegLBv6op7uPrWAYK7krssnetC1+IKj/VGxskrcWWmOu/4Q3yt70FN
 fqGjYeKS8Aq0iTThdTBecWgc8h3O7XR/W4brgZTvqM6YYprJ2UxWYDs8zqNv9+dUy0LF
 8sR+gbq09oiZGT6Ter4VQbJUwxbo36Zfb/ZWjHWB9nsMfnDOz3YvKyWfxY6syoDcfdUq
 asXA==
X-Gm-Message-State: APjAAAWts2DJyzStJH5YPSW21trur5eE6j2xvIWxe8TTJa0PnK9ouhcY
 Sfh4m24B8JQA+dZ9VJ5TbQPBjFqIxV/iSpk2m5RvOBtWs7vYGG5RCDW96LOLX+NlvrNgkJbCrJS
 gmpj3BG8+ZPygKn0=
X-Received: by 2002:a1c:9d8d:: with SMTP id
 g135mr30149537wme.114.1575362861942; 
 Tue, 03 Dec 2019 00:47:41 -0800 (PST)
X-Google-Smtp-Source: APXvYqz903mjgJGviNm59CNaxKCJF2dueQxOTY3o16+N+ZLnPFMqz3uDF3cT+J/jSmlyr+VRg+HqOw==
X-Received: by 2002:a1c:9d8d:: with SMTP id
 g135mr30149496wme.114.1575362861398; 
 Tue, 03 Dec 2019 00:47:41 -0800 (PST)
Received: from [192.168.1.35] (182.red-88-21-103.staticip.rima-tde.net.
 [88.21.103.182])
 by smtp.gmail.com with ESMTPSA id c72sm2285383wmd.11.2019.12.03.00.47.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Dec 2019 00:47:40 -0800 (PST)
Subject: Re: [PATCH 00/10] Add Allwinner H3 SoC and Orange Pi PC Machine
To: Niek Linnenbank <nieklinnenbank@gmail.com>, qemu-devel@nongnu.org
References: <20191202210947.3603-1-nieklinnenbank@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <f54375da-4383-04c5-d57c-3a2f6ff46189@redhat.com>
Date: Tue, 3 Dec 2019 09:47:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191202210947.3603-1-nieklinnenbank@gmail.com>
Content-Language: en-US
X-MC-Unique: wvQkvktjOk2Nvm1Mzn5xUg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
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
Cc: b.galvani@gmail.com, peter.maydell@linaro.org, qemu-arm@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/2/19 10:09 PM, Niek Linnenbank wrote:
> Dear QEMU developers,
> 
> Hereby I would like to contribute the following set of patches to QEMU
> which add support for the Allwinner H3 System on Chip and the
> Orange Pi PC machine. The following features and devices are supported:
> 
>   * SMP (Quad Core Cortex A7)
>   * Generic Interrupt Controller configuration
>   * SRAM mappings
>   * Timer device (re-used from Allwinner A10)
>   * UART
>   * SD/MMC storage controller
>   * EMAC ethernet connectivity
>   * USB 2.0 interfaces
>   * Clock Control Unit
>   * System Control module
>   * Security Identifier device

Awesome!

> Functionality related to graphical output such as HDMI, GPU,
> Display Engine and audio are not included. Recently released
> mainline Linux kernels (4.19 up to latest master) and mainline U-Boot
> are known to work. The SD/MMC code is tested using bonnie++ and
> various tools such as fsck, dd and fdisk. The EMAC is verified with iperf3
> using -netdev socket.
> 
> To build a Linux mainline kernel that can be booted by the Orange Pi PC
> machine, simply configure the kernel using the sunxi_defconfig configuration:
>   $ ARCH=arm CROSS_COMPILE=arm-linux-gnueabi- make mrproper
>   $ ARCH=arm CROSS_COMPILE=arm-linux-gnueabi- make sunxi_defconfig
> 
> To be able to use USB storage, you need to manually enable the corresponding
> configuration item. Start the kconfig configuration tool:
>   $ ARCH=arm CROSS_COMPILE=arm-linux-gnueabi- make menuconfig
> 
> Navigate to the following item, enable it and save your configuration:
>   Device Drivers > USB support > USB Mass Storage support
> 
> Build the Linux kernel with:
>   $ ARCH=arm CROSS_COMPILE=arm-linux-gnueabi- make -j5
> 
> To boot the newly build linux kernel in QEMU with the Orange Pi PC machine, use:
>   $ qemu-system-arm -M orangepi -m 512 -nic user -nographic \
>       -kernel /path/to/linux/arch/arm/boot/zImage \
>       -append 'console=ttyS0,115200' \
>       -dtb /path/to/linux/arch/arm/boot/dts/sun8i-h3-orangepi-pc.dtb
> 
> Note that this kernel does not have a root filesystem. You may provide it
> with an official Orange Pi PC image [1] either as an SD card or as
> USB mass storage. To boot using the Orange Pi PC Debian image on SD card,
> simply add the -sd argument and provide the proper root= kernel parameter:
>   $ qemu-system-arm -M orangepi -m 512 -nic user -nographic \
>       -kernel /path/to/linux/arch/arm/boot/zImage \
>       -append 'console=ttyS0,115200 root=/dev/mmcblk0p2' \
>       -dtb /path/to/linux/arch/arm/boot/dts/sun8i-h3-orangepi-pc.dtb \
>       -sd OrangePi_pc_debian_stretch_server_linux5.3.5_v1.0.img
> 
> Alternatively, you can also choose to build and boot a recent buildroot [2]
> using the orangepi_pc_defconfig or Armbian image [3] for Orange Pi PC.

Richard, trying the Armbian image from 
https://apt.armbian.com/pool/main/l/linux-4.20.7-sunxi/ I get:

$ arm-softmmu/qemu-system-arm -M orangepi -m 512 -nic user \
   -append 'console=ttyS0,115200' \
   -kernel boot/vmlinuz-4.20.7-sunxi \
   -dtb usr/lib/linux-image-dev-sunxi/sun8i-h3-orangepi-pc.dtb \
   -serial stdio -d unimp
Uncompressing Linux... done, booting the kernel.
rtc: unimplemented device write (size 4, value 0x16aa0001, offset 0x0)
rtc: unimplemented device read (size 4, offset 0x0)
rtc: unimplemented device read (size 4, offset 0x0)
rtc: unimplemented device read (size 4, offset 0x8)
qemu-system-arm: target/arm/helper.c:11359: cpu_get_tb_cpu_state: 
Assertion `flags == rebuild_hflags_internal(env)' failed.
Aborted (core dumped)

(gdb) bt
#0  0x00007f6c1fa2ce35 in raise () at /lib64/libc.so.6
#1  0x00007f6c1fa17895 in abort () at /lib64/libc.so.6
#2  0x00007f6c1fa17769 in _nl_load_domain.cold () at /lib64/libc.so.6
#3  0x00007f6c1fa25566 in annobin_assert.c_end () at /lib64/libc.so.6
#4  0x00005590657e2685 in cpu_get_tb_cpu_state (env=0x5590686899b0, 
pc=0x7f6c07ffa718, cs_base=0x7f6c07ffa714, pflags=0x7f6c07ffa71c) at 
target/arm/helper.c:11359
#5  0x000055906569f962 in tb_lookup__cpu_state (cpu=0x5590686808b0, 
pc=0x7f6c07ffa718, cs_base=0x7f6c07ffa714, flags=0x7f6c07ffa71c, 
cf_mask=524288) at include/exec/tb-lookup.h:28
#6  0x00005590656a084c in tb_find (cpu=0x5590686808b0, last_tb=0x0, 
tb_exit=0, cf_mask=524288) at accel/tcg/cpu-exec.c:403
#7  0x00005590656a114a in cpu_exec (cpu=0x5590686808b0) at 
accel/tcg/cpu-exec.c:730
#8  0x000055906565f6af in tcg_cpu_exec (cpu=0x5590686808b0) at cpus.c:1473
#9  0x000055906565ff05 in qemu_tcg_cpu_thread_fn (arg=0x5590686808b0) at 
cpus.c:1781
#10 0x0000559065d54aa6 in qemu_thread_start (args=0x5590687d8c20) at 
util/qemu-thread-posix.c:519
#11 0x00007f6c1fbc54c0 in start_thread () at /lib64/libpthread.so.0
#12 0x00007f6c1faf1553 in clone () at /lib64/libc.so.6

(gdb) p/x flags
$1 = 0x33600000

(gdb) p/x *env
$2 = {regs = {0x0 <repeats 15 times>, 0x40102448}, xregs = {0x0 <repeats 
32 times>}, pc = 0x0, pstate = 0x0, aarch64 = 0x0, hflags = 0x33600000, 
uncached_cpsr = 0x1a, spsr = 0x0, banked_spsr = {0x0, 0x0, 0x0, 0x0, 
0x0, 0x0, 0x0, 0x0},
   banked_r13 = {0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0}, banked_r14 = 
{0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0}, usr_regs = {0x0, 0x0, 0x0, 
0x0, 0x0}, fiq_regs = {0x0, 0x0, 0x0, 0x0, 0x0}, CF = 0x0, VF = 0x0, NF 
= 0x0, ZF = 0x0,
   QF = 0x0, GE = 0x0, thumb = 0x1, condexec_bits = 0x0, btype = 0x0, 
daif = 0x3c0, elr_el = {0x0, 0x0, 0x0, 0x0}, sp_el = {0x0, 0x0, 0x0, 
0x0}, cp15 = {c0_cpuid = 0x410fc075, {{_unused_csselr0 = 0x0, csselr_ns 
= 0x0,
         _unused_csselr1 = 0x0, csselr_s = 0x0}, csselr_el = {0x0, 0x0, 
0x0, 0x0}}, {{_unused_sctlr = 0x0, sctlr_ns = 0xc50078, hsctlr = 0x0, 
sctlr_s = 0xc50078}, sctlr_el = {0x0, 0xc50078, 0x0, 0xc50078}}, 
cpacr_el1 = 0x0, cptr_el = {
       0x0, 0x0, 0x0, 0x0}, c1_xscaleauxcr = 0x0, sder = 0x0, nsacr = 
0xc00, {{_unused_ttbr0_0 = 0x0, ttbr0_ns = 0x0, _unused_ttbr0_1 = 0x0, 
ttbr0_s = 0x0}, ttbr0_el = {0x0, 0x0, 0x0, 0x0}}, {{_unused_ttbr1_0 = 
0x0, ttbr1_ns = 0x0,
         _unused_ttbr1_1 = 0x0, ttbr1_s = 0x0}, ttbr1_el = {0x0, 0x0, 
0x0, 0x0}}, vttbr_el2 = 0x0, tcr_el = {{raw_tcr = 0x0, mask = 0x0, 
base_mask = 0x0}, {raw_tcr = 0x0, mask = 0x0, base_mask = 0xffffc000}, 
{raw_tcr = 0x0, mask = 0x0,
         base_mask = 0x0}, {raw_tcr = 0x0, mask = 0x0, base_mask = 
0xffffc000}}, vtcr_el2 = {raw_tcr = 0x0, mask = 0x0, base_mask = 0x0}, 
c2_data = 0x0, c2_insn = 0x0, {{dacr_ns = 0x0, dacr_s = 0x0}, 
{dacr32_el2 = 0x0}},
     pmsav5_data_ap = 0x0, pmsav5_insn_ap = 0x0, hcr_el2 = 0x0, scr_el3 
= 0x101, {{ifsr_ns = 0x0, ifsr_s = 0x0}, {ifsr32_el2 = 0x0}}, 
{{_unused_dfsr = 0x0, dfsr_ns = 0x0, hsr = 0x0, dfsr_s = 0x0}, esr_el = 
{0x0, 0x0, 0x0, 0x0}},
     c6_region = {0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0}, 
{{_unused_far0 = 0x0, dfar_ns = 0x0, ifar_ns = 0x0, dfar_s = 0x0, ifar_s 
= 0x0, _unused_far3 = 0x0}, far_el = {0x0, 0x0, 0x0, 0x0}}, hpfar_el2 = 
0x0, hstr_el2 = 0x0, {{
         _unused_par_0 = 0x0, par_ns = 0x0, _unused_par_1 = 0x0, par_s = 
0x0}, par_el = {0x0, 0x0, 0x0, 0x0}}, c9_insn = 0x0, c9_data = 0x0, 
c9_pmcr = 0x41002000, c9_pmcnten = 0x0, c9_pmovsr = 0x0, c9_pmuserenr = 
0x0, c9_pmselr = 0x0,
     c9_pminten = 0x0, {{_unused_mair_0 = 0x0, mair0_ns = 0x0, mair1_ns 
= 0x0, _unused_mair_1 = 0x0, mair0_s = 0x0, mair1_s = 0x0}, mair_el = 
{0x0, 0x0, 0x0, 0x0}}, {{_unused_vbar = 0x0, vbar_ns = 0x0, hvbar = 0x0, 
vbar_s = 0x0},
       vbar_el = {0x0, 0x0, 0x0, 0x0}}, mvbar = 0x0, {fcseidr_ns = 0x0, 
fcseidr_s = 0x0}, {{_unused_contextidr_0 = 0x0, contextidr_ns = 0x0, 
_unused_contextidr_1 = 0x0, contextidr_s = 0x0}, contextidr_el = {0x0, 
0x0, 0x0, 0x0}}, {{
         tpidrurw_ns = 0x0, tpidrprw_ns = 0x0, htpidr = 0x0, _tpidr_el3 
= 0x0}, tpidr_el = {0x0, 0x0, 0x0, 0x0}}, tpidrurw_s = 0x0, tpidrprw_s = 
0x0, tpidruro_s = 0x0, {tpidruro_ns = 0x0, tpidrro_el = {0x0}}, 
c14_cntfrq = 0x3b9aca0,
     c14_cntkctl = 0x0, cnthctl_el2 = 0x3, cntvoff_el2 = 0x0, c14_timer 
= {{cval = 0x0, ctl = 0x0}, {cval = 0x0, ctl = 0x0}, {cval = 0x0, ctl = 
0x0}, {cval = 0x0, ctl = 0x0}}, c15_cpar = 0x0, c15_ticonfig = 0x0, 
c15_i_max = 0x0,
     c15_i_min = 0x0, c15_threadid = 0x0, c15_config_base_address = 0x0, 
c15_diagnostic = 0x0, c15_power_diagnostic = 0x0, c15_power_control = 
0x0, dbgbvr = {0x0 <repeats 16 times>}, dbgbcr = {0x0 <repeats 16 
times>}, dbgwvr = {
       0x0 <repeats 16 times>}, dbgwcr = {0x0 <repeats 16 times>}, 
mdscr_el1 = 0x0, oslsr_el1 = 0xa, mdcr_el2 = 0x0, mdcr_el3 = 0x0, 
c15_ccnt = 0x0, c15_ccnt_delta = 0x0, c14_pmevcntr = {0x0 <repeats 31 
times>}, c14_pmevcntr_delta = {
       0x0 <repeats 31 times>}, c14_pmevtyper = {0x0 <repeats 31 
times>}, pmccfiltr_el0 = 0x0, vpidr_el2 = 0x410fc075, vmpidr_el2 = 
0x80000001}, v7m = {other_sp = 0x0, other_ss_msp = 0x0, other_ss_psp = 
0x0, vecbase = {0x0, 0x0},
     basepri = {0x0, 0x0}, control = {0x0, 0x0}, ccr = {0x0, 0x0}, cfsr 
= {0x0, 0x0}, hfsr = 0x0, dfsr = 0x0, sfsr = 0x0, mmfar = {0x0, 0x0}, 
bfar = 0x0, sfar = 0x0, mpu_ctrl = {0x0, 0x0}, exception = 0x0, primask 
= {0x0, 0x0},
     faultmask = {0x0, 0x0}, aircr = 0x0, secure = 0x0, csselr = {0x0, 
0x0}, scr = {0x0, 0x0}, msplim = {0x0, 0x0}, psplim = {0x0, 0x0}, fpcar 
= {0x0, 0x0}, fpccr = {0x0, 0x0}, fpdscr = {0x0, 0x0}, cpacr = {0x0, 
0x0}, nsacr = 0x0},
   exception = {syndrome = 0x0, fsr = 0x0, vaddress = 0x0, target_el = 
0x0}, serror = {pending = 0x0, has_esr = 0x0, esr = 0x0}, irq_line_state 
= 0x0, teecr = 0x0, teehbr = 0x0, vfp = {zregs = {{d = {0x0, 0x0}} 
<repeats 32 times>},
     qc = {0x0, 0x0, 0x0, 0x0}, vec_len = 0x0, vec_stride = 0x0, xregs = 
{0x41023075, 0x0, 0x0, 0x0, 0x0, 0x0, 0x11111111, 0x10110222, 0x0, 0x0, 
0x0, 0x0, 0x0, 0x0, 0x0, 0x0}, scratch = {0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 
0x0, 0x0},
     fp_status = {float_detect_tininess = 0x1, float_rounding_mode = 
0x0, float_exception_flags = 0x0, floatx80_rounding_precision = 0x0, 
flush_to_zero = 0x0, flush_inputs_to_zero = 0x0, default_nan_mode = 0x0, 
snan_bit_is_one = 0x0},
     fp_status_f16 = {float_detect_tininess = 0x1, float_rounding_mode = 
0x0, float_exception_flags = 0x0, floatx80_rounding_precision = 0x0, 
flush_to_zero = 0x0, flush_inputs_to_zero = 0x0, default_nan_mode = 0x0,
       snan_bit_is_one = 0x0}, standard_fp_status = 
{float_detect_tininess = 0x1, float_rounding_mode = 0x0, 
float_exception_flags = 0x0, floatx80_rounding_precision = 0x0, 
flush_to_zero = 0x1, flush_inputs_to_zero = 0x1,
       default_nan_mode = 0x1, snan_bit_is_one = 0x0}, zcr_el = {0x0, 
0x0, 0x0, 0x0}}, exclusive_addr = 0xffffffffffffffff, exclusive_val = 
0x0, exclusive_high = 0x0, iwmmxt = {regs = {0x0 <repeats 16 times>}, 
val = 0x0, cregs = {
       0x0 <repeats 16 times>}}, cpu_breakpoint = {0x0 <repeats 16 
times>}, cpu_watchpoint = {0x0 <repeats 16 times>}, end_reset_fields = 
{<No data fields>}, features = 0xfd38fbe6f3, pmsav7 = {drbar = 0x0, drsr 
= 0x0, dracr = 0x0,
     rnr = {0x0, 0x0}}, pmsav8 = {rbar = {0x0, 0x0}, rlar = {0x0, 0x0}, 
mair0 = {0x0, 0x0}, mair1 = {0x0, 0x0}}, sau = {rbar = 0x0, rlar = 0x0, 
rnr = 0x0, ctrl = 0x0}, nvic = 0x0, boot_info = 0x5622af3a17a0, 
gicv3state = 0x0}

> [1] http://www.orangepi.org/downloadresources/
> [2] https://buildroot.org/download.html
> [3] https://www.armbian.com/orange-pi-pc/


