Return-Path: <SRS0=atk5=B7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCD54C433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 16:19:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C69522DD6
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 16:19:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OL4aOTF9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C69522DD6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59968 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k99kz-0004kt-VD
	for qemu-devel@archiver.kernel.org; Fri, 21 Aug 2020 12:19:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56674)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k99ge-00084k-6D
 for qemu-devel@nongnu.org; Fri, 21 Aug 2020 12:14:40 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:58711
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k99gc-0004kn-0G
 for qemu-devel@nongnu.org; Fri, 21 Aug 2020 12:14:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598026477;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=Kw4iRv82SX96zP42TOMG4Y9OsrNBp208ag9J2U+t+Dc=;
 b=OL4aOTF9S+7EJYRQLhpJ+Y82tjTWPWtdRs0qO/GM4EZV7PDsA9ZIKVKVO0kSlpUHMOcwo/
 XZmuGWZPvS9IjN61CGTJm+TC0WiuZDdajbt40sRUY44I4jBpLU17Hxm648dY4HHmvssD9X
 pT26RecbjjgB5AIryv2ZnMwVSXZa8EY=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-126-LrtQnxDKNbyPFGm_7gP7SA-1; Fri, 21 Aug 2020 12:14:29 -0400
X-MC-Unique: LrtQnxDKNbyPFGm_7gP7SA-1
Received: by mail-wm1-f71.google.com with SMTP id q15so973202wmj.6
 for <qemu-devel@nongnu.org>; Fri, 21 Aug 2020 09:14:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=Kw4iRv82SX96zP42TOMG4Y9OsrNBp208ag9J2U+t+Dc=;
 b=U8I1XXx8XW/ArFAUviJhZR+XH51NvmWnUgsCRtXKAW7YFf5O5GUcA4BLLeeEekO5cb
 vZOI1FNL+1KT1gqWpZx+DqXBydDUOENNcVeSMfXjFbLvRLt8R9O7rSibZ/M0bkdGBxdp
 RiT1pPkStpnVCqz7LiT8toT7Pk3fF3o9c46JPyGNa+HyK1142eIVmZ87jLdzAIOOyEzz
 PZViEzZ2kSfGrKS7oj3ggNTp1tSma/lw4Wz5tp7FgPPlDDkrrPmuMYGjqsPSG8zWx6la
 445BX2PRl6aYD3XSSVbpQIQOW82cSpbrJFHORXjuiTWQScxau1BzLjZwH1i92Ijsn5DR
 8fzg==
X-Gm-Message-State: AOAM530A3L2M4/MTlzZpoxaDyJ0S4GGUuARzycupjgZUQP4lZWz7bgEt
 zqpdMnsXsAfSA3i/p12Lc2dRAEVT5wAh0oTTku3fTFvJV99qsjzzU0j/qOA9qGDJ1vk4ne1Q3G6
 shSoZWPJZHJA1FUM=
X-Received: by 2002:a1c:540c:: with SMTP id i12mr3679137wmb.96.1598026467607; 
 Fri, 21 Aug 2020 09:14:27 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwNET8Z/sKqfDUrk9ECDgrUjRq9z+oPtFI+ahXDyMDdD0bsn7R5yqvil4P2T4q1zFmi+FTGrQ==
X-Received: by 2002:a1c:540c:: with SMTP id i12mr3679110wmb.96.1598026467326; 
 Fri, 21 Aug 2020 09:14:27 -0700 (PDT)
Received: from [192.168.1.36] (121.red-81-40-121.staticip.rima-tde.net.
 [81.40.121.121])
 by smtp.gmail.com with ESMTPSA id a10sm5219310wro.35.2020.08.21.09.14.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 21 Aug 2020 09:14:26 -0700 (PDT)
Subject: Re: [PATCH] configure: silence 'shift' error message in version_ge()
To: Stefano Garzarella <sgarzare@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
References: <20200821150014.42461-1-sgarzare@redhat.com>
 <CAFEAcA9zUDeig8TB4JDd_48v2AXcr7HGyjGq6r7KVx=sQyrjXA@mail.gmail.com>
 <20200821152627.trreokf3ly24thrs@steredhat>
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
Message-ID: <7ac1a133-8b60-226d-4358-231f4b6b29a1@redhat.com>
Date: Fri, 21 Aug 2020 18:14:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200821152627.trreokf3ly24thrs@steredhat>
Content-Language: en-US
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/21 01:00:15
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/21/20 5:26 PM, Stefano Garzarella wrote:
> On Fri, Aug 21, 2020 at 04:21:10PM +0100, Peter Maydell wrote:
>> On Fri, 21 Aug 2020 at 16:00, Stefano Garzarella <sgarzare@redhat.com> wrote:
>>>
>>> If there are less than 2 arguments in version_ge(), the second shift
>>> prints this error:
>>>     ../configure: line 232: shift: shift count out of range
>>>
>>> Let's shut it up, since we're expecting this situation.

Maybe s/shut up/silence/?

>>>
>>> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
>>> ---
>>>  configure | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/configure b/configure
>>> index 4e5fe33211..de4bd0df36 100755
>>> --- a/configure
>>> +++ b/configure
>>> @@ -229,7 +229,7 @@ version_ge () {
>>>          set x $local_ver1
>>>          local_first=${2-0}
>>>          # shift 2 does nothing if there are less than 2 arguments
>>> -        shift; shift
>>> +        shift; shift 2>/dev/null
>>
>> POSIX says
>> https://pubs.opengroup.org/onlinepubs/9699919799/utilities/V3_chap02.html#shift
>>
>> "If the n operand is invalid or is greater than "$#", this may be
>> considered a syntax error and a non-interactive shell may exit"
>>
>> so I think that we need to actually avoid the excess shift,
> 
> Maybe something like this:
> 
> diff --git a/configure b/configure
> index de4bd0df36..5f5f370e2c 100755
> --- a/configure
> +++ b/configure
> @@ -229,7 +229,7 @@ version_ge () {
>          set x $local_ver1
>          local_first=${2-0}
>          # shift 2 does nothing if there are less than 2 arguments
> -        shift; shift
> +        shift; test $# -gt 0 && shift

This looks better that mine indeed.

>          local_ver1=$*
>          set x $local_ver2
>          # the second argument finished, the first must be greater or equal
> 
>> not just suppress any warning it might print. (I'm not sure
>> Philippe's "shift || shift" patch can work for that, though,
>> as the exit status doesn't distinguish "valid shift but don't
>> do it again" from "valid shift and more args to come".)
> 
> I tried and also if I have meson 0.55.0, with the Philippe's patch
> applied it tries to download our internal meson, so maybe it is not
> working as expected.

=)

> 
> Thanks,
> Stefano
> 


