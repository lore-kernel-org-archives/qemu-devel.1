Received: from eggs.gnu.org ([2001:4830:134:3::10]:40202)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1chDXL-0001B4-Fc
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 05:55:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1chDXI-0004Yu-Eb
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 05:55:43 -0500
Received: from 15.mo5.mail-out.ovh.net ([178.33.107.29]:43581)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1chDXI-0004Xh-7v
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 05:55:40 -0500
Received: from player734.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo5.mail-out.ovh.net (Postfix) with ESMTP id C37EDDCB4D
	for <qemu-devel@nongnu.org>; Fri, 24 Feb 2017 11:55:38 +0100 (CET)
References: <1487252865-12064-1-git-send-email-clg@kaod.org>
	<1487252865-12064-6-git-send-email-clg@kaod.org>
	<20170223021816.GT12577@umbus.fritz.box>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <9a6cf1a0-2f6d-26f1-de80-390f87fce061@kaod.org>
Date: Fri, 24 Feb 2017 11:55:34 +0100
MIME-Version: 1.0
In-Reply-To: <20170223021816.GT12577@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 05/22] ppc/xics: introduce a QOM
 interface to handle ICSs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org

On 02/23/2017 03:18 AM, David Gibson wrote:
> On Thu, Feb 16, 2017 at 02:47:28PM +0100, C=E9dric Le Goater wrote:
>> This QOM interface provides two simple handlers. One is to get an ICS
>> object from an irq number and a second to resend the irqs when needed.
>=20
> Maybe call this XICSFabric rather than XicsInterface.  While it's an
> interface from the QOM point-of-view, that doesn't really describe
> where it sits in the hardware model, and it's the ics and icp objects
> which provide all the interfaces which are visible to the guest or to
> interrupt generating devices.

Curiously, this is the only email that was not trashed by my bogus=20
filters and so this is the only change I did in v3 ...=20
=20
C.=20


> Apart from that,
>=20
> Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
>=20
>> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
>> ---
>>  hw/intc/xics.c        |  7 +++++++
>>  include/hw/ppc/xics.h | 18 ++++++++++++++++++
>>  2 files changed, 25 insertions(+)
>>
>> diff --git a/hw/intc/xics.c b/hw/intc/xics.c
>> index b1294417a0ae..3e80d2d0f0d9 100644
>> --- a/hw/intc/xics.c
>> +++ b/hw/intc/xics.c
>> @@ -726,6 +726,12 @@ static const TypeInfo ics_base_info =3D {
>>      .class_size =3D sizeof(ICSStateClass),
>>  };
>> =20
>> +static const TypeInfo xics_interface_info =3D {
>> +    .name =3D TYPE_XICS_INTERFACE,
>> +    .parent =3D TYPE_INTERFACE,
>> +    .class_size =3D sizeof(XICSInterfaceClass),
>> +};
>> +
>>  /*
>>   * Exported functions
>>   */
>> @@ -766,6 +772,7 @@ static void xics_register_types(void)
>>      type_register_static(&ics_simple_info);
>>      type_register_static(&ics_base_info);
>>      type_register_static(&icp_info);
>> +    type_register_static(&xics_interface_info);
>>  }
>> =20
>>  type_init(xics_register_types)
>> diff --git a/include/hw/ppc/xics.h b/include/hw/ppc/xics.h
>> index 6d443ce09dba..fe2bb5c8ef54 100644
>> --- a/include/hw/ppc/xics.h
>> +++ b/include/hw/ppc/xics.h
>> @@ -177,6 +177,24 @@ struct ICSIRQState {
>>      uint8_t flags;
>>  };
>> =20
>> +typedef struct XICSInterface {
>> +    Object parent;
>> +} XICSInterface;
>> +
>> +#define TYPE_XICS_INTERFACE "xics-interface"
>> +#define XICS_INTERFACE(obj)                                     \
>> +    OBJECT_CHECK(XICSInterface, (obj), TYPE_XICS_INTERFACE)
>> +#define XICS_INTERFACE_CLASS(klass)                                  =
   \
>> +    OBJECT_CLASS_CHECK(XICSInterfaceClass, (klass), TYPE_XICS_INTERFA=
CE)
>> +#define XICS_INTERFACE_GET_CLASS(obj)                                =
   \
>> +    OBJECT_GET_CLASS(XICSInterfaceClass, (obj), TYPE_XICS_INTERFACE)
>> +
>> +typedef struct XICSInterfaceClass {
>> +    InterfaceClass parent;
>> +    ICSState *(*ics_get)(XICSInterface *xi, int irq);
>> +    void (*ics_resend)(XICSInterface *xi);
>> +} XICSInterfaceClass;
>> +
>>  #define XICS_IRQS_SPAPR               1024
>> =20
>>  qemu_irq xics_get_qirq(XICSState *icp, int irq);
>=20
