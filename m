Return-Path: <SRS0=B5/Q=AS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7C77C433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 15:20:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 95D3E2065D
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 15:20:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U2NXPg/W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95D3E2065D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55168 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jspOT-00029J-OU
	for qemu-devel@archiver.kernel.org; Tue, 07 Jul 2020 11:20:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47562)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jspNg-0001gg-DU
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 11:19:36 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:26232
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jspNd-0005xe-Sq
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 11:19:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594135173;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=c/d3Mhq4uYygSIy4FP/+0d79LospPFpJQ2b0dlQnmi4=;
 b=U2NXPg/WU5U7ORFtPy8J+Y6abLMmC2rDF4/8AgB8n1/10KKcLl3RpXkeG2s2VJBd9gT62z
 Lcr7dC1cxmKKYEXGPeI/QgiT+nA+e8nBsofPBsSg9EXPDd4pVMNs085GfEUnfpf3frX2Vb
 AOKRFh26e3SzhhZ7A/fJu0K6VN4VomM=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-436-6NoZgnVsPxKobcvku471Cw-1; Tue, 07 Jul 2020 11:19:29 -0400
X-MC-Unique: 6NoZgnVsPxKobcvku471Cw-1
Received: by mail-wr1-f72.google.com with SMTP id e11so48957906wrs.2
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2020 08:19:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=c/d3Mhq4uYygSIy4FP/+0d79LospPFpJQ2b0dlQnmi4=;
 b=PkD8Qe4/YexwyD5hVntdZCBrZArR9NEEtvA6ilWVEYaAWRf64w7orlKxNstHimL0K1
 0efB/I9/t6U5T3AgvmfcbR2A+1zxNCdMYswox/DfBV2hzqgIou/WxkfCPli/w1BywnzM
 UDUbhUEAJmWXLbc4BaYActeWKh2BoQbdVrY/t+xJ929RqXfsfAMhsXxdrvm5bcDWxLam
 mmGbVAl1jT+ac9iOJFiW1UZX5rLFMsRf2FFKxfvThehVGs1kfLH+WwLKD89xwNWX64IR
 VUGPYLd7hEW7ep9BEyT7r8fVeiumwzASffUiYlIDOODqbvbg5r+r3D/bjAcXLd4vChzJ
 vFOw==
X-Gm-Message-State: AOAM530fXDAZhzoREOhZa9YKSAv5qFxzM1cPP3XRqQXSPLs7NGSW3U/a
 OQCT9Ep77cfwGQHgJfQEW9bEH0FHSIizk/gb7FDkQt5vOlMPFyCNK4g2MrHJ+EPpg/vwpnHnAiB
 J2IrcwhzG5wgelGQ=
X-Received: by 2002:a05:600c:218f:: with SMTP id
 e15mr4652436wme.187.1594135167822; 
 Tue, 07 Jul 2020 08:19:27 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxCu4y9aMUzxcdMxN1tKXAfdl37kyim/oZaos/iyjN7/ANNxbUO36Dc0+7bfllHRgRCvveT5Q==
X-Received: by 2002:a05:600c:218f:: with SMTP id
 e15mr4652421wme.187.1594135167611; 
 Tue, 07 Jul 2020 08:19:27 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:e95f:9718:ec18:4c46?
 ([2001:b07:6468:f312:e95f:9718:ec18:4c46])
 by smtp.gmail.com with ESMTPSA id 33sm1580112wri.16.2020.07.07.08.19.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 Jul 2020 08:19:27 -0700 (PDT)
Subject: Re: [qemu-web PATCH] new page: conservancy.md
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20200707145110.10906-1-alex.bennee@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <06e4b9a6-4ea7-8d90-3aca-68c0474a57be@redhat.com>
Date: Tue, 7 Jul 2020 17:19:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200707145110.10906-1-alex.bennee@linaro.org>
Content-Language: en-US
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/07 00:31:00
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: thuth@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 07/07/20 16:51, Alex Bennée wrote:
> +QEMU interacts with Conservancy through a Leadership Committee,
> +currently composed of the following members:
> +
> +* Alex Bennée
> +* Paolo Bonzini
> +* Andreas Färber
> +* Alexander Graf
> +* Stefan Hajnoczi
> +* Peter Maydell
> +
> +The committee votes via simple majority. There cannot be more than two
> +members employed by the same company at once.

s/two members/one third of the members (currently two)/

s/company/entity/ (because Stefan and I are still employed by Red Hat,
not IBM).

> +
> +If you would like to raise an issue to the Leadership Committee,
> +please email [qemu-devel@nongnu.org](mailto:qemu-devel@nongnu.org) and
> +CC at least one of the members so they can bring the issue forward.
> +For private emails you can send an email

Missing "to" here.

> +[qemu@sfconservancy.org](mailto:qemu@sfconservancy.org) which is a
> +private list that all the leadership committee are subscribed to.

Missing comma before "which", or remove "which is" altogether after
adding the comma.

I would also add a link to the first column of _includes/footer.html.

Thanks!

Paolo


