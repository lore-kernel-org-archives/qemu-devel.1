Return-Path: <SRS0=Kewn=DL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19BC8C4363C
	for <qemu-devel@archiver.kernel.org>; Sun,  4 Oct 2020 06:36:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8A0B52080A
	for <qemu-devel@archiver.kernel.org>; Sun,  4 Oct 2020 06:36:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SnEMZtRX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A0B52080A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58712 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kOxcw-0002x5-HM
	for qemu-devel@archiver.kernel.org; Sun, 04 Oct 2020 02:36:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46140)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kOxbv-0002OE-7M
 for qemu-devel@nongnu.org; Sun, 04 Oct 2020 02:35:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:56682)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kOxbt-00020P-7m
 for qemu-devel@nongnu.org; Sun, 04 Oct 2020 02:35:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601793303;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qlbnPyAxDwltE8XhnqI89DA1bAx0urXHx5eO3riRj2o=;
 b=SnEMZtRXjR6sAVyXq6z1FIedLsNGsvDBB0yNfxekaR1N6CczHE7RasxAlGgFkjVGFqB0+U
 umRwDgRIVYM0n5pNWCA9hexNdNADZm5o3+Gn+3XPnhIxWeuM86Z9/bS2kXmM5DkpvBzD73
 98X0cHoVCBx5Fa7B6VGdIr++pM5nWtc=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-39-7cUi1vQOOkyt7YmYMkFT6g-1; Sun, 04 Oct 2020 02:35:01 -0400
X-MC-Unique: 7cUi1vQOOkyt7YmYMkFT6g-1
Received: by mail-wr1-f71.google.com with SMTP id l15so2599173wro.10
 for <qemu-devel@nongnu.org>; Sat, 03 Oct 2020 23:35:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=qlbnPyAxDwltE8XhnqI89DA1bAx0urXHx5eO3riRj2o=;
 b=XG/QidKHJ3UVi7jBYS4iXk/chNyLVK5qtcrH7u2ktHATzpI9cZjyebibbEqStKHK9R
 7wthNTZiXwrPSv9SzM+uxpgUxki0bCJc2HTf/KLRKNUnzr1yLFALJDZN8LWSCpFr/TOK
 zRdKdEf5Lg5MKqt0Pu0Hq4uS9NMia17cTqfrMROvQIp6bbcmS7sqet+2kOJtq+fRcBq2
 OLwdnbKH1olJ0sJadCfGpUWS2CE7oco048raJc0B24rvY0WYRhYEVm/QRWjKqu7IKhBE
 /Sdb0UcAw0M8lcXCTixM6kFBpRW2gL92SydTwSZpoMnKPMm9eaKLMZKMPJYzd3dqCIME
 ABUw==
X-Gm-Message-State: AOAM532MwO13AiaKkx2ewF2CkimalvqHDR1cMMauq5WQtF5Fu8LGefan
 rXuLnNBzVdwJHXmduH6uiWiqwwSoEFXsyTspQfkNwTX/b+UEZ5tjh0sDNKtSKt4zsPsDmMAcrZT
 xuBsNe0YpyRuJBK4=
X-Received: by 2002:a7b:cd93:: with SMTP id y19mr10166989wmj.112.1601793300521; 
 Sat, 03 Oct 2020 23:35:00 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxuBbKdZ23iVO3EnXlDEkaz//t8xWQAHbeaR//OZmnzkTO3K7NcXs5xI5R0rLqH7mW6cTxwwA==
X-Received: by 2002:a7b:cd93:: with SMTP id y19mr10166979wmj.112.1601793300281; 
 Sat, 03 Oct 2020 23:35:00 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:489d:70b5:777c:1988?
 ([2001:b07:6468:f312:489d:70b5:777c:1988])
 by smtp.gmail.com with ESMTPSA id u2sm8454611wre.7.2020.10.03.23.34.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 03 Oct 2020 23:34:59 -0700 (PDT)
Subject: Re: [PATCH] dockerfiles: add diffutils to Fedora
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org
References: <20201003085054.332992-2-pbonzini@redhat.com>
 <48dd90e6-c5fe-5749-ac0a-5128c0496ea9@amsat.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <90b66907-2f5e-af8c-36ee-0d8dddbb5a8e@redhat.com>
Date: Sun, 4 Oct 2020 08:34:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <48dd90e6-c5fe-5749-ac0a-5128c0496ea9@amsat.org>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/04 02:35:03
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.252, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
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
Cc: alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 03/10/20 20:00, Philippe Mathieu-Daudé wrote:
>>
>> diff --git a/tests/docker/dockerfiles/fedora.docker b/tests/docker/dockerfiles/fedora.docker
>> index 71e4b56977..ec783418c8 100644
>> --- a/tests/docker/dockerfiles/fedora.docker
>> +++ b/tests/docker/dockerfiles/fedora.docker
>> @@ -11,6 +11,7 @@ ENV PACKAGES \
>>      cyrus-sasl-devel \
>>      dbus-daemon \
>>      device-mapper-multipath-devel \
>> +    diffutils \
>>      findutils \
>>      gcc \
>>      gcc-c++ \
>>
> What about tests/docker/dockerfiles/fedora-cris-cross.docker
> and tests/docker/dockerfiles/fedora-i386-cross.docker?
> 

They're only used for gcc, not to build QEMU.

Paolo


