Return-Path: <SRS0=dCqM=2Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02ADEC2D0C2
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jan 2020 16:49:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C1F4A2072C
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jan 2020 16:49:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fK/JaEt7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1F4A2072C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54404 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1inQ8w-00047R-TY
	for qemu-devel@archiver.kernel.org; Fri, 03 Jan 2020 11:49:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47819)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1inQ7h-00039Q-2r
 for qemu-devel@nongnu.org; Fri, 03 Jan 2020 11:48:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1inQ7f-0004aI-Or
 for qemu-devel@nongnu.org; Fri, 03 Jan 2020 11:48:28 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:55460
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1inQ7f-0004YA-JS
 for qemu-devel@nongnu.org; Fri, 03 Jan 2020 11:48:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578070106;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MCIzWLWQEEXNXZBcg2NUcuTehoT0bsT27Et9kJxZkfc=;
 b=fK/JaEt7R79JTTrAk9i9GUhxxwT7hD5B4PXJHD7fsF9TP3/2/dMiWDAeNCLaGu5fxJ/pdI
 DOSVfjrQuytwtKZkcJBMjC2AMbTyNzDr64Lt2yX3yJY6sXp0MTpHCTnHzm08B831qd0aq3
 4jINBCv7V3OfT2HFhXdFzPQQWiCxqQc=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-54-WSU4iDPnOgewHU8UcRzZiw-1; Fri, 03 Jan 2020 11:48:23 -0500
Received: by mail-wr1-f71.google.com with SMTP id f15so8978131wrr.2
 for <qemu-devel@nongnu.org>; Fri, 03 Jan 2020 08:48:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=yJ6XoJz7JtCoUc58IsVBOjYuDpS/z//PD2NM95wQfFE=;
 b=bW8UHPq0h6BljnAW6vUi3cKg0VQKuXMKRdanQZjZPLVYssWt7J/Osg0eL1qd9PNqF5
 uH5pzXEv53/l5fbut7UAIrep43mIV/+7yy/qpQA7EKWxxkA16j5K1/qaCi/By9Et7xiY
 TK6a7t3lvPBfEu67w+CsasLM74QDbDGP27lDsmpYBvMF6fK2jG0OlYvosMs+1c8rrQFn
 gSB+H3Nk+COsMVpgdyj3qI6lAViFY4TXtVpQfj5HaE5sPpDf9xQaFnKBlazc9wsfIb92
 QGL/taV/ZTDc/EiMiA6VVm4RLC/vabbpWyKeITyH3QR+8cykuiwsxBN21TBe9b5zz4EW
 E9uw==
X-Gm-Message-State: APjAAAUX2nQ5szooQ55wAofnrc+L1GjIfoNtcmYSCHmRBS4fpG9jPeDj
 WUmKgjuprjwxBul6ndq6aqig/6vJQKTRnM1njioDHRIYcfy96G6I3CPL9eTFrdeHLbZIUOuPTw0
 4zB9h3IqkYopDW8I=
X-Received: by 2002:a1c:ddc5:: with SMTP id u188mr19481888wmg.83.1578070102082; 
 Fri, 03 Jan 2020 08:48:22 -0800 (PST)
X-Google-Smtp-Source: APXvYqyTV4pcxPE4TxzNnCGVVBHlCBo18nZgW+tJwfSxG+2vvkUHqYV4EWyF4lYhQPMkY3bmcejqnw==
X-Received: by 2002:a1c:ddc5:: with SMTP id u188mr19481873wmg.83.1578070101878; 
 Fri, 03 Jan 2020 08:48:21 -0800 (PST)
Received: from [192.168.1.35] (34.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.34])
 by smtp.gmail.com with ESMTPSA id g21sm65590816wrb.48.2020.01.03.08.48.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 03 Jan 2020 08:48:21 -0800 (PST)
Subject: Re: [PATCH v6 13/21] fuzz: add configure flag --enable-fuzzing
To: "Oleinik, Alexander" <alxndr@bu.edu>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
References: <20191129213424.6290-1-alxndr@bu.edu>
 <20191129213424.6290-14-alxndr@bu.edu>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <7dacee3e-92b3-cd12-90b9-e0a409d44f4f@redhat.com>
Date: Fri, 3 Jan 2020 17:48:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191129213424.6290-14-alxndr@bu.edu>
Content-Language: en-US
X-MC-Unique: WSU4iDPnOgewHU8UcRzZiw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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
Cc: "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "bsd@redhat.com" <bsd@redhat.com>, "stefanha@redhat.com" <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/29/19 10:34 PM, Oleinik, Alexander wrote:
> Signed-off-by: Alexander Bulekov <alxndr@bu.edu>
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>   configure | 39 +++++++++++++++++++++++++++++++++++++++
>   1 file changed, 39 insertions(+)
>=20
> diff --git a/configure b/configure
> index 6099be1d84..5fb2494a8e 100755
> --- a/configure
> +++ b/configure
> @@ -504,6 +504,7 @@ debug_mutex=3D"no"
>   libpmem=3D""
>   default_devices=3D"yes"
>   plugins=3D"no"
> +fuzzing=3D"no"
>  =20
>   supported_cpu=3D"no"
>   supported_os=3D"no"
> @@ -633,6 +634,15 @@ int main(void) { return 0; }
>   EOF
>   }
>  =20
> +write_c_fuzzer_skeleton() {
> +    cat > $TMPC <<EOF
> +#include <stdint.h>
> +#include <sys/types.h>
> +int LLVMFuzzerTestOneInput(const uint8_t *Data, size_t Size);
> +int LLVMFuzzerTestOneInput(const uint8_t *Data, size_t Size) { return 0;=
 }
> +EOF
> +}
> +
>   if check_define __linux__ ; then
>     targetos=3D"Linux"
>   elif check_define _WIN32 ; then
> @@ -1539,6 +1549,10 @@ for opt do
>     ;;
>     --disable-plugins) plugins=3D"no"
>     ;;
> +  --enable-fuzzing) fuzzing=3Dyes
> +  ;;
> +  --disable-fuzzing) fuzzing=3Dno
> +  ;;
>     *)
>         echo "ERROR: unknown option $opt"
>         echo "Try '$0 --help' for more information"
> @@ -6018,6 +6032,15 @@ EOF
>     fi
>   fi
>  =20
> +##########################################
> +# checks for fuzzer
> +if test "$fuzzing" =3D "yes" ; then
> +  write_c_fuzzer_skeleton
> +  if compile_prog "$CPU_CFLAGS -Werror -fsanitize=3Daddress,fuzzer" ""; =
then
> +      have_fuzzer=3Dyes
> +  fi
> +fi
> +
>   ##########################################
>   # check for libpmem
>  =20
> @@ -6599,6 +6622,7 @@ echo "libpmem support   $libpmem"
>   echo "libudev           $libudev"
>   echo "default devices   $default_devices"
>   echo "plugin support    $plugins"
> +echo "fuzzing support   $fuzzing"
>  =20
>   if test "$supported_cpu" =3D "no"; then
>       echo
> @@ -7435,6 +7459,16 @@ fi
>   if test "$sheepdog" =3D "yes" ; then
>     echo "CONFIG_SHEEPDOG=3Dy" >> $config_host_mak
>   fi
> +if test "$fuzzing" =3D "yes" ; then
> +  if test "$have_fuzzer" =3D "yes"; then
> +    FUZZ_LDFLAGS=3D" -fsanitize=3Daddress,fuzzer"
> +    FUZZ_CFLAGS=3D" -fsanitize=3Daddress,fuzzer"
> +    CFLAGS=3D" -fsanitize=3Daddress"
> +  else
> +    error_exit "Your compiler doesn't support -fsanitize=3Daddress,fuzze=
r"
> +    exit 1
> +  fi
> +fi
>  =20
>   if test "$plugins" =3D "yes" ; then
>       echo "CONFIG_PLUGIN=3Dy" >> $config_host_mak
> @@ -7538,6 +7572,11 @@ if test "$libudev" !=3D "no"; then
>       echo "CONFIG_LIBUDEV=3Dy" >> $config_host_mak
>       echo "LIBUDEV_LIBS=3D$libudev_libs" >> $config_host_mak
>   fi
> +if test "$fuzzing" !=3D "no"; then

I'd use '=3D "yes"' here to stay consistent.
Anyway:
Reviewed-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>

> +    echo "CONFIG_FUZZ=3Dy" >> $config_host_mak
> +    echo "FUZZ_CFLAGS=3D$FUZZ_CFLAGS" >> $config_host_mak
> +    echo "FUZZ_LDFLAGS=3D$FUZZ_LDFLAGS" >> $config_host_mak
> +fi
>  =20
>   if test "$edk2_blobs" =3D "yes" ; then
>     echo "DECOMPRESS_EDK2_BLOBS=3Dy" >> $config_host_mak
>=20


