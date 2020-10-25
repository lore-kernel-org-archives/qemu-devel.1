Return-Path: <SRS0=AG+E=EA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EDECC2D0A3
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Oct 2020 00:34:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B830C22281
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Oct 2020 00:34:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dYoHAV/Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B830C22281
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53612 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kWTzV-0002bb-RN
	for qemu-devel@archiver.kernel.org; Sat, 24 Oct 2020 20:34:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36630)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kWTyE-0001Hi-O0
 for qemu-devel@nongnu.org; Sat, 24 Oct 2020 20:33:14 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:36391)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kWTyC-0003oH-VU
 for qemu-devel@nongnu.org; Sat, 24 Oct 2020 20:33:14 -0400
Received: by mail-wm1-x343.google.com with SMTP id e2so8263826wme.1
 for <qemu-devel@nongnu.org>; Sat, 24 Oct 2020 17:33:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=/7xwbCZjytByiqoR4V3Ub63glT46qrfDPDh0z4HLav0=;
 b=dYoHAV/YEgZUPRjf4MHB90+v5BmA16OmVXgYZPCRW3sZdeIRYZ8t6dEeTnn5N041TY
 3rYhDGDA95pE7fEo/slzQ5sTAbOalYlXMDwltzUB3FTeBK0UErgUP+zaPU/UIRFAJwnE
 SbyMRy1UAfBCiZ01ZfWi/CoS0XvgpkPNaz160PTYRj/yLnw/cwHdqOZErFmh7NNS+m92
 uOt09qkxz8xjaxZRWjcLmZsaDkQcHqT+IrUeUycQWVX6EGbcIdbuPg89LEf1YgopNot9
 UZmDNUrbqxfSHKDz8jFRZQW2xfU6bgoJzZAoNmORY/0Jpgy/rWIKgSYxOsWKt4F0nMy4
 D2Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=/7xwbCZjytByiqoR4V3Ub63glT46qrfDPDh0z4HLav0=;
 b=HT9AfwC1BnBtD4MXPzn2wZciYru8iM6CJ2GZhq7VX7KrRm6H3zB/rdXLHCsBxSV9LE
 lMF28aLASeTDU4pSkX2VwJ6kbFsnY58lRv3Jof/T3K1lEkGz+Ez/+6cqPujza2uTIRIx
 VkNRFou5SfzW/CH9p2bNgk56y27fEGNcQOKn+ljrOZZ1uxG8RzzaUhOBYOjGYxlzdZHz
 D23eFImkPjHn/e6rvdmaVczC0Q2hvBWtYq/U6ARDmY3fMRtcQZV2vK6em8XaB78wdGMd
 eRSraDb9wMXjHmzJiuIJnmNLyQqKBSC3oj/KL62Jo3hc5y8u1iSr6uVq3zZ/GdCPIw7X
 C9/Q==
X-Gm-Message-State: AOAM530BKMCHUVvu4zw+eJmb7Q8t9PeJVZ4gm4UXm4SmnbG7AQgeBIZe
 kmzT9VO5S/H7l2Gkjfn5Q23Quxr3P2s=
X-Google-Smtp-Source: ABdhPJxQvkkkPqEDsmS+q8CHg0+QIt+FlTAGrv7Dpb5tvvPzsTt1jUO9ZD2+Yc5FS82nW057V20Z1g==
X-Received: by 2002:a1c:b486:: with SMTP id d128mr9011679wmf.164.1603585991042; 
 Sat, 24 Oct 2020 17:33:11 -0700 (PDT)
Received: from [192.168.1.36] (237.red-88-18-140.staticip.rima-tde.net.
 [88.18.140.237])
 by smtp.gmail.com with ESMTPSA id m1sm13300658wmm.34.2020.10.24.17.33.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 24 Oct 2020 17:33:10 -0700 (PDT)
Subject: Re: [PATCH 12/20] hw/rx/rx62n: Use New SCI module.
To: Yoshinori Sato <ysato@users.sourceforge.jp>, qemu-devel@nongnu.org
References: <20200827123859.81793-1-ysato@users.sourceforge.jp>
 <20200827123859.81793-13-ysato@users.sourceforge.jp>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <cc946fbf-496e-2572-8a54-5bce091e22a8@amsat.org>
Date: Sun, 25 Oct 2020 02:33:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20200827123859.81793-13-ysato@users.sourceforge.jp>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x343.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25, NICE_REPLY_A=-0.107,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 8/27/20 2:38 PM, Yoshinori Sato wrote:
> Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
> ---
>   include/hw/rx/rx62n.h | 2 +-
>   hw/rx/rx62n.c         | 7 ++++++-
>   2 files changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/include/hw/rx/rx62n.h b/include/hw/rx/rx62n.h
> index 1182ca24de..f463148799 100644
> --- a/include/hw/rx/rx62n.h
> +++ b/include/hw/rx/rx62n.h
> @@ -70,7 +70,7 @@ typedef struct RX62NState {
>       RXICUState icu;
>       RenesasTMR8State tmr[RX62N_NR_TMR];
>       RenesasCMTState cmt[RX62N_NR_CMT];
> -    RSCIState sci[RX62N_NR_SCI];
> +    RSCIAState sci[RX62N_NR_SCI];
>       RX62NCPGState cpg;
>   
>       MemoryRegion *sysmem;
> diff --git a/hw/rx/rx62n.c b/hw/rx/rx62n.c
> index 0223396110..f61383a4c2 100644
> --- a/hw/rx/rx62n.c
> +++ b/hw/rx/rx62n.c
> @@ -191,11 +191,13 @@ static void register_sci(RX62NState *s, int unit)
>   {
>       SysBusDevice *sci;
>       int i, irqbase;
> +    char ckname[16];
>   
>       object_initialize_child(OBJECT(s), "sci[*]",
> -                            &s->sci[unit], TYPE_RENESAS_SCI);
> +                            &s->sci[unit], TYPE_RENESAS_SCIA);
>       sci = SYS_BUS_DEVICE(&s->sci[unit]);
>       qdev_prop_set_chr(DEVICE(sci), "chardev", serial_hd(unit));
> +    qdev_prop_set_uint32(DEVICE(sci), "unit", unit);
>       sysbus_realize(sci, &error_abort);
>   
>       irqbase = RX62N_SCI_IRQ + SCI_NR_IRQ * unit;
> @@ -203,6 +205,9 @@ static void register_sci(RX62NState *s, int unit)
>           sysbus_connect_irq(sci, i, s->irq[irqbase + i]);
>       }
>       sysbus_mmio_map(sci, 0, RX62N_SCI_BASE + unit * 0x08);
> +    snprintf(ckname, sizeof(ckname), "pck_sci-%d", unit);
> +    qdev_connect_clock_in(DEVICE(sci), "pck",
> +                          qdev_get_clock_out(DEVICE(&s->cpg), ckname));
>   }
>   
>   static void register_cpg(RX62NState *s)
> 

This makes the test_linux_sash test timeout:

$ avocado --show=app,console run -t arch:rx  tests/acceptance/
Fetching asset from 
tests/acceptance/machine_rx_gdbsim.py:RxGdbSimMachine.test_uboot
Fetching asset from 
tests/acceptance/machine_rx_gdbsim.py:RxGdbSimMachine.test_linux_sash
Fetching asset from 
tests/acceptance/machine_rx_gdbsim.py:RxGdbSimMachine.test_linux_sash
JOB ID     : 932d3a7a15be19e0d9772705d69d5b815793b1d3
JOB LOG    : 
/home/phil/avocado/job-results/job-2020-10-25T02.18-932d3a7/job.log
  (1/2) 
tests/acceptance/machine_rx_gdbsim.py:RxGdbSimMachine.test_uboot: 
console: U-Boot 2016.05-rc3-23705-ga1ef3c71cb-dirty (Feb 05 2019 - 
21:56:06 +0900)
PASS (0.11 s)
  (2/2) 
tests/acceptance/machine_rx_gdbsim.py:RxGdbSimMachine.test_linux_sash: 
console: Linux version 4.19.0+ (yo-satoh@yo-satoh-debian) (gcc version 
9.0.0 20181105 (experimental) (GCC)) #137 Wed Feb 20 23:20:02 JST 2019
console: Built 1 zonelists, mobility grouping on.  Total pages: 8128
console: Kernel command line:
console: Dentry cache hash table entries: 4096 (order: 2, 16384 bytes)
console: Inode-cache hash table entries: 2048 (order: 1, 8192 bytes)
console: Memory: 14648K/32768K available (871K kernel code, 95K rwdata, 
140K rodata, 96K init, 175K bss, 18120K reserved, 0K cma-reserved)
console: NR_IRQS: 256
console: rx-cmt: used for periodic clock events
console: clocksource: rx-tpu: mask: 0xffffffff max_cycles: 0xffffffff, 
max_idle_ns: 1274173631191 ns
console: 96.00 BogoMIPS (lpj=480000)
console: pid_max: default: 4096 minimum: 301
console: Mount-cache hash table entries: 1024 (order: 0, 4096 bytes)
console: Mountpoint-cache hash table entries: 1024 (order: 0, 4096 bytes)
console: clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, 
max_idle_ns: 19112604462750000 ns
console: clocksource: Switched to clocksource rx-tpu
console: workingset: timestamp_bits=30 max_order=12 bucket_order=0
console: SuperH (H)SCI(F) driver initialized
console: 88240.serial: ttySC0 at MMIO 0x88240 (irq = 215, base_baud = 0) 
is a sci
console: console [ttySC0] enabled
console: 88248.serial: ttySC1 at MMIO 0x88248 (irq = 219, base_baud = 0) 
is a sci
console: random: get_random_bytes called from 0x01002e48 with crng_init=0
console: Freeing unused kernel memory: 96K
console: This architecture does not have kernel memory protection.
console: Run /sbin/init as init process
console: Run /etc/init as init process
console: Run /bin/init as init process
console: Run /bin/sh as init process
\console: random: fast init done
INTERRUPTED: Test interrupted by SIGTERM\nRunner error occurred: Timeout 
reached\nOriginal status: ERROR\n{'name': 
'2-tests/acceptance/machine_rx_gdbsim.py:RxGdbSimMachine.test_linux_sash', 
'logdir': 
'/home/phil/avocado/job-results/job-2020-10-25T02.18-932d3a7/test-resul... 
(30.23 s)
RESULTS    : PASS 1 | ERROR 0 | FAIL 0 | SKIP 0 | WARN 0 | INTERRUPT 1 | 
CANCEL 0
JOB TIME   : 30.73 s


