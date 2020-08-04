Return-Path: <SRS0=UEgn=BO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8931AC433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Aug 2020 07:24:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7AAFC2076C
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Aug 2020 07:24:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VO/DzvqG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7AAFC2076C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55512 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k2rIx-0008Vj-JR
	for qemu-devel@archiver.kernel.org; Tue, 04 Aug 2020 03:24:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39304)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k2rI6-00084e-CL
 for qemu-devel@nongnu.org; Tue, 04 Aug 2020 03:23:18 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:58174
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k2rI4-0000Pl-4c
 for qemu-devel@nongnu.org; Tue, 04 Aug 2020 03:23:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596525795;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=oWY9IEKdnxeNZK/kdBY6+UmS4a08thM6QSDe7mfEB4E=;
 b=VO/DzvqGTirl96gyY+NIGEC5VjkMeE4tRHc35eSO/uYGjLU/xkssc94tlyp2IWQOmtKhV7
 dKrE6+qZwPPYT+wfHvxuPDgZjvmQ4G9nBoZYOnq96ES62w6Lbh2t49ikQQ5BNcVNlxsKUa
 F4EPXJUb7gb+fmkOgz577F3m6b68xbk=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-42-tCRhB4DYMRihwXSKqCNy7Q-1; Tue, 04 Aug 2020 03:23:12 -0400
X-MC-Unique: tCRhB4DYMRihwXSKqCNy7Q-1
Received: by mail-wm1-f71.google.com with SMTP id a207so733271wme.9
 for <qemu-devel@nongnu.org>; Tue, 04 Aug 2020 00:23:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=oWY9IEKdnxeNZK/kdBY6+UmS4a08thM6QSDe7mfEB4E=;
 b=lQS7GuPDCNuONivZ4cFgNR9MGnqaXweh48sjroRZGVPgX8XzOaasA8sfRXBNPKHqrv
 RrQti4pVKkXHVumC1Ini2Wh/Bz5eStciTufnMdCWv8z5xC959VOkMNcvcn4PzoBF0B2y
 sCjrrBFDwdWbJARxty2o3Go+xdvyb7XvXZ2URLkfBQ09foAlupvgW+2346G+yNlbYK3R
 HUNiRaqbcMlhG+gVkUgYDwOgkvTnYvAfNRyAip01dsAQCBWxhW07GL217SauhDIwJbTY
 k8OG87B0d8GdS2SnRcHY3QnMxwQzJKIALPptnBPxX7t83LjQ6i9KfcDzKLG4B/JjrXTV
 wpjQ==
X-Gm-Message-State: AOAM533mMqeA6YdlKuTesL5mKEehYMMxwkuVn9ZHoqFGOBrZw8u78Evd
 k1CDRRnCXMn59KGjsAtBorcxL44DzAFaJbyHPQ/NBDyZ6yhIj6qlkpXESW5g8humKWVuACLP0PV
 iJs0jt9v/a4l0ajU=
X-Received: by 2002:a1c:32c3:: with SMTP id y186mr2663171wmy.15.1596525791343; 
 Tue, 04 Aug 2020 00:23:11 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwFBtnV3pKa3jBwNUgH6wcXlIiSFQ9vEcIYMNnNYoE30s8yBl/QfZn5FOMQZ5kebeFrLLWhLQ==
X-Received: by 2002:a1c:32c3:: with SMTP id y186mr2663148wmy.15.1596525791105; 
 Tue, 04 Aug 2020 00:23:11 -0700 (PDT)
Received: from [192.168.1.43] (214.red-88-21-68.staticip.rima-tde.net.
 [88.21.68.214])
 by smtp.gmail.com with ESMTPSA id d7sm23812745wra.29.2020.08.04.00.23.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 04 Aug 2020 00:23:10 -0700 (PDT)
Subject: Re: [PATCH v2 0/3] testing: Build WHPX enabled binaries
To: Stefan Weil <sw@weilnetz.de>, Thomas Huth <thuth@redhat.com>,
 Sunil Muthuswamy <sunilmut@microsoft.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
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
Message-ID: <1eae7ba1-47a2-29f3-9425-aa9d8f617106@redhat.com>
Date: Tue, 4 Aug 2020 09:23:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <58f5c48c-cf85-ae2a-ce28-510520c2ae75@weilnetz.de>
Content-Language: en-US
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
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
Cc: Fam Zheng <fam@euphon.net>, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Daniel_P_=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "1879672@bugs.launchpad.net" <1879672@bugs.launchpad.net>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/4/20 8:55 AM, Stefan Weil wrote:
> Am 04.08.20 um 08:43 schrieb Thomas Huth:
> 
>> On 03/08/2020 22.25, Stefan Weil wrote:
>>> We can add a CI pipeline on Microsoft infrastructure by using a GitHub
>>> action.
>> Sorry for being ignorant, but how does that solve the legal questions
>> just because it is running on GitHub instead of a different CI?
>>
>>  Thomas
>>
> 
> Sorry, I though that would be clear by looking at the included shell script.
> 
> The build does not use the Microsoft SDK. It gets the required header
> files from Mingw-w64. They added them in git master.

Oh, so we can do that with GitLab too now, we don't need to rely on the
GitHub 'Actions' CI in particular, right?

> 
> See
> https://github.com/stweil/qemu/blob/master/.github/workflows/build.sh#L50
> for code details.
> 
> It's still shameful that MS is forcing developers to waste time
> rewriting API headers, just because the MS legal departments are not
> able to understand the needs of Open Source development.

There has be a big switch from Microsoft toward Open Source, I attended
some of there talk at the Open Source Summit in 2018. Maybe we simply
haven't contacted the right persons to make the changes...?

> 
> Stefan
> 
> 
> 


