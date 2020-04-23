Return-Path: <SRS0=5yua=6H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93103C2BA19
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2020 10:38:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5CC4C20776
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2020 10:38:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HOe1LDES"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5CC4C20776
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40654 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRZFV-0006zW-GO
	for qemu-devel@archiver.kernel.org; Thu, 23 Apr 2020 06:38:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34622)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <marcandre.lureau@gmail.com>) id 1jRZEn-0006Zw-JN
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 06:37:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <marcandre.lureau@gmail.com>) id 1jRZEn-0002Nk-0C
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 06:37:45 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:42629)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1jRZEm-0002GH-K2
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 06:37:44 -0400
Received: by mail-wr1-x444.google.com with SMTP id j2so6234371wrs.9
 for <qemu-devel@nongnu.org>; Thu, 23 Apr 2020 03:37:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=yDVJQtlIy99DlydKeT1rIXZ3o4u7o6gZYxi8FQlWpbc=;
 b=HOe1LDES3Z+qe/bUJasNI9O2FJ+CYD+zV56j2bDUrgYBFpXeIfy0zajDlutj3+Nfhp
 usIA/2qzzrPwK+fRWaNULlDdCDUNUAsdRSTEOVSfLnVsObnXUZ1VGZqZq4kWwCF5LvTO
 0bnZsvLsjJsWKnwikzD1i42A11ba6cN2CAgDLcV31EWwTmA9PD4gqkjbA4IEmK0TBm0p
 vW+O+uoATG8jNTSi2vt5j2RgobxVap6HeBWLLGdYF5qRZS24M+da6qlNlBN8ckFNYK5E
 LCnEK7RUhAif8grzvTETiOCNyEV4TM+bJtd2bw3NBajZInSxnulhhT9J69EinAELbLBQ
 V/Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=yDVJQtlIy99DlydKeT1rIXZ3o4u7o6gZYxi8FQlWpbc=;
 b=tHKxD2zH3DBPHGyAfdZLUPeWBbLJDk+fRSLHGwNuiYIQPlT/QdUgwfElEfFI9QR4oZ
 6f0OZD5ln1VLV7cWEzGjB9xm/P5wR690Vvagggh1zscJ/+DX5v75DwW6P4vi1G8Ik/TA
 P9qJQFQi5MnldgmTAH+xapfALFw1/YaACHQm4R6rTDAeCtO3aup5oc64M3GUIaMqXj/P
 DEQifNwdsYdK8nsT1RRDU0zSQ16YFufESquu8FRjErAz906R87Oasrb3bk+XRwPHKcUW
 XduMoZYVOISPg2sbDXnIy8Q+M1X0jdT17CM3AiFOdmizDk+QGHMpDh7giljax3ru3O8t
 AS0g==
X-Gm-Message-State: AGi0PuZMXEh3cihstV4AOfMIiBMFR07kaQ2O44MwUkq9lQUvaij28AwG
 5W+moiS1HnwhtJGvy6ZO4BKTmLccYnwgujIQ29Q=
X-Google-Smtp-Source: APiQypL45vGmexzvAuLXysQ2WKRGWs9VxL6S4bhSdXCc/5/VvLlUSQdt13g/ZfjO5NmI2oLp3lZEENW6hyujrdtGfxM=
X-Received: by 2002:a5d:4a4b:: with SMTP id v11mr4084173wrs.32.1587638262229; 
 Thu, 23 Apr 2020 03:37:42 -0700 (PDT)
MIME-Version: 1.0
References: <20200423023212.20968-1-zxq_yx_007@163.com>
In-Reply-To: <20200423023212.20968-1-zxq_yx_007@163.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Thu, 23 Apr 2020 12:37:29 +0200
Message-ID: <CAJ+F1CK=Gdz=u2c9uwiNdNRzfoiZ3+q9ijNo=Ue6wQ=9yLvFCg@mail.gmail.com>
Subject: Re: [PATCH] qemu-sockets: add abstract UNIX domain socket support
To: xiaoqiang zhao <zxq_yx_007@163.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-wr1-x444.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2a00:1450:4864:20::444
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
Cc: "Daniel P. Berrange" <berrange@redhat.com>, QEMU <qemu-devel@nongnu.org>,
 Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi

On Thu, Apr 23, 2020 at 4:48 AM xiaoqiang zhao <zxq_yx_007@163.com> wrote:
>
> unix_connect_saddr now support abstract address type
>
> By default qemu does not support abstract UNIX domain
> socket address. Add this ability to make qemu handy
> when abstract address is needed.
> Abstract address is marked by prefixing the address name with a '@'.
>
> Signed-off-by: xiaoqiang zhao <zxq_yx_007@163.com>


Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>


> ---
>  util/qemu-sockets.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
>
> diff --git a/util/qemu-sockets.c b/util/qemu-sockets.c
> index bcc06d0e01..d4f02a6b1a 100644
> --- a/util/qemu-sockets.c
> +++ b/util/qemu-sockets.c
> @@ -939,6 +939,7 @@ static int unix_connect_saddr(UnixSocketAddress *sadd=
r, Error **errp)
>      struct sockaddr_un un;
>      int sock, rc;
>      size_t pathlen;
> +    socklen_t serverlen;
>
>      if (saddr->path =3D=3D NULL) {
>          error_setg(errp, "unix connect: no path specified");
> @@ -963,10 +964,18 @@ static int unix_connect_saddr(UnixSocketAddress *sa=
ddr, Error **errp)
>      un.sun_family =3D AF_UNIX;
>      memcpy(un.sun_path, saddr->path, pathlen);
>
> +    if (saddr->path[0] =3D=3D '@') {
> +        un.sun_path[0] =3D '\0';
> +        serverlen =3D strlen(saddr->path) + offsetof(struct sockaddr_un,=
 sun_path);
> +    }
> +    else {
> +        serverlen =3D sizeof(un);
> +    }
> +
>      /* connect to peer */
>      do {
>          rc =3D 0;
> -        if (connect(sock, (struct sockaddr *) &un, sizeof(un)) < 0) {
> +        if (connect(sock, (struct sockaddr *) &un, serverlen) < 0) {
>              rc =3D -errno;
>          }
>      } while (rc =3D=3D -EINTR);
> --
> 2.17.1
>
>
>


--=20
Marc-Andr=C3=A9 Lureau

