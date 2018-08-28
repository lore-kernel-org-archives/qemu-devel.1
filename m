Received: from eggs.gnu.org ([2001:4830:134:3::10]:54982)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fugP2-0007EG-QM
	for qemu-devel@nongnu.org; Tue, 28 Aug 2018 11:59:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fugOz-0005jR-J1
	for qemu-devel@nongnu.org; Tue, 28 Aug 2018 11:59:36 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:50100 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1fugOz-0005j5-DJ
	for qemu-devel@nongnu.org; Tue, 28 Aug 2018 11:59:33 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E00D0807A13F
	for <qemu-devel@nongnu.org>; Tue, 28 Aug 2018 15:59:32 +0000 (UTC)
Date: Tue, 28 Aug 2018 16:59:25 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180828155925.GG31005@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20180713130916.4153-1-marcandre.lureau@redhat.com>
	<20180713130916.4153-22-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180713130916.4153-22-marcandre.lureau@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4 21/29] util: use fcntl() for
 qemu_write_pidfile() locking
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, airlied@redhat.com, kraxel@redhat.com

On Fri, Jul 13, 2018 at 03:09:08PM +0200, Marc-Andr=C3=A9 Lureau wrote:
> According to Daniel Berrange, fcntl() locks have better portable
> semantics than lockf().

Specifically I was referring to this from 'man lockf':

   On Linux, lockf() is just an interface  on  top  of  fcntl(2)  locking=
.
   Many other systems implement lockf() in this way, but note that POSIX.=
1
   leaves the relationship between lockf() and fcntl(2) locks unspecified=
.
   A  portable  application  should  probably  avoid mixing calls to thes=
e
   interfaces.

IOW, if its just a shim around fcntl() on many systems, it is clearer
if we just use fcntl() directly, as we then know how fcntl() locks will
behave if they're on a network filesystem like NFS.

> Use an exclusive lock on the first byte with fcntl().
>=20
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  util/oslib-posix.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>=20
> diff --git a/util/oslib-posix.c b/util/oslib-posix.c
> index da1d4a3201..26b11490b9 100644
> --- a/util/oslib-posix.c
> +++ b/util/oslib-posix.c
> @@ -92,6 +92,11 @@ bool qemu_write_pidfile(const char *pidfile, Error *=
*errp)
>  {
>      int pidfd;
>      char pidstr[32];
> +    struct flock lock =3D {
> +        .l_type =3D F_WRLCK,
> +        .l_whence =3D SEEK_SET,
> +        .l_len =3D 1,
> +    };

For the same semantics as lockf we should use  len =3D=3D 0 (ie infinity)


Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
