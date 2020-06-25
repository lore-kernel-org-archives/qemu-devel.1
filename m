Return-Path: <SRS0=KdPs=AG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 980CEC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 15:55:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F3DA2089D
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 15:55:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JPNcOjj0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F3DA2089D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50332 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joUDc-000478-Ln
	for qemu-devel@archiver.kernel.org; Thu, 25 Jun 2020 11:55:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39886)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dstepanov.src@gmail.com>)
 id 1joTpn-0007fB-RJ
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 11:30:39 -0400
Received: from mail-lj1-x242.google.com ([2a00:1450:4864:20::242]:32797)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dstepanov.src@gmail.com>)
 id 1joTpm-0001d3-2g
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 11:30:39 -0400
Received: by mail-lj1-x242.google.com with SMTP id s1so7019754ljo.0
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2020 08:30:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=z8dMPxmLcXy563vvmagKHVd2IuiKkYRe7Isf4iaDzX0=;
 b=JPNcOjj0EAnsleCGkha9qEEHELLvjoVN1OWURyA9xTovG0tci8x33ESHJZ0tFbQ3CV
 9lZFrdopVc0XcpCqC7+v9BmZyavxcSnL22ST8i/ErxwFbHu1QYau02Nf/uQK32ezKS7T
 I59wcr+EPwp9TgmeJ25C4QtIyGAKt9F7aoA0/GUPDKyxUOKcBWo889DbXDtdAn+etS2/
 IxK6HmCJ43cSjbDwY1QSVLwMPmI7Xf1mKa6RmRbpfOENlE/j6HMptpW1uCSxvhrkhHBA
 QcNV87s4hONmWW9OxPt8RsYywcne0JoQ6xdy3PwK8VQSvhI+yLWxl+fULwo25SPttyY6
 2nKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=z8dMPxmLcXy563vvmagKHVd2IuiKkYRe7Isf4iaDzX0=;
 b=EBOi1s39FTSZ9lOvQVsKNkF/O6Ej9/lG/FYYZHOCvxl2Tv4oh7eFMrbE1545ey+eQH
 13/R4ZN6iXsHtD3szVeg6dwqgRzm90iRPYiLDePuJQ9QczuC9E0TYbNiDRnsS/uuP9Rj
 IM6M/QTSRWIrNJ4+oeO/OZPf20BRrq4RMcLj5CdEhJM/ngC4uM6caDsNPC+BRRykiYR8
 2lZ/FHSl8OReqMl0ZPgXH24EL79ZOvdeah6eOjYsTl50P/DYyuid5FoJHIwG3X7KUlob
 jI3OtK5/B8DUOQHFTJKCw2f92yRMwn+LZ2wVXEeYpnTNp2SzuxkK1M4GA3LZ0LLWP7fE
 PVRA==
X-Gm-Message-State: AOAM532QRZQOFLVqdAP697A1s7q1bKjYNp8xDruPwA5uU+TuSDknV5Jm
 7xKQ+NA9pH74iUh0XIFDW/g=
X-Google-Smtp-Source: ABdhPJwI95JePr0jcG3HDgWKFewF4pCFlSIGHnhl7aSTmsIfcO82gh+g4OtwyAu2cAZpR9tf/W9OHg==
X-Received: by 2002:a2e:890d:: with SMTP id d13mr17500160lji.75.1593099035486; 
 Thu, 25 Jun 2020 08:30:35 -0700 (PDT)
Received: from dimastep-nix ([2a02:6b8:b080:6405::1:10])
 by smtp.gmail.com with ESMTPSA id k20sm664716ljc.111.2020.06.25.08.30.34
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 25 Jun 2020 08:30:34 -0700 (PDT)
Date: Thu, 25 Jun 2020 18:30:32 +0300
From: Dima Stepanov <dstepanov.src@gmail.com>
To: Stefan Hajnoczi <stefanha@gmail.com>
Subject: Re: [RFC PATCH 0/3] fuzz: add generic fuzzer
Message-ID: <20200625153031.GA18435@dimastep-nix>
References: <20200611055651.13784-1-alxndr@bu.edu>
 <20200623141601.GL36568@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200623141601.GL36568@stefanha-x1.localdomain>
User-Agent: Mutt/1.5.24 (2015-08-30)
Received-SPF: pass client-ip=2a00:1450:4864:20::242;
 envelope-from=dstepanov.src@gmail.com; helo=mail-lj1-x242.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 25 Jun 2020 11:44:55 -0400
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
Cc: darren.kenny@oracle.com, f4bug@amsat.org, qemu-devel@nongnu.org,
 Alexander Bulekov <alxndr@bu.edu>, bsd@redhat.com, stefanha@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Jun 23, 2020 at 03:16:01PM +0100, Stefan Hajnoczi wrote:
> On Thu, Jun 11, 2020 at 01:56:48AM -0400, Alexander Bulekov wrote:
> > These patches add a generic fuzzer for virtual devices. This should
> > allow us to fuzz devices that accept inputs over MMIO, PIO and DMA
> > without any device-specific code.
> > 
> > Example:
> > QEMU_FUZZ_ARGS="-device virtio-net" \
> > FUZZ_REGION_WHITELIST="virtio pci-" \
> > ./i386-softmmu/qemu-fuzz-i386 --fuzz-target=general-pci-enum-fuzz
> > 
> > The above command will add a virtio-net device to the QEMU arguments and
> > restrict the fuzzer to only interact with MMIO and PIO regions with
> > names that contain "virtio" or "pci-". I find these names using the info
> > mtree monitor command. 
> > 
> > Basically, the fuzzer splits the input into a series of commands, such
> > as mmio_write, pio_write, etc. Additionally, these patches add "hooks"
> > to functions that are typically used by virtual-devices to read from RAM
> > (DMA). These hooks attempt to populate these DMA regions with fuzzed
> > data, just in time.  There are some differences from my reference code
> > that seem to result in performance issues that I am still trying to iron
> > out. I also need to figure out how to add the DMA "hooks" in a neat way.
> > Maybe I can use -Wl,--wrap for this. I appreciate any feedback.
> > 
> > Alexander Bulekov (3):
> >   fuzz: add a general fuzzer for any qemu arguments
> >   fuzz: add support for fuzzing DMA regions
> >   fuzz: Add callbacks for dma-access functions
> > 
> >  exec.c                                |  17 +-
> >  include/exec/memory.h                 |   8 +
> >  include/exec/memory_ldst_cached.inc.h |   9 +
> >  include/sysemu/dma.h                  |   5 +-
> >  memory_ldst.inc.c                     |  12 +
> >  tests/qtest/fuzz/Makefile.include     |   1 +
> >  tests/qtest/fuzz/general_fuzz.c       | 556 ++++++++++++++++++++++++++
> >  7 files changed, 606 insertions(+), 2 deletions(-)
> >  create mode 100644 tests/qtest/fuzz/general_fuzz.c
> 
> CCing Dima in case he is interested in this generic fuzzing approach.
> 
> Stefan
Thanks for adding me, going to look into it on this weekend.

Dima.



