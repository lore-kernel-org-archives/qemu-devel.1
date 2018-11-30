Received: from eggs.gnu.org ([2001:4830:134:3::10]:47619)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1gScsS-0001dz-60
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 02:06:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1gScr7-0007kq-Th
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 02:04:59 -0500
Received: from 8.mo2.mail-out.ovh.net ([188.165.52.147]:32984)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1gScr7-0007h8-KN
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 02:04:53 -0500
Received: from player798.ha.ovh.net (unknown [10.109.160.12])
	by mo2.mail-out.ovh.net (Postfix) with ESMTP id 704DD175E05
	for <qemu-devel@nongnu.org>; Fri, 30 Nov 2018 08:04:47 +0100 (CET)
References: <20181116105729.23240-1-clg@kaod.org>
	<20181116105729.23240-24-clg@kaod.org>
	<20181129034358.GB14697@umbus.fritz.box>
	<1d5ddbac-af54-a00d-bd65-684bb6a7a0b0@kaod.org>
	<20181130012435.GI30479@umbus.fritz.box>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <f88ae8a9-cf8f-0297-d3db-12a771bafa44@kaod.org>
Date: Fri, 30 Nov 2018 08:04:39 +0100
MIME-Version: 1.0
In-Reply-To: <20181130012435.GI30479@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v5 23/36] spapr/xive: add migration support
 for KVM
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

[ ... ]

>>>> +/*
>>>> + * The sPAPRXive KVM model migration priority is higher to make sure
>>>
>>> Higher than what?
>>
>> Than the XiveTCTX and XiveSource models.
>>
>>>> + * its 'pre_save' method runs before all the other XIVE models. It
>>>
>>> If the other XIVE components are children of sPAPRXive (which I think
>>> they are or could be), then I believe the parent object's pre_save
>>> will automatically be called first.
>>
>> ok. XiveTCTX are not children of sPAPRXive but that might not be 
>> a problem anymore with the VMState change handler.
> 
> Ah, right.  You might need the handler in the machine itself then - we
> already have something like that for XICS, IIRC.

exactly. For XIVE, I am using the post_load method at the machine level, 
which should be last. The XIVE sources PQs are restored when the 
machine starts running again in the VM state change handler. So I don't
need the priority at all on the destination. I will try to remove the
prio, I agree it's a bit ugly.  

C.
