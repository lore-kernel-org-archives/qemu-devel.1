Received: from eggs.gnu.org ([2001:4830:134:3::10]:37780)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1eFNLg-00051H-Lr
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 11:49:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1eFNLc-0008W0-PJ
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 11:49:08 -0500
Received: from 10.mo68.mail-out.ovh.net ([46.105.79.203]:33268)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1eFNLc-0008VD-IF
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 11:49:04 -0500
Received: from player750.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo68.mail-out.ovh.net (Postfix) with ESMTP id 0BD229DA71
	for <qemu-devel@nongnu.org>; Thu, 16 Nov 2017 17:49:02 +0100 (CET)
References: <20170911171235.29331-1-clg@kaod.org>
	<20170911171235.29331-2-clg@kaod.org> <20170919022719.GH27153@umbus>
	<d3ee87a7-208e-a172-094b-6aeedf8c5840@kaod.org>
	<20170922110040.GP4998@umbus.fritz.box>
	<fc6b85f6-fa5b-7ed2-2635-72aceda74305@kaod.org>
	<20170926035423.GH12504@umbus>
	<1506419102.2541.11.camel@kernel.crashing.org>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <b2590798-a1fe-2202-5808-8f619aa3a5ad@kaod.org>
Date: Thu, 16 Nov 2017 17:48:56 +0100
MIME-Version: 1.0
In-Reply-To: <1506419102.2541.11.camel@kernel.crashing.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Alexey Kardashevskiy <aik@ozlabs.ru>, Alexander Graf <agraf@suse.de>

On 09/26/2017 11:45 AM, Benjamin Herrenschmidt wrote:
> On Tue, 2017-09-26 at 13:54 +1000, David Gibson wrote:
>>>>
>>>> Which ones?  My impression was that there needed to be at least #cpus
>>>> * #priority-levels EQs, but there could be more than that, 
>>>
>>> euh no, not in spapr mode at least. There are 8 queues per cpu.
>>
>> Ok.
> 
> There's a HW feature of XIVE in DD2.x that I will start exploiting soon
> that sacrifices a queue btw, keep that in mind.
> 
> We should probably only expose 0...6 to guests, not 0...7.

yes. This is achieved using the "ibm,plat-res-int-priorities" property 
of the device tree. 

I don't think we also need to check these priority ranges when allocating
the EQs. We can just allocate them all (8 priorities) and let the hcalls 
do the checks. They should return H_P3 or H_P4 if the prio is invalid.

C.
