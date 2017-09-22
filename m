Received: from eggs.gnu.org ([2001:4830:134:3::10]:35562)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1dvLmu-00083N-2n
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 07:06:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1dvLmq-0008QK-16
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 07:06:28 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:52866
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <nikunj@linux.vnet.ibm.com>)
	id 1dvLmp-0008Q9-Ra
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 07:06:23 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v8MB5dQg076198
	for <qemu-devel@nongnu.org>; Fri, 22 Sep 2017 07:06:18 -0400
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2d4yn2xpeq-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 22 Sep 2017 07:06:17 -0400
Received: from localhost
	by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <nikunj@linux.vnet.ibm.com>;
	Fri, 22 Sep 2017 21:06:15 +1000
From: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
In-Reply-To: <15582716-0d6e-aa7e-e429-08e1078765a4@kaod.org>
References: <20170919082421.GU27153@umbus>
	<871sn2hugn.fsf@abhimanyu.i-did-not-set--mail-host-address--so-tickle-me>
	<20170920045524.GH5520@umbus.fritz.box>
	<87y3pagdg0.fsf@abhimanyu.i-did-not-set--mail-host-address--so-tickle-me>
	<20170920061756.GJ5520@umbus.fritz.box>
	<87vakdhnyn.fsf@abhimanyu.i-did-not-set--mail-host-address--so-tickle-me>
	<20170920065700.GO5520@umbus.fritz.box>
	<87poalhm74.fsf@abhimanyu.i-did-not-set--mail-host-address--so-tickle-me>
	<20170920115342.GQ5520@umbus.fritz.box>
	<87377gpuyh.fsf@abhimanyu.i-did-not-set--mail-host-address--so-tickle-me>
	<20170921053107.GD4998@umbus.fritz.box>
	<87y3p7nugc.fsf@abhimanyu.i-did-not-set--mail-host-address--so-tickle-me>
	<15582716-0d6e-aa7e-e429-08e1078765a4@kaod.org>
Date: Fri, 22 Sep 2017 16:36:02 +0530
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Message-Id: <871smzdmcl.fsf@abhimanyu.i-did-not-set--mail-host-address--so-tickle-me>
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
To: =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>, David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, bharata@linux.vnet.ibm.com, benh@kernel.crashing.org

C=C3=A9dric Le Goater <clg@kaod.org> writes:

> On 09/22/2017 08:00 AM, Nikunj A Dadhania wrote:
>> David Gibson <david@gibson.dropbear.id.au> writes:
>>=20
>>>>>>
>>>>>> As smp_thread defaults to 1 in vl.c, similarly smp_cores also has the
>>>>>> default value of 1 in vl.c. In powernv, we were setting nr-cores like
>>>>>> this:
>>>>>>
>>>>>>         object_property_set_int(chip, smp_cores, "nr-cores", &error_=
fatal);
>>>>>>
>>>>>> Even when there were multiple cpus (-smp 4), when the guest boots up=
, we
>>>>>> just get one core (i.e. smp_cores was 1) with single thread(smp_thre=
ads
>>>>>> was 1), which is wrong as per the command-line that was provided.
>>>>>
>>>>> Right, so, -smp 4 defaults to 4 sockets, each with 1 core of 1
>>>>> thread.  If you can't supply 4 sockets you should error, but you
>>>>> shouldn't go and change the number of cores per socket.
>>>>
>>>> OK, that makes sense now. And I do see that smp_cpus is 4 in the above
>>>> case. Now looking more into it, i see that powernv has something called
>>>> "num_chips", isnt this same as sockets ? Do we need num_chips separate=
ly?
>>>
>>> Ah, yes, I see.  It's probably still reasonable to keep num_chips as
>>> an internal variable, rather than using (smp_cpus / smp_cores /
>>> smp_threads) everywhere.  But we shouldn't have it as a direct
>>> user-settable property, instead setting it from the -smp command line
>>> option.
>>=20
>> Something like the below works till num_chips=3D2, after that guest does
>> not boot up. This might be some limitation within the OS, Cedric might
>> have some clue. Otherwise, I see that multiple chips are created with
>> single core having single thread.
>>=20
>>     ppc/pnv: Use num_chips for multiple sockets
>>=20=20=20=20=20
>>     When the user does not provide the cpu topology, e.g. "-smp 4", mach=
ine fails to
>>     initialize 4 cpus. QEMU assumes smp_threads and smp_cores both as 1.=
 Make sure
>>     that we initialize multiple chips for this.
>
> -smp 4          would give a machine with 4 sockets with 1 core
> -smp 4,cores=3D4  would give a machine with 1 socket  with 4 cores
>
> correct ?

Yes

Regards
Nikunj
