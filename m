Return-Path: <SRS0=2jXw=3K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72DB3C2D0DB
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 08:21:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F2AC24125
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 08:21:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eX/NAISo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F2AC24125
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49810 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iton2-0003Hm-As
	for qemu-devel@archiver.kernel.org; Tue, 21 Jan 2020 03:21:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51434)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1itomH-0002jY-9Y
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 03:20:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1itomC-0001FX-Tf
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 03:20:49 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:32025
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1itomC-0001F3-Ps
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 03:20:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579594843;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8PIFPLrHBMdR66uj8dlbraz5UoNwdSC5WoUJuxxA8ug=;
 b=eX/NAISoaXtv+WxRDdujD5slVnA5N1GKORI4kSvYc6j7HJHBUPpsq8sTpgci9EPceVr/mK
 S+jaa/xXXaSZgMeBuD2Ue5Ky/EPYfKIQAguA4G9wglSg5/lYMzCirLIQ/fkaUyEQqxMEwA
 e2yQc37u7WM38paw/SlRGDdR1d86sME=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-326-I7_0_5gMMyWZ66DAL9KkxQ-1; Tue, 21 Jan 2020 03:20:42 -0500
Received: by mail-wr1-f70.google.com with SMTP id h30so966183wrh.5
 for <qemu-devel@nongnu.org>; Tue, 21 Jan 2020 00:20:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=zoHOy6LOu+JPJzC1UGAAfYjgpK1PD26/QPFGHErBoeU=;
 b=RK4aTP2wxKyNr35v3zbaeg55D8RsAyuNvzWYQjvibz7yaV7gLW1xZLHO/ttOuZwOa+
 SoGw8a0b2JTGoTqqp/PzVGVH4uHCZQcZI8kR9qygJrXc1JJW3WDa7ouFdWYKcEumSBup
 PUFhyqrnHTRg+e/H51BzzhIBNXMTBGunEUjEfPXLiWu4Kb1PIkVbnrDuQqKZLKCBFzxE
 D81yBi7Jyv14c+Wiv500+oJYZMZ5E+cn4cTI6whbKZ6Us3MFCcEtAVeveN6XuEwRajZx
 XHZc8MZD5EQTSbFFd0xfoaeuPxKBNXkMA+95pxIc3mYCJzVuvqda83kahhu3rIiLA8/i
 ocxA==
X-Gm-Message-State: APjAAAUk76v3GoXXoS/6Z9VwKg6kFeM3yycKJRs9A3hxJL0Cm3B6it6f
 nIJfjXOP3cH0mHR8kVmiV8nRSDFCvK8VSwgTP4YB/DynFdVd9dpYmWAHuj/Q4YlM42bu1A8nVlV
 uv77yCYnvTOBrKJE=
X-Received: by 2002:a1c:4c5:: with SMTP id 188mr3059781wme.82.1579594840736;
 Tue, 21 Jan 2020 00:20:40 -0800 (PST)
X-Google-Smtp-Source: APXvYqytFzI//3+tXvOOC7ip9qJG5WDsYtD86oRb6AP6P9k7BUXwEM/WWYHvFVEpVDzpx3Z+r8Iwyw==
X-Received: by 2002:a1c:4c5:: with SMTP id 188mr3059749wme.82.1579594840398;
 Tue, 21 Jan 2020 00:20:40 -0800 (PST)
Received: from [192.168.1.35] (113.red-83-57-172.dynamicip.rima-tde.net.
 [83.57.172.113])
 by smtp.gmail.com with ESMTPSA id n187sm2922935wme.28.2020.01.21.00.20.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 Jan 2020 00:20:39 -0800 (PST)
Subject: Re: [PATCH v4 4/7] python/qemu/machine: Allow to use other serial
 consoles than default
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org
References: <20200120235159.18510-1-f4bug@amsat.org>
 <20200120235159.18510-5-f4bug@amsat.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <6542670c-341f-b259-5705-a5374c5b722d@redhat.com>
Date: Tue, 21 Jan 2020 09:20:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200120235159.18510-5-f4bug@amsat.org>
Content-Language: en-US
X-MC-Unique: I7_0_5gMMyWZ66DAL9KkxQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
 Andrew Baumann <Andrew.Baumann@microsoft.com>, qemu-arm@nongnu.org,
 Cleber Rosa <crosa@redhat.com>, Laurent Bonnans <laurent.bonnans@here.com>,
 Cheng Xiang <ext-cheng.xiang@here.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 1/21/20 12:51 AM, Philippe Mathieu-Daud=C3=A9 wrote:
> Currently the QEMU Python module limits the QEMUMachine class to
> use the first serial console.
>=20
> Some machines/guest might use another console than the first one as
> the 'boot console'. For example the Raspberry Pi uses the second
> (AUX) console.
>=20
> To be able to use the Nth console as default, we simply need to
> connect all the N - 1 consoles to the null chardev.
>=20
> Add an index argument, so we can use a specific serial console as
> default.
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
> v2:
> - renamed 'console_index', added docstring (Cleber)
> - reworded description (pm215)
> ---
>   python/qemu/machine.py | 9 ++++++++-
>   1 file changed, 8 insertions(+), 1 deletion(-)
>=20
> diff --git a/python/qemu/machine.py b/python/qemu/machine.py
> index 734efd8536..ef9f5b213f 100644
> --- a/python/qemu/machine.py
> +++ b/python/qemu/machine.py
> @@ -241,6 +241,8 @@ class QEMUMachine(object):
>                            'chardev=3Dmon,mode=3Dcontrol'])
>           if self._machine is not None:
>               args.extend(['-machine', self._machine])
> +        for i in range(self._console_index):
> +            args.extend(['-serial', 'null'])

This patch is not sufficient, we have to initialize _console_index in=20
__init__():

-- >8 --
diff --git a/python/qemu/machine.py b/python/qemu/machine.py
index ef9f5b213f..183d8f3d38 100644
--- a/python/qemu/machine.py
+++ b/python/qemu/machine.py
@@ -112,6 +112,7 @@ class QEMUMachine(object):
          self._sock_dir =3D sock_dir
          self._launched =3D False
          self._machine =3D None
+        self._console_index =3D 0
          self._console_set =3D False
          self._console_device_type =3D None
          self._console_address =3D None
---

Else for tests not calling self.set_console() we get:

  'QEMUMachine' object has no attribute '_console_index'

>           if self._console_set:
>               self._console_address =3D os.path.join(self._sock_dir,
>                                                    self._name + "-console=
.sock")
> @@ -527,7 +529,7 @@ class QEMUMachine(object):
>           """
>           self._machine =3D machine_type
>  =20
> -    def set_console(self, device_type=3DNone):
> +    def set_console(self, device_type=3DNone, console_index=3D0):
>           """
>           Sets the device type for a console device
>  =20
> @@ -548,9 +550,14 @@ class QEMUMachine(object):
>                               chardev:console" command line argument will
>                               be used instead, resorting to the machine's
>                               default device type.
> +        @param console_index: the index of the console device to use.
> +                              If not zero, the command line will create
> +                              'index - 1' consoles and connect them to
> +                              the 'null' backing character device.
>           """
>           self._console_set =3D True
>           self._console_device_type =3D device_type
> +        self._console_index =3D console_index
>  =20
>       @property
>       def console_socket(self):
>=20


