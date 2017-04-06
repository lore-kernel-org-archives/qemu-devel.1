Received: from eggs.gnu.org ([2001:4830:134:3::10]:47662)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1cw20U-0005pV-8M
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 03:39:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1cw20R-0007KF-3v
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 03:39:02 -0400
Received: from 8.mo2.mail-out.ovh.net ([188.165.52.147]:36669)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1cw20Q-0007Jn-So
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 03:38:59 -0400
Received: from player731.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo2.mail-out.ovh.net (Postfix) with ESMTP id 537687C0CF
	for <qemu-devel@nongnu.org>; Thu,  6 Apr 2017 09:38:56 +0200 (CEST)
References: <1491396106-26376-1-git-send-email-clg@kaod.org>
	<1491396106-26376-9-git-send-email-clg@kaod.org>
	<20170406053639.GD12179@umbus>
	<a1a7e91c-cc90-2b99-0db0-d3d172e0daeb@kaod.org>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <a9d3ec8e-33f2-d439-8d2e-d4f51e0cabc4@kaod.org>
Date: Thu, 6 Apr 2017 09:38:45 +0200
MIME-Version: 1.0
In-Reply-To: <a1a7e91c-cc90-2b99-0db0-d3d172e0daeb@kaod.org>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 08/21] ipmi: introduce an
 ipmi_bmc_sdr_find() API
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Marcel Apfelbaum <marcel@redhat.com>, Corey Minyard <cminyard@mvista.com>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>

On 04/06/2017 09:36 AM, C=E9dric Le Goater wrote:
> On 04/06/2017 07:36 AM, David Gibson wrote:
>> On Wed, Apr 05, 2017 at 02:41:33PM +0200, C=E9dric Le Goater wrote:
>>> This patch exposes a new IPMI routine to query a sdr entry from the
>>> sdr table maintained by the IPMI BMC simulator. The API is very
>>> similar to the internal sdr_find_entry() routine and should be used
>>> the same way to query one or all sdrs.
>>>
>>> A typical use would be to loop on the sdrs to build nodes of a device
>>> tree.
>>>
>>> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
>>> Acked-by: Corey Minyard <cminyard@mvista.com>
>>
>> I don't know much about IPMI, but since it has Corey's ack, I've
>> staged 5..8/21 in my for-2.10 tree.=20
>=20
> thanks for doing so. The patchset needs the interface introduced in   =20
> patch 9 and 10 to build the sensor nodes in the device tree and to=20

oups, I meant patch 8 and 9 :

[PATCH 08/21] ipmi: introduce an ipmi_bmc_sdr_find() API
[PATCH 09/21] ipmi: introduce an ipmi_bmc_gen_event() API

sorry for the noise.

C.=20

> generate shutdown events which is important for the machine.
>=20
>> 9 I've left for now, since Corey has comments.
>=20
> It's patch 10 in fact which is about the SET_SENSOR_READING command.=20
>=20
> I think this is the most complex command in the IPMI specs ... It's=20
> not a strong requirement for the firmware but as I have started it=20
> I am trying to reach a minimal and correct implementation ... It really
> is giving me headaches tough. I am glad that Corey is giving some=20
> support.
>=20
> C.=20
> =20
>>> ---
>>>  hw/ipmi/ipmi_bmc_sim.c | 16 ++++++++++++++++
>>>  include/hw/ipmi/ipmi.h |  2 ++
>>>  2 files changed, 18 insertions(+)
>>>
>>> diff --git a/hw/ipmi/ipmi_bmc_sim.c b/hw/ipmi/ipmi_bmc_sim.c
>>> index eae7b2d8c92b..8185a84b76b9 100644
>>> --- a/hw/ipmi/ipmi_bmc_sim.c
>>> +++ b/hw/ipmi/ipmi_bmc_sim.c
>>> @@ -416,6 +416,22 @@ static int sdr_find_entry(IPMISdr *sdr, uint16_t=
 recid,
>>>      return 1;
>>>  }
>>> =20
>>> +int ipmi_bmc_sdr_find(IPMIBmc *b, uint16_t recid,
>>> +                      const struct ipmi_sdr_compact **sdr, uint16_t =
*nextrec)
>>> +
>>> +{
>>> +    IPMIBmcSim *ibs =3D IPMI_BMC_SIMULATOR(b);
>>> +    unsigned int pos;
>>> +
>>> +    pos =3D 0;
>>> +    if (sdr_find_entry(&ibs->sdr, recid, &pos, nextrec)) {
>>> +        return -1;
>>> +    }
>>> +
>>> +    *sdr =3D (const struct ipmi_sdr_compact *) &ibs->sdr.sdr[pos];
>>> +    return 0;
>>> +}
>>> +
>>>  static void sel_inc_reservation(IPMISel *sel)
>>>  {
>>>      sel->reservation++;
>>> diff --git a/include/hw/ipmi/ipmi.h b/include/hw/ipmi/ipmi.h
>>> index 91b83b5bb0b6..0d36cfc6b7f3 100644
>>> --- a/include/hw/ipmi/ipmi.h
>>> +++ b/include/hw/ipmi/ipmi.h
>>> @@ -259,4 +259,6 @@ struct ipmi_sdr_compact {
>>> =20
>>>  typedef uint8_t ipmi_sdr_compact_buffer[sizeof(struct ipmi_sdr_compa=
ct)];
>>> =20
>>> +int ipmi_bmc_sdr_find(IPMIBmc *b, uint16_t recid,
>>> +                      const struct ipmi_sdr_compact **sdr, uint16_t =
*nextrec);
>>>  #endif
>>
>=20
>=20
