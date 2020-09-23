Return-Path: <SRS0=UzyQ=DA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E223FC2D0A8
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 08:34:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4711F235FC
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 08:34:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b9UXpyKj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4711F235FC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49194 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kL0E9-0003B2-7D
	for qemu-devel@archiver.kernel.org; Wed, 23 Sep 2020 04:34:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44144)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kL0Cu-0002Mc-PH
 for qemu-devel@nongnu.org; Wed, 23 Sep 2020 04:33:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:33978)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kL0Cr-00063B-9x
 for qemu-devel@nongnu.org; Wed, 23 Sep 2020 04:32:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600849970;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=eFEY2B5IJkF3hSXzF+QMEEb2gUc9/rsp+JVylQtS7Dc=;
 b=b9UXpyKj66o/8S1fus8NQ12A3I0GDwfEbgj6PYktP0mUi1hAWsmgTo5Z0OvHWlSoVVL2js
 PkQYB5s4aB2IxvaG0MD4CKi67eGccp1+IxqTXjqujRtIQWOi2V4BtUGY+Gvl/N8Smn56Ht
 ZLFuG8HI1DGF9TURRudIC9rMHgWCLa8=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-42-tiPZ0-I4M4uJb5bv3lt0eg-1; Wed, 23 Sep 2020 04:32:48 -0400
X-MC-Unique: tiPZ0-I4M4uJb5bv3lt0eg-1
Received: by mail-wm1-f71.google.com with SMTP id t8so1085933wmj.6
 for <qemu-devel@nongnu.org>; Wed, 23 Sep 2020 01:32:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=eFEY2B5IJkF3hSXzF+QMEEb2gUc9/rsp+JVylQtS7Dc=;
 b=cBtYmU2dEBG99Zwzk3g8MOM7uKTRWynGnHjC8qv+g+Rfrz4vBJsdkRXQDsU34GvFKp
 hmAerp6wrK62jUPpfU2ADO7d+lw2VYgEn00UOkwqPLfhGGO5s5RgqqwecqfuqwlEvlTE
 YS2YX/e3OFEKBkH3smsuYd1hluFmSlOCJnSnEh8f9x88Zxbrdsu2U0Mcjs7C/kRmK/eg
 aKsNvt0uLdb/dfuuxBLU15nCoFUEAy8UnQCBXtkGi/9Cw7E6ISuLgwtL4MHghDLguusk
 L2+7OOhzLe5Cr0wbOgdTmzr5H5r+rAks8vHn43Vniqt4SF17MKJ41xXCL6sOhSpoWbeU
 5MtQ==
X-Gm-Message-State: AOAM531aGETLkIRI5nX78J4GurtnInIOonAicyQjpUxbetifp1LBzRRb
 v1xLjlg7U2nrsP+9MhlMQXTkULslOcy20aZrF4VHNtQwTBk9pGMSBM3b/Si1RfMzWKomqUq4q5x
 KME0u764rqLBEm5k=
X-Received: by 2002:a1c:ed09:: with SMTP id l9mr5220393wmh.89.1600849966854;
 Wed, 23 Sep 2020 01:32:46 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwDxsrWLwjgJxlujGQRFJf+RBMZDYUaJZBZhAOqU2cQFlimWndxB1lLRWIvKE4ds2zcckexCQ==
X-Received: by 2002:a1c:ed09:: with SMTP id l9mr5220379wmh.89.1600849966621;
 Wed, 23 Sep 2020 01:32:46 -0700 (PDT)
Received: from [192.168.1.36] (65.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.65])
 by smtp.gmail.com with ESMTPSA id n21sm7242355wmi.21.2020.09.23.01.32.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 23 Sep 2020 01:32:45 -0700 (PDT)
Subject: Re: [PATCH] docs/system/deprecated: Move lm32 and unicore32 to the
 right section
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
References: <20200923080015.77373-1-thuth@redhat.com>
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
Message-ID: <4586da8f-d5de-4edb-8d70-6bf143bc7adc@redhat.com>
Date: Wed, 23 Sep 2020 10:32:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200923080015.77373-1-thuth@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/23 00:53:58
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.455,
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
Cc: qemu-trivial@nongnu.org, Peter Maydell <peter.maydell@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/23/20 10:00 AM, Thomas Huth wrote:
> lm32 and unicore32 are softmmut targets, and not linux-user targets.

Typo "softmmu" (else it sounds like soft mammoth targets).

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  docs/system/deprecated.rst | 32 ++++++++++++++++----------------
>  1 file changed, 16 insertions(+), 16 deletions(-)
> 
> diff --git a/docs/system/deprecated.rst b/docs/system/deprecated.rst
> index 0cb8b01424..e3dcf1f149 100644
> --- a/docs/system/deprecated.rst
> +++ b/docs/system/deprecated.rst
> @@ -329,6 +329,22 @@ The ``compat`` property used to set backwards compatibility modes for
>  the processor has been deprecated. The ``max-cpu-compat`` property of
>  the ``pseries`` machine type should be used instead.
>  
> +``lm32`` CPUs (since 5.2.0)
> +'''''''''''''''''''''''''''
> +
> +The ``lm32`` guest CPU support is deprecated and will be removed in
> +a future version of QEMU. The only public user of this architecture
> +was the milkymist project, which has been dead for years; there was
> +never an upstream Linux port.
> +
> +``unicore32`` CPUs (since 5.2.0)
> +''''''''''''''''''''''''''''''''
> +
> +The ``unicore32`` guest CPU support is deprecated and will be removed in
> +a future version of QEMU. Support for this CPU was removed from the
> +upstream Linux kernel, and there is no available upstream toolchain
> +to build binaries for it.
> +
>  System emulator devices
>  -----------------------
>  
> @@ -408,22 +424,6 @@ The above, converted to the current supported format::
>  linux-user mode CPUs
>  --------------------
>  
> -``lm32`` CPUs (since 5.2.0)
> -'''''''''''''''''''''''''''
> -
> -The ``lm32`` guest CPU support is deprecated and will be removed in
> -a future version of QEMU. The only public user of this architecture
> -was the milkymist project, which has been dead for years; there was
> -never an upstream Linux port.
> -
> -``unicore32`` CPUs (since 5.2.0)
> -''''''''''''''''''''''''''''''''
> -
> -The ``unicore32`` guest CPU support is deprecated and will be removed in
> -a future version of QEMU. Support for this CPU was removed from the
> -upstream Linux kernel, and there is no available upstream toolchain
> -to build binaries for it.
> -
>  ``tilegx`` CPUs (since 5.1.0)
>  '''''''''''''''''''''''''''''
>  
> 


