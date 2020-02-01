Return-Path: <SRS0=CCzH=3V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72C4EC33CB3
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Feb 2020 20:13:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 285022063A
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Feb 2020 20:13:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z8WW2dZT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 285022063A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50304 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ixz98-0008P7-CO
	for qemu-devel@archiver.kernel.org; Sat, 01 Feb 2020 15:13:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42837)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1ixz7o-000788-8a
 for qemu-devel@nongnu.org; Sat, 01 Feb 2020 15:12:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1ixz7k-0003t7-4c
 for qemu-devel@nongnu.org; Sat, 01 Feb 2020 15:12:15 -0500
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:35892)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1ixz7j-0003bI-4m
 for qemu-devel@nongnu.org; Sat, 01 Feb 2020 15:12:11 -0500
Received: by mail-wr1-x441.google.com with SMTP id z3so12810416wru.3
 for <qemu-devel@nongnu.org>; Sat, 01 Feb 2020 12:12:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:autocrypt:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=IAPGE6ZoI4o8oiSIn0f1KU5R5jU7De9n/rUZR+ly6uM=;
 b=Z8WW2dZTtn8xC831T/ex9FsMhucXaF26ychH3TU3sr4cvb0TXTVtqLe3QIYqmOg2/O
 lAbjSkkxlJv0PtaDzpEV+JRctN0PDkFADWYnt82PM6NNJ2mjL2ONY7ezZdYdk5NgZAcD
 WKo0G++Be+1yAaELPJD+0xvvaO/OADIrQv0llI5WfRU3UY+cTYC5dLV0iUqXbFSTka8k
 ldWRNbQ6TFcm1moMmgiVu0LbTjOMuvVhc+4egShaVPF5PoYwrUPLVei8/92vW3gov0+K
 tzsjXub77kU5QPbRl6HfugWonyv7ryBo1tCTwrbp0VUsoM4n6p4iXyhbMJPrQFJICWTP
 vqBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=IAPGE6ZoI4o8oiSIn0f1KU5R5jU7De9n/rUZR+ly6uM=;
 b=f1bkye1kzl4+QEJRcU0uktjqcQi5PTZ8k4XLoojrtN2r2sKN3ITA/T/y/FnyROJ5MR
 ZDphRS2YSKi8p7yNODn0dEpKSCNgu5y2n2y+CJt0DF32cpGySJrOb6XVoT2JVm8IEUuw
 ToRGkTNba4xwx7qE1cxQ4OLmgixl2G+3yG79FSjuHlL+p39NLj9MPcG7e81yHb8ir/G6
 rjF4eG11ufSXtdwXlRO9v20Sq914iFZOqiDloOZN3nvoe0HxCBX7HKj3/jLb859Z4oHt
 wwqcGIMBTvo4nXKZIix4zftYc5949kLwJPmdeu0uvo2Fxaakl6UW1ydDXqD4Ons3kHkA
 b2Qg==
X-Gm-Message-State: APjAAAUsTgB2wnpgkwuyoLnWV1YgP9Qz/o7budiCxke7JSvvu7C6RwqJ
 XGf6eN6HsxHWUoKs17xwmBQ=
X-Google-Smtp-Source: APXvYqxxoVzKQqfi6U9MmI1zkfKehBg70IKhw+T691Bt9y4Xpu7QqmUpn8CJuew87oJj0iklYdYCWQ==
X-Received: by 2002:a5d:5403:: with SMTP id g3mr6125875wrv.302.1580587927945; 
 Sat, 01 Feb 2020 12:12:07 -0800 (PST)
Received: from [192.168.1.35] (162.red-83-52-55.dynamicip.rima-tde.net.
 [83.52.55.162])
 by smtp.gmail.com with ESMTPSA id o4sm17896990wrx.25.2020.02.01.12.12.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 01 Feb 2020 12:12:06 -0800 (PST)
Subject: Re: [PULL 32/41] target/mips: Use cpu_*_mmuidx_ra instead of
 MMU_MODE*_SUFFIX
To: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
References: <20200108034523.17349-1-richard.henderson@linaro.org>
 <20200108034523.17349-33-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Autocrypt: addr=f4bug@amsat.org; keydata=
 mQINBDU8rLoBEADb5b5dyglKgWF9uDbIjFXU4gDtcwiga9wJ/wX6xdhBqU8tlQ4BroH7AeRl
 u4zXP0QnBDAG7EetxlQzcfYbPmxFISWjckDBFvDbFsojrZmwF2/LkFSzlvKiN5KLghzzJhLO
 HhjGlF8deEZz/d/G8qzO9mIw8GIBS8uuWh6SIcG/qq7+y+2+aifaj92EdwU79apZepT/U3vN
 YrfcAuo1Ycy7/u0hJ7rlaFUn2Fu5KIgV2O++hHYtCCQfdPBg/+ujTL+U+sCDawCyq+9M5+LJ
 ojCzP9rViLZDd/gS6jX8T48hhidtbtsFRj/e9QpdZgDZfowRMVsRx+TB9yzjFdMO0YaYybXp
 dg/wCUepX5xmDBrle6cZ8VEe00+UQCAU1TY5Hs7QFfBbjgR3k9pgJzVXNUKcJ9DYQP0OBH9P
 ZbZvM0Ut2Bk6bLBO5iCVDOco0alrPkX7iJul2QWBy3Iy9j02GnA5jZ1Xtjr9kpCqQT+sRXso
 Vpm5TPGWaWljIeLWy/qL8drX1eyJzwTB3A36Ck4r3YmjMjfmvltSZB1uAdo1elHTlFEULpU/
 HiwvvqXQ9koB15U154VCuguvx/Qnboz8GFb9Uw8VyawzVxYVNME7xw7CQF8FYxzj6eI7rBf2
 Dj/II6wxWPgDEy3oUzuNOxTB7sT3b/Ym76yOJzWX5BylXQIJ5wARAQABtDFQaGlsaXBwZSBN
 YXRoaWV1LURhdWTDqSAoRjRCVUcpIDxmNGJ1Z0BhbXNhdC5vcmc+iQJVBBMBCAA/AhsPBgsJ
 CAcDAgYVCAIJCgsEFgIDAQIeAQIXgBYhBPqr514SkXIh3P1rsuPjLCzercDeBQJd660aBQks
 klzgAAoJEOPjLCzercDe2iMP+gMG2dUf+qHz2uG8nTBGMjgK0aEJrKVPodFA+iedQ5Kp3BMo
 jrTg3/DG1HMYdcvQu/NFLYwamUfUasyor1k+3dB23hY09O4xOsYJBWdilkBGsJTKErUmkUO2
 3J/kawosvYtJJSHUpw3N6mwz/iWnjkT8BPp7fFXSujV63aZWZINueTbK7Y8skFHI0zpype9s
 loU8xc4JBrieGccy3n4E/kogGrTG5jcMTNHZ106DsQkhFnjhWETp6g9xOKrzZQbETeRBOe4P
 sRsY9YSG2Sj+ZqmZePvO8LyzGRjYU7T6Z80S1xV0lH6KTMvq7vvz5rd92f3pL4YrXq+e//HZ
 JsiLen8LH/FRhTsWRgBtNYkOsd5F9NvfJtSM0qbX32cSXMAStDVnS4U+H2vCVCWnfNug2TdY
 7v4NtdpaCi4CBBa3ZtqYVOU05IoLnlx0miKTBMqmI05kpgX98pi2QUPJBYi/+yNu3fjjcuS9
 K5WmpNFTNi6yiBbNjJA5E2qUKbIT/RwQFQvhrxBUcRCuK4x/5uOZrysjFvhtR8YGm08h+8vS
 n0JCnJD5aBhiVdkohEFAz7e5YNrAg6kOA5IVRHB44lTBOatLqz7ntwdGD0rteKuHaUuXpTYy
 CRqCVAKqFJtxhvJvaX0vLS1Z2dwtDwhjfIdgPiKEGOgCNGH7R8l+aaM4OPOd
Message-ID: <7c714bf4-2e5c-c17b-5a06-72d63e06d3a4@amsat.org>
Date: Sat, 1 Feb 2020 21:12:05 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200108034523.17349-33-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
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
Cc: peter.maydell@linaro.org, David Hildenbrand <david@redhat.com>,
 qemu-devel@nongnu.org, Aleksandar Markovic <amarkovic@wavecomp.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Richard,

On 1/8/20 4:45 AM, Richard Henderson wrote:
> The separate suffixed functions were used to construct
> some do_##insn function switched on mmu_idx.  The interface
> is exactly identical to the *_mmuidx_ra functions.  Replace
> them directly and remove the constructions.
> 
> Cc: Aurelien Jarno <aurelien@aurel32.net>
> Cc: Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>
> Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>

I'm seeing a regression since commit 7dd547e5a (however I'm not sure
this particular commit introduced the regression, or instead revealed it).

I get a hang when booting a I6400 CPU on Malta:

$ qemu-system-mips64el -cpu I6400 -serial stdio \
  -kernel vmlinux \
  -append "clocksource=GIC console=ttyS0 printk.time=1"
Linux version 4.7.0-rc1 (@859affe05464) (gcc version 6.3.0 20170516
(Debian 6.3.0-18) ) #2 SMP Sat Feb 1 18:16:17 UTC 2020
GCRs appear to have been moved (expected them at 0x1fbf8000)!
earlycon: uart8250 at I/O port 0x3f8 (options '38400n8')
bootconsole [uart8250] enabled
MIPS CPS SMP unable to proceed without a CM
CPU0 revision is: 0001a900 (MIPS I6400)
FPU revision is: 20f30300
MSA revision is: 00000300
MIPS: machine is mti,malta
Software DMA cache coherency enabled
Determined physical RAM map:
 memory: 0000000008000000 @ 0000000000000000 (usable)
Zone ranges:
  DMA      [mem 0x0000000000000000-0x0000000000ffffff]
  DMA32    [mem 0x0000000001000000-0x00000000ffffffff]
  Normal   empty
Movable zone start for each node
Early memory node ranges
  node   0: [mem 0x0000000000000000-0x0000000007ffffff]
Initmem setup node 0 [mem 0x0000000000000000-0x0000000007ffffff]
Primary instruction cache 64kB, VIPT, 4-way, linesize 64 bytes.
Primary data cache 64kB, 4-way, VIPT, no aliases, linesize 64 bytes
percpu: Embedded 5 pages/cpu @980000000107c000 s29664 r8192 d44064 u81920
Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 8163
Kernel command line: clocksource=GIC console=ttyS0 printk.time=1
[    0.000000] PID hash table entries: 512 (order: -2, 4096 bytes)
[    0.000000] Dentry cache hash table entries: 16384 (order: 3, 131072
bytes)
[    0.000000] Inode-cache hash table entries: 8192 (order: 2, 65536 bytes)
[    0.000000] Writing ErrCtl register=00000000
[    0.000000] Readback ErrCtl register=00000000
[    0.000000] MAAR configuration:
[    0.000000]   [0]: 0x0000000000010000-0x0000000007ffffff speculate
[    0.000000]   [1]: disabled
[    0.000000]   [2]: disabled
[    0.000000]   [3]: disabled
[    0.000000]   [4]: disabled
[    0.000000]   [5]: disabled
[    0.000000]   [6]: disabled
[    0.000000]   [7]: disabled
[    0.000000] Memory: 121728K/131072K available (5253K kernel code,
380K rwdata, 1276K rodata, 304K init, 278K bss, 9344K reserved, 0K
cma-reserved)
[    0.000000] Hierarchical RCU implementation.
[    0.000000]  Build-time adjustment of leaf fanout to 64.
[    0.000000]  RCU restricting CPUs from NR_CPUS=8 to nr_cpu_ids=1.
[    0.000000] RCU: Adjusting geometry for rcu_fanout_leaf=64, nr_cpu_ids=1
[    0.000000] NR_IRQS:256
[    0.000000] CPU frequency 200.00 MHz
[    0.000000] clocksource: MIPS: mask: 0xffffffff max_cycles:
0xffffffff, max_idle_ns: 19112598155 ns
[    0.000223] sched_clock: 32 bits at 100MHz, resolution 9ns, wraps
every 21474829307ns
[    0.008011] Console: colour dummy device 80x25
[    0.012181] Calibrating delay loop... 950.27 BogoMIPS (lpj=4751360)
[    0.164015] pid_max: default: 32768 minimum: 301
[    0.165920] Mount-cache hash table entries: 2048 (order: 0, 16384 bytes)
[    0.166244] Mountpoint-cache hash table entries: 2048 (order: 0,
16384 bytes)
[    0.202498] Brought up 1 CPUs
[    0.213199] devtmpfs: initialized
[    0.228877] clocksource: jiffies: mask: 0xffffffff max_cycles:
0xffffffff, max_idle_ns: 19112604462750000 ns
[    0.236181] NET: Registered protocol family 16
[    0.253496] clocksource: pit: mask: 0xffffffff max_cycles:
0xffffffff, max_idle_ns: 1601818034827 ns
[    0.254012] pm-cps: no CM, non-coherent states unavailable
[    0.257508] ------------[ cut here ]------------
[    0.258085] WARNING: CPU: 0 PID: 1 at fs/kernfs/dir.c:502
__kernfs_remove+0x250/0x258
[    0.258489] Modules linked in:
[   21.494186] INFO: rcu_sched detected stalls on CPUs/tasks:
[   21.494530]  (detected by 0, t=2102 jiffies, g=-299, c=-300, q=1)
[   21.494921] All QSes seen, last rcu_sched kthread activity 2101
(4294939419-4294937318), jiffies_till_next_fqs=1, root ->qsmask 0x0
[   21.495583] swapper/0       R  running task        0     1      0
0x00100004
[   21.496028] Stack : 000000000000001d 0000000000000004
ffffffff80790000 ffffffff80820000
          0000000000000000 0000000000000000 000000000000001d
0000000000000002
          ffffffff80820000 ffffffff80170c70 0000000000000000
0000000000000000
          0000000000000000 ffffffff80822328 0000000000000001
ffffffff80822328
          9800000007052fc0 ffffffff80780000 ffffffff8078e340
ffffffff8078e340
          ffffffff80780000 ffffffff80780000 ffffffff80781010
ffffffff8078e540
          0000000000000000 0000000000000000 0000000000000000
0000000000000000
          0000000000000000 98000000070577b0 0000000000000000
ffffffff80182a64
          0000000000000000 0000000000000000 0000000000100004
9800000007052fc0
          ffffffff80780000 ffffffff8010c460 9800000001082f80
ffffffff80182a64
          ...
[   21.498954] Call Trace:
[   21.499132] [<ffffffff8010c460>] show_stack+0x80/0xa0
[   21.499520] [<ffffffff80182a64>] rcu_check_callbacks+0x804/0x810
[   21.499744] [<ffffffff80185360>] update_process_times+0x38/0x70
[   21.499981] [<ffffffff80193c34>] tick_handle_periodic+0x2c/0xa8
[   21.500215] [<ffffffff801114b4>] c0_compare_interrupt+0x74/0xb8
[   21.500451] [<ffffffff80172e18>] handle_irq_event_percpu+0x80/0x1a0
[   21.500707] [<ffffffff801775ac>] handle_percpu_irq+0x7c/0xb8
[   21.500935] [<ffffffff80172308>] generic_handle_irq+0x38/0x48
[   21.501176] [<ffffffff80108010>] do_IRQ+0x18/0x28
[   21.501369] [<ffffffff803746c4>] plat_irq_dispatch+0x64/0xa0
[   21.501606] [<ffffffff80106370>] ret_from_irq+0x0/0x4
[   21.501868] [<ffffffff8034573c>] dump_stack+0x6c/0xd0
[   21.502068] [<ffffffff8012d088>] __warn+0xf0/0x108
[   21.502268] [<ffffffff80269e78>] __kernfs_remove+0x250/0x258
[   21.502519] [<ffffffff8026ae38>] kernfs_remove_by_name_ns+0x48/0xb0
[   21.502771] [<ffffffff8026dc44>] remove_files.isra.0+0x44/0x98
[   21.503003] [<ffffffff8026e034>] sysfs_remove_group+0x4c/0xc0
[   21.503339] [<ffffffff807cbc18>] param_sysfs_init+0x178/0x1f0
[   21.503605] [<ffffffff80100564>] do_one_initcall+0x3c/0x148
[   21.503830] [<ffffffff807c4b38>] kernel_init_freeable+0x15c/0x210
[   21.504075] [<ffffffff80619cd0>] kernel_init+0x10/0xf8
[   21.504324] [<ffffffff801063b8>] ret_from_kernel_thread+0x14/0x1c
[   21.504683]
[   21.504843] rcu_sched kthread starved for 2101 jiffies!
g18446744073709551317 c18446744073709551316 f0x2 RCU_GP_WAIT_FQS(3)
->state=0x0
[   21.505320] rcu_sched       R  running task        0     7      2
0x00100000
[   21.505639] Stack : ffffffff8078e5a8 ffffffffffff00fe
000000000234fb95 0000000000000000
          0000000000000117 000000000005fcb4 00000000ffff8ae7
980000000107e600
          980000000107e600 ffffffff80780000 ffffffff80781010
ffffffff80790000
          0000000000000000 0000000000000001 0000000000000003
ffffffff8061b2b4
          0000000000000000 ffffffff8061dbac 0000000000000200
0000000000000000
          00000000ffff8ae7 ffffffff80183fa8 9800000007093000
ffffffff00000000
          0000000000000001 9800000001082f80 ffffffff8078e340
ffffffff8078e340
          ffffffff8078e5a0 ffffffff80780000 ffffffff80780000
ffffffff80181a98
          9800000007093000 9800000007097d58 9800000007097d58
0000000000000000
          0000000000000001 ffffffff80180000 ffffffff8017f140
ffffffff806e0000
          ...
[   21.508301] Call Trace:
[   21.508413] [<ffffffff8061ae28>] __schedule+0x4c8/0x930
[   21.508668] [<ffffffff8061b2b4>] schedule+0x24/0x80
[   21.508892] [<ffffffff8061dbac>] schedule_timeout+0x11c/0x1e0
[   21.509121] [<ffffffff80181a98>] rcu_gp_kthread+0x510/0x948
[   21.509349] [<ffffffff8014a9c8>] kthread+0xc8/0xe0
[   21.509555] [<ffffffff801063b8>] ret_from_kernel_thread+0x14/0x1c
[   21.509794]
^C
qemu-system-mips64el.bad: terminating on signal 2

When using '-d in_asm' I see timer interrupts are delivered and handler
executed, before the rcu_sched detects the cpu stalling.


Console output from the previous commit (330edfcc):

Linux version 4.7.0-rc1 (@859affe05464) (gcc version 6.3.0 20170516
(Debian 6.3.0-18) ) #2 SMP Sat Feb 1 18:16:17 UTC 2020
GCRs appear to have been moved (expected them at 0x1fbf8000)!
earlycon: uart8250 at I/O port 0x3f8 (options '38400n8')
bootconsole [uart8250] enabled
MIPS CPS SMP unable to proceed without a CM
CPU0 revision is: 0001a900 (MIPS I6400)
FPU revision is: 20f30300
MSA revision is: 00000300
MIPS: machine is mti,malta
Software DMA cache coherency enabled
Determined physical RAM map:
 memory: 0000000008000000 @ 0000000000000000 (usable)
Zone ranges:
  DMA      [mem 0x0000000000000000-0x0000000000ffffff]
  DMA32    [mem 0x0000000001000000-0x00000000ffffffff]
  Normal   empty
Movable zone start for each node
Early memory node ranges
  node   0: [mem 0x0000000000000000-0x0000000007ffffff]
Initmem setup node 0 [mem 0x0000000000000000-0x0000000007ffffff]
Primary instruction cache 64kB, VIPT, 4-way, linesize 64 bytes.
Primary data cache 64kB, 4-way, VIPT, no aliases, linesize 64 bytes
percpu: Embedded 5 pages/cpu @980000000107c000 s29664 r8192 d44064 u81920
Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 8163
Kernel command line: clocksource=GIC console=ttyS0 printk.time=1
[    0.000000] PID hash table entries: 512 (order: -2, 4096 bytes)
[    0.000000] Dentry cache hash table entries: 16384 (order: 3, 131072
bytes)
[    0.000000] Inode-cache hash table entries: 8192 (order: 2, 65536 bytes)
[    0.000000] Writing ErrCtl register=00000000
[    0.000000] Readback ErrCtl register=00000000
[    0.000000] MAAR configuration:
[    0.000000]   [0]: 0x0000000000010000-0x0000000007ffffff speculate
[    0.000000]   [1]: disabled
[    0.000000]   [2]: disabled
[    0.000000]   [3]: disabled
[    0.000000]   [4]: disabled
[    0.000000]   [5]: disabled
[    0.000000]   [6]: disabled
[    0.000000]   [7]: disabled
[    0.000000] Memory: 121728K/131072K available (5253K kernel code,
380K rwdata, 1276K rodata, 304K init, 278K bss, 9344K reserved, 0K
cma-reserved)
[    0.000000] Hierarchical RCU implementation.
[    0.000000]  Build-time adjustment of leaf fanout to 64.
[    0.000000]  RCU restricting CPUs from NR_CPUS=8 to nr_cpu_ids=1.
[    0.000000] RCU: Adjusting geometry for rcu_fanout_leaf=64, nr_cpu_ids=1
[    0.000000] NR_IRQS:256
[    0.000000] CPU frequency 200.00 MHz
[    0.000000] clocksource: MIPS: mask: 0xffffffff max_cycles:
0xffffffff, max_idle_ns: 19112606563 ns
[    0.000227] sched_clock: 32 bits at 99MHz, resolution 10ns, wraps
every 21474838522ns
[    0.008164] Console: colour dummy device 80x25
[    0.012438] Calibrating delay loop... 910.13 BogoMIPS (lpj=4550656)
[    0.153536] pid_max: default: 32768 minimum: 301
[    0.155594] Mount-cache hash table entries: 2048 (order: 0, 16384 bytes)
[    0.156021] Mountpoint-cache hash table entries: 2048 (order: 0,
16384 bytes)
[    0.192797] Brought up 1 CPUs
[    0.203257] devtmpfs: initialized
[    0.217846] clocksource: jiffies: mask: 0xffffffff max_cycles:
0xffffffff, max_idle_ns: 19112604462750000 ns
[    0.224678] NET: Registered protocol family 16
[    0.242230] clocksource: pit: mask: 0xffffffff max_cycles:
0xffffffff, max_idle_ns: 1601818034827 ns
[    0.242911] pm-cps: no CM, non-coherent states unavailable
[    0.294752] vgaarb: loaded
[    0.296299] SCSI subsystem initialized
[    0.301656] PCI host bridge to bus 0000:00
[    0.302541] pci_bus 0000:00: root bus resource [mem
0x10000000-0x17ffffff]
[    0.303066] pci_bus 0000:00: root bus resource [io  0x1000-0x1fffff]
[    0.303567] pci_bus 0000:00: root bus resource [??? 0x00000000 flags 0x0]
[    0.304037] pci_bus 0000:00: No busn resource found for root bus,
will use [bus 00-ff]
[    0.306645] pci 0000:00:00.0: [Firmware Bug]: reg 0x14: invalid BAR
(can't size)
[    0.307287] pci 0000:00:00.0: [Firmware Bug]: reg 0x18: invalid BAR
(can't size)
[    0.307732] pci 0000:00:00.0: [Firmware Bug]: reg 0x1c: invalid BAR
(can't size)
[    0.308191] pci 0000:00:00.0: [Firmware Bug]: reg 0x20: invalid BAR
(can't size)
[    0.308683] pci 0000:00:00.0: [Firmware Bug]: reg 0x24: invalid BAR
(can't size)
[    0.312906] pci 0000:00:0a.1: legacy IDE quirk: reg 0x10: [io
0x01f0-0x01f7]
[    0.313321] pci 0000:00:0a.1: legacy IDE quirk: reg 0x14: [io  0x03f6]
[    0.313834] pci 0000:00:0a.1: legacy IDE quirk: reg 0x18: [io
0x0170-0x0177]
[    0.314301] pci 0000:00:0a.1: legacy IDE quirk: reg 0x1c: [io  0x0376]
[    0.316353] pci 0000:00:0a.3: quirk: [io  0x1000-0x103f] claimed by
PIIX4 ACPI
[    0.316796] pci 0000:00:0a.3: quirk: [io  0x1100-0x110f] claimed by
PIIX4 SMB
[    0.318865] vgaarb: device added:
PCI:0000:00:12.0,decodes=io+mem,owns=none,locks=none
[    0.321353] pci 0000:00:12.0: BAR 0: assigned [mem
0x10000000-0x11ffffff pref]
[    0.322118] pci 0000:00:0b.0: BAR 6: assigned [mem
0x12000000-0x1203ffff pref]
[    0.322655] pci 0000:00:12.0: BAR 6: assigned [mem
0x12040000-0x1204ffff pref]
[    0.323124] pci 0000:00:12.0: BAR 1: assigned [mem 0x12050000-0x12050fff]
[    0.323594] pci 0000:00:0a.2: BAR 4: assigned [io  0x1040-0x105f]
[    0.323984] pci 0000:00:0b.0: BAR 0: assigned [io  0x1060-0x107f]
[    0.324368] pci 0000:00:0b.0: BAR 1: assigned [mem 0x12051000-0x1205101f]
[    0.324787] pci 0000:00:0a.1: BAR 4: assigned [io  0x1080-0x108f]
[    0.342630] clocksource: Switched to clocksource MIPS
[    0.344235] VFS: Disk quotas dquot_6.6.0
[    0.344890] VFS: Dquot-cache hash table entries: 2048 (order 0, 16384
bytes)
[    0.386512] NET: Registered protocol family 2
[    0.398836] TCP established hash table entries: 2048 (order: 0, 16384
bytes)
[    0.400383] TCP bind hash table entries: 2048 (order: 1, 32768 bytes)
[    0.400907] TCP: Hash tables configured (established 2048 bind 2048)
[    0.402979] UDP hash table entries: 512 (order: 0, 16384 bytes)
[    0.403480] UDP-Lite hash table entries: 512 (order: 0, 16384 bytes)
[    0.406146] NET: Registered protocol family 1
[    0.410131] RPC: Registered named UNIX socket transport module.
[    0.410481] RPC: Registered udp transport module.
[    0.410723] RPC: Registered tcp transport module.
[    0.410969] RPC: Registered tcp NFSv4.1 backchannel transport module.
[    0.418784] futex hash table entries: 256 (order: 0, 16384 bytes)
[    0.423787] workingset: timestamp_bits=60 max_order=13 bucket_order=0
[    0.427615] Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
[    0.432664] Block layer SCSI generic (bsg) driver version 0.4 loaded
(major 253)
[    0.433193] io scheduler noop registered
[    0.433428] io scheduler deadline registered
[    0.433795] io scheduler cfq registered (default)
[    0.436019] PCI: Enabling device 0000:00:12.0 (0000 -> 0002)
[    0.437688] cirrusfb 0000:00:12.0: Cirrus Logic chipset on PCI bus,
RAM (4096 kB) at 0x10000000
[    0.693879] Console: switching to colour frame buffer device 80x30
[    0.890253] Serial: 8250/16550 driver, 4 ports, IRQ sharing disabled
[    0.900232] console [ttyS0] disabled
[    0.931815] serial8250.0: ttyS0 at I/O 0x3f8 (irq = 4, base_baud =
115200) is a 16550A
[    0.934068] console [ttyS0] enabled
[    0.934068] console [ttyS0] enabled
[    0.934866] bootconsole [uart8250] disabled
[    0.934866] bootconsole [uart8250] disabled
[    0.963488] serial8250.0: ttyS1 at I/O 0x2f8 (irq = 3, base_baud =
115200) is a 16550A
[    0.991024] serial8250.0: ttyS2 at MMIO 0x1f000900 (irq = 20,
base_baud = 230400) is a 16550A
[    0.993376] [drm] Initialized drm 1.1.0 20060810
[    1.035413] brd: module loaded
[    1.036869] PCI: Enabling device 0000:00:0a.1 (0000 -> 0001)
[    1.052237] scsi host0: ata_piix
[    1.055459] scsi host1: ata_piix
[    1.056457] ata1: PATA max UDMA/33 cmd 0x1f0 ctl 0x3f6 bmdma 0x1080
irq 14
[    1.056967] ata2: PATA max UDMA/33 cmd 0x170 ctl 0x376 bmdma 0x1088
irq 15
[    1.060000] physmap platform flash device: 00400000 at 1e000000
[    1.063974] physmap-flash.0: Found 1 x32 devices at 0x0 in 32-bit
bank. Manufacturer ID 0x000000 Chip ID 0x000000
[    1.065202] Intel/Sharp Extended Query Table at 0x0031
[    1.066817] Using buffer write method
[    1.080256] Creating 3 MTD partitions on "physmap-flash.0":
[    1.081618] 0x000000000000-0x000000100000 : "YAMON"
[    1.088644] 0x000000100000-0x0000003e0000 : "User FS"
[    1.091480] 0x0000003e0000-0x000000400000 : "Board Config"
[    1.094277] pcnet32: pcnet32.c:v1.35 21.Apr.2008
tsbogend@alpha.franken.de
[    1.094891] PCI: Enabling device 0000:00:0b.0 (0000 -> 0003)
[    1.096781] pcnet32: PCnet/PCI II 79C970A at 0x1060,
52:54:00:12:34:56 assigned IRQ 10
[    1.100991] pcnet32: eth0: registered as PCnet/PCI II 79C970A
[    1.101594] pcnet32: 1 cards_found
[    1.104245] mousedev: PS/2 mouse device common for all mice
[    1.107521] rtc_cmos rtc_cmos: rtc core: registered rtc_cmos as rtc0
[    1.108464] rtc_cmos rtc_cmos: alarms up to one day, 242 bytes nvram
[    1.111009] NET: Registered protocol family 10
[    1.121232] sit: IPv6 over IPv4 tunneling driver
[    1.124784] NET: Registered protocol family 17
[    1.125362] NET: Registered protocol family 15
[    1.135855] rtc_cmos rtc_cmos: setting system clock to 2020-02-01
20:08:10 UTC (1580587690)
[    1.328785] ata2.00: ATAPI: QEMU DVD-ROM, 2.5+, max UDMA/100
[    1.335399] ata2.00: configured for UDMA/33
[    1.377344] scsi 1:0:0:0: CD-ROM            QEMU     QEMU DVD-ROM
 2.5+ PQ: 0 ANSI: 5
[    1.407242] sr 1:0:0:0: [sr0] scsi3-mmc drive: 4x/4x cd/rw xa/form2 tray
[    1.409546] cdrom: Uniform CD-ROM driver Revision: 3.20
...

When booting

The kernel I'm using is available here:
https://github.com/philmd/qemu-testing-blob/tree/malta_i6400/mips/malta/mips64el

It is built following the steps from:
https://www.mips.com/blog/how-to-run-smp-linux-in-qemu-on-a-mips64-release-6-cpu/
You can rebuild using docker anyway:
https://github.com/philmd/qemu-testing-blob/blob/malta_i6400/mips/malta/mips64el/Dockerfile

> Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>
> Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/mips/cpu.h       |   4 -
>  target/mips/op_helper.c | 182 +++++++++++++---------------------------
>  2 files changed, 60 insertions(+), 126 deletions(-)
> 
> diff --git a/target/mips/cpu.h b/target/mips/cpu.h
> index ca00f41daf..c218ccc4a8 100644
> --- a/target/mips/cpu.h
> +++ b/target/mips/cpu.h
> @@ -1147,10 +1147,6 @@ extern uint32_t cpu_rddsp(uint32_t mask_num, CPUMIPSState *env);
>   * MMU modes definitions. We carefully match the indices with our
>   * hflags layout.
>   */
> -#define MMU_MODE0_SUFFIX _kernel
> -#define MMU_MODE1_SUFFIX _super
> -#define MMU_MODE2_SUFFIX _user
> -#define MMU_MODE3_SUFFIX _error
>  #define MMU_USER_IDX 2
>  
>  static inline int hflags_mmu_index(uint32_t hflags)
> diff --git a/target/mips/op_helper.c b/target/mips/op_helper.c
> index 18fcee4a78..79d44da6fa 100644
> --- a/target/mips/op_helper.c
> +++ b/target/mips/op_helper.c
> @@ -52,69 +52,6 @@ static void raise_exception(CPUMIPSState *env, uint32_t exception)
>      do_raise_exception(env, exception, 0);
>  }
>  
> -#if defined(CONFIG_USER_ONLY)
> -#define HELPER_LD(name, insn, type)                                     \
> -static inline type do_##name(CPUMIPSState *env, target_ulong addr,      \
> -                             int mem_idx, uintptr_t retaddr)            \
> -{                                                                       \
> -    return (type) cpu_##insn##_data_ra(env, addr, retaddr);             \
> -}
> -#else
> -#define HELPER_LD(name, insn, type)                                     \
> -static inline type do_##name(CPUMIPSState *env, target_ulong addr,      \
> -                             int mem_idx, uintptr_t retaddr)            \
> -{                                                                       \
> -    switch (mem_idx) {                                                  \
> -    case 0: return (type) cpu_##insn##_kernel_ra(env, addr, retaddr);   \
> -    case 1: return (type) cpu_##insn##_super_ra(env, addr, retaddr);    \
> -    default:                                                            \
> -    case 2: return (type) cpu_##insn##_user_ra(env, addr, retaddr);     \
> -    case 3: return (type) cpu_##insn##_error_ra(env, addr, retaddr);    \
> -    }                                                                   \
> -}
> -#endif
> -HELPER_LD(lw, ldl, int32_t)
> -#if defined(TARGET_MIPS64)
> -HELPER_LD(ld, ldq, int64_t)
> -#endif
> -#undef HELPER_LD
> -
> -#if defined(CONFIG_USER_ONLY)
> -#define HELPER_ST(name, insn, type)                                     \
> -static inline void do_##name(CPUMIPSState *env, target_ulong addr,      \
> -                             type val, int mem_idx, uintptr_t retaddr)  \
> -{                                                                       \
> -    cpu_##insn##_data_ra(env, addr, val, retaddr);                      \
> -}
> -#else
> -#define HELPER_ST(name, insn, type)                                     \
> -static inline void do_##name(CPUMIPSState *env, target_ulong addr,      \
> -                             type val, int mem_idx, uintptr_t retaddr)  \
> -{                                                                       \
> -    switch (mem_idx) {                                                  \
> -    case 0:                                                             \
> -        cpu_##insn##_kernel_ra(env, addr, val, retaddr);                \
> -        break;                                                          \
> -    case 1:                                                             \
> -        cpu_##insn##_super_ra(env, addr, val, retaddr);                 \
> -        break;                                                          \
> -    default:                                                            \
> -    case 2:                                                             \
> -        cpu_##insn##_user_ra(env, addr, val, retaddr);                  \
> -        break;                                                          \
> -    case 3:                                                             \
> -        cpu_##insn##_error_ra(env, addr, val, retaddr);                 \
> -        break;                                                          \
> -    }                                                                   \
> -}
> -#endif
> -HELPER_ST(sb, stb, uint8_t)
> -HELPER_ST(sw, stl, uint32_t)
> -#if defined(TARGET_MIPS64)
> -HELPER_ST(sd, stq, uint64_t)
> -#endif
> -#undef HELPER_ST
> -
>  /* 64 bits arithmetic for 32 bits hosts */
>  static inline uint64_t get_HILO(CPUMIPSState *env)
>  {
> @@ -379,12 +316,12 @@ target_ulong helper_##name(CPUMIPSState *env, target_ulong arg, int mem_idx)  \
>      }                                                                         \
>      env->CP0_LLAddr = do_translate_address(env, arg, 0, GETPC());             \
>      env->lladdr = arg;                                                        \
> -    env->llval = do_##insn(env, arg, mem_idx, GETPC());                       \
> +    env->llval = cpu_##insn##_mmuidx_ra(env, arg, mem_idx, GETPC());          \
>      return env->llval;                                                        \
>  }
> -HELPER_LD_ATOMIC(ll, lw, 0x3)
> +HELPER_LD_ATOMIC(ll, ldl, 0x3)
>  #ifdef TARGET_MIPS64
> -HELPER_LD_ATOMIC(lld, ld, 0x7)
> +HELPER_LD_ATOMIC(lld, ldq, 0x7)
>  #endif
>  #undef HELPER_LD_ATOMIC
>  #endif
> @@ -400,42 +337,42 @@ HELPER_LD_ATOMIC(lld, ld, 0x7)
>  void helper_swl(CPUMIPSState *env, target_ulong arg1, target_ulong arg2,
>                  int mem_idx)
>  {
> -    do_sb(env, arg2, (uint8_t)(arg1 >> 24), mem_idx, GETPC());
> +    cpu_stb_mmuidx_ra(env, arg2, (uint8_t)(arg1 >> 24), mem_idx, GETPC());
>  
>      if (GET_LMASK(arg2) <= 2) {
> -        do_sb(env, GET_OFFSET(arg2, 1), (uint8_t)(arg1 >> 16), mem_idx,
> -              GETPC());
> +        cpu_stb_mmuidx_ra(env, GET_OFFSET(arg2, 1), (uint8_t)(arg1 >> 16),
> +                          mem_idx, GETPC());
>      }
>  
>      if (GET_LMASK(arg2) <= 1) {
> -        do_sb(env, GET_OFFSET(arg2, 2), (uint8_t)(arg1 >> 8), mem_idx,
> -              GETPC());
> +        cpu_stb_mmuidx_ra(env, GET_OFFSET(arg2, 2), (uint8_t)(arg1 >> 8),
> +                          mem_idx, GETPC());
>      }
>  
>      if (GET_LMASK(arg2) == 0) {
> -        do_sb(env, GET_OFFSET(arg2, 3), (uint8_t)arg1, mem_idx,
> -              GETPC());
> +        cpu_stb_mmuidx_ra(env, GET_OFFSET(arg2, 3), (uint8_t)arg1,
> +                          mem_idx, GETPC());
>      }
>  }
>  
>  void helper_swr(CPUMIPSState *env, target_ulong arg1, target_ulong arg2,
>                  int mem_idx)
>  {
> -    do_sb(env, arg2, (uint8_t)arg1, mem_idx, GETPC());
> +    cpu_stb_mmuidx_ra(env, arg2, (uint8_t)arg1, mem_idx, GETPC());
>  
>      if (GET_LMASK(arg2) >= 1) {
> -        do_sb(env, GET_OFFSET(arg2, -1), (uint8_t)(arg1 >> 8), mem_idx,
> -              GETPC());
> +        cpu_stb_mmuidx_ra(env, GET_OFFSET(arg2, -1), (uint8_t)(arg1 >> 8),
> +                          mem_idx, GETPC());
>      }
>  
>      if (GET_LMASK(arg2) >= 2) {
> -        do_sb(env, GET_OFFSET(arg2, -2), (uint8_t)(arg1 >> 16), mem_idx,
> -              GETPC());
> +        cpu_stb_mmuidx_ra(env, GET_OFFSET(arg2, -2), (uint8_t)(arg1 >> 16),
> +                          mem_idx, GETPC());
>      }
>  
>      if (GET_LMASK(arg2) == 3) {
> -        do_sb(env, GET_OFFSET(arg2, -3), (uint8_t)(arg1 >> 24), mem_idx,
> -              GETPC());
> +        cpu_stb_mmuidx_ra(env, GET_OFFSET(arg2, -3), (uint8_t)(arg1 >> 24),
> +                          mem_idx, GETPC());
>      }
>  }
>  
> @@ -453,82 +390,82 @@ void helper_swr(CPUMIPSState *env, target_ulong arg1, target_ulong arg2,
>  void helper_sdl(CPUMIPSState *env, target_ulong arg1, target_ulong arg2,
>                  int mem_idx)
>  {
> -    do_sb(env, arg2, (uint8_t)(arg1 >> 56), mem_idx, GETPC());
> +    cpu_stb_mmuidx_ra(env, arg2, (uint8_t)(arg1 >> 56), mem_idx, GETPC());
>  
>      if (GET_LMASK64(arg2) <= 6) {
> -        do_sb(env, GET_OFFSET(arg2, 1), (uint8_t)(arg1 >> 48), mem_idx,
> -              GETPC());
> +        cpu_stb_mmuidx_ra(env, GET_OFFSET(arg2, 1), (uint8_t)(arg1 >> 48),
> +                          mem_idx, GETPC());
>      }
>  
>      if (GET_LMASK64(arg2) <= 5) {
> -        do_sb(env, GET_OFFSET(arg2, 2), (uint8_t)(arg1 >> 40), mem_idx,
> -              GETPC());
> +        cpu_stb_mmuidx_ra(env, GET_OFFSET(arg2, 2), (uint8_t)(arg1 >> 40),
> +                          mem_idx, GETPC());
>      }
>  
>      if (GET_LMASK64(arg2) <= 4) {
> -        do_sb(env, GET_OFFSET(arg2, 3), (uint8_t)(arg1 >> 32), mem_idx,
> -              GETPC());
> +        cpu_stb_mmuidx_ra(env, GET_OFFSET(arg2, 3), (uint8_t)(arg1 >> 32),
> +                          mem_idx, GETPC());
>      }
>  
>      if (GET_LMASK64(arg2) <= 3) {
> -        do_sb(env, GET_OFFSET(arg2, 4), (uint8_t)(arg1 >> 24), mem_idx,
> -              GETPC());
> +        cpu_stb_mmuidx_ra(env, GET_OFFSET(arg2, 4), (uint8_t)(arg1 >> 24),
> +                          mem_idx, GETPC());
>      }
>  
>      if (GET_LMASK64(arg2) <= 2) {
> -        do_sb(env, GET_OFFSET(arg2, 5), (uint8_t)(arg1 >> 16), mem_idx,
> -              GETPC());
> +        cpu_stb_mmuidx_ra(env, GET_OFFSET(arg2, 5), (uint8_t)(arg1 >> 16),
> +                          mem_idx, GETPC());
>      }
>  
>      if (GET_LMASK64(arg2) <= 1) {
> -        do_sb(env, GET_OFFSET(arg2, 6), (uint8_t)(arg1 >> 8), mem_idx,
> -              GETPC());
> +        cpu_stb_mmuidx_ra(env, GET_OFFSET(arg2, 6), (uint8_t)(arg1 >> 8),
> +                          mem_idx, GETPC());
>      }
>  
>      if (GET_LMASK64(arg2) <= 0) {
> -        do_sb(env, GET_OFFSET(arg2, 7), (uint8_t)arg1, mem_idx,
> -              GETPC());
> +        cpu_stb_mmuidx_ra(env, GET_OFFSET(arg2, 7), (uint8_t)arg1,
> +                          mem_idx, GETPC());
>      }
>  }
>  
>  void helper_sdr(CPUMIPSState *env, target_ulong arg1, target_ulong arg2,
>                  int mem_idx)
>  {
> -    do_sb(env, arg2, (uint8_t)arg1, mem_idx, GETPC());
> +    cpu_stb_mmuidx_ra(env, arg2, (uint8_t)arg1, mem_idx, GETPC());
>  
>      if (GET_LMASK64(arg2) >= 1) {
> -        do_sb(env, GET_OFFSET(arg2, -1), (uint8_t)(arg1 >> 8), mem_idx,
> -              GETPC());
> +        cpu_stb_mmuidx_ra(env, GET_OFFSET(arg2, -1), (uint8_t)(arg1 >> 8),
> +                          mem_idx, GETPC());
>      }
>  
>      if (GET_LMASK64(arg2) >= 2) {
> -        do_sb(env, GET_OFFSET(arg2, -2), (uint8_t)(arg1 >> 16), mem_idx,
> -              GETPC());
> +        cpu_stb_mmuidx_ra(env, GET_OFFSET(arg2, -2), (uint8_t)(arg1 >> 16),
> +                          mem_idx, GETPC());
>      }
>  
>      if (GET_LMASK64(arg2) >= 3) {
> -        do_sb(env, GET_OFFSET(arg2, -3), (uint8_t)(arg1 >> 24), mem_idx,
> -              GETPC());
> +        cpu_stb_mmuidx_ra(env, GET_OFFSET(arg2, -3), (uint8_t)(arg1 >> 24),
> +                          mem_idx, GETPC());
>      }
>  
>      if (GET_LMASK64(arg2) >= 4) {
> -        do_sb(env, GET_OFFSET(arg2, -4), (uint8_t)(arg1 >> 32), mem_idx,
> -              GETPC());
> +        cpu_stb_mmuidx_ra(env, GET_OFFSET(arg2, -4), (uint8_t)(arg1 >> 32),
> +                          mem_idx, GETPC());
>      }
>  
>      if (GET_LMASK64(arg2) >= 5) {
> -        do_sb(env, GET_OFFSET(arg2, -5), (uint8_t)(arg1 >> 40), mem_idx,
> -              GETPC());
> +        cpu_stb_mmuidx_ra(env, GET_OFFSET(arg2, -5), (uint8_t)(arg1 >> 40),
> +                          mem_idx, GETPC());
>      }
>  
>      if (GET_LMASK64(arg2) >= 6) {
> -        do_sb(env, GET_OFFSET(arg2, -6), (uint8_t)(arg1 >> 48), mem_idx,
> -              GETPC());
> +        cpu_stb_mmuidx_ra(env, GET_OFFSET(arg2, -6), (uint8_t)(arg1 >> 48),
> +                          mem_idx, GETPC());
>      }
>  
>      if (GET_LMASK64(arg2) == 7) {
> -        do_sb(env, GET_OFFSET(arg2, -7), (uint8_t)(arg1 >> 56), mem_idx,
> -              GETPC());
> +        cpu_stb_mmuidx_ra(env, GET_OFFSET(arg2, -7), (uint8_t)(arg1 >> 56),
> +                          mem_idx, GETPC());
>      }
>  }
>  #endif /* TARGET_MIPS64 */
> @@ -546,14 +483,14 @@ void helper_lwm(CPUMIPSState *env, target_ulong addr, target_ulong reglist,
>  
>          for (i = 0; i < base_reglist; i++) {
>              env->active_tc.gpr[multiple_regs[i]] =
> -                (target_long)do_lw(env, addr, mem_idx, GETPC());
> +                (target_long)cpu_ldl_mmuidx_ra(env, addr, mem_idx, GETPC());
>              addr += 4;
>          }
>      }
>  
>      if (do_r31) {
> -        env->active_tc.gpr[31] = (target_long)do_lw(env, addr, mem_idx,
> -                                                    GETPC());
> +        env->active_tc.gpr[31] =
> +            (target_long)cpu_ldl_mmuidx_ra(env, addr, mem_idx, GETPC());
>      }
>  }
>  
> @@ -567,14 +504,14 @@ void helper_swm(CPUMIPSState *env, target_ulong addr, target_ulong reglist,
>          target_ulong i;
>  
>          for (i = 0; i < base_reglist; i++) {
> -            do_sw(env, addr, env->active_tc.gpr[multiple_regs[i]], mem_idx,
> -                  GETPC());
> +            cpu_stw_mmuidx_ra(env, addr, env->active_tc.gpr[multiple_regs[i]],
> +                              mem_idx, GETPC());
>              addr += 4;
>          }
>      }
>  
>      if (do_r31) {
> -        do_sw(env, addr, env->active_tc.gpr[31], mem_idx, GETPC());
> +        cpu_stw_mmuidx_ra(env, addr, env->active_tc.gpr[31], mem_idx, GETPC());
>      }
>  }
>  
> @@ -589,14 +526,15 @@ void helper_ldm(CPUMIPSState *env, target_ulong addr, target_ulong reglist,
>          target_ulong i;
>  
>          for (i = 0; i < base_reglist; i++) {
> -            env->active_tc.gpr[multiple_regs[i]] = do_ld(env, addr, mem_idx,
> -                                                         GETPC());
> +            env->active_tc.gpr[multiple_regs[i]] =
> +                cpu_ldq_mmuidx_ra(env, addr, mem_idx, GETPC());
>              addr += 8;
>          }
>      }
>  
>      if (do_r31) {
> -        env->active_tc.gpr[31] = do_ld(env, addr, mem_idx, GETPC());
> +        env->active_tc.gpr[31] =
> +            cpu_ldq_mmuidx_ra(env, addr, mem_idx, GETPC());
>      }
>  }
>  
> @@ -610,14 +548,14 @@ void helper_sdm(CPUMIPSState *env, target_ulong addr, target_ulong reglist,
>          target_ulong i;
>  
>          for (i = 0; i < base_reglist; i++) {
> -            do_sd(env, addr, env->active_tc.gpr[multiple_regs[i]], mem_idx,
> -                  GETPC());
> +            cpu_stq_mmuidx_ra(env, addr, env->active_tc.gpr[multiple_regs[i]],
> +                              mem_idx, GETPC());
>              addr += 8;
>          }
>      }
>  
>      if (do_r31) {
> -        do_sd(env, addr, env->active_tc.gpr[31], mem_idx, GETPC());
> +        cpu_stq_mmuidx_ra(env, addr, env->active_tc.gpr[31], mem_idx, GETPC());
>      }
>  }
>  #endif
> 

