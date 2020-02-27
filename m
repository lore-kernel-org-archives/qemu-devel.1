Return-Path: <SRS0=0TZc=4P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B06EAC4BA3B
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 10:57:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 75B8D24699
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 10:57:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fHmVxH9y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75B8D24699
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57260 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7GrX-0005s0-LU
	for qemu-devel@archiver.kernel.org; Thu, 27 Feb 2020 05:57:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55962)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jtomko@redhat.com>) id 1j7Gq7-000407-AO
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 05:56:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jtomko@redhat.com>) id 1j7Gq6-000758-2M
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 05:56:23 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:56612
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jtomko@redhat.com>) id 1j7Gq5-00074I-U0
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 05:56:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582800981;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wIYEMUEMIw5VU+RgXKbgXD73dU01FYwID8LDddQNyUE=;
 b=fHmVxH9yANMSrVikfg3xMzz3bK4PPuSEL4upNtvaSBC1SdvTW4qFBhdrb0kb9nWeWszpIa
 PyR5CWRmp0BJusWexVin3ed4/HYT/6orv//wnR5WZUJXgjqx4Eyiy5BB2EBfHCZRPG0JPw
 7Fd/Ob0cCQRAoFaAuZwVSkFCllGyvmw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-334-3Vwhm6_6O8mYzOK2b6y0bQ-1; Thu, 27 Feb 2020 05:56:12 -0500
X-MC-Unique: 3Vwhm6_6O8mYzOK2b6y0bQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 125C6800D50;
 Thu, 27 Feb 2020 10:56:11 +0000 (UTC)
Received: from lpt (unknown [10.43.2.81])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3C7E25C296;
 Thu, 27 Feb 2020 10:56:07 +0000 (UTC)
Date: Thu, 27 Feb 2020 11:56:04 +0100
From: =?iso-8859-1?B?SuFu?= Tomko <jtomko@redhat.com>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Subject: Re: [RFC PATCH] linux-user/syscall: Use g_file_open_tmp()
Message-ID: <20200227105604.GJ2262365@lpt>
References: <20200227100621.21844-1-philmd@redhat.com>
 <20200227103118.GE1645630@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200227103118.GE1645630@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="v2/QI0iRXglpx0hK"
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Riku Voipio <riku.voipio@iki.fi>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org, Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--v2/QI0iRXglpx0hK
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On a Thursday in 2020, Daniel P. Berrang=E9 wrote:
>On Thu, Feb 27, 2020 at 11:06:21AM +0100, Philippe Mathieu-Daud=E9 wrote:
>> Use GLib g_file_open_tmp() instead of getenv + snprintf + mkstemp.
>>
>> Signed-off-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>
>> ---
>> RFC because I'm not sure g_autoptr(GError) works this way.
>
>It does work. Any struct that's defined in GLib has support for
>g_autoptr(). If you aren't suyre though, just check for a
>G_DEFINE_AUTOPTR_CLEANUP_FUNC() macro usage that refers to the
>struct in question
>
>$ grep -r 'G_DEFINE_AUTOPTR_CLEANUP_FUNC(GError' /usr/include/glib-2.0
>/usr/include/glib-2.0/glib/glib-autocleanups.h:G_DEFINE_AUTOPTR_CLEANUP_FU=
NC(GError, g_error_free)
>
>>  linux-user/syscall.c | 11 ++++-------
>>  1 file changed, 4 insertions(+), 7 deletions(-)
>>
>> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
>> index 8d27d10807..0e44969e16 100644
>> --- a/linux-user/syscall.c
>> +++ b/linux-user/syscall.c
>> @@ -7282,17 +7282,14 @@ static int do_openat(void *cpu_env, int dirfd, c=
onst char *pathname, int flags,
>>      }
>>
>>      if (fake_open->filename) {
>> -        const char *tmpdir;
>> -        char filename[PATH_MAX];
>> +        g_autoptr(GError) gerr =3D NULL;
>> +        g_autofree gchar *filename =3D NULL;
>>          int fd, r;
>>
>>          /* create temporary file to map stat to */
>> -        tmpdir =3D getenv("TMPDIR");
>> -        if (!tmpdir)
>> -            tmpdir =3D "/tmp";
>> -        snprintf(filename, sizeof(filename), "%s/qemu-open.XXXXXX", tmp=
dir);
>> -        fd =3D mkstemp(filename);
>> +        fd =3D g_file_open_tmp("qemu-open.XXXXXX", &filename, &gerr);
>
>g_file_open_tmp, calls g_get_tmp_name, which calls
>g_get_tmp_dir, which defaults to $TMPDIR, falling back
>to /tmp. So we're using the same dir as before.
>
>>          if (fd < 0) {
>> +            fprintf(stderr, "Error opening %s: %s\n", filename, gerr->m=
essage);
>
>This is wrong - the returned "filename" is only valid when
>g_file_open_tmp succeeds. So the use of "filename" here
>is likely a NULL. Given that the only place you use "filename"
>is in the error path, and that's not valid, we can simply
>eliminate it entirely, and pass NULL into g_file_open_tmp
>

'filename' is used right below to unlink it.
But it can be dropped from the error message here since it's included in th=
e
error reported by GLib.

Jano

>>              return fd;
>>          }
>>          unlink(filename);
>
>Regards,
>Daniel
>--=20
>|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrang=
e :|
>|: https://libvirt.org         -o-            https://fstop138.berrange.co=
m :|
>|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrang=
e :|
>
>

--v2/QI0iRXglpx0hK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEQeJGMrnL0ADuclbP+YPwO/Mat50FAl5XoDwACgkQ+YPwO/Ma
t531oAf/bXd8/K7dH80vWVINNWEFCRBxqYTTM6gIHId+168eDmgjlycSihCLUT6y
t3J9TJXE1gHIH3mlhGGy6hzajpkfPp/UXpEN1juOiF6LZ9oL1ABSq/UG8hDkvvNg
oQ1za0/72AJ/7WrUj9TeKo9ZPZrhfUrdxiJBl20tYz3zArPbwcugiNUjHzVYrV66
2DtrxDVKIThy6wm2Je0x8rvwbWeM/oDYXVz0IXI0jYiIU6v5T+FsD5tscVkoM9op
c1IwmZaZgFlV4417w3wFLCJxzylPDpV6GXZmotNVNUqfBxLbHrx5q7GJJs1koFsB
AcvDQHBXudTOgbafyWO50mgFqsGTRw==
=PjQW
-----END PGP SIGNATURE-----

--v2/QI0iRXglpx0hK--


