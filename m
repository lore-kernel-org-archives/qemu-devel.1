Return-Path: <SRS0=0TZc=4P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C818C4BA24
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 10:36:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EC0692468E
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 10:36:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Jd6OEZOT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC0692468E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56948 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7GWY-0001xH-61
	for qemu-devel@archiver.kernel.org; Thu, 27 Feb 2020 05:36:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46329)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1j7GSB-0005ou-1o
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 05:31:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1j7GS7-0004HP-J8
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 05:31:38 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:31209
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>) id 1j7GS7-0004Fy-Cp
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 05:31:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582799494;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RUE8shnfPzDdhihUcnfJnzAAfvwflL5lQ1zii1MF3wg=;
 b=Jd6OEZOTkA1V/qM97Utsp+tYv/h1QYD/fQWc/O8p+w0db/z4z+K3EZG5zqxFVae0C02Qjh
 Q3JoJc7kOKCyOoJLVwSLC5nIKKXfgTLgoaUnwe4FPz8zf8ltseQhpoMZNCd2llwJw1C+40
 puITRvwgN+t75Z+xFbLrKYNMJcOKlxc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-464-mQefb3-cOba5iaNuYmj-1w-1; Thu, 27 Feb 2020 05:31:30 -0500
X-MC-Unique: mQefb3-cOba5iaNuYmj-1w-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BA0371902EC8;
 Thu, 27 Feb 2020 10:31:29 +0000 (UTC)
Received: from redhat.com (ovpn-112-43.ams2.redhat.com [10.36.112.43])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id AF4AF65E98;
 Thu, 27 Feb 2020 10:31:21 +0000 (UTC)
Date: Thu, 27 Feb 2020 10:31:18 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Subject: Re: [RFC PATCH] linux-user/syscall: Use g_file_open_tmp()
Message-ID: <20200227103118.GE1645630@redhat.com>
References: <20200227100621.21844-1-philmd@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200227100621.21844-1-philmd@redhat.com>
User-Agent: Mutt/1.13.3 (2020-01-12)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Riku Voipio <riku.voipio@iki.fi>, qemu-devel@nongnu.org,
 Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Feb 27, 2020 at 11:06:21AM +0100, Philippe Mathieu-Daud=C3=A9 wrote=
:
> Use GLib g_file_open_tmp() instead of getenv + snprintf + mkstemp.
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
> RFC because I'm not sure g_autoptr(GError) works this way.

It does work. Any struct that's defined in GLib has support for
g_autoptr(). If you aren't suyre though, just check for a
G_DEFINE_AUTOPTR_CLEANUP_FUNC() macro usage that refers to the
struct in question

$ grep -r 'G_DEFINE_AUTOPTR_CLEANUP_FUNC(GError' /usr/include/glib-2.0
/usr/include/glib-2.0/glib/glib-autocleanups.h:G_DEFINE_AUTOPTR_CLEANUP_FUN=
C(GError, g_error_free)

>  linux-user/syscall.c | 11 ++++-------
>  1 file changed, 4 insertions(+), 7 deletions(-)
>=20
> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> index 8d27d10807..0e44969e16 100644
> --- a/linux-user/syscall.c
> +++ b/linux-user/syscall.c
> @@ -7282,17 +7282,14 @@ static int do_openat(void *cpu_env, int dirfd, co=
nst char *pathname, int flags,
>      }
> =20
>      if (fake_open->filename) {
> -        const char *tmpdir;
> -        char filename[PATH_MAX];
> +        g_autoptr(GError) gerr =3D NULL;
> +        g_autofree gchar *filename =3D NULL;
>          int fd, r;
> =20
>          /* create temporary file to map stat to */
> -        tmpdir =3D getenv("TMPDIR");
> -        if (!tmpdir)
> -            tmpdir =3D "/tmp";
> -        snprintf(filename, sizeof(filename), "%s/qemu-open.XXXXXX", tmpd=
ir);
> -        fd =3D mkstemp(filename);
> +        fd =3D g_file_open_tmp("qemu-open.XXXXXX", &filename, &gerr);

g_file_open_tmp, calls g_get_tmp_name, which calls
g_get_tmp_dir, which defaults to $TMPDIR, falling back
to /tmp. So we're using the same dir as before.

>          if (fd < 0) {
> +            fprintf(stderr, "Error opening %s: %s\n", filename, gerr->me=
ssage);

This is wrong - the returned "filename" is only valid when
g_file_open_tmp succeeds. So the use of "filename" here
is likely a NULL. Given that the only place you use "filename"
is in the error path, and that's not valid, we can simply
eliminate it entirely, and pass NULL into g_file_open_tmp

>              return fd;
>          }
>          unlink(filename);

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange=
 :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com=
 :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange=
 :|


