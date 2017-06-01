Received: from eggs.gnu.org ([2001:4830:134:3::10]:37108)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1dGOCk-0006pk-St
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 07:23:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1dGOCg-0003TY-Ni
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 07:23:50 -0400
Received: from mail-ve1eur01on0091.outbound.protection.outlook.com
	([104.47.1.91]:48592
	helo=EUR01-VE1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <anton.nefedov@virtuozzo.com>)
	id 1dGOCf-0003Pk-UX
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 07:23:46 -0400
References: <1496152683-102751-1-git-send-email-anton.nefedov@virtuozzo.com>
	<1496152683-102751-4-git-send-email-anton.nefedov@virtuozzo.com>
	<CAJ+F1CLJBBJRRGzxRFGxihuD7Gsbxm-0Gg4uvyLfFsC_77NiQA@mail.gmail.com>
From: Anton Nefedov <anton.nefedov@virtuozzo.com>
Message-ID: <e7bb9020-99b1-bb6f-0bf4-1c5d20c692fa@virtuozzo.com>
Date: Thu, 1 Jun 2017 14:23:38 +0300
MIME-Version: 1.0
In-Reply-To: <CAJ+F1CLJBBJRRGzxRFGxihuD7Gsbxm-0Gg4uvyLfFsC_77NiQA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 03/13] char: chardevice hotswap
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@gmail.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, den@virtuozzo.com



On 05/31/2017 10:20 PM, Marc-Andr=C3=A9 Lureau wrote:
> Hi
>=20
> On Tue, May 30, 2017 at 6:12 PM Anton Nefedov=20
> <anton.nefedov@virtuozzo.com <mailto:anton.nefedov@virtuozzo.com>> wrote:
>=20
>     This patch adds a possibility to change a char device without a front=
end
>     removal.
>=20
>     1. Ideally, it would have to happen transparently to a frontend, i.e.
>     frontend would continue its regular operation.
>     However, backends are not stateless and are set up by the frontends
>     via qemu_chr_fe_<> functions, and it's not (generally) possible to
>     replay
>     that setup entirely in a backend code, as different chardevs respond
>     to the setup calls differently, so do frontends work differently basi=
ng
>     on those setup responses.
>     Moreover, some frontend can generally get and save the backend pointe=
r
>     (qemu_chr_fe_get_driver()), and it will become invalid after backend
>     change.
>=20
>     So, a frontend which would like to support chardev hotswap has to
>     register
>     a "backend change" handler, and redo its backend setup there.
>=20
>     2. Write path can be used by multiple threads and thus protected with
>     chr_write_lock.
>     So hotswap also has to be protected so write functions won't access
>     a backend being replaced.
>=20
>=20
> Tbh, I don't understand the need for a different lock. Could you=20
> explain? Even better would be to write a test that shows in which way=20
> the lock helps.
>=20

hi Marc-Andr=C3=A9,

The existing chr_write_lock belongs to Chardev.
For the hotswap case, we need to ensure that be->chr won't change and
the old Chardev (together with its mutex) won't be destroyed while it's
used in the write functions.

Maybe we could move the lock to CharBackend, instead of creating a new
one. But I guess this
  1. won't work for mux, where multiple CharBackends share the same
Chardev
  2. won't work for some chardevs, like pty which uses the lock for the
timer handler

Sorry if I'm not explaining clearly enough or maybe I'm missing some
easier solution?

I can try to add a test but can't quite see yet how to freeze the old
chardev somewhere in cc->chr_write() and hotswap it while it's there.


>=20
>=20
>     Signed-off-by: Anton Nefedov <anton.nefedov@virtuozzo.com
>     <mailto:anton.nefedov@virtuozzo.com>>
>     Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com
>     <mailto:vsementsov@virtuozzo.com>>
>=20
>=20
> patch looks good otherwise
>=20
>     ---
>       chardev/char.c        | 126
>     ++++++++++++++++++++++++++++++++++++++++++++++----
>       include/sysemu/char.h |   9 ++++
>       qapi-schema.json      |  40 ++++++++++++++++
>       3 files changed, 165 insertions(+), 10 deletions(-)
>=20
> --=20
> Marc-Andr=C3=A9 Lureau

/Anton
