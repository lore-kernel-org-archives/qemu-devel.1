Return-Path: <SRS0=UEgn=BO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51BA0C433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Aug 2020 08:35:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 470252075D
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Aug 2020 08:35:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RZkzyaBd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 470252075D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40698 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k2sQI-0007s1-Cz
	for qemu-devel@archiver.kernel.org; Tue, 04 Aug 2020 04:35:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57756)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k2sPK-0006yh-RE
 for qemu-devel@nongnu.org; Tue, 04 Aug 2020 04:34:50 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:51025)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k2sPI-0001Ph-TL
 for qemu-devel@nongnu.org; Tue, 04 Aug 2020 04:34:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596530087;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=qD/CeeZrbqIkgE83qE1EJDNBaCSUEFE64uJULaVnxnU=;
 b=RZkzyaBdijr00rxtgew8M5LaYVAkcSlxXWxdQPUxnNFsA6wmKuK+yEImkfXzmprmbMC2Iz
 4yz1IoVbetErX1kgJ6pb0ucNdH9xLaG8Wf3Z9cYCWrMd9YTRHrQx4iMmv1CKm/Lz5o3HEk
 c111twLwRMgfLsPIZoCkwL1URe8aBWA=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-20-3CZHUtljNvyOFI2bX3zaLQ-1; Tue, 04 Aug 2020 04:34:46 -0400
X-MC-Unique: 3CZHUtljNvyOFI2bX3zaLQ-1
Received: by mail-ej1-f71.google.com with SMTP id d24so8662647ejb.3
 for <qemu-devel@nongnu.org>; Tue, 04 Aug 2020 01:34:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=qD/CeeZrbqIkgE83qE1EJDNBaCSUEFE64uJULaVnxnU=;
 b=hU2coZTm8RUc5Ssbb6RvdO2LleEzVmVsPRc5GTIlPEBH0tKX2eeBTmTu+3ReabWOwJ
 w6oTKJD46iIRzghXWjrbSuZb7SPIdpF9fYgxTBvK/idlwas3yj1GtEorpnhcaZnk6gHq
 NFo9VTVZ9KY64NnM05DfAzRHDpdmH0AIHpZPgDcdzVm6yPGwrJODv/aBPe1pLoFTDZk1
 3wIkFRUR6mFEsMXONZiThUg0wkYrAzG0SRAnuQLQnvpk3X3281lMQbK1y0EhDP9uftdG
 zvuQnfANDnXL0v6TSNGoFMf4nMuk5L0Un2Tf0sAn3SIqKnhOcRntkoc3OAqjy5OX/HXs
 4AZg==
X-Gm-Message-State: AOAM530zBQ100FdxsUqk0nolfVDsZVeVtosBYFvI4HRDu7RSsFLZ3TQd
 VvWWBOeVPUEV36bE8THGyOxTe4OSDq2bI0YutH9fcp2ia5eMqwbDYIicoYGMIhO0owV1TPqN0xx
 vWMSvXcZTaIoZ0E0=
X-Received: by 2002:a05:6402:1a54:: with SMTP id
 bf20mr19573312edb.217.1596530085185; 
 Tue, 04 Aug 2020 01:34:45 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxcPFG6nWYYGYKd1IYh4XRaBTvM1zmuSGq2bzNjsP1QuA5gXXRyHlNYGm5sTx/gM2BJ1aCXoA==
X-Received: by 2002:a05:6402:1a54:: with SMTP id
 bf20mr19573296edb.217.1596530084967; 
 Tue, 04 Aug 2020 01:34:44 -0700 (PDT)
Received: from [192.168.1.43] (214.red-88-21-68.staticip.rima-tde.net.
 [88.21.68.214])
 by smtp.gmail.com with ESMTPSA id dk28sm18329770edb.90.2020.08.04.01.34.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 04 Aug 2020 01:34:44 -0700 (PDT)
Subject: Re: [PATCH-for-5.1 v2 1/1] accel/xen: Fix xen_enabled() behavior on
 target-agnostic objects
To: paul@xen.org, qemu-devel@nongnu.org
References: <20200804074930.13104-1-philmd@redhat.com>
 <20200804074930.13104-2-philmd@redhat.com>
 <001201d66a34$e82ec070$b88c4150$@xen.org>
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
Message-ID: <56c70b44-2d5f-44fc-5d9a-535c3c5fca71@redhat.com>
Date: Tue, 4 Aug 2020 10:34:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <001201d66a34$e82ec070$b88c4150$@xen.org>
Content-Language: en-US
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/04 01:28:16
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
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
Cc: 'Peter Maydell' <peter.maydell@linaro.org>,
 'Stefano Stabellini' <sstabellini@kernel.org>,
 'Paul Durrant' <pdurrant@amazon.com>, 'Paolo Bonzini' <pbonzini@redhat.com>,
 'Anthony Perard' <anthony.perard@citrix.com>, xen-devel@lists.xenproject.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Paul,

On 8/4/20 9:57 AM, Paul Durrant wrote:
>> -----Original Message-----
>> From: Philippe Mathieu-Daudé <philmd@redhat.com>
>> Sent: 04 August 2020 08:50
>> To: qemu-devel@nongnu.org
>> Cc: Peter Maydell <peter.maydell@linaro.org>; Anthony Perard <anthony.perard@citrix.com>; Paolo
>> Bonzini <pbonzini@redhat.com>; Stefano Stabellini <sstabellini@kernel.org>; xen-
>> devel@lists.xenproject.org; Paul Durrant <paul@xen.org>; Philippe Mathieu-Daudé <philmd@redhat.com>;
>> Paul Durrant <pdurrant@amazon.com>
>> Subject: [PATCH-for-5.1 v2 1/1] accel/xen: Fix xen_enabled() behavior on target-agnostic objects
>>
>> CONFIG_XEN is generated by configure and stored in "config-target.h",
>> which is (obviously) only include for target-specific objects.
>> This is a problem for target-agnostic objects as CONFIG_XEN is never
>> defined and xen_enabled() is always inlined as 'false'.
>>
>> Fix by following the KVM schema, defining CONFIG_XEN_IS_POSSIBLE
>> when we don't know to force the call of the non-inlined function,
>> returning the xen_allowed boolean.
>>
>> Fixes: da278d58a092 ("accel: Move Xen accelerator code under accel/xen/")
>> Reported-by: Paul Durrant <pdurrant@amazon.com>
>> Suggested-by: Peter Maydell <peter.maydell@linaro.org>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
>> ---
>>  include/sysemu/xen.h   | 18 ++++++++++++++----
>>  accel/stubs/xen-stub.c |  2 ++
>>  accel/xen/xen-all.c    |  7 +------
>>  3 files changed, 17 insertions(+), 10 deletions(-)
>>
>> diff --git a/include/sysemu/xen.h b/include/sysemu/xen.h
>> index 1ca292715e..2c2c429ea8 100644
>> --- a/include/sysemu/xen.h
>> +++ b/include/sysemu/xen.h
>> @@ -8,9 +8,19 @@
>>  #ifndef SYSEMU_XEN_H
>>  #define SYSEMU_XEN_H
>>
>> -#ifdef CONFIG_XEN
>> +#ifdef NEED_CPU_H
>> +# ifdef CONFIG_XEN
>> +#  define CONFIG_XEN_IS_POSSIBLE
>> +# endif
>> +#else
>> +# define CONFIG_XEN_IS_POSSIBLE
>> +#endif
>>
>> -bool xen_enabled(void);
>> +#ifdef CONFIG_XEN_IS_POSSIBLE
>> +
>> +extern bool xen_allowed;
>> +
>> +#define xen_enabled()           (xen_allowed)
> 
> Can this not move ahead of the #ifdef now (since xen_allowed is present in both xen-stub and xen-all)? I think this is what Peter was saying in his option '(2)'.

I think I respected Peter's option '(2)', following how KVM does, this
is the case with stub,

> 
>   Paul
> 
>>
>>  #ifndef CONFIG_USER_ONLY
>>  void xen_hvm_modified_memory(ram_addr_t start, ram_addr_t length);
>> @@ -18,7 +28,7 @@ void xen_ram_alloc(ram_addr_t ram_addr, ram_addr_t size,
>>                     struct MemoryRegion *mr, Error **errp);
>>  #endif
>>
>> -#else /* !CONFIG_XEN */
>> +#else /* !CONFIG_XEN_IS_POSSIBLE */
>>
>>  #define xen_enabled() 0

    ^^^ here is the other case,

>>  #ifndef CONFIG_USER_ONLY
>> @@ -33,6 +43,6 @@ static inline void xen_ram_alloc(ram_addr_t ram_addr, ram_addr_t size,
>>  }
>>  #endif
>>
>> -#endif /* CONFIG_XEN */
>> +#endif /* CONFIG_XEN_IS_POSSIBLE */
>>
>>  #endif
>> diff --git a/accel/stubs/xen-stub.c b/accel/stubs/xen-stub.c
>> index dcca4e678a..8ae658acff 100644
>> --- a/accel/stubs/xen-stub.c
>> +++ b/accel/stubs/xen-stub.c
>> @@ -9,6 +9,8 @@
>>  #include "hw/xen/xen.h"
>>  #include "qapi/qapi-commands-misc.h"
>>
>> +bool xen_allowed;

here is the stub,

>> +
>>  void xenstore_store_pv_console_info(int i, Chardev *chr)
>>  {
>>  }
>> diff --git a/accel/xen/xen-all.c b/accel/xen/xen-all.c
>> index 0c24d4b191..60b971d0a8 100644
>> --- a/accel/xen/xen-all.c
>> +++ b/accel/xen/xen-all.c
>> @@ -32,12 +32,7 @@
>>      do { } while (0)
>>  #endif
>>
>> -static bool xen_allowed;
>> -
>> -bool xen_enabled(void)
>> -{
>> -    return xen_allowed;
>> -}
>> +bool xen_allowed;

here is the real variable.

>>
>>  xc_interface *xen_xc;
>>  xenforeignmemory_handle *xen_fmem;
>> --
>> 2.21.3
> 
> 


