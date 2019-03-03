Received: from eggs.gnu.org ([209.51.188.92]:59646)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1h0Fmi-0006oT-Kj
	for qemu-devel@nongnu.org; Sat, 02 Mar 2019 20:19:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1h0Fmh-0000bR-UC
	for qemu-devel@nongnu.org; Sat, 02 Mar 2019 20:19:20 -0500
References: <20190302223825.11192-1-philmd@redhat.com>
	<20190302223825.11192-3-philmd@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <26f2a83e-588a-c26c-86dc-51d5b8170ae9@redhat.com>
Date: Sat, 2 Mar 2019 19:12:25 -0600
MIME-Version: 1.0
In-Reply-To: <20190302223825.11192-3-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 2/2] util/error: Remove unnecessary
 saved_errno
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, qemu-trivial@nongnu.org, Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

On 3/2/19 4:38 PM, Philippe Mathieu-Daud=C3=A9 wrote:
> Since 552375088a8, error_set_errno() calls error_setv() which
> already protect errno for clobbering.
> Remove the now unnecessary saved_errno.
>=20
> Suggested-by: Thomas Huth <thuth@redhat.com>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
>  util/error.c | 3 ---
>  1 file changed, 3 deletions(-)
>=20
> diff --git a/util/error.c b/util/error.c
> index 934a78e1b1..0402fa1b9d 100644
> --- a/util/error.c
> +++ b/util/error.c
> @@ -101,14 +101,11 @@ void error_setg_errno_internal(Error **errp,
>                                 int os_errno, const char *fmt, ...)
>  {
>      va_list ap;
> -    int saved_errno =3D errno;
> =20
>      va_start(ap, fmt);
>      error_setv(errp, src, line, func, ERROR_CLASS_GENERIC_ERROR, fmt, =
ap,
>                 os_errno !=3D 0 ? strerror(os_errno) : NULL);
>      va_end(ap);
> -
> -    errno =3D saved_errno;

NACK. strerror() can clobber errno, so you still need to restore
saved_errno, regardless of what error_setv() does internally.
--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org
