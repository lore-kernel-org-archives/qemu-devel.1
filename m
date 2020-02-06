Return-Path: <SRS0=rlpO=32=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE31DC2D0B1
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 13:58:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A734921775
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 13:58:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AXzS6rXa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A734921775
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39504 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izhg8-0007w8-Ri
	for qemu-devel@archiver.kernel.org; Thu, 06 Feb 2020 08:58:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40089)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1izhfM-0007S4-PH
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 08:58:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1izhfL-0003A7-J0
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 08:58:00 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:20476
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1izhfL-000369-Ee
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 08:57:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580997478;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fT0nwOeC5g3Jk6Oq9wQi4zZWV9UwLOHLRswOUEFPwEo=;
 b=AXzS6rXad57loVDDiSB7fBf4uVqyHffBlnRb8+6v4GSBg6g7fRLMdb1SnOmtFUiJcQxZhA
 C29kMn6ie8G6omlAmLUBgAXRLo/jrmOokh2xPgKcPWqGDDtOIekZ3e3GvS/OrqXSqY0PGD
 4K2NTTHle085rwLB6c1FGsqzoxnOyD4=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-279-ODwv-McBOzC_yPGcPeI5vA-1; Thu, 06 Feb 2020 08:57:54 -0500
Received: by mail-wm1-f72.google.com with SMTP id y24so6330wmj.8
 for <qemu-devel@nongnu.org>; Thu, 06 Feb 2020 05:57:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=8QX/4ByYqoM9AlEyRst2z++2ALuan8/941cvw2QPRQM=;
 b=ErZO2mddhNWgBPJ5k9puL2k0Qzecsc2ccrxfDvP6PdIsPjaaGZ3HHMHdGIQLXdd9Yg
 JQW10ytuSaZz+H+E3f5+1iepyKdMhu1hYCPCVKJCObu2dc+7jpso2mTw1n1OtN2W/Vtc
 qFNPZ8DS49t2Z14C3w/8F6Ll0GdrTENURZ6/uS+kOe5e1egrU9DglVwXUEP2Hrrd1o2I
 WLfBTevXHDztMQVeGm7y2cHhN3eEISDaFi6WnGjt3lBp+8MuUakmRhfpSC9h6hNHSXhV
 OIuiU0BIzEB/IOGu/uhSrNJlBhhHhLTiPycKhRuihtTtYrXz1LcjJ6S6+w18CoGQzbd9
 rrqw==
X-Gm-Message-State: APjAAAW8HcGfmccFWHvkOEn1Y7lMdsCVxeVV44a3ncPgbHp/xzrUWa+6
 FiM/CHydczqhKL6F7YYL5C0IJdH3UBT+Sx/s+/Af5Kkp971kZlwk/ZDiAtMi1qIOCvF6wj3x0X7
 B2FRHxNPZchH9gvM=
X-Received: by 2002:a5d:4289:: with SMTP id k9mr4085299wrq.280.1580997473316; 
 Thu, 06 Feb 2020 05:57:53 -0800 (PST)
X-Google-Smtp-Source: APXvYqw8hgUf796spvhx/W0r50Clud2k9/435PMyuUhkc+zX9fs2vZoUXTMqmqGeEUSq1OSrP2ZQIw==
X-Received: by 2002:a5d:4289:: with SMTP id k9mr4085279wrq.280.1580997473125; 
 Thu, 06 Feb 2020 05:57:53 -0800 (PST)
Received: from [192.168.1.35] (78.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.78])
 by smtp.gmail.com with ESMTPSA id l131sm3781595wmf.31.2020.02.06.05.57.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 06 Feb 2020 05:57:52 -0800 (PST)
Subject: Re: [PATCH v2 1/6] tests/boot_linux_console: add microvm acceptance
 test
To: Liam Merwick <liam.merwick@oracle.com>, alex.bennee@linaro.org,
 fam@euphon.net
References: <1580914565-19675-1-git-send-email-liam.merwick@oracle.com>
 <1580914565-19675-2-git-send-email-liam.merwick@oracle.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <6ceb7e42-125a-ac91-fad6-e67c332c48b4@redhat.com>
Date: Thu, 6 Feb 2020 14:57:51 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <1580914565-19675-2-git-send-email-liam.merwick@oracle.com>
Content-Language: en-US
X-MC-Unique: ODwv-McBOzC_yPGcPeI5vA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
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
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, wainersm@redhat.com,
 slp@redhat.com, sgarzare@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/5/20 3:56 PM, Liam Merwick wrote:
> Refactor test_x86_64_pc() to test_x86_64_machine() so that separate
> functions which specify the Avocado tag of ':avocado: tags=3Dmachine:'
> as being either 'pc' or 'microvm' can be used to test booting a
> compressed kernel using either machine class.
>=20
> Signed-off-by: Liam Merwick <liam.merwick@oracle.com>
> Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
> ---
>   tests/acceptance/boot_linux_console.py | 20 +++++++++++++++++---
>   1 file changed, 17 insertions(+), 3 deletions(-)
>=20
> diff --git a/tests/acceptance/boot_linux_console.py b/tests/acceptance/bo=
ot_linux_console.py
> index e40b84651b0b..233601b429bd 100644
> --- a/tests/acceptance/boot_linux_console.py
> +++ b/tests/acceptance/boot_linux_console.py
> @@ -51,10 +51,10 @@ class BootLinuxConsole(Test):
>           os.chdir(cwd)
>           return self.workdir + path
>  =20
> -    def test_x86_64_pc(self):
> +    def do_test_x86_64_machine(self):
>           """
> -        :avocado: tags=3Darch:x86_64
> -        :avocado: tags=3Dmachine:pc
> +        Common routine to boot an x86_64 guest.
> +        Caller must specify tags=3Darch and tags=3Dmachine
>           """
>           kernel_url =3D ('https://archives.fedoraproject.org/pub/archive=
/fedora'
>                         '/linux/releases/29/Everything/x86_64/os/images/p=
xeboot'
> @@ -70,6 +70,20 @@ class BootLinuxConsole(Test):
>           console_pattern =3D 'Kernel command line: %s' % kernel_command_=
line
>           self.wait_for_console_pattern(console_pattern)
>  =20
> +    def test_x86_64_pc(self):
> +        """
> +        :avocado: tags=3Darch:x86_64
> +        :avocado: tags=3Dmachine:pc
> +        """
> +        self.do_test_x86_64_machine()
> +
> +    def test_x86_64_microvm(self):
> +        """
> +        :avocado: tags=3Darch:x86_64
> +        :avocado: tags=3Dmachine:microvm
> +        """
> +        self.do_test_x86_64_machine()
> +
>       def test_mips_malta(self):
>           """
>           :avocado: tags=3Darch:mips
>=20

Reviewed-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>


