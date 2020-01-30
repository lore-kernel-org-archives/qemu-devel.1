Return-Path: <SRS0=hbhd=3T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B431AC2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 22:20:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 73EFC2082E
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 22:20:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GkW9hDhE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73EFC2082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40242 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ixIB1-0001W9-MF
	for qemu-devel@archiver.kernel.org; Thu, 30 Jan 2020 17:20:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44283)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1ixI9k-0000Ew-TB
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 17:19:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1ixI9j-0004cG-KX
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 17:19:24 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:41758
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1ixI9j-0004aB-Ft
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 17:19:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580422761;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FjfPCZ3VGpmVHkzcKcLSdCsHWP+qqF4grXsLnPpnU1M=;
 b=GkW9hDhEwYeOPvbHi/mO6m1doNMGLPCEjy/o0GVOVJc4Rx093lKQRfIdBrcJiCTeyUaeTy
 j2d1U/RnvGBB27t1NDIiMSbEW75wI/YlrwmAjzfjtBJeEt95/y+OTyBv3Tzga+NFGyJzq1
 Nmx9QnvcZ8wBVLGsI5ZsyqpXoVpXO7U=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-255-3bOB-fm_P_64ka6eyW2PfA-1; Thu, 30 Jan 2020 17:19:17 -0500
Received: by mail-wr1-f71.google.com with SMTP id c6so2334882wrm.18
 for <qemu-devel@nongnu.org>; Thu, 30 Jan 2020 14:19:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=rdqf5LMUDJTWCWwG5fmZ87c4gFRxCLOpBOjz45b8I2U=;
 b=aKFPYdk1fJJEFg9W8G19J6nB7t1zoWS8YPm1d2O3+apPa1H6Au5I3h0PlBaXg5IOYD
 7AZYFaWu7V9lUiUkAVl+SMnUNX1/ran9eUinTzncWecVIIs/SM8m6UtEFqSzlYee8Bb5
 2j6MXGEAJcEBNztxa5B0RZ+TQFCDZ0pSBs1dDEe6L42STY48cof2pS/Dj9EDYwNOcKqp
 T7UG5QsxHvmJlZlDQw86P5IyqGEHMJyrRNS7vQiO3TT8cTl9bOVv3HNksMZqHt6odpWy
 ZzPYFUbMiSz1E4uSpc5Q/BUqnTeY0/AP0qnJxahlG1U/1+y4RxQ5WB01Jspa0ZKmYvGM
 hbDw==
X-Gm-Message-State: APjAAAULiiZVO/Ata4TUXoxIuoDAG2HAeDzlL7U0SwRSClizYlKGN7HB
 QP7c/e0sjAcNx1VQ6v39WAJkuW6v+pkXRnjYkKOIp3Q67WGUZGH0unUWE+sR+2OVRK+tpftYd9H
 vfADsFHpgUiHuSjA=
X-Received: by 2002:a1c:3b87:: with SMTP id i129mr7686813wma.142.1580422756652; 
 Thu, 30 Jan 2020 14:19:16 -0800 (PST)
X-Google-Smtp-Source: APXvYqwsiqBeddluK/OfhtQ+LKs0mnmV/b5Tf0rRcf5dBO8fkXU4FohLjgYWBpcOt1pvHF+NYLZ8wA==
X-Received: by 2002:a1c:3b87:: with SMTP id i129mr7686785wma.142.1580422756366; 
 Thu, 30 Jan 2020 14:19:16 -0800 (PST)
Received: from [192.168.1.35] (113.red-83-57-172.dynamicip.rima-tde.net.
 [83.57.172.113])
 by smtp.gmail.com with ESMTPSA id v17sm8746362wrt.91.2020.01.30.14.19.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 30 Jan 2020 14:19:15 -0800 (PST)
Subject: Re: [PATCH v4 3/7] Acceptance tests: Add
 interrupt_interactive_console_until_pattern()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org
References: <20200120235159.18510-1-f4bug@amsat.org>
 <20200120235159.18510-4-f4bug@amsat.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <6f4801dd-9d43-02f7-b954-75395d0c95fb@redhat.com>
Date: Thu, 30 Jan 2020 23:19:14 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200120235159.18510-4-f4bug@amsat.org>
Content-Language: en-US
X-MC-Unique: 3bOB-fm_P_64ka6eyW2PfA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
 Andrew Baumann <Andrew.Baumann@microsoft.com>,
 Niek Linnenbank <nieklinnenbank@gmail.com>, qemu-arm@nongnu.org,
 Cleber Rosa <crosa@redhat.com>, Laurent Bonnans <laurent.bonnans@here.com>,
 Cheng Xiang <ext-cheng.xiang@here.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 1/21/20 12:51 AM, Philippe Mathieu-Daud=C3=A9 wrote:
> We need a function to interrupt interactive consoles.
>=20
> Example: Interrupt U-Boot to set different environment values.
>=20
> Tested-by: Niek Linnenbank <nieklinnenbank@gmail.com>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>   tests/acceptance/avocado_qemu/__init__.py | 32 +++++++++++++++++++++--
>   1 file changed, 30 insertions(+), 2 deletions(-)
>=20
> diff --git a/tests/acceptance/avocado_qemu/__init__.py b/tests/acceptance=
/avocado_qemu/__init__.py
> index 0a50fcf2be..d4358eb431 100644
> --- a/tests/acceptance/avocado_qemu/__init__.py
> +++ b/tests/acceptance/avocado_qemu/__init__.py
> @@ -56,13 +56,15 @@ def pick_default_qemu_bin(arch=3DNone):
>  =20
>  =20
>   def _console_interaction(test, success_message, failure_message,
> -                         send_string):
> +                         send_string, keep_sending=3DFalse):
> +    assert not keep_sending or send_string
>       console =3D test.vm.console_socket.makefile()
>       console_logger =3D logging.getLogger('console')
>       while True:
>           if send_string:
>               test.vm.console_socket.sendall(send_string.encode())
> -            send_string =3D None # send only once
> +            if not keep_sending:
> +                send_string =3D None # send only once
>           msg =3D console.readline().strip()
>           if not msg:
>               continue
> @@ -74,6 +76,32 @@ def _console_interaction(test, success_message, failur=
e_message,
>               fail =3D 'Failure message found in console: %s' % failure_m=
essage
>               test.fail(fail)
>  =20
> +def interrupt_interactive_console_until_pattern(test, success_message,
> +                                                failure_message=3DNone,
> +                                                interrupt_string=3D'\r')=
:
> +    """
> +    Keep sending a string to interrupt a console prompt, while logging t=
he
> +    console output. Typical use case is to break a boot loader prompt, s=
uch:
> +
> +        Press a key within 5 seconds to interrupt boot process.
> +        5
> +        4
> +        3
> +        2
> +        1
> +        Booting default image...
> +
> +    :param test: an Avocado test containing a VM that will have its cons=
ole
> +                 read and probed for a success or failure message
> +    :type test: :class:`avocado_qemu.Test`
> +    :param success_message: if this message appears, test succeeds
> +    :param failure_message: if this message appears, test fails
> +    :param interrupt_string: a string to send to the console before tryi=
ng
> +                             to read a new line
> +    """
> +    _console_interaction(test, success_message, failure_message,
> +                         interrupt_string, True)
> +
>   def wait_for_console_pattern(test, success_message, failure_message=3DN=
one):
>       """
>       Waits for messages to appear on the console, while logging the cont=
ent
>=20

Thanks, applied to my python-next tree:
https://gitlab.com/philmd/qemu/commits/python-next


