Return-Path: <SRS0=bFmd=ZT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA741C432C0
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2019 19:02:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A5D5620715
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2019 19:02:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nZroHFnV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5D5620715
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41952 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ia2aX-0000Fa-Qi
	for qemu-devel@archiver.kernel.org; Wed, 27 Nov 2019 14:02:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54651)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1ia2Yp-0007fr-3F
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 14:01:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1ia2Yn-0007wf-Lc
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 14:01:10 -0500
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:36888)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1ia2Yn-0007ue-DK
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 14:01:09 -0500
Received: by mail-wr1-x442.google.com with SMTP id g7so7287806wrw.4
 for <qemu-devel@nongnu.org>; Wed, 27 Nov 2019 11:01:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=3JVPC5jpJY/OicOiDqt11+4o3oRV+c/AI5ElAh5RNBY=;
 b=nZroHFnV+dHvSdtoGwZBld5Olfnf9JvzQhcBeKquaE3471UytREiLK4uqVNu9fVn0U
 e8VgdwHvR+w36XHAQ/hBQm55oZ3Kj5OcDQ7eiTC6KilRTBI14qoRyxYY6SIUTaSWqFvD
 ihLfxUf5gDFOe4R2JBKxqTaU9Yc6TMNQy+BbnJz7MAOdA2w8Vcdo+1mbLk+QgVmMyoXB
 sswAa7qYpmnWPvhyQwBAqiex4unfyDY6VRMgSKOxfrTu/kQXS9Ig2EMb4/bY52BNLF7v
 /GbjEXJYBUA5vCREZTrTgWdivbf1iX0wtqbhctthzbchOdeWtsL0N3hylp3Qw/HMLm/0
 Ywxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=3JVPC5jpJY/OicOiDqt11+4o3oRV+c/AI5ElAh5RNBY=;
 b=Y4dOHN5/YRKpdgEWgVtyu5q8z2A6zctHOPbqUdwUpnWMIXuQI6oc8388X/uay3vqzC
 Tu2hQHyd1WySnM9umrF6ayBPriTMEuKuZh/7KChEL1+lohlQR68p5T8SJCrtU1U+6nPA
 eEziTfIKmtzBJM2TfCIUMkmpxP6eEoUEu5M0pmfFcBo3TcA/CG4BC3aLQoB/CHUiS+f1
 Y2X0ZwKQxJUJX5LFx5xH6G1ASQytDsz/SrrJ/8e3DyRCfCMTiQJwrtMBlrx7wt+uANdO
 ai6vMN7ClVSWzPb99V8Nro5OLM6oQ5JHf58P2IlZ4V50uZTvLX9zkMFnxSquwZ41ayZS
 sLbw==
X-Gm-Message-State: APjAAAXUtD/oa9T/mYSoWKahvJC9Og8nvH/Yi3CzNiLBUIMIZI2JNkZ1
 Ad3+2c6B+VVBTXUishaSU/Wwpp3i9Jg=
X-Google-Smtp-Source: APXvYqzg31JRc5TEhYvBi4VVA81v3tXhDWxGL7oDkmJRaod3CdpQjeLwaPxhdQ0ECaavWlW8ltKGrw==
X-Received: by 2002:adf:fd84:: with SMTP id d4mr10493574wrr.211.1574881267121; 
 Wed, 27 Nov 2019 11:01:07 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id w11sm21663049wra.83.2019.11.27.11.01.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Nov 2019 11:01:05 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 17A471FF87;
 Wed, 27 Nov 2019 19:01:05 +0000 (GMT)
References: <20191116052815.nop3xkmd4umqsdsb@google.com>
User-agent: mu4e 1.3.5; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: Re: [PATCH] configure: Use lld --image-base for --disable-pie user
 mode binaries
In-reply-to: <20191116052815.nop3xkmd4umqsdsb@google.com>
Date: Wed, 27 Nov 2019 19:01:05 +0000
Message-ID: <87woblf8jy.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
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
Cc: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Fangrui Song <i@maskray.me> writes:

> For lld, --image-base is the preferred way to set the base address.
> lld does not actually implement -Ttext-segment, but treats it as an alias=
 for
> -Ttext. -Ttext-segment=3D0x60000000 combined with --no-rosegment can
> create a 1.6GB executable.
>
> Fix the problem by using --image-base for lld. GNU ld and gold will
> still get -Ttext-segment. Also delete the ld --verbose fallback introduced
> in 2013, which is no longer relevant or correct (the default linker
> script has changed).
>
> Signed-off-by: Fangrui Song <i@maskray.me>

This patch no longer applies cleanly to configure so I couldn't test it.

> ---
>   configure | 33 ++++++++++++---------------------
>   1 file changed, 12 insertions(+), 21 deletions(-)
>
> diff --git a/configure b/configure
> index 6099be1d84..2d45af0d09 100755
> --- a/configure
> +++ b/configure
> @@ -6336,43 +6336,34 @@ fi
>=20=20=20
>   # Probe for the need for relocating the user-only binary.
>   if ( [ "$linux_user" =3D yes ] || [ "$bsd_user" =3D yes ] ) && [ "$pie"=
 =3D no ]; then
> -  textseg_addr=3D
> +  image_base=3D
>     case "$cpu" in
>       arm | i386 | ppc* | s390* | sparc* | x86_64 | x32)
> -      # ??? Rationale for choosing this address
> -      textseg_addr=3D0x60000000
> +      # An arbitrary address that makes it unlikely to collide with user
> +      # programs.
> +      image_base=3D0x60000000

The comment probably belongs up above when we define the empty variable
unless it really is specifically about these targets.

Renaming textseg_addr seems like unnecessary churn for this patch.=20

>         ;;
>       mips)
>         # A 256M aligned address, high in the address space, with enough
>         # room for the code_gen_buffer above it before the stack.
> -      textseg_addr=3D0x60000000
> +      image_base=3D0x60000000
>         ;;
>     esac
> -  if [ -n "$textseg_addr" ]; then
> +  if [ -n "$image_base" ]; then
>       cat > $TMPC <<EOF
>       int main(void) { return 0; }
>   EOF
> -    textseg_ldflags=3D"-Wl,-Ttext-segment=3D$textseg_addr"
> -    if ! compile_prog "" "$textseg_ldflags"; then
> -      # In case ld does not support -Ttext-segment, edit the default lin=
ker
> -      # script via sed to set the .text start addr.  This is needed on F=
reeBSD
> -      # at least.
> -      if ! $ld --verbose >/dev/null 2>&1; then
> +    image_base_ldflags=3D"-Wl,--image-base=3D$image_base"
> +    if ! compile_prog "" "$image_base_ldflags"; then
> +      image_base_ldflags=3D"-Wl,-Ttext-segment=3D$image_base"
> +      if ! compile_prog "" "$image_base_ldflags"; then
>           error_exit \
>               "We need to link the QEMU user mode binaries at a" \
>               "specific text address. Unfortunately your linker" \
> -            "doesn't support either the -Ttext-segment option or" \
> -            "printing the default linker script with --verbose." \
> +            "supports neither --image-base nor -Ttext-segment. " \
>               "If you don't want the user mode binaries, pass the" \
>               "--disable-user option to configure."
>         fi
> -
> -      $ld --verbose | sed \
> -        -e '1,/=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D/d' \
> -        -e '/=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D/,$d' \
> -        -e "s/[.] =3D [0-9a-fx]* [+] SIZEOF_HEADERS/. =3D $textseg_addr =
+ SIZEOF_HEADERS/" \
> -        -e "s/__executable_start =3D [0-9a-fx]*/__executable_start =3D $=
textseg_addr/" > config-host.ld
> -      textseg_ldflags=3D"-Wl,-T../config-host.ld"
>       fi
>     fi
>   fi
> @@ -7945,7 +7936,7 @@ if test "$gprof" =3D "yes" ; then
>   fi
>=20=20=20
>   if test "$target_linux_user" =3D "yes" || test "$target_bsd_user" =3D "=
yes" ; then
> -  ldflags=3D"$ldflags $textseg_ldflags"
> +  ldflags=3D"$ldflags $image_base_ldflags"
>   fi
>=20=20=20
>   # Newer kernels on s390 check for an S390_PGSTE program header and


--=20
Alex Benn=C3=A9e

