Received: from eggs.gnu.org ([2001:4830:134:3::10]:57066)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fV98X-0002N2-F5
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 01:25:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fV98U-0007SU-CC
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 01:25:01 -0400
Received: from 15.mo3.mail-out.ovh.net ([87.98.150.177]:44954)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1fV98U-0007Ry-4s
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 01:24:58 -0400
Received: from player793.ha.ovh.net (unknown [10.109.120.111])
	by mo3.mail-out.ovh.net (Postfix) with ESMTP id 0DF0D1BDD46
	for <qemu-devel@nongnu.org>; Tue, 19 Jun 2018 07:24:55 +0200 (CEST)
References: <20180615152536.30093-1-clg@kaod.org>
	<20180615152536.30093-4-clg@kaod.org>
	<20180618103844.GX25461@umbus.fritz.box>
	<9d1ce421-9caa-08eb-2417-15307dd271ed@kaod.org>
	<20180618121328.GY25461@umbus.fritz.box>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <048d2369-389f-1118-03b0-b81e6bd565a0@kaod.org>
Date: Tue, 19 Jun 2018 07:24:44 +0200
MIME-Version: 1.0
In-Reply-To: <20180618121328.GY25461@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 3/4] ppc/pnv: introduce Pnv8Chip and
 Pnv9Chip models
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


>>>  typedef struct PnvChipClass {
>>>      /*< private >*/
>>> @@ -75,6 +95,7 @@ typedef struct PnvChipClass {
>>>  
>>>      hwaddr       xscom_base;
>>>  
>>> +    void (*realize)(PnvChip *chip, Error **errp);
>>
>> This looks the wrong way round from how things are usually done.
>> Rather than having the base class realize() call the subclass specific
>> realize hook, it's more usual for the subclass to set the
>> dc->realize() and have it call a k->parent_realize() to call up the
>> chain.  grep for device_class_set_parent_realize() for some more
>> examples.
>
> Ah. That is more to my liking. There are a couple of models following
> the wrong object pattern, xics, vio. I will check them.

So XICS is causing some head-aches because the ics-kvm model inherits
from ics-simple which inherits from ics-base. so we have a grand-parent
class to handle.

if we could affiliate ics-kvm directly to ics-base it would make the 
family affair easier. we need to check migration though.  

C.
