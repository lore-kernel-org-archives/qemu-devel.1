Received: from eggs.gnu.org ([2001:4830:134:3::10]:33994)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fhiW7-00068Z-9F
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 17:37:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fhiW4-0006XG-7Q
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 17:37:19 -0400
Received: from 4.mo4.mail-out.ovh.net ([178.32.98.131]:37318)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1fhiW3-0006Wh-Va
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 17:37:16 -0400
Received: from player690.ha.ovh.net (unknown [10.109.143.145])
	by mo4.mail-out.ovh.net (Postfix) with ESMTP id 504B118BD79
	for <qemu-devel@nongnu.org>; Mon, 23 Jul 2018 23:37:14 +0200 (CEST)
References: <20180628083633.12413-1-clg@kaod.org>
	<20180628083633.12413-2-clg@kaod.org>
	<20180718061230.GE2102@umbus.fritz.box>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <16c7eb37-ddd4-17aa-c5cb-ffe05cc13c15@kaod.org>
Date: Mon, 23 Jul 2018 23:37:06 +0200
MIME-Version: 1.0
In-Reply-To: <20180718061230.GE2102@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 1/2] ppc/pnv: Add model for Power8 PHB3
 PCIe Host bridge
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Andrea Bolognani <abologna@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>

On 07/18/2018 08:12 AM, David Gibson wrote:
>> +static void pnv_phb3_get_phb_id(Object *obj, Visitor *v, const char *name,
>> +                              void *opaque, Error **errp)
>> +{
>> +    Property *prop = opaque;
>> +    uint32_t *ptr = qdev_get_prop_ptr(DEVICE(obj), prop);
>> +
>> +    visit_type_uint32(v, name, ptr, errp);
>> +}
>> +
>> +static void pnv_phb3_set_phb_id(Object *obj, Visitor *v, const char *name,
>> +                              void *opaque, Error **errp)
>> +{
>> +    PnvPHB3 *phb = PNV_PHB3(obj);
>> +    uint32_t phb_id;
>> +    Error *local_err = NULL;
>> +
>> +    visit_type_uint32(v, name, &phb_id, &local_err);
>> +    if (local_err) {
>> +        error_propagate(errp, local_err);
>> +        return;
>> +    }
>> +
>> +    /*
>> +     * Limit to a maximum of 6 PHBs per chip
>> +     */
>> +    if (phb_id >= PNV8_CHIP_PHB3_MAX) {
>> +        error_setg(errp, "invalid PHB index: '%d'", phb_id);
>> +        return;
>> +    }
>> +
>> +    phb->phb_id = phb_id;
>> +}
>> +
>> +static const PropertyInfo pnv_phb3_phb_id_propinfo = {
>> +    .name = "irq",
>> +    .get = pnv_phb3_get_phb_id,
>> +    .set = pnv_phb3_set_phb_id,
>> +};
> Can't you use a static DeviceProps style property for this, which is a
> bit simpler?

yes but we will need these ops for user creatable devices. This is where
we will check the chip id.

C. 
