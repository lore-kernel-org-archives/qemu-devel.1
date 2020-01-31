Return-Path: <SRS0=aXOp=3U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0922FC2D0DB
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2020 16:14:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C60F0214D8
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2020 16:14:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YSfxhXo3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C60F0214D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55578 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ixYwV-0001s7-VZ
	for qemu-devel@archiver.kernel.org; Fri, 31 Jan 2020 11:14:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58689)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1ixYex-0000IW-Jz
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 10:56:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1ixYes-0007O9-Hc
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 10:56:43 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:59838
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1ixYes-0007Nl-E7
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 10:56:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580486198;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OXs12+oin74tleKQ4xnOKPJ0L2VwcLTuGhOrnZlehqk=;
 b=YSfxhXo36sbjbxMZvhuv61d3gZ9kphmzXXhI/y6/+4UURcHDJ/+DE1g5LI5719wSEnQb5j
 Kgj6FpXZkQJvJwy3FGQiIr5p8Fy0pAvAa/lQfGLfuZYVsGyvNl2KmRUMDsUykwCzvRFMyi
 mbsdXzO1porVK5bTaZgBYhqRpdbpjY8=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-149-bTLsVLKLNViQ2vfl8aBZnA-1; Fri, 31 Jan 2020 10:56:31 -0500
Received: by mail-wr1-f71.google.com with SMTP id u18so3528459wrn.11
 for <qemu-devel@nongnu.org>; Fri, 31 Jan 2020 07:56:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=xbQ5eHDLjLp+9UP9Wdfm1MVD79Tb9TKa55ihsDL0cmU=;
 b=h6p5xEEblsc71U+nqg59pXO7JD0NcmYpuVDtGs2dpc2uYj99fGaqcEkcl4Id1msH25
 wkf65avQT2LpLmRnhNSCQJpbCWhFROR/N9iF2LDHnFsvO60DVKhTtaFmqnzS981JJdHO
 6SH3Sd5TDLd01oLcVBxO1U5Y+2X+3LqzN8nkiuBCpD4YIabWvPhs/gyd6yjREhrDsYr9
 N6YoKmbv/SvrlILWcnkURGkxvlq91qF4TmRiCHEWxhSKdscImmZ+TdKfwpO/UVfjtO9/
 wON/C8HKXoftMfqL2Zfup0q1vgWajWFdcnXxGFfLDyoPAdr/nAoUF5oo0M8fE2+lsXlK
 l5rA==
X-Gm-Message-State: APjAAAU9EWsWwGdx4jNTiG4hGJD9Ef1cvCyQ3mzOB+4GFvSB5zBgoUud
 xQpM8/WBNpf7Wk9LyXU0CesM5EnNc/2R7LzrwqTzfj8lTu6N5ooBrn+KXQYKFsQKsuIMhaFVied
 I+lZWidTmwXzuEWY=
X-Received: by 2002:adf:edd0:: with SMTP id v16mr12637522wro.310.1580486190532; 
 Fri, 31 Jan 2020 07:56:30 -0800 (PST)
X-Google-Smtp-Source: APXvYqzVBrNPsidzyCgmQ6DldQbTUuZBOh4dqdzeCy3GaI2nzUtOgrkigwTjkEY2PNlVE5V1T5zGSA==
X-Received: by 2002:adf:edd0:: with SMTP id v16mr12637490wro.310.1580486190234; 
 Fri, 31 Jan 2020 07:56:30 -0800 (PST)
Received: from [192.168.1.35] (113.red-83-57-172.dynamicip.rima-tde.net.
 [83.57.172.113])
 by smtp.gmail.com with ESMTPSA id s139sm11806830wme.35.2020.01.31.07.56.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 31 Jan 2020 07:56:29 -0800 (PST)
Subject: Re: [PATCH v2 04/12] travis.yml: Install genisoimage package
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20200130113223.31046-1-alex.bennee@linaro.org>
 <20200130113223.31046-5-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <278a8bf4-8dd0-a15a-9440-7d34da746548@redhat.com>
Date: Fri, 31 Jan 2020 16:56:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200130113223.31046-5-alex.bennee@linaro.org>
Content-Language: en-US
X-MC-Unique: bTLsVLKLNViQ2vfl8aBZnA-1
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
Cc: fam@euphon.net, berrange@redhat.com, stefanb@linux.vnet.ibm.com,
 richard.henderson@linaro.org, f4bug@amsat.org,
 Wainer dos Santos Moschetta <wainersm@redhat.com>, cota@braap.org,
 stefanha@redhat.com, marcandre.lureau@redhat.com, pbonzini@redhat.com,
 aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 1/30/20 12:32 PM, Alex Benn=C3=A9e wrote:
> From: Wainer dos Santos Moschetta <wainersm@redhat.com>
>=20
> The genisoimage program is required for tests/cdrom-test
> tests, otherwise they are skipped. The current Travis
> environments do not provide it by default, so let's
> explicitly require the genisoimage package.
>=20
> Signed-off-by: Wainer dos Santos Moschetta <wainersm@redhat.com>
> Message-Id: <20200110191254.11303-2-wainersm@redhat.com>
> ---
>   .travis.yml | 8 ++++++++
>   1 file changed, 8 insertions(+)
>=20
> diff --git a/.travis.yml b/.travis.yml
> index 1ae645e9fc..e75c979b6c 100644
> --- a/.travis.yml
> +++ b/.travis.yml
> @@ -51,6 +51,8 @@ addons:
>         - sparse
>         - uuid-dev
>         - gcovr
> +      # Tests dependencies
> +      - genisoimage
>  =20
>  =20
>   # The channel name "irc.oftc.net#qemu" is encrypted against qemu/qemu
> @@ -383,6 +385,8 @@ matrix:
>             - libusb-1.0-0-dev
>             - libvdeplug-dev
>             - libvte-2.91-dev
> +          # Tests dependencies
> +          - genisoimage
>         env:
>           - TEST_CMD=3D"make check check-tcg V=3D1"
>           - CONFIG=3D"--disable-containers --target-list=3D${MAIN_SOFTMMU=
_TARGETS}"
> @@ -412,6 +416,8 @@ matrix:
>             - libusb-1.0-0-dev
>             - libvdeplug-dev
>             - libvte-2.91-dev
> +          # Tests dependencies
> +          - genisoimage
>         env:
>           - TEST_CMD=3D"make check check-tcg V=3D1"
>           - CONFIG=3D"--disable-containers --target-list=3D${MAIN_SOFTMMU=
_TARGETS},ppc64le-linux-user"
> @@ -441,6 +447,8 @@ matrix:
>             - libusb-1.0-0-dev
>             - libvdeplug-dev
>             - libvte-2.91-dev
> +          # Tests dependencies
> +          - genisoimage
>         env:
>           - TEST_CMD=3D"make check check-tcg V=3D1"
>           - CONFIG=3D"--disable-containers --target-list=3D${MAIN_SOFTMMU=
_TARGETS},s390x-linux-user"
>=20

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>


