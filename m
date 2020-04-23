Return-Path: <SRS0=5yua=6H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07979C2BA19
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2020 08:19:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C2917208E4
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2020 08:19:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IEBy+aR5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2917208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38758 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRX4X-0001AD-VC
	for qemu-devel@archiver.kernel.org; Thu, 23 Apr 2020 04:19:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55094)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1jRX3I-0008RB-NO
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 04:17:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1jRX3H-0005We-0H
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 04:17:44 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:21251
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jRX3G-0005SK-IN
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 04:17:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587629860;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wpQZ2rTcFsaax2mXKE2E3egR7C1vNDEuaE6Bd+0/E/I=;
 b=IEBy+aR5aMQpIppS7uk5En4IbXetYUzx7fAees0FWjE5zzl2+FJCK2Ct8j2aeei8SfSw5W
 REUsbC93tn4+4CSWwzWyUFH+qdya+9AhZw37R7P3dTpV9WcnhcdZN63+QdEPq9wokALAdo
 BycoCGuVXZUmJsqVOpIvLe/rf9dqAls=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-175-jFCC_JwPN3OjLjr4YUICTw-1; Thu, 23 Apr 2020 04:17:39 -0400
X-MC-Unique: jFCC_JwPN3OjLjr4YUICTw-1
Received: by mail-wm1-f71.google.com with SMTP id w2so136152wmc.3
 for <qemu-devel@nongnu.org>; Thu, 23 Apr 2020 01:17:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=wpQZ2rTcFsaax2mXKE2E3egR7C1vNDEuaE6Bd+0/E/I=;
 b=au3zh+dixDizbK4QF7YpcuQ3kxY4pCiHZL1HTRu13HImMixDOGPyCOQaM0NPoch1iP
 XUqhTXIq0D+haEj8u4LIs98iN6i+ClNY4O9ivwbPF66YLNL/y0wpMTKQxUxbvykjgjf2
 mTzSKjTLc4Fsvn2Sh2uW2dTW4mZmRxNtMr2V+7NTYf9iwN6j5dDh6m9Hf3js/I5GvFm1
 98RweBnosIPlWYFpCOSaI8oCr9jPGO5gpt/S1pHsqfFGyqg3+AS0B76WigGdP/XXjh2q
 JUfyMAHFrOdNNcN65hh/J9BihDZIVVCdTbtdjDJnD0lBThiGRtS4nuf2lfE3rvxg3bk0
 7YAQ==
X-Gm-Message-State: AGi0PuZc0M6mfBmnR/TNl750miIMG7JukRZ16FG7mezO6RGKK4MwqXxm
 qJ42SVP+QzW/gKCPP/dwgXIietAt+x5VOAM8u4wNbTqfq1mxxIx6lHMgcf2Jta/a8p8NnrpGt79
 obwJFVE7GBaUK3xg=
X-Received: by 2002:a05:6000:f:: with SMTP id
 h15mr3467263wrx.408.1587629858093; 
 Thu, 23 Apr 2020 01:17:38 -0700 (PDT)
X-Google-Smtp-Source: APiQypL2wqcvYjVbbPJSFD8vKc92EGaMKTczT5f7KFONoBrPo1RL1M2bQFwJvz2egbGp9OAUuj6Yrg==
X-Received: by 2002:a05:6000:f:: with SMTP id
 h15mr3467227wrx.408.1587629857802; 
 Thu, 23 Apr 2020 01:17:37 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:d0a0:f143:e9e4:2926?
 ([2001:b07:6468:f312:d0a0:f143:e9e4:2926])
 by smtp.gmail.com with ESMTPSA id d7sm2473344wrn.78.2020.04.23.01.17.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 23 Apr 2020 01:17:37 -0700 (PDT)
Subject: Re: [PATCH] accel/tcg: Add stub for probe_access()
To: David Hildenbrand <david@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
References: <20200423071039.7010-1-f4bug@amsat.org>
 <bcc500de-9164-8ef9-240c-9a82161df9ad@redhat.com>
 <CAAdtpL6hF2-XZwkyRp9nEOmAQir1wb-Bw4fv2bhV+OJGU=W8Vw@mail.gmail.com>
 <d065cb52-1fb3-297e-9678-884e3670c84f@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <009b4342-b2e9-ff97-be87-0e6202ed977c@redhat.com>
Date: Thu, 23 Apr 2020 10:17:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <d065cb52-1fb3-297e-9678-884e3670c84f@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/23 02:14:02
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: Beata Michalska <beata.michalska@linaro.org>,
 "Emilio G . Cota" <cota@braap.org>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 23/04/20 10:04, David Hildenbrand wrote:
>> I can only recommend you to read the thread after this previous patch,
>> as I don't have the knowledge to explain...:
>> https://www.mail-archive.com/qemu-devel@nongnu.org/msg689115.html
> Yeah, me neither. Sounds wrong to me to have TCG-only code stick around
> in !CONFIG_TCG builds. But I am pretty sure ARM people know what they
> are doing.

It's better if helpers are left out via obj-$(CONFIG_TCG), but it's not
the end of the world if they aren't---as long as it compiles of course!

This case is definitely borderline.

Paolo


