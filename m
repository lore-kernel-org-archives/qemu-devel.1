Return-Path: <SRS0=4umr=AO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DCBFC433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 13:36:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E642206A1
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 13:36:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F4Jn3nt9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E642206A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33632 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrLrF-0000Ih-KO
	for qemu-devel@archiver.kernel.org; Fri, 03 Jul 2020 09:36:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48402)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jrLqY-00087G-1y
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 09:35:18 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:29610
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jrLqV-00048K-1p
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 09:35:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593783313;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=/CQ9zqDg8ltHtM4ewSqe96QwVsTq6Q60kANp4MDHTio=;
 b=F4Jn3nt9YmTGbvt/zf1HXJYEIXapM8sTg41bG/O0QUy7jByg/DNr1DEysVoOdPzpCvaOGX
 voSFebh7SBqjHu5dcnv4P7CMaYw9b1wfx5547QSMtVUG4LpaLBfZ394Kv4P9p44cgwwa78
 cPtt5XCHyNR0DqVM28M8Qj+HJdgAy8w=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-37-QLxN0UuxPFK0WneySADzTw-1; Fri, 03 Jul 2020 09:35:11 -0400
X-MC-Unique: QLxN0UuxPFK0WneySADzTw-1
Received: by mail-wm1-f70.google.com with SMTP id g187so34950164wme.0
 for <qemu-devel@nongnu.org>; Fri, 03 Jul 2020 06:35:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=/CQ9zqDg8ltHtM4ewSqe96QwVsTq6Q60kANp4MDHTio=;
 b=nusH2hOEDMRBuShXuQccMv3GI1/+cqGauGo/CpW3Ok6q954XOJ1BFKCnwiZaAk9X7a
 FCWn2cvBTosUOVsPz0mY+yVMorPI2hkQDnxwbNy6mRrM/VyfvRuuD3nyteKD8iuCPeDq
 Z2JFFZUkGTbWtyRN5G5LLpXCAFHvk85iodId7C5C4xxXlzBkweu1dXVsHJVCfyBUesyu
 AB2pvVfIKpmuiX6a6Bt350kch5R/D9hnVFzwmhnTbzqhozS+6e5tG6keSeJDcAUBoUuP
 tZcm8d+kiwEqkuMRxG14iM9bCyWEzZv3qIKQDCnZCok1IWKnzu5p9riZuL39fPg/YaiK
 /gCw==
X-Gm-Message-State: AOAM5330N0zx6DjiagRsNX6Atfej/GDSje45ZsvV+wJzYTKjN5a3cPFn
 TBwMN48Zm9O4hU+BMvgfF9V0+SBpZ/dGum2Q1JHV3Ue8QCkUBsVq+f5V1/Qkra7MPeumBpTYoIx
 vS2atzVpX2LfxK88=
X-Received: by 2002:a7b:ca4c:: with SMTP id m12mr37079412wml.33.1593783310365; 
 Fri, 03 Jul 2020 06:35:10 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw5vA2OaHcPNUvVX4DNRddqCM4e9lgmhoOHTzhJpbu+2Gsjh/kumjY3hFdAKvZKDq2RO3LqiQ==
X-Received: by 2002:a7b:ca4c:: with SMTP id m12mr37079378wml.33.1593783310024; 
 Fri, 03 Jul 2020 06:35:10 -0700 (PDT)
Received: from [192.168.1.39] (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id x11sm13025193wmc.26.2020.07.03.06.35.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 03 Jul 2020 06:35:09 -0700 (PDT)
Subject: Re: [PATCH v3 00/12] Add Nuvoton NPCM730/NPCM750 SoCs and two BMC
 machines
To: Peter Maydell <peter.maydell@linaro.org>,
 Havard Skinnemoen <hskinnemoen@google.com>,
 Markus Armbruster <armbru@redhat.com>
References: <20200626235519.591734-1-hskinnemoen@google.com>
 <CAFEAcA_3y3XoF6BsYUt19f2CvyseahSEZWfY0iQxByJKaMA29w@mail.gmail.com>
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
Message-ID: <296f281f-e045-e794-1a1b-4e311b6408b2@redhat.com>
Date: Fri, 3 Jul 2020 15:35:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_3y3XoF6BsYUt19f2CvyseahSEZWfY0iQxByJKaMA29w@mail.gmail.com>
Content-Language: en-US
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/03 02:53:25
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: QEMU Developers <qemu-devel@nongnu.org>, Joel Stanley <joel@jms.id.au>,
 CS20 KFTing <kfting@nuvoton.com>, qemu-arm <qemu-arm@nongnu.org>,
 =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>,
 IS20 Avi Fishman <Avi.Fishman@nuvoton.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/3/20 2:27 PM, Peter Maydell wrote:
> On Sat, 27 Jun 2020 at 00:55, Havard Skinnemoen <hskinnemoen@google.com> wrote:
>>
>> Time for another refresh of this patchset. Sorry it took so long -- I've been
>> trying to figure out why the Winbond flash model isn't working with
>> npcm750-evb, and I'm fairly convinced the number of dummy cycles in DIO mode
>> should be 4, not 1. Unfortunately, I don't see any other machines using Winbond
>> flash in DIO mode, so it's hard to prove that it's correct. I'm planning to
>> post a libqos-based test suite separately.
>>
>> I'm also planning to add the vbootrom to qemu as a submodule, similar to the
>> other roms, but not in this pathset (let me know if you do want me to include
>> this in the series).
> 
> Hi; it looks like codewise this patchset is ready to go in
> and it's all been reviewed. I see however that all the
> new files are GPL-v2-only. We usually prefer GPL-v2-or-later
> for new code: is it possible to use that license instead ?

This series has been posted before Markus qdev & error cleanups.
Maybe some newer error patterns should be used now instead?

Phil.


