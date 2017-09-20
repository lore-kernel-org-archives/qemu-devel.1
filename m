Received: from eggs.gnu.org ([2001:4830:134:3::10]:41234)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1duemz-0007bR-L3
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 09:12:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1duemP-0006gX-3q
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 09:11:41 -0400
Received: from 7.mo2.mail-out.ovh.net ([188.165.48.182]:35756)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1duemO-0006f3-Rt
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 09:11:05 -0400
Received: from player157.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo2.mail-out.ovh.net (Postfix) with ESMTP id D2907ACA99
	for <qemu-devel@nongnu.org>; Wed, 20 Sep 2017 15:05:24 +0200 (CEST)
References: <20170911171235.29331-1-clg@kaod.org>
	<20170911171235.29331-8-clg@kaod.org> <20170919025747.GM27153@umbus>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <771e897f-f304-3616-2e9c-e582f556b914@kaod.org>
Date: Wed, 20 Sep 2017 15:05:18 +0200
MIME-Version: 1.0
In-Reply-To: <20170919025747.GM27153@umbus>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC PATCH v2 07/21] ppc/xive: add MMIO handlers
 for the XIVE interrupt sources
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


>> +/*
>> + * XIVE Interrupt Source MMIOs
>> + */
>> +static uint64_t spapr_xive_esb_read(void *opaque, hwaddr addr, unsigned size)
>> +{
>> +    sPAPRXive *xive = SPAPR_XIVE(opaque);
>> +    uint32_t offset = addr & 0xF00;
>> +    uint32_t srcno = addr >> xive->esb_shift;
>> +    XiveIVE *ive;
>> +    uint64_t ret = -1;
>> +
>> +    ive = spapr_xive_get_ive(xive, srcno);
>> +    if (!ive || !(ive->w & IVE_VALID))  {
>> +        qemu_log_mask(LOG_GUEST_ERROR, "XIVE: invalid LISN %d\n", srcno);
>> +        goto out;
> 
> Since there's a whole (4k) page for each source, I wonder if we should
> actually map each one as a separate MMIO region to allow us to tweak
> the mappings more flexibly
yes we could have a subregion for each source. In that case, 
we should also handle IVE_VALID properly. That will require 
a specific XIVE allocator which was difficult to do while
keeping the compatibility with XICS for migration and CAS.


C.
