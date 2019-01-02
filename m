Received: from eggs.gnu.org ([208.118.235.92]:51597)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcfaracco@gmail.com>) id 1gehMn-0005Hg-TK
	for qemu-devel@nongnu.org; Wed, 02 Jan 2019 09:19:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcfaracco@gmail.com>) id 1gehMm-0007zF-VZ
	for qemu-devel@nongnu.org; Wed, 02 Jan 2019 09:19:29 -0500
MIME-Version: 1.0
References: <20181221135803.9583-1-npes87184@gmail.com>
	<20190102104659.GG24009@stefanha-x1.localdomain>
In-Reply-To: <20190102104659.GG24009@stefanha-x1.localdomain>
From: Julio Faracco <jcfaracco@gmail.com>
Date: Wed, 2 Jan 2019 12:19:12 -0200
Message-ID: <CAENf94JObEbH6tm53itn8zMZsJak3JUD9TkkSqzgeEwnjRDQUw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH] dmg: fix binary search
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: yuchenlin <npes87184@gmail.com>, qemu-trivial@nongnu.org, QEMU Developers <qemu-devel@nongnu.org>, qemu-block@nongnu.org

Hi Stefan,

I created a simple DMG file from MacOS to reproduce the problem:
https://bugs.launchpad.net/qemu/+bug/1809304

Em qua, 2 de jan de 2019 =C3=A0s 08:47, Stefan Hajnoczi <stefanha@redhat.co=
m>
escreveu:

> On Fri, Dec 21, 2018 at 09:58:03PM +0800, yuchenlin wrote:
> > There is a possible hang in original binary searsh implemtation. That i=
s
> > if chunk1 =3D 4, chunk2 =3D 5, chunk3 =3D 4, and we go else case.
> >
> > The chunk1 will be still 4, and so on.
> >
> > Signed-off-by: yuchenlin <npes87184@gmail.com>
> > ---
> >  block/dmg.c | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
>
> Do you have an example dmg file that triggers this bug?
>
> > diff --git a/block/dmg.c b/block/dmg.c
> > index 50e91aef6d..0e05702f5d 100644
> > --- a/block/dmg.c
> > +++ b/block/dmg.c
> > @@ -572,14 +572,14 @@ static inline uint32_t search_chunk(BDRVDMGState
> *s, uint64_t sector_num)
> >  {
> >      /* binary search */
> >      uint32_t chunk1 =3D 0, chunk2 =3D s->n_chunks, chunk3;
> > -    while (chunk1 !=3D chunk2) {
> > +    while (chunk1 <=3D chunk2) {
> >          chunk3 =3D (chunk1 + chunk2) / 2;
> >          if (s->sectors[chunk3] > sector_num) {
> > -            chunk2 =3D chunk3;
> > +            chunk2 =3D chunk3 - 1;
>
> What if chunk1 =3D 0 and chunk2 =3D 1?  chunk3 =3D 0 and the new chunk2 v=
alue
> would be 0xffffffff so the loop continues with out-of-bounds sectors[]
> accesses!
>
