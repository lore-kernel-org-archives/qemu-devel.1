Received: from eggs.gnu.org ([2001:4830:134:3::10]:59667)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1dxtqc-0008WC-Vu
	for qemu-devel@nongnu.org; Fri, 29 Sep 2017 07:52:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1dxtqZ-0002Jm-0B
	for qemu-devel@nongnu.org; Fri, 29 Sep 2017 07:52:50 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:38250
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <nikunj@linux.vnet.ibm.com>)
	id 1dxtqY-0002JK-Qk
	for qemu-devel@nongnu.org; Fri, 29 Sep 2017 07:52:46 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v8TBpIvb051286
	for <qemu-devel@nongnu.org>; Fri, 29 Sep 2017 07:52:43 -0400
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2d9ggdhd8s-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 29 Sep 2017 07:52:43 -0400
Received: from localhost
	by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <nikunj@linux.vnet.ibm.com>;
	Fri, 29 Sep 2017 21:52:40 +1000
From: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
In-Reply-To: <20170929061735.GD7712@umbus.fritz.box>
References: <150659494872.25889.2069124544245723984.stgit@aravinda>
	<150659505839.25889.2018054058894535368.stgit@aravinda>
	<20170929061735.GD7712@umbus.fritz.box>
Date: Fri, 29 Sep 2017 17:22:22 +0530
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <87y3oxen7t.fsf@abhimanyu.i-did-not-set--mail-host-address--so-tickle-me>
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH v5 1/6] ppc: spapr: Register and
 handle HCALL to receive updated RTAS region
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>, Aravinda Prasad <aravinda@linux.vnet.ibm.com>
Cc: benh@au1.ibm.com, mahesh@linux.vnet.ibm.com, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, paulus@samba.org, sam.bobroff@au1.ibm.com
List-ID: <qemu-devel.nongnu.org>

David Gibson <david@gibson.dropbear.id.au> writes:

> On Thu, Sep 28, 2017 at 04:07:38PM +0530, Aravinda Prasad wrote:
>> Receive updates from SLOF about the updated rtas-base.
>> A separate patch for SLOF [1] (commit f9a60de3) adds
>> functionality to invoke a private HCALL whenever OS
>> issues instantiate-rtas with a new rtas-base.
>> 
>> This is required as QEMU needs to know the updated rtas-base
>> as it allocates error reporting structure in RTAS space upon
>> a machine check exception.
>> 
>> [1] https://lists.ozlabs.org/pipermail/linuxppc-dev/2014-August/120386.html
>> 
>> Signed-off-by: Aravinda Prasad <aravinda@linux.vnet.ibm.com>
>> Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
>
> Ao I acked this earlier, but I've now realized there might be some
> connection between this and discussions taking place elsewhere about
> qemu not knowing what SLOF does with the device tree.
>
> At what point will SLOF call the UPDATE_RTAS hcall?  I'm guessing at
> the time of instantiate-rtas, is that right?

The call happens from
arch/powerpc/kernel/prom_init.c:prom_instantiate_rtas() and after that
linux kernel makes two entries in the DT

....
       if (call_prom_ret("call-method", 3, 2, &entry,
                          ADDR("instantiate-rtas"),
                          rtas_inst, base) != 0
            || entry == 0) {
                prom_printf(" failed\n");
                return;
        }
        prom_printf(" done\n");

        reserve_mem(base, size);

        val = cpu_to_be32(base);
        prom_setprop(rtas_node, "/rtas", "linux,rtas-base",
                     &val, sizeof(val));
        val = cpu_to_be32(entry);
        prom_setprop(rtas_node, "/rtas", "linux,rtas-entry",
                     &val, sizeof(val));
....

Quiesce is called after this. 

> Does SLOF put the RTAS blob address in its internal device tree, or
> does it only pass it to the guest via the return parameters from
> instantiate-rtas?

Entry was made to the DT by linux kernel prom_init code, will this be
visible to QEMU?

Regards,
Nikunj
