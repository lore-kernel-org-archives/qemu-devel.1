Received: from eggs.gnu.org ([208.118.235.92]:43887)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <npes87184@gmail.com>) id 1gefWf-0004NN-0O
	for qemu-devel@nongnu.org; Wed, 02 Jan 2019 07:21:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <npes87184@gmail.com>) id 1gefWe-00087m-2F
	for qemu-devel@nongnu.org; Wed, 02 Jan 2019 07:21:33 -0500
MIME-Version: 1.0
References: <20181223025939.15775-1-npes87184@gmail.com>
	<20181223025939.15775-2-npes87184@gmail.com>
	<20190102114919.GJ24009@stefanha-x1.localdomain>
In-Reply-To: <20190102114919.GJ24009@stefanha-x1.localdomain>
From: =?UTF-8?B?5p6X6IKy6L6w?= <npes87184@gmail.com>
Date: Wed, 2 Jan 2019 20:20:54 +0800
Message-ID: <CAPTqjH1K3RYH1A2Q8Fhkh5x6hOE5CU9qTqRtjFC8WLk3UBNFOA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 1/3] dmg: fix binary search
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org

Hi, Stefan

Thank you for your reviewing.

This series is focus on fixing bug #1809304 (see:
https://bugs.launchpad.net/qemu/+bug/1809304).
There is an example dmg file in #1809304 which will trigger this bug.

About your case, I think we can simply check whether chunk3 is zero before
we decrease it.
if s->sectors[chunk3] > sector_num and chunk3 is zero (i.e. s->sectors[0] >
sector_num), it means we cannot find the table contains sector_num.
We can return s->n_chunks (error) directly.

What do you think?

Thanks,
Yu-Chen


Stefan Hajnoczi <stefanha@redhat.com> =E6=96=BC 2019=E5=B9=B41=E6=9C=882=E6=
=97=A5 =E9=80=B1=E4=B8=89 =E4=B8=8B=E5=8D=887:49=E5=AF=AB=E9=81=93=EF=BC=9A

> On Sun, Dec 23, 2018 at 10:59:37AM +0800, yuchenlin wrote:
> > There is a possible hang in original binary search implementation. That
> is
> > if chunk1 =3D 4, chunk2 =3D 5, chunk3 =3D 4, and we go else case.
> >
> > The chunk1 will be still 4, and so on.
> >
> > Signed-off-by: yuchenlin <npes87184@gmail.com>
> > ---
> >  block/dmg.c | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> >
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
> Question from the previous email you sent:
>
> What happens when chunk1 =3D 0, chunk2 =3D 1, and chunk3 =3D 0?  This wou=
ld
> cause out-of-bounds sectors[] accesses.
>
> Stefan
>
