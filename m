Received: from eggs.gnu.org ([208.118.235.92]:50404)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1gf73o-00064G-2z
	for qemu-devel@nongnu.org; Thu, 03 Jan 2019 12:45:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1gf73k-0001fb-OR
	for qemu-devel@nongnu.org; Thu, 03 Jan 2019 12:45:36 -0500
Received: from 7.mo179.mail-out.ovh.net ([46.105.61.94]:57979)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1gf73k-0001dw-Gm
	for qemu-devel@nongnu.org; Thu, 03 Jan 2019 12:45:32 -0500
Received: from player696.ha.ovh.net (unknown [10.109.160.217])
	by mo179.mail-out.ovh.net (Postfix) with ESMTP id EB31810F35B
	for <qemu-devel@nongnu.org>; Thu,  3 Jan 2019 18:45:30 +0100 (CET)
References: <20190102055743.5052-1-clg@kaod.org>
	<20190102055743.5052-9-clg@kaod.org>
	<20190103043340.GT10853@umbus.fritz.box>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <f21712f9-0b67-cbe2-fa5c-7207dd9321be@kaod.org>
Date: Thu, 3 Jan 2019 18:45:25 +0100
MIME-Version: 1.0
In-Reply-To: <20190103043340.GT10853@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 08/10] ppc/xics: allow ICSState to have an
 offset 0
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

On 1/3/19 5:33 AM, David Gibson wrote:
> On Wed, Jan 02, 2019 at 06:57:41AM +0100, C=E9dric Le Goater wrote:
>> commit 15ed653fa49a ("ppc/xics: An ICS with offset 0 is assumed to be
>> uninitialized") introduced an extra check on the ICS offset which is
>> not strictly necessary.
>=20
> The commit message for that suggests it was added to make pnv easier.
> I take it you no longer need this for the current or expected pnv
> code?

This is really just a runtime check which makes sure that the=20
ICSState offset is initialized by the FW before being used.

The problem is more global. It comes from the fact the ICSState=20
offset in QEMU and the XICS offset in KVM is hardcoded to 0x1000.=20

  Thinking aloud :

    May be we should default the offset to 0 and introduce a service=20
    to set the value in QEMU and KVM.  =20

The 'dual' interrupt mode (using the qirq array at the machine level)=20
needs the IRQ number space of the XIVE and XICS interrupt mode to
be in sync, that is to start a 0x0, even if the lower 4K are ignored
in XICS.  =20

So the 'dual' mode tunes the offset to 0 once the ICSState is created
and ignores the lower 4K when initializing the KVM XICS device.=20

C.

>> Revert the change to be able to map the XICS IRQ number space on the
>> XIVE IRQ number space.
>=20
>=20
>=20
>>
>> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
>> ---
>>  include/hw/ppc/xics.h | 3 +--
>>  1 file changed, 1 insertion(+), 2 deletions(-)
>>
>> diff --git a/include/hw/ppc/xics.h b/include/hw/ppc/xics.h
>> index 7668c381a887..07508cbd217e 100644
>> --- a/include/hw/ppc/xics.h
>> +++ b/include/hw/ppc/xics.h
>> @@ -139,8 +139,7 @@ struct ICSState {
>> =20
>>  static inline bool ics_valid_irq(ICSState *ics, uint32_t nr)
>>  {
>> -    return (ics->offset !=3D 0) && (nr >=3D ics->offset)
>> -        && (nr < (ics->offset + ics->nr_irqs));
>> +    return (nr >=3D ics->offset) && (nr < (ics->offset + ics->nr_irqs=
));
>>  }
>> =20
>>  struct ICSIRQState {
>=20
