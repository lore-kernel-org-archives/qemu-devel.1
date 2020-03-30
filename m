Return-Path: <SRS0=g3Vr=5P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF417C43331
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2020 09:25:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 89720206E6
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2020 09:25:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="r4FrTwHG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89720206E6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46972 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jIqfu-0003to-OM
	for qemu-devel@archiver.kernel.org; Mon, 30 Mar 2020 05:25:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38871)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jIqfH-0003TF-Pm
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 05:25:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1jIqfG-0000n1-5w
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 05:25:03 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:33183)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1jIqfF-0000mY-RS
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 05:25:02 -0400
Received: by mail-wr1-x442.google.com with SMTP id a25so20727122wrd.0
 for <qemu-devel@nongnu.org>; Mon, 30 Mar 2020 02:25:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=W5qnvgXrKg7gRZOgRs37VUCIGjEBPuxmiPn831ZnT+k=;
 b=r4FrTwHG0PTDSv65IWc87IVjerdeMXqU6CfkegjNQEescE14TB7dTNRo8rOzgf5Ckl
 WGmZe/y0i0aNKxf5qJZ1LNZHVIOVp3Arvx/gRjov/W0Xk7z7pTIn3yNKzXtIswOv3mil
 l6lzraWaCmRWxirTM0UVwu5lZV0/cyMCvTa7KhbRNA8Mxx1GK4q7L/Otk/oAJYuB/h0q
 gzW+vbK5kIy71N2I1mMEVXibSkQ+V6FNWFBCuOaRnJTw7cWC3thH5kbCtsXHcFsAZsR7
 sb2gsoOkBaQhHm9Sy75vQZl2ru2rHu5Z2i3yW2BHpgtj/KWSG3PpDNMe1aSYm5U6XR0U
 nU5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=W5qnvgXrKg7gRZOgRs37VUCIGjEBPuxmiPn831ZnT+k=;
 b=gLvtl/R3hOWdgZANx2PEHPwnyYoGA8/tKdI97mAMIhKxGkOLRskGEaWDKOG/TiVnsR
 DFn23SCi0Xa0YKpq29zHf6BcGHYijnPRzpygErqDGayS1Fv52g5ERlyWWKwbidrLpRFq
 G8C/pjoF8UPlZ8GfL2Ihaz+T4wL7A0+WDAsOEL/ROJiqwxwdqSEEExjQGCfdFyltBC+f
 rJnJ65f5aT4FBrIfH0ag8gQ8ZDk32rnpDFPHpmfTDgulgkma1f7mIJ22SOxFGQJrsC/H
 OKEutxqGyf7GEtAL/9dZhqwNhTT72AtkZbS+M9QSGtlPuOcX0SYPJZPsL2g+iq7nLUFA
 h9QA==
X-Gm-Message-State: ANhLgQ2ffNCnEnrX7UBqGtdfmeZ1tXzZBku4klQqBvLQvZeQ9WHqHZIr
 Eugs41gVIVNrJtz99TEtPjOBLg==
X-Google-Smtp-Source: ADFU+vtSLN8G1S3P4odmzUxU2awZ7SFX9XsYv0mPGJOjBrZc4WmhIvoGDtd01DiMsIG4qe0LfzvIGw==
X-Received: by 2002:adf:eb51:: with SMTP id u17mr14770581wrn.29.1585560300296; 
 Mon, 30 Mar 2020 02:25:00 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id k83sm9820838wma.3.2020.03.30.02.24.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Mar 2020 02:24:58 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 12B8C1FF7E;
 Mon, 30 Mar 2020 10:24:58 +0100 (BST)
References: <20200327220353.27233-1-richard.henderson@linaro.org>
 <20200327220353.27233-5-richard.henderson@linaro.org>
User-agent: mu4e 1.3.10; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH for-5.0 v3 4/7] configure: Always detect -no-pie
 toolchain support
In-reply-to: <20200327220353.27233-5-richard.henderson@linaro.org>
Date: Mon, 30 Mar 2020 10:24:57 +0100
Message-ID: <87k132gpp2.fsf@linaro.org>
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
 Thomas Huth <thuth@redhat.com>, dim@FreeBSD.org, qemu-devel@nongnu.org,
 roger.pau@citrix.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Richard Henderson <richard.henderson@linaro.org> writes:

> The CFLAGS_NOPIE and LDFLAGS_NOPIE variables are used
> in pc-bios/optionrom/Makefile, which has nothing to do
> with the PIE setting of the main qemu executables.
>
> This overrides any operating system default to build
> all executables as PIE, which is important for ROMs.
>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  configure | 18 ++++++++----------
>  1 file changed, 8 insertions(+), 10 deletions(-)
>
> diff --git a/configure b/configure
> index cbde833f6e..7ba18783cb 100755
> --- a/configure
> +++ b/configure
> @@ -2107,26 +2107,24 @@ if ! compile_prog "-Werror" "" ; then
>  	"Thread-Local Storage (TLS). Please upgrade to a version that does."
>  fi
>=20=20
> -if test "$pie" !=3D "no" ; then
> -  cat > $TMPC << EOF
> +cat > $TMPC << EOF
>=20=20
>  #ifdef __linux__
>  #  define THREAD __thread
>  #else
>  #  define THREAD
>  #endif
> -
>  static THREAD int tls_var;
> -
>  int main(void) { return tls_var; }
> -
>  EOF
> -  # check we support --no-pie first...
> -  if compile_prog "-Werror -fno-pie" "-no-pie"; then
> -    CFLAGS_NOPIE=3D"-fno-pie"
> -    LDFLAGS_NOPIE=3D"-nopie"
> -  fi
>=20=20
> +# Check we support --no-pie first; we will need this for building ROMs.
> +if compile_prog "-Werror -fno-pie" "-no-pie"; then
> +  CFLAGS_NOPIE=3D"-fno-pie"
> +  LDFLAGS_NOPIE=3D"-no-pie"
> +fi
> +
> +if test "$pie" !=3D "no" ; then
>    if compile_prog "-fPIE -DPIE" "-pie"; then
>      QEMU_CFLAGS=3D"-fPIE -DPIE $QEMU_CFLAGS"
>      QEMU_LDFLAGS=3D"-pie $QEMU_LDFLAGS"


--=20
Alex Benn=C3=A9e

