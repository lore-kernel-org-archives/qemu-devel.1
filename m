Return-Path: <SRS0=5EQe=UZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F37E5C48BD6
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2019 19:39:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7EE412085A
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2019 19:39:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j+Q/WKTY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7EE412085A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44572 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hgDln-0007jX-EC
	for qemu-devel@archiver.kernel.org; Wed, 26 Jun 2019 15:39:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57970)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <marcandre.lureau@gmail.com>) id 1hgDk3-0006qw-OE
 for qemu-devel@nongnu.org; Wed, 26 Jun 2019 15:38:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcandre.lureau@gmail.com>) id 1hgDk2-0000A1-LW
 for qemu-devel@nongnu.org; Wed, 26 Jun 2019 15:38:03 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:38669)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
 id 1hgDk2-00008w-7E
 for qemu-devel@nongnu.org; Wed, 26 Jun 2019 15:38:02 -0400
Received: by mail-wm1-x341.google.com with SMTP id s15so3255148wmj.3
 for <qemu-devel@nongnu.org>; Wed, 26 Jun 2019 12:38:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=IVCVljPSFSra0tGOO5P/MB46LApVAVr9x/qycNMTcPo=;
 b=j+Q/WKTYu7sDPQ1H22YyRnjAfXRsJMnDpKwS+5CR8uIdshDbCLxuC1aogt16FOHlwc
 PceReFi2KwwKEOqqV9GF8KxoLXMCO6mjppqEunqI9ahP1SRlOGtuGA7mLZ6mhLovMMRu
 8qIOMfv1h7gIToxXqRM2oAh2HX6uHkCW+zIl9Vhz/1KjjWa8coLvPw7uo2GCRjRkFZPH
 jBt6yGzhDD2T1DejtRx7OuJuA3AU9UgpTS06H1v2X8nJofVfKxoRXrhl5lpf61spdtar
 xD85oY0B2TjEaK3/Y9X2SWKGKdTYS5/vZYnXWZUR25CLiLaoaFQ9VcBtnn+sCCMDvnpN
 i1hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=IVCVljPSFSra0tGOO5P/MB46LApVAVr9x/qycNMTcPo=;
 b=Bzjms2vhR0TxRbTkGaCCsQjt0QfGxGR7folS+mifkTy1F+8Pm1DJLuW6OvqJZ3h00+
 TjrnToBRMiN5Dy3G6C2LLUt4WLPeLNn4aroHr674pr2gR/B8NRT7pNN8kQVQrV5xGSWP
 toidAnVUCItsJSevthLNGR80zGOcg5a/MVm1Q3fhcERx/QCym8nNzSyX5QgdRo+vpn5Z
 m++Me3vwBLPXEBRNrqOCJb7PC0G/QjWUUwAzzW6Ium44sS/7BaFK/AY82AxuCdJEI+k0
 ycgW9FHTEgUnKy6V0Wt80v9TRauYMid53moAq1WQOPLC8zgjXtA+Q4b8lzvEROcFlNVq
 hN3A==
X-Gm-Message-State: APjAAAWbsz107lXEzBWU0RVVk5g7atVhNpUeiKC8X3eTbx+Gg+zQFV6A
 vP2HKNnQcKfxLjiU/HfwEE8LGMXJYYpkQC5wNu0=
X-Google-Smtp-Source: APXvYqyxU+PXxo7dh7r8OkiCJa8rTH4wUM241qdShb1cw0rQ4A2IYEKpWBPyGr1NQPGTvS330r01tSpz5n9XmNC/o0E=
X-Received: by 2002:a7b:cc81:: with SMTP id p1mr360278wma.107.1561577880782;
 Wed, 26 Jun 2019 12:38:00 -0700 (PDT)
MIME-Version: 1.0
References: <20190616213540.20430-1-mst@redhat.com>
 <20190605145829.7674-3-marcandre.lureau@redhat.com>
 <dddce02c-a132-9ab8-0a96-7a81fd8ee76f@redhat.com>
In-Reply-To: <dddce02c-a132-9ab8-0a96-7a81fd8ee76f@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Wed, 26 Jun 2019 21:37:47 +0200
Message-ID: <CAJ+F1CJSwFjD7XQNwNK9jq7mqFJkKUJbLJqzUrCJr2rS26dDdg@mail.gmail.com>
To: Eric Blake <eblake@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
Subject: Re: [Qemu-devel] [PULL 02/11] vhost-user: check unix_listen()
 return value
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Gerd Hoffmann <kraxel@redhat.com>,
 QEMU <qemu-devel@nongnu.org>, "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi

On Wed, Jun 26, 2019 at 7:56 PM Eric Blake <eblake@redhat.com> wrote:
>
> On 6/16/19 4:36 PM, Michael S. Tsirkin wrote:
> > From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> >
> > This check shouldn't be necessary, since &error_fatal is given as
> > argument and will exit() on failure. However, this change should
> > silence coverity CID 1401761 & 1401705.
> >
> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > Message-Id: <20190605145829.7674-3-marcandre.lureau@redhat.com>
> > Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > ---
> >  contrib/vhost-user-gpu/main.c   | 4 ++++
> >  contrib/vhost-user-input/main.c | 4 ++++
> >  2 files changed, 8 insertions(+)
> >
> > diff --git a/contrib/vhost-user-gpu/main.c b/contrib/vhost-user-gpu/mai=
n.c
> > index 9614c9422c..e0b6df5b4d 100644
> > --- a/contrib/vhost-user-gpu/main.c
> > +++ b/contrib/vhost-user-gpu/main.c
> > @@ -1160,6 +1160,10 @@ main(int argc, char *argv[])
> >
> >      if (opt_socket_path) {
> >          int lsock =3D unix_listen(opt_socket_path, &error_fatal);
> > +        if (lsock < 0) {
> > +            g_printerr("Failed to listen on %s.\n", opt_socket_path);
> > +            exit(EXIT_FAILURE);
> > +        }
>
> 4 lines to appease Coverity; wouldn't the following one-liner also do
> the trick?
>
> int lsock =3D unix_listen(opt_socket_path, &error_fatal);
> assert (lsock >=3D 0);

Probably, I didn't think too much about it. However looking at it now,
it would be worthwhile to report the error to the user in a friendlier
way than what error_fatal do. So I guess a follow-up patch should
introduce a local Error.

>
> --
> Eric Blake, Principal Software Engineer
> Red Hat, Inc.           +1-919-301-3226
> Virtualization:  qemu.org | libvirt.org
>


--=20
Marc-Andr=C3=A9 Lureau

