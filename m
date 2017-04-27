Received: from eggs.gnu.org ([2001:4830:134:3::10]:46905)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1d3lyu-0002Dg-GP
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 12:09:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1d3lyr-0005ez-R0
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 12:09:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44208)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1d3lyr-0005eD-FG
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 12:09:21 -0400
Date: Thu, 27 Apr 2017 13:09:16 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170427160916.GD3482@thinpad.lan.raisama.net>
References: <20170427101259.13798-1-lvivier@redhat.com>
	<20170427101259.13798-2-lvivier@redhat.com>
	<20170427140941.GC3482@thinpad.lan.raisama.net>
	<5f64d784-178b-9b10-68ed-51158a1af334@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5f64d784-178b-9b10-68ed-51158a1af334@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 1/2] numa: introduce
 numa_auto_assign_ram() function in MachineClass
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <lvivier@redhat.com>
Cc: David Gibson <david@gibson.dropbear.id.au>, Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org

On Thu, Apr 27, 2017 at 05:09:26PM +0200, Laurent Vivier wrote:
> On 27/04/2017 16:09, Eduardo Habkost wrote:
> > On Thu, Apr 27, 2017 at 12:12:58PM +0200, Laurent Vivier wrote:
> >> We need to change the way we distribute the memory across
> >> the nodes. To keep compatibility between machine type version
> >> introduce a  machine type dependent function.
> >>
> >> Signed-off-by: Laurent Vivier <lvivier@redhat.com>
> > [...]
> >> +static void numa_auto_assign_ram(MachineClass *mc, NodeInfo *nodes,
> >> +                                 int nb_nodes, ram_addr_t size)
> >> +{
> >> +    int i;
> >> +    uint64_t usedmem = 0;
> >> +
> >> +    if (mc->numa_auto_assign_ram) {
> >> +        uint64_t *mem = g_new(uint64_t, nb_nodes);
> >> +
> >> +        mc->numa_auto_assign_ram(mem, nb_nodes, size);
> >> +
> >> +        for (i = 0; i < nb_nodes; i++) {
> >> +            nodes[i].node_mem = mem[i];
> >> +        }
> >> +
> >> +        g_free(mem);
> >> +
> >> +        return;
> >> +    }
> >> +
> >> +    /* Align each node according to the alignment
> >> +     * requirements of the machine class
> >> +     */
> >> +
> >> +    for (i = 0; i < nb_nodes - 1; i++) {
> >> +        nodes[i].node_mem = (size / nb_nodes) &
> >> +                            ~((1 << mc->numa_mem_align_shift) - 1);
> >> +        usedmem += nodes[i].node_mem;
> >> +    }
> >> +    nodes[i].node_mem = size - usedmem;
> >> +}
> > 
> > I would prefer to make your new algorithm the default, and move
> > this code to a legacy_auto_assign_ram() function set by the 2.9
> > machine-types.
> 
> I think it's easier to do as I've done because otherwise, we need:
> 
> - to add the numa_mem_align_shift to the parameters list of the
>   numa_auto_assign_ram() function.

You can take MachineClass or MachineState as paramter.

> 
> - set the function by default to numa_auto_assign_ram in
>   hw/core/machine.c:machine_class_init()

Yep.

> 
> - set the pointer to NULL in 2.10 pseries machine type,

Won't pseries-2.10 have the same behavior as all other machines
except pc/pseries <= 2.9? pseries-2.10 and pc-2.10 would just
reuse the default value set by machine_class_init().

> 
> - export the function to re-set the legacy function in the 2.9 pseries
>   machine type definition.

Well, this is the part where I agree it's too much hassle.  :)

> 
> So, we need to add one argument to the function, export the function to
> use it from machine.c and at least spapr.c, to set the function in
> machine_class_init() and spapr_machine_2_9_class_options() (as we clear
> it in 2.10 function).
> 
> I can do that, but is this what you want?

I don't have a strong opinion. If you believe your way is
simpler, we can keep it.

-- 
Eduardo
