Received: from eggs.gnu.org ([2001:4830:134:3::10]:43350)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1chDoB-0008NA-BQ
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 06:13:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1chDo6-0007IK-LZ
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 06:13:07 -0500
Received: from 17.mo5.mail-out.ovh.net ([46.105.56.132]:57989)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1chDo6-0007FN-Cx
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 06:13:02 -0500
Received: from player734.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo5.mail-out.ovh.net (Postfix) with ESMTP id B027DDC8A3
	for <qemu-devel@nongnu.org>; Fri, 24 Feb 2017 12:13:00 +0100 (CET)
References: <1487252865-12064-1-git-send-email-clg@kaod.org>
	<1487252865-12064-9-git-send-email-clg@kaod.org>
	<20170223022933.GW12577@umbus.fritz.box>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <6deab394-2564-3a43-669c-af4b8a2aa4e3@kaod.org>
Date: Fri, 24 Feb 2017 12:12:54 +0100
MIME-Version: 1.0
In-Reply-To: <20170223022933.GW12577@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH v2 08/22] ppc/xics: use the QOM
 interface to resend irqs
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

On 02/23/2017 03:29 AM, David Gibson wrote:
> On Thu, Feb 16, 2017 at 02:47:31PM +0100, C=E9dric Le Goater wrote:
>> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
>> ---
>>  hw/intc/xics.c | 26 ++++++++++++++------------
>>  1 file changed, 14 insertions(+), 12 deletions(-)
>>
>> diff --git a/hw/intc/xics.c b/hw/intc/xics.c
>> index 0ffdf09c5304..2decb921e4e3 100644
>> --- a/hw/intc/xics.c
>> +++ b/hw/intc/xics.c
>> @@ -229,16 +229,15 @@ static void icp_check_ipi(ICPState *ss)
>>      qemu_irq_raise(ss->output);
>>  }
>> =20
>> -static void icp_resend(ICPState *ss)
>> +static void icp_resend(XICSInterface *xi, ICPState *ss)
>>  {
>> -    ICSState *ics;
>> +    XICSInterfaceClass *xic =3D XICS_INTERFACE_GET_CLASS(xi);
>> =20
>>      if (ss->mfrr < CPPR(ss)) {
>>          icp_check_ipi(ss);
>>      }
>> -    QLIST_FOREACH(ics, &ss->xics->ics, list) {
>> -        ics_resend(ics);
>> -    }
>> +
>> +    xic->ics_resend(xi);
>>  }
>> =20
>>  void icp_set_cppr(ICPState *ss, uint8_t cppr)
>> @@ -262,7 +261,7 @@ void icp_set_cppr(ICPState *ss, uint8_t cppr)
>>          }
>>      } else {
>>          if (!XISR(ss)) {
>> -            icp_resend(ss);
>> +            icp_resend(XICS_INTERFACE(qdev_get_machine()), ss);
>=20
> Here you're assuming that the machine is the implementor of the xics
> interface, which is kinda ugly.  The ICP should have a pointer to the
> xics interface, which will eventually replace the pointer to the
> overall xics object it has now.

yes. I will try improve that. I don't like those calls to=20
qdev_get_machine()either.=20

There are done in a couple of places though, under spapr_cpu_core
to get XICS for instance.

> But I haven't read the rest of the series yet, maybe this is just
> transitional.
>=20
>>          }
>>      }
>>  }
>> @@ -299,6 +298,8 @@ uint32_t icp_ipoll(ICPState *ss, uint32_t *mfrr)
>> =20
>>  void icp_eoi(ICPState *ss, uint32_t xirr)
>>  {
>> +    XICSInterface *xi =3D XICS_INTERFACE(qdev_get_machine());
>> +    XICSInterfaceClass *xic =3D XICS_INTERFACE_GET_CLASS(xi);
>>      ICSState *ics;
>>      uint32_t irq;
>> =20
>> @@ -306,13 +307,13 @@ void icp_eoi(ICPState *ss, uint32_t xirr)
>>      ss->xirr =3D (ss->xirr & ~CPPR_MASK) | (xirr & CPPR_MASK);
>>      trace_xics_icp_eoi(ss->cs->cpu_index, xirr, ss->xirr);
>>      irq =3D xirr & XISR_MASK;
>> -    QLIST_FOREACH(ics, &ss->xics->ics, list) {
>> -        if (ics_valid_irq(ics, irq)) {
>> -            ics_eoi(ics, irq);
>> -        }
>> +
>> +    ics =3D xic->ics_get(xi, irq);
>> +    if (ics) {
>> +        ics_eoi(ics, irq);
>>      }
>>      if (!XISR(ss)) {
>> -        icp_resend(ss);
>> +        icp_resend(xi, ss);
>>      }
>>  }
>> =20
>> @@ -592,10 +593,11 @@ static void ics_simple_reset(DeviceState *dev)
>> =20
>>  static int ics_simple_post_load(ICSState *ics, int version_id)
>>  {
>> +    XICSInterface *xi =3D XICS_INTERFACE(qdev_get_machine());
>>      int i;
>> =20
>>      for (i =3D 0; i < ics->xics->nr_servers; i++) {
>> -        icp_resend(&ics->xics->ss[i]);
>> +        icp_resend(xi, &ics->xics->ss[i]);
>>      }
>=20
> This resend triggering needs to get moved to the xics interface
> implementor - i.e. the machine.  It's actually already broken right
> now, since it incorrectly relies on the ordering of the ics and icp
> restore during migration.

I'm adding a icp_resend() handler in patch 12 and using it patch 14.
Maybe we can move the post_load() handler out of ICS simple now ?=20

Thanks,

C.=20

=20
>>      return 0;
>=20
