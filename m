Received: from eggs.gnu.org ([2001:4830:134:3::10]:51889)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1dDYkA-0007Tc-SQ
	for qemu-devel@nongnu.org; Wed, 24 May 2017 12:02:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1dDYk6-0005PN-SF
	for qemu-devel@nongnu.org; Wed, 24 May 2017 12:02:38 -0400
References: <20170523111812.13469-1-lvivier@redhat.com>
	<20170523111812.13469-4-lvivier@redhat.com>
	<20170524050754.GW30246@umbus.fritz.box>
	<20170524112857.31c3d8f9@bahia.ttt.fr.ibm.com>
	<20170524121402.50e62a75@nial.brq.redhat.com>
	<20170524175410.088f3285@bahia.ttt.fr.ibm.com>
From: Laurent Vivier <lvivier@redhat.com>
Message-ID: <33b6ab16-961b-2ba6-17b9-6667cd00a0fc@redhat.com>
Date: Wed, 24 May 2017 18:02:30 +0200
MIME-Version: 1.0
In-Reply-To: <20170524175410.088f3285@bahia.ttt.fr.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH 3/4] spapr: disable hotplugging
 without OS
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>, Igor Mammedov <imammedo@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

On 24/05/2017 17:54, Greg Kurz wrote:
> On Wed, 24 May 2017 12:14:02 +0200
> Igor Mammedov <imammedo@redhat.com> wrote:
> 
>> On Wed, 24 May 2017 11:28:57 +0200
>> Greg Kurz <groug@kaod.org> wrote:
>>
>>> On Wed, 24 May 2017 15:07:54 +1000
>>> David Gibson <david@gibson.dropbear.id.au> wrote:
>>>   
>>>> On Tue, May 23, 2017 at 01:18:11PM +0200, Laurent Vivier wrote:    
>>>>> If the OS is not started, QEMU sends an event to the OS
>>>>> that is lost and cannot be recovered. An unplug is not
>>>>> able to restore QEMU in a coherent state.
>>>>> So, while the OS is not started, disable CPU and memory hotplug.
>>>>> We use option vector 6 to know if the OS is started
>>>>>
>>>>> Signed-off-by: Laurent Vivier <lvivier@redhat.com>      
>>>>
>>>> Urgh.. I'm not terribly confident that this is really correct.  As
>>>> discussed on the previous patch, you're essentially using OV6 as a
>>>> flag that CAS is complete.
>>>>
>>>> But while it undoubtedly makes the race window much smaller, I don't
>>>> see that there's any guarantee the guest OS will really be able to
>>>> handle hotplug events immediately after CAS.
>>>>
>>>> In particular if the CAS process completes partially but then needs to
>>>> trigger a reboot, I think that would end up setting the ov6 variable,
>>>> but the OS would definitely not be in a state to accept events.  
>> wouldn't guest on reboot pick up updated fdt and online hotplugged
>> before crash cpu along with initial cpus?
>>
> 
> Yes and that's what actually happens with cpus.
> 
> But catching up with the background for this series, I have the
> impression that the issue isn't the fact we loose an event if the OS
> isn't started (which is not true), but more something wrong happening
> when hotplugging+unplugging memory as described in this commit:
> 
> commit fe6824d12642b005c69123ecf8631f9b13553f8b
> Author: Laurent Vivier <lvivier@redhat.com>
> Date:   Tue Mar 28 14:09:34 2017 +0200
> 
>     spapr: fix memory hot-unplugging
> 

Yes, this commit try to fix that, but it's not possible. Some objects
remain in memory: you can see with "info cpus" or "info memory-devices"
that they are not really removed, and this prevents to hotplug them
again, and moreover in the case of the memory hot-unplug we can rerun
the device_del and crash qemu (as before the fix).

Moreover all stuff normally cleared in detach() are not, and we can't do
it later in set_allocation_state() because some are in use by the
kernel, and this is the last call from the kernel.

Laurent
