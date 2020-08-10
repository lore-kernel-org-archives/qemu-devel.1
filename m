Return-Path: <SRS0=QvPl=BU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 362B2C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2020 18:22:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EE0B9207FF
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2020 18:22:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XmLiiCXz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE0B9207FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34698 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k5CQx-0002b9-Sw
	for qemu-devel@archiver.kernel.org; Mon, 10 Aug 2020 14:22:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50058)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k5Bac-0001fU-UA
 for qemu-devel@nongnu.org; Mon, 10 Aug 2020 13:28:02 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:29385
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k5Baa-0005C4-GQ
 for qemu-devel@nongnu.org; Mon, 10 Aug 2020 13:28:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597080478;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nUjscpN9/y/GKc0jo8+74LxFp0A+jcNe9rtm5H+teqs=;
 b=XmLiiCXzGe/VN9JqfGpx3pETCh5hEf+ezlIOG8zbAltfhOGBOo490ZCsJN90sLOy9YLZu4
 m47b+R87q1kGpiXjmQVRhRi96aQX2mzhzLoFu+oiZnpbyKNW1QmJkWM1Orj7Ni5jPByoK9
 G41VyfpLdUkZUJDYbR/Sv6izbgBUA7U=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-129-Qz3mwv22PBOeaZHfz9PScA-1; Mon, 10 Aug 2020 13:27:57 -0400
X-MC-Unique: Qz3mwv22PBOeaZHfz9PScA-1
Received: by mail-wm1-f72.google.com with SMTP id z10so64555wmi.8
 for <qemu-devel@nongnu.org>; Mon, 10 Aug 2020 10:27:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=nUjscpN9/y/GKc0jo8+74LxFp0A+jcNe9rtm5H+teqs=;
 b=XaTASjz388rQ0G0AfRm7ApGXPtamPOe+I91UFJlbu1jCEpB1FAycG9zrHdUId+AbDP
 Mz6cgmqPiEMamcOgI8h5gHACrXBiWy+5SpYamLQP67f6brtGrYuMP3nOsAzOcARVgdm4
 yYo4gJ6Iq3UsQDnzraQlyIG5gp7V2xeF46uoeDPggi1JoyYKjqEC3OAOVCgLypdJLUvB
 o0fG7vtI01QelQTPe55MBdl5JE075AMh0ThF01dLsWcGdzsI6lSva1tb2T705paZ+WxP
 xpxL20N5yJ8SR5qaXNcdZWnF1ik5Hey5goSrXEKN+V/c76SSdU5DLZKRwOmUKkx+QPiN
 ZHtQ==
X-Gm-Message-State: AOAM531d0sq02/xHLnCX3zXzNKEomyCdZpTUHECNzlT/7ttlkxaIeeFY
 DTNgR1GGQY5tbECnwviSK6S72xVglZDyYEf8RJzz1mwwpHlY+qSDdtCy4x38GB51fOKIGtOv4M+
 gIA0qFnxiJYAbHbs=
X-Received: by 2002:adf:ee06:: with SMTP id y6mr25673326wrn.225.1597080475936; 
 Mon, 10 Aug 2020 10:27:55 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyF9SCYH/mhqDSzAaSqxLjmd4JGoWftb+Oc8ibDlshjhnt4Rn0gkJAp6fWoPGm1BebZsrxqWQ==
X-Received: by 2002:adf:ee06:: with SMTP id y6mr25673313wrn.225.1597080475715; 
 Mon, 10 Aug 2020 10:27:55 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:5d6c:f50:4462:5103?
 ([2001:b07:6468:f312:5d6c:f50:4462:5103])
 by smtp.gmail.com with ESMTPSA id y24sm357436wmi.17.2020.08.10.10.27.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 Aug 2020 10:27:55 -0700 (PDT)
Subject: Re: [PATCH v1 1/1] hyperv: Enable SCONTROL if SYNIC is enabled
To: Jon Doron <arilou@gmail.com>, qemu-devel@nongnu.org
References: <20200717125639.1103876-1-arilou@gmail.com>
 <20200717125639.1103876-2-arilou@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <837db114-d7a3-7e0b-dfd4-db136711c120@redhat.com>
Date: Mon, 10 Aug 2020 19:27:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200717125639.1103876-2-arilou@gmail.com>
Content-Language: en-US
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/10 04:13:00
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: vkuznets@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 17/07/20 14:56, Jon Doron wrote:
> Based on an analysis of the HyperV firmwares (Gen1 and Gen2) it seems
> like the SCONTROL is not being set to the ENABLED state as like we have
> thought.
> 
> Also from a test done by Vitaly Kuznetsov, running a nested HyperV it
> was concluded that the first access to the SCONTROL MSR with a read
> resulted with the value of 0x1, aka HV_SYNIC_CONTROL_ENABLE.
> 
> It's important to note that this diverges from the value states in the
> HyperV TLFS of 0.
> 
> Signed-off-by: Jon Doron <arilou@gmail.com>
> ---
>  target/i386/kvm.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/target/i386/kvm.c b/target/i386/kvm.c
> index b8455c89ed..6a62e8ae94 100644
> --- a/target/i386/kvm.c
> +++ b/target/i386/kvm.c
> @@ -1904,6 +1904,8 @@ void kvm_arch_reset_vcpu(X86CPU *cpu)
>  
>      if (hyperv_feat_enabled(cpu, HYPERV_FEAT_SYNIC)) {
>          int i;
> +
> +        env->msr_hv_synic_control = HV_SYNIC_ENABLE;
>          for (i = 0; i < ARRAY_SIZE(env->msr_hv_synic_sint); i++) {
>              env->msr_hv_synic_sint[i] = HV_SINT_MASKED;
>          }
> 

Are both patches needed or only the Hyper-V one?

Paolo


