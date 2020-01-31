Return-Path: <SRS0=aXOp=3U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F54FC33CB2
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2020 10:29:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EC10720707
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2020 10:29:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="m2ZfWMgL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC10720707
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51024 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ixTYB-0007eU-58
	for qemu-devel@archiver.kernel.org; Fri, 31 Jan 2020 05:29:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52399)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mpe@ellerman.id.au>) id 1ixTXU-00076R-LH
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 05:28:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mpe@ellerman.id.au>) id 1ixTXT-0002Yz-1R
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 05:28:40 -0500
Received: from ozlabs.org ([203.11.71.1]:45801)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mpe@ellerman.id.au>)
 id 1ixTXS-0002QA-8a; Fri, 31 Jan 2020 05:28:38 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 488D2j2vhcz9sPJ;
 Fri, 31 Jan 2020 21:28:29 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
 s=201909; t=1580466510;
 bh=+EqOBBXayAg4ya5Zt7Dhm3AMnqqehLq6EoiioL6e0Pc=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=m2ZfWMgLDxgJd3yN7/OH1Lo+i+LNKhIltkWG47RnVMUagtGB2LpudJ0sqQNvLpCf6
 R6s9s5URNTQO/YmNhxpcji8MS0nx2EKxSEzHWpdTDjLrLdWgTRVoEvKyJC/Iged+6k
 /91o7i3afTaEXWtC8kXdPW8cCuUAi7H+MrQp6lN/TrxFYJ/GVBOr/9wkobMqnkONOe
 3J01Zyi94u+jf2zfSSm5RROF1ouN+TgRCY7p4W0pyhwiOEckVkBu9zUrOIIZ5/+f2z
 tFQEfsNu0carFGPqkQpTSDmG2G7atrdCHdhO6ArTMMC7s26wbnArW+U+YBrKKCmd0b
 aBM4QeX4pjbVQ==
From: Michael Ellerman <mpe@ellerman.id.au>
To: David Gibson <david@gibson.dropbear.id.au>, groug@kaod.org, clg@kaod.org
Subject: Re: [PATCH] spapr: Enable DD2.3 accelerated count cache flush in
 pseries-5.0 machine
In-Reply-To: <20200130012622.8564-1-david@gibson.dropbear.id.au>
References: <20200130012622.8564-1-david@gibson.dropbear.id.au>
Date: Fri, 31 Jan 2020 21:28:26 +1100
Message-ID: <87sgjvgbsl.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 203.11.71.1
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
Cc: lvivier@redhat.com, aik@ozlabs.ru, qemu-devel@nongnu.org, paulus@samba.org,
 qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

David Gibson <david@gibson.dropbear.id.au> writes:
> For POWER9 DD2.2 cpus, the best current Spectre v2 indirect branch
> mitigation is "count cache disabled", which is configured with:
>     -machine cap-ibs=fixed-ccd
> However, this option isn't available on DD2.3 CPUs with KVM, because they
> don't have the count cache disabled.
>
> For POWER9 DD2.3 cpus, it is "count cache flush with assist", configured
> with:
>     -machine cap-ibs=workaround,cap-ccf-assist=on
> However this option isn't available on DD2.2 CPUs with KVM, because they
> don't have the special CCF assist instruction this relies on.
>
> On current machine types, we default to "count cache flush w/o assist",
> that is:
>     -machine cap-ibs=workaround,cap-ccf-assist=off
> This runs, with mitigation on both DD2.2 and DD2.3 host cpus, but has a
> fairly significant performance impact.
>
> It turns out we can do better.  The special instruction that CCF assist
> uses to trigger a count cache flush is a no-op on earlier CPUs, rather than
> trapping or causing other badness.  It doesn't, of itself, implement the
> mitigation, but *if* we have count-cache-disabled, then the count cache
> flush is unnecessary, and so using the count cache flush mitigation is
> harmless.
>
> Therefore for the new pseries-5.0 machine type, enable cap-ccf-assist by
> default.  Along with that, suppress throwing an error if cap-ccf-assist
> is selected but KVM doesn't support it, as long as KVM *is* giving us
> count-cache-disabled.  To allow TCG to work out of the box, even though it
> doesn't implement the ccf flush assist, downgrade the error in that case to
> a warning.  This matches several Spectre mitigations where we allow TCG
> to operate for debugging, since we don't really make guarantees about TCG
> security properties anyway.
>
> While we're there, make the TCG warning for this case match that for other
> mitigations.
>
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> ---
>  hw/ppc/spapr.c      |  5 ++++-
>  hw/ppc/spapr_caps.c | 26 ++++++++++++++++++++++----
>  2 files changed, 26 insertions(+), 5 deletions(-)
>
> I have put this into my ppc-for-5.0 tree already, and hope to send a
> pull request tomorrow (Jan 31).

I tested this on a DD 2.2 machine, seems to work as designed.

I had to modify our spectre_v2 test slightly because it is confused
about the sysfs reported mitigation not reflecting reality, but that is
an existing issue.

cheers


# uname -r
5.5.0-gcc-8.2.0

# cat /proc/cpuinfo 
processor       : 0
cpu             : POWER9 (architected), altivec supported
clock           : 3000.000000MHz
revision        : 2.2 (pvr 004e 1202)

timebase        : 512000000
platform        : pSeries
model           : IBM pSeries (emulated by qemu)
machine         : CHRP IBM pSeries (emulated by qemu)
MMU             : Radix

# grep . /sys/devices/system/cpu/vulnerabilities/*
/sys/devices/system/cpu/vulnerabilities/itlb_multihit:Not affected
/sys/devices/system/cpu/vulnerabilities/l1tf:Mitigation: RFI Flush, L1D private per thread
/sys/devices/system/cpu/vulnerabilities/mds:Not affected
/sys/devices/system/cpu/vulnerabilities/meltdown:Mitigation: RFI Flush, L1D private per thread
/sys/devices/system/cpu/vulnerabilities/spec_store_bypass:Mitigation: Kernel entry/exit barrier (eieio)
/sys/devices/system/cpu/vulnerabilities/tsx_async_abort:Not affected
/sys/devices/system/cpu/vulnerabilities/spectre_v1:Mitigation: __user pointer sanitization, ori31 speculation barrier enabled

/sys/devices/system/cpu/vulnerabilities/spectre_v2:Mitigation: Software count cache flush (hardware accelerated), Software link stack flush

# /spectre_v2 
test: spectre_v2
tags: git_version:v5.5-1-g0b2cecc02bf1
sysfs reports: 'Mitigation: Software count cache flush (hardware accelerated), Software link stack flush'
HW accelerated count cache flush on P9N DD2.2 => actually count cache disabled.
 PM_BR_PRED_CCACHE: result 2147483649 running/enabled 19406588726
PM_BR_MPRED_CCACHE: result 2147483649 running/enabled 19406580624
 PM_BR_PRED_PCACHE: result          0 running/enabled 19406574530
PM_BR_MPRED_PCACHE: result          0 running/enabled 19406571036
Miss percent 100 %
OK - Measured branch prediction rates match reported spectre v2 mitigation.
success: spectre_v2

# [   47.183779][    C0] sysrq: Entering xmon
0:mon> di $_switch
c00000000040e280  7c0802a6      mflr    r0
c00000000040e284  f8010010      std     r0,16(r1)
c00000000040e288  f821fe21      stdu    r1,-480(r1)
c00000000040e28c  f9c100e0      std     r14,224(r1)
c00000000040e290  f9e100e8      std     r15,232(r1)
c00000000040e294  fa0100f0      std     r16,240(r1)
c00000000040e298  fa2100f8      std     r17,248(r1)
c00000000040e29c  fa410100      std     r18,256(r1)
c00000000040e2a0  fa610108      std     r19,264(r1)
c00000000040e2a4  fa810110      std     r20,272(r1)
c00000000040e2a8  faa10118      std     r21,280(r1)
c00000000040e2ac  fac10120      std     r22,288(r1)
c00000000040e2b0  fae10128      std     r23,296(r1)
c00000000040e2b4  fb010130      std     r24,304(r1)
c00000000040e2b8  fb210138      std     r25,312(r1)
c00000000040e2bc  fb410140      std     r26,320(r1)
c00000000040e2c0  fb610148      std     r27,328(r1)
c00000000040e2c4  fb810150      std     r28,336(r1)
c00000000040e2c8  fba10158      std     r29,344(r1)
c00000000040e2cc  fbc10160      std     r30,352(r1)
c00000000040e2d0  fbe10168      std     r31,360(r1)
c00000000040e2d4  f8010170      std     r0,368(r1)
c00000000040e2d8  7ee00026      mfcr    r23
c00000000040e2dc  fae101a0      std     r23,416(r1)
c00000000040e2e0  f8230000      std     r1,0(r3)
c00000000040e2e4  4bffdafd      bl      c00000000040bde0        # flush_count_cache+0x0/0x24a0

0:mon> di $flush_count_cache
c00000000040bde0  7d2802a6      mflr    r9

# This is the link stack flush ...
c00000000040bde4  48000005      bl      c00000000040bde8        # flush_count_cache+0x8/0x24a0
 ...
0:mon> 
c00000000040be20  48000005      bl      c00000000040be24        # flush_count_cache+0x44/0x24a0
 ...
0:mon> 
c00000000040be60  48000005      bl      c00000000040be64        # flush_count_cache+0x84/0x24a0
 ...
0:mon> 
c00000000040bea0  48000005      bl      c00000000040bea4        # flush_count_cache+0xc4/0x24a0
 ...
0:mon> 
c00000000040bee0  48000005      bl      c00000000040bee4        # flush_count_cache+0x104/0x24a0
c00000000040bee4  4800001c      b       c00000000040bf00        # flush_count_cache+0x120/0x24a0
c00000000040bee8  60000000      nop
 ...
c00000000040bf00  7d2803a6      mtlr    r9
c00000000040bf04  60000000      nop
c00000000040bf08  39207fff      li      r9,32767
c00000000040bf0c  7d2903a6      mtctr   r9

# This is the HW accelerated count cache flush
c00000000040bf10  4c400420      bcctr-  2,lt
c00000000040bf14  4e800020      blr


