Return-Path: <SRS0=FSHi=DM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 080F8C4363A
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2020 09:18:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6624F2074F
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2020 09:18:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DBE5l74C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6624F2074F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60716 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPMdm-00066M-Gd
	for qemu-devel@archiver.kernel.org; Mon, 05 Oct 2020 05:18:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48628)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kPMc9-0005Dg-SN
 for qemu-devel@nongnu.org; Mon, 05 Oct 2020 05:17:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:31720)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kPMc6-0006DF-7i
 for qemu-devel@nongnu.org; Mon, 05 Oct 2020 05:17:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601889416;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=cgbDBklWtz2zyPEw1VL2vtLw8AKGJ5XicG+4GOisVMc=;
 b=DBE5l74CSROn0Qgxc0csAcgQ+HDHvFgD3NedXP/uZ9T9+nkP61WM7noZC1wJRaufbYITDR
 QuC7q5u5QWioMFVC0LaAjhwMZpckFGtwZmzpDqgyKwpI6QKtpPxHrrR54aBoecuRSK8888
 yZhhfCHyfx7KnbunzGhEAcy4EucTcgs=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-395-nR_oI32TPEmHYt-hsITmVA-1; Mon, 05 Oct 2020 05:16:55 -0400
X-MC-Unique: nR_oI32TPEmHYt-hsITmVA-1
Received: by mail-wr1-f72.google.com with SMTP id 33so3739552wrk.12
 for <qemu-devel@nongnu.org>; Mon, 05 Oct 2020 02:16:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=cgbDBklWtz2zyPEw1VL2vtLw8AKGJ5XicG+4GOisVMc=;
 b=DHNGFsj4WoxgXU//fu2cg+lU6SJGMQqTBzX21iQ0Qp/gLjUdprbiNwOO1DNqElmD+y
 138yrRu4ovke4z8KYIeLrdVKwBiW0Iv6c3jKqaptd11rKNZLAwb7dLi7ehour0d0A8QT
 bFTGa2bT98e8lUbmsCN+BfN3U361L6HOGborrZ8fcr9ERVmIVMhGIlBNXjOFPZS8N7Tz
 qH4b3KsKej2v05wn9CbDHMMcSDnSvGYKigQplVaVyFp/w74Z28hLExO2f1nJA1Xpm9Vq
 H2gt4XNm4iU2WBD6NW7KiAmO/NFj5uv6Dzh6L3ohm/3hTyDQDRVOY0XUpEpcAvPyT2v4
 ZJKQ==
X-Gm-Message-State: AOAM533A0co8Bj3Pi7o1QIxivF2hJ02Oe7oRwY18Q7QXWTnOctEphuuS
 u9Fg9d1sdgGdqyf+3fcqewMSjKOQDJ1EDed+lcC9SiVM5SaFApWh9Qd9UuTftKftXoOkdYH8gE8
 64Mwpd9i8w/y4WLw=
X-Received: by 2002:adf:f30a:: with SMTP id i10mr11036844wro.296.1601889414133; 
 Mon, 05 Oct 2020 02:16:54 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJysnS5dqZblK4lbSeeMlVgAg5iTrs2O5jmXsT8W85lTP1gfSiEa8/uk8iAUXxubpzRdF9sNFQ==
X-Received: by 2002:adf:f30a:: with SMTP id i10mr11036812wro.296.1601889413883; 
 Mon, 05 Oct 2020 02:16:53 -0700 (PDT)
Received: from [192.168.1.36] (106.red-83-59-162.dynamicip.rima-tde.net.
 [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id h17sm13245478wro.27.2020.10.05.02.16.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 05 Oct 2020 02:16:52 -0700 (PDT)
Subject: Re: [PULL 5/5] crypto/tls-cipher-suites: Produce fw_cfg consumable
 blob
To: Laszlo Ersek <lersek@redhat.com>, Kevin Wolf <kwolf@redhat.com>
References: <20200704163927.28188-1-philmd@redhat.com>
 <20200704163927.28188-6-philmd@redhat.com>
 <20200929154651.GC4398@linux.fritz.box>
 <d454d4ae-3c8b-72fb-698d-938e11d18d3a@redhat.com>
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
Message-ID: <b47fe2e3-6867-20ec-70b5-c2dd52c6d698@redhat.com>
Date: Mon, 5 Oct 2020 11:16:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <d454d4ae-3c8b-72fb-698d-938e11d18d3a@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/05 02:11:31
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.745,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1,
 RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org,
 Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Laszlo,

On 10/1/20 9:18 AM, Laszlo Ersek wrote:
> On 09/29/20 17:46, Kevin Wolf wrote:
>> Am 04.07.2020 um 18:39 hat Philippe Mathieu-Daudé geschrieben:
>>> Since our format is consumable by the fw_cfg device,
>>> we can implement the FW_CFG_DATA_GENERATOR interface.
>>>
>>> Example of use to dump the cipher suites (if tracing enabled):
>>>
>>>   $ qemu-system-x86_64 -S \
>>>     -object tls-cipher-suites,id=mysuite1,priority=@SYSTEM \
>>>     -fw_cfg name=etc/path/to/ciphers,gen_id=mysuite1 \
>>>     -trace qcrypto\*
>>>   1590664444.197123:qcrypto_tls_cipher_suite_priority priority: @SYSTEM
>>>   1590664444.197219:qcrypto_tls_cipher_suite_info data=[0x13,0x02] version=TLS1.3 name=TLS_AES_256_GCM_SHA384
>>>   1590664444.197228:qcrypto_tls_cipher_suite_info data=[0x13,0x03] version=TLS1.3 name=TLS_CHACHA20_POLY1305_SHA256
>>>   1590664444.197233:qcrypto_tls_cipher_suite_info data=[0x13,0x01] version=TLS1.3 name=TLS_AES_128_GCM_SHA256
>>>   1590664444.197236:qcrypto_tls_cipher_suite_info data=[0x13,0x04] version=TLS1.3 name=TLS_AES_128_CCM_SHA256
>>>   1590664444.197240:qcrypto_tls_cipher_suite_info data=[0xc0,0x30] version=TLS1.2 name=TLS_ECDHE_RSA_AES_256_GCM_SHA384
>>>   1590664444.197245:qcrypto_tls_cipher_suite_info data=[0xcc,0xa8] version=TLS1.2 name=TLS_ECDHE_RSA_CHACHA20_POLY1305
>>>   1590664444.197250:qcrypto_tls_cipher_suite_info data=[0xc0,0x14] version=TLS1.0 name=TLS_ECDHE_RSA_AES_256_CBC_SHA1
>>>   1590664444.197254:qcrypto_tls_cipher_suite_info data=[0xc0,0x2f] version=TLS1.2 name=TLS_ECDHE_RSA_AES_128_GCM_SHA256
>>>   1590664444.197258:qcrypto_tls_cipher_suite_info data=[0xc0,0x13] version=TLS1.0 name=TLS_ECDHE_RSA_AES_128_CBC_SHA1
>>>   1590664444.197261:qcrypto_tls_cipher_suite_info data=[0xc0,0x2c] version=TLS1.2 name=TLS_ECDHE_ECDSA_AES_256_GCM_SHA384
>>>   1590664444.197266:qcrypto_tls_cipher_suite_info data=[0xcc,0xa9] version=TLS1.2 name=TLS_ECDHE_ECDSA_CHACHA20_POLY1305
>>>   1590664444.197270:qcrypto_tls_cipher_suite_info data=[0xc0,0xad] version=TLS1.2 name=TLS_ECDHE_ECDSA_AES_256_CCM
>>>   1590664444.197274:qcrypto_tls_cipher_suite_info data=[0xc0,0x0a] version=TLS1.0 name=TLS_ECDHE_ECDSA_AES_256_CBC_SHA1
>>>   1590664444.197278:qcrypto_tls_cipher_suite_info data=[0xc0,0x2b] version=TLS1.2 name=TLS_ECDHE_ECDSA_AES_128_GCM_SHA256
>>>   1590664444.197283:qcrypto_tls_cipher_suite_info data=[0xc0,0xac] version=TLS1.2 name=TLS_ECDHE_ECDSA_AES_128_CCM
>>>   1590664444.197287:qcrypto_tls_cipher_suite_info data=[0xc0,0x09] version=TLS1.0 name=TLS_ECDHE_ECDSA_AES_128_CBC_SHA1
>>>   1590664444.197291:qcrypto_tls_cipher_suite_info data=[0x00,0x9d] version=TLS1.2 name=TLS_RSA_AES_256_GCM_SHA384
>>>   1590664444.197296:qcrypto_tls_cipher_suite_info data=[0xc0,0x9d] version=TLS1.2 name=TLS_RSA_AES_256_CCM
>>>   1590664444.197300:qcrypto_tls_cipher_suite_info data=[0x00,0x35] version=TLS1.0 name=TLS_RSA_AES_256_CBC_SHA1
>>>   1590664444.197304:qcrypto_tls_cipher_suite_info data=[0x00,0x9c] version=TLS1.2 name=TLS_RSA_AES_128_GCM_SHA256
>>>   1590664444.197308:qcrypto_tls_cipher_suite_info data=[0xc0,0x9c] version=TLS1.2 name=TLS_RSA_AES_128_CCM
>>>   1590664444.197312:qcrypto_tls_cipher_suite_info data=[0x00,0x2f] version=TLS1.0 name=TLS_RSA_AES_128_CBC_SHA1
>>>   1590664444.197316:qcrypto_tls_cipher_suite_info data=[0x00,0x9f] version=TLS1.2 name=TLS_DHE_RSA_AES_256_GCM_SHA384
>>>   1590664444.197320:qcrypto_tls_cipher_suite_info data=[0xcc,0xaa] version=TLS1.2 name=TLS_DHE_RSA_CHACHA20_POLY1305
>>>   1590664444.197325:qcrypto_tls_cipher_suite_info data=[0xc0,0x9f] version=TLS1.2 name=TLS_DHE_RSA_AES_256_CCM
>>>   1590664444.197329:qcrypto_tls_cipher_suite_info data=[0x00,0x39] version=TLS1.0 name=TLS_DHE_RSA_AES_256_CBC_SHA1
>>>   1590664444.197333:qcrypto_tls_cipher_suite_info data=[0x00,0x9e] version=TLS1.2 name=TLS_DHE_RSA_AES_128_GCM_SHA256
>>>   1590664444.197337:qcrypto_tls_cipher_suite_info data=[0xc0,0x9e] version=TLS1.2 name=TLS_DHE_RSA_AES_128_CCM
>>>   1590664444.197341:qcrypto_tls_cipher_suite_info data=[0x00,0x33] version=TLS1.0 name=TLS_DHE_RSA_AES_128_CBC_SHA1
>>>   1590664444.197345:qcrypto_tls_cipher_suite_count count: 29
>>>
>>> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
>>> Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
>>> Acked-by: Laszlo Ersek <lersek@redhat.com>
>>> Message-Id: <20200623172726.21040-6-philmd@redhat.com>
>>
>> I noticed only now that this breaks '--object help' in
>> qemu-storage-daemon:
>>
>> $ qemu-storage-daemon --object help
>> List of user creatable objects:
>> qemu-storage-daemon: missing interface 'fw_cfg-data-generator' for object 'tls-creds'
>> Aborted (core dumped)
>>
>> The reason is that we don't (and can't) link hw/nvram/fw_cfg.c into the
>> storage daemon because it requires other system emulator stuff.
> 
> Ouch. I've been completely oblivious to "--object help" and how it
> affects qemu-storage-daemon. Sorry about that.
> 
> Could you please include a backtrace about the abort()?
> 
> Grepping for the error message, I can find type_initialize() in
> "qom/object.c", but my knowledge about QOM internals is practically nil.
> 
> The error message seems bogus FWIW -- why would
> TYPE_FW_CFG_DATA_GENERATOR_INTERFACE be *required* from "tls-creds"?
> 
> TYPE_FW_CFG_DATA_GENERATOR_INTERFACE is implemented by
> "tls-cipher-suites", and required by "-fw_cfg name=...,gen_id=...". If
> that -fw_cfg switch is not used, then why would anything look for the
> TYPE_FW_CFG_DATA_GENERATOR_INTERFACE interface? Especially under the
> tls-creds object?

Sorry for not updating Kevin's post in time (we have been discussing
over IRC).

What happens here is a QOM design flow, first triggered by fw_cfg as
we are now trying to have QEMU split into more components.

QOM interface/object type names are simple strings, so we don't get
any link failure in case of missing dependency (which are resolved at
runtime using strcmp).

"tls-cipher-suites" is a generic crypto object, it happens to implement
the fw_cfg-data-generator interface. The fw_cfg-data-generator interface
is registered as QOM type in hw/nvram/fw_cfg.c which is only built when
SOFTMMU is selected. qemu-storage-daemon doesn't select SOFTMMU.
We don't want to restrict "tls-cipher-suites" to SOFTMMU.

The simplest fix we discuss is to have a single C file to register the
fw_cfg-data-generator interface in QOM, and link with it if any of
CRYPTO / NVRAM kconfig is selected.

I'll send a patch.

Regards,

Phil.


