Return-Path: <SRS0=3yEa=UG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF135C28CC3
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 08:51:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 40A4D208E3
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 08:51:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jWoWjAFW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40A4D208E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46982 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hZAbJ-00006t-Er
	for qemu-devel@archiver.kernel.org; Fri, 07 Jun 2019 04:51:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35044)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hZAaI-0007in-Bq
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 04:50:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hZAaH-0004fB-Ci
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 04:50:50 -0400
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:46548)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hZAaH-0004cN-6z
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 04:50:49 -0400
Received: by mail-oi1-x242.google.com with SMTP id 203so884027oid.13
 for <qemu-devel@nongnu.org>; Fri, 07 Jun 2019 01:50:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=5bkijeq6wyj0TynwwIr9elawem3VCDBOcu1LqMo6RN0=;
 b=jWoWjAFWGtFe5ZUQksAR9IOyB2Xw6J5OjeyhmscesnjZqcYNoU+vMPIAGin8x6FufR
 UQFG3ZcOYUTax3CCKpcKV54lbjccFWE2kfZ3XSI1OmGWydPB2GZUoRSVSctepS8Y+ZI8
 NYhQHkC7yuFdJuq0D0QIuqIW1TwH8VsJ3j9B4cwPi3bZFhw28WITebDRfHHwILhwxJZ/
 yUN2uwbE0ggQm9NKftYc0c7sicz5qdc4+1cO94oTdCzbn4t/l7KS05xkIcV5lC4S3QBm
 +kkpF1zirhsTxjjxvbCVVxcUc5ujpwEd6fdfNea9bltvtF5ROriwnw2A385HoKnYcXP7
 BQVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=5bkijeq6wyj0TynwwIr9elawem3VCDBOcu1LqMo6RN0=;
 b=BnuV54vQz32smrLzve6FyNeVNe7vwdsadAlkIM5MvC+0m39IkJIXZ7VsNucvquowud
 +3dbilttfac4+BpM1GiVMQIES4o0yEOJ8ick7F7sErQgF7S3l5wr2FlGbhoPk6uU1w7p
 z4KC+w5oFwWjX/PcO1sHAAJrm+Ao0isSfb85O28W3MqKqkTd8WZeL6JQ2T0wdsmsQUCl
 HgcTSH2xW5c0YVKmUFsLZ3knruE+yzZ1+hgS6+tCkxtp4l7aeMy+1GKPIhMoTHbXgdUi
 TS2c5/qMToQnt0MNbxIMkbNY+0pxtM+dIyCoooIH2n5Nvn9e02poI8OHyLM4C4QvZgyb
 hbmQ==
X-Gm-Message-State: APjAAAVyTQWEBDuOQeROrvA7q0zEgylX4DvnOE9fO0vMRXhsCUpjY93K
 ckGpHljx2gnm9cPDro/pohUN6NzsnUj5EJ0EJO8dEQ==
X-Google-Smtp-Source: APXvYqwBdy5EE5kJ82HiNACR2QgBy8k4NhDUkkIk7U/ILJLPIh/MVF5CzWlNWSCB+nsCDYPaxC4b21Vz58LO9Nloy5c=
X-Received: by 2002:a05:6808:8f1:: with SMTP id
 d17mr3031744oic.170.1559897447997; 
 Fri, 07 Jun 2019 01:50:47 -0700 (PDT)
MIME-Version: 1.0
References: <20190605145829.7674-1-marcandre.lureau@redhat.com>
 <20190605145829.7674-5-marcandre.lureau@redhat.com>
In-Reply-To: <20190605145829.7674-5-marcandre.lureau@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 7 Jun 2019 09:50:36 +0100
Message-ID: <CAFEAcA-shTf-Ha7+LXinyVu184eWe1hb9r80QfecSMYhz0A7Ag@mail.gmail.com>
To: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::242
Subject: Re: [Qemu-devel] [PATCH 4/5] vhost-user-input: check
 ioctl(EVIOCGNAME) return value
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
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 5 Jun 2019 at 16:04, Marc-Andr=C3=A9 Lureau
<marcandre.lureau@redhat.com> wrote:
>
> This should fix coverity CID 1401704.
>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  contrib/vhost-user-input/main.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/contrib/vhost-user-input/main.c b/contrib/vhost-user-input/m=
ain.c
> index 54f882602a..8b4e7d2536 100644
> --- a/contrib/vhost-user-input/main.c
> +++ b/contrib/vhost-user-input/main.c
> @@ -342,7 +342,11 @@ main(int argc, char *argv[])
>
>      vi.config =3D g_array_new(false, false, sizeof(virtio_input_config))=
;
>      memset(&id, 0, sizeof(id));
> -    ioctl(vi.evdevfd, EVIOCGNAME(sizeof(id.u.string) - 1), id.u.string);
> +    if (ioctl(vi.evdevfd, EVIOCGNAME(sizeof(id.u.string) - 1),
> +              id.u.string) < 0) {
> +        g_printerr("Failed to get evdev name: %s\n", g_strerror(errno));
> +        exit(EXIT_FAILURE);
> +    }


Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

