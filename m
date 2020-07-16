Return-Path: <SRS0=z35Y=A3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42245C433E2
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2020 13:44:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1038E207DD
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2020 13:44:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HR/YeSw1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1038E207DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33762 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jw4BF-0006cZ-AD
	for qemu-devel@archiver.kernel.org; Thu, 16 Jul 2020 09:44:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59684)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jw4AU-0005bd-G1
 for qemu-devel@nongnu.org; Thu, 16 Jul 2020 09:43:22 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:26633
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jw4AS-0006Jv-BL
 for qemu-devel@nongnu.org; Thu, 16 Jul 2020 09:43:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594906997;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=vI9gEiec1hYDl6/toiwFmtNSSDkKUPNnzm3NZjnImEs=;
 b=HR/YeSw1H5u/xzbuRk753dMp3GvSGRIrUeAxprOGxl602Vdkxz1tmq1Hr5QHNCjT4GctLA
 9+N1PlwlgEnkiQ+RE5JGmvgI4gIdSVT+ACaVGBKrXzl79YHWhyeoG7TduCoir5wvWIpRsg
 nB75o05MgcGoy/+FU3LL0nBrs0akNWc=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-472-sVDorzZrNHqBbJ0Yv2kZvQ-1; Thu, 16 Jul 2020 09:43:00 -0400
X-MC-Unique: sVDorzZrNHqBbJ0Yv2kZvQ-1
Received: by mail-wm1-f71.google.com with SMTP id e15so5232855wme.8
 for <qemu-devel@nongnu.org>; Thu, 16 Jul 2020 06:42:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=vI9gEiec1hYDl6/toiwFmtNSSDkKUPNnzm3NZjnImEs=;
 b=O1cd3GjFCV9RYUlXVltqyX2O0Teb+N9MeoxOgkWKBRLxsbX2tjN8Vb3O9J9C3EWnuU
 6V+l7q8cgOq/qk0XuEsQa4tdJ5KgWrQPt/5XVm764eS5Iol6DQXL07m3mdxqFMMmbNQB
 Xi2e2v5ro4nFWkrnwUueoZa0MAGbskoYC1D3PV2LZN/xq4tDMuWsMwn+ujKuWKDA2owm
 xUWma6Q76xuDs4CvchsPRt/O+6H9bVr21Al9mqEzFiyILgdnTDxXZvui+c8IqnXMRjEb
 H6sPteyX4oW9zFWcmIygov7sUdgxuPvggoMu5lw+dTrU+Te66mRqhUmTP6GHv36dm36o
 o01g==
X-Gm-Message-State: AOAM531VqpnCUndB0J8qKx81pWu/PgnWs2BoSU1UWcpjCyK1zaFg2x8O
 xC4qrMIqBcpDufuDRvuRijLcJdQ2YS7zR9vweqfRNgxyWwuIU0wBkxIJBbxj+b3tK+VBHWJoL1W
 3J4ag7mR0XHHwYFQ=
X-Received: by 2002:a1c:2ec4:: with SMTP id u187mr4378617wmu.188.1594906978779; 
 Thu, 16 Jul 2020 06:42:58 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwN1Zg33p59pbHZmcoGnJmmxVTasiSOIyyxmFsb6vvtyeyUDAOmtFDmZ9EHcVYmIVltLlFzeQ==
X-Received: by 2002:a1c:2ec4:: with SMTP id u187mr4378604wmu.188.1594906978546; 
 Thu, 16 Jul 2020 06:42:58 -0700 (PDT)
Received: from [192.168.1.37] (138.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.138])
 by smtp.gmail.com with ESMTPSA id c194sm8609142wme.8.2020.07.16.06.42.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 16 Jul 2020 06:42:58 -0700 (PDT)
Subject: Re: [PATCH 1/2] python/qemu: Cleanup changes to ConsoleSocket
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Robert Foley <robert.foley@linaro.org>
References: <20200715204814.2630-1-robert.foley@linaro.org>
 <20200715204814.2630-2-robert.foley@linaro.org> <87blkfwwe4.fsf@linaro.org>
 <CAEyhzFsu9P4y15uSEZj=VgWE+mZKfsUyb2ov3WxG2NzXkuRqfA@mail.gmail.com>
 <878sfjwqkp.fsf@linaro.org>
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
Message-ID: <871c1f92-1bdd-686b-0255-44c9221f5ef7@redhat.com>
Date: Thu, 16 Jul 2020 15:42:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <878sfjwqkp.fsf@linaro.org>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/16 09:29:31
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: Peter Puhov <peter.puhov@linaro.org>, John Snow <jsnow@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Eduardo Habkost <ehabkost@redhat.com>,
 Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/16/20 3:13 PM, Alex Bennée wrote:
> 
> Robert Foley <robert.foley@linaro.org> writes:
> 
>> On Thu, 16 Jul 2020 at 07:07, Alex Bennée <alex.bennee@linaro.org> wrote:
>>>
>>>
>>> Robert Foley <robert.foley@linaro.org> writes:
>>>
>>>> The changes to console_socket.py and machine.py are to
>>>> cleanup for pylint and flake8.
>>>>
>>>> Signed-off-by: Robert Foley <robert.foley@linaro.org>
>>>> ---
>>>>  python/qemu/console_socket.py | 58 +++++++++++++++++------------------
>>>>  python/qemu/machine.py        |  7 +++--
>>>>  python/qemu/pylintrc          |  2 +-
>>>>  3 files changed, 34 insertions(+), 33 deletions(-)
>>>>
>>>> diff --git a/python/qemu/console_socket.py b/python/qemu/console_socket.py
>>>> index 830cb7c628..6a746c1dbf 100644
>>>> --- a/python/qemu/console_socket.py
>>>> +++ b/python/qemu/console_socket.py
>>>> @@ -1,12 +1,9 @@
>>> <snip>
>>>> @@ -103,7 +104,6 @@ class ConsoleSocket(asyncore.dispatcher):
>>>>
>>>>      def set_blocking(self):
>>>>          """Maintain compatibility with socket API"""
>>>> -        pass
>>>
>>> Hmm shouldn't this be with the change in 2/2 because I thought you
>>> needed a "pass" for an empty function in python?
>>
>> Thanks for the review !
>>
>> Sure, I can move this change to 2/2.  Probably makes more sense there
>> since we're changing this function there too.
>>
>> This change was one of the suggestions from John Snow.
>> He pointed out that the pass is not needed here since the docstring takes
>> the role of the function body.
> 
> Ahh I did not know you could do that... I'll defer to John's superior
> python knowledge.

Yes, a function with a comment is not function with an empty body...

¯\_(ツ)_/¯

When you have doubt about Python, I recommend you Gary Bernhardt's talk
from CodeMash 2012.

> 
>>
>> Thanks & Regards,
>> -Rob
>>
>>>
>>> Otherwise:
>>>
>>> Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
>>>
>>> --
>>> Alex Bennée
> 
> 


