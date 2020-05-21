Return-Path: <SRS0=QiA4=7D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B10EC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 15:32:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 01FEC204EA
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 15:32:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GjXy9uEv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01FEC204EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49560 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbnBF-0007rt-LB
	for qemu-devel@archiver.kernel.org; Thu, 21 May 2020 11:32:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40962)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jbnA6-0007RU-2h
 for qemu-devel@nongnu.org; Thu, 21 May 2020 11:31:10 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:56571
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jbnA3-0006jI-Ve
 for qemu-devel@nongnu.org; Thu, 21 May 2020 11:31:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590075064;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NiBbFfqpWGfaX7br4oQd1Sf0u6bMIADYOp/o0kJpbao=;
 b=GjXy9uEv/lQ6cSYvPxCrGFQDerJjYOBYIxbQmDKF/auhN+fgDWsvd9uYfwysHJJUBBVDlO
 kMJzLAhtHxvNFSPaUuZJgKik17mR7txu3Ohzx9jUDD9NoO6fZduYGAq8Bf8HRuEG/7EyW5
 f9vGE9wHT0cbGJnDjsqRthfC8WsH8Xo=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-341-v4YLdCcANfqpLiphTdNlWQ-1; Thu, 21 May 2020 11:31:01 -0400
X-MC-Unique: v4YLdCcANfqpLiphTdNlWQ-1
Received: by mail-wr1-f71.google.com with SMTP id n17so907221wrr.22
 for <qemu-devel@nongnu.org>; Thu, 21 May 2020 08:31:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=NiBbFfqpWGfaX7br4oQd1Sf0u6bMIADYOp/o0kJpbao=;
 b=f1JU6F+K0SvnLtrl9HDbAqnsb15ZexyaK1taVmZ1SY5FuylkjIrlfi5I6mANIOuIDE
 TrPMdRZEhIli0DHm8NHY2sRZf13RmwUEeRCDdv7EcK6u7SdrbRxl00JP3v1UC+TbGah2
 wu78KwK5RFbtjKDc9Nek8zAhdhPULACJ+FI7RyWWrdYNQKmQND3petbBGpVtNBH80CN1
 MGYUFgkwnLn0iN7TlDMT1hLrkdjCANCCWvdMoIRd+HnqrdF2ehJyCHwo5kJyxFK6UdUf
 0BvLqO+dyxkEVV2oM/zprEGoQQiYykUoNmz4GqGm/x8c1SSWHkMntxTrNyZ6Pw7dH/wq
 Ruug==
X-Gm-Message-State: AOAM531S7NBfuq8b2n8BjPX1EbEGtKRVZA8vk98Y1hS4Hxz1M9fVGVlu
 s1WsRKwfzNmqNguSaFPymVi1n8Oqi0yg8c7oEuihFubJvB76CaidVSfSD4U0Cy4bjU6ObvDK6mn
 lssnRLm4Q5IAoFao=
X-Received: by 2002:adf:e951:: with SMTP id m17mr9117308wrn.352.1590075059863; 
 Thu, 21 May 2020 08:30:59 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx9XzQHYSb3oj7OXmZwI4SsOv4c8F+v4kCsqF4Ze+XpP0U9yag65LbK5doHRKdxJY5/WD7+mw==
X-Received: by 2002:adf:e951:: with SMTP id m17mr9117283wrn.352.1590075059632; 
 Thu, 21 May 2020 08:30:59 -0700 (PDT)
Received: from [192.168.178.58] ([151.21.160.154])
 by smtp.gmail.com with ESMTPSA id m7sm6922422wmc.40.2020.05.21.08.30.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 21 May 2020 08:30:59 -0700 (PDT)
Subject: Re: [PATCH v2] i386/kvm: fix a use-after-free when vcpu plug/unplug
To: Pan Nengyuan <pannengyuan@huawei.com>, rth@twiddle.net,
 ehabkost@redhat.com, mtosatti@redhat.com
References: <20200513132630.13412-1-pannengyuan@huawei.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <2bbaf097-69ab-3afb-d081-56eb76f633d5@redhat.com>
Date: Thu, 21 May 2020 17:30:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200513132630.13412-1-pannengyuan@huawei.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/21 04:44:45
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
Cc: euler.robot@huawei.com, qemu-devel@nongnu.org, kvm@vger.kernel.org,
 zhang.zhanghailiang@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 13/05/20 15:26, Pan Nengyuan wrote:
> When we hotplug vcpus, cpu_update_state is added to vm_change_state_head
> in kvm_arch_init_vcpu(). But it forgot to delete in kvm_arch_destroy_vcpu() after
> unplug. Then it will cause a use-after-free access. This patch delete it in
> kvm_arch_destroy_vcpu() to fix that.
> 
> Reproducer:
>     virsh setvcpus vm1 4 --live
>     virsh setvcpus vm1 2 --live
>     virsh suspend vm1
>     virsh resume vm1
> 
> The UAF stack:
> ==qemu-system-x86_64==28233==ERROR: AddressSanitizer: heap-use-after-free on address 0x62e00002e798 at pc 0x5573c6917d9e bp 0x7fff07139e50 sp 0x7fff07139e40
> WRITE of size 1 at 0x62e00002e798 thread T0
>     #0 0x5573c6917d9d in cpu_update_state /mnt/sdb/qemu/target/i386/kvm.c:742
>     #1 0x5573c699121a in vm_state_notify /mnt/sdb/qemu/vl.c:1290
>     #2 0x5573c636287e in vm_prepare_start /mnt/sdb/qemu/cpus.c:2144
>     #3 0x5573c6362927 in vm_start /mnt/sdb/qemu/cpus.c:2150
>     #4 0x5573c71e8304 in qmp_cont /mnt/sdb/qemu/monitor/qmp-cmds.c:173
>     #5 0x5573c727cb1e in qmp_marshal_cont qapi/qapi-commands-misc.c:835
>     #6 0x5573c7694c7a in do_qmp_dispatch /mnt/sdb/qemu/qapi/qmp-dispatch.c:132
>     #7 0x5573c7694c7a in qmp_dispatch /mnt/sdb/qemu/qapi/qmp-dispatch.c:175
>     #8 0x5573c71d9110 in monitor_qmp_dispatch /mnt/sdb/qemu/monitor/qmp.c:145
>     #9 0x5573c71dad4f in monitor_qmp_bh_dispatcher /mnt/sdb/qemu/monitor/qmp.c:234
> 
> Reported-by: Euler Robot <euler.robot@huawei.com>
> Signed-off-by: Pan Nengyuan <pannengyuan@huawei.com>
> Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> ---
> - v2: remove unnecessary set vmsentry to null(there is no non-null check).
> ---
>  target/i386/cpu.h | 1 +
>  target/i386/kvm.c | 4 +++-
>  2 files changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/target/i386/cpu.h b/target/i386/cpu.h
> index e818fc712a..afbd11b7a3 100644
> --- a/target/i386/cpu.h
> +++ b/target/i386/cpu.h
> @@ -1631,6 +1631,7 @@ struct X86CPU {
>  
>      CPUNegativeOffsetState neg;
>      CPUX86State env;
> +    VMChangeStateEntry *vmsentry;
>  
>      uint64_t ucode_rev;
>  
> diff --git a/target/i386/kvm.c b/target/i386/kvm.c
> index 4901c6dd74..0a4eca5a85 100644
> --- a/target/i386/kvm.c
> +++ b/target/i386/kvm.c
> @@ -1770,7 +1770,7 @@ int kvm_arch_init_vcpu(CPUState *cs)
>          }
>      }
>  
> -    qemu_add_vm_change_state_handler(cpu_update_state, env);
> +    cpu->vmsentry = qemu_add_vm_change_state_handler(cpu_update_state, env);
>  
>      c = cpuid_find_entry(&cpuid_data.cpuid, 1, 0);
>      if (c) {
> @@ -1883,6 +1883,8 @@ int kvm_arch_destroy_vcpu(CPUState *cs)
>          env->nested_state = NULL;
>      }
>  
> +    qemu_del_vm_change_state_handler(cpu->vmsentry);
> +
>      return 0;
>  }
>  
> 

Queued, thanks.

Paolo


