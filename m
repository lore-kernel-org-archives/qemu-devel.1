Received: from eggs.gnu.org ([2001:4830:134:3::10]:33798)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1dSnM3-0001Ty-KQ
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 12:40:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1dSnM2-00054x-RZ
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 12:40:43 -0400
Date: Wed, 5 Jul 2017 12:40:36 -0400 (EDT)
From: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Message-ID: <1043373876.47277851.1499272836038.JavaMail.zimbra@redhat.com>
In-Reply-To: <97758bb8-cdd1-8318-e8a0-13a3607c849f@redhat.com>
References: <20170704220346.29244-1-marcandre.lureau@redhat.com>
	<20170704220346.29244-9-marcandre.lureau@redhat.com>
	<4ffefaff-3c04-9328-a27b-332d30153b0a@redhat.com>
	<2079725542.47180593.1499264497487.JavaMail.zimbra@redhat.com>
	<e8eeea5e-6ec5-d2ca-3ff2-631d493afe76@redhat.com>
	<1661217396.47274977.1499270778716.JavaMail.zimbra@redhat.com>
	<97758bb8-cdd1-8318-e8a0-13a3607c849f@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 08/35] block: all bdrv_aio callbacks are
 coroutine_fn
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, "open list:Block layer core" <qemu-block@nongnu.org>, Max Reitz <mreitz@redhat.com>

Hi

----- Original Message -----
>=20
>=20
> On 05/07/2017 18:06, Marc-Andr=C3=A9 Lureau wrote:
> >>> coroutine_fn too)
> >> It's not controversial, I would not have expected the functions to cal=
l
> >> coroutine_fn. :)  How do they do that?
> >>
> > For example,  null_co_readv() calls  null_co_common() which calls
> > co_aio_sleep_ns()
>=20
> But these are bdrv_co_*, not bdrv_aio_*.

Oops, right.

Indeed, it's not needed, but to avoid coroutine annotation mismatch, we wou=
ld have to remove a few:

static coroutine_fn BlockAIOCB *raw_aio_pdiscard(BlockDriverState *bs,

static coroutine_fn BlockAIOCB *hdev_aio_pdiscard(BlockDriverState *bs,

Only those 2, it seems.
