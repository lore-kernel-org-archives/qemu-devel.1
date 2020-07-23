Return-Path: <SRS0=cpkI=BC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ED14C433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 10:27:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4654C206C1
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 10:27:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hOC20v1N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4654C206C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45762 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyYS0-0007JC-Gs
	for qemu-devel@archiver.kernel.org; Thu, 23 Jul 2020 06:27:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41188)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jyYRN-0006sR-Ao
 for qemu-devel@nongnu.org; Thu, 23 Jul 2020 06:27:05 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:46901
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jyYRL-00041P-FC
 for qemu-devel@nongnu.org; Thu, 23 Jul 2020 06:27:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595500022;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=eQNpsINiFu+CfkE6BJ0mJfS2hYIj1bPWPnFWeYy9Eaw=;
 b=hOC20v1NxG/V6oiKiMIFnBYXUEhSEdWNsy/V0yqG81IVtts1WdxvC6cgzDxnab3wvc2ScX
 WXvnyhBWMLwOHY11ESmJfOq6j0HS2JMH8gSy5S7Z2RVvjlQ26toS6WQtagMvYTzp2Ols/R
 2pZ2vp2iIq1ihNHrtO64jgb0JInwsXY=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-102-U8226WVEMpK_xdG0TQX1Tg-1; Thu, 23 Jul 2020 06:27:00 -0400
X-MC-Unique: U8226WVEMpK_xdG0TQX1Tg-1
Received: by mail-wm1-f72.google.com with SMTP id t26so1752448wmn.4
 for <qemu-devel@nongnu.org>; Thu, 23 Jul 2020 03:27:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=eQNpsINiFu+CfkE6BJ0mJfS2hYIj1bPWPnFWeYy9Eaw=;
 b=OcE5hQAhmv+PzqVFKeME5tXD3gP++hKPGmpJ4QgW8EjILjcIDLDHFYEQPzJcB7hcDL
 dQRbVQSDUzRyKMcZbxHmnxIw0i3GwZGJvkllPfv8D8bRY0AyhhAlujRhQtDlhyGLEME4
 TN/8PuHPWZDJZCA7WhJNlg0AEb8bZXMBicFQECZCHqVVexy4iHhRQWOfCWAf1CN2xqfL
 utsIwhOXgOUA6dnqY/Rs7ckhHHZ/7g0WtIxbLp2X/b/4H2XxKJqLpMWHHR10BJwoyxuD
 Lnm8b85sZgNMCyP0OgibLb13wmap5qRSzAxepzqtDFucVDsIKBJB45yaWzyiSTWGEcHy
 0Zjw==
X-Gm-Message-State: AOAM53351JLioh8lswmg/MINAMCNSSTr8rAJwFPnhRd7o5lpZND8YlpZ
 Hd5JF5q4t87ztW4I8vcmdWH0gVMIKMpYZEyryDn5QDNnWYnSj3NJAKiSt5wJg1g9/RWXLsVeATC
 68EEFbZhlWramma4=
X-Received: by 2002:adf:fc06:: with SMTP id i6mr3407404wrr.79.1595500019063;
 Thu, 23 Jul 2020 03:26:59 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyut7HfoiD+aa231x1uWl/Da9rgjCsNGVGoYx/J5uje/PjNFevAfjnxoZ75il+SvOHY3B7Dhw==
X-Received: by 2002:adf:fc06:: with SMTP id i6mr3407385wrr.79.1595500018841;
 Thu, 23 Jul 2020 03:26:58 -0700 (PDT)
Received: from [192.168.1.36] (138.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.138])
 by smtp.gmail.com with ESMTPSA id c24sm3323425wrb.11.2020.07.23.03.26.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 23 Jul 2020 03:26:58 -0700 (PDT)
Subject: Re: please try to avoid sending pullreqs late on release-candidate day
To: Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
References: <CAFEAcA9+9ZQY2CxZ9V4bZrkAGR5eUapbwSk6sNyFGyyd39Y=1Q@mail.gmail.com>
 <20200722093621.GA4838@linux.fritz.box> <87r1t3u4me.fsf@linaro.org>
 <87o8o6pwwm.fsf@dusky.pond.sub.org>
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
Message-ID: <16f1e661-edaa-2ee2-008d-3c9ad0e5e10d@redhat.com>
Date: Thu, 23 Jul 2020 12:26:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <87o8o6pwwm.fsf@dusky.pond.sub.org>
Content-Language: en-US
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/23 06:04:25
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Jason Wang <jasowang@redhat.com>, qemu-devel@nongnu.org,
 Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/23/20 8:28 AM, Markus Armbruster wrote:
> Alex Bennée <alex.bennee@linaro.org> writes:
> 
>> Kevin Wolf <kwolf@redhat.com> writes:
>>
>>> Am 21.07.2020 um 17:56 hat Peter Maydell geschrieben:
>>>> It is not helpful if everybody sends their pullrequests late
>>>> on the Tuesday afternoon, as there just isn't enough time in the
>>>> day to merge test and apply them all before I have to cut the tag.
>>>> Please, if you can, try to send pullrequests earlier, eg Monday.
>>>
>> <snip>
>>>
>>> So given that we _will_ have some late patches, what can we do to
>>> improve the situation?
>>>
>>> Maybe I could send the pull request before testing it to save some time.
>>> Your tests will take a while anyway, so if my own testing fails (e.g.
>>> for the parts of iotests that you don't test), I would still have time
>>> to NACK my own pull request. This wouldn't buy us more than an hour at
>>> most and could lead to wasted testing effort on your side (which is
>>> exactly the resource we want to save).
>>>
>>> Can you test multiple pull requests at once? The Tuesday ones tend to be
>>> small (between 1 and 3 patches was what I saw yesterday), so they should
>>> be much less likely to fail than large pull requests. If you test two
>>> pull requests together and it fails so you have to retest one of them in
>>> isolation, you still haven't really lost time compared to testing both
>>> individually. And if it succeeds, you cut the testing time in half.
>>
>> I've taken to just stacking up patches from my multiple trees to avoid
>> sending more than one PR a week. Of course sometimes the stack grows a
>> bit too tall and becomes unwieldy :-/
> 
> You're right, stacking unrelated smaller pull requests makes sense when
> pulling all the pull requests in flight races with a deadline.

I tend to disagree, since few patches from the "candidate fixes for
5.1-rc1" series are still being discussed, and we are past rc1. Half
of them could have been merged in for rc1.


