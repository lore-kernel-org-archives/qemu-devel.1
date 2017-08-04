Received: from eggs.gnu.org ([2001:4830:134:3::10]:50563)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <den@virtuozzo.com>) id 1ddcN9-0000LV-AR
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 09:11:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <den@virtuozzo.com>) id 1ddcM4-0006cP-5M
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 09:10:34 -0400
References: <8760e3mst2.fsf@dusky.pond.sub.org>
From: "Denis V. Lunev" <den@openvz.org>
Message-ID: <5f5a45ed-26c8-e96d-f39f-39e7a289ec91@openvz.org>
Date: Fri, 4 Aug 2017 16:08:09 +0300
MIME-Version: 1.0
In-Reply-To: <8760e3mst2.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
Subject: Re: [Qemu-devel] Is the use of bdrv_getlength() in
 handle_aiocb_write_zeroes() kosher?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>

On 08/04/2017 03:16 PM, Markus Armbruster wrote:
> Denis, you added this in commit d50d822:
>
> #ifdef CONFIG_FALLOCATE
>     if (s->has_fallocate && aiocb->aio_offset >=3D bdrv_getlength(aiocb=
->bs)) {
>         int ret =3D do_fallocate(s->fd, 0, aiocb->aio_offset, aiocb->ai=
o_nbytes);
>         if (ret =3D=3D 0 || ret !=3D -ENOTSUP) {
>             return ret;
>         }
>         s->has_fallocate =3D false;
>     }
> #endif
>
> bdrv_getlength() can fail.  Does it do the right thing then?  For what
> it's worth, the comparison of its value is signed.
fallocate() with 0 flags can work only beyond end of file
or on top of the hole. Thus the check is made to validate
that we are beyond EOF.

Technically fallocate should fail if that condition will be
violated. But you right, we can add sanity check here.
This would not harm.

Should I send it?

Den
