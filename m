Return-Path: <SRS0=FSHi=DM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 758CEC4363A
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2020 08:09:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D15A820774
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2020 08:09:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VtE9UZKA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D15A820774
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60642 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPLYb-0007N0-He
	for qemu-devel@archiver.kernel.org; Mon, 05 Oct 2020 04:09:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33100)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kPLXA-0006Oc-FS
 for qemu-devel@nongnu.org; Mon, 05 Oct 2020 04:07:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:20143)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kPLX7-00058p-BN
 for qemu-devel@nongnu.org; Mon, 05 Oct 2020 04:07:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601885264;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=hFokf7VtIUajpwgQMfOnv7bWuVtWqGGh1Q951fJ0rAo=;
 b=VtE9UZKAbfwuFHQvi1kyHVntIO78PqeUW/GArnKuDVYH6e+vyW7bflJXH9o7AJL9X8HlA6
 Cw5NGXqsFZNqEPAmIw9Y+s0+Bx3nJlexzyNfYWKksMqDcsPoBWhE0QGHOAdquiBzdJJj/d
 JQTlK+6ZvgUtfq08yJMbgJxpWTusk58=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-5-TKyqVR2YMWyIjvgv_xEDxA-1; Mon, 05 Oct 2020 04:07:41 -0400
X-MC-Unique: TKyqVR2YMWyIjvgv_xEDxA-1
Received: by mail-wr1-f69.google.com with SMTP id v12so3690099wrm.9
 for <qemu-devel@nongnu.org>; Mon, 05 Oct 2020 01:07:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=hFokf7VtIUajpwgQMfOnv7bWuVtWqGGh1Q951fJ0rAo=;
 b=ggsO49v398zPnrPCUYwf1LsRsju/hqCwZGlNkKM/0vYT7BbFw1za1UNKPuo1CFqheM
 OzrhqGNQhSeeoWT2r7WaZaLiGxH6K2Ou6IcrMiV55cZqXpWtbPVLOHUud7xF2xz3RUG6
 ertbQPLsdSyuWLOxOFv+tARecUkHHNwtXo0pMrkkZHhk46wVPRAdowgMemFZjaFP6XOU
 mqTYv6cfD5WVivUcu5LlThJK4lcof+0XoVWxXF3WlLYIzF6c9c9Mc4cCC3AI1d2IelF6
 W033vNbDmNN16vOc3d28y8yf4EnnhJDEDqor4Mij3EGTfr5Rgle59CJhx7CLYOed3CV7
 UQvg==
X-Gm-Message-State: AOAM533VY1aUokzFrZJW5TtTZmq6HXzY7mUojHvBK3fVTOEnZZsuPG15
 wI1D7EqIcidYnMYPMOOkCIdhhOLuSFI1hp5eODs6x7oS+jlrwQxY5vI2WIxgcFWDmbinBxEJEsk
 3hFIN/dIiDEcd8qw=
X-Received: by 2002:adf:b306:: with SMTP id j6mr15539447wrd.279.1601885260311; 
 Mon, 05 Oct 2020 01:07:40 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJziHheQ7zeUhvE+rEXoTxJzOeZ6VhGtpoxTHhHN+gu2V2aXA7d9oXQM4xXvoB7tpw3yjOd/LQ==
X-Received: by 2002:adf:b306:: with SMTP id j6mr15539431wrd.279.1601885260112; 
 Mon, 05 Oct 2020 01:07:40 -0700 (PDT)
Received: from [192.168.1.36] (106.red-83-59-162.dynamicip.rima-tde.net.
 [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id b11sm11911725wrt.38.2020.10.05.01.07.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 05 Oct 2020 01:07:39 -0700 (PDT)
Subject: Re: [PATCH v2] tests/boot_linux_console: Boot Trusted Firmware-A on
 the Raspberry Pi 3
To: qemu-devel@nongnu.org
References: <20200217103442.30318-1-f4bug@amsat.org>
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
Message-ID: <79e2fbbc-2afb-5cef-2af6-4664679b8745@redhat.com>
Date: Mon, 5 Oct 2020 10:07:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200217103442.30318-1-f4bug@amsat.org>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/05 02:11:31
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.745,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1,
 RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
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
Cc: qemu-arm@nongnu.org, pete@akeo.ie, Luc Michel <luc.michel@greensocs.com>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/17/20 11:34 AM, Philippe Mathieu-Daudé wrote:
> This test runs Trusted Firmware-A on the Raspberry Pi 3.
> We deliberately stop the boot process when the EDK2 UEFI version
> is displayed.
> 
> The binary is build on AppVeyor CI using Pete Batard repository [1].
> ATF v2.1 binary are used (see [2]). Extra documentation in [3].
> 
> It is very simple and fast:
> 
>   $ avocado --show=app,console run -t atf tests/acceptance
>   JOB ID     : 1e748d7c9e9011cf0af3250ddc8ebf2389d6204e
>   JOB LOG    : avocado/job-results/job-2020-02-16T18.08-1e748d7/job.log
>    (1/1) tests/acceptance/boot_linux_console.py:BootLinuxConsole.test_aarch64_raspi3_atf:
>   console: NOTICE:  Booting Trusted Firmware
>   console: NOTICE:  BL1: v2.1(release):v2.1
>   console: NOTICE:  BL1: Built : 15:26:06, May 13 2019
>   console: NOTICE:  rpi3: Detected: Raspberry Pi 3 Model B (1GB, Sony, UK) [0x00a02082]
>   console: NOTICE:  BL1: Booting BL2
>   console: ERROR:   rpi3_sdhost: timeout status 0x40
>   console: NOTICE:  BL2: v2.1(release):v2.1
>   console: NOTICE:  BL2: Built : 15:26:01, May 13 2019
>   console: NOTICE:  BL1: Booting BL31
>   console: NOTICE:  BL31: v2.1(release):v2.1
>   console: NOTICE:  BL31: Built : 15:26:04, May 13 2019
>   console: =UEFI firmware (version UEFI Firmware v1.15 built at 11:58:44 on Feb 14 2020)
>   PASS (1.54 s)
>   RESULTS    : PASS 1 | ERROR 0 | FAIL 0 | SKIP 0 | WARN 0 | INTERRUPT 0 | CANCEL 0
>   JOB TIME   : 1.88 s
> 
> [1] https://github.com/pbatard/RPi3#summary
> [2] https://github.com/ARM-software/arm-trusted-firmware/blob/v2.1/docs/plat/rpi3.rst
> [3] http://www.skylyrac.net/2018-02-01-port-arm-tf-to-rpi3.html
> 
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
> v2: Start with a single core powered-on
> ---
>  tests/acceptance/boot_linux_console.py | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)

Thanks, applied to my acceptance-testing tree.


