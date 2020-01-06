Return-Path: <SRS0=kvq2=23=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B52DC3F68F
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2020 19:12:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 68100207FF
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2020 19:12:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Rik3Pyqe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68100207FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58576 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ioXnz-00076P-Ag
	for qemu-devel@archiver.kernel.org; Mon, 06 Jan 2020 14:12:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57644)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlureau@redhat.com>) id 1ioXd9-0007Si-Js
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 14:01:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlureau@redhat.com>) id 1ioXd7-00008e-Tb
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 14:01:35 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:55282
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1ioXd1-0008Pu-7z
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 14:01:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578337283;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=udr4qNUrHL92V3QPI1xp7SuA0OONQ/iGl2vzlDGLXAo=;
 b=Rik3Pyqew/dVHw1vHJZyyXx4NbcsxVwyaZdEnW1kNiBjSRcnhuZ5AfS7jWJz7F026bCbcJ
 O6sgpLjk2Lpf01NVqRVxH/1UNI/NQm3oIMDXfZ8bWG3C6DjcTMPb5Nvg+oVP8f1X2mmKCI
 qGFr610pfolo75Dm/4S4M13CwnoYZzA=
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com
 [209.85.210.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-142-KCa-2e9FNFKTX-1oovKeqQ-1; Mon, 06 Jan 2020 14:01:20 -0500
Received: by mail-ot1-f71.google.com with SMTP id v7so17789880otr.14
 for <qemu-devel@nongnu.org>; Mon, 06 Jan 2020 11:01:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=udr4qNUrHL92V3QPI1xp7SuA0OONQ/iGl2vzlDGLXAo=;
 b=QDWYWkjNcDDJ9cu44YCwzBGwkq5BIAVoecwaR1qNVJgEBbPyN9XGgqwGh8uydVLDTE
 FP19Gfoxow1AWnxQPY+a8cYFTgsdNXsfjsNBC1Zhbr/qfNsg2ym3jxc46xnSHU4T4h6Z
 lFs2nlWHsSNwwKBJ4aajeuxNF0i9oGO02gCs65VBqzUVHylJfCA5/zExpBLWPqHRvvda
 VgBx50voRxqW+b3E6+m/Se5FJalgDaZ0cFQzAmvu7+/LFkv2geXtVyF8oukqUGxiU60Q
 4w9zv1zqg6Wpi8uLMv+FqpghB7YAmabNHEMreThZw06t45wJADuRTXYV6e9qg/klWy66
 eJRg==
X-Gm-Message-State: APjAAAX9PIAkYZyOuQTumO6kuo0m+qcF8gPEFVZmcp8E3ncW9S16KAVn
 xOkKgXRalPvCJ1b0QTFRG686hc0RGbq6PI+Z+lOH0nYA8JhxOdd4cZdF/X52+DpPAEGqyP8SL0m
 iDhP94V9BVqVZ6qbD4y3WJ2xFAb7EuJ0=
X-Received: by 2002:a9d:4706:: with SMTP id a6mr109017049otf.331.1578337278811; 
 Mon, 06 Jan 2020 11:01:18 -0800 (PST)
X-Google-Smtp-Source: APXvYqy6hg7r8jOwhDc1l9VjJIUG5XkDT8WG02VjnstOQj4/x7ixMw2kczT/a6yFRqGT6A+K6KhfmSzxzCXNyrCt7D4=
X-Received: by 2002:a9d:4706:: with SMTP id a6mr109017029otf.331.1578337278541; 
 Mon, 06 Jan 2020 11:01:18 -0800 (PST)
MIME-Version: 1.0
References: <20200106182425.20312-1-danielhb413@gmail.com>
 <20200106182425.20312-11-danielhb413@gmail.com>
In-Reply-To: <20200106182425.20312-11-danielhb413@gmail.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Mon, 6 Jan 2020 23:01:06 +0400
Message-ID: <CAMxuvawDuytTS90fBxc95ONkR=w1AxGT8+faSm+Dbd7-U4TJyA@mail.gmail.com>
Subject: Re: [PATCH v1 10/59] chardev/char-win.c: remove 'fail' label in
 win_chr_serial_init()
To: Daniel Henrique Barboza <danielhb413@gmail.com>
X-MC-Unique: KCa-2e9FNFKTX-1oovKeqQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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
> The 'fail' label is a simply call to 'return -1' on error. Remove
> it and do the return call instead.
>
> CC: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> CC: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Daniel Henrique Barboza <danielhb413@gmail.com>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

> ---
>  chardev/char-win.c | 19 ++++++++-----------
>  1 file changed, 8 insertions(+), 11 deletions(-)
>
> diff --git a/chardev/char-win.c b/chardev/char-win.c
> index 34825f683d..72c232e6d9 100644
> --- a/chardev/char-win.c
> +++ b/chardev/char-win.c
> @@ -85,12 +85,12 @@ int win_chr_serial_init(Chardev *chr, const char *fil=
ename, Error **errp)
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
>      s->file =3D CreateFile(filename, GENERIC_READ | GENERIC_WRITE, 0, NU=
LL,
> @@ -98,12 +98,12 @@ int win_chr_serial_init(Chardev *chr, const char *fil=
ename, Error **errp)
>      if (s->file =3D=3D INVALID_HANDLE_VALUE) {
>          error_setg(errp, "Failed CreateFile (%lu)", GetLastError());
>          s->file =3D NULL;
> -        goto fail;
> +        return -1;
>      }
>
>      if (!SetupComm(s->file, NRECVBUF, NSENDBUF)) {
>          error_setg(errp, "Failed SetupComm");
> -        goto fail;
> +        return -1;
>      }
>
>      ZeroMemory(&comcfg, sizeof(COMMCONFIG));
> @@ -114,29 +114,26 @@ int win_chr_serial_init(Chardev *chr, const char *f=
ilename, Error **errp)
>
>      if (!SetCommState(s->file, &comcfg.dcb)) {
>          error_setg(errp, "Failed SetCommState");
> -        goto fail;
> +        return -1;
>      }
>
>      if (!SetCommMask(s->file, EV_ERR)) {
>          error_setg(errp, "Failed SetCommMask");
> -        goto fail;
> +        return -1;
>      }
>
>      cto.ReadIntervalTimeout =3D MAXDWORD;
>      if (!SetCommTimeouts(s->file, &cto)) {
>          error_setg(errp, "Failed SetCommTimeouts");
> -        goto fail;
> +        return -1;
>      }
>
>      if (!ClearCommError(s->file, &err, &comstat)) {
>          error_setg(errp, "Failed ClearCommError");
> -        goto fail;
> +        return -1;
>      }
>      qemu_add_polling_cb(win_chr_serial_poll, chr);
>      return 0;
> -
> - fail:
> -    return -1;
>  }
>
>  int win_chr_pipe_poll(void *opaque)
> --
> 2.24.1
>


