Return-Path: <SRS0=gXk/=AL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97328C433E1
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 09:45:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 62C302067D
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 09:45:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GjtTu1uf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62C302067D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37222 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqCpQ-0008IA-LG
	for qemu-devel@archiver.kernel.org; Tue, 30 Jun 2020 05:45:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53372)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jqCop-0007pB-HU
 for qemu-devel@nongnu.org; Tue, 30 Jun 2020 05:44:47 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:27476)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jqCon-0001X9-MM
 for qemu-devel@nongnu.org; Tue, 30 Jun 2020 05:44:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593510285;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=0VPmvFF0rsGtdgYPrdi+YI+vSOyDw3Hvu853n2Lx1JM=;
 b=GjtTu1ufSwtNWsoPAafb92ZpgjLZl5LGgQ/FMLAkHx42NrRX+VVAr4voDjyOcPYVCvGHta
 XeyzTgOT9V8GCxU3EpPDdSFMHfeul21fT9l1MyXub4BYyBI/Mqw42perUu1PMO7Q4mt7Ph
 niShjdwl0MUW9aQt+q5oXBGnBLQBu9c=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-21-5-NRHyzIMY-KDbrlgBs84w-1; Tue, 30 Jun 2020 05:44:43 -0400
X-MC-Unique: 5-NRHyzIMY-KDbrlgBs84w-1
Received: by mail-ej1-f69.google.com with SMTP id l18so4749164ejn.17
 for <qemu-devel@nongnu.org>; Tue, 30 Jun 2020 02:44:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=0VPmvFF0rsGtdgYPrdi+YI+vSOyDw3Hvu853n2Lx1JM=;
 b=PKpoeGAgXH7us7IKZQHp5WlV6uX1KB/1fjMh2v6vfImZ/qUin7jojVGBhYZLkhzmgh
 j+0dLaxH/KhWrbL6G73VbkwzXDt5ZgV5vtJdEtmos0M3hk5Fy/BDsNOXUcE9fob3Sf20
 +xyKUjOOx9bL3DdY9efEI9IewFbVIJ/iMTdPZJTCi8q3Cbjmcahrpw1Uqw5RVMF/meOj
 fiUOJjNhjIEZIXdlYrxsghy+AWkG0X0MxLlORXLjqXVbWhXT4GWbawXG9hna3eorKWgE
 f80ZnUq/SSHeHwRHiKouCKlN40WN31EUeac7B5hJJvFKZBoYXAd+SunTgijo9EgvGnXS
 OQ7Q==
X-Gm-Message-State: AOAM5316dWARFB0vLUdehHvzJbSj79scHsHNIoDOswF8Um1oLoTKQKGu
 dLdrUPj3Kfj7Da0LUodPRxV9S0/yiO2tDjX7cUjKxwl0eZBI30IUY2TqVJIIsBfYOK/0SqQMiem
 uar7SBW2XMh+Ciks=
X-Received: by 2002:a50:aacc:: with SMTP id r12mr21946956edc.219.1593510282174; 
 Tue, 30 Jun 2020 02:44:42 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxb4f9yUBCfY2oe+EX6NEEDZuUzLuZhQZ7fck67kQd9RzgLrIG8SZEVs6hotHAv7nmBwplp/Q==
X-Received: by 2002:a50:aacc:: with SMTP id r12mr21946935edc.219.1593510281892; 
 Tue, 30 Jun 2020 02:44:41 -0700 (PDT)
Received: from [192.168.1.40] (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id o18sm1606443ejr.45.2020.06.30.02.44.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 Jun 2020 02:44:41 -0700 (PDT)
Subject: Re: [PATCH v4 3/7] ccid: build smartcard as module
To: Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
References: <20200622135601.12433-1-kraxel@redhat.com>
 <20200622135601.12433-4-kraxel@redhat.com>
 <434be3b8-8ed0-d27b-99c7-e682b0dc4c02@redhat.com>
 <20200623171248.pnq6otnwyvl3apky@sirius.home.kraxel.org>
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
Message-ID: <50b9426c-f34d-c3e7-8572-82c4c7d155a1@redhat.com>
Date: Tue, 30 Jun 2020 11:44:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200623171248.pnq6otnwyvl3apky@sirius.home.kraxel.org>
Content-Language: en-US
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/30 02:00:02
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: dinechin@redhat.com, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/23/20 7:12 PM, Gerd Hoffmann wrote:
>   Hi,
> 
>>> +    { .type = "ccid-card-passthru",    .mod = "usb-smartcard"         },
>>> +    { .type = "ccid-card-emulated",    .mod = "usb-smartcard"         },
>>
>> We want to use type definitions here (such TYPE_CCID_PASSTHRU),
>> as we don't guaranty them stable.
> 
> Hmm?  I'm pretty sure '-device ccid-card-passthru' *is* stable ABI.

Asking on IRC, there is no explicit contract.

But as you remarked, doing so would break the CLI, so we should
some day clarify that objects implementing TYPE_USER_CREATABLE
can not have their typename changed. For the rest, there is no
restriction.

>> Since there is a relation between QOM type and the module,
>> can we store/use the module name in the TypeInfo declaration?
>>
>>   static const TypeInfo passthru_card_info = {
>>       .name          = TYPE_CCID_PASSTHRU,
>>       .parent        = TYPE_CCID_CARD,
>>       .instance_size = sizeof(PassthruState),
>>       .class_init    = passthru_class_initfn,
>>       .module_name   = "usb-smartcard",        <=====
>>   };
> 
> That doesn't buy us much, the TypeInfo ends up in the module not qemu.
> So qemu can't access it without loading the module.
> 
> We do *not* want load all modules on startup though.  Which means we
> need a such list in qemu.  The struct above is just that.  There
> certainly is room for improvement, building that list automatically
> somehow for example.

OK.

> Given that most devices don't depend on external shared libraries I
> expect the list of device modules will stay relatively short.  So I've
> decided to start with something simple and see how it goes (see also
> patch 1/7).
> 
>> Actually this modularization is not specific to QDEV
>> and can be used to all QOM right? I.e:
>>
>>   static const TypeInfo qcrypto_tls_creds_x509_info = {
>>       .parent = TYPE_QCRYPTO_TLS_CREDS,
>>       .name = TYPE_QCRYPTO_TLS_CREDS_X509,
>>       .module_name = "gnu-tls",
>>       ...
>>   }
> 
> Not as-is.  You'll need module load hooks in more places then and some
> code tweaks to move it from qdev level (loading hw-* module only) to qom
> level.
> 
> But, yes, moving the infrastructure to some qom-module.c file might be
> useful when modularizing non-device objects.  Do you have any candidates
> in mind?

So far I was only thinking of gnutls.


