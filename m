Received: from eggs.gnu.org ([2001:4830:134:3::10]:49602)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1ctwnD-00040t-Uh
	for qemu-devel@nongnu.org; Fri, 31 Mar 2017 09:40:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1ctwnC-0003iL-Vk
	for qemu-devel@nongnu.org; Fri, 31 Mar 2017 09:40:43 -0400
Date: Fri, 31 Mar 2017 10:40:33 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170331134033.GY3709@thinpad.lan.raisama.net>
References: <1490965980-513-1-git-send-email-peter.maydell@linaro.org>
	<5979a675-6077-50f8-0714-7e509a9bc492@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <5979a675-6077-50f8-0714-7e509a9bc492@amsat.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] block/parallels.c: avoid integer overflow
 in allocate_clusters()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, patches@linaro.org, Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, "Denis V. Lunev" <den@openvz.org>

On Fri, Mar 31, 2017 at 10:27:44AM -0300, Philippe Mathieu-Daud=E9 wrote:
> Hi,
>=20
> Eduardo you seem skilled regarding Coccinelle scripts, is it possible t=
o
> write one to find those overflows?

Probably not. AFAIK, Coccinelle rules are based on local code
syntax only. This means it doesn't know the data type of
expressions like (s->tracks).

>=20
> Peter having one more macro might help or confuses more?
>=20
> #define MULTIPLY64(a32, b32) ((int64_t)a32 * b32)
>=20
> On 03/31/2017 10:13 AM, Peter Maydell wrote:
> > Coverity (CID 1307776) points out that in the multiply:
> >   space =3D to_allocate * s->tracks;
> > we are trying to calculate a 64 bit result but the types
> > of to_allocate and s->tracks mean that we actually calculate
> > a 32 bit result. Add an explicit cast to force a 64 bit
> > multiply.
> >=20
> > Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
>=20
> Reviewed-by: Philippe Mathieu-Daud=E9 <f4bug@amsat.org>
>=20
> > ---
> > NB: compile-and-make-check tested only...
> > ---
> >  block/parallels.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > diff --git a/block/parallels.c b/block/parallels.c
> > index 4173b3f..3886c30 100644
> > --- a/block/parallels.c
> > +++ b/block/parallels.c
> > @@ -206,7 +206,7 @@ static int64_t allocate_clusters(BlockDriverState=
 *bs, int64_t sector_num,
> >      }
> >=20
> >      to_allocate =3D DIV_ROUND_UP(sector_num + *pnum, s->tracks) - id=
x;
> > -    space =3D to_allocate * s->tracks;
> > +    space =3D (int64_t)to_allocate * s->tracks;
> >      if (s->data_end + space > bdrv_getlength(bs->file->bs) >> BDRV_S=
ECTOR_BITS) {
> >          int ret;
> >          space +=3D s->prealloc_size;
> >=20

--=20
Eduardo
