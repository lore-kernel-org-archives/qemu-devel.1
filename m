Received: from eggs.gnu.org ([2001:4830:134:3::10]:42766)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fXYkq-0006L4-7T
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 17:10:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fXYkp-0001oe-0G
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 17:10:32 -0400
References: <20180620042930.24208-1-suratiamol@gmail.com>
	<20180620042930.24208-2-suratiamol@gmail.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <4049a376-e991-91ab-a1ea-037ee7c0a5b5@redhat.com>
Date: Mon, 25 Jun 2018 17:10:23 -0400
MIME-Version: 1.0
In-Reply-To: <20180620042930.24208-2-suratiamol@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 1/2] ide/hw/core: fix crash on processing a
 partial-sector-size DMA xfer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Amol Surati <suratiamol@gmail.com>, qemu-devel@nongnu.org
Cc: "open list:IDE" <qemu-block@nongnu.org>



On 06/20/2018 12:29 AM, Amol Surati wrote:
> Fixes: https://bugs.launchpad.net/qemu/+bug/1777315
>=20
> QEMU's short PRD policy applies to a DMA transfer of size < 512 bytes.
> But it fails to consider transfers which are >=3D 512 bytes, but are
> not a multiple of 512 bytes.
>=20
> Such transfers are not subject to the short PRD policy. They end up
> violating the assumptions about the granularity of the IO sizes,
> upon which depend the verification of the completion of the previous
> transfer, and the advancement of the offset in preparation of the next.
>=20
> Those violations result in the crash.
>=20
> By forcing each transfer to be a multiple of sector size, such
> transfers are subjected to the policy, and therefore culled before they
> cause the crash.
>=20

So now even if the PRDT we get is greater than a sector is not an even
multiple of 512, we reject it as too short.

That doesn't seem correct to me.

> Signed-off-by: Amol Surati <suratiamol@gmail.com>
> ---
>  hw/ide/core.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>=20
> diff --git a/hw/ide/core.c b/hw/ide/core.c
> index 2c62efc536..14d135224b 100644
> --- a/hw/ide/core.c
> +++ b/hw/ide/core.c
> @@ -836,6 +836,7 @@ static void ide_dma_cb(void *opaque, int ret)
>  {
>      IDEState *s =3D opaque;
>      int n;
> +    int32_t size_prepared;
>      int64_t sector_num;
>      uint64_t offset;
>      bool stay_active =3D false;
> @@ -886,7 +887,9 @@ static void ide_dma_cb(void *opaque, int ret)
>      n =3D s->nsector;
>      s->io_buffer_index =3D 0;
>      s->io_buffer_size =3D n * 512;
> -    if (s->bus->dma->ops->prepare_buf(s->bus->dma, s->io_buffer_size) =
< 512) {
> +    size_prepared =3D s->bus->dma->ops->prepare_buf(s->bus->dma,
> +                                                  s->io_buffer_size);
> +    if (size_prepared <=3D 0 || size_prepared % 512) {
>          /* The PRDs were too short. Reset the Active bit, but don't ra=
ise an
>           * interrupt. */
>          s->status =3D READY_STAT | SEEK_STAT;
>=20

--=20
=E2=80=94js
