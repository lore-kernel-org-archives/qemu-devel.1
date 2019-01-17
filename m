Received: from eggs.gnu.org ([209.51.188.92]:54122)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1gk2nF-0006Bs-TR
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 03:12:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1gk2nD-0002vg-HZ
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 03:12:53 -0500
Received: from 5.mo178.mail-out.ovh.net ([46.105.51.53]:45825)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1gk2nD-0002m5-9n
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 03:12:51 -0500
Received: from player787.ha.ovh.net (unknown [10.109.143.225])
	by mo178.mail-out.ovh.net (Postfix) with ESMTP id 8096847294
	for <qemu-devel@nongnu.org>; Thu, 17 Jan 2019 09:12:47 +0100 (CET)
Date: Thu, 17 Jan 2019 09:12:36 +0100
From: Greg Kurz <groug@kaod.org>
Message-ID: <20190117091236.4d155637@bahia.lan>
In-Reply-To: <20190117075327.22194-2-clg@kaod.org>
References: <20190117075327.22194-1-clg@kaod.org>
	<20190117075327.22194-2-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 1/4] xive: add a get_tctx() method to the
 XiveRouter
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?Q8OpZHJpYw==?= Le Goater <clg@kaod.org>
Cc: David Gibson <david@gibson.dropbear.id.au>, Thomas Huth <thuth@redhat.com>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org

On Thu, 17 Jan 2019 08:53:24 +0100
C=C3=A9dric Le Goater <clg@kaod.org> wrote:

> It provides a mean to retrieve the XiveTCTX of a CPU. This will become
> necessary with future changes which move the interrupt presenter
> object pointers under the PowerPCCPU machine_data.
>=20
> The PowerNV machine has an extra requirement on TIMA accesses that
> this new method addresses. The machine can perform indirect loads and
> stores on the TIMA on behalf of another CPU. The PIR being defined in
> the controller registers, we need a way to peek in the controller
> model to find the PIR value.
>=20
> The XiveTCTX is moved above the XiveRouter definition to avoid forward
> typedef declarations.
>=20
> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
> ---

Reviewed-by: Greg Kurz <groug@kaod.org>

>  include/hw/ppc/xive.h | 57 ++++++++++++++++++++++---------------------
>  hw/intc/spapr_xive.c  |  8 ++++++
>  hw/intc/xive.c        | 16 +++++++-----
>  3 files changed, 47 insertions(+), 34 deletions(-)
>=20
> diff --git a/include/hw/ppc/xive.h b/include/hw/ppc/xive.h
> index 5d31c801ee53..ec3bb2aae45a 100644
> --- a/include/hw/ppc/xive.h
> +++ b/include/hw/ppc/xive.h
> @@ -294,6 +294,33 @@ static inline void xive_source_irq_set(XiveSource *x=
src, uint32_t srcno,
> =20
>  void xive_source_set_irq(void *opaque, int srcno, int val);
> =20
> +/*
> + * XIVE Thread interrupt Management (TM) context
> + */
> +
> +#define TYPE_XIVE_TCTX "xive-tctx"
> +#define XIVE_TCTX(obj) OBJECT_CHECK(XiveTCTX, (obj), TYPE_XIVE_TCTX)
> +
> +/*
> + * XIVE Thread interrupt Management register rings :
> + *
> + *   QW-0  User       event-based exception state
> + *   QW-1  O/S        OS context for priority management, interrupt acks
> + *   QW-2  Pool       hypervisor pool context for virtual processors dis=
patched
> + *   QW-3  Physical   physical thread context and security context
> + */
> +#define XIVE_TM_RING_COUNT      4
> +#define XIVE_TM_RING_SIZE       0x10
> +
> +typedef struct XiveTCTX {
> +    DeviceState parent_obj;
> +
> +    CPUState    *cs;
> +    qemu_irq    output;
> +
> +    uint8_t     regs[XIVE_TM_RING_COUNT * XIVE_TM_RING_SIZE];
> +} XiveTCTX;
> +
>  /*
>   * XIVE Router
>   */
> @@ -324,6 +351,7 @@ typedef struct XiveRouterClass {
>                     XiveNVT *nvt);
>      int (*write_nvt)(XiveRouter *xrtr, uint8_t nvt_blk, uint32_t nvt_idx,
>                       XiveNVT *nvt, uint8_t word_number);
> +    XiveTCTX *(*get_tctx)(XiveRouter *xrtr, CPUState *cs);
>  } XiveRouterClass;
> =20
>  void xive_eas_pic_print_info(XiveEAS *eas, uint32_t lisn, Monitor *mon);
> @@ -338,7 +366,7 @@ int xive_router_get_nvt(XiveRouter *xrtr, uint8_t nvt=
_blk, uint32_t nvt_idx,
>                          XiveNVT *nvt);
>  int xive_router_write_nvt(XiveRouter *xrtr, uint8_t nvt_blk, uint32_t nv=
t_idx,
>                            XiveNVT *nvt, uint8_t word_number);
> -
> +XiveTCTX *xive_router_get_tctx(XiveRouter *xrtr, CPUState *cs);
> =20
>  /*
>   * XIVE END ESBs
> @@ -371,33 +399,6 @@ typedef struct XiveENDSource {
>  void xive_end_pic_print_info(XiveEND *end, uint32_t end_idx, Monitor *mo=
n);
>  void xive_end_queue_pic_print_info(XiveEND *end, uint32_t width, Monitor=
 *mon);
> =20
> -/*
> - * XIVE Thread interrupt Management (TM) context
> - */
> -
> -#define TYPE_XIVE_TCTX "xive-tctx"
> -#define XIVE_TCTX(obj) OBJECT_CHECK(XiveTCTX, (obj), TYPE_XIVE_TCTX)
> -
> -/*
> - * XIVE Thread interrupt Management register rings :
> - *
> - *   QW-0  User       event-based exception state
> - *   QW-1  O/S        OS context for priority management, interrupt acks
> - *   QW-2  Pool       hypervisor pool context for virtual processors dis=
patched
> - *   QW-3  Physical   physical thread context and security context
> - */
> -#define XIVE_TM_RING_COUNT      4
> -#define XIVE_TM_RING_SIZE       0x10
> -
> -typedef struct XiveTCTX {
> -    DeviceState parent_obj;
> -
> -    CPUState    *cs;
> -    qemu_irq    output;
> -
> -    uint8_t     regs[XIVE_TM_RING_COUNT * XIVE_TM_RING_SIZE];
> -} XiveTCTX;
> -
>  /*
>   * XIVE Thread Interrupt Management Aera (TIMA)
>   *
> diff --git a/hw/intc/spapr_xive.c b/hw/intc/spapr_xive.c
> index d391177ab81f..136d872f16bc 100644
> --- a/hw/intc/spapr_xive.c
> +++ b/hw/intc/spapr_xive.c
> @@ -390,6 +390,13 @@ static int spapr_xive_write_nvt(XiveRouter *xrtr, ui=
nt8_t nvt_blk,
>      g_assert_not_reached();
>  }
> =20
> +static XiveTCTX *spapr_xive_get_tctx(XiveRouter *xrtr, CPUState *cs)
> +{
> +    PowerPCCPU *cpu =3D POWERPC_CPU(cs);
> +
> +    return cpu->tctx;
> +}
> +
>  static const VMStateDescription vmstate_spapr_xive_end =3D {
>      .name =3D TYPE_SPAPR_XIVE "/end",
>      .version_id =3D 1,
> @@ -454,6 +461,7 @@ static void spapr_xive_class_init(ObjectClass *klass,=
 void *data)
>      xrc->write_end =3D spapr_xive_write_end;
>      xrc->get_nvt =3D spapr_xive_get_nvt;
>      xrc->write_nvt =3D spapr_xive_write_nvt;
> +    xrc->get_tctx =3D spapr_xive_get_tctx;
>  }
> =20
>  static const TypeInfo spapr_xive_info =3D {
> diff --git a/hw/intc/xive.c b/hw/intc/xive.c
> index 7f567a57d25a..2e9b8efd4342 100644
> --- a/hw/intc/xive.c
> +++ b/hw/intc/xive.c
> @@ -320,8 +320,7 @@ static const XiveTmOp *xive_tm_find_op(hwaddr offset,=
 unsigned size, bool write)
>  static void xive_tm_write(void *opaque, hwaddr offset,
>                            uint64_t value, unsigned size)
>  {
> -    PowerPCCPU *cpu =3D POWERPC_CPU(current_cpu);
> -    XiveTCTX *tctx =3D cpu->tctx;
> +    XiveTCTX *tctx =3D xive_router_get_tctx(XIVE_ROUTER(opaque), current=
_cpu);
>      const XiveTmOp *xto;
> =20
>      /*
> @@ -359,8 +358,7 @@ static void xive_tm_write(void *opaque, hwaddr offset,
> =20
>  static uint64_t xive_tm_read(void *opaque, hwaddr offset, unsigned size)
>  {
> -    PowerPCCPU *cpu =3D POWERPC_CPU(current_cpu);
> -    XiveTCTX *tctx =3D cpu->tctx;
> +    XiveTCTX *tctx =3D xive_router_get_tctx(XIVE_ROUTER(opaque), current=
_cpu);
>      const XiveTmOp *xto;
> =20
>      /*
> @@ -1107,6 +1105,13 @@ int xive_router_write_nvt(XiveRouter *xrtr, uint8_=
t nvt_blk, uint32_t nvt_idx,
>     return xrc->write_nvt(xrtr, nvt_blk, nvt_idx, nvt, word_number);
>  }
> =20
> +XiveTCTX *xive_router_get_tctx(XiveRouter *xrtr, CPUState *cs)
> +{
> +    XiveRouterClass *xrc =3D XIVE_ROUTER_GET_CLASS(xrtr);
> +
> +    return xrc->get_tctx(xrtr, cs);
> +}
> +
>  /*
>   * The thread context register words are in big-endian format.
>   */
> @@ -1182,8 +1187,7 @@ static bool xive_presenter_match(XiveRouter *xrtr, =
uint8_t format,
>       */
> =20
>      CPU_FOREACH(cs) {
> -        PowerPCCPU *cpu =3D POWERPC_CPU(cs);
> -        XiveTCTX *tctx =3D cpu->tctx;
> +        XiveTCTX *tctx =3D xive_router_get_tctx(xrtr, cs);
>          int ring;
> =20
>          /*
