Return-Path: <SRS0=bVMU=B5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D079C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2020 03:37:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 596DE2063A
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2020 03:37:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cVLk4nDy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 596DE2063A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53770 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k8EuN-000160-Jg
	for qemu-devel@archiver.kernel.org; Tue, 18 Aug 2020 23:37:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55978)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k8Etk-0000NM-3E
 for qemu-devel@nongnu.org; Tue, 18 Aug 2020 23:36:24 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:49487
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k8Eti-0007IA-3z
 for qemu-devel@nongnu.org; Tue, 18 Aug 2020 23:36:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597808181;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=C5BimnpFX8LYjH9r2urDqVL8KV+JYtmBT0f5cG2hsQw=;
 b=cVLk4nDy2M+NpRFLLu+kRQJbIbeeRxIiPheEcwvuoSbvsxJfF6pu/VwLpgJCg1YcREuvgA
 NvAwPw3ZzIS3Jf6AG0ulkRWAg1WVOUHX+ty4UXUHV7zW+fs7ydEw/us794Mae9kkW3R0/o
 eHG4Z5CnilR5X/0MZXme0gbTxGSnBYs=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-542-NkbhWrfDOj-qjo3UVDmhbg-1; Tue, 18 Aug 2020 23:36:05 -0400
X-MC-Unique: NkbhWrfDOj-qjo3UVDmhbg-1
Received: by mail-wm1-f72.google.com with SMTP id i15so460579wmb.5
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2020 20:36:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=C5BimnpFX8LYjH9r2urDqVL8KV+JYtmBT0f5cG2hsQw=;
 b=ceCBkh0Hi4TW/gb0esOERW1MjTOml/VgyvlzrkjI01iYDA1W1YPRbbOznLFGg+tTLZ
 PZHBn0WPpOJMavQ7RjLFKiAsAWbOMo6m/yZ6joyJtGNU/bI053bR/AWfIqnQ6FywYUVx
 Fj4TX/cerqYFxD3UtGSaAthrP3X6nNf7DqhrhV8vnbODDLvB0ai1SrfRqc13qrfp0t1s
 m6/jj+P7wZuDNwxRl2UsR5aFGkflxy+qKchItfUSfqFOCFfvtAF7qiJop0KqXHL3aM7m
 Cd97eNBzZWh3pm0MRcH1DTvqcCpz++NkZgZv/KA9QzI76t/x5ZeAEyjiemV5wSuzRnWa
 wSrA==
X-Gm-Message-State: AOAM533GdR3nGsyAurJSXxlKVi4jGMC4hwrck3FuLu2fLDD3p81XnYeH
 bBspWot5sELaeoVcy029gLanNcn19KiFxlX8o9S2opEkVp2A1+/s2n9qEK2FiojzvZRjxokspjz
 BqDHiCEeWqSF/jCQ=
X-Received: by 2002:a1c:3886:: with SMTP id f128mr2703284wma.121.1597808164595; 
 Tue, 18 Aug 2020 20:36:04 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz2TN3Seco6zqBC2/G5bxX+zdchzCTaOwGHaJIdf2Lt08SUCLDhKbo7l5EcbxzReGH11AhkGA==
X-Received: by 2002:a1c:3886:: with SMTP id f128mr2703262wma.121.1597808164376; 
 Tue, 18 Aug 2020 20:36:04 -0700 (PDT)
Received: from [192.168.1.36] (121.red-81-40-121.staticip.rima-tde.net.
 [81.40.121.121])
 by smtp.gmail.com with ESMTPSA id t189sm2996908wmf.47.2020.08.18.20.36.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 18 Aug 2020 20:36:03 -0700 (PDT)
Subject: Re: [EXTERNAL] Re: [PATCH v2 0/3] testing: Build WHPX enabled binaries
To: Sunil Muthuswamy <sunilmut@microsoft.com>, Stefan Weil <sw@weilnetz.de>,
 Thomas Huth <thuth@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, Mike Battista <Mike.Battista@microsoft.com>
References: <20190920113329.16787-1-philmd@redhat.com>
 <01f2f0ee-a288-921a-58f4-78aeb4d457e1@redhat.com>
 <BYAPR21MB1208F0D09B3E5CA80F1B7C3BB6880@BYAPR21MB1208.namprd21.prod.outlook.com>
 <2acf854f-c49a-0811-31af-80e1e958f058@redhat.com>
 <324f5002-be0a-563e-b5a6-e08ee5e1ddad@redhat.com>
 <SN4PR2101MB0880AF5A5D752F06DB94A15FC04E0@SN4PR2101MB0880.namprd21.prod.outlook.com>
 <b8afd626-b6ae-d6fa-c8b7-5e5778574c07@redhat.com>
 <82fa39b2-676c-e8c5-72c6-53123983dcda@weilnetz.de>
 <55002560-9741-1e71-85f9-e75d9f0f3bfc@weilnetz.de>
 <fde8dd22-679a-be5e-b36e-d8aeb7e955cc@redhat.com>
 <58f5c48c-cf85-ae2a-ce28-510520c2ae75@weilnetz.de>
 <1eae7ba1-47a2-29f3-9425-aa9d8f617106@redhat.com>
 <7cdc7066-0477-5f8b-9d22-12de97098cfc@weilnetz.de>
 <SN4PR2101MB088024FA6D6D3C89998C9BB5C05C0@SN4PR2101MB0880.namprd21.prod.outlook.com>
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
Message-ID: <d332bb97-8008-a11a-a068-630b8516b678@redhat.com>
Date: Wed, 19 Aug 2020 05:36:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <SN4PR2101MB088024FA6D6D3C89998C9BB5C05C0@SN4PR2101MB0880.namprd21.prod.outlook.com>
Content-Language: en-US
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/18 23:05:17
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
 =?UTF-8?Q?Daniel_P_=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "1879672@bugs.launchpad.net" <1879672@bugs.launchpad.net>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/18/20 11:20 PM, Sunil Muthuswamy wrote:
>>>> It's still shameful that MS is forcing developers to waste time
>>>> rewriting API headers, just because the MS legal departments are not
>>>> able to understand the needs of Open Source development.
>>> There has be a big switch from Microsoft toward Open Source, I attended
>>> some of there talk at the Open Source Summit in 2018. Maybe we simply
>>> haven't contacted the right persons to make the changes...?
>>
>>
>> Maybe, but it is difficult to find the right person in a large company
>> like MS, and legal departments are often somehow special.
>>
>> And yes, they learned that Open Source can help them for their business,
>> too.
>>
>> Stefan
> 
> Mike Battista is the program manager owner of the SDK license and should be
> able to take/respond to any feedback about the SDK licensing for open source
> projects (I have added him here). He has also been added to previous threads
> about the licensing and is also included in this conversation:
> https://bugs.launchpad.net/qemu/+bug/1879672

Hi Mike, thanks for helping us with this issue!

And thanks a lot Sunil to bring Mike here :)

> 
> - Sunil
>  
> 


