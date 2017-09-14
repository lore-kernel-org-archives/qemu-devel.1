Received: from eggs.gnu.org ([2001:4830:134:3::10]:39665)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1dsMSe-0004pl-0B
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 01:13:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1dsMSa-0007ph-7A
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 01:13:11 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:46853)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <nikunj@linux.vnet.ibm.com>)
	id 1dsMSZ-0007nl-Vg
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 01:13:08 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v8E5BtUd006215
	for <qemu-devel@nongnu.org>; Thu, 14 Sep 2017 01:13:06 -0400
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2cyj72bg1v-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 14 Sep 2017 01:13:05 -0400
Received: from localhost
	by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <nikunj@linux.vnet.ibm.com>;
	Thu, 14 Sep 2017 15:13:03 +1000
From: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
In-Reply-To: <20170913073519.GK7550@umbus.fritz.box>
References: <20170906082748.28520-1-nikunj@linux.vnet.ibm.com>
	<20170909070212.GT2735@umbus.fritz.box>
	<87k2153jnx.fsf@abhimanyu.i-did-not-set--mail-host-address--so-tickle-me>
	<20170913073519.GK7550@umbus.fritz.box>
Date: Thu, 14 Sep 2017 10:42:52 +0530
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <8760clsw17.fsf@abhimanyu.i-did-not-set--mail-host-address--so-tickle-me>
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

> On Mon, Sep 11, 2017 at 10:40:10AM +0530, Nikunj A Dadhania wrote:
>> David Gibson <david@gibson.dropbear.id.au> writes:
>> 
>> > On Wed, Sep 06, 2017 at 01:57:48PM +0530, Nikunj A Dadhania wrote:
>> >> When the user does not provide the cpu topology, e.g. "-smp 4", machine fails to
>> >> initialize 4 cpus. Compute the chip per cores depending on the number of chips
>> >> and smt threads.
>> >> 
>> >> Signed-off-by: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
>> >
>> > I don't understand why simply treating smp_cores as cores per chip is wrong.
>> 
>> We do not have SMT support and when "-smp 4" is passed, smp_cores is
>> always set to 1. So only once core with one thread finally show up in
>> the guest. Moreover, I see spapr too doing similar thing in
>> spapr_init_cpus() with boot_cores_nr.
>
> I'm ok with adding an error if smp_threads > 1, since that won't
> work.  Breaking the identity that smp_cores is the number of cores per
> socket (which should correspond to one chip) is not ok, though.
>
> I think you're misinterpreting the boot_cores_nr stuff - that's just
> about translating the number of initially online vcpus into a number
> of initially online cores.

I thought, I am doing the same here for PowerNV, number of online cores
is equal to initial online vcpus / threads per core

   int boot_cores_nr = smp_cpus / smp_threads;

Only difference that I see in PowerNV is that we have multiple chips
(max 2, at the moment)

        cores_per_chip = smp_cpus / (smp_threads * pnv->num_chips);

And in case user has provided sane smp_cores, we use it.

Regards,
Nikunj
