Return-Path: <SRS0=Z/nf=BQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7189DC433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 21:43:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 568B2221E2
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 21:43:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RQZ+GOXn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 568B2221E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36158 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3nf9-0001rF-Hu
	for qemu-devel@archiver.kernel.org; Thu, 06 Aug 2020 17:42:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46952)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k3neZ-0001Py-1f
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 17:42:23 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:55773
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k3neW-0007vC-6K
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 17:42:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596750138;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=gCd7ZnaEHsbVqEVA6/j/7uKWTnK8Rib0bj8XMTA6Oew=;
 b=RQZ+GOXnIP9bqnRR34XAHEobSbCvlgS4AcJ1WOeheKRFVckp5ndjXlreprYmBQN6g2bG4w
 qUCaJNdtTKbLbyBTX1t6eB0i4TUdGf1bLIzoKH1mEUsyqeDs6fJcSPljEIn+30IupW9VM1
 G455Cv9q8tT7+//wi3vAzr4XrqXpZlw=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-276-t039HH1RMBuZMRdyv9NMRA-1; Thu, 06 Aug 2020 17:42:16 -0400
X-MC-Unique: t039HH1RMBuZMRdyv9NMRA-1
Received: by mail-wm1-f71.google.com with SMTP id u144so4604621wmu.3
 for <qemu-devel@nongnu.org>; Thu, 06 Aug 2020 14:42:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=gCd7ZnaEHsbVqEVA6/j/7uKWTnK8Rib0bj8XMTA6Oew=;
 b=oCjkUmtQait8f8GW0yePJT0Frg0QQo01W2obI/eMotblAmtXsJmuWRvFpcya9C/Jcw
 jLxXtAvFBNXffBtQYvLhV2p+yAjjDkAqW6956LGUt51Kc2CzFyo8dkBqmPXmFqCQfCrz
 yLE0lCsLD+mn/kbqH7hR7hevFzJgLYDzni8rcwNWLqid4Y7SWS04CNwYOGKqZb+KcbZE
 tncDeWBJWBfuecwwOYK9WTp8/PnN+EuoYiD429K5G07v5ncj3rI5YC3dk/UDIMAUv0kH
 +DjThy1Fw0r/bheN48x0/WWNXRM/dKRvf+ezX+KJtTsXLdyDQs3hDkMQUNE9LRJctihb
 Ddyg==
X-Gm-Message-State: AOAM533JVJ0cERKc30WjxNmBthLvA5QBN/+b+uEKREjMG9qDyXraPDtB
 mHQJqPp2vCYc9jlc0x18iEu3bd7J7ABgt3KVtX/3MaF9F03V3LCJp0ZXLO+zcXWlRpa1Me+4a+l
 Rvk5Onw29f6ST77c=
X-Received: by 2002:adf:bb14:: with SMTP id r20mr9065907wrg.366.1596750135418; 
 Thu, 06 Aug 2020 14:42:15 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz7D9RNzABGA7b0d/FoKnHi9q4iz0ddw3Zfhf35+UEMAqtTIvlc/9vZWaEDvTP8NYw0g6We0w==
X-Received: by 2002:adf:bb14:: with SMTP id r20mr9065891wrg.366.1596750135153; 
 Thu, 06 Aug 2020 14:42:15 -0700 (PDT)
Received: from [192.168.1.36] (121.red-81-40-121.staticip.rima-tde.net.
 [81.40.121.121])
 by smtp.gmail.com with ESMTPSA id c17sm8107071wrc.42.2020.08.06.14.42.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 06 Aug 2020 14:42:14 -0700 (PDT)
Subject: Re: [PATCH 108/143] meson: convert hw/intc
To: Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
References: <1596741379-12902-1-git-send-email-pbonzini@redhat.com>
 <1596741379-12902-109-git-send-email-pbonzini@redhat.com>
 <CAFEAcA_j2N1ee3Aqjcw3cKF1ksJ9Ls4qF6eXBH058A8oNBObfw@mail.gmail.com>
 <CABgObfYry+2he0aL_UujxaSCTNELQL+mbtD8GYc_R4b1H94x8g@mail.gmail.com>
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
Message-ID: <0dc20c58-42af-e50f-4e76-1c72a33dacea@redhat.com>
Date: Thu, 6 Aug 2020 23:42:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <CABgObfYry+2he0aL_UujxaSCTNELQL+mbtD8GYc_R4b1H94x8g@mail.gmail.com>
Content-Language: en-US
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/06 00:24:10
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
Cc: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/6/20 11:20 PM, Paolo Bonzini wrote:
> 
> 
> Il gio 6 ago 2020, 23:02 Peter Maydell <peter.maydell@linaro.org
> <mailto:peter.maydell@linaro.org>> ha scritto:
> 
>     On Thu, 6 Aug 2020 at 21:10, Paolo Bonzini <pbonzini@redhat.com
>     <mailto:pbonzini@redhat.com>> wrote:
>     >
>     > From: Marc-André Lureau <marcandre.lureau@redhat.com
>     <mailto:marcandre.lureau@redhat.com>>
>     >
>     > Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com
>     <mailto:marcandre.lureau@redhat.com>>
>     > Signed-off-by: Paolo Bonzini <pbonzini@redhat.com
>     <mailto:pbonzini@redhat.com>>
> 
>     Compared to:
> 
>     > -common-obj-$(CONFIG_HEATHROW_PIC) += heathrow_pic.o
> 
>     > +softmmu_ss.add(when: 'CONFIG_HEATHROW_PIC', if_true:
>     files('heathrow_pic.c'))
> 
>     this feels pretty clunky. Doesn't Meson have a nicer
>     way of expressing this kind of thing? 

Don't forget we also use:

HELPERS-$(call land,$(CONFIG_SOFTMMU),$(CONFIG_LINUX)) +=
qemu-bridge-helper$(EXESUF)
ifeq ($(CONFIG_LINUX)$(CONFIG_VIRGL)$(CONFIG_GBM)$(CONFIG_TOOLS),yyyy)
HELPERS-y += vhost-user-gpu$(EXESUF)
vhost-user-json-y += contrib/vhost-user-gpu/50-qemu-gpu.json
endif

> 
> 
> Nope, in fact it turns out we had to implement it ourselves because
> there was no way to express it at all in the way that QEMU build
> multiple binaries. My initial version didn't have the when/if_true part
> but the maintainer was quite adamant on requiring them instead of just
> relying on positional arguments.
> 
> Unfortunately, while common in QEMU, and in Linux too, it doesn't seem
> to be a very common idiom in general; Makefiles do express it in a very
> readable and concise way.
> 
> I cannot deny it looks clunky. While Meson does have a huge advantage in
> terms of predictability and lack of surprises when doing harder things,
> the imperative syntax is heavier when dealing with the simplest. They do
> remain simple (it's still one line of coffee), but the quotes and commas
> seem to be enough to "switch" our brain to a different mode.
> 
> My opinion is that you don't really look at these things very much, so
> it doesn't really matter, but I can see people disagreeing.
> 
> (You had already pointed this out during the very first discussions, if
> I remember correctly. I can't add much except that with extra experience
> the balance does tilt in favor of Meson despite the heavier syntax for
> simple cases).
> 
> Paolo
> 
>     It's really
>     common and I'd hope that a build system language
>     would provide less long-winded ways to write common
>     operations...
> 
>     thanks
>     -- PMM
> 


