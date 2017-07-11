Received: from eggs.gnu.org ([2001:4830:134:3::10]:49820)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <danielhb@linux.vnet.ibm.com>) id 1dUvOE-0004BD-GP
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 09:39:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <danielhb@linux.vnet.ibm.com>) id 1dUvOB-0004IR-8l
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 09:39:46 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:40943)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <danielhb@linux.vnet.ibm.com>)
	id 1dUvOA-0004Hz-VW
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 09:39:43 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v6BDcoWD046824
	for <qemu-devel@nongnu.org>; Tue, 11 Jul 2017 09:39:41 -0400
Received: from e24smtp01.br.ibm.com (e24smtp01.br.ibm.com [32.104.18.85])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2bmc3gs0f4-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 11 Jul 2017 09:39:41 -0400
Received: from localhost
	by e24smtp01.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <danielhb@linux.vnet.ibm.com>;
	Tue, 11 Jul 2017 10:39:37 -0300
References: <20170707212037.24642-1-danielhb@linux.vnet.ibm.com>
	<20170710063910.GB4083@umbus.fritz.box>
	<eeb7b4a2-ebe4-be28-6efd-071e7ab53625@linux.vnet.ibm.com>
	<20170711130047.GI4083@umbus.fritz.box>
From: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
Date: Tue, 11 Jul 2017 10:39:33 -0300
MIME-Version: 1.0
In-Reply-To: <20170711130047.GI4083@umbus.fritz.box>
Content-Language: en-US
Message-Id: <6582b68b-752e-7740-18a8-c8a50a05effe@linux.vnet.ibm.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-ppc] [RFC drcVI PATCH] spapr: reset DRCs on
 migration pre_load
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, mdroth@linux.vnet.ibm.com, lvivier@redhat.com



On 07/11/2017 10:00 AM, David Gibson wrote:
> Ah! So it's broken for the prelaunch case as well, though in a
> slightly different way.  Actually for me the breakage is less obvious
> - if I plug the cpu at prelaunch, I*do*  get 2 cpus appearing in the
> running system.  But tracing through, that's because the hotplug
> message was queued and gets processed during boot.  That gets to the
> right place in the end, but it's kind of silly going through the
> hotplug logic.
>
> I thought there was a system reset after the prelaunch phase, but I
> was mistaken.
>
> I can see two ways to address this:
>    1) add in a DRC reset before starting up the machine, for both the
>       prelaunch and inmigrate cases.  Your draft patch does the second,
>       but I don't see an obvious place to put a hook for the first
>
>    2) Change the plug (and unplug) paths to skip the notification and
>       gradual state change, and just immediately jump to the completed
>       state when called in the prelaunch or inmigrate. (Easiest way
>       would be just to call the drc reset function instead of queueing
>       an event).
>
> (2) is basically the approach Laurent proposed in a patch a little
> while ago, defining an spapr_hotplugged() function that always
> returned false in prelaunch or inmigrate states.
>
> At the time I was dubious about that approach, because I thought we
> had a natural reset point after that.  After more careful
> investigation, I think that's not the case however, so I'm inclined to
> go with approach (2), polish up Laurent's patch and apply that.
Agreed. I remember Laurent's patch and I think it covers both scenarios 
in a better
way than adding a DRC reset in a pre_load migration hook and another DRC 
reset
in another place to cover the machine start.


Daniel
