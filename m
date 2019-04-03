Received: from eggs.gnu.org ([209.51.188.92]:37224)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1hBeve-0002as-4F
	for qemu-devel@nongnu.org; Wed, 03 Apr 2019 08:23:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1hBevc-0000tC-Pd
	for qemu-devel@nongnu.org; Wed, 03 Apr 2019 08:23:42 -0400
Date: Wed, 3 Apr 2019 13:23:28 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20190403122328.GQ25150@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20190403121620.5228-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190403121620.5228-1-philmd@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] sockets: Fix stringop-truncation warning
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Cc: qemu-trivial@nongnu.org, qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>

On Wed, Apr 03, 2019 at 02:16:20PM +0200, Philippe Mathieu-Daud=C3=A9 wro=
te:
> Compiling with clang-8 fails with:
>=20
>     CC      util/qemu-sockets.o
>   util/qemu-sockets.c: In function 'unix_connect_saddr':
>   util/qemu-sockets.c:925:5: error: 'strncpy' specified bound 108 equal=
s destination size [-Werror=3Dstringop-truncation]
>        strncpy(un.sun_path, saddr->path, sizeof(un.sun_path));
>        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>   util/qemu-sockets.c: In function 'unix_listen_saddr':
>   util/qemu-sockets.c:880:5: error: 'strncpy' specified bound 108 equal=
s destination size [-Werror=3Dstringop-truncation]
>        strncpy(un.sun_path, path, sizeof(un.sun_path));
>        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>=20
> Per the unix socket manpage:
>=20
>   UNIX(7)
>=20
>   Pathname sockets
>   When binding a socket to a pathname, a few rules should be observed f=
or maximum portability and ease of coding:
>   *  The pathname in sun_path should be null-terminated.
>   *  The length of the pathname, including the terminating null byte, s=
hould not exceed the size of sun_path.
>=20
> Reduce the length of the unix socket path by 1 to hold the NUL byte.

Note it just says "should", not "must" here. IOW, there is no requirement
to NUL terminate and so we should not artifically require that at QEMU
level either. If mgmt apps want to have NUL termination then they can
just pass a shorter path to QEMU to start with.

I've proposed the fix for the warning you mention here:

  https://lists.gnu.org/archive/html/qemu-devel/2019-03/msg07759.html


Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
