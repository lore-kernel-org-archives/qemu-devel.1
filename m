Return-Path: <SRS0=cpkI=BC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13873C433E5
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 12:58:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D46BE20768
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 12:58:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Mbj/6/cK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D46BE20768
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47376 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyanR-0005Ix-5a
	for qemu-devel@archiver.kernel.org; Thu, 23 Jul 2020 08:58:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42768)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jyamc-000490-1V
 for qemu-devel@nongnu.org; Thu, 23 Jul 2020 08:57:10 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:52776
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jyama-0008A9-Bt
 for qemu-devel@nongnu.org; Thu, 23 Jul 2020 08:57:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595509027;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=OV18F5B0iOdgpfo0wRVmWWF0SpN3VU+x/re96XTZX54=;
 b=Mbj/6/cKPz3FJuokkW8oeVEO2/AHEnsqKR68R8GpAsuK69PtpySl8fcJqOdOvu0WOlBlN6
 ZsLNfKCQqmsWZRjM+ZrG33aCpckuLMLdAfVJZKYH3p8FKLGQ+NepWtZzncvGyBcE+jZUVI
 ww2f0mq4mGby20l50/GLYTDtRj7C+5E=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-408-xrBlIHfwM8yDmMPjKTpkVQ-1; Thu, 23 Jul 2020 08:57:03 -0400
X-MC-Unique: xrBlIHfwM8yDmMPjKTpkVQ-1
Received: by mail-wm1-f71.google.com with SMTP id a5so2494501wmj.5
 for <qemu-devel@nongnu.org>; Thu, 23 Jul 2020 05:57:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=OV18F5B0iOdgpfo0wRVmWWF0SpN3VU+x/re96XTZX54=;
 b=igZFreB4iignT4J6kRjSNbdnTA7VHIGLo/pwJHBn2+xQxXgORK3DVAbH+wUciNDpAG
 xu9ADTy7vN9EEo4YGMljnMy4fkKaCkYTr7zf+5qcnmAXnJgQlRpyPrY3Is7T3NTjmpJ8
 L7YyNYcMLIOgL4zfd23xscqpc9vTVleCuvyoryt9KzgfMpV1RqDLXkLo1J39vGUCZxqy
 wUQ4H8size5NbBZ7E0ZZ5mQfbtgSo4h1NHqK/dLbs9PNFZVcLICjhiYkz2j1HGieeF2b
 /1BsSX/aH/OvwhxdEHVhFUVcibId7LIKFiWQ4HBELSPfLXuy1RimF202gimFxsLb8IK1
 8ytg==
X-Gm-Message-State: AOAM531Ao1wDoqWxm6zqCJtU3fUo1qDBuvS0LQEri4kHr/X6bpduJQNL
 GbjwhYvbMNqz9EWeuKa0Gdh0+SO1pLptHcSSY0WdHfLjVn4WRy5xat5gt7UL0oCc1P9AQnVMtWG
 Ojxhz1zdXotIL89s=
X-Received: by 2002:adf:bb0a:: with SMTP id r10mr1693861wrg.23.1595509021884; 
 Thu, 23 Jul 2020 05:57:01 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxdKJZsmHgTskvwhPK9cqnbyDwMyHmqe3j8TEuOUOTIIcfqD6/TXZOcmVp+xvVjSNYPXZPyKQ==
X-Received: by 2002:adf:bb0a:: with SMTP id r10mr1693841wrg.23.1595509021574; 
 Thu, 23 Jul 2020 05:57:01 -0700 (PDT)
Received: from [192.168.1.36] (138.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.138])
 by smtp.gmail.com with ESMTPSA id c10sm3920709wro.84.2020.07.23.05.57.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 23 Jul 2020 05:57:00 -0700 (PDT)
Subject: Re: [PULL 0/2] fw_cfg patches for 2020-07-21
To: Peter Maydell <peter.maydell@linaro.org>
References: <20200721175326.8004-1-philmd@redhat.com>
 <CAFEAcA-H0E-EFkbHuVOhyy1_p47dbr5uHXqzZL=jgwXVzmD1vw@mail.gmail.com>
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
Message-ID: <bde02d2a-e967-d80f-13ad-37c787d85a2c@redhat.com>
Date: Thu, 23 Jul 2020 14:56:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-H0E-EFkbHuVOhyy1_p47dbr5uHXqzZL=jgwXVzmD1vw@mail.gmail.com>
Content-Language: en-US
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Laszlo Ersek <lersek@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/23/20 12:43 PM, Peter Maydell wrote:
> On Tue, 21 Jul 2020 at 18:54, Philippe Mathieu-Daudé <philmd@redhat.com> wrote:
>>
>> The following changes since commit 90218a9a393c7925f330e7dcc08658e2a01d3bd4:
>>
>>   Merge remote-tracking branch 'remotes/huth-gitlab/tags/pull-request-2020-07=
>> -21' into staging (2020-07-21 10:24:38 +0100)
>>
>> are available in the Git repository at:
>>
>>   https://gitlab.com/philmd/qemu.git tags/fw_cfg-20200721
>>
>> for you to fetch changes up to 077195187b47d83418e5fb521c89d7881fab3049:
>>
>>   hw/nvram/fw_cfg: Let fw_cfg_add_from_generator() return boolean value (2020=
>> -07-21 16:47:54 +0200)
>>
>> ----------------------------------------------------------------
>> fw_cfg patches
>>
>> Fixes the DEADCODE issue reported by Coverity (CID 1430396).
>>
>> CI jobs result:
>> . https://gitlab.com/philmd/qemu/-/pipelines/169086301
>>
>> ----------------------------------------------------------------
>>
>> Philippe Mathieu-Daud=C3=A9 (2):
> 
> Something in your cover-letter creation is not handling UTF-8 right :-)

Yes, this is a known git-publish issue:
https://github.com/stefanha/git-publish/issues/88

It only happens with the cover, it doesn't affect the patches,
so it is considered a very low priority issue :)

> 
>>   hw/nvram/fw_cfg: Simplify fw_cfg_add_from_generator() error
>>     propagation
>>   hw/nvram/fw_cfg: Let fw_cfg_add_from_generator() return boolean value
> 
> 
> Applied, thanks.
> 
> Please update the changelog at https://wiki.qemu.org/ChangeLog/5.1
> for any user-visible changes.

Thanks (no user-visible changes in these patches).

Phil.


