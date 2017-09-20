Received: from eggs.gnu.org ([2001:4830:134:3::10]:46442)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1duWV7-0001Zb-Q0
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 00:20:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1duWV4-0002Ox-Kq
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 00:20:41 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:56926)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <nikunj@linux.vnet.ibm.com>)
	id 1duWV4-0002Hh-C6
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 00:20:38 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v8K4JHY3113957
	for <qemu-devel@nongnu.org>; Wed, 20 Sep 2017 00:20:36 -0400
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2d3cmr6uxk-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 20 Sep 2017 00:20:36 -0400
Received: from localhost
	by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <nikunj@linux.vnet.ibm.com>;
	Wed, 20 Sep 2017 14:20:33 +1000
From: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
In-Reply-To: <20170919082421.GU27153@umbus>
References: <20170906082748.28520-1-nikunj@linux.vnet.ibm.com>
	<20170909070212.GT2735@umbus.fritz.box>
	<87k2153jnx.fsf@abhimanyu.i-did-not-set--mail-host-address--so-tickle-me>
	<20170913073519.GK7550@umbus.fritz.box>
	<8760clsw17.fsf@abhimanyu.i-did-not-set--mail-host-address--so-tickle-me>
	<20170915064830.GI5250@umbus.fritz.box>
	<87377omkuk.fsf@abhimanyu.i-did-not-set--mail-host-address--so-tickle-me>
	<20170915085115.GN5250@umbus.fritz.box>
	<87y3pgl45f.fsf@abhimanyu.i-did-not-set--mail-host-address--so-tickle-me>
	<20170919082421.GU27153@umbus>
Date: Wed, 20 Sep 2017 09:50:24 +0530
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <871sn2hugn.fsf@abhimanyu.i-did-not-set--mail-host-address--so-tickle-me>
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

> On Fri, Sep 15, 2017 at 02:39:16PM +0530, Nikunj A Dadhania wrote:
>> David Gibson <david@gibson.dropbear.id.au> writes:
>> 
>> > On Fri, Sep 15, 2017 at 01:53:15PM +0530, Nikunj A Dadhania wrote:
>> >> David Gibson <david@gibson.dropbear.id.au> writes:
>> >> 
>> >> >> 
>> >> >> I thought, I am doing the same here for PowerNV, number of online cores
>> >> >> is equal to initial online vcpus / threads per core
>> >> >> 
>> >> >>    int boot_cores_nr = smp_cpus / smp_threads;
>> >> >> 
>> >> >> Only difference that I see in PowerNV is that we have multiple chips
>> >> >> (max 2, at the moment)
>> >> >> 
>> >> >>         cores_per_chip = smp_cpus / (smp_threads * pnv->num_chips);
>> >> >
>> >> > This doesn't make sense to me.  Cores per chip should *always* equal
>> >> > smp_cores, you shouldn't need another calculation for it.
>> >> >
>> >> >> And in case user has provided sane smp_cores, we use it.
>> >> >
>> >> > If smp_cores isn't sane, you should simply reject it, not try to fix
>> >> > it.  That's just asking for confusion.
>> >> 
>> >> This is the case where the user does not provide a topology(which is a
>> >> valid scenario), not sure we should reject it. So qemu defaults
>> >> smp_cores/smt_threads to 1. I think it makes sense to over-ride.
>> >
>> > If you can find a way to override it by altering smp_cores when it's
>> > not explicitly specified, then ok.
>> 
>> Should I change the global smp_cores here as well ?
>
> I'm pretty uneasy with that option.

Me too.

> It would take a fair bit of checking to ensure that changing smp_cores
> is safe here. An easier to verify option would be to make the generic
> logic which splits up an unspecified -smp N into cores and sockets
> more flexible, possibly based on machine options for max values.
>
> That might still be more trouble than its worth.

I think the current approach is the simplest and less intrusive, as we
are handling a case where user has not bothered to provide a detailed
topology, the best we can do is create single threaded cores equal to
number of cores.

Regards
Nikunj
