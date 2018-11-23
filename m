Received: from eggs.gnu.org ([2001:4830:134:3::10]:52096)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1gQ8hR-0003VK-5l
	for qemu-devel@nongnu.org; Fri, 23 Nov 2018 05:28:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1gQ8hN-0004Qd-UP
	for qemu-devel@nongnu.org; Fri, 23 Nov 2018 05:28:37 -0500
Received: from 5.mo7.mail-out.ovh.net ([178.32.120.239]:57668)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1gQ8hN-0004Pf-Ls
	for qemu-devel@nongnu.org; Fri, 23 Nov 2018 05:28:33 -0500
Received: from player755.ha.ovh.net (unknown [10.109.160.153])
	by mo7.mail-out.ovh.net (Postfix) with ESMTP id 47A77EC839
	for <qemu-devel@nongnu.org>; Fri, 23 Nov 2018 11:28:32 +0100 (CET)
References: <20181116105729.23240-1-clg@kaod.org>
	<20181116105729.23240-5-clg@kaod.org>
	<20181122044450.GF10448@umbus.fritz.box>
	<121d4f915a03c2e734feebceda023947aedb78a3.camel@kernel.crashing.org>
	<20181123011005.GU10448@umbus.fritz.box>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <12f3da3b-3761-a26f-4460-65d3c978f52d@kaod.org>
Date: Fri, 23 Nov 2018 11:28:24 +0100
MIME-Version: 1.0
In-Reply-To: <20181123011005.GU10448@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v5 04/36] ppc/xive: introduce the
 XiveRouter model
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>, Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org

On 11/23/18 2:10 AM, David Gibson wrote:
> On Thu, Nov 22, 2018 at 05:50:07PM +1100, Benjamin Herrenschmidt wrote:
>> On Thu, 2018-11-22 at 15:44 +1100, David Gibson wrote:
>>>
>>> Sorry, didn't think of this in my first reply.
>>>
>>> 1) Does the hardware ever actually write back to the EAS?  I know it
>>> does for the END, but it's not clear why it would need to for the
>>> EAS.  If not, we don't need the setter.
>>
>> Nope, though the PAPR model will via hcalls
> 
> Right, bit AIUI the set_eas hook is about abstracting PAPR vs bare
> metal details.  Since the hcall knows it's PAPR it can just update the
> backing information for the EAS directly, and no need for an
> abstracted hook.

Indeed, the first versions of the XIVE patchset did not use such hooks, 
but when discussed we said we wanted abstract methods for the router 
to validate the overall XIVE model, which is useful for PowerNV. 

We can change again and have the hcalls get/set directly in the EAT
and ENDT. It would certainly simplify the sPAPR model. 

C.


> 
>>
>>>
>>> 2) The signatures are a bit odd here.  For the setter, a value would
>>> make sense than a (XiveEAS *), since it's just a word.  For the getter
>>> you could return the EAS value directly rather than using a pointer -
>>> there's already a valid bit in the EAS so you can construct a value
>>> with that cleared if the lisn is out of bounds.
>>
> 
