Return-Path: <SRS0=6r5r=AY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2885FC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 08:39:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EBF57206F0
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 08:39:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VJrAc0VB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EBF57206F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36360 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1juu0A-0000xX-9q
	for qemu-devel@archiver.kernel.org; Mon, 13 Jul 2020 04:39:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46740)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jutzb-0000V9-0F
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 04:39:19 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:46147
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jutzZ-00007e-B5
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 04:39:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594629556;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=bstM2lWib7+HcJAqlKCT9ldB1wl4EUc74N6pkZPkaM0=;
 b=VJrAc0VB/SPZDlfPXQAGJ9CBOocMYFm1Ia/c+RDAR6FW/Z0BJqFFG02504HhcaZF0DRQTo
 CdZjV77nYOV4Hx8/AGj5b7mfpyBgghMJW/dWG3iRmc591gf4H3PVxoisHNI5NrqKRTldjn
 CkCHpHnaI690u8SDNeZ32OMTw4qTpyg=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-269-RIfBvfM7NEWTVx_P6pUpeQ-1; Mon, 13 Jul 2020 04:39:13 -0400
X-MC-Unique: RIfBvfM7NEWTVx_P6pUpeQ-1
Received: by mail-wr1-f72.google.com with SMTP id c6so16945552wru.7
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2020 01:39:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:from:to:cc:references:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=bstM2lWib7+HcJAqlKCT9ldB1wl4EUc74N6pkZPkaM0=;
 b=WbsdPKBBUA9r48lCzL4vEteN6T1Xn/FFturUrfEbcFvmdMaikYLAE3SKUn4JEDxYK7
 sLJEqPAoJ+JZBDgMx9Zteuh7Qgi+c+k5y18cOx3Nnaiz5YhWw9/i2hKwT3wQXosB6kma
 iSYAjw6tmtSBu7cjPVnWSbYT2/ulJOtq6fNCeK93kY76p+iEw9MufFTJAC4zFngdVq6E
 QwfT+B4DZwl/af2W0DNxA3Z0RVAGgD78/Q+fdckhquqZmo1mriH8uXPMGHwReJu1ZmWM
 7gEacMerpefbtw7NbtzPltyfaRmM9cM17JI0MzucaoLzrShy0Ze8x9VvgvA72V626Hdy
 sGvA==
X-Gm-Message-State: AOAM532UcF039GVsiHSBu7qXGuTwWmAa9xu++EtMkhUFDwv8iB24vRXF
 1Z57stJ2tGeit5Hu7OZKhk5OZSnrEkM4nKaQ+2rVsryYP8PwR2PikW21stE6iyc8m+KUIAtEhvs
 3jW/QmbbTfPj+hu8=
X-Received: by 2002:a1c:6788:: with SMTP id
 b130mr18574694wmc.100.1594629551983; 
 Mon, 13 Jul 2020 01:39:11 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwrGPQZ+W1yg9veTKsrI/LwnhrCAn4Y9cKMXQjmFSpXcAnwU+C2qb4OlWSccGDySDjXZS+QkQ==
X-Received: by 2002:a1c:6788:: with SMTP id
 b130mr18574665wmc.100.1594629551710; 
 Mon, 13 Jul 2020 01:39:11 -0700 (PDT)
Received: from [192.168.1.37] (138.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.138])
 by smtp.gmail.com with ESMTPSA id q7sm23938253wra.56.2020.07.13.01.39.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 13 Jul 2020 01:39:11 -0700 (PDT)
Subject: Re: Migrating custom qemu.org infrastructure to GitLab
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
To: Stefan Hajnoczi <stefanha@gmail.com>, qemu-devel <qemu-devel@nongnu.org>
References: <CAJSP0QV3uB4QY6mzw2JFDedr0PJhGkU5FdmLF5PbjMPyxiYSuw@mail.gmail.com>
 <5bf99e61-8aa2-53f0-0157-52becec1df26@redhat.com>
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
Message-ID: <019332f6-c925-fc3f-6e0e-5d02513b28dd@redhat.com>
Date: Mon, 13 Jul 2020 10:39:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <5bf99e61-8aa2-53f0-0157-52becec1df26@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/13 02:19:41
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>, Cleber Rosa <cleber@redhat.com>,
 Jeff Cody <codyprime@gmail.com>, Michael Roth <mdroth@linux.vnet.ibm.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/10/20 4:04 PM, Philippe Mathieu-Daudé wrote:
> On 7/8/20 11:52 AM, Stefan Hajnoczi wrote:
>>
>> There is a snowball effect where the experience is improved the more
>> GitLab features we use, so I hope that most of these migrations will
>> be possible.
> 
> I've been looking at other features we might be interested in.
[...]

> 7/ License Compliance
> 
> https://docs.gitlab.com/ee/user/compliance/license_compliance/

WRT IRC feedback QEMU licensing is a lost cause, I can not tell,
but I think if GitLab has scripts to take care of it, it is an
improvement over what we have now:

  a) Users will have a clearer idea of the permitted licenses

  b) New contributions will be checked for correct license by
     a machine, so reviewer can focus on other topics.

> 8/ Connecting with other bug tracking services:
> 
> In case we want to link BZ:
> https://docs.gitlab.com/ee/user/project/integrations/bugzilla.html
> 
> Or eventually launchpad:
> https://docs.gitlab.com/ee/user/project/integrations/custom_issue_tracker.html
> 
> 
> From these points I'm interested in investigating
> 
> - CI testing metrics
> - d3js graphs
> - License Compliance
> 
> Regards,
> 
> Phil.
> 


