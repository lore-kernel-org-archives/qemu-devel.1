Return-Path: <SRS0=5nOY=BY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B503C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2020 07:38:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 412C720639
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2020 07:38:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ioa+GvQN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 412C720639
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34812 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k6UI5-00021R-AI
	for qemu-devel@archiver.kernel.org; Fri, 14 Aug 2020 03:38:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41290)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k6UHO-0001Uf-RA
 for qemu-devel@nongnu.org; Fri, 14 Aug 2020 03:37:35 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:35836
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k6UHM-000759-81
 for qemu-devel@nongnu.org; Fri, 14 Aug 2020 03:37:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597390650;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=ff8yorX7FNLt+LfNRH5luQzB00S3Pa/2+2gEHrz+wAQ=;
 b=ioa+GvQNSVxkQuo93w5TEVlbIu5MFeH6SFNNUuOvQN0JtbdnBtX8L5/rJ7Nl4M4NO9piNt
 +lPzx89MvpxpmQKXUdMsw70leq9qB2FKOguDUqIqOwnT5LBIWEGHXyNhOaPFo+FebxkAqO
 WLnVkp5CuDx6lnYRQ2zkLuFdVzUduuI=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-126-QNxNs50NOh-ZfFiFXWQCwQ-1; Fri, 14 Aug 2020 03:37:29 -0400
X-MC-Unique: QNxNs50NOh-ZfFiFXWQCwQ-1
Received: by mail-wm1-f72.google.com with SMTP id i15so2856866wmb.5
 for <qemu-devel@nongnu.org>; Fri, 14 Aug 2020 00:37:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=ff8yorX7FNLt+LfNRH5luQzB00S3Pa/2+2gEHrz+wAQ=;
 b=EimvOWo+a9hf2T95swvVju1apm0U6zI9ESAt7wyl5WdPqACq9wZg4i4hpqLhS6xlrh
 MIJWI7S/klP1JLAo8pTD9grlv1B8E32T0cij+CWfnnEE7PXEgJVy8AEzWibPHbdYy1FC
 3iX8Ip6f+slOQTE0joKrd9vyX/pdiFbHfyOqnoLFjevl+r4b5sPHZ15jUPZCC9n4qn1F
 cXhFzroakPf0xF690k+jPQltPOjJ1TeXOEXIuKr1ukFwaG+VhprXYt75Navn9XJLwF8u
 VVemlR7cRZ2r7NF8ibhWpSxiOJPug0YjVZCNpGRyQyLLguujdaCyfD0ur9WTPBbMptYJ
 QgYQ==
X-Gm-Message-State: AOAM5314Ye+g761tsT8+J3lwtq57XDHkja7yGU05EEWHG6nFM6DW5Vvl
 WN8eRoaJReJdrNzhMkJOgH/p0W2YWZ8GHPS5yaVHCIGqX6UeXcWurmxkdwslGUuiSi4TIHTvbwT
 T0ZrJCYm49JH0MdY=
X-Received: by 2002:adf:c983:: with SMTP id f3mr1488644wrh.348.1597390647804; 
 Fri, 14 Aug 2020 00:37:27 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwqL/HqZB15Q9nfCcDOjCM0XUweKRVa4Lb1l6sbpQx8kaNIB2EB7xWmOeP7f9MC/QjWR26iMg==
X-Received: by 2002:adf:c983:: with SMTP id f3mr1488627wrh.348.1597390647574; 
 Fri, 14 Aug 2020 00:37:27 -0700 (PDT)
Received: from [192.168.1.36] (121.red-81-40-121.staticip.rima-tde.net.
 [81.40.121.121])
 by smtp.gmail.com with ESMTPSA id v8sm13207759wmb.24.2020.08.14.00.37.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 14 Aug 2020 00:37:26 -0700 (PDT)
Subject: Re: [PULL 3/3] configure: Allow to build tools without pixman
To: Thomas Huth <thuth@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 qemu-devel@nongnu.org
References: <20200724164258.24886-1-kraxel@redhat.com>
 <20200724164258.24886-4-kraxel@redhat.com>
 <f1fbe9b9-575e-b55f-8596-754a82654b5c@redhat.com>
 <2abe330a-37e2-fda6-d531-79fb5805afc7@redhat.com>
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
Message-ID: <8ccd0dc6-05e7-1d6a-6b7a-e7366550d079@redhat.com>
Date: Fri, 14 Aug 2020 09:37:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <2abe330a-37e2-fda6-d531-79fb5805afc7@redhat.com>
Content-Language: en-US
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/14 03:37:30
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Rafael Kitover <rkitover@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/13/20 9:07 PM, Thomas Huth wrote:
> On 12/08/2020 18.26, Philippe Mathieu-Daudé wrote:
>> Hi,
>>
>> On 7/24/20 6:42 PM, Gerd Hoffmann wrote:
>>> From: Thomas Huth <thuth@redhat.com>
>>>
>>> If pixman is not installed, it is currently not possible to run:
>>>
>>>  .../configure  --disable-system --enable-tools
>>>
>>> Seems like there was a dependency from one of the required source
>>> files to pixman in the past, but since commit 1ac0206b2ae1ffaeec56
>>> ("qemu-timer.c: Trim list of included headers"), this dependency
>>> should be gone. Thus allow to compile the tools without pixman now.
>>>
>>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>>> Message-id: 20200723141123.14765-1-thuth@redhat.com
>>> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
>>> ---
>>>  configure | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/configure b/configure
>>> index 4bd80ed507aa..2acc4d1465f8 100755
>>> --- a/configure
>>> +++ b/configure
>>> @@ -4065,7 +4065,7 @@ fi
>>>  ##########################################
>>>  # pixman support probe
>>>  
>>> -if test "$want_tools" = "no" && test "$softmmu" = "no"; then
>>> +if test "$softmmu" = "no"; then
>>>    pixman_cflags=
>>>    pixman_libs=
>>>  elif $pkg_config --atleast-version=0.21.8 pixman-1 > /dev/null 2>&1; then
>>>
>>
>> This commit broke my '--disable-system --disable-user --enable-tools' build:
>>
>> $ make vhost-user-gpu
> 
> Yes, there is already a patch on the list to fix this. Look for:
> "configure: Require pixman for vhost-user-gpu". I hope Gerd can pick it
> up for his next pull request.

Thanks! I'll test it. Too bad it misses the release :(

> 
>  Thomas
> 


