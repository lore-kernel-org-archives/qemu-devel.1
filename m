Return-Path: <SRS0=+uBF=DN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CCF9C4363D
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Oct 2020 11:34:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F8DB207EA
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Oct 2020 11:34:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BfSxnoNG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F8DB207EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58554 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPlF5-0001AQ-KJ
	for qemu-devel@archiver.kernel.org; Tue, 06 Oct 2020 07:34:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38632)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kPlAW-0005AJ-LL
 for qemu-devel@nongnu.org; Tue, 06 Oct 2020 07:30:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:24504)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kPlAT-0007Zs-5x
 for qemu-devel@nongnu.org; Tue, 06 Oct 2020 07:30:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601983804;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=BmvMbYmaEUDxrE/v7K3YoGkp+1T4rULeFuecKUlOtw8=;
 b=BfSxnoNGYKe4KNmS3FYePMoMXvo+rU0Q1bTl6Hu/9Y/dl0T/1s0cvvT/FmC31tOecepUan
 zz6LpnGP/zYPLZCseYQlpbW3UWyb91HPWHTl8b/bbm9wO5Q0pqhwZgLrD2XynCT45OhuTt
 nG+Xq/iDblrm/gM3d/Sq8ucU2+1SIy0=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-444-wAFKwh7iPIe_eRF4-hWxFw-1; Tue, 06 Oct 2020 07:30:02 -0400
X-MC-Unique: wAFKwh7iPIe_eRF4-hWxFw-1
Received: by mail-wr1-f69.google.com with SMTP id g6so5252021wrv.3
 for <qemu-devel@nongnu.org>; Tue, 06 Oct 2020 04:30:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=BmvMbYmaEUDxrE/v7K3YoGkp+1T4rULeFuecKUlOtw8=;
 b=Uii2/Ue7mSPoa7fo3orc+mXM0bzbxX8jVaEzGrHJj6Ma9R0Dkv6/qo3VlO/VhdS3ZO
 tYgqBsrSbYAHJnROWjJxQGy4DFbmTKjLWaZud+yWwxQ3qvB7Ucwe1KQbV8eDaKlqKQvs
 adcdATDVqqInEM4D+bGZTIIxhnXZuVn0LGXAkIUuOD0570ItN2MciaU0JLOxe3R3cHYf
 v2r+4UgC7KNO9A+CdVXGcuwSmxUvGuhyDIV0V6bVdx+Yw1XzHvEfRCsV0aaVl+KEDquM
 tFWbU+BTd+NQQ/q6XnGQVeUjPK4ygiRIvZGt57xomzcHhvgkbhZZa0iLY9AAtGSdx87s
 ba+g==
X-Gm-Message-State: AOAM533v6U7NlCeOg/fempu+mQ6myrUPBm3WorsrJIHgGpHIlaEmBu8b
 /69SLQIaUaMprcXF1Ymf6XzTMows4MkpuFjmuYtdoVhEfFE7ClAGg9DESVJiaUaN1ITihpjWwBq
 ZHj8hdHDQ1lLfrCk=
X-Received: by 2002:adf:a4cc:: with SMTP id h12mr4333228wrb.123.1601983800947; 
 Tue, 06 Oct 2020 04:30:00 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwVf2qht1sO8V6zCY7YGvLXvO+XoRdRb7BqU9KGmUo9lyb/8sqik/rImXtZxRd+EqaTtX1klQ==
X-Received: by 2002:adf:a4cc:: with SMTP id h12mr4333212wrb.123.1601983800743; 
 Tue, 06 Oct 2020 04:30:00 -0700 (PDT)
Received: from [192.168.1.36] (106.red-83-59-162.dynamicip.rima-tde.net.
 [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id d9sm3340648wmb.30.2020.10.06.04.29.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 06 Oct 2020 04:30:00 -0700 (PDT)
Subject: Re: [PATCH 06/10] migration: Move the creation of the library to the
 main meson.build
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20201006111219.2300921-1-philmd@redhat.com>
 <20201006111219.2300921-7-philmd@redhat.com>
 <7b4e8c2a-652c-6a07-8591-852738290f37@redhat.com>
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
Message-ID: <c37b97e4-c0cf-e044-bdcc-3d0994704b1b@redhat.com>
Date: Tue, 6 Oct 2020 13:29:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <7b4e8c2a-652c-6a07-8591-852738290f37@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/06 01:55:55
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.733,
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
Cc: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Juan Quintela <quintela@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/6/20 1:25 PM, Paolo Bonzini wrote:
> On 06/10/20 13:12, Philippe Mathieu-Daudé wrote:
>> Be consistent creating all the libraries in the main meson.build file.
>>
>> Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
>> ---
>>  meson.build           | 6 ++++++
>>  migration/meson.build | 6 ------
>>  2 files changed, 6 insertions(+), 6 deletions(-)
>>
>> diff --git a/meson.build b/meson.build
>> index 6bec7a0994..55966c3b60 100644
>> --- a/meson.build
>> +++ b/meson.build
>> @@ -1328,6 +1328,12 @@ qemu_syms = custom_target('qemu.syms', output: 'qemu.syms',
>>  # Library dependencies #
>>  ########################
>>  
>> +libmigration = static_library('migration', sources: migration_files + genh,
>> +                              name_suffix: 'fa',
>> +                              build_by_default: false)
>> +migration = declare_dependency(link_with: libmigration,
>> +                               dependencies: [zlib, qom, io])
>> +
>>  block_ss = block_ss.apply(config_host, strict: false)
>>  libblock = static_library('block', block_ss.sources() + genh,
>>                            dependencies: block_ss.dependencies(),
>> diff --git a/migration/meson.build b/migration/meson.build
>> index 55c9e1329f..980e37865c 100644
>> --- a/migration/meson.build
>> +++ b/migration/meson.build
>> @@ -8,12 +8,6 @@ migration_files = files(
>>    'qemu-file.c',
>>    'qjson.c',
>>  )
>> -
>> -libmigration = static_library('migration', sources: migration_files + genh,
>> -                              name_suffix: 'fa',
>> -                              build_by_default: false)
>> -migration = declare_dependency(link_with: libmigration,
>> -                               dependencies: [zlib, qom, io])
>>  softmmu_ss.add(migration_files)
>>  
>>  softmmu_ss.add(files(
>>
> 
> You can move add softmmu_ss.add(migration) to the toplevel meson.build
> too, together with the other dependencies.

Ah OK now I understand slightly better.

> 
> Paolo
> 


