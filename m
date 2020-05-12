Return-Path: <SRS0=ZOtl=62=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A0D4C54E4B
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 07:55:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3FDB520643
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 07:55:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="elz05xO0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FDB520643
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48656 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYPlM-0006xR-DU
	for qemu-devel@archiver.kernel.org; Tue, 12 May 2020 03:55:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59066)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jYPkK-00062p-Ds
 for qemu-devel@nongnu.org; Tue, 12 May 2020 03:54:36 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:37819
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jYPkI-0003Y5-Jt
 for qemu-devel@nongnu.org; Tue, 12 May 2020 03:54:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589270072;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=u/MYEE3LL026i32opmckGgknS6r7+NiLTdtsOAf25vo=;
 b=elz05xO0cvXWiG0MJ1auB050RM5a2yT188uWFT+gQ0LAB5fl4exT2aa9cP7bJWSewARjZq
 ZZpxL/st04nJdRqyPzdreY5fiHpVPIjsqQ3wYosmqEBgvYY227NaG5SDCkx7KGLl23Vujb
 HuAknVAXI7qNdRvObR41fSvuBrmHRFw=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-209-S25bY0OrNvS3z4oGoNQriw-1; Tue, 12 May 2020 03:54:30 -0400
X-MC-Unique: S25bY0OrNvS3z4oGoNQriw-1
Received: by mail-wm1-f71.google.com with SMTP id q5so9568026wmc.9
 for <qemu-devel@nongnu.org>; Tue, 12 May 2020 00:54:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=u/MYEE3LL026i32opmckGgknS6r7+NiLTdtsOAf25vo=;
 b=Dc6UfqAizJFaP9gAuF+JzBQ6pXtOHy6QembmLzfMcGCFGXNl0YIwr+pm4t2Mi3WYPB
 oqHqOzyw8gu1BTPcPickjuJR2yfRoqL2QDpGj/j2lXquW2CUqjE8CqVPGhkPdY56DHk4
 dbydQWmyBG+12N6jS/SyBeq1Fsx9XVcM+Kzh+EKAvvlh469eSPOdlMk8Tit/jIw+wmYk
 9Yuxn5u4gsXscAatNG7qbHdqYRnuVWw2jIGXrYcmg/KVQk/suSqjtJr08u3RptDy9ADS
 n9zj5aECZaxBC1zRcIM1L4e1w3BPVlC1j53wqLr8HzKVU0KKICnLyvt+Hbx45N2CdDYf
 T09Q==
X-Gm-Message-State: AGi0PuZNnJBVzW68MG9kk8KkItWaKvUxsp480VW9Xp5dNM0diOe3uJQ0
 VYN7m6o29Cy2nNFnP0YGDGMQ8gu2LGHSc9eJhKuuVhC2e0iOt0mAPn/Mj011Qbdjhqkt0cjGZsV
 M/BaSpvUvOicQQUk=
X-Received: by 2002:a5d:684a:: with SMTP id o10mr23024028wrw.311.1589270069792; 
 Tue, 12 May 2020 00:54:29 -0700 (PDT)
X-Google-Smtp-Source: APiQypJCzBgjMpK4yFwn071XfEIZdrnXGhYtv+pSlpt1rTWKIT49tzHYGX04nanxlWmWYnQp5xLxSg==
X-Received: by 2002:a5d:684a:: with SMTP id o10mr23023997wrw.311.1589270069463; 
 Tue, 12 May 2020 00:54:29 -0700 (PDT)
Received: from [192.168.1.38] (17.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.17])
 by smtp.gmail.com with ESMTPSA id p8sm21067366wre.11.2020.05.12.00.54.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 12 May 2020 00:54:28 -0700 (PDT)
Subject: Re: [PATCH] i386/kvm: fix a use-after-free when vcpu plug/unplug
To: Pan Nengyuan <pannengyuan@huawei.com>, pbonzini@redhat.com,
 rth@twiddle.net, ehabkost@redhat.com, mtosatti@redhat.com
References: <20200512133933.8696-1-pannengyuan@huawei.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <eab55b02-d51b-96c6-3c03-eb69964f162d@redhat.com>
Date: Tue, 12 May 2020 09:54:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200512133933.8696-1-pannengyuan@huawei.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/12 01:41:59
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: zhang.zhanghailiang@huawei.com, qemu-devel@nongnu.org, kvm@vger.kernel.org,
 euler.robot@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/12/20 3:39 PM, Pan Nengyuan wrote:
> When we hotplug vcpus, cpu_update_state is added to vm_change_state_head
> in kvm_arch_init_vcpu(). But it forgot to delete in kvm_arch_destroy_vcpu() after
> unplug. Then it will cause a use-after-free access. This patch delete it in
> kvm_arch_destroy_vcpu() to fix that.
> 
> Reproducer:
>      virsh setvcpus vm1 4 --live
>      virsh setvcpus vm1 2 --live
>      virsh suspend vm1
>      virsh resume vm1
> 
> The UAF stack:
> ==qemu-system-x86_64==28233==ERROR: AddressSanitizer: heap-use-after-free on address 0x62e00002e798 at pc 0x5573c6917d9e bp 0x7fff07139e50 sp 0x7fff07139e40
> WRITE of size 1 at 0x62e00002e798 thread T0
>      #0 0x5573c6917d9d in cpu_update_state /mnt/sdb/qemu/target/i386/kvm.c:742
>      #1 0x5573c699121a in vm_state_notify /mnt/sdb/qemu/vl.c:1290
>      #2 0x5573c636287e in vm_prepare_start /mnt/sdb/qemu/cpus.c:2144
>      #3 0x5573c6362927 in vm_start /mnt/sdb/qemu/cpus.c:2150
>      #4 0x5573c71e8304 in qmp_cont /mnt/sdb/qemu/monitor/qmp-cmds.c:173
>      #5 0x5573c727cb1e in qmp_marshal_cont qapi/qapi-commands-misc.c:835
>      #6 0x5573c7694c7a in do_qmp_dispatch /mnt/sdb/qemu/qapi/qmp-dispatch.c:132
>      #7 0x5573c7694c7a in qmp_dispatch /mnt/sdb/qemu/qapi/qmp-dispatch.c:175
>      #8 0x5573c71d9110 in monitor_qmp_dispatch /mnt/sdb/qemu/monitor/qmp.c:145
>      #9 0x5573c71dad4f in monitor_qmp_bh_dispatcher /mnt/sdb/qemu/monitor/qmp.c:234
> 
> Reported-by: Euler Robot <euler.robot@huawei.com>
> Signed-off-by: Pan Nengyuan <pannengyuan@huawei.com>
> ---
>   target/i386/cpu.h | 1 +
>   target/i386/kvm.c | 5 ++++-
>   2 files changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/target/i386/cpu.h b/target/i386/cpu.h
> index e818fc712a..afbd11b7a3 100644
> --- a/target/i386/cpu.h
> +++ b/target/i386/cpu.h
> @@ -1631,6 +1631,7 @@ struct X86CPU {
>   
>       CPUNegativeOffsetState neg;
>       CPUX86State env;
> +    VMChangeStateEntry *vmsentry;
>   
>       uint64_t ucode_rev;
>   
> diff --git a/target/i386/kvm.c b/target/i386/kvm.c
> index 4901c6dd74..ff2848357e 100644
> --- a/target/i386/kvm.c
> +++ b/target/i386/kvm.c
> @@ -1770,7 +1770,7 @@ int kvm_arch_init_vcpu(CPUState *cs)
>           }
>       }
>   
> -    qemu_add_vm_change_state_handler(cpu_update_state, env);
> +    cpu->vmsentry = qemu_add_vm_change_state_handler(cpu_update_state, env);
>   
>       c = cpuid_find_entry(&cpuid_data.cpuid, 1, 0);
>       if (c) {
> @@ -1883,6 +1883,9 @@ int kvm_arch_destroy_vcpu(CPUState *cs)
>           env->nested_state = NULL;
>       }
>   
> +    qemu_del_vm_change_state_handler(cpu->vmsentry);
> +    cpu->vmsentry = NULL;

Why set it to NULL? there is no non-NULL check.

Anyway if it matters to you, why not do it in 
qemu_del_vm_change_state_handler()?

Otherwise:
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> +
>       return 0;
>   }
>   
> 


