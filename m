Received: from eggs.gnu.org ([2001:4830:134:3::10]:60852)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1dvLa0-0002mz-K1
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 06:53:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1dvLZv-00082U-Oq
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 06:53:08 -0400
Received: from 10.mo179.mail-out.ovh.net ([46.105.79.46]:49363)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1dvLZv-000822-GD
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 06:53:03 -0400
Received: from player690.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo179.mail-out.ovh.net (Postfix) with ESMTP id E5D9364E9A
	for <qemu-devel@nongnu.org>; Fri, 22 Sep 2017 12:53:01 +0200 (CEST)
References: <871sn2hugn.fsf@abhimanyu.i-did-not-set--mail-host-address--so-tickle-me>
	<20170920045524.GH5520@umbus.fritz.box>
	<87y3pagdg0.fsf@abhimanyu.i-did-not-set--mail-host-address--so-tickle-me>
	<20170920061756.GJ5520@umbus.fritz.box>
	<87vakdhnyn.fsf@abhimanyu.i-did-not-set--mail-host-address--so-tickle-me>
	<20170920065700.GO5520@umbus.fritz.box>
	<87poalhm74.fsf@abhimanyu.i-did-not-set--mail-host-address--so-tickle-me>
	<20170920115342.GQ5520@umbus.fritz.box>
	<87377gpuyh.fsf@abhimanyu.i-did-not-set--mail-host-address--so-tickle-me>
	<a59b2c71-fe1d-1ef6-e885-703c3f33893c@kaod.org>
	<20170922100858.GE4998@umbus.fritz.box>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <0d09c93e-4fba-33b8-c05e-70decc9b6ff4@kaod.org>
Date: Fri, 22 Sep 2017 12:52:55 +0200
MIME-Version: 1.0
In-Reply-To: <20170922100858.GE4998@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
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
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, bharata@linux.vnet.ibm.com, benh@kernel.crashing.org

On 09/22/2017 12:08 PM, David Gibson wrote:
> On Thu, Sep 21, 2017 at 08:04:55AM +0200, C=E9dric Le Goater wrote:
>> On 09/21/2017 05:54 AM, Nikunj A Dadhania wrote:
>>> David Gibson <david@gibson.dropbear.id.au> writes:
>>>
>>>> On Wed, Sep 20, 2017 at 12:48:55PM +0530, Nikunj A Dadhania wrote:
>>>>> David Gibson <david@gibson.dropbear.id.au> writes:
>>>>>
>>>>>> On Wed, Sep 20, 2017 at 12:10:48PM +0530, Nikunj A Dadhania wrote:
>>>>>>> David Gibson <david@gibson.dropbear.id.au> writes:
>>>>>>>
>>>>>>>> On Wed, Sep 20, 2017 at 10:43:19AM +0530, Nikunj A Dadhania wrot=
e:
>>>>>>>>> David Gibson <david@gibson.dropbear.id.au> writes:
>>>>>>>>>
>>>>>>>>>> On Wed, Sep 20, 2017 at 09:50:24AM +0530, Nikunj A Dadhania wr=
ote:
>>>>>>>>>>> David Gibson <david@gibson.dropbear.id.au> writes:
>>>>>>>>>>>
>>>>>>>>>>>> On Fri, Sep 15, 2017 at 02:39:16PM +0530, Nikunj A Dadhania =
wrote:
>>>>>>>>>>>>> David Gibson <david@gibson.dropbear.id.au> writes:
>>>>>>>>>>>>>
>>>>>>>>>>>>>> On Fri, Sep 15, 2017 at 01:53:15PM +0530, Nikunj A Dadhani=
a wrote:
>>>>>>>>>>>>>>> David Gibson <david@gibson.dropbear.id.au> writes:
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>> I thought, I am doing the same here for PowerNV, number=
 of online cores
>>>>>>>>>>>>>>>>> is equal to initial online vcpus / threads per core
>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>    int boot_cores_nr =3D smp_cpus / smp_threads;
>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>> Only difference that I see in PowerNV is that we have m=
ultiple chips
>>>>>>>>>>>>>>>>> (max 2, at the moment)
>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>         cores_per_chip =3D smp_cpus / (smp_threads * pn=
v->num_chips);
>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>> This doesn't make sense to me.  Cores per chip should *a=
lways* equal
>>>>>>>>>>>>>>>> smp_cores, you shouldn't need another calculation for it=
.
>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>> And in case user has provided sane smp_cores, we use it=
.
>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>> If smp_cores isn't sane, you should simply reject it, no=
t try to fix
>>>>>>>>>>>>>>>> it.  That's just asking for confusion.
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> This is the case where the user does not provide a topolo=
gy(which is a
>>>>>>>>>>>>>>> valid scenario), not sure we should reject it. So qemu de=
faults
>>>>>>>>>>>>>>> smp_cores/smt_threads to 1. I think it makes sense to ove=
r-ride.
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> If you can find a way to override it by altering smp_cores=
 when it's
>>>>>>>>>>>>>> not explicitly specified, then ok.
>>>>>>>>>>>>>
>>>>>>>>>>>>> Should I change the global smp_cores here as well ?
>>>>>>>>>>>>
>>>>>>>>>>>> I'm pretty uneasy with that option.
>>>>>>>>>>>
>>>>>>>>>>> Me too.
>>>>>>>>>>>
>>>>>>>>>>>> It would take a fair bit of checking to ensure that changing=
 smp_cores
>>>>>>>>>>>> is safe here. An easier to verify option would be to make th=
e generic
>>>>>>>>>>>> logic which splits up an unspecified -smp N into cores and s=
ockets
>>>>>>>>>>>> more flexible, possibly based on machine options for max val=
ues.
>>>>>>>>>>>>
>>>>>>>>>>>> That might still be more trouble than its worth.
>>>>>>>>>>>
>>>>>>>>>>> I think the current approach is the simplest and less intrusi=
ve, as we
>>>>>>>>>>> are handling a case where user has not bothered to provide a =
detailed
>>>>>>>>>>> topology, the best we can do is create single threaded cores =
equal to
>>>>>>>>>>> number of cores.
>>>>>>>>>>
>>>>>>>>>> No, sorry.  Having smp_cores not correspond to the number of c=
ores per
>>>>>>>>>> chip in all cases is just not ok.  Add an error message if the
>>>>>>>>>> topology isn't workable for powernv by all means.  But users h=
aving to
>>>>>>>>>> use a longer command line is better than breaking basic assump=
tions
>>>>>>>>>> about what numbers reflect what topology.
>>>>>>>>>
>>>>>>>>> Sorry to ask again, as I am still not convinced, we do similar
>>>>>>>>> adjustment in spapr where the user did not provide the number o=
f cores,
>>>>>>>>> but qemu assumes them as single threaded cores and created
>>>>>>>>> cores(boot_cores_nr) that were not same as smp_cores ?
>>>>>>>>
>>>>>>>> What?  boot_cores_nr has absolutely nothing to do with adjusting=
 the
>>>>>>>> topology, and it certainly doesn't assume they're single threade=
d.
>>>>>>>
>>>>>>> When we start a TCG guest and user provides following commandline=
, e.g.
>>>>>>> "-smp 4", smt_threads is set to 1 by default in vl.c. So the gues=
t boots
>>>>>>> with 4 cores, each having 1 thread.
>>>>>>
>>>>>> Ok.. and what's the problem with that behaviour on powernv?
>>>>>
>>>>> As smp_thread defaults to 1 in vl.c, similarly smp_cores also has t=
he
>>>>> default value of 1 in vl.c. In powernv, we were setting nr-cores li=
ke
>>>>> this:
>>>>>
>>>>>         object_property_set_int(chip, smp_cores, "nr-cores", &error=
_fatal);
>>>>>
>>>>> Even when there were multiple cpus (-smp 4), when the guest boots u=
p, we
>>>>> just get one core (i.e. smp_cores was 1) with single thread(smp_thr=
eads
>>>>> was 1), which is wrong as per the command-line that was provided.
>>>>
>>>> Right, so, -smp 4 defaults to 4 sockets, each with 1 core of 1
>>>> thread.  If you can't supply 4 sockets you should error, but you
>>>> shouldn't go and change the number of cores per socket.
>>>
>>> OK, that makes sense now. And I do see that smp_cpus is 4 in the abov=
e
>>> case. Now looking more into it, i see that powernv has something call=
ed
>>> "num_chips", isnt this same as sockets ? Do we need num_chips separat=
ely?
>>
>> yes that would do for cpus, but how do we retrieve the number of=20
>> sockets ? I don't see a smp_sockets.=20
>=20
> 	# sockets =3D smp_cpus / smp_threads / smp_cores
>=20
> Or, if you want the maximum possible number of sockets (for a fully
> populated system)
> 	# sockets =3D max_cpus / smp_threads / smp_cores
ok. that would do for a default setting. Sorry for the noise.

>> If we start looking at such issues, we should also take into account=20
>> memory distribution :
>>
>>       -numa node[,mem=3Dsize][,cpus=3Dfirstcpu[-lastcpu]][,nodeid=3Dno=
de]
>>
>> would allow us to define a set of cpus per node, cpus should be evenly=
=20
>> distributed on the nodes though, and also define memory per node, but=20
>> some nodes could be without memory.
>=20
> I don't really see what that has to do with anything.  We already have
> ways to assign memory or cpus to specific nodes if we want.

We will see when the needs come if numa options fit the requirements.

C.=20
 =20
=20
