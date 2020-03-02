Return-Path: <SRS0=YPEG=4T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2934FC3F2D1
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 11:08:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E88632080C
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 11:08:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Pm3sL26j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E88632080C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58714 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j8iw4-0003bD-4a
	for qemu-devel@archiver.kernel.org; Mon, 02 Mar 2020 06:08:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59449)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1j8iv7-0002jw-BL
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 06:07:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1j8iv6-0007Oo-6Y
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 06:07:33 -0500
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:42281)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1j8iv6-0007O0-0J
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 06:07:32 -0500
Received: by mail-wr1-x443.google.com with SMTP id z11so3264928wro.9
 for <qemu-devel@nongnu.org>; Mon, 02 Mar 2020 03:07:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=srJ9yulfLeWETl9XADoKD3jE0xA5oIgcohUzS0AGF3Q=;
 b=Pm3sL26jwZvQHcsWYewn0WJ8R4LnVYbJPfIKbu1HHcXWUkpymqjb0o2oEATcp0MLcS
 pEpmDxfsUsoaP9inW//fdHgzuoSh80Vw5xQ/a3d9OpS8HW7GZ/EYuHUuyM9Nu1YFIUUg
 KLPu9P3ePyBOtCrdmmogeo89Wg4cGEiglU8K6p0k9ICer0uJMt2qnAIPpecbdaESTUrl
 dK9BJKxe+7ZB3Hf0gZShzGZlBvDK3sPrMTggw2efwceibfbhGD+pJMt+vT+nZVOTQHif
 OXdYgGmRbhHdrrlorwf+k/Q6sXE8/T1WyqcEJunZ0dKzgLrGg7f6hEbRXQ1MkhdxvLZQ
 +OOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=srJ9yulfLeWETl9XADoKD3jE0xA5oIgcohUzS0AGF3Q=;
 b=ffrg7DRu4zxyObwXbglzu+L3McFePJ16Jb6MrxtZ4kXJUrHA2z+zJGz46Xw8t/v0Hy
 2RIcS0wGF6+bJCNjPA41oslOXTuCo6IO2zPSrvZx7upndONtb7Ss2ZV3TDrAsppxBb9g
 puc+PWFjtamQEHuCYCCXI36NomnOOWGXGnBlBXvz3li06M36AgBKOCoV031XaPkzuMdP
 HnYetMyapbko4hq8cZg8AH06x8k/3EQnBxFTDfJGXAmISzC8Yukmrb9BjNox1aYQptmY
 3n5orRHLa8InQqRq5wxIi8o9m9joAa2a6BKgj516pjV5pTpRJuoRxAsONh69gcWPvYqf
 c57Q==
X-Gm-Message-State: ANhLgQ3gXM2c5PlLGuZ28F80m6j+BXqg2Qj0FR5F4VOqu3ZJFW/9juRr
 4lwJqPqoTsDNZQOl58O0/Fezwg==
X-Google-Smtp-Source: ADFU+vuBAPeXR4mJJoUrFhNVtUrC5a/dzVr14cl6K4BupfK4aO6jSqCpcUQVe+KPOfrKd+b7e9gzEA==
X-Received: by 2002:a5d:5012:: with SMTP id e18mr11925579wrt.419.1583147250969; 
 Mon, 02 Mar 2020 03:07:30 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id n3sm15320717wmc.42.2020.03.02.03.07.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Mar 2020 03:07:29 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id C8F451FF87;
 Mon,  2 Mar 2020 11:07:28 +0000 (GMT)
References: <20200228153619.9906-1-peter.maydell@linaro.org>
 <20200228153619.9906-4-peter.maydell@linaro.org>
User-agent: mu4e 1.3.9; emacs 27.0.90
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH v3 03/33] texi2pod: parse @include directives outside
 "@c man" blocks
In-reply-to: <20200228153619.9906-4-peter.maydell@linaro.org>
Date: Mon, 02 Mar 2020 11:07:28 +0000
Message-ID: <8736arc8wf.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 Kashyap Chamarthy <kchamart@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Peter Maydell <peter.maydell@linaro.org> writes:

> From: Paolo Bonzini <pbonzini@redhat.com>
>
> This enables splitting the huge qemu-doc.texi file and keeping parallel
> Texinfo and rST versions of the documentation.  texi2pod is not going to
> live much longer and hardly anyone cares about its upstream status,
> so the temporary fork should be acceptable.
>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> Message-id: 20200226113034.6741-4-pbonzini@redhat.com
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  scripts/texi2pod.pl | 36 ++++++++++++++++++------------------
>  1 file changed, 18 insertions(+), 18 deletions(-)
>
> diff --git a/scripts/texi2pod.pl b/scripts/texi2pod.pl
> index 839b7917cf7..8bfc6f6f4c4 100755
> --- a/scripts/texi2pod.pl
> +++ b/scripts/texi2pod.pl
> @@ -143,6 +143,24 @@ while(<$inf>) {
>  	next;
>      };
>=20=20
> +    # Single line command handlers.
> +
> +    /^\@include\s+(.+)$/ and do {
> +	push @instack, $inf;
> +	$inf =3D gensym();
> +	$file =3D postprocess($1);
> +
> +	# Try cwd and $ibase, then explicit -I paths.
> +	$done =3D 0;
> +	foreach $path ("", $ibase, @ipath) {
> +	    $mypath =3D $file;
> +	    $mypath =3D $path . "/" . $mypath if ($path ne "");
> +	    open($inf, "<" . $mypath) and ($done =3D 1, last);
> +	}
> +	die "cannot find $file" if !$done;
> +	next;
> +    };
> +
>      next unless $output;
>=20=20
>      # Discard comments.  (Can't do it above, because then we'd never see
> @@ -242,24 +260,6 @@ while(<$inf>) {
>  	s/>/&GT;/g;
>      }
>=20=20
> -    # Single line command handlers.
> -
> -    /^\@include\s+(.+)$/ and do {
> -	push @instack, $inf;
> -	$inf =3D gensym();
> -	$file =3D postprocess($1);
> -
> -	# Try cwd and $ibase, then explicit -I paths.
> -	$done =3D 0;
> -	foreach $path ("", $ibase, @ipath) {
> -	    $mypath =3D $file;
> -	    $mypath =3D $path . "/" . $mypath if ($path ne "");
> -	    open($inf, "<" . $mypath) and ($done =3D 1, last);
> -	}
> -	die "cannot find $file" if !$done;
> -	next;
> -    };
> -
>      /^\@(?:section|unnumbered|unnumberedsec|center)\s+(.+)$/
>  	and $_ =3D "\n=3Dhead2 $1\n";
>      /^\@subsection\s+(.+)$/


--=20
Alex Benn=C3=A9e

