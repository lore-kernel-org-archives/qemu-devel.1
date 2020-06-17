Return-Path: <SRS0=bzpH=76=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C373C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 03:34:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5717620663
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 03:34:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YMtveokG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5717620663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46252 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlOqV-0005Yy-M6
	for qemu-devel@archiver.kernel.org; Tue, 16 Jun 2020 23:34:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54304)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jlOpU-0004mH-SI
 for qemu-devel@nongnu.org; Tue, 16 Jun 2020 23:33:38 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:35969
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jlOpT-0008Qg-0W
 for qemu-devel@nongnu.org; Tue, 16 Jun 2020 23:33:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592364813;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=5tJ9gI4kIUt6W+wnAYQfRijM4AqdJkpPzqDJSWuYP/4=;
 b=YMtveokG5nadedegIMoawoi2GVVckYSHOxae3ArEFEUCNgZ9woaut/XKl4ecrNreVuFyM/
 nIZDUQ9Y+eBXcgtOd9pGe1g1dsvegmd/dYn1SxtgVXX2F4W0sGV5vP0sVLTHT1rZlXK0jH
 RjlaFCr3TBukEQ7qMgvuhaGSQaR2Xpw=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-202-rCAaN9wDNEybNFgiac_-fA-1; Tue, 16 Jun 2020 23:33:28 -0400
X-MC-Unique: rCAaN9wDNEybNFgiac_-fA-1
Received: by mail-wr1-f70.google.com with SMTP id s7so368972wrm.16
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2020 20:33:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=5tJ9gI4kIUt6W+wnAYQfRijM4AqdJkpPzqDJSWuYP/4=;
 b=RK5GF5G5jUGrInpcOtuhiZcjxyWBJISIgvINOu4ULHX9vZRrXaAuKmccZD3UEr1v9O
 1xGEtGwIiAPrVwOMW45gjMWsukd9nBHbXRWzeBk1K226k4R2+DSc9tAjyA2GKd4gSxYk
 di/+3J7gSC01J7mzwiFuUKLuP5Kk0DlTNZ9EZMVy4DNujXVw3oTtgLdyA1lgDNr34oY0
 xSIn/MmEyospdDcwpzsIYGbGd7561FyM6HVliH5Jmmg8xAbyaxBe2tA0RX01sdTlJVCo
 yYstBABttc1RdcHTuaPJDom53SAEPf0xkj/m6lgFGmCIfYCoZqXIP3ExZYcD03hs8j8q
 5f1Q==
X-Gm-Message-State: AOAM531kgn37r7n1V8P0/JgyfeqOEwseuCO4x2MqTLPz6y1dAHqZhVpZ
 MlBr3TMwU6cVqC6Qa/kSKTNQoi4v1b00293bqAs7LM7NduVQz2WQg19/M3aBRiMq4aa3UZ4aFMl
 tn2mbp2iHbgUMEkQ=
X-Received: by 2002:adf:f790:: with SMTP id q16mr6202556wrp.399.1592364807480; 
 Tue, 16 Jun 2020 20:33:27 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxk16srYtnxhzQOQZP+oMUelp3MPYIwBvxdUiQZurPygYB/tP2e7Xs7kfkDlPJDW465i/BSCQ==
X-Received: by 2002:adf:f790:: with SMTP id q16mr6202535wrp.399.1592364807223; 
 Tue, 16 Jun 2020 20:33:27 -0700 (PDT)
Received: from [192.168.1.37] (93.red-83-59-160.dynamicip.rima-tde.net.
 [83.59.160.93])
 by smtp.gmail.com with ESMTPSA id h15sm29865466wrt.73.2020.06.16.20.33.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 16 Jun 2020 20:33:26 -0700 (PDT)
Subject: Re: applying mailing list review tags (was: Re: [PATCH v3 00/16]
 python: add mypy support to python/qemu)
To: John Snow <jsnow@redhat.com>, Markus Armbruster <armbru@redhat.com>
References: <20200604202236.25039-1-jsnow@redhat.com>
 <20200605092630.GE5869@linux.fritz.box>
 <502e4f4d-6770-61a7-1496-9cb244f9ddd3@redhat.com>
 <20200608153327.GD6419@linux.fritz.box>
 <130e4383-8c33-c3f2-55b2-1ec45a5214cc@redhat.com>
 <87wo4gr4yb.fsf@dusky.pond.sub.org>
 <4ee8f32a-192d-b154-f3cc-c41e7ff56c58@redhat.com>
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
Message-ID: <82753499-3459-e6af-6cda-501ce56dfce6@redhat.com>
Date: Wed, 17 Jun 2020 05:33:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <4ee8f32a-192d-b154-f3cc-c41e7ff56c58@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/16 23:33:33
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
Cc: Kevin Wolf <kwolf@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/16/20 7:58 PM, John Snow wrote:
> 
> 
> On 6/9/20 4:58 AM, Markus Armbruster wrote:
>> Philippe Mathieu-Daudé <philmd@redhat.com> writes:
>>
>>> On 6/8/20 5:33 PM, Kevin Wolf wrote:
>>>> Am 08.06.2020 um 17:19 hat John Snow geschrieben:
>>>>>
>>>>>
>>>>> On 6/5/20 5:26 AM, Kevin Wolf wrote:
>>>>>> Am 04.06.2020 um 22:22 hat John Snow geschrieben:
>>>>>>> Based-on: 20200604195252.20739-1-jsnow@redhat.com
>>>>>>>
>>>>>>> This series is extracted from my larger series that attempted to bundle
>>>>>>> our python module as an installable module. These fixes don't require that,
>>>>>>> so they are being sent first as I think there's less up for debate in here.
>>>>>>>
>>>>>>> This requires my "refactor shutdown" patch as a pre-requisite.
>>>>>>
>>>>>> You didn't like my previous R-b? Here's a new one. :-)
>>>>>>
>>>>>> Reviewed-by: Kevin Wolf <kwolf@redhat.com>
>>>>>>
>>>>>
>>>>> I felt like I should address the feedback, and though I could have
>>>>> applied the R-B to patches I didn't change, it was ... faster to just
>>>>> re-send it.
>>>>>
>>>>> Serious question: How do you apply people's R-Bs to your patches? At the
>>>>> moment, it's pretty manually intensive for me. I use stgit and I pop all
>>>>> of the patches off (stg pop -n 100), and then one-at-a-time I `stg push;
>>>>> stg edit` and copy-paste the R-B into it.
>>>
>>> wget https://patchew.org/QEMU/${MSG_ID}/mbox
>>> git am mbox
>>>
>>> Where ${MSG_ID} is the Message-Id of the series cover letter.
>>
>> Patchew's awesomeness is still under-appreciated.
>>
> 
> Not for lack of appreciating patchew, but the problem with this workflow
> is if I have already made modifications to my patches locally, I can't
> use this to apply tags from upstream.

Does that mean you want to respin this series?
Else you can consider it applied on python-next.

> 
> It looks like I will continue to do this manually for the time being;
> but scripting the ability to "merge tags" from the list would be a cool
> trick.
> 
> I'm not sure how to do it with git, though. Let's say I've got 16
> patches and I've made modifications to some, but not all; so I have a
> branch with 16 patches ahead of origin/master.
> 
> Does anyone have any cool tricks for being able to script:
> 
> 1. Correlating a mailing list patch from e.g. patchew to a commit in my
> history, even if it's changed a little bit?
> 
> (git-backport-diff uses patch names, that might be sufficient... Could
> use that as a starting point, at least.)
> 
> 2. Obtaining the commit message of that patch?
> `git show -s --format=%B $SHA` ought to do it...
> 
> 3. Editing that commit message? This I'm not sure about. I'd need to
> understand the tags on the upstream and downstream versions, merge them,
> and then re-write the message. Some magic with `git rebase -i` ?
> 
> --js
> 


