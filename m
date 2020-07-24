Return-Path: <SRS0=2cnN=BD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75A27C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 16:48:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3E65920674
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 16:48:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UbU9Ac5Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E65920674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37966 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jz0rf-0003wv-H1
	for qemu-devel@archiver.kernel.org; Fri, 24 Jul 2020 12:48:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56758)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jz0q7-00017p-N8
 for qemu-devel@nongnu.org; Fri, 24 Jul 2020 12:46:31 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:36090
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jz0q5-000349-Rm
 for qemu-devel@nongnu.org; Fri, 24 Jul 2020 12:46:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595609189;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=cbmibe0plmp5JYNuLagpqInl2e7ZAUbsw2RQfE109NU=;
 b=UbU9Ac5Ylhw0wNneFy+/onyd6dCRkhbmQxmjaXdTdME7xejxzRv7ajCg/6sL8q07lRQoNE
 AkB0tssDxGXgn16Q8+y/kQUYoVUFBDTBYIAHaYU73J8YO8/QFUoVDWs21KL59G4aoJsu/P
 a+25F4SqRtQgRb8jNRHLqbpFsGbM/KI=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-490-Sp-7aAuIMBi-nPtgjF9mFw-1; Fri, 24 Jul 2020 12:46:26 -0400
X-MC-Unique: Sp-7aAuIMBi-nPtgjF9mFw-1
Received: by mail-wm1-f72.google.com with SMTP id w25so2575049wmc.0
 for <qemu-devel@nongnu.org>; Fri, 24 Jul 2020 09:46:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=cbmibe0plmp5JYNuLagpqInl2e7ZAUbsw2RQfE109NU=;
 b=Gd9j3LS3y5ZZAw24IpX0Xc783bNiQ6XdhH9o+/z1QUdjVlkPNWb4xBxWefxrvtle3e
 4545NlvTVcExKaWZf5rXxG8AhmQedxlvd6aPUHIJKHfV6FviEwifodwPihMlrkaMyzlA
 kvalTIhRRy8V6lObw/cVpdi3Sig7avJ3eHJqgRAxvrtlGMrBvU5agfEMKlCliqzmp/2I
 IFtE8GK0f4LRmqxy1J1jhasL+av/JeoytScFJVNvTqP79gIlsHqU1Gj4t9/yThY6iixI
 exFsy1Aik2w2X0mNwzs+Zgq0UcPZcwheGlXnVahiI6PLQNKryxhIxGnZg2QSPVmWecj9
 Lsfw==
X-Gm-Message-State: AOAM532vuCScIL2anp4H2pkxH7JOnQaT+oRgQshgyw1lybM7Li0UgjNi
 KDTforQZog9iA6T2Jz+96gSNNOabVSDjTpAmX2N0qJrqGCCOYdBgm/Of6ZFU0rzcnOSxP4mS0Sl
 TcO4lT5g+Yb5j2J8=
X-Received: by 2002:adf:f6cb:: with SMTP id y11mr2929728wrp.169.1595609185396; 
 Fri, 24 Jul 2020 09:46:25 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyYUC9WtNI0K9uHSTxp9n1RfVwK4WUsleYzZPmHLn4fFJ3aDtl52s3E9qnpVm4JiTdwteIDwg==
X-Received: by 2002:adf:f6cb:: with SMTP id y11mr2929720wrp.169.1595609185157; 
 Fri, 24 Jul 2020 09:46:25 -0700 (PDT)
Received: from [192.168.1.33] (214.red-88-21-68.staticip.rima-tde.net.
 [88.21.68.214])
 by smtp.gmail.com with ESMTPSA id 31sm1992469wrj.94.2020.07.24.09.46.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 24 Jul 2020 09:46:24 -0700 (PDT)
Subject: Re: [PATCH 2/3] cirrus.yml: Compile macOS and FreeBSD with -Werror
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>
References: <20200724143220.32751-1-thuth@redhat.com>
 <20200724143220.32751-3-thuth@redhat.com>
 <20200724144651.GG3146350@redhat.com>
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
Message-ID: <506e2579-410e-8553-6cbf-508793bb35a0@redhat.com>
Date: Fri, 24 Jul 2020 18:46:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200724144651.GG3146350@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/24 08:23:04
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Ed Maste <emaste@freebsd.org>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Li-Wen Hsu <lwhsu@freebsd.org>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/24/20 4:46 PM, Daniel P. Berrangé wrote:
> On Fri, Jul 24, 2020 at 04:32:19PM +0200, Thomas Huth wrote:
>> Compiler warnings currently go unnoticed in our FreeBSD and macOS builds,
>> since -Werror is only enabled for Linux and MinGW builds by default. So
>> let's enable them here now, too.
>> For macOS, that unfortunately means that we have to disable the vnc-sasl
>> feature, since this is marked as deprecated in the macOS headers and thus
>> generates a lot of deprecation warnings.
> 
> I wonder if its possible to add
> 
> #pragma GCC diagnostic push
> #pragma GCC diagnostic ignored "-Wdeprecated"
> 
> ...
> 
> #pragma GCC diagnostic pop
> 
> to silence just one source file ?

3 years ago Peter said:

"The awkward part is
 that it has to  be in force at the point where the deprecated
 function is used, not where it's declared. So you can't just wrap
 the #include of the ssl header in pragmas, you'd have to either
 do it at every callsite or else over the whole .c file."

https://www.mail-archive.com/qemu-devel@nongnu.org/msg459264.html

I guess we were expecting the distrib to update the pkg.

> 
> 
> Regards,
> Daniel
> 


