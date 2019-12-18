Return-Path: <SRS0=xKpV=2I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49072C43603
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 17:59:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1674F206D7
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 17:59:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aa3phtQo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1674F206D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58600 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihdbB-0004FA-9W
	for qemu-devel@archiver.kernel.org; Wed, 18 Dec 2019 12:59:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41446)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1ihdaI-0002z5-06
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 12:58:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1ihdaG-0000oZ-74
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 12:58:05 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:26545
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1ihdaG-0000iv-1e
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 12:58:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576691882;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1AFdKv4SJV4pL7Hv2b/wAsUZmN2dDxQEJN02HJVdn0o=;
 b=aa3phtQoEch7PggOuEjThf0TQpcbJSS2D0OpQN9Ab+yA00qIQjwFf7onB8mKUDqWrlPigF
 vXy1ziB+kyLlJvm21c1BvNCxsyY0dBEX2Nkw698orQXfVSHZyOmG0X5E+8+bUy1pK4jZfk
 XgDvaI2KGnEE/XMHGU/eOXlxChwODQw=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-276-5a3toIvPNV-HTAUSI1v9aw-1; Wed, 18 Dec 2019 12:58:01 -0500
Received: by mail-wr1-f72.google.com with SMTP id o6so1177509wrp.8
 for <qemu-devel@nongnu.org>; Wed, 18 Dec 2019 09:58:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=c7/FtO+roA8NfAvO8mNC1fACPEX2k2PEpd7+ffClD7g=;
 b=IYqWQH7i6t3tOk07kDqumSEdskAS/VDvE+JwfHEiWfkqa1gryOjy0BAbF81RLIJEPM
 jvv8iS4N1rdDhqMgZvj6EM8zj6Pad1NnE5pueywzG0j/CrrN6RuFpywvm2NjJ3aiUkBv
 Zdly1itXui//YYt/5PGPJcOUlPpaHMcglZU6VXMLBtE7h2IgS0VyU8DjzfUwfHtdna7V
 Cxv3fx2DAObm8w+rcuTS6dF4I1YMU73BUNAx9aB5Ww1I/tKyrbq71uhS7RNlqJOrNL3H
 jYzEOQiqj9zMkWazzUC2OaZFG2kviRujj2BT18aS6fw7XM5JuUOxcwuKKiSw5r9uHdpc
 xD+A==
X-Gm-Message-State: APjAAAV3a/HHa2cjI1pZVMkIen6Bx5OfKuhLtf6Is9jmo78nemua3ew+
 e9nCd4M3pMb2wA484cdSef7no6TnNultohR7xRS2Yf4nB+Jq/bwc8zhp9kCo3h429A1Udt52MYa
 jaHebTc8X/XTgzlI=
X-Received: by 2002:a5d:4d06:: with SMTP id z6mr4143687wrt.339.1576691880116; 
 Wed, 18 Dec 2019 09:58:00 -0800 (PST)
X-Google-Smtp-Source: APXvYqzXYOf8SwmDJ8N6wac+1G60AVNm4Uur1Z2YKj61t9db+P9dDlXYvinKFD8/DRW5oremoKTFyg==
X-Received: by 2002:a5d:4d06:: with SMTP id z6mr4143654wrt.339.1576691879834; 
 Wed, 18 Dec 2019 09:57:59 -0800 (PST)
Received: from [192.168.1.35] (34.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.34])
 by smtp.gmail.com with ESMTPSA id p7sm3216944wmp.31.2019.12.18.09.57.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 18 Dec 2019 09:57:59 -0800 (PST)
Subject: Re: [PATCH 6/7] configure: Override the os default with --disable-pie
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20191218031920.6414-1-richard.henderson@linaro.org>
 <20191218031920.6414-7-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <2cdc6931-2a97-a3ed-84f2-607e34cd4271@redhat.com>
Date: Wed, 18 Dec 2019 18:57:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191218031920.6414-7-richard.henderson@linaro.org>
Content-Language: en-US
X-MC-Unique: 5a3toIvPNV-HTAUSI1v9aw-1
X-Mimecast-Spam-Score: 0
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
Cc: i@maskray.me, berrange@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/18/19 4:19 AM, Richard Henderson wrote:
> Some distributions, e.g. Ubuntu 19.10, enable PIE by default.
> If for some reason one wishes to build a non-pie binary, we
> must provide additional options to override.
>=20
> At the same time, reorg the code to an elif chain.
>=20
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   configure | 25 ++++++++++++-------------
>   1 file changed, 12 insertions(+), 13 deletions(-)
>=20
> diff --git a/configure b/configure
> index f8981eec15..1645a58b3a 100755
> --- a/configure
> +++ b/configure
> @@ -2029,19 +2029,18 @@ if compile_prog "-Werror -fno-pie" "-no-pie"; the=
n
>     LDFLAGS_NOPIE=3D"-no-pie"
>   fi
>  =20
> -if test "$pie" !=3D "no" ; then
> -  if compile_prog "-fPIE -DPIE" "-pie"; then
> -    QEMU_CFLAGS=3D"-fPIE -DPIE $QEMU_CFLAGS"
> -    LDFLAGS=3D"-pie $LDFLAGS"
> -    pie=3D"yes"
> -  else
> -    if test "$pie" =3D "yes"; then
> -      error_exit "PIE not available due to missing toolchain support"
> -    else
> -      echo "Disabling PIE due to missing toolchain support"
> -      pie=3D"no"
> -    fi
> -  fi
> +if test "$pie" =3D "no"; then
> +  QEMU_CFLAGS=3D"$CFLAGS_NOPIE $QEMU_CFLAGS"
> +  LDFLAGS=3D"$LDFLAGS_NOPIE $LDFLAGS"
> +elif compile_prog "-fPIE -DPIE" "-pie"; then
> +  QEMU_CFLAGS=3D"-fPIE -DPIE $QEMU_CFLAGS"
> +  LDFLAGS=3D"-pie $LDFLAGS"
> +  pie=3D"yes"
> +elif test "$pie" =3D "yes"; then
> +  error_exit "PIE not available due to missing toolchain support"
> +else
> +  echo "Disabling PIE due to missing toolchain support"
> +  pie=3D"no"
>   fi
>  =20
>   # Detect support for DT_BIND_NOW.
>=20

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>


