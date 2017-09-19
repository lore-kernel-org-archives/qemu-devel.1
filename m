Received: from eggs.gnu.org ([2001:4830:134:3::10]:36569)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1duINc-000169-9G
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 09:16:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1duINY-0004pI-1d
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 09:16:00 -0400
Received: from 8.mo3.mail-out.ovh.net ([87.98.172.249]:60015)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1duINX-0004oA-S0
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 09:15:55 -0400
Received: from player797.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo3.mail-out.ovh.net (Postfix) with ESMTP id 6A1D0159601
	for <qemu-devel@nongnu.org>; Tue, 19 Sep 2017 15:15:54 +0200 (CEST)
References: <20170911171235.29331-1-clg@kaod.org>
	<20170911171235.29331-2-clg@kaod.org> <20170919022719.GH27153@umbus>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <d3ee87a7-208e-a172-094b-6aeedf8c5840@kaod.org>
Date: Tue, 19 Sep 2017 15:15:44 +0200
MIME-Version: 1.0
In-Reply-To: <20170919022719.GH27153@umbus>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH v2 01/21] ppc/xive: introduce a
 skeleton for the sPAPR XIVE interrupt controller
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Alexey Kardashevskiy <aik@ozlabs.ru>, Alexander Graf <agraf@suse.de>

On 09/19/2017 04:27 AM, David Gibson wrote:
> On Mon, Sep 11, 2017 at 07:12:15PM +0200, C=E9dric Le Goater wrote:
>> Start with a couple of attributes for the XIVE sPAPR controller
>> model. The number of provisionned IRQ is necessary to size the
>> different internal XIVE tables, the number of CPUs is also.
>>
>> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
>=20
> [snip]
>=20
>> +static void spapr_xive_realize(DeviceState *dev, Error **errp)
>> +{
>> +    sPAPRXive *xive =3D SPAPR_XIVE(dev);
>> +
>> +    if (!xive->nr_targets) {
>> +        error_setg(errp, "Number of interrupt targets needs to be gre=
ater 0");
>> +        return;
>> +    }
>> +    /* We need to be able to allocate at least the IPIs */
>> +    if (!xive->nr_irqs || xive->nr_irqs < xive->nr_targets) {
>> +        error_setg(errp, "Number of interrupts too small");
>> +        return;
>> +    }
>> +}
>> +
>> +static Property spapr_xive_properties[] =3D {
>> +    DEFINE_PROP_UINT32("nr-irqs", sPAPRXive, nr_irqs, 0),
>> +    DEFINE_PROP_UINT32("nr-targets", sPAPRXive, nr_targets, 0),
>=20
> I'm a bit uneasy about the number of targets having to be set in
> advance: this can make life awkward when CPUs are hotplugged.  I know
> there's something similar in xics, but it has caused some hassles, and
> we're starting to move away from it.
>=20
> Do you really need this?
>=20

Some of the internal table size depend on the number of cpus=20
defined for the machine. When the sPAPRXive object is instantiated,=20
we use xics_max_server_number() to get the max number of cpus
provisioned.

C.
