Received: from eggs.gnu.org ([2001:4830:134:3::10]:43834)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1chDqe-00020R-EM
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 06:15:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1chDqZ-0001li-Dy
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 06:15:40 -0500
Received: from 2.mo5.mail-out.ovh.net ([178.33.109.111]:40136)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1chDqZ-0001k1-7l
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 06:15:35 -0500
Received: from player734.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo5.mail-out.ovh.net (Postfix) with ESMTP id 6108EDCA1B
	for <qemu-devel@nongnu.org>; Fri, 24 Feb 2017 12:15:33 +0100 (CET)
References: <1487252865-12064-1-git-send-email-clg@kaod.org>
	<1487252865-12064-13-git-send-email-clg@kaod.org>
	<20170223023946.GA12577@umbus.fritz.box>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <94cf0f58-fcda-abad-4c9c-bd23af9a30c4@kaod.org>
Date: Fri, 24 Feb 2017 12:15:21 +0100
MIME-Version: 1.0
In-Reply-To: <20170223023946.GA12577@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH v2 12/22] ppc/xics: extend the
 QOM interface to handle ICPs
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

On 02/23/2017 03:39 AM, David Gibson wrote:
> On Thu, Feb 16, 2017 at 02:47:35PM +0100, C=E9dric Le Goater wrote:
>> Let's add two new handlers for ICPs. One is to get an ICP object from
>> a server number and a second is to resend the irqs when needed.
>>
>> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
>> ---
>>  hw/intc/xics.c        |  2 +-
>>  hw/ppc/spapr.c        | 20 ++++++++++++++++++++
>>  include/hw/ppc/xics.h |  3 +++
>>  3 files changed, 24 insertions(+), 1 deletion(-)
>>
>> diff --git a/hw/intc/xics.c b/hw/intc/xics.c
>> index 5131587ce088..7168c2cfd8a1 100644
>> --- a/hw/intc/xics.c
>> +++ b/hw/intc/xics.c
>> @@ -216,7 +216,7 @@ static void icp_check_ipi(ICPState *ss)
>>      qemu_irq_raise(ss->output);
>>  }
>> =20
>> -static void icp_resend(XICSInterface *xi, ICPState *ss)
>> +void icp_resend(XICSInterface *xi, ICPState *ss)
>>  {
>>      XICSInterfaceClass *xic =3D XICS_INTERFACE_GET_CLASS(xi);
>> =20
>> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
>> index d1946ebcac69..eb7da32296d8 100644
>> --- a/hw/ppc/spapr.c
>> +++ b/hw/ppc/spapr.c
>> @@ -2915,6 +2915,24 @@ static void spapr_ics_resend(XICSInterface *dev=
)
>>      ics_resend(spapr->ics);
>>  }
>> =20
>> +static ICPState *spapr_icp_get(XICSInterface *xi, int server)
>> +{
>> +    sPAPRMachineState *spapr =3D SPAPR_MACHINE(xi);
>> +
>> +    return (server < spapr->xics->nr_servers) ? &spapr->xics->ss[serv=
er] :
>> +        NULL;
>> +}
>> +
>> +static void spapr_icp_resend(XICSInterface *xi)
>> +{
>> +    sPAPRMachineState *spapr =3D SPAPR_MACHINE(xi);
>> +    int i;
>> +
>> +    for (i =3D 0; i < spapr->xics->nr_servers; i++) {
>> +        icp_resend(xi, &spapr->xics->ss[i]);
>> +    }
>> +}
>=20
> I'm not quite sure where you plan to use the resend hook.  AFAICT all
> the existing users of this path can do fine using icp_get() then
> icp_resend() directly.

This is for ics_simple_post_load().

C.

>=20
>> +
>>  static void spapr_machine_class_init(ObjectClass *oc, void *data)
>>  {
>>      MachineClass *mc =3D MACHINE_CLASS(oc);
>> @@ -2959,6 +2977,8 @@ static void spapr_machine_class_init(ObjectClass=
 *oc, void *data)
>>      vhc->hypercall =3D emulate_spapr_hypercall;
>>      xic->ics_get =3D spapr_ics_get;
>>      xic->ics_resend =3D spapr_ics_resend;
>> +    xic->icp_get =3D spapr_icp_get;
>> +    xic->icp_resend =3D spapr_icp_resend;
>>  }
>> =20
>>  static const TypeInfo spapr_machine_info =3D {
>> diff --git a/include/hw/ppc/xics.h b/include/hw/ppc/xics.h
>> index c15d8e2a8ae6..7004c851e250 100644
>> --- a/include/hw/ppc/xics.h
>> +++ b/include/hw/ppc/xics.h
>> @@ -191,6 +191,8 @@ typedef struct XICSInterfaceClass {
>>      InterfaceClass parent;
>>      ICSState *(*ics_get)(XICSInterface *xi, int irq);
>>      void (*ics_resend)(XICSInterface *xi);
>> +    ICPState *(*icp_get)(XICSInterface *xi, int server);
>> +    void (*icp_resend)(XICSInterface *xi);
>>  } XICSInterfaceClass;
>> =20
>>  #define XICS_IRQS_SPAPR               1024
>> @@ -221,5 +223,6 @@ void ics_simple_write_xive(ICSState *ics, int nr, =
int server,
>>  void ics_set_irq_type(ICSState *ics, int srcno, bool lsi);
>> =20
>>  void ics_resend(ICSState *ics);
>> +void icp_resend(XICSInterface *xi, ICPState *ss);
>> =20
>>  #endif /* XICS_H */
>=20
