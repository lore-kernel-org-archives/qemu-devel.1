Received: from eggs.gnu.org ([2001:4830:134:3::10]:59648)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1clQpg-0004e9-6B
	for qemu-devel@nongnu.org; Tue, 07 Mar 2017 20:56:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1clQpc-0000Mi-U0
	for qemu-devel@nongnu.org; Tue, 07 Mar 2017 20:56:04 -0500
Date: Wed, 8 Mar 2017 12:47:30 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170308014730.GF19967@umbus.fritz.box>
References: <1488878620-30617-1-git-send-email-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="0rSojgWGcpz+ezC3"
Content-Disposition: inline
In-Reply-To: <1488878620-30617-1-git-send-email-clg@kaod.org>
Subject: Re: [Qemu-devel] [PATCH for-2.10] ppc/spapr: QOM'ify sPAPRRTCState
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Cc: Thomas Huth <thuth@redhat.com>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org


--0rSojgWGcpz+ezC3
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 07, 2017 at 10:23:40AM +0100, C=E9dric Le Goater wrote:
> Also use an 'sPAPRRTCState' attribute under the sPAPR machine to hold
> the RTC object. Overall, these changes remove an unnecessary and
> implicit dependency on SysBus.
>=20
> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>

Applied to ppc-for-2.10.

> ---
>  hw/ppc/spapr.c         | 16 ++++++++--------
>  hw/ppc/spapr_events.c  |  2 +-
>  hw/ppc/spapr_rtc.c     | 41 +++++++----------------------------------
>  include/hw/ppc/spapr.h | 21 ++++++++++++++++-----
>  include/hw/ppc/xics.h  |  2 +-
>  5 files changed, 33 insertions(+), 49 deletions(-)
>=20
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index c3bb99160545..3a7868ed80da 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -1333,13 +1333,13 @@ static void spapr_create_nvram(sPAPRMachineState =
*spapr)
> =20
>  static void spapr_rtc_create(sPAPRMachineState *spapr)
>  {
> -    DeviceState *dev =3D qdev_create(NULL, TYPE_SPAPR_RTC);
> -
> -    qdev_init_nofail(dev);
> -    spapr->rtc =3D dev;
> -
> -    object_property_add_alias(qdev_get_machine(), "rtc-time",
> -                              OBJECT(spapr->rtc), "date", NULL);
> +    object_initialize(&spapr->rtc, sizeof(spapr->rtc), TYPE_SPAPR_RTC);
> +    object_property_add_child(OBJECT(spapr), "rtc", OBJECT(&spapr->rtc),
> +                              &error_fatal);
> +    object_property_set_bool(OBJECT(&spapr->rtc), true, "realized",
> +                              &error_fatal);
> +    object_property_add_alias(OBJECT(spapr), "rtc-time", OBJECT(&spapr->=
rtc),
> +                              "date", &error_fatal);
>  }
> =20
>  /* Returns whether we want to use VGA or not */
> @@ -1377,7 +1377,7 @@ static int spapr_post_load(void *opaque, int versio=
n_id)
>       * So when migrating from those versions, poke the incoming offset
>       * value into the RTC device */
>      if (version_id < 3) {
> -        err =3D spapr_rtc_import_offset(spapr->rtc, spapr->rtc_offset);
> +        err =3D spapr_rtc_import_offset(&spapr->rtc, spapr->rtc_offset);
>      }
> =20
>      return err;
> diff --git a/hw/ppc/spapr_events.c b/hw/ppc/spapr_events.c
> index 24a5758e6243..f0b28d811242 100644
> --- a/hw/ppc/spapr_events.c
> +++ b/hw/ppc/spapr_events.c
> @@ -422,7 +422,7 @@ static void spapr_init_maina(struct rtas_event_log_v6=
_maina *maina,
>      maina->hdr.section_id =3D cpu_to_be16(RTAS_LOG_V6_SECTION_ID_MAINA);
>      maina->hdr.section_length =3D cpu_to_be16(sizeof(*maina));
>      /* FIXME: section version, subtype and creator id? */
> -    spapr_rtc_read(spapr->rtc, &tm, NULL);
> +    spapr_rtc_read(&spapr->rtc, &tm, NULL);
>      year =3D tm.tm_year + 1900;
>      maina->creation_date =3D cpu_to_be32((to_bcd(year / 100) << 24)
>                                         | (to_bcd(year % 100) << 16)
> diff --git a/hw/ppc/spapr_rtc.c b/hw/ppc/spapr_rtc.c
> index 3a17ac42e44b..00a4e4c717d5 100644
> --- a/hw/ppc/spapr_rtc.c
> +++ b/hw/ppc/spapr_rtc.c
> @@ -33,19 +33,8 @@
>  #include "qapi-event.h"
>  #include "qemu/cutils.h"
> =20
> -#define SPAPR_RTC(obj) \
> -    OBJECT_CHECK(sPAPRRTCState, (obj), TYPE_SPAPR_RTC)
> -
> -typedef struct sPAPRRTCState sPAPRRTCState;
> -struct sPAPRRTCState {
> -    /*< private >*/
> -    SysBusDevice parent_obj;
> -    int64_t ns_offset;
> -};
> -
> -void spapr_rtc_read(DeviceState *dev, struct tm *tm, uint32_t *ns)
> +void spapr_rtc_read(sPAPRRTCState *rtc, struct tm *tm, uint32_t *ns)
>  {
> -    sPAPRRTCState *rtc =3D SPAPR_RTC(dev);
>      int64_t host_ns =3D qemu_clock_get_ns(rtc_clock);
>      int64_t guest_ns;
>      time_t guest_s;
> @@ -63,16 +52,12 @@ void spapr_rtc_read(DeviceState *dev, struct tm *tm, =
uint32_t *ns)
>      }
>  }
> =20
> -int spapr_rtc_import_offset(DeviceState *dev, int64_t legacy_offset)
> +int spapr_rtc_import_offset(sPAPRRTCState *rtc, int64_t legacy_offset)
>  {
> -    sPAPRRTCState *rtc;
> -
> -    if (!dev) {
> +    if (!rtc) {
>          return -ENODEV;
>      }
> =20
> -    rtc =3D SPAPR_RTC(dev);
> -
>      rtc->ns_offset =3D legacy_offset * NANOSECONDS_PER_SECOND;
> =20
>      return 0;
> @@ -91,12 +76,7 @@ static void rtas_get_time_of_day(PowerPCCPU *cpu, sPAP=
RMachineState *spapr,
>          return;
>      }
> =20
> -    if (!spapr->rtc) {
> -        rtas_st(rets, 0, RTAS_OUT_HW_ERROR);
> -        return;
> -    }
> -
> -    spapr_rtc_read(spapr->rtc, &tm, &ns);
> +    spapr_rtc_read(&spapr->rtc, &tm, &ns);
> =20
>      rtas_st(rets, 0, RTAS_OUT_SUCCESS);
>      rtas_st(rets, 1, tm.tm_year + 1900);
> @@ -113,7 +93,7 @@ static void rtas_set_time_of_day(PowerPCCPU *cpu, sPAP=
RMachineState *spapr,
>                                   target_ulong args,
>                                   uint32_t nret, target_ulong rets)
>  {
> -    sPAPRRTCState *rtc;
> +    sPAPRRTCState *rtc =3D &spapr->rtc;
>      struct tm tm;
>      time_t new_s;
>      int64_t host_ns;
> @@ -123,11 +103,6 @@ static void rtas_set_time_of_day(PowerPCCPU *cpu, sP=
APRMachineState *spapr,
>          return;
>      }
> =20
> -    if (!spapr->rtc) {
> -        rtas_st(rets, 0, RTAS_OUT_HW_ERROR);
> -        return;
> -    }
> -
>      tm.tm_year =3D rtas_ld(args, 0) - 1900;
>      tm.tm_mon =3D rtas_ld(args, 1) - 1;
>      tm.tm_mday =3D rtas_ld(args, 2);
> @@ -144,8 +119,6 @@ static void rtas_set_time_of_day(PowerPCCPU *cpu, sPA=
PRMachineState *spapr,
>      /* Generate a monitor event for the change */
>      qapi_event_send_rtc_change(qemu_timedate_diff(&tm), &error_abort);
> =20
> -    rtc =3D SPAPR_RTC(spapr->rtc);
> -
>      host_ns =3D qemu_clock_get_ns(rtc_clock);
> =20
>      rtc->ns_offset =3D (new_s * NANOSECONDS_PER_SECOND) - host_ns;
> @@ -155,7 +128,7 @@ static void rtas_set_time_of_day(PowerPCCPU *cpu, sPA=
PRMachineState *spapr,
> =20
>  static void spapr_rtc_qom_date(Object *obj, struct tm *current_tm, Error=
 **errp)
>  {
> -    spapr_rtc_read(DEVICE(obj), current_tm, NULL);
> +    spapr_rtc_read(SPAPR_RTC(obj), current_tm, NULL);
>  }
> =20
>  static void spapr_rtc_realize(DeviceState *dev, Error **errp)
> @@ -200,7 +173,7 @@ static void spapr_rtc_class_init(ObjectClass *oc, voi=
d *data)
> =20
>  static const TypeInfo spapr_rtc_info =3D {
>      .name          =3D TYPE_SPAPR_RTC,
> -    .parent        =3D TYPE_SYS_BUS_DEVICE,
> +    .parent        =3D TYPE_DEVICE,
>      .instance_size =3D sizeof(sPAPRRTCState),
>      .class_init    =3D spapr_rtc_class_init,
>  };
> diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
> index 808aac870359..ba9e689ee230 100644
> --- a/include/hw/ppc/spapr.h
> +++ b/include/hw/ppc/spapr.h
> @@ -20,6 +20,18 @@ typedef struct sPAPREventSource sPAPREventSource;
> =20
>  #define SPAPR_TIMEBASE_FREQ     512000000ULL
> =20
> +#define TYPE_SPAPR_RTC "spapr-rtc"
> +
> +#define SPAPR_RTC(obj)                                  \
> +    OBJECT_CHECK(sPAPRRTCState, (obj), TYPE_SPAPR_RTC)
> +
> +typedef struct sPAPRRTCState sPAPRRTCState;
> +struct sPAPRRTCState {
> +    /*< private >*/
> +    DeviceState parent_obj;
> +    int64_t ns_offset;
> +};
> +
>  typedef struct sPAPRMachineClass sPAPRMachineClass;
> =20
>  #define TYPE_SPAPR_MACHINE      "spapr-machine"
> @@ -58,7 +70,7 @@ struct sPAPRMachineState {
>      QLIST_HEAD(, sPAPRPHBState) phbs;
>      struct sPAPRNVRAM *nvram;
>      ICSState *ics;
> -    DeviceState *rtc;
> +    sPAPRRTCState rtc;
> =20
>      void *htab;
>      uint32_t htab_shift;
> @@ -629,11 +641,10 @@ struct sPAPRConfigureConnectorState {
> =20
>  void spapr_ccs_reset_hook(void *opaque);
> =20
> -#define TYPE_SPAPR_RTC "spapr-rtc"
> -#define TYPE_SPAPR_RNG "spapr-rng"
> +void spapr_rtc_read(sPAPRRTCState *rtc, struct tm *tm, uint32_t *ns);
> +int spapr_rtc_import_offset(sPAPRRTCState *rtc, int64_t legacy_offset);
> =20
> -void spapr_rtc_read(DeviceState *dev, struct tm *tm, uint32_t *ns);
> -int spapr_rtc_import_offset(DeviceState *dev, int64_t legacy_offset);
> +#define TYPE_SPAPR_RNG "spapr-rng"
> =20
>  int spapr_rng_populate_dt(void *fdt);
> =20
> diff --git a/include/hw/ppc/xics.h b/include/hw/ppc/xics.h
> index 9a5e715fe553..ce230183a106 100644
> --- a/include/hw/ppc/xics.h
> +++ b/include/hw/ppc/xics.h
> @@ -28,7 +28,7 @@
>  #ifndef XICS_H
>  #define XICS_H
> =20
> -#include "hw/sysbus.h"
> +#include "hw/qdev.h"
> =20
>  #define XICS_IPI        0x2
>  #define XICS_BUID       0x1

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--0rSojgWGcpz+ezC3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYv2KyAAoJEGw4ysog2bOSBbIQAJ30+2omvJikJ6P1Tb8M2ZFR
H/h3TCuoiv3tQuw+idyKU+Haj120HtguAwuKiULG6PgSu8hLBdhpeBfruUHok+8F
dPogWqE9dQsT+Hcg2BrDmd8X5DS5sypCbnk09rElMtaKMJ0HepRuMvTjip0xVDNZ
4HdUtSPqnt+86UdFlXiXWCr4sCJtbSsVE49xB+HnRHSVpNX8c2f++FV4cavh7oce
OHFIBxzkyk7rLBpLp8iUJSXL/6hhLR3PywARAU7aTAaxbJiNYmF7Y9YGT09B8rlc
gGDOPS5SA5Q8glPjBfmD21thM/Rzs1oqFNbj+2YqOd1IaikeNT1XZnfgOm6c+TXw
jLLDhZtrwXEnMFsbNMe1tH5CzOXoo1OIoDh7aXB5KWGATDqXjXjfSTW9Ib3BjKuW
law3CD1TTSJ/PCQerZ0gWl0Qweea/qqes+5Ft44zCsBGJDbbek/zyJ199JX8n4Bb
ylVuW3F2XPqWyaVdEDgibOrc23jCQQ6Rbk98FRSfsVMAvcLdhdyir3DEAFWnGAiQ
04vS+2+EzG4pnjeultndaeLJFLSJw3QQQX7sEeBMaMbcOLvxT5LYjRcqqHuKzbk0
UCllDE4HI11awoNvd7dK8yIumupD0N6QtGpwJXTyE/ehnIGubDZc+96ghL8BW6bE
EghfUcCZWfEXT4BwUWfJ
=JoBA
-----END PGP SIGNATURE-----

--0rSojgWGcpz+ezC3--
