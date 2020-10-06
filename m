Return-Path: <SRS0=+uBF=DN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96E32C41604
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Oct 2020 11:27:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1279120760
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Oct 2020 11:27:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ephnDZzI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1279120760
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43174 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPl7z-0002iL-43
	for qemu-devel@archiver.kernel.org; Tue, 06 Oct 2020 07:27:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36390)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kPl1m-0003q5-EH
 for qemu-devel@nongnu.org; Tue, 06 Oct 2020 07:21:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:54999)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kPl1k-0006QN-GA
 for qemu-devel@nongnu.org; Tue, 06 Oct 2020 07:21:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601983263;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=XMFdEwehuIxHUwt7jU/ZInvyJcmwXDf3H2RxuwKFXpA=;
 b=ephnDZzIP1zooUReog1sQ4tjkwl2sdTptJLZICCdmw0loIC6Dzj3ZIhO9ruNdR2oe1IXbf
 97mWP2O3ZKtWkjpfo2mBrTd0jqaoDPL5w+MJwb13wKfbfA9sUuuuODpXtfMkIvuxXHv16U
 F5sv4S1C4Vmi8tAdwLHKH3DBYUuLj20=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-578-89vy08YjNfOuqxASm8zu3w-1; Tue, 06 Oct 2020 07:20:56 -0400
X-MC-Unique: 89vy08YjNfOuqxASm8zu3w-1
Received: by mail-wm1-f71.google.com with SMTP id d76so987101wmd.8
 for <qemu-devel@nongnu.org>; Tue, 06 Oct 2020 04:20:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=XMFdEwehuIxHUwt7jU/ZInvyJcmwXDf3H2RxuwKFXpA=;
 b=lEmSaVtVFgKrjqDdiCVR5w0V0gaVXhidMZDOGfdhrNnLMpLHhuxCZX0GJF3wxo+rjj
 yEizUsZuoeynMEKkYAIdYei3r8Xt0l+S0aG1aqfyEXpO7HyfRpKOQ593/4oyvLJmLftA
 PkRnlGPpCSEDjgw1Ef8LK6vUA5Xq4MaUTpPLR+E4Q8a+SlkLtFQgg3DJpDhlThBZ34F2
 71agB/nhvXuAWHTRfMMQe4yuNKiAezp/gYoiYh9tsj80m0CZrGUya7ZtD80kkEv5WbCo
 v4uMkFnPyIX51AH7ZCpDVU8YaFLXaCsruOqjCG42tZsaWb4wQre35E6G2xw8BaNBZ0jd
 UfBQ==
X-Gm-Message-State: AOAM531lhQRZUafZZw28MGB6az4qnHvGuGtgHbqryid78vdt2kf9NZJz
 Y/1ij60mKDpKUVmI3VR1u2IimH/tafU/nI7H+RnC+zU+a/+9LPTIlgo1+/Bp8CllwT8gFLsC6EP
 NDeFBktHNjAaqs+4=
X-Received: by 2002:a1c:19c1:: with SMTP id 184mr4483679wmz.114.1601983255368; 
 Tue, 06 Oct 2020 04:20:55 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwvThJeZzk3OR6MjXWE4qdO/qnDEusp5GPIYQBFy9CSqwVidx4q3O9UJqCteCjd3ZumATeSkA==
X-Received: by 2002:a1c:19c1:: with SMTP id 184mr4483657wmz.114.1601983255216; 
 Tue, 06 Oct 2020 04:20:55 -0700 (PDT)
Received: from [192.168.1.36] (106.red-83-59-162.dynamicip.rima-tde.net.
 [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id k8sm3979598wrl.42.2020.10.06.04.20.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 06 Oct 2020 04:20:54 -0700 (PDT)
Subject: Re: [PATCH v2 3/3] MAINTAINERS: add Kevin Wolf as storage daemon
 maintainer
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
References: <20200910144400.69615-1-stefanha@redhat.com>
 <20200910144400.69615-4-stefanha@redhat.com>
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
Message-ID: <ac5eb4fd-3a65-2aae-f40d-40b1ffb19537@redhat.com>
Date: Tue, 6 Oct 2020 13:20:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200910144400.69615-4-stefanha@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/06 01:55:55
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.733,
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 qemu-block@nongnu.org, Kashyap Chamarthy <kchamart@redhat.com>,
 afrosi@redhat.com, Markus Armbruster <armbru@redhat.com>,
 Laszlo Ersek <lersek@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/10/20 4:44 PM, Stefan Hajnoczi wrote:
> The MAINTAINERS file was not updated when the storage daemon was merged.
> 
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  MAINTAINERS | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 7d0a5e91e4..eb80b6c548 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2099,6 +2099,15 @@ F: qobject/block-qdict.c
>  F: tests/check-block-qdict.c
>  T: git https://repo.or.cz/qemu/kevin.git block
>  
> +Storage daemon
> +M: Kevin Wolf <kwolf@redhat.com>
> +L: qemu-block@nongnu.org
> +S: Supported
> +F: storage-daemon/
> +F: docs/interop/qemu-storage-daemon-qmp-ref.texi
> +F: docs/tools/qemu-storage-daemon.rst
> +T: git https://repo.or.cz/qemu/kevin.git block
> +
>  Block I/O path
>  M: Stefan Hajnoczi <stefanha@redhat.com>
>  M: Fam Zheng <fam@euphon.net>
> 

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
=)


