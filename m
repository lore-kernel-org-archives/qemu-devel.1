Received: from eggs.gnu.org ([2001:4830:134:3::10]:60923)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1fiawd-0004jN-9X
	for qemu-devel@nongnu.org; Thu, 26 Jul 2018 03:44:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1fiawa-0002wd-BE
	for qemu-devel@nongnu.org; Thu, 26 Jul 2018 03:44:19 -0400
References: <20180504042044.10318-1-mdroth@linux.vnet.ibm.com>
	<20180726050746.GC12001@umbus.fritz.box>
From: Laurent Vivier <lvivier@redhat.com>
Message-ID: <c23b3b10-a73b-24c8-36c5-114933d9b41b@redhat.com>
Date: Thu, 26 Jul 2018 09:44:11 +0200
MIME-Version: 1.0
In-Reply-To: <20180726050746.GC12001@umbus.fritz.box>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] target/ppc: only save guest timebase once
 after stopping
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>, Michael Roth <mdroth@linux.vnet.ibm.com>
Cc: qemu-devel@nongnu.org, Alexey Kardashevskiy <aik@ozlabs.ru>, qemu-ppc@nongnu.org, qemu-stable@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>

On 26/07/2018 07:07, David Gibson wrote:
> On Thu, May 03, 2018 at 11:20:44PM -0500, Michael Roth wrote:
>> In some cases (e.g. spapr) we record guest timebase after qmp_stop()
>> via a runstate hook so we can restore it on qmp_cont(). If a migration
>> occurs in between those events we end up saving it again, this time
>> based on the current timebase the guest would be seeing had it been
>> running. This has the effect of advancing the guest timebase while
>> it is stopped, which is not what the code intends.
>>
>> Other than simple jumps in time, this has been seen to trigger what
>> appear to be RCU-related crashes in recent kernels when the advance
>> exceeds rcu_cpu_stall_timeout, and it can be triggered by fairly
>> common operations such as `virsh migrate ... --timeout 60`.
>>
>> Cc: Alexey Kardashevskiy <aik@ozlabs.ru>
>> Cc: David Gibson <david@gibson.dropbear.id.au>
>> Cc: Laurent Vivier <lvivier@redhat.com>
>> Cc: qemu-ppc@nongnu.org
>> Cc: qemu-stable@nongnu.org
>> Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
> 
> Sorry, this fell off my radar for ages, but I've finally had a chance
> to look at it properly.
> 
> I'm not totally convinced this handle all the possible edge cases
> correctly, but I am convinced it gives behaviour that's more correct
> than we have now.  It doesn't introduce changes to the interface or
> migration stream that would break things in future, so I've applied it
> to ppc-for-3.1.

See https://bugzilla.redhat.com/show_bug.cgi?id=1571230#c8

So you revert:

commit 42043e4f1241eeb77f87f5816b5cf0b6e9583ed7
Author: Laurent Vivier <lvivier@redhat.com>
Date:   Fri Jan 27 13:24:58 2017 +0100

    spapr: clock should count only if vm is running

and change the behaviour compared to x86_64

     6053a86 kvmclock: reduce kvmclock difference on migration

Is this what you want?

Thanks,
Laurent
