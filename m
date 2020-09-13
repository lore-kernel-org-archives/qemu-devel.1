Return-Path: <SRS0=H3r+=CW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3E19C433E2
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Sep 2020 15:36:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5FEAC2078D
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Sep 2020 15:36:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OYHEDE+s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5FEAC2078D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60500 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kHU39-00042g-99
	for qemu-devel@archiver.kernel.org; Sun, 13 Sep 2020 11:36:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49998)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kHU27-0003QR-0q
 for qemu-devel@nongnu.org; Sun, 13 Sep 2020 11:35:15 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:53205
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kHU25-0006T1-5I
 for qemu-devel@nongnu.org; Sun, 13 Sep 2020 11:35:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600011310;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=yM7jVwC1ENpyKho6fnOSaM5sgV6RYyNF6jPuyGz5RrI=;
 b=OYHEDE+sl51skK6EXQFWYp6ITrdP8gOBev5o2JbbHBuP66CPIFaU9g6/dujTT/UjdDwF1u
 YCxJ2EEUwESWZuaJjbvHJ4T5KA2KRk0vyMMJmwV1ITDeb+nX3is3AqGBvtPJcqdmbdyyS/
 L73hjb5N4d7VbdpWGMyopCb9b9r1hXI=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-480-sgpkNsaIMJCjLib1pX2idw-1; Sun, 13 Sep 2020 11:35:07 -0400
X-MC-Unique: sgpkNsaIMJCjLib1pX2idw-1
Received: by mail-wr1-f69.google.com with SMTP id r15so5665813wrt.8
 for <qemu-devel@nongnu.org>; Sun, 13 Sep 2020 08:35:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=yM7jVwC1ENpyKho6fnOSaM5sgV6RYyNF6jPuyGz5RrI=;
 b=fHmyh3ibgBwI3sOrE/4fAKCQbph/k/LZIyHpl1OBgqCZ1wlKTcdo3q5fzVLX3+1/Rt
 lhihNkbcfWycbd9x4oB4T3GFJC2YDeVs2hPY7A74xlqR0EixWCB85SdYzBXsUJu6T9nS
 GKtNgd9OF51mlchx1MioRE54aLtz85nyRXi3P5U16uT+8+bK9V6M+JSxcNRBOqv6Fm0h
 1/L4EYf+QBCgIRC6/R7AtmvFuiFeRmPJDFYdQCinlEVQyV2+ckVrIpU8Bh9zYRmoX6mL
 J2fPmoJjr6HbLp6833B8LHFgq7Y2qZQ2Be2NzJGrnOo5rHd8rwGPQsQlSGPkTXTa+zAb
 wa4Q==
X-Gm-Message-State: AOAM530k4VlH3AfU9ANl7iU5pIWMXUAU42OWBZOmwspeWqFaJtLk8ST7
 mOVQabuoWTyyf3NiLQZRSbR8Q+BnRZXOo/zXVe3UmsTLLr6GFuUSfVERbABKhmq5F2jKM+PLMo0
 pEECiM2+7+375xl0=
X-Received: by 2002:a05:600c:230c:: with SMTP id
 12mr10918685wmo.23.1600011306196; 
 Sun, 13 Sep 2020 08:35:06 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzIx0gvjawSPX4L+ewyWgQF1Zof8Z47odsKxgzm3F5Zc0HKJbnE4B91ctgw0gFBqAyG9CQx8Q==
X-Received: by 2002:a05:600c:230c:: with SMTP id
 12mr10918668wmo.23.1600011306036; 
 Sun, 13 Sep 2020 08:35:06 -0700 (PDT)
Received: from [192.168.1.36] (65.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.65])
 by smtp.gmail.com with ESMTPSA id n14sm14839648wmi.33.2020.09.13.08.35.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 13 Sep 2020 08:35:05 -0700 (PDT)
Subject: Re: [PATCH v8 11/27] meson: Use -b to ignore CR vs. CR-LF issues on
 Windows
To: Yonggang Luo <luoyonggang@gmail.com>, qemu-devel@nongnu.org
References: <20200912224431.1428-1-luoyonggang@gmail.com>
 <20200912224431.1428-12-luoyonggang@gmail.com>
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
Message-ID: <c6ed5abf-2c71-bded-7efc-33baa0b415af@redhat.com>
Date: Sun, 13 Sep 2020 17:35:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200912224431.1428-12-luoyonggang@gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Received-SPF: pass client-ip=205.139.110.61; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/13 11:28:09
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.695,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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
Cc: Kevin Wolf <kwolf@redhat.com>, Ed Maste <emaste@freebsd.org>,
 qemu-block@nongnu.org, Stefan Weil <sw@weilnetz.de>,
 Xie Changlong <xiechanglong.d@gmail.com>, Peter Lieven <pl@kamp.de>,
 Michael Roth <mdroth@linux.vnet.ibm.com>,
 Markus Armbruster <armbru@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Wen Congyang <wencongyang2@huawei.com>,
 =?UTF-8?Q?Daniel_P_=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Max Reitz <mreitz@redhat.com>, Li-Wen Hsu <lwhsu@freebsd.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/13/20 12:44 AM, Yonggang Luo wrote:
> On windows, a difference in line endings causes testsuite failures
> complaining that every single line in files such as
> 'tests/qapi-schemadoc-good.texi' is wrong.  Fix it by adding -b to diff.

Isn't '--strip-trailing-cr' more adapted?

> 
> Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
> Reviewed-by: Eric Blake <eblake@redhat.com>
> Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>  tests/qapi-schema/meson.build | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tests/qapi-schema/meson.build b/tests/qapi-schema/meson.build
> index c87d141417..f1449298b0 100644
> --- a/tests/qapi-schema/meson.build
> +++ b/tests/qapi-schema/meson.build
> @@ -220,6 +220,6 @@ qapi_doc = custom_target('QAPI doc',
>  
>  # "full_path()" needed here to work around
>  # https://github.com/mesonbuild/meson/issues/7585
> -test('QAPI doc', diff, args: ['-u', files('doc-good.texi'), qapi_doc[0].full_path()],
> +test('QAPI doc', diff, args: ['-b', '-u', files('doc-good.texi'), qapi_doc[0].full_path()],
>       depends: qapi_doc,
>       suite: ['qapi-schema', 'qapi-doc'])
> 


