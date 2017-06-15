Received: from eggs.gnu.org ([2001:4830:134:3::10]:45417)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1dLORC-0008RR-2i
	for qemu-devel@nongnu.org; Thu, 15 Jun 2017 02:39:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1dLOR9-0008MY-0t
	for qemu-devel@nongnu.org; Thu, 15 Jun 2017 02:39:26 -0400
Received: from 9.mo178.mail-out.ovh.net ([46.105.75.45]:56299)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1dLOR8-0008L4-Qr
	for qemu-devel@nongnu.org; Thu, 15 Jun 2017 02:39:22 -0400
Received: from player728.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo178.mail-out.ovh.net (Postfix) with ESMTP id 11AA83CF88
	for <qemu-devel@nongnu.org>; Thu, 15 Jun 2017 08:39:14 +0200 (CEST)
References: <149744692318.5507.14451686460325895979.stgit@bahia.lan>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <32c9b289-e151-0c7e-9519-8d729ef16367@kaod.org>
Date: Thu, 15 Jun 2017 08:39:01 +0200
MIME-Version: 1.0
In-Reply-To: <149744692318.5507.14451686460325895979.stgit@bahia.lan>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v5 0/3] spapr/xics: fix migration of older
 machine types
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org
Cc: Laurent Vivier <lvivier@redhat.com>, qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, Thomas Huth <thuth@redhat.com>

On 06/14/2017 03:28 PM, Greg Kurz wrote:
> Cc'ing Laurent because I needed to incorporate the "spapr: manage hotplugged
> devices while the VM is not started" patch in this series to be able to
> verify that the "CPU core unplug" part of patch 3 behaves as expected.
> 
> With this series, I could successfully do the following on POWER8 host with
> full cores:
>
> 1) start a pseries-2.9 machine with QEMU 2.9:
>         -smp cores=1,threads=2,maxcpus=8
> 
> 2) hotplug a core:
>     device_add host-spapr-cpu-core,core-id=4,id=core4
> 
> 3) migrate to QEMU 2.10 with core4 added (ie, started with same -smp as in
>    step 1 and same device_add as step 2):
> 
> 4) hotplug another core:
>     device_add host-spapr-cpu-core,core-id=2,id=core2
> 
> 5) migrate back to QEMU 2.9 with core4 and core2 added
> 
> 6) hotplug the core in the last available slot:
>     device_add host-spapr-cpu-core,core-id=6,id=core6
> 
> 7) migrate to QEMU 2.10 with core4, core2 and core6 added
> 
> The following step requires Laurent's patch, otherwise the guest complains
> about the non-existing DRC and fails to unplug the cores.
> 
> 8) unplug some cores:
>     device_del core4
>     device_del core2
> 
> 9) migrate back to QEMU 2.9 with core6 added

Thanks for the amount of time you have put into fixing this 
regression. That was complex and it required skill and patience.

It would be good to have some framework to test migration across
different QEMU versions. Does it exists ? I really don't know how 
feasible this is. I remember Thomas working on migration script
for kvm-unit-tests. That was quite promising. 

Cheers,

C. 


> 
> v5: - some patches from v4 got merged
>     - rebased and added Laurent's change to manage hotplugging of CPU
>       on the destination host (patch 1)
>     - see individual changelog for patches 2 and 3
> 
> v4: - some patches from v3 got merged
>     - added some more preparatory cleanup in xics (patches 1,2)
>     - merge cpu_setup() handler into realize() (patch 4)
>     - see individual changelog for patches 3 and 6
> 
> v3: - preparatory cleanup in pnv (patch 1)
>     - rework ICPState realization and vmstate registration (patches 2,3,4)
>     - fix migration using dummy icp/server entries (patch 5)
> 
> v2: - some patches from v1 are already merged in ppc-for-2.10
>     - added a new fix to a potential memory leak (patch 1)
>     - consolidate dt_id computation (patch 3)
>     - see individual changelogs for patch 2 and 4
> 
> Cheers.
> 
> --
> Greg
> 
> ---
> 
> Greg Kurz (2):
>       xics: directly register ICPState objects to vmstate
>       spapr: fix migration of ICPState objects from/to older QEMU
> 
> Laurent Vivier (1):
>       spapr: manage hotplugged devices while the VM is not started
> 
> 
>  hw/intc/xics.c         |    5 ++
>  hw/ppc/spapr.c         |  107 ++++++++++++++++++++++++++++++++++++++++++++----
>  include/hw/ppc/spapr.h |    1 
>  3 files changed, 104 insertions(+), 9 deletions(-)
> 
