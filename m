Return-Path: <SRS0=afRr=CX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EA3AC433E2
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 10:54:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB77920829
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 10:53:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b+J4K+3u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB77920829
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48888 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kHm7S-0006n0-Tm
	for qemu-devel@archiver.kernel.org; Mon, 14 Sep 2020 06:53:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40406)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kHm6d-0005lV-Ry
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 06:53:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:39240)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kHm6b-00043R-VW
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 06:53:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600080785;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=2CZNSI3F+NLY37OZHZ6G0S1NMPMavrd2JAop5LfGlxg=;
 b=b+J4K+3uUetS+10OhA8cS/E0cdkjjekLjHLFEAn9aJlhOr0Vy8xhz3TP34e5KuUqR8SWq4
 o9PrN6h+gq+6voG6VfUbZlqwn35xx+Jta3D4OsG24/fTwb8NkBrTeLe0nngEbVPEKAUFH0
 aUJa7Bn6ewt+bc2o40/rr9s6pRt+1rQ=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-574-KvRgYejiMzWnrf6AjqnXkQ-1; Mon, 14 Sep 2020 06:53:03 -0400
X-MC-Unique: KvRgYejiMzWnrf6AjqnXkQ-1
Received: by mail-wm1-f72.google.com with SMTP id a7so2337793wmc.2
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2020 03:53:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=2CZNSI3F+NLY37OZHZ6G0S1NMPMavrd2JAop5LfGlxg=;
 b=MYMGZ0JcH1DFnBWIAGlQVqpJ6d55N91T1xdFbJR+aOBl7xBzkyG9D3Lj4QqkrWA9mp
 KgM6PhjzBI3+luiMMShlzlsWFJkfVgXfzOCWkvJdpkDwtagejsmHGsUJAfkTtIIHe3pT
 qk4hPQG8AwxDLxXS6Eco/KrGEAPzoB8DWtQk1eTvW4F+TFhkMytj1Wp4jaZusKvpTb9f
 EIfqbGfwpSjPTTEBVnajbutkKeVsIDhumExKVSh9DcqbBKa2sSAcAMyIXnxghMizl5Vh
 byI6Dutdxz9O8ukd7jPi9WKMq8cgri0xgCgaTKBz0D3lt3fgfiqUX7ClSykeCMe/P0DS
 2dlg==
X-Gm-Message-State: AOAM531zXp2ExQ9ahnLxlWUySs7h+ewnhl1ccExadxZdRMVG8/2Aoo7X
 X7D4E/7ZXqx/CK6ZMjpY5VLNHU09+jdDt83wGmDN+9Hd/KGKx/YJzg9nsCxM0vpauF3JqYXT8Vo
 C2DV2fz7ICIaunDc=
X-Received: by 2002:a7b:ce96:: with SMTP id q22mr13650361wmj.132.1600080782368; 
 Mon, 14 Sep 2020 03:53:02 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx/iqkQsLnAtuS11dd8nnRSKZdvssXO0oNe0EOjPf0L7Xw9z+mG4TPSZC2jHu2aBAWpuxRoLw==
X-Received: by 2002:a7b:ce96:: with SMTP id q22mr13650338wmj.132.1600080782110; 
 Mon, 14 Sep 2020 03:53:02 -0700 (PDT)
Received: from [192.168.1.36] (65.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.65])
 by smtp.gmail.com with ESMTPSA id 97sm20439342wrm.15.2020.09.14.03.53.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 14 Sep 2020 03:53:01 -0700 (PDT)
Subject: Re: [PATCH 08/10] pc-bios: refresh edk2 build artifacts for
 edk2-stable202008
To: Gerd Hoffmann <kraxel@redhat.com>
References: <20200908072939.30178-1-lersek@redhat.com>
 <20200908072939.30178-9-lersek@redhat.com>
 <b2037644-bf48-e86f-23e3-f2c68e7ddc1f@redhat.com>
 <20200914095438.wkc2fou3ijrctmfl@sirius.home.kraxel.org>
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
Message-ID: <a1ec5724-bebd-3fe7-a1a2-db8065266feb@redhat.com>
Date: Mon, 14 Sep 2020 12:53:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200914095438.wkc2fou3ijrctmfl@sirius.home.kraxel.org>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Received-SPF: pass client-ip=63.128.21.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/14 02:55:39
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.792,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
Cc: Thomas Huth <thuth@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>,
 Laszlo Ersek <lersek@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>,
 qemu devel list <qemu-devel@nongnu.org>, Bruce Rogers <brogers@suse.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

+Michael & Bruce

On 9/14/20 11:54 AM, Gerd Hoffmann wrote:
>   Hi,
> 
>> The CI idea is to have reproducible builds if possible.
>> When the submodule is updated (or the QEMU scripts containing the
>> -D defines), it triggers the 'build-edk2' job which produce these
>> same binaries.
>> My original idea was to push the tag on GitLab that triggers the
>> job, then download the produced binaries, test them, then commit
>> them.
> 
> Now with CI in place we maybe should step back and have a look at the
> big picture.
> 
> Should we simply stop committing firmware binaries into git and provide
> them as CI artifacts instead?

What I'm not sure about is how to keep the built artifacts forever.
Usually git-forge based projects keep release builds forever.
In our case we are interested in updating them during the development
window, to be well tested on release.

Also we need to modify the source tarball generator script to fetch
the artifacts and include them, isn't it?

>  Can we build all our firmware in CI,
> using the shared gitlab x86 runners and cross compilers?

I'm pretty sure. In case something is missing, adding it shouldn't
be a problem anyway.

Regards,

Phil.


