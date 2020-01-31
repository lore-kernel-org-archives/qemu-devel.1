Return-Path: <SRS0=aXOp=3U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57415C33C9E
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2020 02:11:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 238A9206F0
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2020 02:11:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VM7OMU8k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 238A9206F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47586 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ixLmM-0003GM-DV
	for qemu-devel@archiver.kernel.org; Thu, 30 Jan 2020 21:11:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50847)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1ixLle-0002eB-MD
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 21:10:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1ixLlc-0000mm-5W
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 21:10:45 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:53933
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1ixLlc-0000lG-1o
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 21:10:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580436643;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=N6ayk/ft5wsmfKUBydtbk6VT0gvwHB29Ch32NVXJQJM=;
 b=VM7OMU8kfvtVGWn3xWnwPT52Z/HfJ0uhPzbI/30lowp5xscnQ+QWkps3MY8B1Jq5U5Egs8
 SjKKb8sqB4JD6jqaR0+cDTqA/LrHzA0Fy47mAFS7Topfj+/EeonJuGCFmrzeSMNtfbkW5s
 C46gzoghnS5AJ/0Zb22f7j6c0VAZjXA=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-299-m368kySOMU2xOuUAiXW7Fw-1; Thu, 30 Jan 2020 21:10:39 -0500
Received: by mail-wm1-f70.google.com with SMTP id p5so2154730wmc.4
 for <qemu-devel@nongnu.org>; Thu, 30 Jan 2020 18:10:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=sQ2XPoEyVrYXsnHP3S+Bx1jgnWR7qliXlQ6rATor0F8=;
 b=RHIejUp52v2gXxByfbRRRniW2xwaPtoSXANKQUUXWMhPLEC52H9py546GEFx8CUFVN
 8qi+PHWjBdKa5AkcLV8S7NSl6RprpqQks6i3CasOUkT3hFOwZiYwjuezp7rsvjs7bQX9
 YfyXdeGksN12JFqC2tNyJt5qXYsPDhbpi3WPySy+R0xkvJnacasZEp5VUV/gEaUj7xVp
 UEfX031iEirOLPJdDkcdsnfYXU611kmbBrNmLHHFdAkY36rOh9IMvaokDV+tOGSmMdPy
 1lmS/uu0ZrGIv5uhw3PvBppOe1IPzJUqbHixDTdZb564hYDotgQxJQN60TZHY/0osa0Y
 6psQ==
X-Gm-Message-State: APjAAAV4nx5gAGGNd6hfxdjiQZPbAt7pGwDtAsphKkLFItliWo7VzHI2
 1FSAdby6w45DlECL6wkIDdjTA262ZC8NAGoUh3ac7yBo1wRF6SA2QV7cWOgThRW1kRKiGNxjgoz
 MaNTpuZQaqKRXXV8=
X-Received: by 2002:a1c:80d4:: with SMTP id b203mr8938964wmd.102.1580436637815; 
 Thu, 30 Jan 2020 18:10:37 -0800 (PST)
X-Google-Smtp-Source: APXvYqy2BkzamxUFHHgelW+zEPD+ndEPPLbrrmVC285N4ZFYcPlX4XrMUUmSjzubCnKnirYGBJsFHQ==
X-Received: by 2002:a1c:80d4:: with SMTP id b203mr8938944wmd.102.1580436637597; 
 Thu, 30 Jan 2020 18:10:37 -0800 (PST)
Received: from [192.168.1.35] (113.red-83-57-172.dynamicip.rima-tde.net.
 [83.57.172.113])
 by smtp.gmail.com with ESMTPSA id z21sm8644614wml.5.2020.01.30.18.10.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 30 Jan 2020 18:10:36 -0800 (PST)
Subject: Re: [PATCH v4 7/7] tests/boot_linux_console: Tag Emcraft Smartfusion2
 as running 'u-boot'
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org
References: <20200120235159.18510-1-f4bug@amsat.org>
 <20200120235159.18510-8-f4bug@amsat.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <851737e6-9afd-85a5-b9a8-49e506287cf8@redhat.com>
Date: Fri, 31 Jan 2020 03:10:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200120235159.18510-8-f4bug@amsat.org>
Content-Language: en-US
X-MC-Unique: m368kySOMU2xOuUAiXW7Fw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Alistair Francis <alistair@alistair23.me>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>, qemu-arm@nongnu.org,
 Cleber Rosa <crosa@redhat.com>, Laurent Bonnans <laurent.bonnans@here.com>,
 Cheng Xiang <ext-cheng.xiang@here.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 1/21/20 12:51 AM, Philippe Mathieu-Daud=C3=A9 wrote:
> Avocado tags are handy to automatically select tests matching
> the tags. Since this test also runs U-Boot, tag it.
>=20
> We can run all the tests using U-Boot as once with:
>=20
>    $ avocado --show=3Dapp run -t u-boot tests/acceptance/
>    JOB LOG    : avocado/job-results/job-2020-01-21T00.16-ee9344e/job.log
>     (1/3) tests/acceptance/boot_linux_console.py:BootLinuxConsole.test_ar=
m_emcraft_sf2: PASS (16.59 s)
>     (2/3) tests/acceptance/boot_linux_console.py:BootLinuxConsole.test_ar=
m_raspi2_uboot: PASS (0.47 s)
>     (3/3) tests/acceptance/boot_linux_console.py:BootLinuxConsole.test_aa=
rch64_raspi3_uboot: PASS (2.43 s)
>    RESULTS    : PASS 3 | ERROR 0 | FAIL 0 | SKIP 0 | WARN 0 | INTERRUPT 0=
 | CANCEL 0
>    JOB TIME   : 19.78 s
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>   tests/acceptance/boot_linux_console.py | 1 +
>   1 file changed, 1 insertion(+)
>=20
> diff --git a/tests/acceptance/boot_linux_console.py b/tests/acceptance/bo=
ot_linux_console.py
> index 22b360118d..4a4cf9d0ea 100644
> --- a/tests/acceptance/boot_linux_console.py
> +++ b/tests/acceptance/boot_linux_console.py
> @@ -305,6 +305,7 @@ class BootLinuxConsole(Test):
>           :avocado: tags=3Darch:arm
>           :avocado: tags=3Dmachine:emcraft-sf2
>           :avocado: tags=3Dendian:little
> +        :avocado: tags=3Du-boot
>           """
>           uboot_url =3D ('https://raw.githubusercontent.com/'
>                        'Subbaraya-Sundeep/qemu-test-binaries/'
>=20

Thanks, applied to my python-next tree:
https://gitlab.com/philmd/qemu/commits/python-next


