Return-Path: <SRS0=BocF=C2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BFE4C43461
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 16:32:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8DA2520795
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 16:32:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WvSbMiAb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DA2520795
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37126 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIwpK-0000lQ-AE
	for qemu-devel@archiver.kernel.org; Thu, 17 Sep 2020 12:32:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52372)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kIwnr-0008Pg-Oc
 for qemu-devel@nongnu.org; Thu, 17 Sep 2020 12:30:35 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:49398
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kIwnp-0000mb-Ri
 for qemu-devel@nongnu.org; Thu, 17 Sep 2020 12:30:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600360233;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=io57eP3Aqxz6Ynhm6MRvNTAzfhOeJYdT3+6hZ4JGK64=;
 b=WvSbMiAbAYlHryH9BPQCZoHwD0YlE1Rknw83ZwAzt8VfpemnLFNx/ZA6aDwFrHImDiMCTi
 +NIZnYf7Efc7PaLv2pjC9i+mK9EPRjJUqlORp0ukKbVoW2s5C+EC88RAvXVmztKDJBCRiZ
 nERnpm50LEmYmY34TKTZhwFGos4zdbE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-191-0iv7AWShM8mQEVBtIHpOQA-1; Thu, 17 Sep 2020 12:30:29 -0400
X-MC-Unique: 0iv7AWShM8mQEVBtIHpOQA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B751A1009607;
 Thu, 17 Sep 2020 16:30:27 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-113-38.ams2.redhat.com [10.36.113.38])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 30BC11000320;
 Thu, 17 Sep 2020 16:30:18 +0000 (UTC)
Subject: Re: [PATCH v2 09/10] disas: Enable capstone disassembly for s390x
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20200914230210.2185860-1-richard.henderson@linaro.org>
 <20200914230210.2185860-10-richard.henderson@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <8d62af90-ab13-f912-fe90-917a72fcc6cb@redhat.com>
Date: Thu, 17 Sep 2020 18:30:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200914230210.2185860-10-richard.henderson@linaro.org>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=thuth@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Received-SPF: pass client-ip=207.211.31.120; envelope-from=thuth@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/17 02:16:16
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.997,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: luoyonggang@gmail.com, alex.bennee@linaro.org,
 qemu-s390x <qemu-s390x@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 15/09/2020 01.02, Richard Henderson wrote:
> Enable s390x, aka SYSZ, in the git submodule build.
> Set the capstone parameters for both s390x host and guest.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  disas.c            |  3 +++
>  target/s390x/cpu.c |  4 ++++
>  meson.build        | 11 +++++++++++
>  3 files changed, 18 insertions(+)
> 
> diff --git a/disas.c b/disas.c
> index e27dea2c19..c4cd305190 100644
> --- a/disas.c
> +++ b/disas.c
> @@ -201,6 +201,9 @@ static void initialize_debug_host(CPUDebug *s)
>      s->info.print_insn = print_insn_m68k;
>  #elif defined(__s390__)
>      s->info.print_insn = print_insn_s390;
> +    s->info.cap_arch = CS_ARCH_SYSZ;
> +    s->info.cap_insn_unit = 2;
> +    s->info.cap_insn_split = 6;
>  #elif defined(__hppa__)
>      s->info.print_insn = print_insn_hppa;
>  #endif
> diff --git a/target/s390x/cpu.c b/target/s390x/cpu.c
> index 749cd548f0..2a96692691 100644
> --- a/target/s390x/cpu.c
> +++ b/target/s390x/cpu.c
> @@ -44,6 +44,7 @@
>  #include "sysemu/tcg.h"
>  #endif
>  #include "fpu/softfloat-helpers.h"
> +#include "disas/capstone.h"
>  
>  #define CR0_RESET       0xE0UL
>  #define CR14_RESET      0xC2000000UL;
> @@ -182,6 +183,9 @@ static void s390_cpu_disas_set_info(CPUState *cpu, disassemble_info *info)
>  {
>      info->mach = bfd_mach_s390_64;
>      info->print_insn = print_insn_s390;
> +    info->cap_arch = CS_ARCH_SYSZ;
> +    info->cap_insn_unit = 2;
> +    info->cap_insn_split = 6;
>  }
>  
>  static void s390_cpu_realizefn(DeviceState *dev, Error **errp)
> diff --git a/meson.build b/meson.build
> index 2f3da5d8c6..448c87f645 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -674,6 +674,17 @@ if capstone_opt == 'internal'
>      )
>    endif
>  
> +  if 'CONFIG_S390_DIS' in config_all_disas
> +    capstone_data.set('CAPSTONE_HAS_SYSZ', '1')
> +    capstone_files += files(
> +      'capstone/arch/SystemZ/SystemZDisassembler.c',
> +      'capstone/arch/SystemZ/SystemZInstPrinter.c',
> +      'capstone/arch/SystemZ/SystemZMapping.c',
> +      'capstone/arch/SystemZ/SystemZModule.c',
> +      'capstone/arch/SystemZ/SystemZMCTargetDesc.c'
> +    )
> +  endif
> +
>    if 'CONFIG_I386_DIS' in config_all_disas
>      capstone_data.set('CAPSTONE_HAS_X86', 1)
>      capstone_files += files(
> 

Acked-by: Thomas Huth <thuth@redhat.com>


