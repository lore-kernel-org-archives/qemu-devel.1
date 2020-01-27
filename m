Return-Path: <SRS0=8p31=3Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A90DC2D0DB
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2020 19:26:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C84572467F
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2020 19:26:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CRuytB4u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C84572467F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49930 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwA1c-00006L-VN
	for qemu-devel@archiver.kernel.org; Mon, 27 Jan 2020 14:26:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54343)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iwA0Q-0007gK-Uf
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 14:25:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iwA0O-0007fF-Vk
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 14:25:05 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:34682
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iwA0O-0007eO-SK
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 14:25:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580153104;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4w/7ix5bcgPZBVTYwrdl9DtBU/HWjSIyf4OdkV4cNUE=;
 b=CRuytB4uBG6isXFnXjYWn/AsBRi9FTb7+pFYAC/g+v2g74nQMDzNdKL1ievJTSzJhNDqz5
 THFqpwUEUg3Nk3JpVgNwq7t+eCqg5sQEBqgaF2WPrABO0NHFUvwT+3RiUtKGiz7+jwXIy0
 2daSvyTeNV4+uV7u4pf3dJJSI9VGVTg=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-216-tfdhxpLnPgKfp-W36Gq2nA-1; Mon, 27 Jan 2020 14:24:57 -0500
Received: by mail-wm1-f72.google.com with SMTP id z7so1377085wmi.0
 for <qemu-devel@nongnu.org>; Mon, 27 Jan 2020 11:24:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=x02uidMh79A/UC5RnsLU5i29rWtrdO0B0MTNMPKEZ4I=;
 b=hLDIO3XHECdeTiqagqgqMXBhogEECvRmnlj1MyvEqnp9thOb85IaJeAfjAzOtxBc+1
 U26g7nF4NcvU7yQ/2I3mIMSvpaxV4EOf56WRWv3oJ1xzbAsIQnMvd1fTDmb9cORi8+XJ
 lz1aGUzY5wFSB8OpRWpwKFX9tPLstxaOROhLrRpywZXS8wlBmqkW/O27mNAzKfooapU6
 o1eBnFPc5yuvv0uDe5IZNPmhkjR87TAEhaVARUH6H/eWUBCzbyecZlEAOKZqKM1+2voO
 5reitB0TTodH7dOl0ClmHjGru7l4M3/2nJczmL1wp9/vsSEE4KzIpSInpOJG8AaMDMx6
 Pvlg==
X-Gm-Message-State: APjAAAWsf/ubOTMMeT2wgaj9mssDVQooDS8TBz5Quv/doqmDLCrAA7Uc
 xq3tVc+DwOv+bNRkMj7NtH0wKGplX59Mk9y6fUlBUEBw/NTYCYcnz83KLvkgLN0/06PH0eyVBoJ
 iE6b/fw40+38mlKs=
X-Received: by 2002:a1c:9897:: with SMTP id a145mr180639wme.132.1580153096247; 
 Mon, 27 Jan 2020 11:24:56 -0800 (PST)
X-Google-Smtp-Source: APXvYqy/3f2mkxCxVoCXwxip/Es5ciKxWaF7YYAoeG7yxVX9V4qsYs/gRbAeVdrwkPz9CDwtp7aOag==
X-Received: by 2002:a1c:9897:: with SMTP id a145mr180612wme.132.1580153095924; 
 Mon, 27 Jan 2020 11:24:55 -0800 (PST)
Received: from [192.168.1.35] (113.red-83-57-172.dynamicip.rima-tde.net.
 [83.57.172.113])
 by smtp.gmail.com with ESMTPSA id x14sm19797517wmj.42.2020.01.27.11.24.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 Jan 2020 11:24:55 -0800 (PST)
Subject: Re: [PATCH v1 02/13] tests/docker: better handle symlinked libs
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20200124204026.2107-1-alex.bennee@linaro.org>
 <20200124204026.2107-3-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <bca8f112-4d93-1eed-421d-c98ca9fa16d6@redhat.com>
Date: Mon, 27 Jan 2020 20:24:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200124204026.2107-3-alex.bennee@linaro.org>
Content-Language: en-US
X-MC-Unique: tfdhxpLnPgKfp-W36Gq2nA-1
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
Cc: fam@euphon.net, berrange@redhat.com, stefanb@linux.vnet.ibm.com,
 richard.henderson@linaro.org, f4bug@amsat.org, cota@braap.org,
 stefanha@redhat.com, marcandre.lureau@redhat.com, pbonzini@redhat.com,
 aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 1/24/20 9:40 PM, Alex Benn=C3=A9e wrote:
> When we are copying we want to ensure we grab the first
> resolution (the found in path section). However even that binary might
> be a symlink so lets make sure we chase the symlinks to copy the right
> binary to where it can be found.
>=20
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> ---
>   tests/docker/docker.py | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
>=20
> diff --git a/tests/docker/docker.py b/tests/docker/docker.py
> index 31d8adf836..7dfca63fe4 100755
> --- a/tests/docker/docker.py
> +++ b/tests/docker/docker.py
> @@ -109,7 +109,7 @@ def _get_so_libs(executable):
>       ensure theright data is copied."""
>  =20
>       libs =3D []
> -    ldd_re =3D re.compile(r"(/.*/)(\S*)")
> +    ldd_re =3D re.compile(r"(?:\S+ =3D> )?(\S*) \(:?0x[0-9a-f]+\)")
>       try:
>           ldd_output =3D subprocess.check_output(["ldd", executable]).dec=
ode('utf-8')
>           for line in ldd_output.split("\n"):
> @@ -145,7 +145,8 @@ def _copy_binary_with_libs(src, bin_dest, dest_dir):
>       if libs:
>           for l in libs:
>               so_path =3D os.path.dirname(l)
> -            _copy_with_mkdir(l, dest_dir, so_path)
> +            real_l =3D os.path.realpath(l)
> +            _copy_with_mkdir(real_l, dest_dir, so_path)
>  =20
>  =20
>   def _check_binfmt_misc(executable):
>=20

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>


