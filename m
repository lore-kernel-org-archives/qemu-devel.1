Received: from eggs.gnu.org ([2001:4830:134:3::10]:55493)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1dLYIR-0007XO-Hz
	for qemu-devel@nongnu.org; Thu, 15 Jun 2017 13:11:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1dLYIO-00048d-9Z
	for qemu-devel@nongnu.org; Thu, 15 Jun 2017 13:11:03 -0400
References: <20170608050930.2613-1-david@gibson.dropbear.id.au>
From: Laurent Vivier <lvivier@redhat.com>
Message-ID: <4f1e9592-566f-b558-91e8-e39ac8691455@redhat.com>
Date: Thu, 15 Jun 2017 19:10:55 +0200
MIME-Version: 1.0
In-Reply-To: <20170608050930.2613-1-david@gibson.dropbear.id.au>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 0/6] spapr: DRC cleanups (part IV)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>, mdroth@linux.vnet.ibm.com
Cc: sursingh@redhat.com, qemu-devel@nongnu.org, groug@kaod.org, qemu-ppc@nongnu.org, bharata@linux.vnet.ibm.com

On 08/06/2017 07:09, David Gibson wrote:
> This fourth isntallment of cleanups to the DRC code introduces the
> first changes to the fundamental state handling.  We change the
> initial states in the reset code and attach code for PCI devices, and
> are able to remove the 'signalled' state variable with those fixes.
> 
> There are also some more mechanical cleanups in preparation for
> further cleanups and fixes to the state management.
> 
> David Gibson (6):
>   spapr: Start hotplugged PCI devices in ISOLATED state
>   spapr: Eliminate DRC 'signalled' state variable
>   spapr: Split DRC release from DRC detach
>   spapr: Make DRC reset force DRC into known state
>   spapr: Clean up DRC set_allocation_state path
>   spapr: Clean up DRC set_isolation_state() path
> 
>  hw/ppc/spapr.c             |  15 --
>  hw/ppc/spapr_drc.c         | 363 +++++++++++++++++++++++----------------------
>  hw/ppc/spapr_events.c      |  10 --
>  include/hw/ppc/spapr_drc.h |  10 +-
>  4 files changed, 188 insertions(+), 210 deletions(-)
> 

I've tested your series rebased on master.

- plugging a CPU while the OS is not started (stopped in SLOF/GRUB):

    The cpu can be hotplugged, but once the OS is started, the OS
    doesn't detect it and it can't be unplugged.

- plugging a memory DIMM while the OS is not started:

    The first device_del does nothing, the second one crashes qemu

- migration with hotplugged cpu (with OS started):

     CPU cannot be unplugged on destination side

- migration with hotplugged memory DIMM (with OS started):

     The first device_del does nothing, the second one crashes qemu

As it's cleanup, I guess this is what is expected
(the results are the same as before cleanup series).

Laurent
