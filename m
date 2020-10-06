Return-Path: <SRS0=+uBF=DN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64CEFC41604
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Oct 2020 09:27:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4F403206B5
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Oct 2020 09:27:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KM86jwlh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F403206B5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35740 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPjFa-0001m5-3v
	for qemu-devel@archiver.kernel.org; Tue, 06 Oct 2020 05:27:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37484)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kPjEz-0001HW-PE
 for qemu-devel@nongnu.org; Tue, 06 Oct 2020 05:26:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:58873)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kPjEx-00008n-Gm
 for qemu-devel@nongnu.org; Tue, 06 Oct 2020 05:26:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601976394;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=ZE6/KQVwX4nHNVIyURBXkLfFzSRnqpnxFmVm9pB1DHo=;
 b=KM86jwlh6QMjC/RnuwFQselF/Vf+1c817LSTKXnT7N2WGHhu+e+DaDFrw7t/iVX1+MvHhR
 NwkukN6EnGBMcKHTPdiYnSjmjvWy/5c49QhrjYUB72qwH9xRjL+KlTGoD8OMlcwUsbDpLE
 Nc3/lUp9mqLvawYpEs00i13g6HoDUnY=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-277-0_mK1YyiP5Oc8MXf2H4kCw-1; Tue, 06 Oct 2020 05:26:32 -0400
X-MC-Unique: 0_mK1YyiP5Oc8MXf2H4kCw-1
Received: by mail-wr1-f69.google.com with SMTP id v12so5127394wrm.9
 for <qemu-devel@nongnu.org>; Tue, 06 Oct 2020 02:26:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=ZE6/KQVwX4nHNVIyURBXkLfFzSRnqpnxFmVm9pB1DHo=;
 b=nCSw3xXAqtYuxznT9ZPd2z33CTAX9BQQJ3cshP01s8l1L+smEDB5m1ZrhA3xbyEZXy
 8NPNWcUjLrdS6wFs2L2YC/BHdbZPvU0Om904rX79oq2VmIRAzGV26z5DWiWu2btD45wz
 WeH+Yq6xITGzzSAI86FbwxDM8gGwlDCpfxT/w9tLZG4+9suFq4c1rjP4qJHX9KrE7Yrr
 jK4IWK2XiMyAE3iZgYqsX7EAXh0m8pqsSQhJOyVHBxZMH7pTiqgYfAY5zlqnGtx4mdgs
 T0tvyyd2GjpoMSGIVMeGk40mnOSjtE+wplpLNSkpZIaH7vCx3b4D4CHAXpuZEat/FrO8
 Cphw==
X-Gm-Message-State: AOAM5334v/4//vbrs8/KfU8j1DK1IJP5q/47bLXUCcIFzy3nnJSbao/H
 H/DKELoylqGLtAsNnBQBT3IgwwjVJz/XRadS62zTmvYkbtqceq0qPubl9/BiR52772EVByPXekK
 FWYsFxlcJ5g7/BdU=
X-Received: by 2002:a1c:7e90:: with SMTP id z138mr3693882wmc.122.1601976391696; 
 Tue, 06 Oct 2020 02:26:31 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwLEaRAf38pj/gr+c8BJE4OMK7XEWj4p7jiNauonXe2tJQwHI9cZYUiPnIhnn7tVbIKJA9JSw==
X-Received: by 2002:a1c:7e90:: with SMTP id z138mr3693861wmc.122.1601976391359; 
 Tue, 06 Oct 2020 02:26:31 -0700 (PDT)
Received: from [192.168.1.36] (106.red-83-59-162.dynamicip.rima-tde.net.
 [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id n21sm3094878wmi.21.2020.10.06.02.26.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 06 Oct 2020 02:26:30 -0700 (PDT)
Subject: Re: [PULL 5/5] crypto/tls-cipher-suites: Produce fw_cfg consumable
 blob
To: Laszlo Ersek <lersek@redhat.com>, Kevin Wolf <kwolf@redhat.com>
References: <20200704163927.28188-1-philmd@redhat.com>
 <20200704163927.28188-6-philmd@redhat.com>
 <20200929154651.GC4398@linux.fritz.box>
 <d454d4ae-3c8b-72fb-698d-938e11d18d3a@redhat.com>
 <b47fe2e3-6867-20ec-70b5-c2dd52c6d698@redhat.com>
 <23aed98b-6844-d027-14dd-26298698160d@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Autocrypt: addr=philmd@redhat.com; keydata=
 mQINBDXML8YBEADXCtUkDBKQvNsQA7sDpw6YLE/1tKHwm24A1au9Hfy/OFmkpzo+MD+dYc+7
 bvnqWAeGweq2SDq8zbzFZ1gJBd6+e5v1a/UrTxvwBk51yEkadrpRbi+r2bDpTJwXc/uEtYAB
 GvsTZMtiQVA4kRID1KCdgLa3zztPLCj5H1VZhqZsiGvXa/nMIlhvacRXdbgllPPJ72cLUkXf
 z1Zu4AkEKpccZaJspmLWGSzGu6UTZ7UfVeR2Hcc2KI9oZB1qthmZ1+PZyGZ/Dy+z+zklC0xl
 XIpQPmnfy9+/1hj1LzJ+pe3HzEodtlVA+rdttSvA6nmHKIt8Ul6b/h1DFTmUT1lN1WbAGxmg
 CH1O26cz5nTrzdjoqC/b8PpZiT0kO5MKKgiu5S4PRIxW2+RA4H9nq7nztNZ1Y39bDpzwE5Sp
 bDHzd5owmLxMLZAINtCtQuRbSOcMjZlg4zohA9TQP9krGIk+qTR+H4CV22sWldSkVtsoTaA2
 qNeSJhfHQY0TyQvFbqRsSNIe2gTDzzEQ8itsmdHHE/yzhcCVvlUzXhAT6pIN0OT+cdsTTfif
 MIcDboys92auTuJ7U+4jWF1+WUaJ8gDL69ThAsu7mGDBbm80P3vvUZ4fQM14NkxOnuGRrJxO
 qjWNJ2ZUxgyHAh5TCxMLKWZoL5hpnvx3dF3Ti9HW2dsUUWICSQARAQABtDJQaGlsaXBwZSBN
 YXRoaWV1LURhdWTDqSAoUGhpbCkgPHBoaWxtZEByZWRoYXQuY29tPokCVQQTAQgAPwIbDwYL
 CQgHAwIGFQgCCQoLBBYCAwECHgECF4AWIQSJweePYB7obIZ0lcuio/1u3q3A3gUCXsfWwAUJ
 KtymWgAKCRCio/1u3q3A3ircD/9Vjh3aFNJ3uF3hddeoFg1H038wZr/xi8/rX27M1Vj2j9VH
 0B8Olp4KUQw/hyO6kUxqkoojmzRpmzvlpZ0cUiZJo2bQIWnvScyHxFCv33kHe+YEIqoJlaQc
 JfKYlbCoubz+02E2A6bFD9+BvCY0LBbEj5POwyKGiDMjHKCGuzSuDRbCn0Mz4kCa7nFMF5Jv
 piC+JemRdiBd6102ThqgIsyGEBXuf1sy0QIVyXgaqr9O2b/0VoXpQId7yY7OJuYYxs7kQoXI
 6WzSMpmuXGkmfxOgbc/L6YbzB0JOriX0iRClxu4dEUg8Bs2pNnr6huY2Ft+qb41RzCJvvMyu
 gS32LfN0bTZ6Qm2A8ayMtUQgnwZDSO23OKgQWZVglGliY3ezHZ6lVwC24Vjkmq/2yBSLakZE
 6DZUjZzCW1nvtRK05ebyK6tofRsx8xB8pL/kcBb9nCuh70aLR+5cmE41X4O+MVJbwfP5s/RW
 9BFSL3qgXuXso/3XuWTQjJJGgKhB6xXjMmb1J4q/h5IuVV4juv1Fem9sfmyrh+Wi5V1IzKI7
 RPJ3KVb937eBgSENk53P0gUorwzUcO+ASEo3Z1cBKkJSPigDbeEjVfXQMzNt0oDRzpQqH2vp
 apo2jHnidWt8BsckuWZpxcZ9+/9obQ55DyVQHGiTN39hkETy3Emdnz1JVHTU0Q==
Message-ID: <6c69e142-16b3-571a-5545-2e947893a578@redhat.com>
Date: Tue, 6 Oct 2020 11:26:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <23aed98b-6844-d027-14dd-26298698160d@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/06 00:55:20
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.733,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org,
 Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/6/20 10:41 AM, Laszlo Ersek wrote:
> On 10/05/20 11:16, Philippe Mathieu-Daudé wrote:
>> Hi Laszlo,
>>
>> On 10/1/20 9:18 AM, Laszlo Ersek wrote:
>>> On 09/29/20 17:46, Kevin Wolf wrote:
>>>> Am 04.07.2020 um 18:39 hat Philippe Mathieu-Daudé geschrieben:
>>>>> Since our format is consumable by the fw_cfg device,
>>>>> we can implement the FW_CFG_DATA_GENERATOR interface.
>>>>>
>>>>> Example of use to dump the cipher suites (if tracing enabled):
>>>>>
>>>>>   $ qemu-system-x86_64 -S \
>>>>>     -object tls-cipher-suites,id=mysuite1,priority=@SYSTEM \
>>>>>     -fw_cfg name=etc/path/to/ciphers,gen_id=mysuite1 \
>>>>>     -trace qcrypto\*
>>>>>   1590664444.197123:qcrypto_tls_cipher_suite_priority priority: @SYSTEM
>>>>>   1590664444.197219:qcrypto_tls_cipher_suite_info data=[0x13,0x02] version=TLS1.3 name=TLS_AES_256_GCM_SHA384
>>>>>   1590664444.197228:qcrypto_tls_cipher_suite_info data=[0x13,0x03] version=TLS1.3 name=TLS_CHACHA20_POLY1305_SHA256
>>>>>   1590664444.197233:qcrypto_tls_cipher_suite_info data=[0x13,0x01] version=TLS1.3 name=TLS_AES_128_GCM_SHA256
>>>>>   1590664444.197236:qcrypto_tls_cipher_suite_info data=[0x13,0x04] version=TLS1.3 name=TLS_AES_128_CCM_SHA256
>>>>>   1590664444.197240:qcrypto_tls_cipher_suite_info data=[0xc0,0x30] version=TLS1.2 name=TLS_ECDHE_RSA_AES_256_GCM_SHA384
>>>>>   1590664444.197245:qcrypto_tls_cipher_suite_info data=[0xcc,0xa8] version=TLS1.2 name=TLS_ECDHE_RSA_CHACHA20_POLY1305
>>>>>   1590664444.197250:qcrypto_tls_cipher_suite_info data=[0xc0,0x14] version=TLS1.0 name=TLS_ECDHE_RSA_AES_256_CBC_SHA1
>>>>>   1590664444.197254:qcrypto_tls_cipher_suite_info data=[0xc0,0x2f] version=TLS1.2 name=TLS_ECDHE_RSA_AES_128_GCM_SHA256
>>>>>   1590664444.197258:qcrypto_tls_cipher_suite_info data=[0xc0,0x13] version=TLS1.0 name=TLS_ECDHE_RSA_AES_128_CBC_SHA1
>>>>>   1590664444.197261:qcrypto_tls_cipher_suite_info data=[0xc0,0x2c] version=TLS1.2 name=TLS_ECDHE_ECDSA_AES_256_GCM_SHA384
>>>>>   1590664444.197266:qcrypto_tls_cipher_suite_info data=[0xcc,0xa9] version=TLS1.2 name=TLS_ECDHE_ECDSA_CHACHA20_POLY1305
>>>>>   1590664444.197270:qcrypto_tls_cipher_suite_info data=[0xc0,0xad] version=TLS1.2 name=TLS_ECDHE_ECDSA_AES_256_CCM
>>>>>   1590664444.197274:qcrypto_tls_cipher_suite_info data=[0xc0,0x0a] version=TLS1.0 name=TLS_ECDHE_ECDSA_AES_256_CBC_SHA1
>>>>>   1590664444.197278:qcrypto_tls_cipher_suite_info data=[0xc0,0x2b] version=TLS1.2 name=TLS_ECDHE_ECDSA_AES_128_GCM_SHA256
>>>>>   1590664444.197283:qcrypto_tls_cipher_suite_info data=[0xc0,0xac] version=TLS1.2 name=TLS_ECDHE_ECDSA_AES_128_CCM
>>>>>   1590664444.197287:qcrypto_tls_cipher_suite_info data=[0xc0,0x09] version=TLS1.0 name=TLS_ECDHE_ECDSA_AES_128_CBC_SHA1
>>>>>   1590664444.197291:qcrypto_tls_cipher_suite_info data=[0x00,0x9d] version=TLS1.2 name=TLS_RSA_AES_256_GCM_SHA384
>>>>>   1590664444.197296:qcrypto_tls_cipher_suite_info data=[0xc0,0x9d] version=TLS1.2 name=TLS_RSA_AES_256_CCM
>>>>>   1590664444.197300:qcrypto_tls_cipher_suite_info data=[0x00,0x35] version=TLS1.0 name=TLS_RSA_AES_256_CBC_SHA1
>>>>>   1590664444.197304:qcrypto_tls_cipher_suite_info data=[0x00,0x9c] version=TLS1.2 name=TLS_RSA_AES_128_GCM_SHA256
>>>>>   1590664444.197308:qcrypto_tls_cipher_suite_info data=[0xc0,0x9c] version=TLS1.2 name=TLS_RSA_AES_128_CCM
>>>>>   1590664444.197312:qcrypto_tls_cipher_suite_info data=[0x00,0x2f] version=TLS1.0 name=TLS_RSA_AES_128_CBC_SHA1
>>>>>   1590664444.197316:qcrypto_tls_cipher_suite_info data=[0x00,0x9f] version=TLS1.2 name=TLS_DHE_RSA_AES_256_GCM_SHA384
>>>>>   1590664444.197320:qcrypto_tls_cipher_suite_info data=[0xcc,0xaa] version=TLS1.2 name=TLS_DHE_RSA_CHACHA20_POLY1305
>>>>>   1590664444.197325:qcrypto_tls_cipher_suite_info data=[0xc0,0x9f] version=TLS1.2 name=TLS_DHE_RSA_AES_256_CCM
>>>>>   1590664444.197329:qcrypto_tls_cipher_suite_info data=[0x00,0x39] version=TLS1.0 name=TLS_DHE_RSA_AES_256_CBC_SHA1
>>>>>   1590664444.197333:qcrypto_tls_cipher_suite_info data=[0x00,0x9e] version=TLS1.2 name=TLS_DHE_RSA_AES_128_GCM_SHA256
>>>>>   1590664444.197337:qcrypto_tls_cipher_suite_info data=[0xc0,0x9e] version=TLS1.2 name=TLS_DHE_RSA_AES_128_CCM
>>>>>   1590664444.197341:qcrypto_tls_cipher_suite_info data=[0x00,0x33] version=TLS1.0 name=TLS_DHE_RSA_AES_128_CBC_SHA1
>>>>>   1590664444.197345:qcrypto_tls_cipher_suite_count count: 29
>>>>>
>>>>> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
>>>>> Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
>>>>> Acked-by: Laszlo Ersek <lersek@redhat.com>
>>>>> Message-Id: <20200623172726.21040-6-philmd@redhat.com>
>>>>
>>>> I noticed only now that this breaks '--object help' in
>>>> qemu-storage-daemon:
>>>>
>>>> $ qemu-storage-daemon --object help
>>>> List of user creatable objects:
>>>> qemu-storage-daemon: missing interface 'fw_cfg-data-generator' for object 'tls-creds'
>>>> Aborted (core dumped)
>>>>
>>>> The reason is that we don't (and can't) link hw/nvram/fw_cfg.c into the
>>>> storage daemon because it requires other system emulator stuff.
>>>
>>> Ouch. I've been completely oblivious to "--object help" and how it
>>> affects qemu-storage-daemon. Sorry about that.
>>>
>>> Could you please include a backtrace about the abort()?
>>>
>>> Grepping for the error message, I can find type_initialize() in
>>> "qom/object.c", but my knowledge about QOM internals is practically nil.
>>>
>>> The error message seems bogus FWIW -- why would
>>> TYPE_FW_CFG_DATA_GENERATOR_INTERFACE be *required* from "tls-creds"?
>>>
>>> TYPE_FW_CFG_DATA_GENERATOR_INTERFACE is implemented by
>>> "tls-cipher-suites", and required by "-fw_cfg name=...,gen_id=...". If
>>> that -fw_cfg switch is not used, then why would anything look for the
>>> TYPE_FW_CFG_DATA_GENERATOR_INTERFACE interface? Especially under the
>>> tls-creds object?
>>
>> Sorry for not updating Kevin's post in time (we have been discussing
>> over IRC).
>>
>> What happens here is a QOM design flow, first triggered by fw_cfg as
>> we are now trying to have QEMU split into more components.
>>
>> QOM interface/object type names are simple strings, so we don't get
>> any link failure in case of missing dependency (which are resolved at
>> runtime using strcmp).
>>
>> "tls-cipher-suites" is a generic crypto object, it happens to implement
>> the fw_cfg-data-generator interface. The fw_cfg-data-generator interface
>> is registered as QOM type in hw/nvram/fw_cfg.c which is only built when
>> SOFTMMU is selected. qemu-storage-daemon doesn't select SOFTMMU.
>> We don't want to restrict "tls-cipher-suites" to SOFTMMU.
>>
>> The simplest fix we discuss is to have a single C file to register the
>> fw_cfg-data-generator interface in QOM, and link with it if any of
>> CRYPTO / NVRAM kconfig is selected.
>>
>> I'll send a patch.
> 
> Thank you for the explanation!
> 
> (I suggest keeping such discussions *originally* on the list. IRC is
> practically indistinguishable from the bit bucket, and you'll have to
> write up a summary for others on the mailing list anyway. (In some cases
> it could even require filing a ticket in some tracker, in the end.) Best
> to have the discussion at once on the list. Just my suggestion of course.)

There are so many discussions there... But you are right,
noted for the areas I'm co-maintaining, I'll summarize on
the list.

Regards,

Phil.


