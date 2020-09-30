Return-Path: <SRS0=HfOj=DH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0144C4727E
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 13:18:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 57F4E20738
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 13:18:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q7TcezTC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57F4E20738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37270 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNc00-0002rs-G3
	for qemu-devel@archiver.kernel.org; Wed, 30 Sep 2020 09:18:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58696)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kNbyu-00029h-UI
 for qemu-devel@nongnu.org; Wed, 30 Sep 2020 09:17:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:29866)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kNbyt-0003Sh-EE
 for qemu-devel@nongnu.org; Wed, 30 Sep 2020 09:17:16 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601471834;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=k+T3hp1G/8usQabHu6Z+BeraaB8GJWxJvx9lFv1z4Og=;
 b=Q7TcezTCB1xb2JRAT6Hfo0aRjeW+tcKMnXUgGdMal/VGdrKt55fjCS5G2ukmLCs+LyD1pr
 Iu0wdIgvKR+94kuRjGflOoWCRpIoeCjrLKArsmjjar6DhQrWudmq9lAr/W4Tw7PMUtw13a
 xvGUlbMUXyyDiC/uvTHfCYHZjO+LyAU=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-560-N0JF5_xpNGaxNikaDJ264w-1; Wed, 30 Sep 2020 09:17:09 -0400
X-MC-Unique: N0JF5_xpNGaxNikaDJ264w-1
Received: by mail-wm1-f70.google.com with SMTP id t10so457004wmi.9
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2020 06:17:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=k+T3hp1G/8usQabHu6Z+BeraaB8GJWxJvx9lFv1z4Og=;
 b=hqytutFv+DaEP0JqBOnEzIcZAaYzx1KuLqdtNeHrRMyrUFKE4eZYrq/C9yypcGuL8N
 bF/xPy3xkCY9r4MlfxWLxvr4/7t7SL8STph4DerXXfnFwzR4lg6JvdvdRtTz4JF1uLok
 KffFasmZTFY1UKRHc+6/TlXVnlhvH+qPGcr7dELBTRvtDw7NdRM9LYF4m5nrxpbZHJ9J
 ZUXVRcNKUZUbNwLsEOHNmpSonYpYaWJNUxEoUSnLhWLnwjLw9ThBHy2Ydu7NgfQL7S23
 L/FK5ETnLadNmKrsOAC2dhMeeawVkubMj+GjedOtMCbSt9UQoNLwYFfLlNxfTCU8ZFH+
 bIhQ==
X-Gm-Message-State: AOAM531RvcZzlDf9P6hy0g0lE+JO9m2qwIpAKM93v89KZVYMu3KGzDFF
 SbFFhpezQ+h9xiuFHiHCTvCWZGX5V6APRebGOlres9268+B78GmdL3Gj8YWOceh+F6889XpRl0y
 qoYIodZbgf2OT52c=
X-Received: by 2002:a5d:570b:: with SMTP id a11mr3221728wrv.139.1601471828201; 
 Wed, 30 Sep 2020 06:17:08 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyFWiFaTR4B/SjKzTAPoCC3OoRM1zFV1RHDbm+NroRgIJcx+EUjmdCrnL/ItnriRxkgp0BBAA==
X-Received: by 2002:a5d:570b:: with SMTP id a11mr3221701wrv.139.1601471827982; 
 Wed, 30 Sep 2020 06:17:07 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:75e3:aaa7:77d6:f4e4?
 ([2001:b07:6468:f312:75e3:aaa7:77d6:f4e4])
 by smtp.gmail.com with ESMTPSA id h3sm3118133wrq.0.2020.09.30.06.17.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 30 Sep 2020 06:17:07 -0700 (PDT)
Subject: Re: [PATCH v4 02/12] meson: Allow optional target/${ARCH}/Kconfig
To: Claudio Fontana <cfontana@suse.de>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
References: <20200929224355.1224017-1-philmd@redhat.com>
 <20200929224355.1224017-3-philmd@redhat.com>
 <19b1318a-f9be-5808-760b-ba7748d48267@suse.de>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <254ee778-e8b6-9acf-d7c7-075eb3a88a65@redhat.com>
Date: Wed, 30 Sep 2020 15:17:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <19b1318a-f9be-5808-760b-ba7748d48267@suse.de>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/30 00:31:59
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.469,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
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
Cc: Fam Zheng <fam@euphon.net>, Peter Maydell <peter.maydell@linaro.org>,
 Thomas Huth <thuth@redhat.com>, kvm@vger.kernel.org,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 30/09/20 14:50, Claudio Fontana wrote:
> On 9/30/20 12:43 AM, Philippe Mathieu-Daudé wrote:
>> Extend the generic Meson script to pass optional target Kconfig
>> file to the minikconf script.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
>> ---
>> We could use fs.exists() but is_file() is more specific
>> (can not be a directory).
>>
>> Cc: Paolo Bonzini <pbonzini@redhat.com>
>> Cc: Claudio Fontana <cfontana@suse.de>
>> ---
>>  meson.build | 8 +++++++-
>>  1 file changed, 7 insertions(+), 1 deletion(-)
>>
>> diff --git a/meson.build b/meson.build
>> index d36dd085b5..9ab5d514d7 100644
>> --- a/meson.build
>> +++ b/meson.build
>> @@ -529,6 +529,7 @@ kconfig_external_symbols = [
>>  ]
>>  ignored = ['TARGET_XML_FILES', 'TARGET_ABI_DIR', 'TARGET_DIRS']
>>  
>> +fs = import('fs')
>>  foreach target : target_dirs
>>    config_target = keyval.load(meson.current_build_dir() / target / 'config-target.mak')
>>  
>> @@ -569,8 +570,13 @@ foreach target : target_dirs
>>      endforeach
>>  
>>      config_devices_mak = target + '-config-devices.mak'
>> +    target_kconfig = 'target' / config_target['TARGET_BASE_ARCH'] / 'Kconfig'
>> +    minikconf_input = ['default-configs' / target + '.mak', 'Kconfig']
>> +    if fs.is_file(target_kconfig)
>> +      minikconf_input += [target_kconfig]
>> +    endif
>>      config_devices_mak = configure_file(
>> -      input: ['default-configs' / target + '.mak', 'Kconfig'],
>> +      input: minikconf_input,
>>        output: config_devices_mak,
>>        depfile: config_devices_mak + '.d',
>>        capture: true,
>>
> 
> I can't say I understand it, but the general idea seems right to me.

Acked-by: Paolo Bonzini <pbonzini@redhat.com>


