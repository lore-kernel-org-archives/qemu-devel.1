Received: from eggs.gnu.org ([2001:4830:134:3::10]:50413)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1dsmcy-0003wN-7T
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 05:09:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1dsmcu-0006iv-0i
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 05:09:36 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:60335)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <nikunj@linux.vnet.ibm.com>)
	id 1dsmct-0006ia-ON
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 05:09:31 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v8F94QWN050454
	for <qemu-devel@nongnu.org>; Fri, 15 Sep 2017 05:09:30 -0400
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2d084u284b-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 15 Sep 2017 05:09:30 -0400
Received: from localhost
	by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <nikunj@linux.vnet.ibm.com>;
	Fri, 15 Sep 2017 19:09:27 +1000
From: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
In-Reply-To: <20170915085115.GN5250@umbus.fritz.box>
References: <20170906082748.28520-1-nikunj@linux.vnet.ibm.com>
	<20170909070212.GT2735@umbus.fritz.box>
	<87k2153jnx.fsf@abhimanyu.i-did-not-set--mail-host-address--so-tickle-me>
	<20170913073519.GK7550@umbus.fritz.box>
	<8760clsw17.fsf@abhimanyu.i-did-not-set--mail-host-address--so-tickle-me>
	<20170915064830.GI5250@umbus.fritz.box>
	<87377omkuk.fsf@abhimanyu.i-did-not-set--mail-host-address--so-tickle-me>
	<20170915085115.GN5250@umbus.fritz.box>
Date: Fri, 15 Sep 2017 14:39:16 +0530
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <87y3pgl45f.fsf@abhimanyu.i-did-not-set--mail-host-address--so-tickle-me>
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
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, clg@kaod.org, bharata@linux.vnet.ibm.com, benh@kernel.crashing.org

David Gibson <david@gibson.dropbear.id.au> writes:

> On Fri, Sep 15, 2017 at 01:53:15PM +0530, Nikunj A Dadhania wrote:
>> David Gibson <david@gibson.dropbear.id.au> writes:
>> 
>> >> 
>> >> I thought, I am doing the same here for PowerNV, number of online cores
>> >> is equal to initial online vcpus / threads per core
>> >> 
>> >>    int boot_cores_nr = smp_cpus / smp_threads;
>> >> 
>> >> Only difference that I see in PowerNV is that we have multiple chips
>> >> (max 2, at the moment)
>> >> 
>> >>         cores_per_chip = smp_cpus / (smp_threads * pnv->num_chips);
>> >
>> > This doesn't make sense to me.  Cores per chip should *always* equal
>> > smp_cores, you shouldn't need another calculation for it.
>> >
>> >> And in case user has provided sane smp_cores, we use it.
>> >
>> > If smp_cores isn't sane, you should simply reject it, not try to fix
>> > it.  That's just asking for confusion.
>> 
>> This is the case where the user does not provide a topology(which is a
>> valid scenario), not sure we should reject it. So qemu defaults
>> smp_cores/smt_threads to 1. I think it makes sense to over-ride.
>
> If you can find a way to override it by altering smp_cores when it's
> not explicitly specified, then ok.

Should I change the global smp_cores here as well ?

> But overriding smp_cores with a different variable that's the "real"
> number of cores is not acceptable. If that means the user has to
> specify cores explicitly, so be it.

Right, we would error out in case there is mismatch.

> Slight awkwardness in command line is preferable to breaking the
> assumption that smp_cores == (# of cores per next level up cpu object)
> which is used all over the place.

Regards
Nikunj
