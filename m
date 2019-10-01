Return-Path: <SRS0=WBSu=X2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FF0CECE587
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 18:36:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D607E2133F
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 18:36:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="guw706Aa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D607E2133F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46548 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFN13-00024b-PR
	for qemu-devel@archiver.kernel.org; Tue, 01 Oct 2019 14:36:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41465)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <palmer@sifive.com>) id 1iFMyM-0008L3-AK
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 14:34:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <palmer@sifive.com>) id 1iFMyL-0002jK-7o
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 14:34:06 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:38442)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <palmer@sifive.com>) id 1iFMyL-0002iw-34
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 14:34:05 -0400
Received: by mail-pf1-x443.google.com with SMTP id h195so8666425pfe.5
 for <qemu-devel@nongnu.org>; Tue, 01 Oct 2019 11:34:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com; s=google;
 h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
 :content-transfer-encoding;
 bh=pz0D2/ekdx2L9LGzzrxsNOaKJHXNmStYb+seabNgP4U=;
 b=guw706AaJmsMfXFv3V0/dkcEGkRJV8Zpo6DD6r+I4Wco1GUg+8GC1fItDK1oOn+RrY
 wKBZFTLoEz1hDKtzgGqw42oDqaqlPsSneVjWANDxL7SpLEH6HOVtaSuQzFi7BlYrMgLO
 TWlaZ5wCM5p6lD+gbIokIkdsuh6bEShVBfPHTAsEoFGJX8kHkvGlONtiQ752/4Z1FCWa
 RBFuH4eDrGG6daCfrMdWpSt8medpbhr64NXwSp2LZRqXwJTow3My/kbpohQKd12Gte7U
 7R+ekfmjccO05nlkzV2yWgD8bBMJbv7i3OOv0iza/7FDZVbi5cqPIXY5mSNaXDkxoxiH
 sxaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
 :mime-version:content-transfer-encoding;
 bh=pz0D2/ekdx2L9LGzzrxsNOaKJHXNmStYb+seabNgP4U=;
 b=YAduDEonwykARjkkNmF9+vLUfYgzsuF80vkpq378omcuf9lkB/IHt9jMBcEzZ4IPIf
 dhPasd9ipsltAnxfejcrhJD7mHmX2wS1naiV2de0wRmu2RQ8aLniNm4hzG3YlK68d6Fa
 vAw3TwQpJneTcJr0qtqn4PdzzNIGswg7TfpgRhHYFb4qORqqtqj9pNnK1mvoCfr1S/Rn
 jTLzrOZlsl49VZrLv8N9y5mZ/wgWiYjZ/2yfTrd76YdX2F5qbjJX307mrovtHVqUwxE8
 H3X3eTYaaVRnYuTq7YsQIgLRrmYlEwtQnhGqgzFwORpWJvAuTGZ3G5Vv9bdrxy345tUf
 2/Gw==
X-Gm-Message-State: APjAAAX/hifGWWeEZltD+bDQQK9xJ0lp2WIb9/VjPhTOWOyfsmyqJfc2
 8axR/wizvkvs93rJEUcsbiddmjRmnqvf9Q==
X-Google-Smtp-Source: APXvYqwV2fJBmWzaXEmemHqqxag+iUPHQUA/uYzzIQqSbah6Jk4gGnuZgAt+ECX4o0NC2I51lJA15g==
X-Received: by 2002:a63:ed10:: with SMTP id d16mr32422317pgi.307.1569954843724; 
 Tue, 01 Oct 2019 11:34:03 -0700 (PDT)
Received: from localhost ([12.206.222.5])
 by smtp.gmail.com with ESMTPSA id r30sm19308133pfl.42.2019.10.01.11.34.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Oct 2019 11:34:03 -0700 (PDT)
Date: Tue, 01 Oct 2019 11:34:03 -0700 (PDT)
X-Google-Original-Date: Tue, 01 Oct 2019 11:32:24 PDT (-0700)
Subject: Re: [PATCH v1 19/28] target/riscv: Disable guest FP support based on
 virtual status
In-Reply-To: <4f1ff6ef5fb2baa3c461d16b5669d3bd829733a0.1566603412.git.alistair.francis@wdc.com>
From: Palmer Dabbelt <palmer@sifive.com>
To: Alistair Francis <Alistair.Francis@wdc.com>
Message-ID: <mhng-caebff54-201e-4407-a992-d99a8a33817c@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::443
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
Cc: qemu-riscv@nongnu.org, Anup Patel <Anup.Patel@wdc.com>,
 qemu-devel@nongnu.org, Atish Patra <Atish.Patra@wdc.com>,
 Alistair Francis <Alistair.Francis@wdc.com>, alistair23@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 23 Aug 2019 16:38:39 PDT (-0700), Alistair Francis wrote:
> When the Hypervisor extension is in use we only enable floating point
> support when both status and vsstatus have enabled floating point
> support.
>
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> ---
>  target/riscv/cpu_helper.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
> index 17eec6217b..098873c83e 100644
> --- a/target/riscv/cpu_helper.c
> +++ b/target/riscv/cpu_helper.c
> @@ -90,6 +90,9 @@ bool riscv_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
>  bool riscv_cpu_fp_enabled(CPURISCVState *env)
>  {
>      if (*env->mstatus & MSTATUS_FS) {
> +        if (riscv_cpu_virt_enabled(env) && !(env->vsstatus & MSTATUS_FS)) {
> +            return false;
> +        }
>          return true;
>      }

Reviewed-by: Palmer Dabbelt <palmer@sifive.com>

