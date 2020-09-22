Return-Path: <SRS0=0j61=C7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32609C2D0E2
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 12:05:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B59F920936
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 12:05:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AiOCjTqt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B59F920936
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49134 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKh3U-0004wn-U7
	for qemu-devel@archiver.kernel.org; Tue, 22 Sep 2020 08:05:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35580)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kKh2l-0004Oh-2R
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 08:05:11 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:34459
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kKh2f-0004zk-M0
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 08:05:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600776300;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Fbci2o4pg9HYWGHwlSBIthUnoYF+N3Iupz+SYZ3MYgk=;
 b=AiOCjTqtCb7YOhftO4GK/I3wUeB23ruOzcjKKXSStrhcynyRJofYNEqLmQhbncqfwBnjTb
 PZayzaZzM4l9RPgypaHf46EUuYX0S24uJHz6NmMJCJhpySTiBg2Txkz7t8ShWuBHKkKq97
 we32WvsGHiu0TixlCCCL2k12n6+WPUk=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-327-DNaqxy0gMveIc5aEvFB-mw-1; Tue, 22 Sep 2020 08:04:58 -0400
X-MC-Unique: DNaqxy0gMveIc5aEvFB-mw-1
Received: by mail-wr1-f72.google.com with SMTP id f18so7320401wrv.19
 for <qemu-devel@nongnu.org>; Tue, 22 Sep 2020 05:04:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Fbci2o4pg9HYWGHwlSBIthUnoYF+N3Iupz+SYZ3MYgk=;
 b=r1IGzAIJr627cV7gItslP0QcfBZNcoXdI0GZtzT9xdLcpI2g0pS5SGSZhR30XYUzae
 lD2zRbTy3nscmDVOpKZG6HcheL2ZMEY5pyX8kCPf7A6FneA4R9N7eLpdwnfL+YAgvGxL
 q+/hWMsso+RXz8RUFnw6n6hNNIziVyJCKwkippsACISLV+DeYKR5kLyfpLm2eYK5Aq1H
 Fg8YPibmyEyCb9X3n5OYwZHgZb9E4WQRWhPdwP5FGV+tlzwUPS/sC1ZDQQKuM2sSqDUQ
 5rsp2lX4zpTTE+rzoaF/IUKPmGmGx/mFN27BFRnT8OuWZmPJ1GOxfoVHfpBbQqcSyAcX
 n2pQ==
X-Gm-Message-State: AOAM532lC8LeQodfrNwb+vDTeh89stgfsiumSkvTBoqidu2UO1rVD0dQ
 eR7K6fCd24+FGoAH7CdXaeFO9lBj6OW7LIBH4ui64hwSP7wOamiMq+YLsgn1cfZMI2ycKnFZosl
 QkHIozyzl1vFDY2o=
X-Received: by 2002:adf:912b:: with SMTP id j40mr5024949wrj.42.1600776296815; 
 Tue, 22 Sep 2020 05:04:56 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxBSdRMIFDbeFYSwXPTwdTNJcRlTstv7TCD4th7Pmb5S2XhaFvh8ZSfQvOa360U8yFnt2uJtA==
X-Received: by 2002:adf:912b:: with SMTP id j40mr5024917wrj.42.1600776296416; 
 Tue, 22 Sep 2020 05:04:56 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:ec2c:90a9:1236:ebc6?
 ([2001:b07:6468:f312:ec2c:90a9:1236:ebc6])
 by smtp.gmail.com with ESMTPSA id t15sm25711348wrp.20.2020.09.22.05.04.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 22 Sep 2020 05:04:55 -0700 (PDT)
Subject: Re: [PATCH] helper_syscall x86_64: clear exception_is_int
To: Douglas Crosher <dtc-ubuntu@scieneer.com>, qemu-devel@nongnu.org
References: <a7dab33e-eda6-f988-52e9-f3d32db7538d@scieneer.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <651980e0-4413-47e5-73fd-5970ede99117@redhat.com>
Date: Tue, 22 Sep 2020 14:04:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <a7dab33e-eda6-f988-52e9-f3d32db7538d@scieneer.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Received-SPF: pass client-ip=207.211.31.120; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/22 01:57:21
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.455,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: ehabkost@redhat.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 22/09/20 06:17, Douglas Crosher wrote:
> 
> The exception_is_int flag may be set on entry to helper_syscall,
> e.g. after a prior interrupt that has returned, and processing
> EXCP_SYSCALL as an interrupt causes it to fail so clear this flag.
> 
> Signed-off-by: Douglas Crosher <dtc-ubuntu@scieneer.com>
> ---
>  target/i386/seg_helper.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/target/i386/seg_helper.c b/target/i386/seg_helper.c
> index b96de068ca..be88938c2a 100644
> --- a/target/i386/seg_helper.c
> +++ b/target/i386/seg_helper.c
> @@ -975,6 +975,7 @@ void helper_syscall(CPUX86State *env, int
> next_eip_addend)
>      CPUState *cs = env_cpu(env);
> 
>      cs->exception_index = EXCP_SYSCALL;
> +    env->exception_is_int = 0;
>      env->exception_next_eip = env->eip + next_eip_addend;
>      cpu_loop_exit(cs);
>  }

Queued, thanks.

Paolo


