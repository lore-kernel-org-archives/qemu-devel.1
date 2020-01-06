Return-Path: <SRS0=kvq2=23=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71755C33C8C
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2020 19:16:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 390142072E
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2020 19:16:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RZGCZWaJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 390142072E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58688 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ioXrM-0003eq-9C
	for qemu-devel@archiver.kernel.org; Mon, 06 Jan 2020 14:16:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57762)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlureau@redhat.com>) id 1ioXdM-0007kT-IJ
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 14:01:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlureau@redhat.com>) id 1ioXdK-0000NN-8Z
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 14:01:47 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:36262
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1ioXdK-0000Mo-4p
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 14:01:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578337305;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jZYMq6rkclQC8eMi6qcmCvHpL50F8Ty50/ctqNiKoSM=;
 b=RZGCZWaJ3pLdtrF6DFnrEW1x4a3M8nOKBucqiWtIND0kB9oX78HewbO3s76MavNyEfU8p9
 ScE2v/Paobd0mXaHBCgz1UUUPuRQle0Gc4hXNIuzQZkvovsOTYJe2CnTt+6z+TMDyZax4U
 sIfCq4WScn7L/xyZ6N7ErWSAwcltoVw=
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-167-ASrAHUIHMMmQsgG39w01FQ-1; Mon, 06 Jan 2020 14:01:44 -0500
Received: by mail-oi1-f199.google.com with SMTP id q204so17716065oic.12
 for <qemu-devel@nongnu.org>; Mon, 06 Jan 2020 11:01:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=jZYMq6rkclQC8eMi6qcmCvHpL50F8Ty50/ctqNiKoSM=;
 b=Qt1iY32uU56pxNMUXFmkHUOykNOVY0ah6LCTndWjaLoejWWzX8sKNnDhkJPy/xVWbH
 vishkuv5er9nX+MgWSlG5KeJpPP7UqnV8dh14sTjQ2ophNqGECh5QGmBYQ+FU58MxgNR
 7Dao9AcDlUnXUOWMJ56JGL6jaNPXsuRCktCJCxX7TU+JKBjy4n/h53ZstqhYXzONCy0B
 G8I/Ep8Zx4HXgVh32CfNVCPTVo2utKLHYdLO2Hh+KajyKpPq0mt9l1j5wI0W9V9vshA9
 PNLkH33VQ5RI7Fvf9VQJlLCYhcn1+Ue/CnU+hBdEQgRa8hLvuzDnuK1ZSPYeDwCC+LZ5
 haKQ==
X-Gm-Message-State: APjAAAUslQIVZ6iQQNjjoZzcR4DB7IDVz2QlMCcY+i6Qhix8bXJ7ofML
 Y3PvuVRLup6GgnI2dXQtVyjRQirD2b2PeW2/oehdU7EWYaqjYIIS7smTj8ALsZydvyDGqmGnmgt
 dLFGFyLd1HrS5Q+G0eCkWBBdtf2Eoc74=
X-Received: by 2002:a9d:60c4:: with SMTP id b4mr94936866otk.166.1578337303964; 
 Mon, 06 Jan 2020 11:01:43 -0800 (PST)
X-Google-Smtp-Source: APXvYqxE7iYyaQtBsvuxtSKh/zmmpmdZfvLPHwENXoxR/9WkQcmEG38PQlOfRMCLmkbLq5DtA/VlLoYSCqO6/JkZJ+k=
X-Received: by 2002:a9d:60c4:: with SMTP id b4mr94936845otk.166.1578337303778; 
 Mon, 06 Jan 2020 11:01:43 -0800 (PST)
MIME-Version: 1.0
References: <20200106182425.20312-1-danielhb413@gmail.com>
 <20200106182425.20312-10-danielhb413@gmail.com>
In-Reply-To: <20200106182425.20312-10-danielhb413@gmail.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Mon, 6 Jan 2020 23:01:31 +0400
Message-ID: <CAMxuvawvybuW20r2UOT_Eke2YXRwk5o2wi-OnAvaiXEM8iSkAg@mail.gmail.com>
Subject: Re: [PATCH v1 09/59] chardev/char-pipe.c: remove 'fail' label in
 win_chr_pipe_init()
To: Daniel Henrique Barboza <danielhb413@gmail.com>
X-MC-Unique: ASrAHUIHMMmQsgG39w01FQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: qemu-trivial <qemu-trivial@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Jan 6, 2020 at 10:25 PM Daniel Henrique Barboza
<danielhb413@gmail.com> wrote:
>
> The 'fail' label is simply doing a 'return -1'.
>
> CC: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> CC: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Daniel Henrique Barboza <danielhb413@gmail.com>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

> ---
>  chardev/char-pipe.c | 13 +++++--------
>  1 file changed, 5 insertions(+), 8 deletions(-)
>
> diff --git a/chardev/char-pipe.c b/chardev/char-pipe.c
> index 94d714ffcd..65d52beb0d 100644
> --- a/chardev/char-pipe.c
> +++ b/chardev/char-pipe.c
> @@ -54,12 +54,12 @@ static int win_chr_pipe_init(Chardev *chr, const char=
 *filename,
>      s->hsend =3D CreateEvent(NULL, TRUE, FALSE, NULL);
>      if (!s->hsend) {
>          error_setg(errp, "Failed CreateEvent");
> -        goto fail;
> +        return -1;
>      }
>      s->hrecv =3D CreateEvent(NULL, TRUE, FALSE, NULL);
>      if (!s->hrecv) {
>          error_setg(errp, "Failed CreateEvent");
> -        goto fail;
> +        return -1;
>      }
>
>      openname =3D g_strdup_printf("\\\\.\\pipe\\%s", filename);
> @@ -72,7 +72,7 @@ static int win_chr_pipe_init(Chardev *chr, const char *=
filename,
>      if (s->file =3D=3D INVALID_HANDLE_VALUE) {
>          error_setg(errp, "Failed CreateNamedPipe (%lu)", GetLastError())=
;
>          s->file =3D NULL;
> -        goto fail;
> +        return -1;
>      }
>
>      ZeroMemory(&ov, sizeof(ov));
> @@ -80,7 +80,7 @@ static int win_chr_pipe_init(Chardev *chr, const char *=
filename,
>      ret =3D ConnectNamedPipe(s->file, &ov);
>      if (ret) {
>          error_setg(errp, "Failed ConnectNamedPipe");
> -        goto fail;
> +        return -1;
>      }
>
>      ret =3D GetOverlappedResult(s->file, &ov, &size, TRUE);
> @@ -90,7 +90,7 @@ static int win_chr_pipe_init(Chardev *chr, const char *=
filename,
>              CloseHandle(ov.hEvent);
>              ov.hEvent =3D NULL;
>          }
> -        goto fail;
> +        return -1;
>      }
>
>      if (ov.hEvent) {
> @@ -99,9 +99,6 @@ static int win_chr_pipe_init(Chardev *chr, const char *=
filename,
>      }
>      qemu_add_polling_cb(win_chr_pipe_poll, chr);
>      return 0;
> -
> - fail:
> -    return -1;
>  }
>
>  static void qemu_chr_open_pipe(Chardev *chr,
> --
> 2.24.1
>


