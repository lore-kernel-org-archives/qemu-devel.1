Return-Path: <SRS0=ZO09=24=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBF91C33C8C
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 15:37:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A4C572081E
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 15:37:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MJevW+i7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4C572081E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51660 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ioqvN-0002RS-Ak
	for qemu-devel@archiver.kernel.org; Tue, 07 Jan 2020 10:37:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36404)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <marcandre.lureau@gmail.com>) id 1ioqdT-00075u-7h
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 10:19:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcandre.lureau@gmail.com>) id 1ioqdS-00053x-65
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 10:19:11 -0500
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:53990)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
 id 1ioqdS-00053a-0R
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 10:19:10 -0500
Received: by mail-wm1-x341.google.com with SMTP id m24so19363795wmc.3
 for <qemu-devel@nongnu.org>; Tue, 07 Jan 2020 07:19:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=spmWeXl4S5LMM/EH0t+JvDvCsYbDH5Ny1Okgs359Mz4=;
 b=MJevW+i7ayBjBkFcWjWUOYNKLPun/2eZsIAyFbqf1t8zO7BfXC4D73VWgSPBy/mEu+
 4p0X/QsOZmHHR87tMdwk0GwrrdAq/gTb2hBJlij9CDx794iLh5kp6GHfibJ7JlM7cKbQ
 fVldxUJVKQAStZR41sr6Vnrar6vDE5y18QqyIX+zM9Z6uEifnQAaqXWFkqJjdz8QW+aw
 6rjWCs66TzGTLAHQGA/f9Z6dpjeX7De7HDRzkVEXVr10NmdGYFHbcDvfJ7M5/mDghcZq
 uGA1jhf/7i7ODr1AxBajAEHwrlsz+tSprhDVceDB7Da56m43ZmQAFWYgiT1YpObDuIqQ
 Q84Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=spmWeXl4S5LMM/EH0t+JvDvCsYbDH5Ny1Okgs359Mz4=;
 b=aNsgVdYOaMdNy8Uax4DRfCO+D55SHaVu1X+a8OzaS2WhxvKy4OSemM8nZeAlJM15iH
 cN/iTnNBSv3DZumyRmyIhzK8wxKN3Be8IqgIf9B3bjqmJ04jSTg6uPetEbgUuHrTkO5J
 MpPlrLbLYMBg98LTEDwxhWUCMcNwGgSgLUc1oLr3wnEdjajuq+nRD7vslHoBfh9cSHn1
 mk4eYEVz29ZQG4mF3e52hcYrCuPmByL+hUXLwEWVJ8gPhW9J1lyOcQDuBH1wFo7Djw3D
 WcGsj+NmJn++8M1NjNBxcm0Z9sKAAc3IB7cXOiuGuuTF6LU8BS8VVgKOkNomifDULS4L
 rThA==
X-Gm-Message-State: APjAAAVziGaJqAaik77U7z3VIWtFJgo6AYma+/da87bpAmc9jI+YEzgN
 3Xifuc6vXv+2gCpQipGXiMtwS08vgT8+GzE2na8=
X-Google-Smtp-Source: APXvYqyNOVZmr3nwhz5OTJqEFmCZULtFqCT9YjFbfXRrZLCUIFxgtNnjtFC4c9ek5G9ROEu+h+aKHd4Tmqt6z8iKryY=
X-Received: by 2002:a05:600c:228f:: with SMTP id
 15mr41984335wmf.56.1578410348881; 
 Tue, 07 Jan 2020 07:19:08 -0800 (PST)
MIME-Version: 1.0
References: <20200107135311.5215-1-alex.bennee@linaro.org>
 <20200107135311.5215-7-alex.bennee@linaro.org>
In-Reply-To: <20200107135311.5215-7-alex.bennee@linaro.org>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 7 Jan 2020 19:18:56 +0400
Message-ID: <CAJ+F1CJwudHpqDonGTOYQjBNJ65XEsRT99x1cPOn=CKSP=emnA@mail.gmail.com>
Subject: Re: [PATCH v1 6/6] travis: install homebrew python for OS X
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
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
Cc: Fam Zheng <fam@euphon.net>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 QEMU <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Jan 7, 2020 at 6:55 PM Alex Benn=C3=A9e <alex.bennee@linaro.org> wr=
ote:
>
> Our python3 requirements now outstrip those of the build.
>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

> ---
>  .travis.yml | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/.travis.yml b/.travis.yml
> index 848a2714efe..a86ca34f79d 100644
> --- a/.travis.yml
> +++ b/.travis.yml
> @@ -57,6 +57,7 @@ addons:
>        - glib
>        - pixman
>        - gnu-sed
> +      - python
>      update: true
>
>
> --
> 2.20.1
>
>


--=20
Marc-Andr=C3=A9 Lureau

