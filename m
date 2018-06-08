Received: from eggs.gnu.org ([2001:4830:134:3::10]:58913)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fR6tu-0006UR-Rj
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 22:13:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fR6tt-00009e-9N
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 22:13:14 -0400
Date: Fri, 8 Jun 2018 12:13:02 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180608021302.GD3344@umbus.fritz.box>
References: <20180607171751.11510-1-mark.cave-ayland@ilande.co.uk>
	<20180607171751.11510-3-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="a2FkP9tdjPU2nyhF"
Content-Disposition: inline
In-Reply-To: <20180607171751.11510-3-mark.cave-ayland@ilande.co.uk>
Subject: Re: [Qemu-devel] [PATCH 2/4] cuda: embed mos6522_cuda device
 directly rather than using QOM object link
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org


--a2FkP9tdjPU2nyhF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 07, 2018 at 06:17:49PM +0100, Mark Cave-Ayland wrote:
> Examining the migration stream it can be seen that the mos6522 device sta=
te is
> being stored separately rather than as part of the CUDA device which is
> incorrect (and likely to cause issues if another mos6522 device is added =
to
> the machine).
>=20
> Resolve this by embedding the mos6522_cuda device directly within the CUDA
> device rather than using a QOM object link to reference the device separa=
tely.
>=20
> Note that we also bump the version in vmstate_cuda to reflect this change=
: this
> isn't particularly important for the moment as the Mac machine migration =
isn't
> 100% reliable due to issues migrating the timebase under TCG.

And apart from that the mac machine types aren't yet versioned, so
we're not really trying to support migration between different qemu
versions anyway.

>=20
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> ---
>  hw/misc/macio/cuda.c         | 44 ++++++++++++++++++--------------------=
------
>  hw/misc/mos6522.c            |  2 +-
>  include/hw/misc/macio/cuda.h | 27 ++++++++++++---------------
>  include/hw/misc/mos6522.h    |  2 ++
>  4 files changed, 33 insertions(+), 42 deletions(-)
>=20
> diff --git a/hw/misc/macio/cuda.c b/hw/misc/macio/cuda.c
> index bd9b862034..8aba2e63ec 100644
> --- a/hw/misc/macio/cuda.c
> +++ b/hw/misc/macio/cuda.c
> @@ -65,7 +65,7 @@ static void cuda_receive_packet_from_host(CUDAState *s,
>  static uint64_t cuda_get_counter_value(MOS6522State *s, MOS6522Timer *ti)
>  {
>      MOS6522CUDAState *mcs =3D container_of(s, MOS6522CUDAState, parent_o=
bj);
> -    CUDAState *cs =3D mcs->cuda;
> +    CUDAState *cs =3D container_of(mcs, CUDAState, mos6522_cuda);
> =20
>      /* Reverse of the tb calculation algorithm that Mac OS X uses on boo=
tup */
>      uint64_t tb_diff =3D muldiv64(qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL),
> @@ -78,7 +78,7 @@ static uint64_t cuda_get_counter_value(MOS6522State *s,=
 MOS6522Timer *ti)
>  static uint64_t cuda_get_load_time(MOS6522State *s, MOS6522Timer *ti)
>  {
>      MOS6522CUDAState *mcs =3D container_of(s, MOS6522CUDAState, parent_o=
bj);
> -    CUDAState *cs =3D mcs->cuda;
> +    CUDAState *cs =3D container_of(mcs, CUDAState, mos6522_cuda);
> =20
>      uint64_t load_time =3D muldiv64(qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL=
),
>                                    cs->tb_frequency, NANOSECONDS_PER_SECO=
ND);
> @@ -88,7 +88,7 @@ static uint64_t cuda_get_load_time(MOS6522State *s, MOS=
6522Timer *ti)
>  static void cuda_set_sr_int(void *opaque)
>  {
>      CUDAState *s =3D opaque;
> -    MOS6522CUDAState *mcs =3D s->mos6522_cuda;
> +    MOS6522CUDAState *mcs =3D &s->mos6522_cuda;
>      MOS6522State *ms =3D MOS6522(mcs);
>      MOS6522DeviceClass *mdc =3D MOS6522_DEVICE_GET_CLASS(ms);
> =20
> @@ -97,7 +97,7 @@ static void cuda_set_sr_int(void *opaque)
> =20
>  static void cuda_delay_set_sr_int(CUDAState *s)
>  {
> -    MOS6522CUDAState *mcs =3D s->mos6522_cuda;
> +    MOS6522CUDAState *mcs =3D &s->mos6522_cuda;
>      MOS6522State *ms =3D MOS6522(mcs);
>      MOS6522DeviceClass *mdc =3D MOS6522_DEVICE_GET_CLASS(ms);
>      int64_t expire;
> @@ -117,7 +117,7 @@ static void cuda_delay_set_sr_int(CUDAState *s)
>  /* NOTE: TIP and TREQ are negated */
>  static void cuda_update(CUDAState *s)
>  {
> -    MOS6522CUDAState *mcs =3D s->mos6522_cuda;
> +    MOS6522CUDAState *mcs =3D &s->mos6522_cuda;
>      MOS6522State *ms =3D MOS6522(mcs);
>      int packet_received, len;
> =20
> @@ -462,7 +462,7 @@ static void cuda_receive_packet_from_host(CUDAState *=
s,
>  static uint64_t mos6522_cuda_read(void *opaque, hwaddr addr, unsigned si=
ze)
>  {
>      CUDAState *s =3D opaque;
> -    MOS6522CUDAState *mcs =3D s->mos6522_cuda;
> +    MOS6522CUDAState *mcs =3D &s->mos6522_cuda;
>      MOS6522State *ms =3D MOS6522(mcs);
> =20
>      addr =3D (addr >> 9) & 0xf;
> @@ -473,7 +473,7 @@ static void mos6522_cuda_write(void *opaque, hwaddr a=
ddr, uint64_t val,
>                                 unsigned size)
>  {
>      CUDAState *s =3D opaque;
> -    MOS6522CUDAState *mcs =3D s->mos6522_cuda;
> +    MOS6522CUDAState *mcs =3D &s->mos6522_cuda;
>      MOS6522State *ms =3D MOS6522(mcs);
> =20
>      addr =3D (addr >> 9) & 0xf;
> @@ -492,9 +492,11 @@ static const MemoryRegionOps mos6522_cuda_ops =3D {
> =20
>  static const VMStateDescription vmstate_cuda =3D {
>      .name =3D "cuda",
> -    .version_id =3D 4,
> -    .minimum_version_id =3D 4,
> +    .version_id =3D 5,
> +    .minimum_version_id =3D 5,
>      .fields =3D (VMStateField[]) {
> +        VMSTATE_STRUCT(mos6522_cuda.parent_obj, CUDAState, 0, vmstate_mo=
s6522,
> +                       MOS6522State),
>          VMSTATE_UINT8(last_b, CUDAState),
>          VMSTATE_UINT8(last_acr, CUDAState),
>          VMSTATE_INT32(data_in_size, CUDAState),
> @@ -530,12 +532,8 @@ static void cuda_realize(DeviceState *dev, Error **e=
rrp)
>      DeviceState *d;
>      struct tm tm;
> =20
> -    d =3D qdev_create(NULL, TYPE_MOS6522_CUDA);
> -    object_property_set_link(OBJECT(d), OBJECT(s), "cuda", errp);
> -    qdev_init_nofail(d);
> -    s->mos6522_cuda =3D MOS6522_CUDA(d);
> -
>      /* Pass IRQ from 6522 */
> +    d =3D DEVICE(&s->mos6522_cuda);
>      ms =3D MOS6522(d);
>      sbd =3D SYS_BUS_DEVICE(s);
>      sysbus_pass_irq(sbd, SYS_BUS_DEVICE(ms));
> @@ -556,6 +554,10 @@ static void cuda_init(Object *obj)
>      CUDAState *s =3D CUDA(obj);
>      SysBusDevice *sbd =3D SYS_BUS_DEVICE(obj);
> =20
> +    object_initialize(&s->mos6522_cuda, sizeof(s->mos6522_cuda),
> +                      TYPE_MOS6522_CUDA);
> +    qdev_set_parent_bus(DEVICE(&s->mos6522_cuda), sysbus_get_default());
> +
>      memory_region_init_io(&s->mem, obj, &mos6522_cuda_ops, s, "cuda", 0x=
2000);
>      sysbus_init_mmio(sbd, &s->mem);
> =20
> @@ -590,8 +592,9 @@ static const TypeInfo cuda_type_info =3D {
>  static void mos6522_cuda_portB_write(MOS6522State *s)
>  {
>      MOS6522CUDAState *mcs =3D container_of(s, MOS6522CUDAState, parent_o=
bj);
> +    CUDAState *cs =3D container_of(mcs, CUDAState, mos6522_cuda);
> =20
> -    cuda_update(mcs->cuda);
> +    cuda_update(cs);
>  }
> =20
>  static void mos6522_cuda_realize(DeviceState *dev, Error **errp)
> @@ -605,16 +608,6 @@ static void mos6522_cuda_realize(DeviceState *dev, E=
rror **errp)
>      ms->timers[1].frequency =3D (SCALE_US * 6000) / 4700;
>  }
> =20
> -static void mos6522_cuda_init(Object *obj)
> -{
> -    MOS6522CUDAState *s =3D MOS6522_CUDA(obj);
> -
> -    object_property_add_link(obj, "cuda", TYPE_CUDA,
> -                             (Object **) &s->cuda,
> -                             qdev_prop_allow_set_link_before_realize,
> -                             0, NULL);
> -}
> -
>  static void mos6522_cuda_class_init(ObjectClass *oc, void *data)
>  {
>      DeviceClass *dc =3D DEVICE_CLASS(oc);
> @@ -632,7 +625,6 @@ static const TypeInfo mos6522_cuda_type_info =3D {
>      .name =3D TYPE_MOS6522_CUDA,
>      .parent =3D TYPE_MOS6522,
>      .instance_size =3D sizeof(MOS6522CUDAState),
> -    .instance_init =3D mos6522_cuda_init,
>      .class_init =3D mos6522_cuda_class_init,
>  };
> =20
> diff --git a/hw/misc/mos6522.c b/hw/misc/mos6522.c
> index dd56c796e4..facdaed5d5 100644
> --- a/hw/misc/mos6522.c
> +++ b/hw/misc/mos6522.c
> @@ -390,7 +390,7 @@ static const VMStateDescription vmstate_mos6522_timer=
 =3D {
>      }
>  };
> =20
> -static const VMStateDescription vmstate_mos6522 =3D {
> +const VMStateDescription vmstate_mos6522 =3D {
>      .name =3D "mos6522",
>      .version_id =3D 0,
>      .minimum_version_id =3D 0,
> diff --git a/include/hw/misc/macio/cuda.h b/include/hw/misc/macio/cuda.h
> index 494b709579..7dad469142 100644
> --- a/include/hw/misc/macio/cuda.h
> +++ b/include/hw/misc/macio/cuda.h
> @@ -54,12 +54,21 @@
>  #define CUDA_TIMER_TICKLE              0x24
>  #define CUDA_COMBINED_FORMAT_IIC       0x25
> =20
> +
> +/* MOS6522 CUDA */
> +typedef struct MOS6522CUDAState {
> +    /*< private >*/
> +    MOS6522State parent_obj;
> +} MOS6522CUDAState;
> +
> +#define TYPE_MOS6522_CUDA "mos6522-cuda"
> +#define MOS6522_CUDA(obj) OBJECT_CHECK(MOS6522CUDAState, (obj), \
> +                                       TYPE_MOS6522_CUDA)
> +
>  /* Cuda */
>  #define TYPE_CUDA "cuda"
>  #define CUDA(obj) OBJECT_CHECK(CUDAState, (obj), TYPE_CUDA)
> =20
> -typedef struct MOS6522CUDAState MOS6522CUDAState;
> -
>  typedef struct CUDAState {
>      /*< private >*/
>      SysBusDevice parent_obj;
> @@ -67,7 +76,7 @@ typedef struct CUDAState {
>      MemoryRegion mem;
> =20
>      ADBBusState adb_bus;
> -    MOS6522CUDAState *mos6522_cuda;
> +    MOS6522CUDAState mos6522_cuda;
> =20
>      uint32_t tick_offset;
>      uint64_t tb_frequency;
> @@ -92,16 +101,4 @@ typedef struct CUDAState {
>      QEMUTimer *adb_poll_timer;
>  } CUDAState;
> =20
> -/* MOS6522 CUDA */
> -struct MOS6522CUDAState {
> -    /*< private >*/
> -    MOS6522State parent_obj;
> -
> -    CUDAState *cuda;
> -};
> -
> -#define TYPE_MOS6522_CUDA "mos6522-cuda"
> -#define MOS6522_CUDA(obj) OBJECT_CHECK(MOS6522CUDAState, (obj), \
> -                                       TYPE_MOS6522_CUDA)
> -
>  #endif /* CUDA_H */
> diff --git a/include/hw/misc/mos6522.h b/include/hw/misc/mos6522.h
> index a53c161b00..cb0fd7db78 100644
> --- a/include/hw/misc/mos6522.h
> +++ b/include/hw/misc/mos6522.h
> @@ -146,6 +146,8 @@ typedef struct MOS6522DeviceClass {
>  #define MOS6522_DEVICE_GET_CLASS(obj) \
>      OBJECT_GET_CLASS(MOS6522DeviceClass, (obj), TYPE_MOS6522)
> =20
> +extern const VMStateDescription vmstate_mos6522;
> +
>  uint64_t mos6522_read(void *opaque, hwaddr addr, unsigned size);
>  void mos6522_write(void *opaque, hwaddr addr, uint64_t val, unsigned siz=
e);
> =20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--a2FkP9tdjPU2nyhF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlsZ5i4ACgkQbDjKyiDZ
s5KrfBAAtUJG3KQwU9OC1zO3NZ70JhNffElfEtyqEhcganQ84QmrcRVrXJyQFGq6
w5aveCygoM8SqPkcrZKDqPPaBpRAQBn5rsuwMj9oSSh5+CxJ3q8Z7zXFK9NjML4B
yp2G+M8ND4JKsdykXc8Os7/Oxo752WV5PaYOPP3ppYfr0Vlj+LUyFEFla06WPCOo
g/rAZg1D3FvgoJCxRIICxMZXYP9oE2BuNfjjGOTX6B+8y6y6cX4JlinFN7Oc4MWf
WrEWrwNySimROsna1ivgh9QyzCegMtGrXFnnCZjDrp4ik9Jiid1BiqXyCXdpICpR
65Kpw9BOzaI3qn4UptmjW0wSV2w1n2/Y81XHH40PxBDhKbKdkf1B36GgvUPCkh0s
2CVLZZgxVYknG/QTxrUc8FU6xE/VchtKbhrSgRftxCS8UpXZ1IlmqabbW6D6yNWA
qBbPnalPZmathkrtK4TPHhAUPEJ3K2TDK54yiTyes9X6pMYXtgCE9HbjGL3GbHfj
ZcAo2KetvGreZhknZsEeJ7Fnrkr/mEcWmxigdt5dBdNYFn6Ox5usXVuuhJtYqCVa
BCzOiVZz7vDC5X8nvu2weRMVbIiADOQWYs9IdwNlmPyYTR8q4X9LhjBF7bI/ih2e
j9CUagKgRBHccI2g8gRPMAj8uzU08VmYRdbkyEJGEvkhx2vqHdM=
=0rRF
-----END PGP SIGNATURE-----

--a2FkP9tdjPU2nyhF--
