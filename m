Return-Path: <SRS0=t76e=5M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9E9FC43331
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2020 00:01:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 70BED206E6
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2020 00:01:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=dabbelt-com.20150623.gappssmtp.com header.i=@dabbelt-com.20150623.gappssmtp.com header.b="gCtcLzqx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70BED206E6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=dabbelt.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35386 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHcRZ-0002mc-Ir
	for qemu-devel@archiver.kernel.org; Thu, 26 Mar 2020 20:01:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55632)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <palmer@dabbelt.com>) id 1jHcQT-0002II-IV
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 20:00:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <palmer@dabbelt.com>) id 1jHcQR-0003vg-2r
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 20:00:41 -0400
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:37491)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <palmer@dabbelt.com>) id 1jHcQQ-0003nk-MA
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 20:00:39 -0400
Received: by mail-pg1-x543.google.com with SMTP id a32so3709811pga.4
 for <qemu-devel@nongnu.org>; Thu, 26 Mar 2020 17:00:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
 h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
 :content-transfer-encoding;
 bh=SAn1nnFZvKIh4e7l7/1OgxHDBWJKSm33dEkqyjW94hQ=;
 b=gCtcLzqx7Gd0WfjU639XZJrmfHfpuH+QGytomc2/rmQact42SaXyDr/LA2KBa0WmSD
 V1vutFEqs2B86wbzVz18T4JKgg3G2/QXhOTUxNi3wJ4mmEPdSq3XcfMvmRav9o2q9exk
 MnLZtwCpZeFq8LWEd1vL0/z1NTzejV/wqXcWr7S0J6ACTxQB5vgY3UZn/i4D/UFaRMi7
 hvoZi6r/yqItFZtWMW/TOWzYBvmQuUYBhHlK4sLL80icr3WIEKhkJGymOarIEwKe5qpR
 dV/kIGhtQ1phCVpbdFirulIYRwAYbGsVr6yJJYpV7d3L5a7VocikMm/QPcKvaWdCSTzj
 UaRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
 :mime-version:content-transfer-encoding;
 bh=SAn1nnFZvKIh4e7l7/1OgxHDBWJKSm33dEkqyjW94hQ=;
 b=I+lCGTbrptUWjNl4TsZl4/Uphz+0EvLGvh/LRdraXqmXWcgdkzrTWOdoWAuMxE5Fsn
 4Ag1kCn12YXQsprpB6SEf52XNfaUgb2Xfx0HEvQFcZ5HeKUS410uwxnqFQGrZk6mEzWz
 wXYT2imioV564zY9I2ExE9LBwbys282PmUpGBDteMJUWd7kk8Awn5rHIofUwNAzCpS8h
 wr2puq7My/WFHITJ14UaTE62ovQsCh95sr/DvmPXmockuIrLZoOpIB8FIgUm5v+SGAyt
 65IYI2EvHjHGJhBN9cpVKsZvyy/z3f8wCfkHJ1JRcXYBL+LlHXDl9Nb0L+97UEbjkVGX
 UObw==
X-Gm-Message-State: ANhLgQ1iIRcf85SSF8Qlgzm7cvbMYbhhwYU2uMuyYmehu3m8K5/VMrUf
 Oi4Py9dJNLASYzjbW02WaxwaMg5Anes=
X-Google-Smtp-Source: ADFU+vtUwupELF+0uo6irhfwziGhrKGLzWF2lotLbAjHlZpeIww4OFgY7h+Q3lEq6cbTSKiCNhQCvA==
X-Received: by 2002:a63:154b:: with SMTP id 11mr11133228pgv.11.1585267227431; 
 Thu, 26 Mar 2020 17:00:27 -0700 (PDT)
Received: from localhost (c-67-161-15-180.hsd1.ca.comcast.net. [67.161.15.180])
 by smtp.gmail.com with ESMTPSA id f5sm2739018pfq.63.2020.03.26.17.00.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Mar 2020 17:00:26 -0700 (PDT)
Date: Thu, 26 Mar 2020 17:00:26 -0700 (PDT)
X-Google-Original-Date: Thu, 26 Mar 2020 17:00:24 PDT (-0700)
Subject: Re: [PATCH for 5.0 v1 0/2]  RISC-V: Fix Hypervisor guest user space
In-Reply-To: <cover.1585262586.git.alistair.francis@wdc.com>
From: Palmer Dabbelt <palmer@dabbelt.com>
To: Alistair Francis <Alistair.Francis@wdc.com>
Message-ID: <mhng-f7361188-1bb2-4ea3-bc25-3076f877aa64@palmerdabbelt-glaptop1>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::543
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
Cc: Alistair Francis <Alistair.Francis@wdc.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org, alistair23@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 26 Mar 2020 15:44:04 PDT (-0700), Alistair Francis wrote:
> This series fixes two bugs in the RISC-V two stage lookup
> implementation. This fixes the Hypervisor userspace failing to start.
>
> Alistair Francis (2):
>   riscv: Don't use stage-2 PTE lookup protection flags
>   riscv: AND stage-1 and stage-2 protection flags
>
>  target/riscv/cpu_helper.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)

Thanks, these are in the queue.

