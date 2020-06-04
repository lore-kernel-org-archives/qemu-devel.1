Return-Path: <SRS0=1Qun=7R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66E88C433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 15:56:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2D111206A2
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 15:56:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D2GY/549"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D111206A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35982 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgsEc-00037h-Ev
	for qemu-devel@archiver.kernel.org; Thu, 04 Jun 2020 11:56:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47988)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jgsDn-0002Om-6o
 for qemu-devel@nongnu.org; Thu, 04 Jun 2020 11:55:59 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:53518
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jgsDl-00028c-Jy
 for qemu-devel@nongnu.org; Thu, 04 Jun 2020 11:55:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591286156;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=ZSUs2UwiC2+LOzZWwH5AXKd5N12CAHgO7GcS0o20I9I=;
 b=D2GY/549nWyOZ8XJW8NOC6XxiP97IqLGFXEfJO+vPFutP6HIVY4FwP8+zj1+FrkM+d/pOB
 KB6alGTzYsOSNYNhcxQKSTAq4p1yAsHCk7ygspLGlzciXwwmkrlfXzUS5WtcwIjBEiIbLF
 Hdk4rreFID8xiAuw76f/IhkhsSIU+6w=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-413-hkr4dk-vNRqE3qbpZlPLxw-1; Thu, 04 Jun 2020 11:55:54 -0400
X-MC-Unique: hkr4dk-vNRqE3qbpZlPLxw-1
Received: by mail-wm1-f72.google.com with SMTP id 11so1911551wmj.6
 for <qemu-devel@nongnu.org>; Thu, 04 Jun 2020 08:55:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=ZSUs2UwiC2+LOzZWwH5AXKd5N12CAHgO7GcS0o20I9I=;
 b=sLJadVGYuaEZzXJBf5vXKWTmxXjs89HWstWbxa+fXgQ7ZzD6DHjLep1kVoo+q26k5s
 ooDmEI+1yqFOFeiqOtra1qOtPhXEw1u7w+a+WwmOXHP1TH+WBKtvtofu1W6SWSV0OxX/
 bbWrAohVrWfBg+MVqgVTVUxDMONHyhkFKIsCqcV1DwLb5RIUCTiIktv1lKv+LUm1wng5
 YSWwPkz6GF8sokJCThFpGxHyDGQZjFKpWfXeLTWf+1EW0upW0x86JqdVXVUe6msKZmZf
 NK5gfDJO3IOjnay/KlWdtMoXSxo7C+Y01Y201uwiXFCrtcDp1XSicEEu5Br4Fg+IbwBF
 DPMQ==
X-Gm-Message-State: AOAM533EGmyPTjGHrrH06DvQptbOoTau0eEBzLvgxTo+3Bp4b0ywP/re
 QPXkqIP0SrXaM2kYoFw8xFt4xGYTGub1LNomI/1trLlWnHUixabPxSyWb4t7wGFdEO9m36mDlYx
 I/kIMpOy5jPuZSvE=
X-Received: by 2002:a5d:6b81:: with SMTP id n1mr4981951wrx.411.1591286153283; 
 Thu, 04 Jun 2020 08:55:53 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyKP2wjhhIVqV/6/D0Xs5LdL450mpJdYCGyyN/mo8HkTCELdBs5tQoaUIlJIW1SwMVFLZi5Jg==
X-Received: by 2002:a5d:6b81:: with SMTP id n1mr4981923wrx.411.1591286153056; 
 Thu, 04 Jun 2020 08:55:53 -0700 (PDT)
Received: from [192.168.1.43] (181.red-88-10-103.dynamicip.rima-tde.net.
 [88.10.103.181])
 by smtp.gmail.com with ESMTPSA id j68sm8973064wrj.28.2020.06.04.08.55.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 04 Jun 2020 08:55:52 -0700 (PDT)
Subject: Re: [PATCH] hw/block/pflash_cfi01: Limit maximum flash size to 256 MiB
To: Peter Maydell <peter.maydell@linaro.org>
References: <20200525155826.11333-1-philmd@redhat.com>
 <CAFEAcA8UGjx5S+zVHX_Oon-ELaCRuLpXEDrjs0VoAwqJ7uPn3g@mail.gmail.com>
 <5dbecc86-f9df-249d-7439-36c358dc5aba@redhat.com>
 <CAFEAcA9qVBdLZMO4e+oSaL6kwpF9WS+RdeL3DxBNKVMPwnQ=TQ@mail.gmail.com>
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
Message-ID: <918fedda-6966-9d67-b58e-a005cd28a2d1@redhat.com>
Date: Thu, 4 Jun 2020 17:55:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9qVBdLZMO4e+oSaL6kwpF9WS+RdeL3DxBNKVMPwnQ=TQ@mail.gmail.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/04 01:31:23
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Kevin Wolf <kwolf@redhat.com>, Hongbo Zhang <hongbo.zhang@linaro.org>,
 Tanmay Jagdale <tanmay.jagdale@linaro.org>, Qemu-block <qemu-block@nongnu.org>,
 Markus Armbruster <armbru@redhat.com>,
 Radoslaw Biernacki <radoslaw.biernacki@gmail.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Max Reitz <mreitz@redhat.com>,
 Leif Lindholm <leif@nuviainc.com>, Laszlo Ersek <lersek@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/4/20 5:30 PM, Peter Maydell wrote:
> On Thu, 4 Jun 2020 at 16:16, Philippe Mathieu-Daudé <philmd@redhat.com> wrote:
>> On 5/25/20 10:59 PM, Peter Maydell wrote:
>>> What problem is this check solving? Is there some implementation
>>> imposed limitation or a limit within the flash header format
>>> that means larger sizes don't work? If so, what's the restriction?
>>
>> I am not confident maintaining virtual device with no specifications.
> 
> This isn't a virtual device, is it? The CFI spec exists and defines
> what these flash devices behave like.
> 
>> If someone come with a datasheet for a pflash > 256MB then we can add
>> another commit to relax this restriction.
>> If someone is forced to use a >256MB and such hardware does not exist,
>> I'd rather have a document in docs/specs/pflash_cfi01.rst describing the
>> CFI fields.
>>
>> IOW this is not a hardware limitation, but a maintenance protection.
>>
>> I am worried with the recent EDK2 activity with the SBSA-ref, and I
>> don't want to give false hope to developers that they can create any
>> kind of pflash with the current device model.
>>
>> If I reword this better in the commit description, is my argument
>> acceptable?
> 
> Not really; I think we should know what we're limiting against.
> Currently you're checking total_len, but this is just sector_len * nb_blocs,
> so if there's a problem with silly large values then it's probably
> actually a problem with one of those being over-sized which would
> still show up even if the total_len was less than 256MB.
> (I suspect the underlying limit here is what the cfi_table entries
> 0x2D..0x30 impose on blocks_per_device and sector_len_per_device.)

What I'm working on is a whitelist of the few models our machines really
use, but it is taking time. Meanwhile I wanted to at least limit the
total size.

I'll try to finish my whitelist effort before someone try to use a
>256MB flash.

> 
> thanks
> -- PMM
> 


