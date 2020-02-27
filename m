Return-Path: <SRS0=0TZc=4P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C676DC4BA3B
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 10:30:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 92BC324691
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 10:30:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P+lwGEqa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92BC324691
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56780 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7GQu-0003tB-QG
	for qemu-devel@archiver.kernel.org; Thu, 27 Feb 2020 05:30:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44965)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlureau@redhat.com>) id 1j7GO1-00019d-Nf
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 05:27:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlureau@redhat.com>) id 1j7GNx-00042A-LO
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 05:27:21 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:49927
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1j7GNx-00041R-Fr
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 05:27:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582799237;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3JuFsm69pCXiFxPSjN/VPT5Lvx6wPoxEwSXUPjnk0jQ=;
 b=P+lwGEqaKT+6dHi9fWCOmYYF19Vg3ykYJQeY4TFsVxSyIV479v1xltfH/SkhR737RZm9QU
 ZWkfHw5RKLwn1iQt0CYt7bZ2vTHwknAfxnpDtj1Ntr8AEFMtcXlji8M2OsUZNIoHOGgszQ
 3fImkL8mGL0g5fDw2v8c4JnUV24L+5o=
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com
 [209.85.210.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-7-2r3vR3LcPum_OmtDnTjbOw-1; Thu, 27 Feb 2020 05:27:15 -0500
X-MC-Unique: 2r3vR3LcPum_OmtDnTjbOw-1
Received: by mail-ot1-f71.google.com with SMTP id d16so1355473otf.5
 for <qemu-devel@nongnu.org>; Thu, 27 Feb 2020 02:27:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=3JuFsm69pCXiFxPSjN/VPT5Lvx6wPoxEwSXUPjnk0jQ=;
 b=p2uHrS/gQ54YepWqThrtm/EYUKS9HyO6MW+wa2v45ZrbG451GAO1oVlsv4bZuPEG8j
 hSZtPrG7s+PodDXnJchsimriK2ax4qSm9ijH+rGF4QOR3ncy3QH47GDdqYwqHzp4C4lL
 4MLEkoSHXqHd+W06z4vieVrHleYnJC2p29ZmyMEYb2JsEMP34ktKSgKONMzf53W9LkTy
 2gpiGQL7vAiRbLmc5X0cqMddqKSUfvhIY5dAfL4ozjGePvbYwUOj+UoCrFp/g/ZOeuue
 J0HKVjqrkgUEwEmsJB8Cln5He7OBll+tCZbZRbIE3dd/kHzXpICYwSsLam3fhZJqbqdG
 2F8Q==
X-Gm-Message-State: APjAAAWaQb+MjMQeFIpknSTx0k4PLNgSWQfTiNNWrX6kGfh4YUKm1Ol8
 VCi9QZPDAPxf2MNVhTb61uglzjEW52DF308BIqPFYTMd/D8Ov7DsW/L958Qugn5osOErjjx/n41
 0LPt264GqmDF89CUJnCuAxdJ5ymfvhS4=
X-Received: by 2002:a05:6808:487:: with SMTP id z7mr395157oid.46.1582799234511; 
 Thu, 27 Feb 2020 02:27:14 -0800 (PST)
X-Google-Smtp-Source: APXvYqwtQ6IcMaU2stJcqkzqCnYweyHKBDRF+h5rrLp+dpqC67WidJrXpyNu39TYvV5YLz0rtfBe+1i1FvaALS/3hFw=
X-Received: by 2002:a05:6808:487:: with SMTP id z7mr395141oid.46.1582799234293; 
 Thu, 27 Feb 2020 02:27:14 -0800 (PST)
MIME-Version: 1.0
References: <20200227100250.20514-1-philmd@redhat.com>
 <20200227100250.20514-2-philmd@redhat.com>
In-Reply-To: <20200227100250.20514-2-philmd@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Thu, 27 Feb 2020 11:27:03 +0100
Message-ID: <CAMxuvawwy4b2rhkph7x=ifG2GrpRVCogdm1_dYYtXjvz9fwiiw@mail.gmail.com>
Subject: Re: [PATCH 1/2] chardev: Improve error report by calling
 error_setg_win32()
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
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
Cc: qemu-trivial <qemu-trivial@nongnu.org>, Stefan Weil <sw@weilnetz.de>,
 "Daniel P . Berrange" <berrange@redhat.com>,
 qemu-devel <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Feb 27, 2020 at 11:03 AM Philippe Mathieu-Daud=C3=A9
<philmd@redhat.com> wrote:
>
> Use error_setg_win32() which adds a hint similar to strerror(errno)).
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
>  chardev/char-pipe.c | 2 +-
>  chardev/char-win.c  | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/chardev/char-pipe.c b/chardev/char-pipe.c
> index 94d714ffcd..fd12c9e63b 100644
> --- a/chardev/char-pipe.c
> +++ b/chardev/char-pipe.c
> @@ -70,7 +70,7 @@ static int win_chr_pipe_init(Chardev *chr, const char *=
filename,
>                                MAXCONNECT, NSENDBUF, NRECVBUF, NTIMEOUT, =
NULL);
>      g_free(openname);
>      if (s->file =3D=3D INVALID_HANDLE_VALUE) {
> -        error_setg(errp, "Failed CreateNamedPipe (%lu)", GetLastError())=
;
> +        error_setg_win32(errp, GetLastError(), "Failed CreateNamedPipe")=
;
>          s->file =3D NULL;
>          goto fail;
>      }
> diff --git a/chardev/char-win.c b/chardev/char-win.c
> index 34825f683d..d4fb44c4dc 100644
> --- a/chardev/char-win.c
> +++ b/chardev/char-win.c
> @@ -96,7 +96,7 @@ int win_chr_serial_init(Chardev *chr, const char *filen=
ame, Error **errp)
>      s->file =3D CreateFile(filename, GENERIC_READ | GENERIC_WRITE, 0, NU=
LL,
>                        OPEN_EXISTING, FILE_FLAG_OVERLAPPED, 0);
>      if (s->file =3D=3D INVALID_HANDLE_VALUE) {
> -        error_setg(errp, "Failed CreateFile (%lu)", GetLastError());
> +        error_setg_win32(errp, GetLastError(), "Failed CreateFile");
>          s->file =3D NULL;
>          goto fail;
>      }
> --
> 2.21.1
>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>


Daniel, do you mind queuing this with the qio patch?


