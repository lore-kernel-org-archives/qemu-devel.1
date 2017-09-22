Received: from eggs.gnu.org ([2001:4830:134:3::10]:59719)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1dvLUH-0000gj-E4
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 06:47:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1dvLUE-00062W-Bz
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 06:47:13 -0400
Received: from 4.mo179.mail-out.ovh.net ([46.105.36.149]:49090)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1dvLUE-00061n-5p
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 06:47:10 -0400
Received: from player690.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo179.mail-out.ovh.net (Postfix) with ESMTP id 6762262310
	for <qemu-devel@nongnu.org>; Fri, 22 Sep 2017 12:47:07 +0200 (CEST)
References: <87y3pagdg0.fsf@abhimanyu.i-did-not-set--mail-host-address--so-tickle-me>
	<20170920061756.GJ5520@umbus.fritz.box>
	<87vakdhnyn.fsf@abhimanyu.i-did-not-set--mail-host-address--so-tickle-me>
	<20170920065700.GO5520@umbus.fritz.box>
	<87poalhm74.fsf@abhimanyu.i-did-not-set--mail-host-address--so-tickle-me>
	<20170920115342.GQ5520@umbus.fritz.box>
	<87377gpuyh.fsf@abhimanyu.i-did-not-set--mail-host-address--so-tickle-me>
	<20170921053107.GD4998@umbus.fritz.box>
	<87y3p7nugc.fsf@abhimanyu.i-did-not-set--mail-host-address--so-tickle-me>
	<e2ad1b05-0e93-5389-92b5-7d9ebdd273f8@kaod.org>
	<20170922101201.GG4998@umbus.fritz.box>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <8cf3e77a-e397-c082-f1a2-b6b8c6be439f@kaod.org>
Date: Fri, 22 Sep 2017 12:46:58 +0200
MIME-Version: 1.0
In-Reply-To: <20170922101201.GG4998@umbus.fritz.box>
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

On 09/22/2017 12:12 PM, David Gibson wrote:
> On Fri, Sep 22, 2017 at 08:07:06AM +0200, C=E9dric Le Goater wrote:
>> On 09/22/2017 08:00 AM, Nikunj A Dadhania wrote:
>>> David Gibson <david@gibson.dropbear.id.au> writes:
>>>
>>>>>>>
>>>>>>> As smp_thread defaults to 1 in vl.c, similarly smp_cores also has=
 the
>>>>>>> default value of 1 in vl.c. In powernv, we were setting nr-cores =
like
>>>>>>> this:
>>>>>>>
>>>>>>>         object_property_set_int(chip, smp_cores, "nr-cores", &err=
or_fatal);
>>>>>>>
>>>>>>> Even when there were multiple cpus (-smp 4), when the guest boots=
 up, we
>>>>>>> just get one core (i.e. smp_cores was 1) with single thread(smp_t=
hreads
>>>>>>> was 1), which is wrong as per the command-line that was provided.
>>>>>>
>>>>>> Right, so, -smp 4 defaults to 4 sockets, each with 1 core of 1
>>>>>> thread.  If you can't supply 4 sockets you should error, but you
>>>>>> shouldn't go and change the number of cores per socket.
>>>>>
>>>>> OK, that makes sense now. And I do see that smp_cpus is 4 in the ab=
ove
>>>>> case. Now looking more into it, i see that powernv has something ca=
lled
>>>>> "num_chips", isnt this same as sockets ? Do we need num_chips separ=
ately?
>>>>
>>>> Ah, yes, I see.  It's probably still reasonable to keep num_chips as
>>>> an internal variable, rather than using (smp_cpus / smp_cores /
>>>> smp_threads) everywhere.  But we shouldn't have it as a direct
>>>> user-settable property, instead setting it from the -smp command lin=
e
>>>> option.
>>>
>>> Something like the below works till num_chips=3D2, after that guest d=
oes
>>> not boot up. This might be some limitation within the OS, Cedric migh=
t
>>> have some clue.
>>
>> Some controllers might need some more tweaking, PSI, LPC, to elect a=20
>> master one.
>=20
> Uh.. why?

that's not true. I managed to boot a pnv machine with 4 chips/sockets=20
each having 4 cpus using a 4.4.9-openpower2 skiroot kernel, from an=20
openpower firmare 1.10 I think. Recent openpower kernel must be using=20
some new features/instructions that we don't manage well in QEMU.

I would need to build a kernel with more output.

>> Anyhow I don't think we want to deduce the number of chips
>> from the number of cpus. These two figures are very different.
>=20
> How so?  It's not totally perfect, but making a single chip correspond
> to a "socket" in qemu's (somewhat x86 centric) terminology is still a
> pretty good match.

well, it would be good to be able to define chips with different
numbers of cpus. That is something will we want to do for sure.

Thanks,

C.=20
=20
