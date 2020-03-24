Return-Path: <SRS0=M7c2=5J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E3F7C4332B
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 12:46:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 48ABB207FF
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 12:46:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cjuKIBwA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48ABB207FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48148 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGiwh-0004Z3-Fw
	for qemu-devel@archiver.kernel.org; Tue, 24 Mar 2020 08:46:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43896)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jGivb-0003jp-DZ
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 08:45:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jGiva-0000gs-Cy
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 08:45:07 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:42287)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jGiva-0000gQ-8l
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 08:45:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585053904;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IBkOPT/+9j0pJA2o2ZtVjBTtDZmMTymjPd8LvdzpTMY=;
 b=cjuKIBwAnrNg5Hk/8/WkxYsmX5CTTrh0T0oyymsbH8L8T/CEFsCY0ob0cWQ9TwD2UrKiM3
 naT2HZsv5BvNrQ6XtmPSsHaupK8Nm8o9Ah86YK8Vl40q9jEQYlTVgQTtLZq9f9Wu/f6g8d
 bGNiKt+quDnTXeJ0YU/XM5EIxugyYv8=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-145-wwF1AYBsPZK7OS8jZK67AA-1; Tue, 24 Mar 2020 08:45:02 -0400
X-MC-Unique: wwF1AYBsPZK7OS8jZK67AA-1
Received: by mail-ed1-f70.google.com with SMTP id j10so6286349edy.21
 for <qemu-devel@nongnu.org>; Tue, 24 Mar 2020 05:45:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=mVcIWofKfYzrOLVo5LxbqCLYFDq2/xIKP598P5/0CLA=;
 b=G4v0asCTmfKZnpN4q0tO1z3LBZn13CWZP5TRRAXZ2Ka9B9uWD1A6gi3IjeCXQL+4EV
 h5+FPIiuDzyLbOb0hFfwh/GqBeKkiy+tMzMc2Rg83nXYpAWudFLLj3Rw6XEZ3WqXtaiQ
 DlBOHmh2sT8P4JrxEcGeqoOJOrhfvdkp/47vlymtbn13ywx2HlAePc+rgqmnsx6OO9Ls
 6Okqokh8yfpYgn25thaEoevREwba8ns3/g/UIXFUJYD/Dp9NlAE95bdTlYY4+Ku1Je2f
 Y2cE+njF77kz8oPQSJNqEaw+k3ifViZbmweve7/pv1WlYmgEipV7Hm5FQTHiVf+AU0+8
 +gUg==
X-Gm-Message-State: ANhLgQ2DgjYwx4sQDBqNMPAolA3HputlTRgd0adCf+jbROvZHQ83y7TL
 OziRWsrH2Bz9q947iv7spD8Jf2ogmY6prXnAun+pGx/dr/tWzQb2zJgZvp3cqSsUeyt/NJzn+DQ
 Y2G6cNHD55IDyWKk=
X-Received: by 2002:a50:c312:: with SMTP id a18mr25353097edb.292.1585053901655; 
 Tue, 24 Mar 2020 05:45:01 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vvFUfoCf/pXthoyVEzUgJQcoDF5lUGJ7yZ8EXaTQR4RrNtR9hgu1/fBbFMAGUXfxQ3ZzK6+IA==
X-Received: by 2002:a50:c312:: with SMTP id a18mr25353048edb.292.1585053900978; 
 Tue, 24 Mar 2020 05:45:00 -0700 (PDT)
Received: from [192.168.1.35] (37.red-83-52-54.dynamicip.rima-tde.net.
 [83.52.54.37])
 by smtp.gmail.com with ESMTPSA id a17sm1276014edj.53.2020.03.24.05.44.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 24 Mar 2020 05:45:00 -0700 (PDT)
Subject: Re: [PATCH v1 01/11] tests/vm: write raw console log
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20200323161514.23952-1-alex.bennee@linaro.org>
 <20200323161514.23952-2-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <4c7574c7-f9dd-7ecf-26f9-ff9a51aeb4ad@redhat.com>
Date: Tue, 24 Mar 2020 13:44:59 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200323161514.23952-2-alex.bennee@linaro.org>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 216.205.24.74
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
Cc: Fam Zheng <fam@euphon.net>, Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/23/20 5:15 PM, Alex Benn=C3=A9e wrote:
> From: Gerd Hoffmann <kraxel@redhat.com>
>=20
> Run "tail -f /var/tmp/*/qemu*console.raw" in another terminal
> to watch the install console.
>=20
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> Message-Id: <20200310083218.26355-2-kraxel@redhat.com>
> ---
>   tests/vm/basevm.py | 6 ++++++
>   1 file changed, 6 insertions(+)
>=20
> diff --git a/tests/vm/basevm.py b/tests/vm/basevm.py
> index 8400b0e07f6..c53fd354d95 100644
> --- a/tests/vm/basevm.py
> +++ b/tests/vm/basevm.py
> @@ -213,6 +213,9 @@ class BaseVM(object):
>       def console_init(self, timeout =3D 120):
>           vm =3D self._guest
>           vm.console_socket.settimeout(timeout)
> +        self.console_raw_path =3D os.path.join(vm._temp_dir,
> +                                             vm._name + "-console.raw")
> +        self.console_raw_file =3D open(self.console_raw_path, 'wb')
>  =20
>       def console_log(self, text):
>           for line in re.split("[\r\n]", text):
> @@ -234,6 +237,9 @@ class BaseVM(object):
>           while True:
>               try:
>                   chars =3D vm.console_socket.recv(1)
> +                if self.console_raw_file:
> +                    self.console_raw_file.write(chars)
> +                    self.console_raw_file.flush()
>               except socket.timeout:
>                   sys.stderr.write("console: *** read timeout ***\n")
>                   sys.stderr.write("console: waiting for: '%s'\n" % expec=
t)
>=20

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>


