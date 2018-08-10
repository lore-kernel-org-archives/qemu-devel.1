Received: from eggs.gnu.org ([2001:4830:134:3::10]:49873)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fo0ut-0007xZ-Ra
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 02:28:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fo0ut-0002cF-2Y
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 02:28:55 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20180809114417.28718-1-marcandre.lureau@redhat.com>
	<20180809114417.28718-3-marcandre.lureau@redhat.com>
Date: Fri, 10 Aug 2018 08:28:48 +0200
In-Reply-To: <20180809114417.28718-3-marcandre.lureau@redhat.com>
	(=?utf-8?Q?=22Marc-Andr=C3=A9?=
	Lureau"'s message of "Thu, 9 Aug 2018 13:44:15 +0200")
Message-ID: <87r2j6u44f.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 2/4] tests: fix bdrv-drain leak
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, Hannes Reinecke <hare@suse.com>, Fam Zheng <famz@redhat.com>, qemu-block@nongnu.org, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Max Reitz <mreitz@redhat.com>

Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:

> Spotted by ASAN:
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> =3D=3D5378=3D=3DERROR: LeakSanitizer: detected memory leaks
>
> Direct leak of 65536 byte(s) in 1 object(s) allocated from:
>     #0 0x7f788f83bc48 in malloc (/lib64/libasan.so.5+0xeec48)
>     #1 0x7f788c9923c5 in g_malloc (/lib64/libglib-2.0.so.0+0x523c5)
>     #2 0x5622a1fe37bc in coroutine_trampoline /home/elmarco/src/qq/util/c=
oroutine-ucontext.c:116
>     #3 0x7f788a15d75f in __correctly_grouped_prefixwc (/lib64/libc.so.6+0=
x4c75f)
>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  tests/test-bdrv-drain.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/tests/test-bdrv-drain.c b/tests/test-bdrv-drain.c
> index 17bb8508ae..abc8bbe6f0 100644
> --- a/tests/test-bdrv-drain.c
> +++ b/tests/test-bdrv-drain.c
> @@ -948,6 +948,7 @@ static void coroutine_fn test_co_delete_by_drain(void=
 *opaque)
>      }
>=20=20
>      dbdd->done =3D true;
> +    g_free(buffer);
>  }
>=20=20
>  /**

Screwed up in commit 4c8158e359d.

Max, could the coroutine's stack accomodate the buffer?
