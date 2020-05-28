Return-Path: <SRS0=D+kF=7K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A54A4C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 10:18:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7027320776
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 10:18:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TpkBrJWS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7027320776
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48644 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jeFcL-0003bg-Kg
	for qemu-devel@archiver.kernel.org; Thu, 28 May 2020 06:18:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44086)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jeFbC-00020n-Ay
 for qemu-devel@nongnu.org; Thu, 28 May 2020 06:17:18 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:36203
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jeFbA-0006gz-KS
 for qemu-devel@nongnu.org; Thu, 28 May 2020 06:17:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590661034;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=tAvr10wZ2amEBB7wqb2emrEkE3eE3tKlnog6Ng/IVjY=;
 b=TpkBrJWS+bSjHLs+ncTVpSovMSnzrYjG1bfBPoyj3GaEgB34Ag0AwULI+gk0FnM5H9DKJO
 KiZ0CUODWYEOUZqKROkZInGgfsp59quylbTpJtPZge3o2E9ga6qjcoXa+oG+IOWk6/utS+
 AApWYapNVeBmVrlZSyJmShbRThEfTfc=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-471-YESW43-4NsihyogaxMkEKw-1; Thu, 28 May 2020 06:17:13 -0400
X-MC-Unique: YESW43-4NsihyogaxMkEKw-1
Received: by mail-wr1-f70.google.com with SMTP id s17so479652wrt.7
 for <qemu-devel@nongnu.org>; Thu, 28 May 2020 03:17:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=tAvr10wZ2amEBB7wqb2emrEkE3eE3tKlnog6Ng/IVjY=;
 b=LIkbIdvpDB8KU4YS2XHYtgVgz10iqPl7yzkSsWuCTqUhch/x9JA+gPNwDnzftUgemc
 aYwWL2bV3QuUXcO5GrBuQl7QWJKbsBoYTakeJTMS9YnnsApMSl/UPI21wvRvuefo2Rnp
 Y04cKng9Y1Lk9Oq45Sb1PxJNj1wEPj4qivBuA4y2z20MWfEB3IM8VVWtQNU6B05wWEdz
 wW0Xt/JOowuADlb1SuDE5qzpXcx4vOCdjGKJkSP807tQE4baPNI2ALLqydey+b4YR0Iw
 z0cVEX/MS3k37mxmFGf6wH6wyH2XhDVRHVJhTUZRRrBkrCxLt1cdv5RH9F+DlkEfGvwa
 HDEA==
X-Gm-Message-State: AOAM530Sb9iUWps6ALa204VFnEZ5egrrNX33WtwXrV5zNQKyPEnm7OJP
 jhVv49mFUJF2U/zl9pydZCMgsIGQk+mjCIUu7zKIB5KOdvB3GOplWn0celhrXn8hMWC2HqPy46H
 OyrGmgCknlHxbqss=
X-Received: by 2002:a5d:554b:: with SMTP id g11mr2863347wrw.260.1590661032066; 
 Thu, 28 May 2020 03:17:12 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxjVZq/aUuagDAJ53DzciDgbld8xTFsj/efIDWRPMPc/9xByyf0cEei6UEVdUU1blbbRu/lNQ==
X-Received: by 2002:a5d:554b:: with SMTP id g11mr2863326wrw.260.1590661031836; 
 Thu, 28 May 2020 03:17:11 -0700 (PDT)
Received: from [192.168.1.36] (71.red-88-21-204.staticip.rima-tde.net.
 [88.21.204.71])
 by smtp.gmail.com with ESMTPSA id a124sm6256584wmh.4.2020.05.28.03.17.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 28 May 2020 03:17:11 -0700 (PDT)
Subject: Re: [PATCH v6 4/5] crypto: Add tls-cipher-suites object
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
References: <20200519182024.14638-1-philmd@redhat.com>
 <20200519182024.14638-5-philmd@redhat.com>
 <20200527113643.GL2665520@redhat.com>
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
Message-ID: <0207f87c-4dc0-431c-935b-a1f6d437be15@redhat.com>
Date: Thu, 28 May 2020 12:17:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200527113643.GL2665520@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/28 02:50:32
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Laszlo Ersek <lersek@redhat.com>, qemu-devel@nongnu.org,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/27/20 1:36 PM, Daniel P. Berrangé wrote:
> On Tue, May 19, 2020 at 08:20:23PM +0200, Philippe Mathieu-Daudé wrote:
>> Example of use to dump:
>>
>>   $ qemu-system-x86_64 -S \
>>     -object tls-cipher-suites,id=mysuite,priority=@SYSTEM,verbose=yes
>>   Cipher suites for @SYSTEM:
>>   - TLS_AES_256_GCM_SHA384                                0x13, 0x02      TLS1.3
>>   - TLS_CHACHA20_POLY1305_SHA256                          0x13, 0x03      TLS1.3
>>   - TLS_AES_128_GCM_SHA256                                0x13, 0x01      TLS1.3
>>   - TLS_AES_128_CCM_SHA256                                0x13, 0x04      TLS1.3
>>   - TLS_ECDHE_RSA_AES_256_GCM_SHA384                      0xc0, 0x30      TLS1.2
>>   - TLS_ECDHE_RSA_CHACHA20_POLY1305                       0xcc, 0xa8      TLS1.2
>>   - TLS_ECDHE_RSA_AES_256_CBC_SHA1                        0xc0, 0x14      TLS1.0
>>   - TLS_ECDHE_RSA_AES_128_GCM_SHA256                      0xc0, 0x2f      TLS1.2
>>   - TLS_ECDHE_RSA_AES_128_CBC_SHA1                        0xc0, 0x13      TLS1.0
>>   - TLS_ECDHE_ECDSA_AES_256_GCM_SHA384                    0xc0, 0x2c      TLS1.2
>>   - TLS_ECDHE_ECDSA_CHACHA20_POLY1305                     0xcc, 0xa9      TLS1.2
>>   - TLS_ECDHE_ECDSA_AES_256_CCM                           0xc0, 0xad      TLS1.2
>>   - TLS_ECDHE_ECDSA_AES_256_CBC_SHA1                      0xc0, 0x0a      TLS1.0
>>   - TLS_ECDHE_ECDSA_AES_128_GCM_SHA256                    0xc0, 0x2b      TLS1.2
>>   - TLS_ECDHE_ECDSA_AES_128_CCM                           0xc0, 0xac      TLS1.2
>>   - TLS_ECDHE_ECDSA_AES_128_CBC_SHA1                      0xc0, 0x09      TLS1.0
>>   - TLS_RSA_AES_256_GCM_SHA384                            0x00, 0x9d      TLS1.2
>>   - TLS_RSA_AES_256_CCM                                   0xc0, 0x9d      TLS1.2
>>   - TLS_RSA_AES_256_CBC_SHA1                              0x00, 0x35      TLS1.0
>>   - TLS_RSA_AES_128_GCM_SHA256                            0x00, 0x9c      TLS1.2
>>   - TLS_RSA_AES_128_CCM                                   0xc0, 0x9c      TLS1.2
>>   - TLS_RSA_AES_128_CBC_SHA1                              0x00, 0x2f      TLS1.0
>>   - TLS_DHE_RSA_AES_256_GCM_SHA384                        0x00, 0x9f      TLS1.2
>>   - TLS_DHE_RSA_CHACHA20_POLY1305                         0xcc, 0xaa      TLS1.2
>>   - TLS_DHE_RSA_AES_256_CCM                               0xc0, 0x9f      TLS1.2
>>   - TLS_DHE_RSA_AES_256_CBC_SHA1                          0x00, 0x39      TLS1.0
>>   - TLS_DHE_RSA_AES_128_GCM_SHA256                        0x00, 0x9e      TLS1.2
>>   - TLS_DHE_RSA_AES_128_CCM                               0xc0, 0x9e      TLS1.2
>>   - TLS_DHE_RSA_AES_128_CBC_SHA1                          0x00, 0x33      TLS1.0
>>   total: 29 ciphers
> 
> IMHO this "verbose" option shouldn't exist. Instead we should be
> using the QEMU trace infrastructure to log this information. This
> will make it possible to trace the info at runtime in production
> deployments too

OK, clever.

> 
>> +static void parse_cipher_suites(QCryptoTLSCipherSuites *s,
>> +                                const char *priority_name, Error **errp)
>> +{
>> +#ifdef CONFIG_GNUTLS
> 
> Instead of doing this......
> 
> 
>> diff --git a/crypto/Makefile.objs b/crypto/Makefile.objs
>> index c2a371b0b4..ce706d322a 100644
>> --- a/crypto/Makefile.objs
>> +++ b/crypto/Makefile.objs
>> @@ -13,6 +13,7 @@ crypto-obj-y += cipher.o
>>  crypto-obj-$(CONFIG_AF_ALG) += afalg.o
>>  crypto-obj-$(CONFIG_AF_ALG) += cipher-afalg.o
>>  crypto-obj-$(CONFIG_AF_ALG) += hash-afalg.o
>> +crypto-obj-y += tls-cipher-suites.o
> 
> ....Use crypto-obj-$(CONFIG_GNUTLS) += tls-cipher-suites.o
> 
> This lets the mgmt appliction introspect QEMU to discover whether the
> TLS cipher suits object is present & usable.

OK, thanks!

> 
>>  crypto-obj-y += tlscreds.o
>>  crypto-obj-y += tlscredsanon.o
>>  crypto-obj-y += tlscredspsk.o
>> -- 
>> 2.21.3
>>
> 
> Regards,
> Daniel
> 


