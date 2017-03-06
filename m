Received: from eggs.gnu.org ([2001:4830:134:3::10]:55756)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ckp4A-0005fP-Ea
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 04:36:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ckp47-0008Of-8v
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 04:36:30 -0500
Date: Mon, 6 Mar 2017 20:01:17 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170306090117.GA11260@umbus.fritz.box>
References: <1488548254-456-1-git-send-email-clg@kaod.org>
	<39ad7cac-b29e-b01e-723c-8cbdb1cf3ca9@redhat.com>
	<f55bb0be-778c-6ded-1564-9b77c4521f52@kaod.org>
	<b4b5780b-4604-9577-f42a-8821c4cb18d4@redhat.com>
	<c8ea232a-3511-f42a-6643-18a66a3d8e9c@kaod.org>
	<20170305232328.GB12030@umbus.fritz.box>
	<4743c70a-c8e4-a8a6-f685-9e7119d575b9@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="PNTmBPCT7hxwcZjr"
Content-Disposition: inline
In-Reply-To: <4743c70a-c8e4-a8a6-f685-9e7119d575b9@kaod.org>
Subject: Re: [Qemu-devel] [PATCH] ppc/spapr: QOM'ify sPAPRRTCState
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


--PNTmBPCT7hxwcZjr
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 06, 2017 at 08:56:07AM +0100, C=E9dric Le Goater wrote:
> On 03/06/2017 12:23 AM, David Gibson wrote:
> > On Fri, Mar 03, 2017 at 06:23:15PM +0100, C=E9dric Le Goater wrote:
> >> On 03/03/2017 05:54 PM, Thomas Huth wrote:
> >>> On 03.03.2017 15:49, C=E9dric Le Goater wrote:
> >>>> On 03/03/2017 03:13 PM, Thomas Huth wrote:
> >>>>> On 03.03.2017 14:37, C=E9dric Le Goater wrote:
> >>>>>> Also use an 'Object *' under the sPAPR machine to hold the RTC
> >>>>>> object.
> >>>>>
> >>>>> The change from TYPE_SYS_BUS_DEVICE to TYPE_DEVICE is certainly a g=
ood
> >>>>> idea! But what's the advantage of using Object* instead of DeviceSt=
ate*
> >>>>> in sPAPRMachineState ?
> >>>>
> >>>> it makes spapr_rtc_create() a little simpler. =20
> >>>>
> >>>> We could go even further and use a sPAPRRTCState under sPAPRMachineS=
tate=20
> >>>> that we  would initialize with object_initialize().=20
> >>>
> >>> I think a sPAPRRTCState* would make more sense here - if you just see=
 an
> >>> Object* and are not familiar with the code, you wonder what this poin=
ter
> >>> is all about (and you then have to cast it to something different if =
you
> >>> want to do anything with it) ... so IMHO either a DeviceState* or
> >>> sPAPRRTCState* is the better choice here.
> >>
> >> I think having a non-pointer is a better for the object lifecycle=20
> >> but I don't have a strong opinion on that. We will see what Dave=20
> >> prefers.
> >=20
> > You seem to be talking at cross purposes.  AFAICT Thomas is not
> > talking about the difference between a pointer and a non-pointer, he's
> > talking about the difference between a generic Object (pointer or
> > otherwise) and a concrete type.
> >=20
> > I agree with Thomas that a specific type is preferable.  I'm not
> > particularly bothered by the difference between pointer and
> > non-pointer.
>=20
> Using a non-pointer sPAPRRTCState introduces more changes. See below.
> This is going a further than just removing the dependency on SysBus.=20
> To remove only the dependency on SysBus, we can keep a 'DeviceState *'=20
> under the machine and fix the code accordingly. =20
>=20
> Just tell me what you prefer. I don't mind. Although I think that=20

Ok.  I think non-pointer is probably better.  I don't mind if we
convert directly to that, or go via some pointery intermediate step -
just do whichever is easier.

> QOM'ifying sPAPR is good thing. After RTC, there is only the NVRAM
> object left to handle but I am not sure we can do much about it as=20
> this is a drive.



> =20
> > In any case, this has missed the cutoff for qemu-2.9, I'm afraid.
>=20
> Well, yes. it's not fixing a bug.
>=20
> Thanks,
>=20
> C.=20
>=20
>=20
> >From b061c1616cd07d04e795cb817768b3d9833d9036 Mon Sep 17 00:00:00 2001
> From: =3D?UTF-8?q?C=3DC3=3DA9dric=3D20Le=3D20Goater?=3D <clg@kaod.org>
> Date: Fri, 3 Mar 2017 14:29:40 +0100
> Subject: [PATCH] ppc/spapr: QOM'ify sPAPRRTCState
> MIME-Version: 1.0
> Content-Type: text/plain; charset=3DUTF-8
> Content-Transfer-Encoding: 8bit
>=20
> Also use an 'sPAPRRTCState' attribute under the sPAPR machine to hold
> the RTC object. Overall, these changes remove an unnecessary and
> implicit dependency on SysBus.
>=20
> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
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

--PNTmBPCT7hxwcZjr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYvSVaAAoJEGw4ysog2bOStDIP/ici7C8dlwwxg4EwFr9wYqif
oibY8sXTkPrrEdvn6TxaU/mSIdqYaSoZA98LQEVfg974ZMJIAKG8ENqKO9u79qoR
pcZdqAdgXLWOO7qme+iXZWowz1begO1Uxt2pnESkjtsYQKh8HbwhVgNJGF96bURm
J4TpqEb6bPDjpJeho+cVzhhqOm3xGXdSq+Vc/nyshl3a+/8Y2ZfYmY/rgYr+2k5f
4jZBEEbKIiYOA51k4WLz/gt/Ie9lPEVcAee8FNSKNw6dOciullWwuospiCaBlfIa
iEftwbmTFgjfgv4xiZSsCaU4xGoAKgS4bdhmShZZwaS8YDitOgYmmVX7b6wwYxVO
cWTKXhpPylIJXDDeqivvZY2WCWLt0hEpZBA0OfWE6mqKz8q7Zu5vKf+jhPwlVYYx
o4bz61BF/em8AfVTvpzZuFPuwpJEKNnHRY0nh0FZbX8LZzCbnLvXEZgnavlXvVGm
z8dYMv5vN4HYS/GHsPuVmCYbDZOfBF81wOslC+yVC8a/tstkEe2xBJoY9TehJgpO
iPfllc1hODqosRNDH3F1QMRRHHLMh9oDuERstsTwX3nAtFItW6RoQZqy75nSZ8Cc
/xhqfx4JS0On4Qh8xMIEuEjL4LlJQuJ6g9k/oLpApC9I4oRxSeJeJ4l65WFli7B+
+Yjhhd5gB9WPIwbyiull
=gVYL
-----END PGP SIGNATURE-----

--PNTmBPCT7hxwcZjr--
