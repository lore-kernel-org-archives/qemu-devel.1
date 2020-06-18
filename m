Return-Path: <SRS0=FaGC=77=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FBF1C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 10:36:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BEBA620706
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 10:36:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NVSy1dON"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BEBA620706
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50252 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlruF-0007uo-Ol
	for qemu-devel@archiver.kernel.org; Thu, 18 Jun 2020 06:36:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44570)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jlrtG-0006Sv-9v
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 06:35:26 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:34291
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jlrtC-0007XF-5o
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 06:35:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592476520;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=F9m5YQV0nHEOpjjyDseH18Zq49wNJQGWE9XMFCMqdLg=;
 b=NVSy1dONzpfZ57EBGDM97CKr5m8GuQjypFdpMUv/LqmkbPZDvL9SD+vFK1mkG6FwRhStp0
 lwJ76VXSxeoM14nnVrypgD9Q5aTpnOQro+Gv8DBKgTy90UUDI4X1+DDba7voIV9Y+v41dd
 KkHq2VygmX3RYHtXCAdm8K8y5gnOTVc=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-182-uWPqW8nLMci8-CEEys8CEA-1; Thu, 18 Jun 2020 06:35:18 -0400
X-MC-Unique: uWPqW8nLMci8-CEEys8CEA-1
Received: by mail-wr1-f69.google.com with SMTP id c14so2611183wrw.11
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2020 03:35:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=F9m5YQV0nHEOpjjyDseH18Zq49wNJQGWE9XMFCMqdLg=;
 b=XNId3alRU7Y4xzaOQSQTWwCzW9+c6tb/HOr106xSlh4YP5oVai7L+CaeU9jTbGRrKB
 WMiCpEAk7CyTw1auagIvH0Lxqh5bBBVOqBkxWVksXK0qg8idtSVl7Pyupn3ZM8npGx7L
 3DWLd6I+Ydc7eMbowctSqWSUQTXh84+G9JQPPTKa5EfPUticQFkxgMzXUW+xlBFUAbEf
 JJ+swswBMvOLcTjSPvPYKCxgb7qMKXDHGrZFvzPM7cKJaC4Va4PngJ40BpPO3NVwLJnd
 L9r0fV/X7sxMsLW1HHwFSC0Wwkt3+e/owrlJ/32XwM7uzGmnfT2AkIkkhBOMPU+lUsXw
 shJA==
X-Gm-Message-State: AOAM531rGPsZMf73SXTjEFKjdBMxwYjECM1Nq2iKqvH4WlXGFtbYpOao
 zqi+VTbRu2cCK4+rMzBZmvw3NZJJCvaOL5ZR8tjXDtUVTHwYYxA8WDv2hNXemDXhp93iheNfmg5
 SEvtPJ/LCbqhVGZk=
X-Received: by 2002:a05:600c:4146:: with SMTP id
 h6mr3378043wmm.172.1592476517702; 
 Thu, 18 Jun 2020 03:35:17 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw9TTouuQZRtFR1WUR29js+cSf2/esXXi4p+uoD9l+gqBn/Tof1hbyC6F2JQBmhQWeTMsSNSg==
X-Received: by 2002:a05:600c:4146:: with SMTP id
 h6mr3378024wmm.172.1592476517486; 
 Thu, 18 Jun 2020 03:35:17 -0700 (PDT)
Received: from [192.168.1.38] (93.red-83-59-160.dynamicip.rima-tde.net.
 [83.59.160.93])
 by smtp.gmail.com with ESMTPSA id r1sm2148447wrn.29.2020.06.18.03.35.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 18 Jun 2020 03:35:16 -0700 (PDT)
Subject: Re: [PATCH] hw/audio/gus: Fix registers 32-bit access
To: Peter Maydell <peter.maydell@linaro.org>
References: <20200615201757.16868-1-aperamak@pp1.inet.fi>
 <CAFEAcA-eKboVf3uk4iY_A9_uQ=HnGyic4fzbzJhv1gH2V+TMVw@mail.gmail.com>
 <fdb9eabf-2663-f2e4-6b40-2455261eaa46@redhat.com>
 <CAFEAcA9sCJ6wKdra+EBFOJfOaZbtOE0DND6S6rh5jgrDqLG57Q@mail.gmail.com>
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
Message-ID: <eae2ce28-693a-b838-37ea-b8a58a581bb8@redhat.com>
Date: Thu, 18 Jun 2020 12:35:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9sCJ6wKdra+EBFOJfOaZbtOE0DND6S6rh5jgrDqLG57Q@mail.gmail.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/18 01:21:16
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: QEMU Trivial <qemu-trivial@nongnu.org>,
 Allan Peramaki <aperamak@pp1.inet.fi>, QEMU Developers <qemu-devel@nongnu.org>,
 Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/18/20 12:23 PM, Peter Maydell wrote:
> On Thu, 18 Jun 2020 at 11:22, Philippe Mathieu-Daudé <philmd@redhat.com> wrote:
>>
>> On 6/17/20 10:23 PM, Peter Maydell wrote:
>>> On Mon, 15 Jun 2020 at 22:23, Allan Peramaki <aperamak@pp1.inet.fi> wrote:
>>>>
>>>> Fix audio on software that accesses DRAM above 64k via register peek/poke
>>>> and some cases when more than 16 voices are used.
>>>>
>>>> Fixes: 135f5ae1974c ("audio: GUSsample is int16_t")
>>>> Signed-off-by: Allan Peramaki <aperamak@pp1.inet.fi>
>>>
>>> This patch is quite difficult to read because it mixes some
>>> whitespace only changes with some actual changes of
>>> behaviour.
>>
>> In such cases the author might add a comment in the commit
>> description "this patch is easier to review with git-diff -w"
>> or other options.
>>
>> Allan, can we get the patch with only the changed lines?
> 
> Is it worth the effort of a respin at this point?
> 

I'll give it a try to see if it takes me less than 2min.


