Return-Path: <SRS0=5yua=6H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12568C54FD0
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2020 20:53:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD8C92073A
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2020 20:53:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W4xSaQRb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD8C92073A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41486 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRiqP-0005mT-0d
	for qemu-devel@archiver.kernel.org; Thu, 23 Apr 2020 16:53:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33928)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <marcandre.lureau@gmail.com>) id 1jRipI-0004f8-89
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 16:52:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <marcandre.lureau@gmail.com>) id 1jRipG-0003vP-KF
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 16:52:04 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:56250)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1jRipG-0003uX-4m
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 16:52:02 -0400
Received: by mail-wm1-x341.google.com with SMTP id e26so8118061wmk.5
 for <qemu-devel@nongnu.org>; Thu, 23 Apr 2020 13:52:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=xI/7UGSbUDidCuMybls+r4oADxm2z0eT7aFVuZj77jI=;
 b=W4xSaQRb1jl0QgtKxrzF7AZRwR2iffCAsln4yffvb/tkMnfW6bCJIk8Ql4r+jUeGGa
 6pCkn8Kw4ELqbaamPvpo/rJ09f+UKS9DAak8HWBZBtqmPILAFn4B+2UHy9jSfMflDbha
 HEbmsyRe4Zjh0BVvkdDG7i2yDHYG7hqclm2fY+GHraYlgAHe8ABk8HobSC34og9+nveD
 H+CS1KjWH1Ohlgk08DEWaCl10037ay+mAp4vbc6gcAMa9ARETdsZ3L2zu9Z21PgkHxi3
 BJ+hzUdmP3pObvGqoTLPGyrJFpOfE65eS2aRZd2OguhErrF6TgwiUe2a5ITmRbE0LxSM
 RwIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=xI/7UGSbUDidCuMybls+r4oADxm2z0eT7aFVuZj77jI=;
 b=jYGYrxkMjPzThHMtozTmg8fFL3drvkq26hyzkhUnCXYZWpsjsb53cQS3LHJYaD1aAI
 0DZ73J8N287o3krd20XcSTZOyQhKlKSAyrhxEd10uR9+gM4a3JRvfhKNcQRFN/VWHErS
 7PfFPFYheImKp82ipwvmnLKCIYpaxFaBECe/znQOG/ioAH7Wfr1lWxNe8MfowwTw+IZ/
 9cUqe1wZNhTd1L9jsismXuDTObX97eLCK6l8NAWiWz94XquqNHCmtzw98f5SbyG1ZiwS
 u3zc899C+xutjtsw5La7r9MCDDb8hAM7z4h0z4+Nx6lzfitKqa7qNmCaB4LmrQO3/ocK
 2LCA==
X-Gm-Message-State: AGi0PuY5GqQ4qx6A3igNez+5G3fd3nBxxhz5szENprqVkAXNXszeq5D6
 n22lK10Rwmyb76sh+vYPag7O9bGGpTeEZ71Dh40=
X-Google-Smtp-Source: APiQypL93iFO65FNrvRaRIY9OtO4OY9+gRPEV3xNSp3U0yKrOc1/W9RVA5QLDAB2RNBlnlwD99JyIUYLHxeGVYjnQAg=
X-Received: by 2002:a1c:7301:: with SMTP id d1mr6470936wmb.26.1587675118538;
 Thu, 23 Apr 2020 13:51:58 -0700 (PDT)
MIME-Version: 1.0
References: <20200423202112.644-1-philmd@redhat.com>
 <20200423202112.644-4-philmd@redhat.com>
In-Reply-To: <20200423202112.644-4-philmd@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Thu, 23 Apr 2020 22:51:46 +0200
Message-ID: <CAJ+F1CJpdU=S6zQg5J=8gYDzR1GmgbzDZqVFkaigd-vbSLbPsw@mail.gmail.com>
Subject: Re: [PATCH 3/7] chardev: Restrict msmouse / wctablet / testdev to
 system emulation
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-wm1-x341.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
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
Cc: Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 John G Johnson <john.g.johnson@oracle.com>,
 Jagannathan Raman <jag.raman@oracle.com>, QEMU <qemu-devel@nongnu.org>,
 Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Apr 23, 2020 at 10:22 PM Philippe Mathieu-Daud=C3=A9
<philmd@redhat.com> wrote:
>
> The msmouse / wctablet / testdev character devices are only
> used by system emulation. Remove them from user mode and tools.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>


> ---
>  chardev/Makefile.objs | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/chardev/Makefile.objs b/chardev/Makefile.objs
> index d68e1347f9..15ee7f47da 100644
> --- a/chardev/Makefile.objs
> +++ b/chardev/Makefile.objs
> @@ -17,7 +17,7 @@ chardev-obj-y +=3D char-udp.o
>  chardev-obj-$(CONFIG_WIN32) +=3D char-win.o
>  chardev-obj-$(CONFIG_WIN32) +=3D char-win-stdio.o
>
> -common-obj-y +=3D msmouse.o wctablet.o testdev.o
> +common-obj-$(CONFIG_SOFTMMU) +=3D msmouse.o wctablet.o testdev.o
>  common-obj-$(CONFIG_BRLAPI) +=3D baum.o
>  baum.o-cflags :=3D $(SDL_CFLAGS)
>  baum.o-libs :=3D $(BRLAPI_LIBS)
> --
> 2.21.1
>
>


--=20
Marc-Andr=C3=A9 Lureau

