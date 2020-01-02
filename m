Return-Path: <SRS0=Q/S9=2X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56C5CC2D0DC
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jan 2020 12:29:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 20C95215A4
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jan 2020 12:29:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NLesUvpI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20C95215A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40630 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1imzb6-0004Lv-9g
	for qemu-devel@archiver.kernel.org; Thu, 02 Jan 2020 07:29:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51958)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <marcandre.lureau@gmail.com>) id 1imzaR-0003cN-Bw
 for qemu-devel@nongnu.org; Thu, 02 Jan 2020 07:28:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcandre.lureau@gmail.com>) id 1imzaQ-00069X-6a
 for qemu-devel@nongnu.org; Thu, 02 Jan 2020 07:28:23 -0500
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435]:41649)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
 id 1imzaQ-00069B-0m
 for qemu-devel@nongnu.org; Thu, 02 Jan 2020 07:28:22 -0500
Received: by mail-wr1-x435.google.com with SMTP id c9so39065483wrw.8
 for <qemu-devel@nongnu.org>; Thu, 02 Jan 2020 04:28:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=FrVcr/esl7fifERlBEeBsXE21Z8yCJJJgxYy1MTSa/E=;
 b=NLesUvpIEce+d6FnuvD717usOvILYoaX616gC1sUQp+TC/D141ocIgYcs77kW7GbnP
 aUKa3uoCbJ2N20+SQkrBGVrXONWC96QzHhdey8lxYrGfkVx+0U+B1UoULWHNLRfwTTVn
 ELtHtgUYZTkRneFsmtznqJFBhEcczTBU56WIS0c8W4ogq2ghgRKdscWsrDnj11lg2HxP
 Jw0Xdq+4SR78MZX0goWGjaLJiMOPQXwDkBHI54bkWfhviNsapYyvCkRUVCtkV9zuSBvi
 KYkoT8IUXxNw6O6n5ioKQq+8T4i/Xas1bX98s1UEWJdNzw1E9YPXKLDBPaWmI7B60yLv
 cVWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=FrVcr/esl7fifERlBEeBsXE21Z8yCJJJgxYy1MTSa/E=;
 b=MhgVoPwihlhv6l124gRajpotZBi9vJqdb/GUzVyzSSd1dr56QYLhouzrTzkf2/e07/
 Epy1UC+Zfcq5McXgDU7OMiKznccm/QwipHPeT5iNbkik4/AYduBTAsZ2cTgPn7CbA3VY
 ufXhX2x5nZ5roToU2Ma3ra5bynIfxCxceFT6z//ldaOymn6lHcVz4hOTbcmidfw/Cdyc
 5wXozcbgZEup6FKGQg6EfINnTJPJXBiinF6u/KaoIxPFuLSE9fxB0NHfD2PXFVmXYEU0
 y6mnsMD7US8MS8Qa7V43CteHX+b1voUGg25RW/EapS5H34VshjzRDSk3WrOzNFA1F8EN
 q73A==
X-Gm-Message-State: APjAAAU7Pq0+y1PaCLDzOhTT218aPxhw60vN7DJ4dCL5vK87uOmRoo9o
 Yxi0zIlhdP3HLL1yl01njiThTECH3VkZAUwEhK40EQJrzZo=
X-Google-Smtp-Source: APXvYqza6Kx+YowL/ZOc/t5Hulo3L5Gqq28mNB7cOx0y1UWzhQLN0865nzwKmH+aneTvJNmvIyE+4ALcLWBSfMaVwfo=
X-Received: by 2002:adf:f10a:: with SMTP id r10mr81973325wro.202.1577968099825; 
 Thu, 02 Jan 2020 04:28:19 -0800 (PST)
MIME-Version: 1.0
References: <20200102115459.854103-1-marcandre.lureau@redhat.com>
In-Reply-To: <20200102115459.854103-1-marcandre.lureau@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Thu, 2 Jan 2020 16:28:07 +0400
Message-ID: <CAJ+F1C+eewb6qrjiC83R_7aLe9+KYP1NX3+fv9KRYAypE56uEg@mail.gmail.com>
Subject: Re: [PULL 0/7] Screendump patches
To: QEMU <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::435
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Jan 2, 2020 at 3:55 PM Marc-Andr=C3=A9 Lureau
<marcandre.lureau@redhat.com> wrote:
>
> The following changes since commit dd5b0f95490883cd8bc7d070db8de70d5c979c=
bc:
>
>   Merge remote-tracking branch 'remotes/cohuck/tags/s390x-20191219' into =
staging (2019-12-20 16:37:07 +0000)
>
> are available in the Git repository at:
>
>   https://github.com/elmarco/qemu.git tags/screendump-pull-request
>
> for you to fetch changes up to 6b8d2a5132378ac19cf93597dad694ea764cca4f:
>
>   screendump: use qemu_unlink() (2020-01-02 13:54:57 +0400)
>
> ----------------------------------------------------------------
> console: screendump improvements
>
> Hi,
>
> The following patches have been extracted from the "[PATCH v6 00/25]
> monitor: add asynchronous command type", as they are
> reviewable/mergeable independantly.
>
> They introduce some internal API changes, and fix
> qemu_open()/qemu_close()/unlink() misusages which should be quite
> harmless.
>
> ----------------------------------------------------------------
>
> Marc-Andr=C3=A9 Lureau (7):
>   console: add graphic_hw_update_done()
>   ppm-save: pass opened fd
>   ui: add pixman image g_autoptr support
>   object: add g_autoptr support
>   screendump: replace FILE with QIOChannel and fix close()/qemu_close()
>   osdep: add qemu_unlink()
>   screendump: use qemu_unlink()
>
>  hw/display/qxl-render.c  |  9 +++--
>  hw/display/qxl.c         |  1 +
>  include/qemu/osdep.h     |  1 +
>  include/qom/object.h     |  3 ++
>  include/ui/console.h     |  2 ++
>  include/ui/qemu-pixman.h |  2 ++
>  ui/console.c             | 74 +++++++++++++++++++++-------------------
>  ui/trace-events          |  2 +-
>  util/osdep.c             | 15 ++++++++
>  9 files changed, 71 insertions(+), 38 deletions(-)
>
> --
> 2.24.0.308.g228f53135a
>
>

nack, travis found an issue:
error: unused variable

      'error' [-Werror,-Wunused-variable]

    g_autoptr(GError) error =3D NULL;



--=20
Marc-Andr=C3=A9 Lureau

