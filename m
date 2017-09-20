Received: from eggs.gnu.org ([2001:4830:134:3::10]:58857)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1dua8C-0002u0-AN
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 04:13:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1dua86-0005tJ-5S
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 04:13:16 -0400
Received: from 5.mo2.mail-out.ovh.net ([87.98.181.248]:37948)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1dua85-0005ms-ST
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 04:13:10 -0400
Received: from player157.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo2.mail-out.ovh.net (Postfix) with ESMTP id 51BD8AC9D5
	for <qemu-devel@nongnu.org>; Wed, 20 Sep 2017 10:13:08 +0200 (CEST)
References: <20170915064830.GI5250@umbus.fritz.box>
	<87377omkuk.fsf@abhimanyu.i-did-not-set--mail-host-address--so-tickle-me>
	<20170915085115.GN5250@umbus.fritz.box>
	<87y3pgl45f.fsf@abhimanyu.i-did-not-set--mail-host-address--so-tickle-me>
	<20170919082421.GU27153@umbus>
	<871sn2hugn.fsf@abhimanyu.i-did-not-set--mail-host-address--so-tickle-me>
	<20170920045524.GH5520@umbus.fritz.box>
	<87y3pagdg0.fsf@abhimanyu.i-did-not-set--mail-host-address--so-tickle-me>
	<20170920061756.GJ5520@umbus.fritz.box>
	<87vakdhnyn.fsf@abhimanyu.i-did-not-set--mail-host-address--so-tickle-me>
	<20170920065700.GO5520@umbus.fritz.box>
	<87poalhm74.fsf@abhimanyu.i-did-not-set--mail-host-address--so-tickle-me>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <90951ad0-ad4a-8649-f9f2-bb82dee276af@kaod.org>
Date: Wed, 20 Sep 2017 10:12:59 +0200
MIME-Version: 1.0
In-Reply-To: <87poalhm74.fsf@abhimanyu.i-did-not-set--mail-host-address--so-tickle-me>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] ppc/pnv: fix cores per chip for multiple
 cpus
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>, David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, bharata@linux.vnet.ibm.com, benh@kernel.crashing.org

On 09/20/2017 09:18 AM, Nikunj A Dadhania wrote:
> David Gibson <david@gibson.dropbear.id.au> writes:
> 
>> On Wed, Sep 20, 2017 at 12:10:48PM +0530, Nikunj A Dadhania wrote:
>>> David Gibson <david@gibson.dropbear.id.au> writes:
>>>
>>>> On Wed, Sep 20, 2017 at 10:43:19AM +0530, Nikunj A Dadhania wrote:
>>>>> David Gibson <david@gibson.dropbear.id.au> writes:
>>>>>
>>>>>> On Wed, Sep 20, 2017 at 09:50:24AM +0530, Nikunj A Dadhania wrote:
>>>>>>> David Gibson <david@gibson.dropbear.id.au> writes:
>>>>>>>
>>>>>>>> On Fri, Sep 15, 2017 at 02:39:16PM +0530, Nikunj A Dadhania wrote:
>>>>>>>>> David Gibson <david@gibson.dropbear.id.au> writes:
>>>>>>>>>
>>>>>>>>>> On Fri, Sep 15, 2017 at 01:53:15PM +0530, Nikunj A Dadhania wrote:
>>>>>>>>>>> David Gibson <david@gibson.dropbear.id.au> writes:
>>>>>>>>>>>
>>>>>>>>>>>>>
>>>>>>>>>>>>> I thought, I am doing the same here for PowerNV, number of online cores
>>>>>>>>>>>>> is equal to initial online vcpus / threads per core
>>>>>>>>>>>>>
>>>>>>>>>>>>>    int boot_cores_nr = smp_cpus / smp_threads;
>>>>>>>>>>>>>
>>>>>>>>>>>>> Only difference that I see in PowerNV is that we have multiple chips
>>>>>>>>>>>>> (max 2, at the moment)
>>>>>>>>>>>>>
>>>>>>>>>>>>>         cores_per_chip = smp_cpus / (smp_threads * pnv->num_chips);
>>>>>>>>>>>>
>>>>>>>>>>>> This doesn't make sense to me.  Cores per chip should *always* equal
>>>>>>>>>>>> smp_cores, you shouldn't need another calculation for it.
>>>>>>>>>>>>
>>>>>>>>>>>>> And in case user has provided sane smp_cores, we use it.
>>>>>>>>>>>>
>>>>>>>>>>>> If smp_cores isn't sane, you should simply reject it, not try to fix
>>>>>>>>>>>> it.  That's just asking for confusion.
>>>>>>>>>>>
>>>>>>>>>>> This is the case where the user does not provide a topology(which is a
>>>>>>>>>>> valid scenario), not sure we should reject it. So qemu defaults
>>>>>>>>>>> smp_cores/smt_threads to 1. I think it makes sense to over-ride.
>>>>>>>>>>
>>>>>>>>>> If you can find a way to override it by altering smp_cores when it's
>>>>>>>>>> not explicitly specified, then ok.
>>>>>>>>>
>>>>>>>>> Should I change the global smp_cores here as well ?
>>>>>>>>
>>>>>>>> I'm pretty uneasy with that option.
>>>>>>>
>>>>>>> Me too.
>>>>>>>
>>>>>>>> It would take a fair bit of checking to ensure that changing smp_cores
>>>>>>>> is safe here. An easier to verify option would be to make the generic
>>>>>>>> logic which splits up an unspecified -smp N into cores and sockets
>>>>>>>> more flexible, possibly based on machine options for max values.
>>>>>>>>
>>>>>>>> That might still be more trouble than its worth.
>>>>>>>
>>>>>>> I think the current approach is the simplest and less intrusive, as we
>>>>>>> are handling a case where user has not bothered to provide a detailed
>>>>>>> topology, the best we can do is create single threaded cores equal to
>>>>>>> number of cores.
>>>>>>
>>>>>> No, sorry.  Having smp_cores not correspond to the number of cores per
>>>>>> chip in all cases is just not ok.  Add an error message if the
>>>>>> topology isn't workable for powernv by all means.  But users having to
>>>>>> use a longer command line is better than breaking basic assumptions
>>>>>> about what numbers reflect what topology.
>>>>>
>>>>> Sorry to ask again, as I am still not convinced, we do similar
>>>>> adjustment in spapr where the user did not provide the number of cores,
>>>>> but qemu assumes them as single threaded cores and created
>>>>> cores(boot_cores_nr) that were not same as smp_cores ?
>>>>
>>>> What?  boot_cores_nr has absolutely nothing to do with adjusting the
>>>> topology, and it certainly doesn't assume they're single threaded.
>>>
>>> When we start a TCG guest and user provides following commandline, e.g.
>>> "-smp 4", smt_threads is set to 1 by default in vl.c. So the guest boots
>>> with 4 cores, each having 1 thread.
>>
>> Ok.. and what's the problem with that behaviour on powernv?
> 
> As smp_thread defaults to 1 in vl.c, similarly smp_cores also has the
> default value of 1 in vl.c. In powernv, we were setting nr-cores like
> this:
> 
>         object_property_set_int(chip, smp_cores, "nr-cores", &error_fatal);
> 
> Even when there were multiple cpus (-smp 4), when the guest boots up, we
> just get one core (i.e. smp_cores was 1) with single thread(smp_threads
> was 1), which is wrong as per the command-line that was provided.

I have never noticed as always use the cores= option but if you use
the following on a powernv machine:

 -smp 4				1 cpu
 -smp cpus=4,threads=1		1 cpu
 -smp cores=4,threads=1		4 cpus
 -smp cpus=4,cores=4,threads=1	4 cpus
 -smp cpus=1,cores=4,threads=1	fails
 -smp cpus=4,cores=1,threads=1	1 cpu

Should we be using 'smp_cpus' instead of 'smp_cores' then ? Honestly,
I feel a bit lost with all default behaviors.

C. 
