Return-Path: <SRS0=rz2F=DU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4CA8C4363A
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 08:52:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BAE0E214DB
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 08:52:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CYMrKafw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BAE0E214DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54388 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSG2Z-0004pl-ML
	for qemu-devel@archiver.kernel.org; Tue, 13 Oct 2020 04:52:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60316)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kSG1B-00048s-4f
 for qemu-devel@nongnu.org; Tue, 13 Oct 2020 04:50:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:29600)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kSG15-0007fi-K7
 for qemu-devel@nongnu.org; Tue, 13 Oct 2020 04:50:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602579040;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=m+t4JEDX2dMudCeVorcy28dupxkaFkTpQFWT7/7DIXk=;
 b=CYMrKafwdeInrPxgG/e4WJ32QQuzCl5bmLj56RlYhB3g68LwJ3NsTdXGLAFq9ujh0mY7tH
 3oiAU3PgF2MrFOLSoE1QPAGZhTLRRpqkQU80TQUlNty7BLtvbLgJco3Qox1G+rY055TgYb
 cHVFqqI8clD6hdsBzcasfwiyQkkxgL0=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-376-pMsD6s-fOSCYXy2i-V0lag-1; Tue, 13 Oct 2020 04:50:37 -0400
X-MC-Unique: pMsD6s-fOSCYXy2i-V0lag-1
Received: by mail-wm1-f71.google.com with SMTP id r19so6502398wmh.9
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2020 01:50:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=m+t4JEDX2dMudCeVorcy28dupxkaFkTpQFWT7/7DIXk=;
 b=sCsE4pfkNxI5PzVI2ZXB5HhQwlODhZZnh8e3GiL086rAeCRewRWOlmfe8AwR5HVBkO
 cMIFsFjqG0CmQSmF+Vluj2DuPROnqp4IBgDImYq2cc0M+4XCRr8zoRgQyKESfPaKI1Ws
 VS+tly9g2VWsCWc6UkuCq5fRy077uNusz2+vshDZpaYR+r7g4XEeCJ2ESyStbLxaZXH1
 lKpkTjc8UpCYEt4gXdEwGJIzFf55xSx3C3qNp1ntAp389qbKpV9u2q+mISXI6KsYsX/M
 meqA8/EL7uS31arBzOoZRR/6TrTt2DYJ++0ujYblM6z3CLpRmpnNmkXWTBDUw3UR60ww
 blSQ==
X-Gm-Message-State: AOAM530B7kVkXnAB0wQKMYIVGtRxvso7RLQdMoO+2EnYU7l4iz25JiTx
 PC+oORl7KA22YRsjSr0ZyfCjOEV90x8Eg5vR5k1a6kvozwZWSUR6lM2nAAwRI3JENkdA1rvN2DR
 W3IM/mMCPfM/YBqA=
X-Received: by 2002:a1c:4b0f:: with SMTP id y15mr15201378wma.165.1602579036587; 
 Tue, 13 Oct 2020 01:50:36 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzfrIfs8sh7GeztZdluBaZgWSj3ZD96zKOp7GKdiAyr/CrtfALhKbBFO7fq4+eQ0I3/WXGfJg==
X-Received: by 2002:a1c:4b0f:: with SMTP id y15mr15201360wma.165.1602579036402; 
 Tue, 13 Oct 2020 01:50:36 -0700 (PDT)
Received: from [192.168.1.36] (106.red-83-59-162.dynamicip.rima-tde.net.
 [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id x6sm27410141wmb.17.2020.10.13.01.50.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 Oct 2020 01:50:35 -0700 (PDT)
Subject: Re: [PATCH v2 0/3] unbreak non-tcg builds
To: Claudio Fontana <cfontana@suse.de>, Paolo Bonzini <pbonzini@redhat.com>
References: <20201012214527.1780-1-cfontana@suse.de>
 <d32be762-ece9-c9cb-1bdc-3d7e65c5a7bc@redhat.com>
 <4b561396-f6ea-599f-1108-8fc679f61c31@suse.de>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <ebd66974-280e-1ce0-54c1-cb3fc2ab6016@redhat.com>
Date: Tue, 13 Oct 2020 10:50:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <4b561396-f6ea-599f-1108-8fc679f61c31@suse.de>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/13 03:04:27
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org,
 Pavel Dovgalyuk <dovgaluk@ispras.ru>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/13/20 10:28 AM, Claudio Fontana wrote:
> On 10/13/20 10:25 AM, Philippe Mathieu-Daudé wrote:
>> On 10/12/20 11:45 PM, Claudio Fontana wrote:
>>> This series now unbreaks current non-tcg builds
>>> (!CONFIG_TCG).
>>>
>>> tests Makefiles need to avoid relying on all non-native
>>> archs binaries to be present,
>>>
>>> bios-tables-test needs to skip tests that are tcg-only,
>>>
>>> and notably the replay framework needs to consider that
>>> it might not be functional (or its code present at all)
>>> without TCG.
>>>
>>> Tested ok target x86_64-softmmu on x86_64 host with:
>>>
>>> ./configure --enable-tcg --disable-kvm
>>> ./configure --enable-kvm --disable-tcg
>>> ./configure --enable-tcg --enable-kvm
>>>
>>> running make check-qtest
>>
>> If you want to avoid these configurations to bitrot,
>> please cover them adding Gitlab jobs.
>>
>> Thanks,
>>
>> Phil.
>>
> 
> Hi, yes I was about to ask :-) We have only minimal coverage of --disable-tcg and only for s390 IIRC.

Aarch64 is on his way:
https://www.mail-archive.com/qemu-devel@nongnu.org/msg746053.html

> 
> Ciao,
> 
> Claudio
> 


