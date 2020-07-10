Return-Path: <SRS0=e3er=AV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3033C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 08:43:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6CD6E2078D
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 08:43:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IpcCJkx8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6CD6E2078D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58570 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtodP-0003DK-PK
	for qemu-devel@archiver.kernel.org; Fri, 10 Jul 2020 04:43:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34166)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jtoct-0002nI-92
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 04:43:23 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:40620
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jtocr-0006q5-NB
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 04:43:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594370600;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=VOmLdh4eyJMf4MT99rmFSHG4W/xre9xMSIo1mI45dlg=;
 b=IpcCJkx8e+fUosOtIN1NikEBAcpOZEIotW1Z19mtyzq09gjv5Sm3POZ86Dkgh3YbeDulbA
 l2qJ2LN9v+qoDiAUwEIFMxo2w5dlg/4M/VOMQOOaUIWdM8g6O2coqQ7h6ROwBB3oMFX/Yt
 yBrAmWWWwDkpaMqfLmwu2GGalcytFJc=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-390-ZqlUS_9JPbuUEF8zCVb1mw-1; Fri, 10 Jul 2020 04:43:05 -0400
X-MC-Unique: ZqlUS_9JPbuUEF8zCVb1mw-1
Received: by mail-wr1-f72.google.com with SMTP id y13so5227275wrp.13
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2020 01:43:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=VOmLdh4eyJMf4MT99rmFSHG4W/xre9xMSIo1mI45dlg=;
 b=JcOZldzlipUtKBGwbvgukxaz+a2pPafayIMkfJ4vG2A1Zrj+u6FJcSoEaa/aEqj3t0
 GIDf3TnyHDa/OjmB5WcgKudKokPraCnt8QTGNggRlzRZkMahgAB24rZ6o5uukm+ZTNI+
 /vSP0AWb8rtNV+EZODqybzPp6wRpgDGG2vBCFsmr9Cxkvj9OJBsL8tn0b2B5D/H8NctK
 akwWCktzD9Kht/uF8i0zMqwfDDkrRAKLudQLiBfCEbMFJeYeKJg0q3FL84E5TIJ35mv8
 jQxwfQJwa8JxVfLHw30eaIL6HlLGxv+XpT+oP8rkQjKQdxJsYNxsqA8ijtqBpENmZNBx
 54Rw==
X-Gm-Message-State: AOAM532QhDGgkD9nRd/u05SOfU9K6KkhT/bSzvKpACRbqXmQBxDRkVpN
 nwlXZU74pgpTRqhKK770VBwtLBaw7RviV//me2OzhZMZ44mO+FBqPGxky+81SwzzYLHtBX/s0IF
 fpzALuZAV6CYETTE=
X-Received: by 2002:a7b:c7c2:: with SMTP id z2mr4028478wmk.39.1594370584356;
 Fri, 10 Jul 2020 01:43:04 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxuoqE6fEmLmbDIm3TGSsvHrcRrqfjwFYCP4fFxSjrpg+Bn9lO2ZjPk/UL58IB5Vr0RpOrc/w==
X-Received: by 2002:a7b:c7c2:: with SMTP id z2mr4028457wmk.39.1594370584048;
 Fri, 10 Jul 2020 01:43:04 -0700 (PDT)
Received: from [192.168.1.37] (138.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.138])
 by smtp.gmail.com with ESMTPSA id v15sm7963477wmh.24.2020.07.10.01.43.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 10 Jul 2020 01:43:03 -0700 (PDT)
Subject: Re: Separate notifications from list messages?
To: Peter Maydell <peter.maydell@linaro.org>, Liviu Ionescu <ilg@livius.net>
References: <E646BE29-B46F-4B56-ADF5-B0DC6CCEF422@livius.net>
 <0a3689e1-001a-76ec-894d-0bb63115ecdd@redhat.com>
 <CAFEAcA-Y_e9V2UTEZoVbxOWQcs_eP96cMQ1J2BtC6Y0AAUTgSA@mail.gmail.com>
 <FF6A540C-7C16-4FFC-9A6D-FAB9EFE56B7F@livius.net>
 <CAFEAcA_c3M-NQcXMt7pnA1qn9B8AYSnFMP1zHx3i_cU2cqpnSQ@mail.gmail.com>
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
Message-ID: <62f156e3-db58-e271-23de-ba2f95577252@redhat.com>
Date: Fri, 10 Jul 2020 10:43:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_c3M-NQcXMt7pnA1qn9B8AYSnFMP1zHx3i_cU2cqpnSQ@mail.gmail.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/09 22:08:55
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
Cc: Thomas Huth <thuth@redhat.com>, Qemu Developers <qemu-devel@nongnu.org>,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/10/20 10:32 AM, Peter Maydell wrote:
> On Fri, 10 Jul 2020 at 09:25, Liviu Ionescu <ilg@livius.net> wrote:
>>> On 10 Jul 2020, at 11:09, Peter Maydell <peter.maydell@linaro.org> wrote:
>>>
>>> What sort of notifications are we talking about here ?

qemu-ci-notifications@ for all our CI?

>>
>> For example:
>>
>> ...
>> Received: from mg.gitlab.com (74.90.74.34.bc.googleusercontent.com
>>  [34.74.90.74]) by smtp-out-n18.prod.us-west-2.postgun.com with SMTP id
>>  5f074fb9a33b1a3dd4571072 (version=TLS1.3, cipher=TLS_AES_128_GCM_SHA256);
>>  Thu, 09 Jul 2020 17:11:21 GMT
>> Date: Thu, 09 Jul 2020 17:11:20 +0000
>> Message-ID: <5f074fb827f26_7cd93fa34d371dbc1570d@sidekiq-catchall-02-sv-gprd.mail>
>> Subject: QEMU | Pipeline #164899134 has failed for master | 3d7cad3c
>> Reply-to: GitLab <noreply@gitlab.com>, GitLab <gitlab@mg.gitlab.com>
>> From: GitLab via <qemu-devel@nongnu.org>
>> ...
> 
> Thanks; yeah, I've seen those go past. Do we expect any other
> kinds to appear as we make more use of gitlab?

If we create qemu-ci-notifications@ we could enable the email
notifications from Shippable/Cirrus/Travis.

Shippable/Cirrus are only checked by Alex/myself, it is not
practical.

We could move the Travis-CI IRC notification to this mailing
list.

Then when jobs are ported to GitLab, we will simply disable the
other CIs. But one unique list for all of them sounds a good idea,
and let the developers the freedom to subscribe to it.

Regards,

Phil.


