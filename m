Return-Path: <SRS0=CCzH=3V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CAC7C35249
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Feb 2020 22:08:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D0F8320643
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Feb 2020 22:08:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S5ilEkQ+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0F8320643
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51094 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iy0wR-0003gd-2b
	for qemu-devel@archiver.kernel.org; Sat, 01 Feb 2020 17:08:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35851)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iy0vY-000301-Ls
 for qemu-devel@nongnu.org; Sat, 01 Feb 2020 17:07:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iy0vT-0006Ys-1T
 for qemu-devel@nongnu.org; Sat, 01 Feb 2020 17:07:44 -0500
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:37709)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iy0vS-0006YQ-Hq
 for qemu-devel@nongnu.org; Sat, 01 Feb 2020 17:07:38 -0500
Received: by mail-wr1-x441.google.com with SMTP id w15so12993423wru.4
 for <qemu-devel@nongnu.org>; Sat, 01 Feb 2020 14:07:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:from:to:cc:references:autocrypt:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=F1kdGlmCkfxxIqfZcIv8K5LTOE3qH2kFOYxR4dBBUvI=;
 b=S5ilEkQ+JXQXblz+KoAQX0ZxRbcAwlqYLixeRsRUAeQoKJsCNkpU25sKoKRMJJYKC3
 DaSn58xKbDjhesXBnkDJC6OMf7JQTxuYWS3Aipni2Tcl/+C/uvucHCSJUru/jNrZGgbX
 WeLP5Yb2mn8D3gjVvB+bg7fkA7rT32nIgePquNh9R22KbUrzXbWHarYW0ORS2cifOKHj
 iVHrwFVtV8ZNmZk4kkmQVW+x/xcXH+4Ij6vJtMdZOIoBkvD/1+J+nhFgUQbOOaNx44jk
 QF+g9MGjJKSJsmm8Tge3roLd2tQWZLRhNjDqUTHh5aV0twHKjPd8unmd5MJdjB2j0LCR
 lUUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:from:to:cc:references:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=F1kdGlmCkfxxIqfZcIv8K5LTOE3qH2kFOYxR4dBBUvI=;
 b=pFhZLgIcNAKa4JLeVe+nKLUs1F2rjBAOvx344UNUoQsWWLz1Z2a44TE5tzRDbs35mU
 U7oFDP2MDGmf19cxJDaIY/NUbkcsswF537Gekdn4Bht64LxoVets0wtB8C0wr2QtN+fj
 DW3e3QzU66RWHbiFeO7dCnpDbOSeEKo7WEDZkBHI3ukOLqg1VRz2tbQEWAw4AlaqO+Ld
 v51Z7rfEFqEyKafXZqCm7J48UWfpFYPoZIFBA/JSpMlQqqhLfmOchgEvvOAttiWE7WjW
 n5vW345H394YGEgxJCSSvWj3GMsHAiP2lQPpuOQ0EdN/yvBYRH3uEX9erF2kO1+PG3sZ
 +3RA==
X-Gm-Message-State: APjAAAWQxC8e/MFWefs6Ca2jHYj+kwp8F9JT72xmjoo1qL2QBsiKnmGh
 KgTq9myTjS0vOx90lFpF+rU=
X-Google-Smtp-Source: APXvYqxMg09GdhmAHxw4i9cSR5qtrYD0re/lrQ/IODxrKrM25xSgwaWjAYQksqbnNy2T5IDjqC1y6Q==
X-Received: by 2002:adf:f0cb:: with SMTP id x11mr6073745wro.421.1580594856205; 
 Sat, 01 Feb 2020 14:07:36 -0800 (PST)
Received: from [192.168.1.35] (162.red-83-52-55.dynamicip.rima-tde.net.
 [83.52.55.162])
 by smtp.gmail.com with ESMTPSA id x6sm16331219wmi.44.2020.02.01.14.07.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 01 Feb 2020 14:07:35 -0800 (PST)
Subject: Re: [PULL 32/41] target/mips: Use cpu_*_mmuidx_ra instead of
 MMU_MODE*_SUFFIX
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
To: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
References: <20200108034523.17349-1-richard.henderson@linaro.org>
 <20200108034523.17349-33-richard.henderson@linaro.org>
 <7c714bf4-2e5c-c17b-5a06-72d63e06d3a4@amsat.org>
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
Message-ID: <51ba939f-b90f-0413-aa37-4af427bb63e3@amsat.org>
Date: Sat, 1 Feb 2020 23:07:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <7c714bf4-2e5c-c17b-5a06-72d63e06d3a4@amsat.org>
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

On 2/1/20 9:12 PM, Philippe Mathieu-Daudé wrote:
> Hi Richard,
> 
> On 1/8/20 4:45 AM, Richard Henderson wrote:
>> The separate suffixed functions were used to construct
>> some do_##insn function switched on mmu_idx.  The interface
>> is exactly identical to the *_mmuidx_ra functions.  Replace
>> them directly and remove the constructions.
>>
>> Cc: Aurelien Jarno <aurelien@aurel32.net>
>> Cc: Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>
>> Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> 
> I'm seeing a regression since commit 7dd547e5a (however I'm not sure
> this particular commit introduced the regression, or instead revealed it).
> 
> I get a hang when booting a I6400 CPU on Malta:
> 
> $ qemu-system-mips64el -cpu I6400 -serial stdio \
>   -kernel vmlinux \
>   -append "clocksource=GIC console=ttyS0 printk.time=1"

FYI this binary was built using:

  ./configure --target-list=mips64el-softmmu --disable-xen
--disable-spice --disable-vnc --disable-rdma --disable-vde --disable-rbd
--disable-smartcard --disable-libusb --disable-glusterfs --disable-tpm
--disable-vhdx --disable-tools --disable-guest-agent --disable-docs
--disable-vhost-vsock --extra-cflags='-Wno-format-truncation
-Wno-stringop-truncation -Wno-address-of-packed-member'

> Linux version 4.7.0-rc1 (@859affe05464) (gcc version 6.3.0 20170516
> (Debian 6.3.0-18) ) #2 SMP Sat Feb 1 18:16:17 UTC 2020
> GCRs appear to have been moved (expected them at 0x1fbf8000)!
> earlycon: uart8250 at I/O port 0x3f8 (options '38400n8')
> bootconsole [uart8250] enabled
> MIPS CPS SMP unable to proceed without a CM
> CPU0 revision is: 0001a900 (MIPS I6400)
> FPU revision is: 20f30300
> MSA revision is: 00000300
> MIPS: machine is mti,malta
> Software DMA cache coherency enabled
> Determined physical RAM map:
>  memory: 0000000008000000 @ 0000000000000000 (usable)
> Zone ranges:
>   DMA      [mem 0x0000000000000000-0x0000000000ffffff]
>   DMA32    [mem 0x0000000001000000-0x00000000ffffffff]
>   Normal   empty
> Movable zone start for each node
> Early memory node ranges
>   node   0: [mem 0x0000000000000000-0x0000000007ffffff]
> Initmem setup node 0 [mem 0x0000000000000000-0x0000000007ffffff]
> Primary instruction cache 64kB, VIPT, 4-way, linesize 64 bytes.
> Primary data cache 64kB, 4-way, VIPT, no aliases, linesize 64 bytes
> percpu: Embedded 5 pages/cpu @980000000107c000 s29664 r8192 d44064 u81920
> Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 8163
> Kernel command line: clocksource=GIC console=ttyS0 printk.time=1
> [    0.000000] PID hash table entries: 512 (order: -2, 4096 bytes)
> [    0.000000] Dentry cache hash table entries: 16384 (order: 3, 131072
> bytes)
> [    0.000000] Inode-cache hash table entries: 8192 (order: 2, 65536 bytes)
> [    0.000000] Writing ErrCtl register=00000000
> [    0.000000] Readback ErrCtl register=00000000
> [    0.000000] MAAR configuration:
> [    0.000000]   [0]: 0x0000000000010000-0x0000000007ffffff speculate
> [    0.000000]   [1]: disabled
> [    0.000000]   [2]: disabled
> [    0.000000]   [3]: disabled
> [    0.000000]   [4]: disabled
> [    0.000000]   [5]: disabled
> [    0.000000]   [6]: disabled
> [    0.000000]   [7]: disabled
> [    0.000000] Memory: 121728K/131072K available (5253K kernel code,
> 380K rwdata, 1276K rodata, 304K init, 278K bss, 9344K reserved, 0K
> cma-reserved)
> [    0.000000] Hierarchical RCU implementation.
> [    0.000000]  Build-time adjustment of leaf fanout to 64.
> [    0.000000]  RCU restricting CPUs from NR_CPUS=8 to nr_cpu_ids=1.
> [    0.000000] RCU: Adjusting geometry for rcu_fanout_leaf=64, nr_cpu_ids=1
> [    0.000000] NR_IRQS:256
> [    0.000000] CPU frequency 200.00 MHz
> [    0.000000] clocksource: MIPS: mask: 0xffffffff max_cycles:
> 0xffffffff, max_idle_ns: 19112598155 ns
> [    0.000223] sched_clock: 32 bits at 100MHz, resolution 9ns, wraps
> every 21474829307ns
> [    0.008011] Console: colour dummy device 80x25
> [    0.012181] Calibrating delay loop... 950.27 BogoMIPS (lpj=4751360)
> [    0.164015] pid_max: default: 32768 minimum: 301
> [    0.165920] Mount-cache hash table entries: 2048 (order: 0, 16384 bytes)
> [    0.166244] Mountpoint-cache hash table entries: 2048 (order: 0,
> 16384 bytes)
> [    0.202498] Brought up 1 CPUs
> [    0.213199] devtmpfs: initialized
> [    0.228877] clocksource: jiffies: mask: 0xffffffff max_cycles:
> 0xffffffff, max_idle_ns: 19112604462750000 ns
> [    0.236181] NET: Registered protocol family 16
> [    0.253496] clocksource: pit: mask: 0xffffffff max_cycles:
> 0xffffffff, max_idle_ns: 1601818034827 ns
> [    0.254012] pm-cps: no CM, non-coherent states unavailable
> [    0.257508] ------------[ cut here ]------------
> [    0.258085] WARNING: CPU: 0 PID: 1 at fs/kernfs/dir.c:502
> __kernfs_remove+0x250/0x258
> [    0.258489] Modules linked in:
> [   21.494186] INFO: rcu_sched detected stalls on CPUs/tasks:
> [   21.494530]  (detected by 0, t=2102 jiffies, g=-299, c=-300, q=1)
> [   21.494921] All QSes seen, last rcu_sched kthread activity 2101
> (4294939419-4294937318), jiffies_till_next_fqs=1, root ->qsmask 0x0
> [   21.495583] swapper/0       R  running task        0     1      0
> 0x00100004
> [   21.496028] Stack : 000000000000001d 0000000000000004
> ffffffff80790000 ffffffff80820000
>           0000000000000000 0000000000000000 000000000000001d
> 0000000000000002
>           ffffffff80820000 ffffffff80170c70 0000000000000000
> 0000000000000000
>           0000000000000000 ffffffff80822328 0000000000000001
> ffffffff80822328
>           9800000007052fc0 ffffffff80780000 ffffffff8078e340
> ffffffff8078e340
>           ffffffff80780000 ffffffff80780000 ffffffff80781010
> ffffffff8078e540
>           0000000000000000 0000000000000000 0000000000000000
> 0000000000000000
>           0000000000000000 98000000070577b0 0000000000000000
> ffffffff80182a64
>           0000000000000000 0000000000000000 0000000000100004
> 9800000007052fc0
>           ffffffff80780000 ffffffff8010c460 9800000001082f80
> ffffffff80182a64
>           ...
> [   21.498954] Call Trace:
> [   21.499132] [<ffffffff8010c460>] show_stack+0x80/0xa0
> [   21.499520] [<ffffffff80182a64>] rcu_check_callbacks+0x804/0x810
> [   21.499744] [<ffffffff80185360>] update_process_times+0x38/0x70
> [   21.499981] [<ffffffff80193c34>] tick_handle_periodic+0x2c/0xa8
> [   21.500215] [<ffffffff801114b4>] c0_compare_interrupt+0x74/0xb8
> [   21.500451] [<ffffffff80172e18>] handle_irq_event_percpu+0x80/0x1a0
> [   21.500707] [<ffffffff801775ac>] handle_percpu_irq+0x7c/0xb8
> [   21.500935] [<ffffffff80172308>] generic_handle_irq+0x38/0x48
> [   21.501176] [<ffffffff80108010>] do_IRQ+0x18/0x28
> [   21.501369] [<ffffffff803746c4>] plat_irq_dispatch+0x64/0xa0
> [   21.501606] [<ffffffff80106370>] ret_from_irq+0x0/0x4
> [   21.501868] [<ffffffff8034573c>] dump_stack+0x6c/0xd0
> [   21.502068] [<ffffffff8012d088>] __warn+0xf0/0x108
> [   21.502268] [<ffffffff80269e78>] __kernfs_remove+0x250/0x258
> [   21.502519] [<ffffffff8026ae38>] kernfs_remove_by_name_ns+0x48/0xb0
> [   21.502771] [<ffffffff8026dc44>] remove_files.isra.0+0x44/0x98
> [   21.503003] [<ffffffff8026e034>] sysfs_remove_group+0x4c/0xc0
> [   21.503339] [<ffffffff807cbc18>] param_sysfs_init+0x178/0x1f0
> [   21.503605] [<ffffffff80100564>] do_one_initcall+0x3c/0x148
> [   21.503830] [<ffffffff807c4b38>] kernel_init_freeable+0x15c/0x210
> [   21.504075] [<ffffffff80619cd0>] kernel_init+0x10/0xf8
> [   21.504324] [<ffffffff801063b8>] ret_from_kernel_thread+0x14/0x1c
> [   21.504683]
> [   21.504843] rcu_sched kthread starved for 2101 jiffies!
> g18446744073709551317 c18446744073709551316 f0x2 RCU_GP_WAIT_FQS(3)
> ->state=0x0
> [   21.505320] rcu_sched       R  running task        0     7      2
> 0x00100000
> [   21.505639] Stack : ffffffff8078e5a8 ffffffffffff00fe
> 000000000234fb95 0000000000000000
>           0000000000000117 000000000005fcb4 00000000ffff8ae7
> 980000000107e600
>           980000000107e600 ffffffff80780000 ffffffff80781010
> ffffffff80790000
>           0000000000000000 0000000000000001 0000000000000003
> ffffffff8061b2b4
>           0000000000000000 ffffffff8061dbac 0000000000000200
> 0000000000000000
>           00000000ffff8ae7 ffffffff80183fa8 9800000007093000
> ffffffff00000000
>           0000000000000001 9800000001082f80 ffffffff8078e340
> ffffffff8078e340
>           ffffffff8078e5a0 ffffffff80780000 ffffffff80780000
> ffffffff80181a98
>           9800000007093000 9800000007097d58 9800000007097d58
> 0000000000000000
>           0000000000000001 ffffffff80180000 ffffffff8017f140
> ffffffff806e0000
>           ...
> [   21.508301] Call Trace:
> [   21.508413] [<ffffffff8061ae28>] __schedule+0x4c8/0x930
> [   21.508668] [<ffffffff8061b2b4>] schedule+0x24/0x80
> [   21.508892] [<ffffffff8061dbac>] schedule_timeout+0x11c/0x1e0
> [   21.509121] [<ffffffff80181a98>] rcu_gp_kthread+0x510/0x948
> [   21.509349] [<ffffffff8014a9c8>] kthread+0xc8/0xe0
> [   21.509555] [<ffffffff801063b8>] ret_from_kernel_thread+0x14/0x1c
> [   21.509794]
> ^C
> qemu-system-mips64el.bad: terminating on signal 2
> 
> When using '-d in_asm' I see timer interrupts are delivered and handler
> executed, before the rcu_sched detects the cpu stalling.
> 
> 
> Console output from the previous commit (330edfcc):
> 
> Linux version 4.7.0-rc1 (@859affe05464) (gcc version 6.3.0 20170516
> (Debian 6.3.0-18) ) #2 SMP Sat Feb 1 18:16:17 UTC 2020
> GCRs appear to have been moved (expected them at 0x1fbf8000)!
> earlycon: uart8250 at I/O port 0x3f8 (options '38400n8')
> bootconsole [uart8250] enabled
> MIPS CPS SMP unable to proceed without a CM
> CPU0 revision is: 0001a900 (MIPS I6400)
> FPU revision is: 20f30300
> MSA revision is: 00000300
> MIPS: machine is mti,malta
> Software DMA cache coherency enabled
> Determined physical RAM map:
>  memory: 0000000008000000 @ 0000000000000000 (usable)
> Zone ranges:
>   DMA      [mem 0x0000000000000000-0x0000000000ffffff]
>   DMA32    [mem 0x0000000001000000-0x00000000ffffffff]
>   Normal   empty
> Movable zone start for each node
> Early memory node ranges
>   node   0: [mem 0x0000000000000000-0x0000000007ffffff]
> Initmem setup node 0 [mem 0x0000000000000000-0x0000000007ffffff]
> Primary instruction cache 64kB, VIPT, 4-way, linesize 64 bytes.
> Primary data cache 64kB, 4-way, VIPT, no aliases, linesize 64 bytes
> percpu: Embedded 5 pages/cpu @980000000107c000 s29664 r8192 d44064 u81920
> Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 8163
> Kernel command line: clocksource=GIC console=ttyS0 printk.time=1
> [    0.000000] PID hash table entries: 512 (order: -2, 4096 bytes)
> [    0.000000] Dentry cache hash table entries: 16384 (order: 3, 131072
> bytes)
> [    0.000000] Inode-cache hash table entries: 8192 (order: 2, 65536 bytes)
> [    0.000000] Writing ErrCtl register=00000000
> [    0.000000] Readback ErrCtl register=00000000
> [    0.000000] MAAR configuration:
> [    0.000000]   [0]: 0x0000000000010000-0x0000000007ffffff speculate
> [    0.000000]   [1]: disabled
> [    0.000000]   [2]: disabled
> [    0.000000]   [3]: disabled
> [    0.000000]   [4]: disabled
> [    0.000000]   [5]: disabled
> [    0.000000]   [6]: disabled
> [    0.000000]   [7]: disabled
> [    0.000000] Memory: 121728K/131072K available (5253K kernel code,
> 380K rwdata, 1276K rodata, 304K init, 278K bss, 9344K reserved, 0K
> cma-reserved)
> [    0.000000] Hierarchical RCU implementation.
> [    0.000000]  Build-time adjustment of leaf fanout to 64.
> [    0.000000]  RCU restricting CPUs from NR_CPUS=8 to nr_cpu_ids=1.
> [    0.000000] RCU: Adjusting geometry for rcu_fanout_leaf=64, nr_cpu_ids=1
> [    0.000000] NR_IRQS:256
> [    0.000000] CPU frequency 200.00 MHz
> [    0.000000] clocksource: MIPS: mask: 0xffffffff max_cycles:
> 0xffffffff, max_idle_ns: 19112606563 ns
> [    0.000227] sched_clock: 32 bits at 99MHz, resolution 10ns, wraps
> every 21474838522ns
> [    0.008164] Console: colour dummy device 80x25
> [    0.012438] Calibrating delay loop... 910.13 BogoMIPS (lpj=4550656)
> [    0.153536] pid_max: default: 32768 minimum: 301
> [    0.155594] Mount-cache hash table entries: 2048 (order: 0, 16384 bytes)
> [    0.156021] Mountpoint-cache hash table entries: 2048 (order: 0,
> 16384 bytes)
> [    0.192797] Brought up 1 CPUs
> [    0.203257] devtmpfs: initialized
> [    0.217846] clocksource: jiffies: mask: 0xffffffff max_cycles:
> 0xffffffff, max_idle_ns: 19112604462750000 ns
> [    0.224678] NET: Registered protocol family 16
> [    0.242230] clocksource: pit: mask: 0xffffffff max_cycles:
> 0xffffffff, max_idle_ns: 1601818034827 ns
> [    0.242911] pm-cps: no CM, non-coherent states unavailable
> [    0.294752] vgaarb: loaded
> [    0.296299] SCSI subsystem initialized
> [    0.301656] PCI host bridge to bus 0000:00
> [    0.302541] pci_bus 0000:00: root bus resource [mem
> 0x10000000-0x17ffffff]
> [    0.303066] pci_bus 0000:00: root bus resource [io  0x1000-0x1fffff]
> [    0.303567] pci_bus 0000:00: root bus resource [??? 0x00000000 flags 0x0]
> [    0.304037] pci_bus 0000:00: No busn resource found for root bus,
> will use [bus 00-ff]
> [    0.306645] pci 0000:00:00.0: [Firmware Bug]: reg 0x14: invalid BAR
> (can't size)
> [    0.307287] pci 0000:00:00.0: [Firmware Bug]: reg 0x18: invalid BAR
> (can't size)
> [    0.307732] pci 0000:00:00.0: [Firmware Bug]: reg 0x1c: invalid BAR
> (can't size)
> [    0.308191] pci 0000:00:00.0: [Firmware Bug]: reg 0x20: invalid BAR
> (can't size)
> [    0.308683] pci 0000:00:00.0: [Firmware Bug]: reg 0x24: invalid BAR
> (can't size)
> [    0.312906] pci 0000:00:0a.1: legacy IDE quirk: reg 0x10: [io
> 0x01f0-0x01f7]
> [    0.313321] pci 0000:00:0a.1: legacy IDE quirk: reg 0x14: [io  0x03f6]
> [    0.313834] pci 0000:00:0a.1: legacy IDE quirk: reg 0x18: [io
> 0x0170-0x0177]
> [    0.314301] pci 0000:00:0a.1: legacy IDE quirk: reg 0x1c: [io  0x0376]
> [    0.316353] pci 0000:00:0a.3: quirk: [io  0x1000-0x103f] claimed by
> PIIX4 ACPI
> [    0.316796] pci 0000:00:0a.3: quirk: [io  0x1100-0x110f] claimed by
> PIIX4 SMB
> [    0.318865] vgaarb: device added:
> PCI:0000:00:12.0,decodes=io+mem,owns=none,locks=none
> [    0.321353] pci 0000:00:12.0: BAR 0: assigned [mem
> 0x10000000-0x11ffffff pref]
> [    0.322118] pci 0000:00:0b.0: BAR 6: assigned [mem
> 0x12000000-0x1203ffff pref]
> [    0.322655] pci 0000:00:12.0: BAR 6: assigned [mem
> 0x12040000-0x1204ffff pref]
> [    0.323124] pci 0000:00:12.0: BAR 1: assigned [mem 0x12050000-0x12050fff]
> [    0.323594] pci 0000:00:0a.2: BAR 4: assigned [io  0x1040-0x105f]
> [    0.323984] pci 0000:00:0b.0: BAR 0: assigned [io  0x1060-0x107f]
> [    0.324368] pci 0000:00:0b.0: BAR 1: assigned [mem 0x12051000-0x1205101f]
> [    0.324787] pci 0000:00:0a.1: BAR 4: assigned [io  0x1080-0x108f]
> [    0.342630] clocksource: Switched to clocksource MIPS
> [    0.344235] VFS: Disk quotas dquot_6.6.0
> [    0.344890] VFS: Dquot-cache hash table entries: 2048 (order 0, 16384
> bytes)
> [    0.386512] NET: Registered protocol family 2
> [    0.398836] TCP established hash table entries: 2048 (order: 0, 16384
> bytes)
> [    0.400383] TCP bind hash table entries: 2048 (order: 1, 32768 bytes)
> [    0.400907] TCP: Hash tables configured (established 2048 bind 2048)
> [    0.402979] UDP hash table entries: 512 (order: 0, 16384 bytes)
> [    0.403480] UDP-Lite hash table entries: 512 (order: 0, 16384 bytes)
> [    0.406146] NET: Registered protocol family 1
> [    0.410131] RPC: Registered named UNIX socket transport module.
> [    0.410481] RPC: Registered udp transport module.
> [    0.410723] RPC: Registered tcp transport module.
> [    0.410969] RPC: Registered tcp NFSv4.1 backchannel transport module.
> [    0.418784] futex hash table entries: 256 (order: 0, 16384 bytes)
> [    0.423787] workingset: timestamp_bits=60 max_order=13 bucket_order=0
> [    0.427615] Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
> [    0.432664] Block layer SCSI generic (bsg) driver version 0.4 loaded
> (major 253)
> [    0.433193] io scheduler noop registered
> [    0.433428] io scheduler deadline registered
> [    0.433795] io scheduler cfq registered (default)
> [    0.436019] PCI: Enabling device 0000:00:12.0 (0000 -> 0002)
> [    0.437688] cirrusfb 0000:00:12.0: Cirrus Logic chipset on PCI bus,
> RAM (4096 kB) at 0x10000000
> [    0.693879] Console: switching to colour frame buffer device 80x30
> [    0.890253] Serial: 8250/16550 driver, 4 ports, IRQ sharing disabled
> [    0.900232] console [ttyS0] disabled
> [    0.931815] serial8250.0: ttyS0 at I/O 0x3f8 (irq = 4, base_baud =
> 115200) is a 16550A
> [    0.934068] console [ttyS0] enabled
> [    0.934068] console [ttyS0] enabled
> [    0.934866] bootconsole [uart8250] disabled
> [    0.934866] bootconsole [uart8250] disabled
> [    0.963488] serial8250.0: ttyS1 at I/O 0x2f8 (irq = 3, base_baud =
> 115200) is a 16550A
> [    0.991024] serial8250.0: ttyS2 at MMIO 0x1f000900 (irq = 20,
> base_baud = 230400) is a 16550A
> [    0.993376] [drm] Initialized drm 1.1.0 20060810
> [    1.035413] brd: module loaded
> [    1.036869] PCI: Enabling device 0000:00:0a.1 (0000 -> 0001)
> [    1.052237] scsi host0: ata_piix
> [    1.055459] scsi host1: ata_piix
> [    1.056457] ata1: PATA max UDMA/33 cmd 0x1f0 ctl 0x3f6 bmdma 0x1080
> irq 14
> [    1.056967] ata2: PATA max UDMA/33 cmd 0x170 ctl 0x376 bmdma 0x1088
> irq 15
> [    1.060000] physmap platform flash device: 00400000 at 1e000000
> [    1.063974] physmap-flash.0: Found 1 x32 devices at 0x0 in 32-bit
> bank. Manufacturer ID 0x000000 Chip ID 0x000000
> [    1.065202] Intel/Sharp Extended Query Table at 0x0031
> [    1.066817] Using buffer write method
> [    1.080256] Creating 3 MTD partitions on "physmap-flash.0":
> [    1.081618] 0x000000000000-0x000000100000 : "YAMON"
> [    1.088644] 0x000000100000-0x0000003e0000 : "User FS"
> [    1.091480] 0x0000003e0000-0x000000400000 : "Board Config"
> [    1.094277] pcnet32: pcnet32.c:v1.35 21.Apr.2008
> tsbogend@alpha.franken.de
> [    1.094891] PCI: Enabling device 0000:00:0b.0 (0000 -> 0003)
> [    1.096781] pcnet32: PCnet/PCI II 79C970A at 0x1060,
> 52:54:00:12:34:56 assigned IRQ 10
> [    1.100991] pcnet32: eth0: registered as PCnet/PCI II 79C970A
> [    1.101594] pcnet32: 1 cards_found
> [    1.104245] mousedev: PS/2 mouse device common for all mice
> [    1.107521] rtc_cmos rtc_cmos: rtc core: registered rtc_cmos as rtc0
> [    1.108464] rtc_cmos rtc_cmos: alarms up to one day, 242 bytes nvram
> [    1.111009] NET: Registered protocol family 10
> [    1.121232] sit: IPv6 over IPv4 tunneling driver
> [    1.124784] NET: Registered protocol family 17
> [    1.125362] NET: Registered protocol family 15
> [    1.135855] rtc_cmos rtc_cmos: setting system clock to 2020-02-01
> 20:08:10 UTC (1580587690)
> [    1.328785] ata2.00: ATAPI: QEMU DVD-ROM, 2.5+, max UDMA/100
> [    1.335399] ata2.00: configured for UDMA/33
> [    1.377344] scsi 1:0:0:0: CD-ROM            QEMU     QEMU DVD-ROM
>  2.5+ PQ: 0 ANSI: 5
> [    1.407242] sr 1:0:0:0: [sr0] scsi3-mmc drive: 4x/4x cd/rw xa/form2 tray
> [    1.409546] cdrom: Uniform CD-ROM driver Revision: 3.20
> ...
> 
> When booting
> 
> The kernel I'm using is available here:
> https://github.com/philmd/qemu-testing-blob/tree/malta_i6400/mips/malta/mips64el
> 
> It is built following the steps from:
> https://www.mips.com/blog/how-to-run-smp-linux-in-qemu-on-a-mips64-release-6-cpu/
> You can rebuild using docker anyway:
> https://github.com/philmd/qemu-testing-blob/blob/malta_i6400/mips/malta/mips64el/Dockerfile

I'm not sure this is not related to this commit, but it certainly
changes something.

I can reproduce 1/10 on commit 330edfcc84 building with --enable-debug,
while 10/10 using commit 7dd547e5a.


Console log using --enable-debug on 330edfcc84:

Linux version 4.7.0-rc1 (@859affe05464) (gcc version 6.3.0 20170516
(Debian 6.3.0-18) ) #2 SMP Sat Feb 1 18:16:17 UTC 2020
earlycon: uart8250 at I/O port 0x3f8 (options '38400n8')
bootconsole [uart8250] enabled
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
VP topology {8} total 8
Primary instruction cache 64kB, VIPT, 4-way, linesize 64 bytes.
Primary data cache 64kB, 4-way, VIPT, no aliases, linesize 64 bytes
percpu: Embedded 5 pages/cpu @980000000107c000 s29664 r8192 d44064 u81920
Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 8163
Kernel command line: clocksource=GIC console=ttyS0 printk.time=1
[    0.000000] log_buf_len individual max cpu contribution: 4096 bytes
[    0.000000] log_buf_len total cpu_extra contributions: 28672 bytes
[    0.000000] log_buf_len min size: 32768 bytes
[    0.000000] log_buf_len: 65536 bytes
[    0.000000] early log buf free: 30424(92%)
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
[    0.000000] Memory: 121104K/131072K available (5253K kernel code,
380K rwdata, 1276K rodata, 304K init, 278K bss, 9968K reserved, 0K
cma-reserved)
[    0.000000] Hierarchical RCU implementation.
[    0.000000]  Build-time adjustment of leaf fanout to 64.
[    0.000000] NR_IRQS:256
[    0.000000] CPU frequency 200.00 MHz
[    0.000000] GIC frequency 99.98 MHz
[    0.000000] clocksource: GIC: mask: 0xffffffff max_cycles:
0xffffffff, max_idle_ns: 19117033123 ns
[    0.000000] clocksource: MIPS: mask: 0xffffffff max_cycles:
0xffffffff, max_idle_ns: 19112620523 ns
[    0.000787] sched_clock: 32 bits at 99MHz, resolution 10ns, wraps
every 21474854906ns
[    0.045704] Console: colour dummy device 80x25
[    0.053021] Calibrating delay loop... 1325.46 BogoMIPS (lpj=6627328)
[    0.129932] pid_max: default: 32768 minimum: 301
[    0.136234] Mount-cache hash table entries: 2048 (order: 0, 16384 bytes)
[    0.136906] Mountpoint-cache hash table entries: 2048 (order: 0,
16384 bytes)
[   41.031274] Primary instruction cache 64kB, VIPT, 4-way, linesize 64
bytes.
[   41.033583] Primary data cache 64kB, 4-way, VIPT, no aliases,
linesize 64 bytes
[   41.054201] CPU1 revision is: 0001a900 (MIPS I6400)
[   41.055728] FPU revision is: 20f30300
[   41.055863] MSA revision is: 00000300
[    0.442532] Synchronize counters for CPU 1: done.
[   41.014309] Primary instruction cache 64kB, VIPT, 4-way, linesize 64
bytes.
[   41.014327] Primary data cache 64kB, 4-way, VIPT, no aliases,
linesize 64 bytes
[   41.014786] CPU2 revision is: 0001a900 (MIPS I6400)
[   41.014798] FPU revision is: 20f30300
[   41.014804] MSA revision is: 00000300
[    0.504208] Synchronize counters for CPU 2: done.
[   41.014212] Primary instruction cache 64kB, VIPT, 4-way, linesize 64
bytes.
[   41.014229] Primary data cache 64kB, 4-way, VIPT, no aliases,
linesize 64 bytes
[   41.014579] CPU3 revision is: 0001a900 (MIPS I6400)
[   41.014592] FPU revision is: 20f30300
[   41.014599] MSA revision is: 00000300
[    0.544586] Synchronize counters for CPU 3: done.
[   41.014251] Primary instruction cache 64kB, VIPT, 4-way, linesize 64
bytes.
[   41.014272] Primary data cache 64kB, 4-way, VIPT, no aliases,
linesize 64 bytes
[   41.014563] CPU4 revision is: 0001a900 (MIPS I6400)
[   41.014576] FPU revision is: 20f30300
[   41.014582] MSA revision is: 00000300
[    0.695674] Synchronize counters for CPU 4: done.
[   41.014280] Primary instruction cache 64kB, VIPT, 4-way, linesize 64
bytes.
[   41.014309] Primary data cache 64kB, 4-way, VIPT, no aliases,
linesize 64 bytes
[   41.014659] CPU5 revision is: 0001a900 (MIPS I6400)
[   41.014675] FPU revision is: 20f30300
[   41.014684] MSA revision is: 00000300
[    0.929436] Synchronize counters for CPU 5: done.
[   41.014251] Primary instruction cache 64kB, VIPT, 4-way, linesize 64
bytes.
[   41.014271] Primary data cache 64kB, 4-way, VIPT, no aliases,
linesize 64 bytes
[   41.014600] CPU6 revision is: 0001a900 (MIPS I6400)
[   41.014612] FPU revision is: 20f30300
[   41.014618] MSA revision is: 00000300
[    0.969928] Synchronize counters for CPU 6: done.
[   41.014292] Primary instruction cache 64kB, VIPT, 4-way, linesize 64
bytes.
[   41.014313] Primary data cache 64kB, 4-way, VIPT, no aliases,
linesize 64 bytes
[   41.014625] CPU7 revision is: 0001a900 (MIPS I6400)
[   41.014638] FPU revision is: 20f30300
[   41.014644] MSA revision is: 00000300
[    1.051137] Synchronize counters for CPU 7: done.
[    1.051764] Brought up 8 CPUs
[    1.121113] devtmpfs: initialized
[    1.215360] clocksource: jiffies: mask: 0xffffffff max_cycles:
0xffffffff, max_idle_ns: 19112604462750000 ns
[    1.358645] NET: Registered protocol family 16
[    1.392339] pm-cps: CPC does not support clock gating
[    1.732391] vgaarb: loaded
[    1.811916] SCSI subsystem initialized
[    1.829400] PCI host bridge to bus 0000:00
[    1.833354] pci_bus 0000:00: root bus resource [mem
0x10000000-0x17ffffff]
[    1.834048] pci_bus 0000:00: root bus resource [io  0x1000-0x1fffff]
[    1.834760] pci_bus 0000:00: root bus resource [??? 0x00000000 flags 0x0]
[    1.835537] pci_bus 0000:00: No busn resource found for root bus,
will use [bus 00-ff]
[    1.845795] pci 0000:00:00.0: [Firmware Bug]: reg 0x14: invalid BAR
(can't size)
[    1.846928] pci 0000:00:00.0: [Firmware Bug]: reg 0x18: invalid BAR
(can't size)
[    1.847531] pci 0000:00:00.0: [Firmware Bug]: reg 0x1c: invalid BAR
(can't size)
[    1.848025] pci 0000:00:00.0: [Firmware Bug]: reg 0x20: invalid BAR
(can't size)
[    1.848970] pci 0000:00:00.0: [Firmware Bug]: reg 0x24: invalid BAR
(can't size)
[    1.874551] pci 0000:00:0a.1: legacy IDE quirk: reg 0x10: [io
0x01f0-0x01f7]
[    1.875292] pci 0000:00:0a.1: legacy IDE quirk: reg 0x14: [io  0x03f6]
[    1.876094] pci 0000:00:0a.1: legacy IDE quirk: reg 0x18: [io
0x0170-0x0177]
[    1.876873] pci 0000:00:0a.1: legacy IDE quirk: reg 0x1c: [io  0x0376]
[    1.884188] pci 0000:00:0a.3: quirk: [io  0x1000-0x103f] claimed by
PIIX4 ACPI
[    1.884928] pci 0000:00:0a.3: quirk: [io  0x1100-0x110f] claimed by
PIIX4 SMB
[    1.890092] vgaarb: device added:
PCI:0000:00:12.0,decodes=io+mem,owns=none,locks=none
[    1.900721] pci 0000:00:12.0: BAR 0: assigned [mem
0x10000000-0x10ffffff pref]
[    1.902774] pci 0000:00:0b.0: BAR 6: assigned [mem
0x11000000-0x1103ffff pref]
[    1.903875] pci 0000:00:12.0: BAR 6: assigned [mem
0x11040000-0x1104ffff pref]
[    1.904908] pci 0000:00:13.0: BAR 4: assigned [mem
0x11050000-0x11053fff 64bit pref]
[    1.906044] pci 0000:00:12.0: BAR 2: assigned [mem 0x11054000-0x11054fff]
[    1.906570] pci 0000:00:0a.2: BAR 4: assigned [io  0x1040-0x105f]
[    1.906963] pci 0000:00:0b.0: BAR 0: assigned [io  0x1060-0x107f]
[    1.907308] pci 0000:00:0b.0: BAR 1: assigned [mem 0x11055000-0x1105501f]
[    1.908194] pci 0000:00:0a.1: BAR 4: assigned [io  0x1080-0x108f]
[    1.967033] clocksource: Switched to clocksource GIC
[   22.982466] INFO: rcu_sched detected stalls on CPUs/tasks:
[   22.998174]  2-...: (1 GPs behind) idle=37e/0/0 softirq=55/57 fqs=1
[   23.002730]  (detected by 3, t=2104 jiffies, g=-272, c=-273, q=128)
[   23.007730] Task dump for CPU 2:
[   23.010438] swapper/2       R  running task        0     0      1
0x00100000
[   23.013820] Stack : ffffffff806dd460 ffffffff807c0000
0000000000000001 ffffffff80780e78
          ffffffff807807c0 0000000000000001 00000000001abff1
ffffffff80107f18
          ffffffff806dd460 ffffffff807c0000 98000000070c8000
98000000070cbdf0
          ffffffff80780000 ffffffff80166758 000000001400fce3
ffffffff80780e78
          ffffffff807807c0 ffffffff80195630 0000000000800400
ffffffff80166754
          000000000000000a ffffffff8012eec8 ffffffff807805c0
0000000000000001
          0000000000000008 0000000000000008 ffffffff8081cc40
ffffffff80114914
          0000000000000001 0000000000000000 0000000000000004
0000000000000002
          ffffffff80820000 0000000000000000 0000000000000005
0000000000000000
          0000000000000000 0000000000000000 0000000000000000
0000000000000000
          ...
[   23.022834] Call Trace:
[   23.025982] [<ffffffff8061ae28>] __schedule+0x4c8/0x930
[   23.029166]
[   23.031304] rcu_sched kthread starved for 2106 jiffies!
g18446744073709551344 c18446744073709551343 f0x0 RCU_GP_WAIT_FQS(3)
->state=0x1
[   23.033442] rcu_sched       S ffffffff8061b2b4     0     7      2
0x00100000
[   23.034900] Stack : 00000000000001d7 ffffffff8078e340
00000000ffff8b7d 0000000000000005
          98000000070afce0 980000000110a600 00000000ffff8b8d
980000000110a600
          980000000110a600 ffffffff80780000 ffffffff80781010
ffffffff80790000
          0000000000000000 0000000000000001 0000000000000003
ffffffff8061b2b4
          ffffffff80790000 ffffffff8061dbac 0000000000000000
980000000110aaa0
          00000000ffff8b8d ffffffff80183fa8 98000000070ab000
ffffffff00000007
          0000000000000001 ffffffff80780000 ffffffff8078e340
ffffffff8078e340
          ffffffff8078e5a0 ffffffff80780000 ffffffff80780000
ffffffff80181a98
          98000000070ab000 ffffffff8078e5a8 ffffffff8078e5a8
0000000000000000
          0000000000000000 ffffffff80180000 ffffffff8017f140
ffffffff806e0000
          ...
[   23.042338] Call Trace:
[   23.042732] [<ffffffff8061ae28>] __schedule+0x4c8/0x930
[   23.043187] [<ffffffff8061b2b4>] schedule+0x24/0x80
[   23.043567] [<ffffffff8061dbac>] schedule_timeout+0x11c/0x1e0
[   23.043943] [<ffffffff80181a98>] rcu_gp_kthread+0x510/0x948
[   23.044381] [<ffffffff8014a9c8>] kthread+0xc8/0xe0
[   23.044702] [<ffffffff801063b8>] ret_from_kernel_thread+0x14/0x1c
[   23.045165]
[   44.055135] INFO: rcu_sched detected stalls on CPUs/tasks:
[   44.058011]  7-...: (0 ticks this GP) idle=232/0/0 softirq=45/45 fqs=1
[   44.059496]  (detected by 0, t=2102 jiffies, g=-271, c=-272, q=88)
[   44.061806] Task dump for CPU 7:
[   44.063035] swapper/7       R  running task        0     0      1
0x00100000
[   44.067350] Stack : ffffffff806dd460 ffffffff807c0000
0000000000000001 980000000110ba08
          0000000000000007 ffffffff806dd460 ffffffff807c0000
ffffffff80195080
          7fffffffffffffff ffffffff807c0000 ffffffff80780000
ffffffff80780e78
          ffffffff806dd460 ffffffff807c0000 0000000000000001
ffffffff80780e78
          ffffffff80780cc0 ffffffff80195630 ffffffff806dd460
ffffffff80166754
          000000000000000a ffffffff8012eec8 ffffffff807805c0
0000000000000001
          0000000000000008 0000000000000008 ffffffff8081cc40
ffffffff80114914
          0000000000000001 0000000000000000 0000000000000080
0000000000000007
          ffffffff80820000 0000000000000000 0000000000000005
0000000000000000
          0000000000000000 0000000000000000 0000000000000000
0000000000000000
          ...
[   44.078926] Call Trace:
[   44.079358] [<ffffffff8061ae28>] __schedule+0x4c8/0x930
[   44.079998]
[   44.080211] rcu_sched kthread starved for 2101 jiffies!
g18446744073709551345 c18446744073709551344 f0x0 RCU_GP_WAIT_FQS(3)
->state=0x1
[   44.081905] rcu_sched       S ffffffff8061b2b4     0     7      2
0x00100000
[   44.082736] Stack : 00000000000001d7 ffffffff8078e340
00000000ffff8b7d 0000000000000005
          98000000070afce0 980000000110a600 00000000ffff93c9
980000000110a600
          980000000110a600 ffffffff80780000 ffffffff80781010
ffffffff80790000
          0000000000000000 0000000000000001 0000000000000003
ffffffff8061b2b4
          ffffffff80790000 ffffffff8061dbac 0000000000000000
980000000110aed0
          00000000ffff93c9 ffffffff80183fa8 98000000070ab000
ffffffff00000007
          0000000000000001 ffffffff80780000 ffffffff8078e340
ffffffff8078e340
          ffffffff8078e5a0 ffffffff80780000 ffffffff80780000
ffffffff80181a98
          98000000070ab000 ffffffff8078e5a8 ffffffff8078e5a8
0000000000000000
          0000000000000000 ffffffff80180000 ffffffff8017f140
ffffffff806e0000
          ...
[   44.089552] Call Trace:
[   44.089733] [<ffffffff8061ae28>] __schedule+0x4c8/0x930
[   44.090069] [<ffffffff8061b2b4>] schedule+0x24/0x80
[   44.090375] [<ffffffff8061dbac>] schedule_timeout+0x11c/0x1e0
[   44.090743] [<ffffffff80181a98>] rcu_gp_kthread+0x510/0x948
[   44.091093] [<ffffffff8014a9c8>] kthread+0xc8/0xe0
[   44.091395] [<ffffffff801063b8>] ret_from_kernel_thread+0x14/0x1c
[   44.091767]
[   44.945325] VFS: Disk quotas dquot_6.6.0
[   44.984731] VFS: Dquot-cache hash table entries: 2048 (order 0, 16384
bytes)
[   45.176126] NET: Registered protocol family 2
[   45.414925] TCP established hash table entries: 2048 (order: 0, 16384
bytes)
[   45.419093] TCP bind hash table entries: 2048 (order: 1, 32768 bytes)
[   45.421411] TCP: Hash tables configured (established 2048 bind 2048)
[   45.430481] UDP hash table entries: 512 (order: 0, 16384 bytes)
[   45.431498] UDP-Lite hash table entries: 512 (order: 0, 16384 bytes)
[   45.534362] NET: Registered protocol family 1
[   45.606926] RPC: Registered named UNIX socket transport module.
[   45.608354] RPC: Registered udp transport module.
[   45.609336] RPC: Registered tcp transport module.
[   45.610249] RPC: Registered tcp NFSv4.1 backchannel transport module.
[   45.718310] futex hash table entries: 2048 (order: 3, 131072 bytes)
[   45.747210] workingset: timestamp_bits=60 max_order=13 bucket_order=0
[   46.275627] Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
[   46.354259] Block layer SCSI generic (bsg) driver version 0.4 loaded
(major 253)
[   46.355680] io scheduler noop registered
[   46.356208] io scheduler deadline registered
[   46.395936] io scheduler cfq registered (default)
[   46.512436] PCI: Enabling device 0000:00:13.0 (0000 -> 0002)
[   46.555822] input: QEMU Virtio Keyboard as
/devices/pci0000:00/0000:00:13.0/virtio0/input/input0
[   46.716413] Serial: 8250/16550 driver, 4 ports, IRQ sharing disabled
[   46.756069] console [ttyS0] disabled
[   46.787920] serial8250.0: ttyS0 at I/O 0x3f8 (irq = 4, base_baud =
115200) is a 16550A
[   46.795739] console [ttyS0] enabled
[   46.795739] console [ttyS0] enabled
[   46.797338] bootconsole [uart8250] disabled
[   46.797338] bootconsole [uart8250] disabled
[   46.818839] serial8250.0: ttyS1 at I/O 0x2f8 (irq = 3, base_baud =
115200) is a 16550A
[   46.839273] serial8250.0: ttyS2 at MMIO 0x1f000900 (irq = 20,
base_baud = 230400) is a 16550A
[   46.842492] [drm] Initialized drm 1.1.0 20060810
[   46.854005] PCI: Enabling device 0000:00:12.0 (0000 -> 0002)
[   46.859898] [drm] Found bochs VGA, ID 0xb0c5.
[   46.860297] [drm] Framebuffer size 16384 kB @ 0x10000000, mmio @
0x11054000.
[   46.866727] [TTM] Zone  kernel: Available graphics memory: 60552 kiB
[   46.867364] [TTM] Initializing pool allocator
[   47.092723] Console: switching to colour frame buffer device 128x48
[   47.117712] bochs-drm 0000:00:12.0: fb0: bochsdrmfb frame buffer device
[   47.121833] [drm] Initialized bochs-drm 1.0.0 20130925 for
0000:00:12.0 on minor 0
[   47.307909] brd: module loaded
[   47.325590] PCI: Enabling device 0000:00:0a.1 (0000 -> 0001)
[   47.379430] scsi host0: ata_piix
[   47.391937] scsi host1: ata_piix
[   47.394914] ata1: PATA max UDMA/33 cmd 0x1f0 ctl 0x3f6 bmdma 0x1080
irq 14
[   47.395537] ata2: PATA max UDMA/33 cmd 0x170 ctl 0x376 bmdma 0x1088
irq 15
[   47.407079] physmap platform flash device: 00400000 at 1e000000
[   47.420227] physmap-flash.0: Found 1 x32 devices at 0x0 in 32-bit
bank. Manufacturer ID 0x000000 Chip ID 0x000000
[   47.424040] Intel/Sharp Extended Query Table at 0x0031
[   47.427841] Using buffer write method
[   47.441991] Creating 3 MTD partitions on "physmap-flash.0":
[   47.445025] 0x000000000000-0x000000100000 : "YAMON"
[   47.459268] 0x000000100000-0x0000003e0000 : "User FS"
[   47.463336] 0x0000003e0000-0x000000400000 : "Board Config"
[   47.469471] pcnet32: pcnet32.c:v1.35 21.Apr.2008
tsbogend@alpha.franken.de
[   47.470336] PCI: Enabling device 0000:00:0b.0 (0000 -> 0003)
[   47.477538] pcnet32: PCnet/PCI II 79C970A at 0x1060,
52:54:00:12:34:56 assigned IRQ 10
[   47.515743] pcnet32: eth0: registered as PCnet/PCI II 79C970A
[   47.516844] pcnet32: 1 cards_found
[   47.526661] mousedev: PS/2 mouse device common for all mice
[   47.539046] rtc_cmos rtc_cmos: rtc core: registered rtc_cmos as rtc0
[   47.541127] rtc_cmos rtc_cmos: alarms up to one day, 242 bytes nvram
[   47.643909] ata2.00: ATAPI: QEMU DVD-ROM, 2.5+, max UDMA/100
[   47.651047] ata2.00: configured for UDMA/33
[   47.704763] scsi 1:0:0:0: CD-ROM            QEMU     QEMU DVD-ROM
 2.5+ PQ: 0 ANSI: 5
[   47.830833] sr 1:0:0:0: [sr0] scsi3-mmc drive: 4x/4x cd/rw xa/form2 tray
[   47.833285] cdrom: Uniform CD-ROM driver Revision: 3.20
[   47.855442] NET: Registered protocol family 10
[   48.049944] sit: IPv6 over IPv4 tunneling driver
[   48.135772] NET: Registered protocol family 17
[   48.137211] NET: Registered protocol family 15
[   48.188261] rtc_cmos rtc_cmos: setting system clock to 2020-02-01
21:54:13 UTC (1580594053)

While there is no activity during 20s after "clocksource: Switched to
clocksource GIC" is displayed, QEMU use very little resources (3% on a
core).


Console log using --enable-debug on 7dd547e5a:

Linux version 4.7.0-rc1 (@859affe05464) (gcc version 6.3.0 20170516
(Debian 6.3.0-18) ) #2 SMP Sat Feb 1 18:16:17 UTC 2020
earlycon: uart8250 at I/O port 0x3f8 (options '38400n8')
bootconsole [uart8250] enabled
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
VP topology {8} total 8
Primary instruction cache 64kB, VIPT, 4-way, linesize 64 bytes.
Primary data cache 64kB, 4-way, VIPT, no aliases, linesize 64 bytes
percpu: Embedded 5 pages/cpu @980000000107c000 s29664 r8192 d44064 u81920
Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 8163
Kernel command line: clocksource=GIC console=ttyS0 printk.time=1
[    0.000000] log_buf_len individual max cpu contribution: 4096 bytes
[    0.000000] log_buf_len total cpu_extra contributions: 28672 bytes
[    0.000000] log_buf_len min size: 32768 bytes
[    0.000000] log_buf_len: 65536 bytes
[    0.000000] early log buf free: 30424(92%)
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
[    0.000000] Memory: 121104K/131072K available (5253K kernel code,
380K rwdata, 1276K rodata, 304K init, 278K bss, 9968K reserved, 0K
cma-reserved)
[    0.000000] Hierarchical RCU implementation.
[    0.000000]  Build-time adjustment of leaf fanout to 64.
[    0.000000] NR_IRQS:256
[    0.000000] CPU frequency 200.00 MHz
[    0.000000] GIC frequency 99.99 MHz
[    0.000000] clocksource: GIC: mask: 0xffffffff max_cycles:
0xffffffff, max_idle_ns: 19113957547 ns
[    0.000000] clocksource: MIPS: mask: 0xffffffff max_cycles:
0xffffffff, max_idle_ns: 19112610963 ns
[    0.000741] sched_clock: 32 bits at 99MHz, resolution 10ns, wraps
every 21474843642ns
[    0.045796] Console: colour dummy device 80x25
[    0.052754] Calibrating delay loop... 1380.35 BogoMIPS (lpj=6901760)
[    0.182166] pid_max: default: 32768 minimum: 301
[    0.188361] Mount-cache hash table entries: 2048 (order: 0, 16384 bytes)
[    0.189064] Mountpoint-cache hash table entries: 2048 (order: 0,
16384 bytes)
[   41.034804] Primary instruction cache 64kB, VIPT, 4-way, linesize 64
bytes.
[   41.036928] Primary data cache 64kB, 4-way, VIPT, no aliases,
linesize 64 bytes
[   41.056628] CPU1 revision is: 0001a900 (MIPS I6400)
[   41.058037] FPU revision is: 20f30300
[   41.058156] MSA revision is: 00000300
[    0.535401] Synchronize counters for CPU 1: done.
[   41.018777] Primary instruction cache 64kB, VIPT, 4-way, linesize 64
bytes.
[   41.018795] Primary data cache 64kB, 4-way, VIPT, no aliases,
linesize 64 bytes
[   41.019379] CPU2 revision is: 0001a900 (MIPS I6400)
[   41.019391] FPU revision is: 20f30300
[   41.019397] MSA revision is: 00000300
[    0.628295] Synchronize counters for CPU 2: done.
[   41.018747] Primary instruction cache 64kB, VIPT, 4-way, linesize 64
bytes.
[   41.018763] Primary data cache 64kB, 4-way, VIPT, no aliases,
linesize 64 bytes
[   41.019222] CPU3 revision is: 0001a900 (MIPS I6400)
[   41.019233] FPU revision is: 20f30300
[   41.019238] MSA revision is: 00000300
[    0.769903] Synchronize counters for CPU 3: done.
[   41.018757] Primary instruction cache 64kB, VIPT, 4-way, linesize 64
bytes.
[   41.018774] Primary data cache 64kB, 4-way, VIPT, no aliases,
linesize 64 bytes
[   41.019008] CPU4 revision is: 0001a900 (MIPS I6400)
[   41.019020] FPU revision is: 20f30300
[   41.019026] MSA revision is: 00000300
[    0.911756] Synchronize counters for CPU 4: done.
[   41.018736] Primary instruction cache 64kB, VIPT, 4-way, linesize 64
bytes.
[   41.018756] Primary data cache 64kB, 4-way, VIPT, no aliases,
linesize 64 bytes
[   41.018990] CPU5 revision is: 0001a900 (MIPS I6400)
[   41.019002] FPU revision is: 20f30300
[   41.019009] MSA revision is: 00000300
[    1.043787] Synchronize counters for CPU 5: done.
[   41.018734] Primary instruction cache 64kB, VIPT, 4-way, linesize 64
bytes.
[   41.018752] Primary data cache 64kB, 4-way, VIPT, no aliases,
linesize 64 bytes
[   41.018977] CPU6 revision is: 0001a900 (MIPS I6400)
[   41.018989] FPU revision is: 20f30300
[   41.018995] MSA revision is: 00000300
[    1.085417] Synchronize counters for CPU 6: done.
[   41.018723] Primary instruction cache 64kB, VIPT, 4-way, linesize 64
bytes.
[   41.018742] Primary data cache 64kB, 4-way, VIPT, no aliases,
linesize 64 bytes
[   41.019068] CPU7 revision is: 0001a900 (MIPS I6400)
[   41.019080] FPU revision is: 20f30300
[   41.019085] MSA revision is: 00000300
[    1.226464] Synchronize counters for CPU 7: done.
[    1.227129] Brought up 8 CPUs
[    1.297485] devtmpfs: initialized
[    1.383773] clocksource: jiffies: mask: 0xffffffff max_cycles:
0xffffffff, max_idle_ns: 19112604462750000 ns
[    1.498275] NET: Registered protocol family 16
[    1.535531] pm-cps: CPC does not support clock gating
[    1.558214] ------------[ cut here ]------------
[    1.560406] WARNING: CPU: 0 PID: 1 at fs/kernfs/dir.c:502
__kernfs_remove+0x250/0x258
[    1.561507] Modules linked in:
[   22.727193] INFO: rcu_sched self-detected stall on CPU
[   22.728201]  0-...: (2099 ticks this GP) idle=051/140000000000001/0
softirq=14/14 fqs=2085
[   22.728694]   (t=2100 jiffies g=-292 c=-293 q=134)
[   22.729734] Task dump for CPU 0:
[   22.730579] swapper/0       R  running task        0     1      0
0x00100004
[   22.731798] Stack : 000000000000001d 0000000000000004
ffffffff80790000 ffffffff80820000
          0000000000000000 0000000000000000 000000000000001d
0000000000000002
          ffffffff80820000 ffffffff80170c70 0000000000000000
0000000000000000
          0000000000000000 ffffffff80822328 0000000000000001
0000000000000002
          9800000007066fc0 ffffffff8078e340 ffffffff80780000
0000000000000000
          0000000000000000 ffffffff80780000 ffffffff80781010
0000000000000086
          0000000000000000 0000000000000000 0000000000000000
0000000000000000
          0000000000000000 980000000706b760 0000000000000000
ffffffff801a726c
          0000000000000000 0000000000000000 0000000000100004
9800000007066fc0
          ffffffff8078e340 ffffffff8010c460 ffffffff8078e340
ffffffff801a726c
          ...
[   22.736574] Call Trace:
[   22.736932] [<ffffffff8010c460>] show_stack+0x80/0xa0
[   22.737782] [<ffffffff801a726c>] rcu_dump_cpu_stacks+0x8c/0xc8
[   22.738076] [<ffffffff801829e0>] rcu_check_callbacks+0x780/0x810
[   22.738407] [<ffffffff80185360>] update_process_times+0x38/0x70
[   22.738731] [<ffffffff80193c34>] tick_handle_periodic+0x2c/0xa8
[   22.739059] [<ffffffff804b6fe8>] gic_compare_interrupt+0x28/0x40
[   22.739356] [<ffffffff80177688>] handle_percpu_devid_irq+0xa0/0xf0
[   22.739655] [<ffffffff80172308>] generic_handle_irq+0x38/0x48
[   22.740096] [<ffffffff80375d70>] gic_irq_dispatch+0x80/0x268
[   22.740371] [<ffffffff80172308>] generic_handle_irq+0x38/0x48
[   22.740647] [<ffffffff80108010>] do_IRQ+0x18/0x28
[   22.740879] [<ffffffff803746c4>] plat_irq_dispatch+0x64/0xa0
[   22.741158] [<ffffffff80106370>] ret_from_irq+0x0/0x4
[   22.741616] [<ffffffff8034573c>] dump_stack+0x6c/0xd0
[   22.741870] [<ffffffff8012d088>] __warn+0xf0/0x108
[   22.742117] [<ffffffff80269e78>] __kernfs_remove+0x250/0x258
[   22.742390] [<ffffffff8026ae38>] kernfs_remove_by_name_ns+0x48/0xb0
[   22.742689] [<ffffffff8026dc44>] remove_files.isra.0+0x44/0x98
[   22.742969] [<ffffffff8026e034>] sysfs_remove_group+0x4c/0xc0
[   22.743553] [<ffffffff807cbc18>] param_sysfs_init+0x178/0x1f0
[   22.744001] [<ffffffff80100564>] do_one_initcall+0x3c/0x148
[   22.744286] [<ffffffff807c4b38>] kernel_init_freeable+0x15c/0x210
[   22.744588] [<ffffffff80619cd0>] kernel_init+0x10/0xf8
[   22.744841] [<ffffffff801063b8>] ret_from_kernel_thread+0x14/0x1c
[   22.745542]
[   86.443882] INFO: rcu_sched self-detected stall on CPU
[   86.444599]  0-...: (8402 ticks this GP) idle=051/140000000000001/0
softirq=14/14 fqs=7208
[   86.445336]   (t=8403 jiffies g=-292 c=-293 q=134)
[   86.446122] rcu_sched kthread starved for 1127 jiffies!
g18446744073709551324 c18446744073709551323 f0x0 RCU_GP_WAIT_FQS(3)
->state=0x0
[   86.447172] rcu_sched       R  running task        0     7      2
0x00100000
[   86.447843] Stack : ffffffff8017f140 98000000070afd68
98000000070afd50 ffffffff80781010
          98000000070afce0 98000000010f6600 00000000ffffa7cd
98000000010f6600
          98000000010f6600 ffffffff80780000 ffffffff80781010
ffffffff80790000
          0000000000000000 0000000000000001 0000000000000003
ffffffff8061b2b4
          0000000000000000 ffffffff8061dbac 0000000000000200
0000000000000000
          00000000ffffa7cd ffffffff80183fa8 98000000070ab000
ffffffff00000006
          0000000000000001 ffffffff80780000 ffffffff8078e340
ffffffff8078e340
          ffffffff8078e5a0 ffffffff80780000 ffffffff80780000
ffffffff80181a98
          98000000070ab000 ffffffff8078e5a8 ffffffff8078e5a8
0000000000000001
          0000000000000000 ffffffff80180000 ffffffff8017f140
ffffffff806e0000
          ...
[   86.452980] Call Trace:
[   86.453240] [<ffffffff8061ae28>] __schedule+0x4c8/0x930
[   86.453728] [<ffffffff8061b2b4>] schedule+0x24/0x80
[   86.454571] [<ffffffff8061dbac>] schedule_timeout+0x11c/0x1e0
[   86.455103] [<ffffffff80181a98>] rcu_gp_kthread+0x510/0x948
[   86.455731] [<ffffffff8014a9c8>] kthread+0xc8/0xe0
[   86.456180] [<ffffffff801063b8>] ret_from_kernel_thread+0x14/0x1c
[   86.456721]
[   86.456991] Task dump for CPU 0:
[   86.457297] swapper/0       R  running task        0     1      0
0x00100004
[   86.457956] Stack : 000000000000001d 0000000000000004
ffffffff80790000 ffffffff80820000
          0000000000000000 0000000000000000 000000000000001d
0000000000000002
          ffffffff80820000 ffffffff80170c70 0000000000000000
0000000000000000
          0000000000000000 ffffffff80822328 0000000000000001
ffffffff80822328
          9800000007066fc0 ffffffff8078e340 ffffffff80780000
0000000000000000
          0000000000000000 ffffffff80780000 ffffffff80781010
0000000000000086
          0000000000000000 0000000000000000 0000000000000000
0000000000000000
          0000000000000000 980000000706b760 0000000000000000
ffffffff801a726c
          0000000000000000 0000000000000000 0000000000100004
9800000007066fc0
          ffffffff8078e340 ffffffff8010c460 ffffffff8078e340
ffffffff801a726c
          ...
[   86.464391] Call Trace:
[   86.464637] [<ffffffff8010c460>] show_stack+0x80/0xa0
[   86.465108] [<ffffffff801a726c>] rcu_dump_cpu_stacks+0x8c/0xc8
[   86.465639] [<ffffffff801829e0>] rcu_check_callbacks+0x780/0x810
[   86.466157] [<ffffffff80185360>] update_process_times+0x38/0x70
[   86.466482] [<ffffffff80193c34>] tick_handle_periodic+0x2c/0xa8
[   86.466861] [<ffffffff804b6fe8>] gic_compare_interrupt+0x28/0x40
[   86.467198] [<ffffffff80177688>] handle_percpu_devid_irq+0xa0/0xf0
[   86.467536] [<ffffffff80172308>] generic_handle_irq+0x38/0x48
[   86.467849] [<ffffffff80375d70>] gic_irq_dispatch+0x80/0x268
[   86.468165] [<ffffffff80172308>] generic_handle_irq+0x38/0x48
[   86.468479] [<ffffffff80108010>] do_IRQ+0x18/0x28
[   86.468757] [<ffffffff803746c4>] plat_irq_dispatch+0x64/0xa0
[   86.469070] [<ffffffff80106370>] ret_from_irq+0x0/0x4
[   86.469358] [<ffffffff8034573c>] dump_stack+0x6c/0xd0
[   86.469638] [<ffffffff8012d088>] __warn+0xf0/0x108
[   86.469909] [<ffffffff80269e78>] __kernfs_remove+0x250/0x258
[   86.470321] [<ffffffff8026ae38>] kernfs_remove_by_name_ns+0x48/0xb0
[   86.470766] [<ffffffff8026dc44>] remove_files.isra.0+0x44/0x98
[   86.471183] [<ffffffff8026e034>] sysfs_remove_group+0x4c/0xc0
[   86.471592] [<ffffffff807cbc18>] param_sysfs_init+0x178/0x1f0
[   86.472003] [<ffffffff80100564>] do_one_initcall+0x3c/0x148
[   86.472405] [<ffffffff807c4b38>] kernel_init_freeable+0x15c/0x210
[   86.472840] [<ffffffff80619cd0>] kernel_init+0x10/0xf8
[   86.473219] [<ffffffff801063b8>] ret_from_kernel_thread+0x14/0x1c
[   86.473546]
[  150.198525] INFO: rcu_sched self-detected stall on CPU
[  150.198956]  0-...: (14705 ticks this GP) idle=051/140000000000001/0
softirq=14/14 fqs=7208
[  150.199539]   (t=14706 jiffies g=-292 c=-293 q=134)
[  150.199943] rcu_sched kthread starved for 7430 jiffies!
g18446744073709551324 c18446744073709551323 f0x0 RCU_GP_WAIT_FQS(3)
->state=0x0
[  150.200850] rcu_sched       R  running task        0     7      2
0x00100000
[  150.201251] Stack : ffffffff8017f140 98000000070afd68
98000000070afd50 ffffffff80781010
          98000000070afce0 98000000010f6600 00000000ffffa7cd
98000000010f6600
          98000000010f6600 ffffffff80780000 ffffffff80781010
ffffffff80790000
          0000000000000000 0000000000000001 0000000000000003
ffffffff8061b2b4
          0000000000000000 ffffffff8061dbac 0000000000000200
0000000000000000
          00000000ffffa7cd ffffffff80183fa8 98000000070ab000
ffffffff00000006
          0000000000000001 ffffffff80780000 ffffffff8078e340
ffffffff8078e340
          ffffffff8078e5a0 ffffffff80780000 ffffffff80780000
ffffffff80181a98
          98000000070ab000 ffffffff8078e5a8 ffffffff8078e5a8
0000000000000001
          0000000000000000 ffffffff80180000 ffffffff8017f140
ffffffff806e0000
          ...
[  150.205988] Call Trace:
[  150.206198] [<ffffffff8061ae28>] __schedule+0x4c8/0x930
[  150.206588] [<ffffffff8061b2b4>] schedule+0x24/0x80
[  150.206951] [<ffffffff8061dbac>] schedule_timeout+0x11c/0x1e0
[  150.207381] [<ffffffff80181a98>] rcu_gp_kthread+0x510/0x948
[  150.207794] [<ffffffff8014a9c8>] kthread+0xc8/0xe0
[  150.208157] [<ffffffff801063b8>] ret_from_kernel_thread+0x14/0x1c
[  150.208641]
[  150.208805] Task dump for CPU 0:
[  150.209047] swapper/0       R  running task        0     1      0
0x00100004
[  150.209580] Stack : 000000000000001d 0000000000000004
ffffffff80790000 ffffffff80820000
          0000000000000000 0000000000000000 000000000000001d
0000000000000002
          ffffffff80820000 ffffffff80170c70 0000000000000000
0000000000000000
          0000000000000000 ffffffff80822328 0000000000000001
ffffffff80822328
          9800000007066fc0 ffffffff8078e340 ffffffff80780000
0000000000000000
          0000000000000000 ffffffff80780000 ffffffff80781010
0000000000000086
          0000000000000000 0000000000000000 0000000000000000
0000000000000000
          0000000000000000 980000000706b760 0000000000000000
ffffffff801a726c
          0000000000000000 0000000000000000 0000000000100004
9800000007066fc0
          ffffffff8078e340 ffffffff8010c460 ffffffff8078e340
ffffffff801a726c
          ...
[  150.215207] Call Trace:
[  150.215407] [<ffffffff8010c460>] show_stack+0x80/0xa0
[  150.215782] [<ffffffff801a726c>] rcu_dump_cpu_stacks+0x8c/0xc8
[  150.216211] [<ffffffff801829e0>] rcu_check_callbacks+0x780/0x810
[  150.216646] [<ffffffff80185360>] update_process_times+0x38/0x70
[  150.217076] [<ffffffff80193c34>] tick_handle_periodic+0x2c/0xa8
[  150.217512] [<ffffffff804b6fe8>] gic_compare_interrupt+0x28/0x40
[  150.217948] [<ffffffff80177688>] handle_percpu_devid_irq+0xa0/0xf0
[  150.218400] [<ffffffff80172308>] generic_handle_irq+0x38/0x48
[  150.218820] [<ffffffff80375d70>] gic_irq_dispatch+0x80/0x268
[  150.219240] [<ffffffff80172308>] generic_handle_irq+0x38/0x48
[  150.219660] [<ffffffff80108010>] do_IRQ+0x18/0x28
[  150.220123] [<ffffffff803746c4>] plat_irq_dispatch+0x64/0xa0
[  150.220579] [<ffffffff80106370>] ret_from_irq+0x0/0x4
[  150.220952] [<ffffffff8034573c>] dump_stack+0x6c/0xd0
[  150.221328] [<ffffffff8012d088>] __warn+0xf0/0x108
[  150.221688] [<ffffffff80269e78>] __kernfs_remove+0x250/0x258
[  150.222105] [<ffffffff8026ae38>] kernfs_remove_by_name_ns+0x48/0xb0
[  150.222565] [<ffffffff8026dc44>] remove_files.isra.0+0x44/0x98
[  150.222989] [<ffffffff8026e034>] sysfs_remove_group+0x4c/0xc0
[  150.223412] [<ffffffff807cbc18>] param_sysfs_init+0x178/0x1f0
[  150.223832] [<ffffffff80100564>] do_one_initcall+0x3c/0x148
[  150.224246] [<ffffffff807c4b38>] kernel_init_freeable+0x15c/0x210
[  150.224693] [<ffffffff80619cd0>] kernel_init+0x10/0xf8
[  150.225069] [<ffffffff801063b8>] ret_from_kernel_thread+0x14/0x1c
[  150.225506]
^C
qemu-system-mips64el: terminating on signal 2

While hanging, QEMU is using 2 cores at 100%.

