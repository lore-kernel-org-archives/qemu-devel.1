Received: from eggs.gnu.org ([2001:4830:134:3::10]:48468)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1dvH7T-0003xo-86
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 02:07:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1dvH7O-0006SD-9r
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 02:07:23 -0400
Received: from 8.mo179.mail-out.ovh.net ([46.105.75.26]:37083)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1dvH7N-0006RT-Vs
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 02:07:18 -0400
Received: from player690.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo179.mail-out.ovh.net (Postfix) with ESMTP id 42C6162804
	for <qemu-devel@nongnu.org>; Fri, 22 Sep 2017 08:07:15 +0200 (CEST)
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
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <e2ad1b05-0e93-5389-92b5-7d9ebdd273f8@kaod.org>
Date: Fri, 22 Sep 2017 08:07:06 +0200
MIME-Version: 1.0
In-Reply-To: <87y3p7nugc.fsf@abhimanyu.i-did-not-set--mail-host-address--so-tickle-me>
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

On 09/22/2017 08:00 AM, Nikunj A Dadhania wrote:
> David Gibson <david@gibson.dropbear.id.au> writes:
> 
>>>>>
>>>>> As smp_thread defaults to 1 in vl.c, similarly smp_cores also has the
>>>>> default value of 1 in vl.c. In powernv, we were setting nr-cores like
>>>>> this:
>>>>>
>>>>>         object_property_set_int(chip, smp_cores, "nr-cores", &error_fatal);
>>>>>
>>>>> Even when there were multiple cpus (-smp 4), when the guest boots up, we
>>>>> just get one core (i.e. smp_cores was 1) with single thread(smp_threads
>>>>> was 1), which is wrong as per the command-line that was provided.
>>>>
>>>> Right, so, -smp 4 defaults to 4 sockets, each with 1 core of 1
>>>> thread.  If you can't supply 4 sockets you should error, but you
>>>> shouldn't go and change the number of cores per socket.
>>>
>>> OK, that makes sense now. And I do see that smp_cpus is 4 in the above
>>> case. Now looking more into it, i see that powernv has something called
>>> "num_chips", isnt this same as sockets ? Do we need num_chips separately?
>>
>> Ah, yes, I see.  It's probably still reasonable to keep num_chips as
>> an internal variable, rather than using (smp_cpus / smp_cores /
>> smp_threads) everywhere.  But we shouldn't have it as a direct
>> user-settable property, instead setting it from the -smp command line
>> option.
> 
> Something like the below works till num_chips=2, after that guest does
> not boot up. This might be some limitation within the OS, Cedric might
> have some clue.

Some controllers might need some more tweaking, PSI, LPC, to elect a 
master one. Anyhow I don't think we want to deduce the number of chips
from the number of cpus. These two figures are very different.

C.

> Otherwise, I see that multiple chips are created with single core having 
> single thread.
>
>     ppc/pnv: Use num_chips for multiple sockets
>     
>     When the user does not provide the cpu topology, e.g. "-smp 4", machine fails to
>     initialize 4 cpus. QEMU assumes smp_threads and smp_cores both as 1. Make sure
>     that we initialize multiple chips for this.
>     
>     Remove the user-settable property num_chips from machine command line option
>     
>     Signed-off-by: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
> 
> diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
> index 9724719..fa501f9 100644
> --- a/hw/ppc/pnv.c
> +++ b/hw/ppc/pnv.c
> @@ -709,7 +709,17 @@ static void ppc_powernv_init(MachineState *machine)
>          exit(1);
>      }
>  
> +    pnv->num_chips = smp_cpus / (smp_cores * smp_threads);
>      pnv->chips = g_new0(PnvChip *, pnv->num_chips);
> +
> +    if (smp_cpus != (smp_threads * pnv->num_chips * smp_cores)) {
> +        error_report("cpu topology not balanced: "
> +                     "chips (%u) * cores (%u) * threads (%u) != "
> +                     "number of cpus (%u)",
> +                     pnv->num_chips, smp_cores, smp_threads, smp_cpus);
> +        exit(1);
> +    }
> +
>      for (i = 0; i < pnv->num_chips; i++) {
>          char chip_name[32];
>          Object *chip = object_new(chip_typename);
> @@ -1255,53 +1265,12 @@ static void pnv_pic_print_info(InterruptStatsProvider *obj,
>      }
>  }
>  
> -static void pnv_get_num_chips(Object *obj, Visitor *v, const char *name,
> -                              void *opaque, Error **errp)
> -{
> -    visit_type_uint32(v, name, &POWERNV_MACHINE(obj)->num_chips, errp);
> -}
> -
> -static void pnv_set_num_chips(Object *obj, Visitor *v, const char *name,
> -                              void *opaque, Error **errp)
> -{
> -    PnvMachineState *pnv = POWERNV_MACHINE(obj);
> -    uint32_t num_chips;
> -    Error *local_err = NULL;
> -
> -    visit_type_uint32(v, name, &num_chips, &local_err);
> -    if (local_err) {
> -        error_propagate(errp, local_err);
> -        return;
> -    }
> -
> -    /*
> -     * TODO: should we decide on how many chips we can create based
> -     * on #cores and Venice vs. Murano vs. Naples chip type etc...,
> -     */
> -    if (!is_power_of_2(num_chips) || num_chips > 4) {
> -        error_setg(errp, "invalid number of chips: '%d'", num_chips);
> -        return;
> -    }
> -
> -    pnv->num_chips = num_chips;
> -}
> -
>  static void powernv_machine_initfn(Object *obj)
>  {
>      PnvMachineState *pnv = POWERNV_MACHINE(obj);
>      pnv->num_chips = 1;
>  }
>  
> -static void powernv_machine_class_props_init(ObjectClass *oc)
> -{
> -    object_class_property_add(oc, "num-chips", "uint32",
> -                              pnv_get_num_chips, pnv_set_num_chips,
> -                              NULL, NULL, NULL);
> -    object_class_property_set_description(oc, "num-chips",
> -                              "Specifies the number of processor chips",
> -                              NULL);
> -}
> -
>  static void powernv_machine_class_init(ObjectClass *oc, void *data)
>  {
>      MachineClass *mc = MACHINE_CLASS(oc);
> @@ -1321,8 +1290,6 @@ static void powernv_machine_class_init(ObjectClass *oc, void *data)
>      xic->ics_get = pnv_ics_get;
>      xic->ics_resend = pnv_ics_resend;
>      ispc->print_info = pnv_pic_print_info;
> -
> -    powernv_machine_class_props_init(oc);
>  }
>  
>  static const TypeInfo powernv_machine_info = {
> 
