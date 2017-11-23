Received: from eggs.gnu.org ([2001:4830:134:3::10]:42015)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1eHu20-0005PF-Nc
	for qemu-devel@nongnu.org; Thu, 23 Nov 2017 11:07:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1eHu1x-0003p7-Mi
	for qemu-devel@nongnu.org; Thu, 23 Nov 2017 11:07:16 -0500
Received: from 3.mo3.mail-out.ovh.net ([46.105.44.175]:53766)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1eHu1x-0003nh-Ed
	for qemu-devel@nongnu.org; Thu, 23 Nov 2017 11:07:13 -0500
Received: from player797.ha.ovh.net (gw6.ovh.net [213.251.189.206])
	by mo3.mail-out.ovh.net (Postfix) with ESMTP id 9E6B8175B25
	for <qemu-devel@nongnu.org>; Thu, 23 Nov 2017 17:07:11 +0100 (CET)
References: <20171120032420.9134-1-mdavidsaver@gmail.com>
	<20171120032420.9134-2-mdavidsaver@gmail.com>
	<20171122032852.GG2380@umbus.fritz.box>
	<791a1520-6f3b-f380-3029-a89cdd0fbff6@gmail.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <1535252e-ae96-99fa-d5be-7e53750124ce@kaod.org>
Date: Thu, 23 Nov 2017 17:07:04 +0100
MIME-Version: 1.0
In-Reply-To: <791a1520-6f3b-f380-3029-a89cdd0fbff6@gmail.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH 01/12] e500: add board config
 options
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Davidsaver <mdavidsaver@gmail.com>, David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org

On 11/22/2017 06:55 PM, Michael Davidsaver wrote:
> On 11/21/2017 09:28 PM, David Gibson wrote:
>> On Sun, Nov 19, 2017 at 09:24:09PM -0600, Michael Davidsaver wrote:
>>> allow board code to skip common NIC and guest image setup
>>> and configure decrementor frequency.
>>> Existing boards unchanged.
>>>
>>> Signed-off-by: Michael Davidsaver <mdavidsaver@gmail.com>
>>
>> So, it's spelled "decrementer".
>>
>> Other than that, the patch looks correct.  However having a big common
>> function for overall init with a pile of ad-hoc configuration
>> parameters is usually not a great way to go.  I think what we want
>> instead is to eliminate ppce500_init(), instead doing the setup logic
>> separately in each of the e500 machines.   The large common slabs of
>> code can be helpers in e500.c, but the overall logic - including most
>> of the things controlled by the current params - would be under the
>> individual machine's control.
> 
> I agree that ppce500_init() is unwieldy, and am willing to spend some
> time on cleanup.  I'm just not sure what to do.
> 
> I can see moving initialization of at least the serial, i2c, gpio, and
> possibly MPIC and PCI host bridge into the e500-ccsr class.

each of these controllers should have a QOM model possibly.

I think that the part above : 

	    /* Load kernel. */

is machine specific and the part below is generic and could be called 
from each machine init routine. You would still need some op/struct for 
the device tree.

> I'm not sure what to do with all the device tree construction code in
> e500.c, which has a bunch of hard coded register offsets.  A comment
> here summarizes the problem nicely.
> 
>> /* TODO: parameterize */
>> #define MPC8544_CCSRBAR_SIZE       0x00100000ULL
>> #define MPC8544_MPIC_REGS_OFFSET   0x40000ULL
> 
> It seems desirable to avoid having these offsets appear in two different
> files, which could allow them to get out of sync.
> 
> I had the idea of using an Interface to split up device tree
> construction, and was encouraged to find PnvXScomInterfaceClass which
> seems be a way of combining device tree construction in a device class.
> Is this the way to go?

yes. You would need to QOM'ify the whole machine and have all controllers
be children of a 'board' object to loop on them.

> Some guidance would be appreciated.

The models of the ARM SoC are good examples to follow. You could check 
the Aspeed machines which have been slowly growing and which have had 
some good reviews from Peter. The ARM machines are all QOM'ified and 
that might be difficult to apply to the e500 boards quickly. At least, 
the models for the new controllers should follow QOM. It will ease the 
future work.      

Thanks,

C. 

> 
> Michael
> 
> 
>>> ---
>>>  hw/ppc/e500.c      | 8 ++++++--
>>>  hw/ppc/e500.h      | 3 +++
>>>  hw/ppc/e500plat.c  | 1 +
>>>  hw/ppc/mpc8544ds.c | 1 +
>>>  4 files changed, 11 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/hw/ppc/e500.c b/hw/ppc/e500.c
>>> index 5cf0dabef3..9e7e1b29c4 100644
>>> --- a/hw/ppc/e500.c
>>> +++ b/hw/ppc/e500.c
>>> @@ -826,7 +826,7 @@ void ppce500_init(MachineState *machine, PPCE500Params *params)
>>>          env->mpic_iack = params->ccsrbar_base +
>>>                           MPC8544_MPIC_REGS_OFFSET + 0xa0;
>>>  
>>> -        ppc_booke_timers_init(cpu, 400000000, PPC_TIMER_E500);
>>> +        ppc_booke_timers_init(cpu, params->decrementor_freq, PPC_TIMER_E500);
>>>  
>>>          /* Register reset handler */
>>>          if (!i) {
>>> @@ -899,7 +899,7 @@ void ppce500_init(MachineState *machine, PPCE500Params *params)
>>>      if (!pci_bus)
>>>          printf("couldn't create PCI controller!\n");
>>>  
>>> -    if (pci_bus) {
>>> +    if (pci_bus && !params->tsec_nic) {
>>>          /* Register network interfaces. */
>>>          for (i = 0; i < nb_nics; i++) {
>>>              pci_nic_init_nofail(&nd_table[i], pci_bus, "virtio", NULL);
>>> @@ -948,6 +948,10 @@ void ppce500_init(MachineState *machine, PPCE500Params *params)
>>>                                      sysbus_mmio_get_region(s, 0));
>>>      }
>>>  
>>> +    if (params->skip_load) {
>>> +        return;
>>> +    }
>>> +
>>>      /* Load kernel. */
>>>      if (machine->kernel_filename) {
>>>          kernel_base = cur_base;
>>> diff --git a/hw/ppc/e500.h b/hw/ppc/e500.h
>>> index 70ba1d8f4f..40f72f2de2 100644
>>> --- a/hw/ppc/e500.h
>>> +++ b/hw/ppc/e500.h
>>> @@ -22,6 +22,9 @@ typedef struct PPCE500Params {
>>>      hwaddr pci_mmio_base;
>>>      hwaddr pci_mmio_bus_base;
>>>      hwaddr spin_base;
>>> +    uint32_t decrementor_freq; /* in Hz */
>>> +    bool skip_load;
>>> +    bool tsec_nic;
>>>  } PPCE500Params;
>>>  
>>>  void ppce500_init(MachineState *machine, PPCE500Params *params);
>>> diff --git a/hw/ppc/e500plat.c b/hw/ppc/e500plat.c
>>> index e59e80fb9e..3d07987bd1 100644
>>> --- a/hw/ppc/e500plat.c
>>> +++ b/hw/ppc/e500plat.c
>>> @@ -47,6 +47,7 @@ static void e500plat_init(MachineState *machine)
>>>          .pci_mmio_base = 0xC00000000ULL,
>>>          .pci_mmio_bus_base = 0xE0000000ULL,
>>>          .spin_base = 0xFEF000000ULL,
>>> +        .decrementor_freq = 400000000,
>>>      };
>>>  
>>>      /* Older KVM versions don't support EPR which breaks guests when we announce
>>> diff --git a/hw/ppc/mpc8544ds.c b/hw/ppc/mpc8544ds.c
>>> index 1717953ec7..6d9931c475 100644
>>> --- a/hw/ppc/mpc8544ds.c
>>> +++ b/hw/ppc/mpc8544ds.c
>>> @@ -40,6 +40,7 @@ static void mpc8544ds_init(MachineState *machine)
>>>          .pci_mmio_bus_base = 0xC0000000ULL,
>>>          .pci_pio_base = 0xE1000000ULL,
>>>          .spin_base = 0xEF000000ULL,
>>> +        .decrementor_freq = 400000000,
>>>      };
>>>  
>>>      if (machine->ram_size > 0xc0000000) {
>>
> 
> 
