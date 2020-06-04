Return-Path: <SRS0=1Qun=7R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E76EC433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 18:28:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F33620663
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 18:28:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M5S0KJT9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F33620663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47680 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgubE-0003AL-MY
	for qemu-devel@archiver.kernel.org; Thu, 04 Jun 2020 14:28:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37816)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jguag-0002k1-8c
 for qemu-devel@nongnu.org; Thu, 04 Jun 2020 14:27:46 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:32392
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jguae-0006t2-0F
 for qemu-devel@nongnu.org; Thu, 04 Jun 2020 14:27:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591295262;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mT0NDhPocEvD5q0njxV/Om3384bNUNQf4XbE/+FTMPs=;
 b=M5S0KJT9zGy8dSyz7DTQdU+uqAX4aEO+sHRRzt60zxAgBoWzWMpLS+pP1inEQzb1u5E+I+
 62d7h/CpXOYbz93iefL7sZxkliZJXBQHl+6IdCpVZ0XORQqSVCyp6hRShFqRIuoKpUdxTb
 qlJkvOs/JGDUaD+pOxklLQYK03d8Arw=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-492-tefvYLzpMMOmqEcCPPnAwg-1; Thu, 04 Jun 2020 14:27:40 -0400
X-MC-Unique: tefvYLzpMMOmqEcCPPnAwg-1
Received: by mail-wr1-f70.google.com with SMTP id f4so2749805wrp.21
 for <qemu-devel@nongnu.org>; Thu, 04 Jun 2020 11:27:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=mT0NDhPocEvD5q0njxV/Om3384bNUNQf4XbE/+FTMPs=;
 b=FGCWUXuvEBmZ9ogS/2F+36/2PXkkWahZbYWEwI2nGuybf6Bqp9qimdoAYqGnZDauOJ
 ED2nmoQjV5aaNF3gGj73PucF2304HeGpQKEbqGzsD69CcR1JCZx/u1esrsgt4p2y7vDN
 MXPjhi3ZpsCdQdP7d62tmzhmwDivekd5aIch8at8gB2ckkWPa8dw+/qJIWxW/Ubt1vyi
 7eAgc8Lw+LY41DD4OU6J9/N5HR3Bkrmc6hYb/w04Bbtmu2zIMWeHaeK0ZDhnlf4RcKTO
 k5abIBDXysCXYzCxOzlgVunQtJ4KnP2wb9VNfs0gmD7l57wYSNci/DSViRgkyFQL0JNj
 YjsQ==
X-Gm-Message-State: AOAM532Ty2c/7EpN+zqeLOXzGyQeTFeI688i+Nq4DhMOLVPgpVPvGiKU
 SV4/mDeZp5G3Jg711Hv66LLDLRaZEaVmFrxWJvoEB5rfd1RaUhuoLOSXR71MDoKImYAfzgUkKNV
 jQRyIXBvNKL2+L4U=
X-Received: by 2002:adf:b34e:: with SMTP id k14mr5713204wrd.109.1591295259574; 
 Thu, 04 Jun 2020 11:27:39 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw3zJNTS56xC1E5EkdbzxTqqGSC9jvfo0HpAEjW59kzggkFMkLCFWdkCqzPzxN256hUU8Nueg==
X-Received: by 2002:adf:b34e:: with SMTP id k14mr5713186wrd.109.1591295259283; 
 Thu, 04 Jun 2020 11:27:39 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:a0c0:5d2e:1d35:17bb?
 ([2001:b07:6468:f312:a0c0:5d2e:1d35:17bb])
 by smtp.gmail.com with ESMTPSA id d17sm10163605wrg.75.2020.06.04.11.27.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 04 Jun 2020 11:27:38 -0700 (PDT)
Subject: Re: [PATCH 12/13] i386: hvf: Move mmio_buf into CPUX86State
To: Roman Bolshakov <r.bolshakov@yadro.com>, qemu-devel@nongnu.org
References: <20200528193758.51454-1-r.bolshakov@yadro.com>
 <20200528193758.51454-13-r.bolshakov@yadro.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <d57e48c6-574e-471c-78be-1245d62bc908@redhat.com>
Date: Thu, 4 Jun 2020 20:27:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200528193758.51454-13-r.bolshakov@yadro.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/04 12:22:43
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, Cameron Esfahani <dirty@apple.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 28/05/20 21:37, Roman Bolshakov wrote:
> There's no similar field in CPUX86State, but it's needed for MMIO traps.
> 
> Signed-off-by: Roman Bolshakov <r.bolshakov@yadro.com>
> ---
>  target/i386/cpu.h         |  1 +
>  target/i386/hvf/hvf.c     |  5 +++++
>  target/i386/hvf/x86.h     |  1 -
>  target/i386/hvf/x86_emu.c | 12 ++++++------
>  4 files changed, 12 insertions(+), 7 deletions(-)
> 
> diff --git a/target/i386/cpu.h b/target/i386/cpu.h
> index 7e6566565a..be44e19154 100644
> --- a/target/i386/cpu.h
> +++ b/target/i386/cpu.h
> @@ -1593,6 +1593,7 @@ typedef struct CPUX86State {
>  #endif
>  #if defined(CONFIG_HVF)
>      hvf_lazy_flags hvf_lflags;
> +    void *hvf_mmio_buf;
>      HVFX86EmulatorState *hvf_emul;
>  #endif
>  
> diff --git a/target/i386/hvf/hvf.c b/target/i386/hvf/hvf.c
> index 4cee496d71..57696c46c7 100644
> --- a/target/i386/hvf/hvf.c
> +++ b/target/i386/hvf/hvf.c
> @@ -533,7 +533,11 @@ void hvf_reset_vcpu(CPUState *cpu) {
>  
>  void hvf_vcpu_destroy(CPUState *cpu)
>  {
> +    X86CPU *x86_cpu = X86_CPU(cpu);
> +    CPUX86State *env = &x86_cpu->env;
> +
>      hv_return_t ret = hv_vcpu_destroy((hv_vcpuid_t)cpu->hvf_fd);
> +    g_free(env->hvf_mmio_buf);
>      assert_hvf_ok(ret);
>  }
>  
> @@ -563,6 +567,7 @@ int hvf_init_vcpu(CPUState *cpu)
>      init_decoder();
>  
>      hvf_state->hvf_caps = g_new0(struct hvf_vcpu_caps, 1);
> +    env->hvf_mmio_buf = g_new(char, 4096);
>      env->hvf_emul = g_new0(HVFX86EmulatorState, 1);
>  
>      r = hv_vcpu_create((hv_vcpuid_t *)&cpu->hvf_fd, HV_VCPU_DEFAULT);
> diff --git a/target/i386/hvf/x86.h b/target/i386/hvf/x86.h
> index 2363616c07..483fcea762 100644
> --- a/target/i386/hvf/x86.h
> +++ b/target/i386/hvf/x86.h
> @@ -230,7 +230,6 @@ typedef struct x68_segment_selector {
>  
>  /* Definition of hvf_x86_state is here */
>  struct HVFX86EmulatorState {
> -    uint8_t mmio_buf[4096];
>  };
>  
>  /* useful register access  macros */
> diff --git a/target/i386/hvf/x86_emu.c b/target/i386/hvf/x86_emu.c
> index 1ad2c30e16..d3e289ed87 100644
> --- a/target/i386/hvf/x86_emu.c
> +++ b/target/i386/hvf/x86_emu.c
> @@ -187,8 +187,8 @@ void write_val_ext(struct CPUX86State *env, target_ulong ptr, target_ulong val,
>  
>  uint8_t *read_mmio(struct CPUX86State *env, target_ulong ptr, int bytes)
>  {
> -    vmx_read_mem(env_cpu(env), env->hvf_emul->mmio_buf, ptr, bytes);
> -    return env->hvf_emul->mmio_buf;
> +    vmx_read_mem(env_cpu(env), env->hvf_mmio_buf, ptr, bytes);
> +    return env->hvf_mmio_buf;
>  }
>  
>  
> @@ -489,9 +489,9 @@ static void exec_ins_single(struct CPUX86State *env, struct x86_decode *decode)
>      target_ulong addr = linear_addr_size(env_cpu(env), RDI(env),
>                                           decode->addressing_size, R_ES);
>  
> -    hvf_handle_io(env_cpu(env), DX(env), env->hvf_emul->mmio_buf, 0,
> +    hvf_handle_io(env_cpu(env), DX(env), env->hvf_mmio_buf, 0,
>                    decode->operand_size, 1);
> -    vmx_write_mem(env_cpu(env), addr, env->hvf_emul->mmio_buf,
> +    vmx_write_mem(env_cpu(env), addr, env->hvf_mmio_buf,
>                    decode->operand_size);
>  
>      string_increment_reg(env, R_EDI, decode);
> @@ -512,9 +512,9 @@ static void exec_outs_single(struct CPUX86State *env, struct x86_decode *decode)
>  {
>      target_ulong addr = decode_linear_addr(env, decode, RSI(env), R_DS);
>  
> -    vmx_read_mem(env_cpu(env), env->hvf_emul->mmio_buf, addr,
> +    vmx_read_mem(env_cpu(env), env->hvf_mmio_buf, addr,
>                   decode->operand_size);
> -    hvf_handle_io(env_cpu(env), DX(env), env->hvf_emul->mmio_buf, 1,
> +    hvf_handle_io(env_cpu(env), DX(env), env->hvf_mmio_buf, 1,
>                    decode->operand_size, 1);
>  
>      string_increment_reg(env, R_ESI, decode);
> 

It should be possible to get rid of the buffer altogether, but it's ok
to do it separately.

I queued the series, thanks.

Paolo


