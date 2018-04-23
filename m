Received: from eggs.gnu.org ([2001:4830:134:3::10]:47555)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fAVwo-00018w-At
	for qemu-devel@nongnu.org; Mon, 23 Apr 2018 03:31:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fAVwi-00054h-FM
	for qemu-devel@nongnu.org; Mon, 23 Apr 2018 03:31:38 -0400
Received: from 8.mo177.mail-out.ovh.net ([46.105.61.98]:45256)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1fAVwi-00051s-4N
	for qemu-devel@nongnu.org; Mon, 23 Apr 2018 03:31:32 -0400
Received: from player737.ha.ovh.net (unknown [10.109.105.4])
	by mo177.mail-out.ovh.net (Postfix) with ESMTP id 459A8AED8D
	for <qemu-devel@nongnu.org>; Mon, 23 Apr 2018 09:31:30 +0200 (CEST)
References: <20180419124331.3915-1-clg@kaod.org>
	<20180419124331.3915-3-clg@kaod.org>
	<20180423064408.GF19804@umbus.fritz.box>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <ac69df02-8ee8-0506-36ac-83fdaccdca77@kaod.org>
Date: Mon, 23 Apr 2018 09:31:24 +0200
MIME-Version: 1.0
In-Reply-To: <20180423064408.GF19804@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 02/35] ppc/xive: add support for the LSI
 interrupt sources
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>

On 04/23/2018 08:44 AM, David Gibson wrote:
> On Thu, Apr 19, 2018 at 02:42:58PM +0200, C=E9dric Le Goater wrote:
>> The 'sent' status of the LSI interrupt source is modeled with the 'P'
>> bit of the ESB and the assertion status of the source is maintained in
>> an array under the main sPAPRXive object. The type of the source is
>> stored in the same array for practical reasons.
>>
>> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
>> ---
>>  hw/intc/xive.c        | 54 ++++++++++++++++++++++++++++++++++++++++++=
+++++----
>>  include/hw/ppc/xive.h | 16 +++++++++++++++
>>  2 files changed, 66 insertions(+), 4 deletions(-)
>>
>> diff --git a/hw/intc/xive.c b/hw/intc/xive.c
>> index c70578759d02..060976077dd7 100644
>> --- a/hw/intc/xive.c
>> +++ b/hw/intc/xive.c
>> @@ -104,6 +104,21 @@ static void xive_source_notify(XiveSource *xsrc, =
int srcno)
>> =20
>>  }
>> =20
>> +/*
>> + * LSI interrupt sources use the P bit and a custom assertion flag
>> + */
>> +static bool xive_source_lsi_trigger(XiveSource *xsrc, uint32_t srcno)
>> +{
>> +    uint8_t old_pq =3D xive_source_pq_get(xsrc, srcno);
>> +
>> +    if  (old_pq =3D=3D XIVE_ESB_RESET &&
>> +         xsrc->status[srcno] & XIVE_STATUS_ASSERTED) {
>> +        xive_source_pq_set(xsrc, srcno, XIVE_ESB_PENDING);
>> +        return true;
>> +    }
>> +    return false;
>> +}
>> +
>>  /* In a two pages ESB MMIO setting, even page is the trigger page, od=
d
>>   * page is for management */
>>  static inline bool xive_source_is_trigger_page(hwaddr addr)
>> @@ -133,6 +148,13 @@ static uint64_t xive_source_esb_read(void *opaque=
, hwaddr addr, unsigned size)
>>           */
>>          ret =3D xive_source_pq_eoi(xsrc, srcno);
>> =20
>> +        /* If the LSI source is still asserted, forward a new source
>> +         * event notification */
>> +        if (xive_source_irq_is_lsi(xsrc, srcno)) {
>> +            if (xive_source_lsi_trigger(xsrc, srcno)) {
>> +                xive_source_notify(xsrc, srcno);
>> +            }
>> +        }
>>          break;
>> =20
>>      case XIVE_ESB_GET:
>> @@ -183,6 +205,14 @@ static void xive_source_esb_write(void *opaque, h=
waddr addr,
>>           * notification
>>           */
>>          notify =3D xive_source_pq_eoi(xsrc, srcno);
>> +
>> +        /* LSI sources do not set the Q bit but they can still be
>> +         * asserted, in which case we should forward a new source
>> +         * event notification
>> +         */
>> +        if (xive_source_irq_is_lsi(xsrc, srcno)) {
>> +            notify =3D xive_source_lsi_trigger(xsrc, srcno);
>> +        }

FYI, I have moved that common test under xive_source_pq_eoi()

>>          break;
>> =20
>>      default:
>> @@ -216,8 +246,17 @@ static void xive_source_set_irq(void *opaque, int=
 srcno, int val)
>>      XiveSource *xsrc =3D XIVE_SOURCE(opaque);
>>      bool notify =3D false;
>> =20
>> -    if (val) {
>> -        notify =3D xive_source_pq_trigger(xsrc, srcno);
>> +    if (xive_source_irq_is_lsi(xsrc, srcno)) {
>> +        if (val) {
>> +            xsrc->status[srcno] |=3D XIVE_STATUS_ASSERTED;
>> +        } else {
>> +            xsrc->status[srcno] &=3D ~XIVE_STATUS_ASSERTED;
>> +        }
>> +        notify =3D xive_source_lsi_trigger(xsrc, srcno);
>> +    } else {
>> +        if (val) {
>> +            notify =3D xive_source_pq_trigger(xsrc, srcno);
>> +        }
>>      }
>> =20
>>      /* Forward the source event notification for routing */
>> @@ -234,13 +273,13 @@ void xive_source_pic_print_info(XiveSource *xsrc=
, Monitor *mon)
>>                     xsrc->offset, xsrc->offset + xsrc->nr_irqs - 1);
>>      for (i =3D 0; i < xsrc->nr_irqs; i++) {
>>          uint8_t pq =3D xive_source_pq_get(xsrc, i);
>> -        uint32_t lisn =3D i  + xsrc->offset;
>> =20
>>          if (pq =3D=3D XIVE_ESB_OFF) {
>>              continue;
>>          }
>> =20
>> -        monitor_printf(mon, "  %4x %c%c\n", lisn,
>> +        monitor_printf(mon, "  %4x %s %c%c\n", i + xsrc->offset,
>> +                       xive_source_irq_is_lsi(xsrc, i) ? "LSI" : "MSI=
",
>>                         pq & XIVE_ESB_VAL_P ? 'P' : '-',
>>                         pq & XIVE_ESB_VAL_Q ? 'Q' : '-');
>>      }
>> @@ -249,6 +288,12 @@ void xive_source_pic_print_info(XiveSource *xsrc,=
 Monitor *mon)
>>  static void xive_source_reset(DeviceState *dev)
>>  {
>>      XiveSource *xsrc =3D XIVE_SOURCE(dev);
>> +    int i;
>> +
>> +    /* Keep the IRQ type */
>> +    for (i =3D 0; i < xsrc->nr_irqs; i++) {
>> +        xsrc->status[i] &=3D ~XIVE_STATUS_ASSERTED;
>> +    }
>> =20
>>      /* SBEs are initialized to 0b01 which corresponds to "ints off" *=
/
>>      memset(xsrc->sbe, 0x55, xsrc->sbe_size);
>> @@ -273,6 +318,7 @@ static void xive_source_realize(DeviceState *dev, =
Error **errp)
>> =20
>>      xsrc->qirqs =3D qemu_allocate_irqs(xive_source_set_irq, xsrc,
>>                                       xsrc->nr_irqs);
>> +    xsrc->status =3D g_malloc0(xsrc->nr_irqs);
>> =20
>>      /* Allocate the SBEs (State Bit Entry). 2 bits, so 4 entries per =
byte */
>>      xsrc->sbe_size =3D DIV_ROUND_UP(xsrc->nr_irqs, 4);
>> diff --git a/include/hw/ppc/xive.h b/include/hw/ppc/xive.h
>> index d92a50519edf..0b76dd278d9b 100644
>> --- a/include/hw/ppc/xive.h
>> +++ b/include/hw/ppc/xive.h
>> @@ -33,6 +33,9 @@ typedef struct XiveSource {
>>      uint32_t     nr_irqs;
>>      uint32_t     offset;
>>      qemu_irq     *qirqs;
>> +#define XIVE_STATUS_LSI         0x1
>> +#define XIVE_STATUS_ASSERTED    0x2
>> +    uint8_t      *status;
>=20
> I don't love the idea of mixing configuration information (STATUS_LSI)
> with runtime state information (ASSERTED) in the same field.  Any
> reason not to have these as parallel bitmaps.

none. I can change that.=20
=20
> Come to that.. is there a compelling reason to allow any individual
> irq to be marked LSI or MSI, rather than using separate XiveSource
> objects for MSIs and LSIs?

yes. I would have preferred two distinct interrupt source objects but=20
this is to be compatible with XICS, which uses only one. If we want
to be able to change interrupt mode, the IRQ number space should be
organized in the exact same way. Or we should change XICS also.

Also, the change (a bitmap) is really small.

>>      /* PQ bits */
>>      uint8_t      *sbe;
>=20
> .. and come to that is there a reason to keep the ASSERTED bit in a
> separate array from sbe?  AFAICT the actual 2-bit-per-irq layout is
> never exposed to the guests.

indeed. we always use the xive_source_pq_get/set() helpers to=20
manipulate the PQ bits. So we could add an extra bit for the ASSERT=20
without too much changes. Could also we put the type there or would=20
you still prefer a bitmap ? =20

> Or, even re-use the Q bit for asserted in LSIs (but report it as
> always 0 in the register read/write path).

I would prefer to add extra status bits. It is easier to debug.

Thanks,

C.

>> @@ -127,4 +130,17 @@ uint8_t xive_source_pq_set(XiveSource *xsrc, uint=
32_t srcno, uint8_t pq);
>> =20
>>  void xive_source_pic_print_info(XiveSource *xsrc, Monitor *mon);
>> =20
>> +static inline bool xive_source_irq_is_lsi(XiveSource *xsrc, uint32_t =
srcno)
>> +{
>> +    assert(srcno < xsrc->nr_irqs);
>> +    return xsrc->status[srcno] & XIVE_STATUS_LSI;
>> +}
>> +
>> +static inline void xive_source_irq_set(XiveSource *xsrc, uint32_t src=
no,
>> +                                       bool lsi)
>> +{
>> +    assert(srcno < xsrc->nr_irqs);
>> +    xsrc->status[srcno] |=3D lsi ? XIVE_STATUS_LSI : 0;
>> +}
>> +
>>  #endif /* PPC_XIVE_H */
>=20
