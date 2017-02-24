Received: from eggs.gnu.org ([2001:4830:134:3::10]:34610)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1chJl8-0002wG-3y
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 12:34:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1chJl3-0000FM-T4
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 12:34:22 -0500
Received: from mo5.mail-out.ovh.net ([178.32.228.5]:36070)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1chJl3-0008JL-Mw
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 12:34:17 -0500
Received: from player734.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo5.mail-out.ovh.net (Postfix) with ESMTP id 68876DC691
	for <qemu-devel@nongnu.org>; Fri, 24 Feb 2017 18:34:10 +0100 (CET)
References: <1487252865-12064-1-git-send-email-clg@kaod.org>
	<1487252865-12064-9-git-send-email-clg@kaod.org>
	<20170223022933.GW12577@umbus.fritz.box>
	<6deab394-2564-3a43-669c-af4b8a2aa4e3@kaod.org>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <e12d3243-3da1-b432-a898-f01e89af5807@kaod.org>
Date: Fri, 24 Feb 2017 18:34:06 +0100
MIME-Version: 1.0
In-Reply-To: <6deab394-2564-3a43-669c-af4b8a2aa4e3@kaod.org>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH v2 08/22] ppc/xics: use the QOM
 interface to resend irqs
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

>>> @@ -592,10 +593,11 @@ static void ics_simple_reset(DeviceState *dev)
>>>  
>>>  static int ics_simple_post_load(ICSState *ics, int version_id)
>>>  {
>>> +    XICSInterface *xi = XICS_INTERFACE(qdev_get_machine());
>>>      int i;
>>>  
>>>      for (i = 0; i < ics->xics->nr_servers; i++) {
>>> -        icp_resend(&ics->xics->ss[i]);
>>> +        icp_resend(xi, &ics->xics->ss[i]);
>>>      }
>>
>> This resend triggering needs to get moved to the xics interface
>> implementor - i.e. the machine.  It's actually already broken right
>> now, since it incorrectly relies on the ordering of the ics and icp
>> restore during migration.
> 
> I'm adding a icp_resend() handler in patch 12 and using it patch 14.
> Maybe we can move the post_load() handler out of ICS simple now ? 

Could you give me a little more info on what should be done ? I lack 
context on this problem. 

So should we call : 

    ICPState *ss = opaque;
    ICPStateClass *info = ICP_GET_CLASS(ss);

    if (info->post_load) {
        return info->post_load(ss, version_id);
    }

and then 

    ICSState *ics = opaque;
    ICSStateClass *info = ICS_BASE_GET_CLASS(ics);

    if (info->post_load) {
        return info->post_load(ics, version_id);
    }

from spapr_post_load() ? 

Thanks,

C.
