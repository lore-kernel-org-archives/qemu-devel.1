Received: from eggs.gnu.org ([2001:4830:134:3::10]:33916)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1dyr05-0002EZ-Tv
	for qemu-devel@nongnu.org; Sun, 01 Oct 2017 23:02:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1dyr02-0006Z4-0C
	for qemu-devel@nongnu.org; Sun, 01 Oct 2017 23:02:33 -0400
Received: from mail-pg0-x244.google.com ([2607:f8b0:400e:c05::244]:37352)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <aik@ozlabs.ru>) id 1dyr01-0006XE-PD
	for qemu-devel@nongnu.org; Sun, 01 Oct 2017 23:02:29 -0400
Received: by mail-pg0-x244.google.com with SMTP id o1so3203842pga.4
	for <qemu-devel@nongnu.org>; Sun, 01 Oct 2017 20:02:27 -0700 (PDT)
References: <150659494872.25889.2069124544245723984.stgit@aravinda>
	<150659505839.25889.2018054058894535368.stgit@aravinda>
	<20170929061735.GD7712@umbus.fritz.box>
	<87y3oxen7t.fsf@abhimanyu.i-did-not-set--mail-host-address--so-tickle-me>
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <95142cc0-518a-b7b7-4e56-cfc2adca36ba@ozlabs.ru>
Date: Mon, 2 Oct 2017 14:02:19 +1100
MIME-Version: 1.0
In-Reply-To: <87y3oxen7t.fsf@abhimanyu.i-did-not-set--mail-host-address--so-tickle-me>
Content-Type: text/plain; charset=utf-8
Content-Language: en-AU
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH v5 1/6] ppc: spapr: Register and
 handle HCALL to receive updated RTAS region
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>, David Gibson <david@gibson.dropbear.id.au>, Aravinda Prasad <aravinda@linux.vnet.ibm.com>
Cc: benh@au1.ibm.com, mahesh@linux.vnet.ibm.com, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, paulus@samba.org, sam.bobroff@au1.ibm.com
List-ID: <qemu-devel.nongnu.org>

On 29/09/17 21:52, Nikunj A Dadhania wrote:
> David Gibson <david@gibson.dropbear.id.au> writes:
> 
>> On Thu, Sep 28, 2017 at 04:07:38PM +0530, Aravinda Prasad wrote:
>>> Receive updates from SLOF about the updated rtas-base.
>>> A separate patch for SLOF [1] (commit f9a60de3) adds
>>> functionality to invoke a private HCALL whenever OS
>>> issues instantiate-rtas with a new rtas-base.
>>>
>>> This is required as QEMU needs to know the updated rtas-base
>>> as it allocates error reporting structure in RTAS space upon
>>> a machine check exception.
>>>
>>> [1] https://lists.ozlabs.org/pipermail/linuxppc-dev/2014-August/120386.html
>>>
>>> Signed-off-by: Aravinda Prasad <aravinda@linux.vnet.ibm.com>
>>> Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
>>
>> Ao I acked this earlier, but I've now realized there might be some
>> connection between this and discussions taking place elsewhere about
>> qemu not knowing what SLOF does with the device tree.
>>
>> At what point will SLOF call the UPDATE_RTAS hcall?  I'm guessing at
>> the time of instantiate-rtas, is that right?
> 
> The call happens from
> arch/powerpc/kernel/prom_init.c:prom_instantiate_rtas() and after that
> linux kernel makes two entries in the DT
> 
> ....
>        if (call_prom_ret("call-method", 3, 2, &entry,
>                           ADDR("instantiate-rtas"),
>                           rtas_inst, base) != 0
>             || entry == 0) {
>                 prom_printf(" failed\n");
>                 return;
>         }
>         prom_printf(" done\n");
> 
>         reserve_mem(base, size);
> 
>         val = cpu_to_be32(base);
>         prom_setprop(rtas_node, "/rtas", "linux,rtas-base",
>                      &val, sizeof(val));
>         val = cpu_to_be32(entry);
>         prom_setprop(rtas_node, "/rtas", "linux,rtas-entry",
>                      &val, sizeof(val));
> ....
> 
> Quiesce is called after this. 
> 
>> Does SLOF put the RTAS blob address in its internal device tree, or
>> does it only pass it to the guest via the return parameters from
>> instantiate-rtas?
> 
> Entry was made to the DT by linux kernel prom_init code, will this be
> visible to QEMU?

With my recent SLOF FDT patch - yes:

aik@fstn1-p1:~$ grep rtas dbg.dts
	rtas {
		linux,rtas-entry = <0x2fff0000>;
		linux,rtas-base = <0x2fff0000>;
[...]


-- 
Alexey
