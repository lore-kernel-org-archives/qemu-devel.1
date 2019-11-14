Return-Path: <SRS0=NHD5=ZG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 091BBC432C3
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2019 09:30:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA96D206C0
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2019 09:30:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jOzDFJ1t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA96D206C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54762 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iVBS6-0000sK-KS
	for qemu-devel@archiver.kernel.org; Thu, 14 Nov 2019 04:30:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33215)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <marcandre.lureau@gmail.com>) id 1iVBQG-0007xH-QJ
 for qemu-devel@nongnu.org; Thu, 14 Nov 2019 04:28:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcandre.lureau@gmail.com>) id 1iVBQF-0003Wx-NX
 for qemu-devel@nongnu.org; Thu, 14 Nov 2019 04:28:16 -0500
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:36588)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
 id 1iVBQF-0003WX-HA
 for qemu-devel@nongnu.org; Thu, 14 Nov 2019 04:28:15 -0500
Received: by mail-wr1-x441.google.com with SMTP id r10so5610867wrx.3
 for <qemu-devel@nongnu.org>; Thu, 14 Nov 2019 01:28:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=KJ2+cWdBiTW8/awolFB8JPFavjkyz9vlHlu0IK5hFvg=;
 b=jOzDFJ1tqOdHvTgmAjUFvcjRsMkcRtTub9VcfRzsNguuwi7/asBHSWqzP1B71XuDpJ
 8bWZB4L3wIxTfTp/fdOdE4A2NgWS9VyWfA2qniPL2Bpeiir53gc4AYgzB3VQym4cGju3
 JRk9sVlqm75fXqxvmnWJBe1rzLw1e2qRvfNpiE4UA/OyI1aiCiVpcCeLZM7ARXywRqtU
 Y8tz6gX1EE88BXwhKUNNRtHXBFVgG9iHHZ8nwdWZTqAdb+ONMR6fl7SV7JHJTSMYjsQU
 5vCkUDjLwTaTN6BvHB1M2l57lsmFmdHSVCdQGsJpu1FFi8FTnx5ZjfgjhNfyqR3fqmOy
 dStw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=KJ2+cWdBiTW8/awolFB8JPFavjkyz9vlHlu0IK5hFvg=;
 b=dVGhmbduU9CM9kk+nBG35+cYPcCY37AkpLTR9o/iK7MdxH3aU0icz1uv+0zpeQu3Sq
 glmYoZcknAhTY3v+ojQlnU2qpvfgdaS2FjpdM35ib0Qs6DkcSQ+l4P98+O2aPJJwLhBs
 yZB8wMILpeqSJAG7NKcphz3GIzjTOqOpU6Xi5YW8jGk460uk0Aaj6alrcYxVmZ7sVGZU
 0G2r+5Dw1xNWEAsmQm24pd9lBLXyEnYs/MJJk3hjaMOvUp8ggXOo0mZIfnteBFrGzuEd
 YdPun74nEiIWuhgkU0jHQ2HY1JHIDI9xqvGJIBeXnyKdUIOxN/PdeXtBvNFXRam8xt0w
 tpJg==
X-Gm-Message-State: APjAAAVn+nRj2QzkkUKNLiCkyXm2yFxDdhOb/il5ui/irxLoFmj7ZZ7v
 0dU/Vs28pNcYxu91UMmWVV2jKPfNFu8ooJPDKY0=
X-Google-Smtp-Source: APXvYqzv8LKMJWtVzVK+rdKpZzm8CcQ/dpjoAQUBe4AHc4RUFuaWVEVlUjTDtqDeFNdLNlpw2BZqLWQrDkBMARVKghA=
X-Received: by 2002:a5d:670a:: with SMTP id o10mr7541169wru.312.1573723694261; 
 Thu, 14 Nov 2019 01:28:14 -0800 (PST)
MIME-Version: 1.0
References: <1573655945-14912-1-git-send-email-pbonzini@redhat.com>
 <1573655945-14912-8-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1573655945-14912-8-git-send-email-pbonzini@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Thu, 14 Nov 2019 13:28:02 +0400
Message-ID: <CAJ+F1CJRCMnVEBCjm4Q+6FS2kahFHURPOV5wixLfJ2Yi-4SPxg@mail.gmail.com>
Subject: Re: [PATCH 07/16] vl: warn for unavailable accelerators,
 clarify messages
To: Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
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
Cc: Thomas Huth <thuth@redhat.com>, QEMU <qemu-devel@nongnu.org>,
 Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi

On Wed, Nov 13, 2019 at 6:39 PM Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> So far, specifying an accelerator that was not compiled in did not result
> in an error; fix that.
>
> While at it, clarify the mysterious "Back to TCG" message.

I was wondering why this was not addressed in previous patch :)

>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

> ---
>  vl.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/vl.c b/vl.c
> index dd895db..843b263 100644
> --- a/vl.c
> +++ b/vl.c
> @@ -2853,6 +2853,8 @@ static int do_configure_accelerator(void *opaque, Q=
emuOpts *opts, Error **errp)
>      int ret;
>
>      if (!ac) {
> +        *p_init_failed =3D true;
> +        error_report("invalid accelerator %s", acc);
>          return 0;
>      }
>      ret =3D accel_init_machine(ac, current_machine);
> @@ -2907,6 +2909,9 @@ static void configure_accelerators(const char *prog=
name)
>               */
>              if (accel_find(*tmp)) {
>                  qemu_opts_parse_noisily(qemu_find_opts("accel"), *tmp, t=
rue);
> +            } else {
> +                init_failed =3D true;
> +                error_report("invalid accelerator %s", *tmp);
>              }
>          }
>      } else {
> @@ -2926,7 +2931,7 @@ static void configure_accelerators(const char *prog=
name)
>
>      if (init_failed) {
>          AccelClass *ac =3D ACCEL_GET_CLASS(current_machine->accelerator)=
;
> -        error_report("Back to %s accelerator", ac->name);
> +        error_report("falling back to %s", ac->name);
>      }
>
>      if (!tcg_enabled() && use_icount) {
> --
> 1.8.3.1
>
>
>


--=20
Marc-Andr=C3=A9 Lureau

