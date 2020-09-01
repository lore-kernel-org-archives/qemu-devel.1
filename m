Return-Path: <SRS0=/2J2=CK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4135C433E6
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 11:50:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8BFE320707
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 11:50:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LA/V3Ra/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8BFE320707
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53690 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kD4o4-0000rq-Me
	for qemu-devel@archiver.kernel.org; Tue, 01 Sep 2020 07:50:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46856)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kD4nK-0000Ay-Bm
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 07:49:46 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:32110
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kD4nG-0002Hd-S9
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 07:49:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598960981;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=PzKvZH3d5FJC1HOZOv9QBhJ1lqY2KNPQmOA7/9fGmRo=;
 b=LA/V3Ra/YRLZ81bz/qPHadhDdDdz75cRSai7NEPz26usGH90yu/byV17/X+FFDnMTdgjzK
 Z+gbayED+byEM3H5HPfsFXnXr4sWbZwpX+SMMzKqeyIo6j+hyJdeK/NoaGDyCNNFHuuWBh
 IPLOt7yiWN08noFCsqg6IUjtCrbXU1U=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-235-IPVwjklWMIOpU-I7PpT-Lg-1; Tue, 01 Sep 2020 07:49:40 -0400
X-MC-Unique: IPVwjklWMIOpU-I7PpT-Lg-1
Received: by mail-wm1-f71.google.com with SMTP id x81so357058wmg.8
 for <qemu-devel@nongnu.org>; Tue, 01 Sep 2020 04:49:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=PzKvZH3d5FJC1HOZOv9QBhJ1lqY2KNPQmOA7/9fGmRo=;
 b=NSGjPoVt+6ABENYtv3ZfltTXicxjhcOnM+ADoIffBj45LDfyKcvzRB/uI6fvgsI/pR
 STsY6cFwqPV0NSEnTBYGn8Y5ZGgQSg4d78ipGpsitXe+vqQ57ZaQg6Ljgc/yZE4GZvDV
 UpAuugM2iB9qN+71l3iHXJhYvbpuyQKCHQAESE7sFPrEi29CgmsEcWBYzckGUtAhn96t
 gQWhAazxoQZjS2TCQzhj1Z9xPAQAvKnFhtn7ARdNfd1ZDHdR67t0awHSqxKDfnBdxl2q
 mNUx/buWJxCvTdmVlB4DifpoRLh7PPfajSQIFhhzbldacJeqhSB+fb/BOev8QUpFnEUZ
 X5lg==
X-Gm-Message-State: AOAM5339a2l79vRGqMBUXtPJYmOMKoK5ewdcYL/OHjomueHlqPc4o6nD
 1rvWbN7GNG2JM1WI/X8mWcZNviUQoEKy2PMPSuF/Zb5yLAUG90BOgoiyCor81QjD0GuN/YFae2m
 TptuMC4xYQwKZi5w=
X-Received: by 2002:a1c:f709:: with SMTP id v9mr1422876wmh.165.1598960979196; 
 Tue, 01 Sep 2020 04:49:39 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyBvPPqxlUSMpwVQUln2PJmkhud27XS/SOI3dWzHM1MJkKk2BlZYDFO3ULdYTj3Dy55Qo1RLA==
X-Received: by 2002:a1c:f709:: with SMTP id v9mr1422856wmh.165.1598960978962; 
 Tue, 01 Sep 2020 04:49:38 -0700 (PDT)
Received: from redhat.com (bzq-79-181-14-13.red.bezeqint.net. [79.181.14.13])
 by smtp.gmail.com with ESMTPSA id
 v2sm1848051wrn.44.2020.09.01.04.49.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Sep 2020 04:49:38 -0700 (PDT)
Date: Tue, 1 Sep 2020 07:49:34 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Nathan Chancellor <natechancellor@gmail.com>
Subject: Re: [PATCH] riscv: sifive_test: Allow 16-bit writes to memory region
Message-ID: <20200901074918-mutt-send-email-mst@kernel.org>
References: <20200901055822.2721209-1-natechancellor@gmail.com>
 <20200901065406-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20200901065406-mutt-send-email-mst@kernel.org>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0.003
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=mst@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/01 00:57:59
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: qemu-riscv@nongnu.org, Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org,
 qemu-stable@nongnu.org, Alistair Francis <Alistair.Francis@wdc.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Palmer Dabbelt <palmer@dabbelt.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Sep 01, 2020 at 07:08:34AM -0400, Michael S. Tsirkin wrote:
> On Mon, Aug 31, 2020 at 10:58:23PM -0700, Nathan Chancellor wrote:
> > When shutting down the machine running a mainline Linux kernel, the
> > following error happens:
> > 
> > $ build/riscv64-softmmu/qemu-system-riscv64 -bios default -M virt \
> >     -display none -initrd rootfs.cpio -kernel Image -m 512m \
> >     -nodefaults -serial mon:stdio
> > ...
> > Requesting system poweroff
> > [    4.999630] reboot: Power down
> > sbi_trap_error: hart0: trap handler failed (error -2)
> > sbi_trap_error: hart0: mcause=0x0000000000000007 mtval=0x0000000000100000
> > sbi_trap_error: hart0: mepc=0x000000008000d4cc mstatus=0x0000000000001822
> > sbi_trap_error: hart0: ra=0x000000008000999e sp=0x0000000080015c78
> > sbi_trap_error: hart0: gp=0xffffffe000e76610 tp=0xffffffe0081b89c0
> > sbi_trap_error: hart0: s0=0x0000000080015c88 s1=0x0000000000000040
> > sbi_trap_error: hart0: a0=0x0000000000000000 a1=0x0000000080004024
> > sbi_trap_error: hart0: a2=0x0000000080004024 a3=0x0000000080004024
> > sbi_trap_error: hart0: a4=0x0000000000100000 a5=0x0000000000005555
> > sbi_trap_error: hart0: a6=0x0000000000004024 a7=0x0000000080011158
> > sbi_trap_error: hart0: s2=0x0000000000000000 s3=0x0000000080016000
> > sbi_trap_error: hart0: s4=0x0000000000000000 s5=0x0000000000000000
> > sbi_trap_error: hart0: s6=0x0000000000000001 s7=0x0000000000000000
> > sbi_trap_error: hart0: s8=0x0000000000000000 s9=0x0000000000000000
> > sbi_trap_error: hart0: s10=0x0000000000000000 s11=0x0000000000000008
> > sbi_trap_error: hart0: t0=0x0000000000000000 t1=0x0000000000000000
> > sbi_trap_error: hart0: t2=0x0000000000000000 t3=0x0000000000000000
> > sbi_trap_error: hart0: t4=0x0000000000000000 t5=0x0000000000000000
> > sbi_trap_error: hart0: t6=0x0000000000000000
> > 
> > The kernel does a 16-bit write when powering off the machine, which
> > was allowed before commit 5d971f9e67 ("memory: Revert "memory: accept
> > mismatching sizes in memory_region_access_valid""). Make min_access_size
> > match reality so that the machine can shut down properly now.
> > 
> > Cc: qemu-stable@nongnu.org
> > Fixes: 88a07990fa ("SiFive RISC-V Test Finisher")
> > Fixes: 5d971f9e67 ("memory: Revert "memory: accept mismatching sizes in memory_region_access_valid"")
> > Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> > ---
> > 
> > Please let me know if the tags are wrong or inappropriate, this is my
> > first QEMU patch.
> > 
> >  hw/riscv/sifive_test.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/hw/riscv/sifive_test.c b/hw/riscv/sifive_test.c
> > index 0c78fb2c93..8c70dd69df 100644
> > --- a/hw/riscv/sifive_test.c
> > +++ b/hw/riscv/sifive_test.c
> > @@ -59,7 +59,7 @@ static const MemoryRegionOps sifive_test_ops = {
> >      .write = sifive_test_write,
> >      .endianness = DEVICE_NATIVE_ENDIAN,
> 
> 
> Apropos, why is this native endian?
> The write handler seems to ignore target endian-ness,
> looks like a bug ...


patch itself looks fine

Acked-by: Michael S. Tsirkin <mst@redhat.com>

> >      .valid = {
> > -        .min_access_size = 4,
> > +        .min_access_size = 2,
> >          .max_access_size = 4
> >      }
> >  };
> > 
> > base-commit: 2f4c51c0f384d7888a04b4815861e6d5fd244d75
> > -- 
> > 2.28.0


