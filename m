Return-Path: <SRS0=H0ck=CE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D2AAC433E1
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 19:08:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 20413207BC
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 19:08:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BxvXrg9i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20413207BC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44898 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kB0mp-0007Pk-D8
	for qemu-devel@archiver.kernel.org; Wed, 26 Aug 2020 15:08:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36710)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ckuehl@redhat.com>) id 1kB0m5-00067i-SA
 for qemu-devel@nongnu.org; Wed, 26 Aug 2020 15:07:57 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:21498
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ckuehl@redhat.com>) id 1kB0m4-0004AM-8s
 for qemu-devel@nongnu.org; Wed, 26 Aug 2020 15:07:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598468875;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zVfRzCZn6+ts4feYrw8uCdw680voVQCMoTJdKdW6yBo=;
 b=BxvXrg9icWMhxqiYEB73tsXmap2ne4XrTYqKldDz36O7IIHc4lKr6xvRisQHu0ZNPGsbMy
 clsPH7C04ROYH6L+FbcHkMzRRigGFVJTTG7rl4vQsDYNILh1dcSXTgbjdPuuHt924fubqV
 Zo7XVbz5J0tU4WbNGb2aKbWUAbKGmI4=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-36-fpUIm5hJNvWSr5GBlsDXgQ-1; Wed, 26 Aug 2020 15:07:54 -0400
X-MC-Unique: fpUIm5hJNvWSr5GBlsDXgQ-1
Received: by mail-qk1-f198.google.com with SMTP id 1so2492585qki.22
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2020 12:07:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=zVfRzCZn6+ts4feYrw8uCdw680voVQCMoTJdKdW6yBo=;
 b=KmGGvsHmqjKfl1MEETERPfqcBnLkh9ZW5zr1pe5NxzBNK34BNJ4yHdQjN/OPFrblTI
 2VEapRT0sggGS5l6gO1XF4e3EdfD8lDWamHMebhsuvCKDvuz4wh/9oTcxDgUHi888P7+
 khzmad+GnCoD1FGaC0HyDq1ICdHrzs6k7Mco0LAq3Ck6KqDQlFdxuIAAkbyBlcWJrtgi
 jaWhqSiV1ipcjpVsgMWyoxeXsmnc/WFBkm6NZag22PLmlWXw6yKuuOOeqOZIR3JAGeJS
 GqtMAH2bw9tKVsFlYdQR1NXTn7ttcwxIn7x41bC+x0+vUe/uuzzhKLB7QsS/sIneEhzf
 YIRw==
X-Gm-Message-State: AOAM531WNy6YyfTJ2IkY5dhxyWjyFy1X6w7geYKCn01miNCftSIaDtoA
 ES06BwSkRbpenD9cSNt1DhWjCigyW5cxchoIA9AYyY7uP1I5g/YuU3nMj7rNY8h2tH4aA9gegbo
 KJKBLQFtHtq7INNc=
X-Received: by 2002:ac8:60c5:: with SMTP id i5mr15888521qtm.268.1598468873282; 
 Wed, 26 Aug 2020 12:07:53 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwKt/sofP3XC1APCt3YLfAwrGBkvCvQK56qB/zFRFY59XZ6fmnPY9uf24qJI+m73tK77o61WA==
X-Received: by 2002:ac8:60c5:: with SMTP id i5mr15888494qtm.268.1598468873067; 
 Wed, 26 Aug 2020 12:07:53 -0700 (PDT)
Received: from [192.168.0.172] (ip68-103-222-6.ks.ok.cox.net. [68.103.222.6])
 by smtp.gmail.com with ESMTPSA id
 r17sm1584791qke.66.2020.08.26.12.07.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 26 Aug 2020 12:07:52 -0700 (PDT)
Subject: Re: [PATCH 4/4] sev/i386: Enable an SEV-ES guest based on SEV policy
To: Tom Lendacky <thomas.lendacky@amd.com>, qemu-devel@nongnu.org,
 kvm@vger.kernel.org
References: <cover.1598382343.git.thomas.lendacky@amd.com>
 <8390c20d2f7e638d166f7b771c3e11363a7852f6.1598382343.git.thomas.lendacky@amd.com>
From: Connor Kuehl <ckuehl@redhat.com>
Message-ID: <bb74c9ef-4d50-0e81-3444-0643947b4240@redhat.com>
Date: Wed, 26 Aug 2020 14:07:51 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <8390c20d2f7e638d166f7b771c3e11363a7852f6.1598382343.git.thomas.lendacky@amd.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ckuehl@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Received-SPF: pass client-ip=205.139.110.120; envelope-from=ckuehl@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/26 14:43:37
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -52
X-Spam_score: -5.3
X-Spam_bar: -----
X-Spam_report: (-5.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.959,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-2.239, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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
Cc: Eduardo Habkost <ehabkost@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Jiri Slaby <jslaby@suse.cz>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/25/20 2:05 PM, Tom Lendacky wrote:
> From: Tom Lendacky <thomas.lendacky@amd.com>
> 
> Update the sev_es_enabled() function return value to be based on the SEV
> policy that has been specified. SEV-ES is enabled if SEV is enabled and
> the SEV-ES policy bit is set in the policy object.
> 
> Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
> ---
>   target/i386/sev.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/target/i386/sev.c b/target/i386/sev.c
> index 5146b788fb..153c2cba2c 100644
> --- a/target/i386/sev.c
> +++ b/target/i386/sev.c
> @@ -70,6 +70,8 @@ struct SevGuestState {
>   #define DEFAULT_GUEST_POLICY    0x1 /* disable debug */
>   #define DEFAULT_SEV_DEVICE      "/dev/sev"
>   
> +#define GUEST_POLICY_SEV_ES_BIT (1 << 2)
> +
>   /* SEV Information Block GUID = 00f771de-1a7e-4fcb-890e-68c77e2fb44e */
>   #define SEV_INFO_BLOCK_GUID "\xde\x71\xf7\x00\x7e\x1a\xcb\x4f\x89\x0e\x68\xc7\x7e\x2f\xb4\x4e"
>   
> @@ -374,7 +376,7 @@ sev_enabled(void)
>   bool
>   sev_es_enabled(void)
>   {
> -    return false;
> +    return (sev_enabled() && (sev_guest->policy & GUEST_POLICY_SEV_ES_BIT));

checkpatch wants these outer parentheses removed :-)

>   }
>   
>   uint64_t
> 


