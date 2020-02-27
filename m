Return-Path: <SRS0=0TZc=4P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A885C4BA3B
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 10:30:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E5FB21556
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 10:30:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G+YeM47z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E5FB21556
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56790 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7GRJ-0004Du-Ng
	for qemu-devel@archiver.kernel.org; Thu, 27 Feb 2020 05:30:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44240)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlureau@redhat.com>) id 1j7GM0-0007Ha-P2
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 05:25:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlureau@redhat.com>) id 1j7GLz-0000kr-Mj
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 05:25:16 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:35096
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1j7GLz-0000fY-HE
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 05:25:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582799113;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9eAGK8hm4b6OpEG0aZeCxAATaSVWpXt37Aav9YL4F+E=;
 b=G+YeM47zwP8mIiIFCB88ssuCfJf2Pd6i2/pj7/3VGf1/gf95OIBykgEVyXGnoNqNqm6awj
 Jw2AqwzPGodTecoyJzZylBh0ANl1iOsvf+x/X11tZAICY7Npysal8Az6u9YIb/IxUPsHqk
 2A4ejgfz4ZpUVL0vloFlhlNJV3TZq/s=
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com
 [209.85.167.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-23-4dm-gFgCOCK48ZTbwULj6Q-1; Thu, 27 Feb 2020 05:25:12 -0500
X-MC-Unique: 4dm-gFgCOCK48ZTbwULj6Q-1
Received: by mail-oi1-f200.google.com with SMTP id o5so1383378oif.9
 for <qemu-devel@nongnu.org>; Thu, 27 Feb 2020 02:25:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=9eAGK8hm4b6OpEG0aZeCxAATaSVWpXt37Aav9YL4F+E=;
 b=PBkGjHYCEk/1WBypE3LRVQk8eio5J4MBcq/90BpURvIIKF98GnFLST6x5YBf7f+02/
 yU3CyINows5Jh2OB9cZk4Td1waEdOluyVcfiGuloBwT7T8EOjiFTURDQvGcUYmFiJ3FC
 oUHNYU1n+S4VSO3TEdq126qB2UqbMno1s+reGXFB7tshTYBnYaBnnbysr+oE0l8no5ju
 pOz3tYU9GudQFhpviWDHlGyoYfth4W3xttATV5w+gUBFtK6kp/lwVq984qkTFA54y66D
 JC048ObnOXoWyZQbUe0vFHI7jRbsTd6RRU8nPre9k0mO2dsL6XHbvyMSkrEw1KzS6nii
 SElg==
X-Gm-Message-State: APjAAAUPOZ2UxaMAGX2ZpBOSBi7J93iCX7WQ6P9hNZ9md3ftFoem+IXk
 zUmgOPka85BZAJNn/XPdgtt5ubuux+qDCLa5PkivsyED+44kKiEGd6FAuzzaPD8r6adZzur8y1g
 YqT7VM2eiN+i3b6AE+DgXZ9Mz2MtopAQ=
X-Received: by 2002:aca:4843:: with SMTP id v64mr2164397oia.13.1582799111559; 
 Thu, 27 Feb 2020 02:25:11 -0800 (PST)
X-Google-Smtp-Source: APXvYqxxdQa9QweVUwDAVM+CpaqR54Tsa8RKw3TUcfHBAKujpYRnfimDn5H211/72JBMJLCRjH6YzLcs1qI7Ag5p4OE=
X-Received: by 2002:aca:4843:: with SMTP id v64mr2164378oia.13.1582799111298; 
 Thu, 27 Feb 2020 02:25:11 -0800 (PST)
MIME-Version: 1.0
References: <20200227100621.21844-1-philmd@redhat.com>
In-Reply-To: <20200227100621.21844-1-philmd@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Thu, 27 Feb 2020 11:25:00 +0100
Message-ID: <CAMxuvazPH6h1Q8OEeb2R-E9kJYeGyjapa9mFWz1vDUFCRHn6EQ@mail.gmail.com>
Subject: Re: [RFC PATCH] linux-user/syscall: Use g_file_open_tmp()
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: Riku Voipio <riku.voipio@iki.fi>,
 "Daniel P . Berrange" <berrange@redhat.com>,
 qemu-devel <qemu-devel@nongnu.org>, Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi

On Thu, Feb 27, 2020 at 11:06 AM Philippe Mathieu-Daud=C3=A9
<philmd@redhat.com> wrote:
>
> Use GLib g_file_open_tmp() instead of getenv + snprintf + mkstemp.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
> RFC because I'm not sure g_autoptr(GError) works this way.

G_DEFINE_AUTOPTR_CLEANUP_FUNC(GError, g_error_free)
it will call g_error_free() at the end of the scope if the variable is !=3D=
 NULL.

>
>  linux-user/syscall.c | 11 ++++-------
>  1 file changed, 4 insertions(+), 7 deletions(-)
>
> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> index 8d27d10807..0e44969e16 100644
> --- a/linux-user/syscall.c
> +++ b/linux-user/syscall.c
> @@ -7282,17 +7282,14 @@ static int do_openat(void *cpu_env, int dirfd, co=
nst char *pathname, int flags,
>      }
>
>      if (fake_open->filename) {
> -        const char *tmpdir;
> -        char filename[PATH_MAX];
> +        g_autoptr(GError) gerr =3D NULL;
> +        g_autofree gchar *filename =3D NULL;
>          int fd, r;
>
>          /* create temporary file to map stat to */
> -        tmpdir =3D getenv("TMPDIR");
> -        if (!tmpdir)
> -            tmpdir =3D "/tmp";
> -        snprintf(filename, sizeof(filename), "%s/qemu-open.XXXXXX", tmpd=
ir);
> -        fd =3D mkstemp(filename);
> +        fd =3D g_file_open_tmp("qemu-open.XXXXXX", &filename, &gerr);
>          if (fd < 0) {
> +            fprintf(stderr, "Error opening %s: %s\n", filename, gerr->me=
ssage);

I am not sure if it's a good idea to printf() here, this may be
confused with the program output being run.

However, having a good errno value is probably necessary. And here,
glib doesn't guarantee that for this function, since it relies on
GFileError. So you would need something like g_file_error_to_errno()
which doesn't exist...



>              return fd;
>          }
>          unlink(filename);
> --
> 2.21.1
>


