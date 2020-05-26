Return-Path: <SRS0=4PQo=7I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDFAFC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 15:09:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BCBE12070A
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 15:09:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UywDgmzN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BCBE12070A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48880 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdbCn-0007Q1-VW
	for qemu-devel@archiver.kernel.org; Tue, 26 May 2020 11:09:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45274)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jdbCC-0006u4-EK
 for qemu-devel@nongnu.org; Tue, 26 May 2020 11:08:48 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:20143
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jdbCB-0000Yf-Hk
 for qemu-devel@nongnu.org; Tue, 26 May 2020 11:08:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590505726;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=uSFV0obrjlI0ld382u94SOJJ1TD+E7x5vp90pFKuygU=;
 b=UywDgmzNKUqc8+/vAtalA8fB+u4qigURGarMwv74Z2MMZug96ny5z4h5XR5C4JsWH5BmOj
 0GNveefq93CiR3+2AAMiVPzyl1/CzF315YWi42+xz7MpO7YqkOUa1D2+suz7ws+IPvYJTM
 jJ3l/TJqlS46CToVJIWwUZOpxuF+McQ=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-327-lqm5OQezOxm36hE3Rvdd8Q-1; Tue, 26 May 2020 11:08:45 -0400
X-MC-Unique: lqm5OQezOxm36hE3Rvdd8Q-1
Received: by mail-ed1-f69.google.com with SMTP id w15so8464963edi.11
 for <qemu-devel@nongnu.org>; Tue, 26 May 2020 08:08:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=uSFV0obrjlI0ld382u94SOJJ1TD+E7x5vp90pFKuygU=;
 b=fm0DqopsmEJmlbQZgvpdWBTYHvZKiwTtB2tDs+KtJG24Q0ukofcBT9/EUpPFTOIy0V
 moDGR39MBCY9X9PLYLKgD5J2cFf5ISPj6/7NrMFFrfQuPxUZ1QWiRqPtHYAgrz3teePr
 pe7ien5BUIDTcW+W1ROefCq2bslrqFp54vjWLz0uGLk7gNGgsetyx/5o0nb9I4jjZomB
 4q9mdgkk49a+urkR/0EFbV+tAkPsBJt8CuuT5iAf3hDedCvseAqKdgoAW8kp+NCy3GTa
 pymr3wPR69Kl+t3DipT3kRyCXUfGiwTT1PSfIs7/V6npU1mXOzESWIzQ5yvWwndQoKRW
 pdcw==
X-Gm-Message-State: AOAM532QnNAvoKPMMlf+fy7bcMhBAf8f8MV5QYUjhLQr6AYbQ06lYvAA
 HfmKNpRh3vtXsa3Pl2B8BYA+CoaC8vreHUu6jIMhM0nr4FdeN8/kD6qavuCRE8RsmkddHIfTUwk
 BOvn3B/FwgAvXdUw=
X-Received: by 2002:a50:ec0d:: with SMTP id g13mr20041951edr.296.1590505724192; 
 Tue, 26 May 2020 08:08:44 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzGs+XMgezkybB6MXYVL7FYv1pZ1fTz/dxBNZXFqydU/ZHU9xoZ9Ccugo+1paoLM6iocpIJtg==
X-Received: by 2002:a50:ec0d:: with SMTP id g13mr20041914edr.296.1590505723938; 
 Tue, 26 May 2020 08:08:43 -0700 (PDT)
Received: from [192.168.1.36] (71.red-88-21-204.staticip.rima-tde.net.
 [88.21.204.71])
 by smtp.gmail.com with ESMTPSA id g23sm150803edh.59.2020.05.26.08.08.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 26 May 2020 08:08:42 -0700 (PDT)
Subject: Re: [PATCH RFC 03/32] python//machine.py: remove bare except
To: John Snow <jsnow@redhat.com>, Eric Blake <eblake@redhat.com>,
 qemu-devel@nongnu.org
References: <20200514055403.18902-1-jsnow@redhat.com>
 <20200514055403.18902-4-jsnow@redhat.com>
 <9cfb85c4-70a2-efdc-fe1a-6e76d2ff3671@redhat.com>
 <211adfd7-1191-8fa3-bd7f-4fcafd6f5f90@redhat.com>
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
Message-ID: <45414404-0de5-91ea-641e-4eb3f4835cf5@redhat.com>
Date: Tue, 26 May 2020 17:08:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <211adfd7-1191-8fa3-bd7f-4fcafd6f5f90@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/26 10:22:33
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/14/20 4:26 PM, John Snow wrote:
> 
> 
> On 5/14/20 9:55 AM, Eric Blake wrote:
>> On 5/14/20 12:53 AM, John Snow wrote:
>>> Catch only the timeout error; if there are other problems, allow the
>>> stack trace to be visible.
>>>
>>
>> A lot of patches in this series start with "python//" - is that
>> intentional, or should it be a single slash?
>>
> 
> Was trying to imply an elided path structure, because
> "python/qemu/lib/qmp.py" et al is way too chatty.
> 
> Feel free to suggest better subject names!
> 

Eliding "qemu/lib/" is OK. I wouldn't not use double //, it sounds like
a recurrent typo.


