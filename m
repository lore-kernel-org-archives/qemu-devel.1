Return-Path: <SRS0=hbhd=3T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9883DC2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 22:20:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F8E02082E
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 22:20:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZcOdofZb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F8E02082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40232 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ixIAb-000100-Gg
	for qemu-devel@archiver.kernel.org; Thu, 30 Jan 2020 17:20:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44187)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1ixI9Q-0008Ij-KZ
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 17:19:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1ixI9P-0004Fj-92
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 17:19:04 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:33597
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1ixI9P-0004FV-57
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 17:19:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580422742;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1bbijX/5mpejZEmEAhJQI3cWJJJgBAOpvoXXXibcMYU=;
 b=ZcOdofZbyF7w3WIwxrRR8+pi2yAfDItbbJDHsFqdxELOhX6O0cjkb0yi0bJiUUA2lSo23y
 60EHfGEWtZTNZcpyODMa1HwcMo7GhbHwYsxmwctlWO78ouHh8X0tCupYJJ2r6piCpDKMMI
 nq5bM3IsR9V8aJilcoc2CKETTVdYKNQ=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-390-Orf5AkW7NG2qAmElSztKrQ-1; Thu, 30 Jan 2020 17:19:00 -0500
Received: by mail-wr1-f72.google.com with SMTP id c6so2334559wrm.18
 for <qemu-devel@nongnu.org>; Thu, 30 Jan 2020 14:19:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=wBD9r5igCEYXX1Zd/yQCCldg83MJcLH+8L6Hgk4lI4Q=;
 b=fN3OWB9H/EDzAhZItXLQV/Zz4/jpOsRYnQE7vgXvreXGqi1MbBvZicETNWtCZ4ktQ3
 en1JjJNQ7jjEFWBT3Stz3ItdWfFlHtpA3Ddx2TQcXUojQWU7fJuwXJ/8tgnokINZyxPh
 dnjYBaOwPA7kzOMb5qN77Bpb2b2x1n8g9zEJTTQk4LDa59B6ZeqvnJgl4v7Xv3fZgme6
 FqK5Xnq8NpIRrqzc2fjRyZWpGwGJL1yIzHmim/KIYHc1hhWtfnIrHEUG9AqeNk+gD8lp
 YcofImD9IyNgRRzt7k2Nkwe//bmEpCLpAauxPA/Eryu67hR799XRipC16VFtg8RhpvbW
 B3Rg==
X-Gm-Message-State: APjAAAUn3/nlLWszkba3eXwyom9v6Y+aCmPmlCQYiDCQfQJR13mS6qzQ
 R2/BXociIKZPoxMI9Sg1IrHvPC8d+sufW3CmJuD3pbwIeAcBqrrqxjr1G+uNB4gIrHLNRTIlIQ+
 Dcsd7LCE/2mi3ZAA=
X-Received: by 2002:a7b:ce94:: with SMTP id q20mr8058555wmj.4.1580422739483;
 Thu, 30 Jan 2020 14:18:59 -0800 (PST)
X-Google-Smtp-Source: APXvYqy1ivo4z4cGLoCzQbZUWz9tLKVRm5yUKHG5CXj4l9lFEzSblS1zsEs5lB1cZKzEohGs/7jypg==
X-Received: by 2002:a7b:ce94:: with SMTP id q20mr8058533wmj.4.1580422739229;
 Thu, 30 Jan 2020 14:18:59 -0800 (PST)
Received: from [192.168.1.35] (113.red-83-57-172.dynamicip.rima-tde.net.
 [83.57.172.113])
 by smtp.gmail.com with ESMTPSA id a9sm7985110wmm.15.2020.01.30.14.18.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 30 Jan 2020 14:18:58 -0800 (PST)
Subject: Re: [PATCH v4 2/7] Acceptance tests: Extract _console_interaction()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org
References: <20200120235159.18510-1-f4bug@amsat.org>
 <20200120235159.18510-3-f4bug@amsat.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <57469393-0d7d-a4f8-d37e-2144ac6b67e9@redhat.com>
Date: Thu, 30 Jan 2020 23:18:57 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200120235159.18510-3-f4bug@amsat.org>
Content-Language: en-US
X-MC-Unique: Orf5AkW7NG2qAmElSztKrQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
> Since we are going to re-use the code shared between
> wait_for_console_pattern() and exec_command_and_wait_for_pattern(),
> extract the common part into a local function.
>=20
> Tested-by: Niek Linnenbank <nieklinnenbank@gmail.com>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>   tests/acceptance/avocado_qemu/__init__.py | 31 +++++++++++++----------
>   1 file changed, 17 insertions(+), 14 deletions(-)
>=20
> diff --git a/tests/acceptance/avocado_qemu/__init__.py b/tests/acceptance=
/avocado_qemu/__init__.py
> index 6618ea67c1..0a50fcf2be 100644
> --- a/tests/acceptance/avocado_qemu/__init__.py
> +++ b/tests/acceptance/avocado_qemu/__init__.py
> @@ -55,19 +55,14 @@ def pick_default_qemu_bin(arch=3DNone):
>           return qemu_bin_from_src_dir_path
>  =20
>  =20
> -def wait_for_console_pattern(test, success_message, failure_message=3DNo=
ne):
> -    """
> -    Waits for messages to appear on the console, while logging the conte=
nt
> -
> -    :param test: an Avocado test containing a VM that will have its cons=
ole
> -                 read and probed for a success or failure message
> -    :type test: :class:`avocado_qemu.Test`
> -    :param success_message: if this message appears, test succeeds
> -    :param failure_message: if this message appears, test fails
> -    """
> +def _console_interaction(test, success_message, failure_message,
> +                         send_string):
>       console =3D test.vm.console_socket.makefile()
>       console_logger =3D logging.getLogger('console')
>       while True:
> +        if send_string:
> +            test.vm.console_socket.sendall(send_string.encode())
> +            send_string =3D None # send only once
>           msg =3D console.readline().strip()
>           if not msg:
>               continue
> @@ -79,6 +74,17 @@ def wait_for_console_pattern(test, success_message, fa=
ilure_message=3DNone):
>               fail =3D 'Failure message found in console: %s' % failure_m=
essage
>               test.fail(fail)
>  =20
> +def wait_for_console_pattern(test, success_message, failure_message=3DNo=
ne):
> +    """
> +    Waits for messages to appear on the console, while logging the conte=
nt
> +
> +    :param test: an Avocado test containing a VM that will have its cons=
ole
> +                 read and probed for a success or failure message
> +    :type test: :class:`avocado_qemu.Test`
> +    :param success_message: if this message appears, test succeeds
> +    :param failure_message: if this message appears, test fails
> +    """
> +    _console_interaction(test, success_message, failure_message, None)
>  =20
>   def exec_command_and_wait_for_pattern(test, command,
>                                         success_message, failure_message=
=3DNone):
> @@ -94,10 +100,7 @@ def exec_command_and_wait_for_pattern(test, command,
>       :param success_message: if this message appears, test succeeds
>       :param failure_message: if this message appears, test fails
>       """
> -    command +=3D '\r'
> -    test.vm.console_socket.sendall(command.encode())
> -    wait_for_console_pattern(test, success_message, failure_message)
> -
> +    _console_interaction(test, success_message, failure_message, command=
 + '\r')
>  =20
>   class Test(avocado.Test):
>       def _get_unique_tag_val(self, tag_name):
>=20

Thanks, applied to my python-next tree:
https://gitlab.com/philmd/qemu/commits/python-next


