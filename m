Received: from eggs.gnu.org ([2001:4830:134:3::10]:41938)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yuval.shaia@oracle.com>) id 1eQeER-0001H2-VF
	for qemu-devel@nongnu.org; Sun, 17 Dec 2017 14:04:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yuval.shaia@oracle.com>) id 1eQeEN-0001x2-19
	for qemu-devel@nongnu.org; Sun, 17 Dec 2017 14:04:15 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:59503)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yuval.shaia@oracle.com>)
	id 1eQeEM-0001u4-KQ
	for qemu-devel@nongnu.org; Sun, 17 Dec 2017 14:04:10 -0500
Date: Sun, 17 Dec 2017 21:03:56 +0200
From: Yuval Shaia <yuval.shaia@oracle.com>
Message-ID: <20171217190355.GA15664@yuvallap>
References: <20171217125457.3429-1-marcel@redhat.com>
	<20171217125457.3429-2-marcel@redhat.com>
	<2ff27216-1dc8-4025-0149-8d5321799120@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <2ff27216-1dc8-4025-0149-8d5321799120@amsat.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH V2 1/5] pci/shpc: Move function to generic
 header file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>
Cc: Marcel Apfelbaum <marcel@redhat.com>, qemu-devel@nongnu.org, ehabkost@redhat.com, mst@redhat.com, pbonzini@redhat.com, imammedo@redhat.com

On Sun, Dec 17, 2017 at 03:16:15PM -0300, Philippe Mathieu-Daud=E9 wrote:
> Hi Marcel, Yuval,
>=20
> On 12/17/2017 09:54 AM, Marcel Apfelbaum wrote:
> > From: Yuval Shaia <yuval.shaia@oracle.com>
> >=20
> > This function should be declared in generic header file so we can
> > utilize it.
> >=20
> > Signed-off-by: Yuval Shaia <yuval.shaia@oracle.com>
> > Signed-off-by: Marcel Apfelbaum <marcel@redhat.com>
> > ---
> >  hw/pci/shpc.c         | 11 +----------
> >  include/qemu/cutils.h | 10 ++++++++++
> >  2 files changed, 11 insertions(+), 10 deletions(-)
> >=20
> > diff --git a/hw/pci/shpc.c b/hw/pci/shpc.c
> > index 69fc14b218..3d22424fd2 100644
> > --- a/hw/pci/shpc.c
> > +++ b/hw/pci/shpc.c
> > @@ -1,6 +1,7 @@
> >  #include "qemu/osdep.h"
> >  #include "qapi/error.h"
> >  #include "qemu-common.h"
> > +#include "qemu/cutils.h"
> >  #include "qemu/range.h"
> >  #include "qemu/error-report.h"
> >  #include "hw/pci/shpc.h"
> > @@ -122,16 +123,6 @@
> >  #define SHPC_PCI_TO_IDX(pci_slot) ((pci_slot) - 1)
> >  #define SHPC_IDX_TO_PHYSICAL(slot) ((slot) + 1)
> > =20
> > -static int roundup_pow_of_two(int x)
> > -{
> > -    x |=3D (x >> 1);
> > -    x |=3D (x >> 2);
> > -    x |=3D (x >> 4);
> > -    x |=3D (x >> 8);
> > -    x |=3D (x >> 16);
> > -    return x + 1;
> > -}
> > -
> >  static uint16_t shpc_get_status(SHPCDevice *shpc, int slot, uint16_t=
 msk)
> >  {
> >      uint8_t *status =3D shpc->config + SHPC_SLOT_STATUS(slot);
> > diff --git a/include/qemu/cutils.h b/include/qemu/cutils.h
> > index f0878eaafa..4895334645 100644
> > --- a/include/qemu/cutils.h
> > +++ b/include/qemu/cutils.h
>=20
> I'd rather move this function below pow2ceil() in "qemu/host-utils.h"
> and rename it pow2roundup().
>=20
> > @@ -164,4 +164,14 @@ bool test_buffer_is_zero_next_accel(void);
> >  int uleb128_encode_small(uint8_t *out, uint32_t n);
> >  int uleb128_decode_small(const uint8_t *in, uint32_t *n);
> > =20
> > +static inline int roundup_pow_of_two(w x)
> > +{
> > +    x |=3D (x >> 1);
> > +    x |=3D (x >> 2);
> > +    x |=3D (x >> 4);
> > +    x |=3D (x >> 8);
> > +    x |=3D (x >> 16);
>=20
> So this would be pow2roundup32(uint32_t value)...
>=20
> Naming it pow2roundup() without specifying the integer size, I'd
> directly use a uint64_t argument, and:
>=20
>        x |=3D (x >> 32);

Make sense, will do.

>=20
> > +    return x + 1;
> > +}
> > +
> >  #endif
>=20
> Naming it pow2roundup() in "qemu/host-utils.h" (regardless the arg size=
):
> Reviewed-by: Philippe Mathieu-Daud=E9 <f4bug@amsat.org>

Thanks.

>=20
> Regards,
>=20
> Phil.
