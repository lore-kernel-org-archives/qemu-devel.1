Return-Path: <SRS0=rlpO=32=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 947CEC352A2
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 14:31:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6343121741
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 14:31:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bksGrADY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6343121741
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40052 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iziBe-0002jO-Hf
	for qemu-devel@archiver.kernel.org; Thu, 06 Feb 2020 09:31:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54519)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1izi7n-0005pL-Hn
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 09:27:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1izi7m-00029y-Fj
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 09:27:23 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:41740
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1izi7m-00028w-BF
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 09:27:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580999242;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ABMImKJyQzQvIOVlESnKU5f8sZvt1PxYGJsvRN/2Ois=;
 b=bksGrADYwikBXILLm/W/enoLNi/xORvzp0KIqSxmRuCVwRWicj816kXc1K/LZMVaUIv6Ew
 g8suOHNQ/tFx5q9ueqSf0H8rA5W+ytyTeQ514bFkEDTbQxas8wo99hd7s3k/1beDXg387l
 QeW8DLlBZn1pXymIB5D8NzZil+SQyAk=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-391-FRia5xXNMQuBeCKLgAQbcw-1; Thu, 06 Feb 2020 09:27:17 -0500
Received: by mail-wm1-f71.google.com with SMTP id u11so48969wmb.4
 for <qemu-devel@nongnu.org>; Thu, 06 Feb 2020 06:27:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=qvtAoDfnX633x4W6mvZaQHfQIKRnmpQGQ5cOySK7fKU=;
 b=CW2GgKj0h/o4omyoYjF3hmxNG/frTrCCz8z91MzRsrTvi0dVzXhEOSGE0HtgKUdjlf
 gvAEZiLAcPfOuwdwtv3qpWmFgcyX9QxL2MEjNbdAsmhwe1HwyfgpYoL9V6Ev9onestvV
 0FbRRlR5CzYWtBwhKfZ8KkauWAEcepnJzDfYPuD8xdTD7lYOHLMlm2ZvEeNP6ac8fgO+
 B7mbZivGhDLbDXLb2tnRKy5h2V+H+fSq50DEttxf9q7DddO39V7w81xwE/T2FEWBT4RL
 3cPQGiMe20pRX5IzuxWd2hJXuSusjuVOQMfy4/fB2vm71aaBEVyCfjMdjOvm7MsEe63t
 ZpLg==
X-Gm-Message-State: APjAAAU/tHxxE123mhgIClR79rmIuORGdGYOkFlj0uX56d+rGQPbmosF
 PgRlTnmb67AV/wJR9/Xd4piPwZZeZfscdo0l5NuNYyEhssZCPraxzXZdDMU6YrDhZeupy6cOG6z
 by1IVEh5QKBihYNQ=
X-Received: by 2002:adf:fd0e:: with SMTP id e14mr4042186wrr.127.1580999235953; 
 Thu, 06 Feb 2020 06:27:15 -0800 (PST)
X-Google-Smtp-Source: APXvYqxggTcVGe3ZPrLpBkGb+RJ2AHYeBntZPZukw54qmuiko7cV7jS50aK9eltfoXPnOkaa7jhoFA==
X-Received: by 2002:adf:fd0e:: with SMTP id e14mr4042154wrr.127.1580999235644; 
 Thu, 06 Feb 2020 06:27:15 -0800 (PST)
Received: from [192.168.1.35] (78.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.78])
 by smtp.gmail.com with ESMTPSA id n3sm4197237wrs.8.2020.02.06.06.27.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 06 Feb 2020 06:27:15 -0800 (PST)
Subject: Re: [PATCH v2 4/6] tests/boot_linux_console: add extract_from_rpm
 method
To: Liam Merwick <liam.merwick@oracle.com>, alex.bennee@linaro.org,
 fam@euphon.net
References: <1580914565-19675-1-git-send-email-liam.merwick@oracle.com>
 <1580914565-19675-5-git-send-email-liam.merwick@oracle.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <c7403e08-e18e-c914-b9b3-1de158cc5fca@redhat.com>
Date: Thu, 6 Feb 2020 15:27:14 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <1580914565-19675-5-git-send-email-liam.merwick@oracle.com>
Content-Language: en-US
X-MC-Unique: FRia5xXNMQuBeCKLgAQbcw-1
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
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, wainersm@redhat.com,
 slp@redhat.com, sgarzare@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/5/20 3:56 PM, Liam Merwick wrote:
> Add a method to extract a specified file from an RPM to the test's
> working directory and return the path to the extracted file.
>=20
> Signed-off-by: Liam Merwick <liam.merwick@oracle.com>
> Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
>   tests/acceptance/boot_linux_console.py | 16 ++++++++++++++++
>   1 file changed, 16 insertions(+)
>=20
> diff --git a/tests/acceptance/boot_linux_console.py b/tests/acceptance/bo=
ot_linux_console.py
> index e9375590bc1c..6a473363a122 100644
> --- a/tests/acceptance/boot_linux_console.py
> +++ b/tests/acceptance/boot_linux_console.py
> @@ -51,6 +51,22 @@ class BootLinuxConsole(Test):
>           os.chdir(cwd)
>           return self.workdir + path
>  =20
> +    def extract_from_rpm(self, rpm, path):
> +        """
> +        Extracts a file from an RPM package into the test workdir.
> +
> +        :param rpm: path to the rpm archive
> +        :param path: path within the rpm archive of the file to be extra=
cted
> +                     needs to be a relative path (starting with './') be=
cause
> +                     cpio(1), which is used to extract the file, expects=
 that.
> +        :returns: path of the extracted file
> +        """
> +        cwd =3D os.getcwd()
> +        os.chdir(self.workdir)
> +        process.run("rpm2cpio %s | cpio -id %s" % (rpm, path), shell=3DT=
rue)
> +        os.chdir(cwd)
> +        return os.path.normpath(os.path.join(self.workdir, path))
> +
>       def do_test_x86_64_machine(self):
>           """
>           Common routine to boot an x86_64 guest.
>=20

Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>


