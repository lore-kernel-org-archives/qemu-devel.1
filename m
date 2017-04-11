Received: from eggs.gnu.org ([2001:4830:134:3::10]:56287)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1cxyGP-0003Ql-Rf
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 12:03:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1cxyGM-0002ql-Pl
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 12:03:29 -0400
Received: from 2.mo173.mail-out.ovh.net ([178.33.251.49]:49603)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1cxyGM-0002qE-K0
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 12:03:26 -0400
Received: from player778.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo173.mail-out.ovh.net (Postfix) with ESMTP id 6A44531169
	for <qemu-devel@nongnu.org>; Tue, 11 Apr 2017 18:03:24 +0200 (CEST)
References: <1491396106-26376-1-git-send-email-clg@kaod.org>
	<1491396106-26376-21-git-send-email-clg@kaod.org>
	<20170410081414.GS27571@umbus>
	<1491879951.4166.222.camel@kernel.crashing.org>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <d44181ac-63fd-deec-3013-a0b048123418@kaod.org>
Date: Tue, 11 Apr 2017 18:03:12 +0200
MIME-Version: 1.0
In-Reply-To: <1491879951.4166.222.camel@kernel.crashing.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 20/21] ppc/pnv: Add model for Power8 PHB3
 PCIe Host bridge
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Marcel Apfelbaum <marcel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>

On 04/11/2017 05:05 AM, Benjamin Herrenschmidt wrote:
> On Mon, 2017-04-10 at 18:14 +1000, David Gibson wrote:
>>> +    switch (size) {
>>> +    case 1:
>>> +        break;
>>> +    case 2:
>>> +        val = bswap16(val);
>>
>> An unconditional bswap() seems unlikely to be correct.  What's the
>> purpose of thise?
> 
> Though it is :-) I *think* ... I did test with both LE and BE hosts I
> believe but Cedric can double check.

Yeah that works. I ran a PowerNV guest under a Pseries BE guest under
a PowerNV P8 host. Network was running on the final guest so I suppose 
that's enough to check the PCI layer.  

> 
> From memory it comes from the fact that the PHB register space is
> declared to be big endian since 99% of it actually is.
> 
> However the CONFIG_DATA register used to issue config space accesses is
> "special" and expect little endian accesses.
> 
> However because the whole region is marked BE, qemu will have done
> the necessary swapping for BE, which thus needs to be undone for
> that specific register unconditionally:
> 
>  - BE host will not swap the value, so we get the LE value written by
> the guest which needs to be swapped to BE.
> 
>  - LE host will have swapped the value as if it was BE except it isn't
> so we need to re-swap it.
>
> IE. Another option would be to create a specific memory region just for
> that one register but it's easier to just unconditionally swap.

No that's fine. I will add some helper routines to explain what is
happening. I have had to do some thing similar with the Aspeed flash
controller tests when using the Command mode.  

Thanks,

C.
 
>>> +        break;
>>> +    case 4:
>>> +        val = bswap32(val);
>>> +        break;
>>
>> No 64-bit config registers?
> 
> No, they don't exist. (Which is also why an assert isn't a good
> idea as other registers do support 64-bit accesses).
> 
> Ben.
> 
