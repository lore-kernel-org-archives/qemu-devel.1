Return-Path: <SRS0=aXOp=3U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 241A3C2D0DB
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2020 16:09:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E4AF3206D5
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2020 16:09:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YljKDJhk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4AF3206D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55470 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ixYrl-0004BM-0p
	for qemu-devel@archiver.kernel.org; Fri, 31 Jan 2020 11:09:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59231)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1ixYhA-00042P-KN
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 10:59:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1ixYh8-0000an-OT
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 10:59:00 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:28203
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1ixYh8-0000a9-Kz
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 10:58:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580486336;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=N+nB8n7fswyYhE1bHy4hfuYzby2lfaQf0qdPG+Se00A=;
 b=YljKDJhkhyrCP4TxghQZInktrP1SqqgiZ8m80oRHCzIL2kVIi2ACRJigqLvQL4WvJAb6Qm
 gUOMZ8bzjlRDjgtIG0lcMeJ+jyfwCIAQmRDdqKncZD1aFR5ad2/usr/4g1qAyDdmGi7XI8
 otK4zNcY+lY03gBJFVq81ctlsrKnpNY=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-329-avR9jT04M0Gc4dFwgBXpLw-1; Fri, 31 Jan 2020 10:58:46 -0500
Received: by mail-wr1-f69.google.com with SMTP id w6so3550802wrm.16
 for <qemu-devel@nongnu.org>; Fri, 31 Jan 2020 07:58:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=ZvG9cUtGFJMaKZy2AzOfBIRnAqChnxsGlc3SyQcPSHo=;
 b=AQr4ckoU96Fk09RzMabeurNpnQb0CVMAuHR22a3uUAozmjWbB/uqQyb6Zrf4gOrd4N
 46qsjTjWMUxH73jz6UEGVTobVfRc581zlCW45KQDW1WKGkF1Y/PUDEQ5PLB9LuHgoJG4
 8tD9nHCKPMyla8ll2MVOXcUWzc2RhQweSc0Hvw8Rt2O4sVGLlc132KPNHu4iKUQX/S3G
 vfQExcLMDVKlEsdkZEJ4iALglS4gMsrPTx9GFSgkFiVQhNTdJyOA9sUh0EhGwnR8+URu
 xLPYYO+drAGYpBtn7jqrbPtR9VRlBo9t+ZTlBSthwjbtIKNW3XjBF2bZuIcK0bAfZBL6
 qCvQ==
X-Gm-Message-State: APjAAAUGgvwG53dCOY1cE33TmyP/CjRLtpihcCyh4M7oetBzLbSW/4fw
 QxhU7fdurCdImli3js+AHVGa4hUbzBGNEKPYRYlhcjR2q6Mj4687kdF2C5inK7xVZabvP+Q/rhJ
 27PBj1+Sd003+p+A=
X-Received: by 2002:a1c:20ce:: with SMTP id
 g197mr12989063wmg.172.1580486325036; 
 Fri, 31 Jan 2020 07:58:45 -0800 (PST)
X-Google-Smtp-Source: APXvYqyyzemwbnd6iw75JA+Rk+GtIKHL98S6QC47Rcjq4YX0T5e8QauMt6++uycizqKCKBbRo7CoDA==
X-Received: by 2002:a1c:20ce:: with SMTP id
 g197mr12989036wmg.172.1580486324799; 
 Fri, 31 Jan 2020 07:58:44 -0800 (PST)
Received: from [192.168.1.35] (113.red-83-57-172.dynamicip.rima-tde.net.
 [83.57.172.113])
 by smtp.gmail.com with ESMTPSA id s8sm11582030wrt.57.2020.01.31.07.58.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 31 Jan 2020 07:58:44 -0800 (PST)
Subject: Re: [PATCH v2 02/12] tests/docker: better handle symlinked libs
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20200130113223.31046-1-alex.bennee@linaro.org>
 <20200130113223.31046-3-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <8a1eb0c0-9fe4-0b6b-c1ca-28f48ec89512@redhat.com>
Date: Fri, 31 Jan 2020 16:58:42 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200130113223.31046-3-alex.bennee@linaro.org>
Content-Language: en-US
X-MC-Unique: avR9jT04M0Gc4dFwgBXpLw-1
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
Cc: fam@euphon.net, berrange@redhat.com, Robert Foley <robert.foley@linaro.org>,
 stefanb@linux.vnet.ibm.com, richard.henderson@linaro.org, f4bug@amsat.org,
 cota@braap.org, stefanha@redhat.com, marcandre.lureau@redhat.com,
 pbonzini@redhat.com, aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 1/30/20 12:32 PM, Alex Benn=C3=A9e wrote:
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

Rob raised an issue in this patch, it appears in a separated thread:
https://www.mail-archive.com/qemu-devel@nongnu.org/msg675307.html


