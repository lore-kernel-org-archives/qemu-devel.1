Return-Path: <SRS0=gXk/=AL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C3E8C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 12:36:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C47120774
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 12:36:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H3/eOJX+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C47120774
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33242 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqFVA-000438-Fn
	for qemu-devel@archiver.kernel.org; Tue, 30 Jun 2020 08:36:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43650)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jqFTl-0002Ja-0y
 for qemu-devel@nongnu.org; Tue, 30 Jun 2020 08:35:14 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:20307
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jqFTi-0004Gu-3H
 for qemu-devel@nongnu.org; Tue, 30 Jun 2020 08:35:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593520506;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IrdTemAVXSth7S8Ngc+V6Z7fI368p6qBpEIF+M2GKTk=;
 b=H3/eOJX+UPmbsI1lg0YBP64+/pA7cg/dh+prVnQVM02MOb/s9zZ/zcPLw2ntvUCmpPqlS9
 lAFaFNkm0NaJG6UWiwxf1mtPfhWVRnnTjiXzqvs75JLnfz+Z9YiBqp43LYqOUvpwNpDusX
 MHxa4fpvui5U8RSU94BFMgOw8u6gzYU=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-44-QC-M7qjxM7aiRSStLpb8Ng-1; Tue, 30 Jun 2020 08:35:04 -0400
X-MC-Unique: QC-M7qjxM7aiRSStLpb8Ng-1
Received: by mail-wm1-f69.google.com with SMTP id h6so20796144wmb.7
 for <qemu-devel@nongnu.org>; Tue, 30 Jun 2020 05:35:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=IrdTemAVXSth7S8Ngc+V6Z7fI368p6qBpEIF+M2GKTk=;
 b=a5t8zOmxDtDbS9RLbozm9pv7pZLPHLmaR0XxogCoPe0SfbVTiAHeZaMvnQeiuO6CUF
 +yCQSo/JdVbtYgOrmLecSr5jxmRM2Sb4qBotAw8Zrg8Sn8OWoImdupCGjz73zdWDAtmG
 0747uzD/Qx3TBzSFCayl2psz0jtmSETFnv/W9fXcZRoqPDP7jH3aWdJlFGM8hWqPjoUg
 fi2N9Wf6E+Z44IEylwjNROJmbMnZYiWI1CW2TlmbExlwBDMUDkWebYczXfk+j0YBthMg
 BiHObYu51nahjnpKCDJBBaRO5PU0bLFOHnWHYnVHnbiQgzCQn8BHgPx5rlwKcKlMDSDk
 Qjiw==
X-Gm-Message-State: AOAM531aIGVZjNVkiewVaDQgfrx6thQJanRHxI4qC06zFp4a0u3o52y7
 HuM+ZU4Y2sK1eRC4s03JogfuVJnF+8+uPiH0WSlG/rrvjZwrJXzimtSQI1/mA/NgDfFOzH2thaP
 Ph4uFvQlL6cmdht4=
X-Received: by 2002:a05:6000:cf:: with SMTP id
 q15mr22253476wrx.203.1593520503098; 
 Tue, 30 Jun 2020 05:35:03 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyzQQDjPidxLUa6l0oxTXSE129fB16Rkp+nORL67w2ql98gUOBQV3RJu+ZXv0dLsdrRiUkXMw==
X-Received: by 2002:a05:6000:cf:: with SMTP id
 q15mr22253466wrx.203.1593520502893; 
 Tue, 30 Jun 2020 05:35:02 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:b0e5:c632:a580:8b9a?
 ([2001:b07:6468:f312:b0e5:c632:a580:8b9a])
 by smtp.gmail.com with ESMTPSA id l8sm3593120wrq.15.2020.06.30.05.35.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 Jun 2020 05:35:02 -0700 (PDT)
Subject: Re: [PATCH v2 1/9] i386: hvf: Set env->eip in macvm_set_rip()
To: Roman Bolshakov <r.bolshakov@yadro.com>, qemu-devel@nongnu.org
References: <20200630102824.77604-1-r.bolshakov@yadro.com>
 <20200630102824.77604-2-r.bolshakov@yadro.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <6a498ea9-2c9f-58be-5afc-3704db8af9d3@redhat.com>
Date: Tue, 30 Jun 2020 14:35:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200630102824.77604-2-r.bolshakov@yadro.com>
Content-Language: en-US
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/30 01:11:03
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, Claudio Fontana <cfontana@suse.de>,
 Cameron Esfahani <dirty@apple.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 30/06/20 12:28, Roman Bolshakov wrote:
> cpu_synchronize_state() is currently no-op for hvf but BIOS will hang in
> vAPIC option ROM when cpu_synchronize_state() is wired to
> hvf_cpu_synchronize_state().
> 
> cpu_synchronize_state() state is called from vapic_write() during option
> ROM initialization. It sets dirty flag on the cpu. macvm_set_rip() is
> then invoked to advance IP after the I/O write to vAPIC port.
> 
> macvm_set_rip() only modifies VMCS, it doesn't change env->eip.
> Therefore on the next iteration of vCPU loop, vcpu_dirty flag is checked
> and hvf_put_registers() overwrites correct RIP in VMCS with the value of
> env->eip that points to the I/O write instruction. Execution of the CPU
> gets stuck on the instruction.
> 
> The issue can be avoided if eip doesn't contain stale value when dirty
> flag is set on cpu.
> 
> Cc: Cameron Esfahani <dirty@apple.com>
> Signed-off-by: Roman Bolshakov <r.bolshakov@yadro.com>
> ---
>  target/i386/hvf/vmx.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/target/i386/hvf/vmx.h b/target/i386/hvf/vmx.h
> index ce2a1532d5..1e8b29bf7d 100644
> --- a/target/i386/hvf/vmx.h
> +++ b/target/i386/hvf/vmx.h
> @@ -173,6 +173,7 @@ static inline void macvm_set_rip(CPUState *cpu, uint64_t rip)
>  
>      /* BUG, should take considering overlap.. */
>      wreg(cpu->hvf_fd, HV_X86_RIP, rip);
> +    env->eip = rip;
>  
>      /* after moving forward in rip, we need to clean INTERRUPTABILITY */
>     val = rvmcs(cpu->hvf_fd, VMCS_GUEST_INTERRUPTIBILITY);
> 

Queued except for patch 4.

Paolo


