Return-Path: <SRS0=KdPs=AG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65296C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 10:22:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F08E820679
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 10:22:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FjvIjKvM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F08E820679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50640 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joP1s-0001SI-15
	for qemu-devel@archiver.kernel.org; Thu, 25 Jun 2020 06:22:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35840)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1joP1C-0000rY-Bx
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 06:22:06 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:23248
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1joP1A-0005VE-N0
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 06:22:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593080524;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=Np/KBW8DfZW/BRX2Me1bSOcVr+2F/KNwrqXtrj9yMIM=;
 b=FjvIjKvM6OPNxbFlerghGkQYlovOYlaMU2h6auRgHFUpqvK4OSDY4OyCxa9jFUnsPBQIry
 Joj5azfpHZkuQQLQa/bUAzj8j5KdQergctEcxpxTnwHRsZiCNhXr0q/uR37gjIRC4EfLaX
 wcd4LYgBPTJuVsaAKNMfD80tJU3Q8mM=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-211--ZqOY4qMNtW4VIT9KyvJFw-1; Thu, 25 Jun 2020 06:22:02 -0400
X-MC-Unique: -ZqOY4qMNtW4VIT9KyvJFw-1
Received: by mail-wm1-f69.google.com with SMTP id a7so6517982wmf.1
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2020 03:22:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=Np/KBW8DfZW/BRX2Me1bSOcVr+2F/KNwrqXtrj9yMIM=;
 b=BnGGDwhUjS699uXEbuEnYvU4/y1R6uClfCwbluoSCyTXhzMNjRHHWFXMvkYGMDREpG
 7dj3F64Pf/R16rtgflPYAlhKQkocqxNVWJ2zYzNA/isQNosnv5HD736RT72cGlTzkMGu
 doyKxEO/Xn/j2nh6Oyi1SyBHr2N+un+YnbqHt6zseu4+8GdKOQgJZdOgHCpK7pqBgB3L
 /mwQsOnMFgrgQUKuJBsE4qDyge6UCdNYNqMra8p//IuTnB7WYDxgAo1Yo4pug6iZQQVN
 PiCC+dc2oXvL4VCPhNXvk0Q9SJ7C9CIMpbqAhwr9HGO//AI6F6w03xtDwu3bYRpoDWi0
 rryA==
X-Gm-Message-State: AOAM531iSAJCK2ZFppzU+ofipgCo93p4Fl3Bq7HoSDx4K8n9ZR3VdiSy
 Uey/JhE+yU0Cqov/91KOHw9G/TIfmj3CK2fRqs7Ex6390p+nhgj9h69z6yT8GEkUL1XDbWeNody
 7lcnj4vLl6CoqG5I=
X-Received: by 2002:a5d:4bc8:: with SMTP id l8mr20277666wrt.159.1593080521070; 
 Thu, 25 Jun 2020 03:22:01 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwU6kzcIQy4qm6VvH/088Y6YpgvitKrsIpvunTL53oSfs+5lVLe0v2F3sqlSBPWPmZP6CGhhw==
X-Received: by 2002:a5d:4bc8:: with SMTP id l8mr20277649wrt.159.1593080520917; 
 Thu, 25 Jun 2020 03:22:00 -0700 (PDT)
Received: from [192.168.1.40] (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id a12sm20984625wrv.41.2020.06.25.03.21.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 25 Jun 2020 03:22:00 -0700 (PDT)
Subject: Re: [PATCH v2 7/9] tz-ppc: add dummy read/write methods
To: P J P <ppandit@redhat.com>
References: <20200624185523.762240-1-ppandit@redhat.com>
 <20200624185523.762240-8-ppandit@redhat.com>
 <7ffe6cd9-fc23-3fdf-6c57-7bb0af0dd030@redhat.com>
 <nycvar.YSQ.7.77.849.2006251427210.92950@xnncv>
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
Message-ID: <86ed036e-cbf1-834d-59d9-af6db7b750ef@redhat.com>
Date: Thu, 25 Jun 2020 12:21:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <nycvar.YSQ.7.77.849.2006251427210.92950@xnncv>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/25 02:30:11
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Li Qiang <liq3ea@gmail.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Lei Sun <slei.casper@gmail.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/25/20 11:18 AM, P J P wrote:
> +-- On Thu, 25 Jun 2020, Philippe Mathieu-Daudé wrote --+
> | > @@ -196,7 +196,22 @@ static bool tz_ppc_dummy_accepts(void *opaque, hwaddr addr,
> | >      g_assert_not_reached();
> | 
> | This is a shame we now have to fill the read/write handlers for
> | unreachable code :( 
> |
> | > +static uint64_t tz_ppc_dummy_read(void *opaque, hwaddr addr, unsigned size)
> | 
> | I'd instead use a clearer:
> |        g_assert_not_reached();
> | 
> | > +static void tz_ppc_dummy_write(void *opaque, hwaddr addr,
> | 
> | Ditto:
> |        g_assert_not_reached();
> 
> This will likely be called in tz_ppc_dummy_accepts() above. Do we still want 
> to revise this patch? considering read/write callbacks are unreachable.

So a simple comment in each read/write might be sufficient (removing the
qemu_log_mask calls).


