Return-Path: <SRS0=TEh4=AD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C159C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 18:29:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CC6F820732
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 18:29:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UNYn/TEb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC6F820732
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60534 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnRC4-0002ZN-4J
	for qemu-devel@archiver.kernel.org; Mon, 22 Jun 2020 14:29:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42070)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jnRBP-00027J-7q
 for qemu-devel@nongnu.org; Mon, 22 Jun 2020 14:28:39 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:22479
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jnRBM-0007Ho-G0
 for qemu-devel@nongnu.org; Mon, 22 Jun 2020 14:28:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592850515;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=/W1mTUNP3qoqVp1362mvm8n7xl5PxEr0hqt2NVEfXGY=;
 b=UNYn/TEbVHLkM9aWWrpbx8tlOSYOt99zaZYCuR55Q8xY5KFdg38i8LR+KtfSNt70Aqo9Y9
 BwMZzxQmeq9AonUR6ELY8dBMs/aecfljVAkquy1ZHgfR3iXinsvB3GBFItuP/iwn+fDZKE
 rugo1bQP+/NJ30EZSuE0IPz/fBy/hV4=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-409-rceg_UsCOEOgV08M-BZAoA-1; Mon, 22 Jun 2020 14:28:23 -0400
X-MC-Unique: rceg_UsCOEOgV08M-BZAoA-1
Received: by mail-wr1-f72.google.com with SMTP id p9so11415050wrx.10
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2020 11:28:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=/W1mTUNP3qoqVp1362mvm8n7xl5PxEr0hqt2NVEfXGY=;
 b=hD+BLxDv2an1Ory8jrDJ4ITHh9MjNYgD9+JOEopn4YroUkLdev/t9DYZf+oGjA7HVD
 cjZq87atBipUwniItSP3TeCCTSWNJfwPwLhfRUqKNBqZarH96uNL+GeSH1+odBdbs3r5
 /IkresphvfJWePmiSNACr46uS4GOTB9KDYDDYLbKdEErK0pG6kVcvLoNinPYpXMxJVQ8
 DdxLwHb6kgQ7B46Fuv4NQJg9Ih0vywMWXUfKQyM4sZE+wDwmLOe4FSaH+AU3db9IYX4n
 LjDzzpLMr3jOqP30s4x1LgFqQg44RZgW/TX8INJer5Pg3DTvWluFiZi/XUlBlufBuAWA
 PgKw==
X-Gm-Message-State: AOAM530r9OXWrePAQ5fqma43UwhUZ2RmxneRT4w6xUc360BhKAiUSgK2
 jHhjD19fFDr+neOKfLETuVSZrNjr8OfJ6+Z3j2AYesXfORsDeAHeS7qVHaoSqGB56NBYQs9lmgD
 //00dlnva9gH8v9E=
X-Received: by 2002:a1c:4302:: with SMTP id q2mr19744540wma.54.1592850502516; 
 Mon, 22 Jun 2020 11:28:22 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwvd5CXzwr4E8kW93UOb7SJfH5bCb+W9y3kTVRpSu69o4xqQy6NhgyJDyz8eDlv64fttJV2ng==
X-Received: by 2002:a1c:4302:: with SMTP id q2mr19744515wma.54.1592850502314; 
 Mon, 22 Jun 2020 11:28:22 -0700 (PDT)
Received: from [192.168.1.40] (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id x205sm481868wmx.21.2020.06.22.11.28.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 22 Jun 2020 11:28:21 -0700 (PDT)
Subject: Re: [PATCH v3 0/3] python/machine.py: refactor shutdown
To: John Snow <jsnow@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
References: <20200604195252.20739-1-jsnow@redhat.com>
 <8bd27ec8-1bb6-45e2-a43a-7e0229065414@redhat.com>
 <4012de28-5837-889a-eda1-b9957cbbbad1@redhat.com>
 <5d20012b-923c-0bf4-232d-272977087fe3@redhat.com>
 <20200616214900.GA347659@localhost.localdomain>
 <fd9c8f22-77fe-9689-9445-416fad9ff0fa@redhat.com>
 <19227083-5e99-e08f-4a6d-8d2edcdeacf8@redhat.com>
 <536b1d29-f3e0-4c28-e294-3cd83885323e@redhat.com>
 <7c989539-8b81-89db-5d29-0e66c83b1201@redhat.com>
 <b6adbb99-e166-1c79-7282-cd9c713c6731@redhat.com>
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
Message-ID: <494f45f1-0379-04a3-39e4-f89bad42c4de@redhat.com>
Date: Mon, 22 Jun 2020 20:28:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <b6adbb99-e166-1c79-7282-cd9c713c6731@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/22 02:57:26
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: kwolf@redhat.com, Markus Armbruster <armbru@redhat.com>,
 qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

+Alex

On 6/22/20 8:08 PM, John Snow wrote:
> On 6/22/20 1:55 PM, Philippe Mathieu-Daudé wrote:
>> On 6/22/20 7:51 PM, John Snow wrote:
>>>
>>>
>>> On 6/20/20 6:14 AM, Philippe Mathieu-Daudé wrote:
>>>> Still doesn't work...
>>>> https://travis-ci.org/github/philmd/qemu/jobs/700309163#L5445
>>>
>>> I tried running from master with just these patches applied. So far, the
>>> only failures I am seeing on gitlab/travis are job timeouts.
>>>
>>> Are you doing something special to avoid timeout failures?
>>
>> Unfortunately no :S Cleber tried too and couldn't reproduce,
>> I'm the only one lucky enough to win the race condition...
>>
>> Retrying the acceptance tests on Travis-CI is painful, yes,
>> I know...
>>
> 
> You didn't address the timeouts I asked about. Are you not seeing job
> timeouts? How is the CI passing at all, for anyone?
> 
> We seem to have bigger problems here.

OK, your problem/question was not obvious.

What helped me to is to know you setup'd your Travis-CI
account today.
At some point the jobs were taking too long, by caching
the ccache directory between runs, we could get quicker
builds.

My guess is as your setup is new, your cache is empty,
and you are reaching the 50min timeout...

If this is the case, I'm not sure how to resolve this.
Retry and retry again?


