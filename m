Return-Path: <SRS0=3yEa=UG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C7D4C28CC3
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 08:52:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A6AA208E3
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 08:52:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="J/TYSNQ0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A6AA208E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46984 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hZAbR-0000Cu-LF
	for qemu-devel@archiver.kernel.org; Fri, 07 Jun 2019 04:52:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34705)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hZAZD-00079H-52
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 04:49:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hZAZC-0002Ph-1M
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 04:49:43 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:36479)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hZAZB-0002JC-RV
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 04:49:41 -0400
Received: by mail-ot1-x341.google.com with SMTP id c3so1163604otr.3
 for <qemu-devel@nongnu.org>; Fri, 07 Jun 2019 01:49:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=Up/VjuXxuZcPlN7p9+iFlb4bswqF/zXsRLKkmSmheFo=;
 b=J/TYSNQ0mDavDP/2kkqiF8JztsQQ/tIBZOtOEue2qGGmBF+VUzxmhlEWfp5dh3mPXI
 rEEtxKtFkUug5bljEZhkahZ5AujoZuoe5BCE97Qx79juCfWmRmmR288RaDAhpMNseRy7
 rLUO+mELAh/ZwtSbi/cnUZn8pc1iAXOf8uKGYl1GcJzqrgmr1edg4A0I+mBEx2YO+c0w
 +sSaQEelo3BapJVgw55FENgUsA6irjG+kGZHIieUSwEPAlKb4KzqHZMOv8EVnihMPNQ1
 LbbypxhGh9ylhfxq8j5s75UKve7FAQxxNcE0varVMhET1En+4IAIkxTRq3ptL9oxoc3e
 cZLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=Up/VjuXxuZcPlN7p9+iFlb4bswqF/zXsRLKkmSmheFo=;
 b=UEbW1bqajIufEhHsnCLVi7KjMexzA/TT57Pa+tDXE8OXt/wHwXgMfVinAfNrBFWspE
 UeFLDN++7yZkYr98e2JqNaEulHhvXrJw9kExcmeZhdfAmrpnzvE+YDIPzhMd+mjf8P0k
 lf2stQoaxoKcWbjzgOZNsTJdm3mblhGZPQjNT2d+wZ5YYoyYpfnurLll9nvNw1Q5qJiD
 4Xv51nescODffKJWV2cSoyNYbr6PZPT0yiIRQP4sLOmGSp8Fhz6tXKycplSwCzFEqx/x
 LFaZqdbJja761vF6Vhduf8TlqQJ3xYEnQBa2KuXkf+biEg5vgYEIO4U9tQvctc1y8NMh
 VX/A==
X-Gm-Message-State: APjAAAWtHHQoVryhGBs7ftbvgg/9Rqr2GCu2Lgp0gXzyzkePiNJpIGax
 dn1pwtlu+rFRR/p0CHf3orukm1ae/SPv4JeOX7keNA==
X-Google-Smtp-Source: APXvYqzhQ9G03X4uVRWtcUkRPSwPOYelc2N16r5bfDfFv5XUv6UVV2FlvwgidvvwUpiIfP4aE/3A/YUFVpFA4UTx/6k=
X-Received: by 2002:a9d:711e:: with SMTP id n30mr632753otj.97.1559897376707;
 Fri, 07 Jun 2019 01:49:36 -0700 (PDT)
MIME-Version: 1.0
References: <20190605145829.7674-1-marcandre.lureau@redhat.com>
 <20190605145829.7674-3-marcandre.lureau@redhat.com>
In-Reply-To: <20190605145829.7674-3-marcandre.lureau@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 7 Jun 2019 09:49:25 +0100
Message-ID: <CAFEAcA_4W+UGHUFFLW0V5bwoSt94DcSzkFcQqoOwA03Pd1JbAQ@mail.gmail.com>
To: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::341
Subject: Re: [Qemu-devel] [PATCH 2/5] vhost-user: check unix_listen() return
 value
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

On Wed, 5 Jun 2019 at 16:02, Marc-Andr=C3=A9 Lureau
<marcandre.lureau@redhat.com> wrote:
>
> This check shouldn't be necessary, since &error_fatal is given as
> argument and will exit() on failure. However, this change should
> silence coverity CID 1401761 & 1401705.
>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  contrib/vhost-user-gpu/main.c   | 4 ++++
>  contrib/vhost-user-input/main.c | 4 ++++
>  2 files changed, 8 insertions(+)
>
> diff --git a/contrib/vhost-user-gpu/main.c b/contrib/vhost-user-gpu/main.=
c
> index 9614c9422c..e0b6df5b4d 100644
> --- a/contrib/vhost-user-gpu/main.c
> +++ b/contrib/vhost-user-gpu/main.c
> @@ -1160,6 +1160,10 @@ main(int argc, char *argv[])
>
>      if (opt_socket_path) {
>          int lsock =3D unix_listen(opt_socket_path, &error_fatal);
> +        if (lsock < 0) {
> +            g_printerr("Failed to listen on %s.\n", opt_socket_path);
> +            exit(EXIT_FAILURE);
> +        }
>          fd =3D accept(lsock, NULL, NULL);
>          close(lsock);
>      } else {
> diff --git a/contrib/vhost-user-input/main.c b/contrib/vhost-user-input/m=
ain.c
> index 8d493f598e..8b854117f5 100644
> --- a/contrib/vhost-user-input/main.c
> +++ b/contrib/vhost-user-input/main.c
> @@ -367,6 +367,10 @@ main(int argc, char *argv[])
>
>      if (opt_socket_path) {
>          int lsock =3D unix_listen(opt_socket_path, &error_fatal);
> +        if (lsock < 0) {
> +            g_printerr("Failed to listen on %s.\n", opt_socket_path);
> +            exit(EXIT_FAILURE);
> +        }
>          fd =3D accept(lsock, NULL, NULL);
>          close(lsock);
>      } else {
> --
> 2.22.0.rc2.384.g1a9a72ea1d
>

Maybe better to just assert(lsock >=3D 0) ?
(I hadn't noticed the &error_fatal -- it means this new code
is unreachable.)

thanks
-- PMM

