Return-Path: <SRS0=ZO09=24=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24AC6C33C8C
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 12:36:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E21092072A
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 12:36:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="o/sjNe+1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E21092072A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47886 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ioo5f-0006fK-Bj
	for qemu-devel@archiver.kernel.org; Tue, 07 Jan 2020 07:36:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42068)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1ion7p-00080t-FF
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 06:34:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1ion7n-0003p4-2Y
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 06:34:17 -0500
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:36057)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1ion7m-0003oK-Qs
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 06:34:15 -0500
Received: by mail-wm1-x342.google.com with SMTP id p17so19014632wma.1
 for <qemu-devel@nongnu.org>; Tue, 07 Jan 2020 03:34:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=n6yfo28ViAZu9pFTT+o1vMt8ymW7JeFvs8LMzFVkFB0=;
 b=o/sjNe+1qeEyenddx/oiKqJyjHyLLnq1wQDY1swUVXoVl5OF99f+W76Mz8yyVNeICq
 Ln3DB6pPJ99FjNvDFvhbJetshzHrHZddoiAhwdmI1cHMB1U9Tz1S3MrJWLFJdGCj+j4U
 gYhK6n/AHishMp+4lkarpDOQhVTDoC06MsNqnaKGAFj3hRfB3HOlIcIvoPErkhfTQ4Kk
 k3VyzWNdkBoJyQfjfbe+uavbNTiaTFWynuCeRHzeYB5f3j/NvPeGS7VRpLo6UUy7Z9GP
 LJkmq8rvweQT/71GoaVGzNh+pqCSbAJzfYqCmjEszAMxOfDiLCz6haxLz+QhaReBju4o
 iSLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=n6yfo28ViAZu9pFTT+o1vMt8ymW7JeFvs8LMzFVkFB0=;
 b=NNA0aISDrtcMeJEEENaU6Ut5Ljf7vHwh8F7MWHE5zP3ChXSM8pu/x4ebdZK3xKioiG
 mkfFDRRjtzoYRD/rKVj7N/yzK02dEN9dgRqsma8k5qlo7ZxfRYxyLgC1oOu7dRHogRnl
 FhklHXPXfxYugm1NwQah+XWMaW7SM4ZqzIMjr+c36z+JKqcIsxisb63kZ7KJ8K4uWKIi
 4FRb1vhY+PnViEj3IauH/Q6RDWqUannNHpuNotfAv96TLtm7Xi7XAB0EsiHcHl7hRebC
 rHFyTrcv6M084il+EE4SZRLcPjul6D2qAB0xZTR86SRd9bHeokDMz0vJDV7V5/2vbZuN
 IcOg==
X-Gm-Message-State: APjAAAWW2bhm3SMlcShLisvrqVeEepcRs+Bt+XAmXozCNro6zMwAYXNi
 UEFi1dvMUSpSjeKJCUxjI0Gx/3Z5d+g=
X-Google-Smtp-Source: APXvYqxC/T1QJwOGinO/+rnNumtLB2dP22nACh0jTEtjZIrp3PzmY37GkP9qR2epBkjCd2JsNm6zTQ==
X-Received: by 2002:a7b:c407:: with SMTP id k7mr40574361wmi.46.1578396853324; 
 Tue, 07 Jan 2020 03:34:13 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id 2sm78263013wrq.31.2020.01.07.03.34.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jan 2020 03:34:12 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 61CD01FF87;
 Tue,  7 Jan 2020 11:34:11 +0000 (GMT)
References: <20191218223441.23852-1-richard.henderson@linaro.org>
 <20191218223441.23852-2-richard.henderson@linaro.org>
User-agent: mu4e 1.3.6; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: Re: [PATCH v2 1/7] configure: Drop adjustment of textseg
In-reply-to: <20191218223441.23852-2-richard.henderson@linaro.org>
Date: Tue, 07 Jan 2020 11:34:11 +0000
Message-ID: <87woa34i18.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
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
Cc: berrange@redhat.com, Thomas Huth <thuth@redhat.com>, i@maskray.me,
 philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Richard Henderson <richard.henderson@linaro.org> writes:

> This adjustment was random and unnecessary.  The user mode
> startup code in probe_guest_base() will choose a value for
> guest_base that allows the host qemu binary to not conflict
> with the guest binary.
>
> With modern distributions, this isn't even used, as the default
> is PIE, which does the same job in a more portable way.
>
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
> v2: Remove mention of config-host.ld from make distclean
> ---
>  Makefile  |  2 +-
>  configure | 47 -----------------------------------------------
>  2 files changed, 1 insertion(+), 48 deletions(-)
>
> diff --git a/Makefile b/Makefile
> index 1361def144..adf83f75a1 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -735,7 +735,7 @@ rm -f $(MANUAL_BUILDDIR)/$1/objects.inv $(MANUAL_BUIL=
DDIR)/$1/searchindex.js $(M
>  endef
>=20=20
>  distclean: clean
> -	rm -f config-host.mak config-host.h* config-host.ld $(DOCS) qemu-option=
s.texi qemu-img-cmds.texi qemu-monitor.texi qemu-monitor-info.texi
> +	rm -f config-host.mak config-host.h* $(DOCS) qemu-options.texi qemu-img=
-cmds.texi qemu-monitor.texi qemu-monitor-info.texi
>  	rm -f tests/tcg/config-*.mak
>  	rm -f config-all-devices.mak config-all-disas.mak config.status
>  	rm -f $(SUBDIR_DEVICES_MAK)
> diff --git a/configure b/configure
> index e0c66ee9b6..30e3875c6b 100755
> --- a/configure
> +++ b/configure
> @@ -6298,49 +6298,6 @@ if test "$cpu" =3D "s390x" ; then
>    fi
>  fi
>=20=20
> -# Probe for the need for relocating the user-only binary.
> -if ( [ "$linux_user" =3D yes ] || [ "$bsd_user" =3D yes ] ) && [ "$pie" =
=3D no ]; then
> -  textseg_addr=3D
> -  case "$cpu" in
> -    arm | i386 | ppc* | s390* | sparc* | x86_64 | x32)
> -      # ??? Rationale for choosing this address
> -      textseg_addr=3D0x60000000
> -      ;;
> -    mips)
> -      # A 256M aligned address, high in the address space, with enough
> -      # room for the code_gen_buffer above it before the stack.
> -      textseg_addr=3D0x60000000
> -      ;;
> -  esac
> -  if [ -n "$textseg_addr" ]; then
> -    cat > $TMPC <<EOF
> -    int main(void) { return 0; }
> -EOF
> -    textseg_ldflags=3D"-Wl,-Ttext-segment=3D$textseg_addr"
> -    if ! compile_prog "" "$textseg_ldflags"; then
> -      # In case ld does not support -Ttext-segment, edit the default lin=
ker
> -      # script via sed to set the .text start addr.  This is needed on F=
reeBSD
> -      # at least.
> -      if ! $ld --verbose >/dev/null 2>&1; then
> -        error_exit \
> -            "We need to link the QEMU user mode binaries at a" \
> -            "specific text address. Unfortunately your linker" \
> -            "doesn't support either the -Ttext-segment option or" \
> -            "printing the default linker script with --verbose." \
> -            "If you don't want the user mode binaries, pass the" \
> -            "--disable-user option to configure."
> -      fi
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
> -    fi
> -  fi
> -fi
> -
>  # Check that the C++ compiler exists and works with the C compiler.
>  # All the QEMU_CXXFLAGS are based on QEMU_CFLAGS. Keep this at the end t=
o don't miss any other that could be added.
>  if has $cxx; then
> @@ -7903,10 +7860,6 @@ if test "$gprof" =3D "yes" ; then
>    fi
>  fi
>=20=20
> -if test "$target_linux_user" =3D "yes" || test "$target_bsd_user" =3D "y=
es" ; then
> -  ldflags=3D"$ldflags $textseg_ldflags"
> -fi
> -
>  # Newer kernels on s390 check for an S390_PGSTE program header and
>  # enable the pgste page table extensions in that case. This makes
>  # the vm.allocate_pgste sysctl unnecessary. We enable this program


--=20
Alex Benn=C3=A9e

