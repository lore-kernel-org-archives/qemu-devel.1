Return-Path: <SRS0=E5X6=CV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A54CCC433E2
	for <qemu-devel@archiver.kernel.org>; Sat, 12 Sep 2020 16:18:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E3D3520838
	for <qemu-devel@archiver.kernel.org>; Sat, 12 Sep 2020 16:18:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZlsZxW5v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3D3520838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56140 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kH8Eo-0000ye-PT
	for qemu-devel@archiver.kernel.org; Sat, 12 Sep 2020 12:18:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57872)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kH8EJ-0000YJ-8V
 for qemu-devel@nongnu.org; Sat, 12 Sep 2020 12:18:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:41107)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kH8EH-00060I-90
 for qemu-devel@nongnu.org; Sat, 12 Sep 2020 12:18:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599927499;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=F/B/PWzqUW6KvBsejypy1Tw7oHLy21bCgDEqHt5U9Jw=;
 b=ZlsZxW5vjPPFJSFWDCdV2wKMlV6eOuBZ71ScxDj8iva6Yv/MKnM7miy7HvKK6X+ltH+2Wp
 Mu6HkmZjKkSmn/8YXVc7jVqjeIDxvGDhjRI8aEp6TZ0X60C9X0h9WHQNi8Sb054eb/7INR
 jeeF6pSL72wwY1WzWCfu8UIjm51nJ+s=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-229-Fj6dG7WyO8y1EfBaXClnug-1; Sat, 12 Sep 2020 12:18:17 -0400
X-MC-Unique: Fj6dG7WyO8y1EfBaXClnug-1
Received: by mail-wr1-f69.google.com with SMTP id y3so4534291wrl.21
 for <qemu-devel@nongnu.org>; Sat, 12 Sep 2020 09:18:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=F/B/PWzqUW6KvBsejypy1Tw7oHLy21bCgDEqHt5U9Jw=;
 b=mri8+WGgzv/jorQbpvi5RsaL7SGIXK5ipu0/hc6aSd8SErcT20MYS8F8KZsII9QmiK
 EkWHxiuxlXMPEbjDUL0wWTqPuWGQsVNJXZNnTO6/56A3KTO/2kYQ+4SqHsZ0DSKnN1Qe
 lhLiUT65hlas2zQIOdburqGTz3rlH2ML2dSmz10NYgk4IhXdHlImB7ihScaUA8ae2BlG
 4I7JMcd8cofapYCEFn/wCBSBUat9MZNtlSmIV2bAsP6WYEFiOloZCHV/d0HzaH/p+lm/
 lksowEWLhbkfWZib9XAaiVWa7eYqQqJPPkvJimFvTL4AacbjSyN5TVOClu18SfX9c83q
 VIAw==
X-Gm-Message-State: AOAM532VL9pItA2LKPp+uRJiIUzH76OAz0PEtbePr2WolFY0VOmD3XRR
 5+fpTY9MQRRg1DcAgwnAc8nT2EZndA4C4oBS5JM/muA7JSNm8u5KkK1uMXk/ykFJEhHQlNT4Fot
 xUGw6DWNOsGBQNkg=
X-Received: by 2002:adf:db43:: with SMTP id f3mr7968947wrj.219.1599927496553; 
 Sat, 12 Sep 2020 09:18:16 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz16b3yWDsZMYkti/ueSynSKRsJ3tN20E4GRrMuFe+R1nVkeZAtbklUr2+W+IACL3IZPwDg5A==
X-Received: by 2002:adf:db43:: with SMTP id f3mr7968931wrj.219.1599927496290; 
 Sat, 12 Sep 2020 09:18:16 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:9fd9:16f2:2095:52d7?
 ([2001:b07:6468:f312:9fd9:16f2:2095:52d7])
 by smtp.gmail.com with ESMTPSA id v204sm10970570wmg.20.2020.09.12.09.18.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 12 Sep 2020 09:18:15 -0700 (PDT)
Subject: Re: [PATCH 7/7] hw/char/serial: Let SerialState have an 'id' field
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org
References: <20200907015535.827885-1-f4bug@amsat.org>
 <20200907015535.827885-8-f4bug@amsat.org>
 <b6dceab9-d20d-290e-93c5-170a99499da2@redhat.com>
 <9ba2e4c6-859e-0798-c43d-585413864095@amsat.org>
 <c717743f-d43c-1aae-291a-7d050c96b16a@amsat.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <2e243901-8c12-fa71-022a-d50701a1673b@redhat.com>
Date: Sat, 12 Sep 2020 18:18:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <c717743f-d43c-1aae-291a-7d050c96b16a@amsat.org>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Received-SPF: pass client-ip=216.205.24.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/12 12:18:19
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.543, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: qemu-trivial@nongnu.org,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/09/20 13:33, Philippe Mathieu-Daudé wrote:
>> I'll send a new patch for the PCI-single device:
> Bah this can simply be squashed into the previous patch.
> 

Yup, done.

Paolo


