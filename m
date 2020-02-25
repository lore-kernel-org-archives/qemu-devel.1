Return-Path: <SRS0=OzdF=4N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30D76C35E04
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 17:09:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EDA0020732
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 17:09:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gPJ4lyxR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EDA0020732
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60820 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6diD-0000ex-1d
	for qemu-devel@archiver.kernel.org; Tue, 25 Feb 2020 12:09:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46613)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j6dhR-0008Nq-Qe
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 12:08:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j6dhN-0007xn-LN
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 12:08:49 -0500
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:45567)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j6dhN-0007xJ-Fg
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 12:08:45 -0500
Received: by mail-oi1-x243.google.com with SMTP id v19so13243489oic.12
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2020 09:08:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
 bh=Kp56q3oI4teEfiymhSPkWaiej/Byo+VCQG8ZGPnKOSs=;
 b=gPJ4lyxRodAEAy5NtSk/thzMlH84DH6gOwTWMXFp81zPj0BNLMT+2AmF3ARHqnOv3R
 AzndE7SRqz7i7wj7o8jPO1KQRXCQpUGO++ltW6scUJPBrvHIbgu+LfMH1Rq2bd3t7mQo
 djHRlcV0bFGSZ5NkmSTFEB4CbRvpreqe+Gux6J4QCREoR5jOVxClvn/TnFeSjrBLNGFq
 OHHk90k1Im7WpRtlvTjCweeC+f56VdjIe8/Q09Sk3hR0MZta8aRrQ+6tHIRpVdJNT8Qd
 Kuh45k3Idkxq3QPD1ehHrxuslqLwhIP+ZbWy2NTIckYp2xgFmqmZRp4z4K5Q00pGDdXD
 HHKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to;
 bh=Kp56q3oI4teEfiymhSPkWaiej/Byo+VCQG8ZGPnKOSs=;
 b=gi2oGykcSeY+2fWDV+BreORB8oj4J+CwgbnjSUXOfRqdXbh3lNEZ75Qo0jCf6Eu1fY
 L71bw0On29iyfWjhhlFyi8fm571u+rOFxDHrX49zobalpOG3oGxuKEpRz/FgVFnrNATO
 C38S2BMdCD6FT0nWUs1afiehPVWtS64BaeNHxXbHnXPb0Nvmj8/Gdve2q877egFpPFFk
 ekyqh4MEJ2NLp9VwyNOCUQxbkIfc7fojnMcnC8mzoV17NpcRzrpwaZWxclbDNWQvoFI+
 HKbrTMi5VgSr6rT1iN/rfvxU1ZjSGdn3clOZtxDwEMkC42+wRH2hKJSb45RvjaT6HVWl
 b4QQ==
X-Gm-Message-State: APjAAAU0JraRH86wSaQp077nmgQaAz1wHUv1Afi6W7rNZ4btV/ypt2sF
 rlGimDTq+Jbi85sU6Sn73y2d1V/N8DcnzALvbxfgwxqw
X-Google-Smtp-Source: APXvYqyVrn2mufUUPmXbvDB+4VOojFYcYnEraKm3ITBw08skPEwgnMm59kmtwPbT6QyBa6Gyhh0wVnUO9rTpJ7rhGzk=
X-Received: by 2002:a54:4f16:: with SMTP id e22mr4589019oiy.170.1582650523865; 
 Tue, 25 Feb 2020 09:08:43 -0800 (PST)
MIME-Version: 1.0
References: <20190201160653.13829-1-peter.maydell@linaro.org>
 <20190201160653.13829-36-peter.maydell@linaro.org>
In-Reply-To: <20190201160653.13829-36-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 25 Feb 2020 17:08:32 +0000
Message-ID: <CAFEAcA8ZgeGom6wVmCih9wY-s+kJ-yEsty_=S7+KQ_tkidN-Og@mail.gmail.com>
Subject: Re: [PULL 35/47] target/arm: Send interrupts on PMU counter overflow
To: QEMU Developers <qemu-devel@nongnu.org>,
 Aaron Lindsay <Aaron@os.amperecomputing.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::243
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

On Fri, 1 Feb 2019 at 16:07, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> From: Aaron Lindsay OS <aaron@os.amperecomputing.com>
>
> Whenever we notice that a counter overflow has occurred, send an
> interrupt. This is made more reliable with the addition of a timer in a
> follow-on commit.
>
> Signed-off-by: Aaron Lindsay <aaron@os.amperecomputing.com>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Message-id: 20190124162401.5111-2-aaron@os.amperecomputing.com
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Hi Aaron -- I've just noticed a problem with this patch that
went into QEMU recently. The problem is that we can end up
calling pmu_update_irq(), which injects an interrupt, from
a raw-write function for some of the PMU registers. This is
bad because when we're using KVM the raw-write functions are
called as part of syncing state to and from the kernel. In
particular, if using '-cpu host,pmu=off' we don't set up the
PMU interrupt because we don't want to provide the guest a
PMU but then we can still find ourselves in this function,
and then we assert because we try to set a bogus interrupt.
Here's the backtrace:

#1  0x0000fffff6be68b4 in __GI_abort () at abort.c:79
#2  0x0000aaaaaae20820 in kvm_set_irq (s=0xaaaaabf8a020, irq=33554455, level=0)
    at /home/pm/qemu-bisect/accel/kvm/kvm-all.c:1277
#3  0x0000aaaaaafb7890 in kvm_arm_set_irq (cpu=0, irqtype=2, irq=23, level=0)
    at /home/pm/qemu-bisect/target/arm/kvm.c:897
#4  0x0000aaaaaae729dc in kvm_arm_gic_set_irq (num_irq=288, irq=23, level=0)
    at /home/pm/qemu-bisect/hw/intc/arm_gic_kvm.c:75
#5  0x0000aaaaaae72a1c in kvm_arm_gicv2_set_irq
(opaque=0xaaaaac169ff0, irq=279, level=0)
    at /home/pm/qemu-bisect/hw/intc/arm_gic_kvm.c:82
#6  0x0000aaaaab1ba15c in qemu_set_irq (irq=0xaaaaac186090, level=0)
    at /home/pm/qemu-bisect/hw/core/irq.c:44
#7  0x0000aaaaaaf86050 in pmu_update_irq (env=0xaaaaac0fa470)
    at /home/pm/qemu-bisect/target/arm/helper.c:1412
#8  0x0000aaaaaaf8747c in pmintenclr_write (env=0xaaaaac0fa470,
ri=0xaaaaac12c3e0, value=2154950974777589790) at
/home/pm/qemu-bisect/target/arm/helper.c:1903
#9  0x0000aaaaaaf83e68 in write_raw_cp_reg (env=0xaaaaac0fa470,
ri=0xaaaaac12c3e0, v=2154950976315703518) at
/home/pm/qemu-bisect/target/arm/helper.c:206
#10 0x0000aaaaaaf840d4 in write_cpustate_to_list (cpu=0xaaaaac0f0b90,
kvm_sync=true)
    at /home/pm/qemu-bisect/target/arm/helper.c:290
#11 0x0000aaaaaafbb1ac in kvm_arch_put_registers (cs=0xaaaaac0f0b90, level=3)
    at /home/pm/qemu-bisect/target/arm/kvm64.c:1108
#12 0x0000aaaaaae22ea0 in do_kvm_cpu_synchronize_post_init
(cpu=0xaaaaac0f0b90, arg=...)
    at /home/pm/qemu-bisect/accel/kvm/kvm-all.c:2223
#13 0x0000aaaaab107fa0 in process_queued_cpu_work (cpu=0xaaaaac0f0b90)
    at /home/pm/qemu-bisect/cpus-common.c:338
#14 0x0000aaaaaadf4ff4 in qemu_wait_io_event_common (cpu=0xaaaaac0f0b90)
    at /home/pm/qemu-bisect/cpus.c:1175
#15 0x0000aaaaaadf51a8 in qemu_wait_io_event (cpu=0xaaaaac0f0b90)
    at /home/pm/qemu-bisect/cpus.c:1215
#16 0x0000aaaaaadf52cc in qemu_kvm_cpu_thread_fn (arg=0xaaaaac0f0b90)
    at /home/pm/qemu-bisect/cpus.c:1251
#17 0x0000aaaaab690268 in qemu_thread_start (args=0xaaaaac14b1d0)
    at /home/pm/qemu-bisect/util/qemu-thread-posix.c:519


The point of the 'raw_read/write' accessors is that they're supposed
to not have side effects but just to be usable to read and write
any underlying register state. If the regdef doesn't define them
we fall back to the usual readfn/writefn on the assumption that
they're side-effect-free. So I think the fix here would be to
provide a raw_writefn everywhere where we've made
the normal writefn have a "sets an interrupt" side effect.

thanks
-- PMM

