Return-Path: <SRS0=0j61=C7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09FAEC4363D
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 07:12:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 386A6207C3
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 07:12:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eQn9JXIa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 386A6207C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54802 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKcTp-00069L-55
	for qemu-devel@archiver.kernel.org; Tue, 22 Sep 2020 03:12:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34826)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kKcSo-0005fs-C6
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 03:11:46 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:40968
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kKcSm-00065G-N7
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 03:11:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600758703;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BjZ/hfz30lfw0dw42fHBRmyvU9yvd2imdzJF3B5OVEA=;
 b=eQn9JXIatEPkOq2B0ZHgtHEbiduGVq0INMwHqMgvrdZYuqsaXrquEcCCsmWCvxNiw46rXy
 QX7PJCpqbiTndJVeYmpI1IVU6rhtpCyIqBhzK/puPGhPVgqVKB9yp8nbsNwvRirxVHLFe5
 1v7dPeRJRRIltG7YIJwkpj8XXn6BGfo=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-176-4X6qzhsdNoSbhbHRvnmfuw-1; Tue, 22 Sep 2020 03:11:41 -0400
X-MC-Unique: 4X6qzhsdNoSbhbHRvnmfuw-1
Received: by mail-wm1-f70.google.com with SMTP id x6so553927wmi.1
 for <qemu-devel@nongnu.org>; Tue, 22 Sep 2020 00:11:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=BjZ/hfz30lfw0dw42fHBRmyvU9yvd2imdzJF3B5OVEA=;
 b=UaWcdh9ZdtYBIsCwTD3ufjDasSpL+tG2NDyemsU5Fv1d5s8pnInjHYWvWA0aJYF1+2
 CpIxIhEjolf1tWJdv4ua6HfHSTFdeKN6E2jS7yaftDxUs/R5ENnTnpyajlcQ1yLFz5ds
 74q7KM0wgFK54O/93btuIj3jvDcq0ksthHIvzEM9ghpxxQLy8OFJSUfLQesQbTKnHIXR
 MouQ/jCPhAYBZn2ZFhZJcDDYHJTQfXyD8hKtQy9/dn9hWHXbBeCcrreR2xUEz8+0aaP+
 waNYujdlR9j1/9d0LlM4kVSZQvEcrJ4sSr4J+tKGcwU7mbWusiE/In3E3B+FTCksEScw
 eMfg==
X-Gm-Message-State: AOAM533e223n6VC4j4HaNrwVfnjVBojZ8jhclnquFysoPeMrCHNEkPw+
 URwrGzGTQBWQRH4Wcxtqpo4uT2Ab2Q4ji+ydap6AyCE40cQ0Lm/jCBlVEG0O42G6ytr4HcYygut
 Jv4EKoG+JbmTLTAY=
X-Received: by 2002:a5d:4448:: with SMTP id x8mr3824588wrr.207.1600758699787; 
 Tue, 22 Sep 2020 00:11:39 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzj2FVHEB8SjqZfIVDRSbaL6ND6hrVf97m1J2tIp+GG//7j8Q/F+5sDJ1qCfnWy7o58ui4CBg==
X-Received: by 2002:a5d:4448:: with SMTP id x8mr3824562wrr.207.1600758699557; 
 Tue, 22 Sep 2020 00:11:39 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:d153:8d0f:94cf:5114?
 ([2001:b07:6468:f312:d153:8d0f:94cf:5114])
 by smtp.gmail.com with ESMTPSA id i15sm25304979wrb.91.2020.09.22.00.11.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 22 Sep 2020 00:11:38 -0700 (PDT)
Subject: Re: [External] Re: [PATCH 2/3] iqapi/run-state.json: introduce memory
 failure event
To: zhenwei pi <pizhenwei@bytedance.com>,
 Peter Maydell <peter.maydell@linaro.org>
References: <20200914134321.958079-1-pizhenwei@bytedance.com>
 <20200914134321.958079-3-pizhenwei@bytedance.com>
 <CAFEAcA-KX6p3aaKxmMx2i1G2n+9GdOXjDL2mqmHcngq3M_f+Gw@mail.gmail.com>
 <348159b8-0e10-ab93-42ca-5e6d586d5abc@bytedance.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <08d688b5-fe64-6bb7-3fa8-9e976640041a@redhat.com>
Date: Tue, 22 Sep 2020 09:11:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <348159b8-0e10-ab93-42ca-5e6d586d5abc@bytedance.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Received-SPF: pass client-ip=205.139.110.61; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/22 01:27:34
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.455,
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
Cc: Marcelo Tosatti <mtosatti@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 21/09/20 15:10, zhenwei pi wrote:
>>
> Right, to make architecture-neutral, how about these changes:
> 'PC-RAM' -> 'guest-memory'
> 'guest-mce' -> 'guest-mce-inject'
> 'guest-triple-fault' -> 'guest-mce-fault'

Perhaps we should have three fields

1) recipient: 'hypervisor' or 'guest'

2) action: 'ignore', 'inject', 'fatal'

3) kind: 'action-optional' or 'action-required'

And possibly:

4) recursive: true or false

On x86 "recursive" would be set if MCIP=1.

Paolo


