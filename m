Received: from eggs.gnu.org ([2001:4830:134:3::10]:37940)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <danielhb@linux.vnet.ibm.com>) id 1dSV8p-0001Km-LT
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 17:13:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <danielhb@linux.vnet.ibm.com>) id 1dSV8l-00065r-2b
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 17:13:51 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:33418
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <danielhb@linux.vnet.ibm.com>)
	id 1dSV8k-00065L-SF
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 17:13:46 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v64L96MD146759
	for <qemu-devel@nongnu.org>; Tue, 4 Jul 2017 17:13:42 -0400
Received: from e24smtp05.br.ibm.com (e24smtp05.br.ibm.com [32.104.18.26])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2bg9tptqs0-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 04 Jul 2017 17:13:42 -0400
Received: from localhost
	by e24smtp05.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <danielhb@linux.vnet.ibm.com>;
	Tue, 4 Jul 2017 18:13:40 -0300
References: <20170621091848.28256-1-david@gibson.dropbear.id.au>
From: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
Date: Tue, 4 Jul 2017 18:13:31 -0300
MIME-Version: 1.0
In-Reply-To: <20170621091848.28256-1-david@gibson.dropbear.id.au>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Message-Id: <f89c6897-9555-100a-7252-a705fcbc8ee6@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH 0/5] spapr: DRC cleanups (part
 VI)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>, mdroth@linux.vnet.ibm.com
Cc: lvivier@redhat.com, sursingh@redhat.com, qemu-devel@nongnu.org, groug@kaod.org, qemu-ppc@nongnu.org, bharata@linux.vnet.ibm.com

I just tested this patch set on top of current ppc-for-2.10 branch 
(which contains
the patches from part V). It applied cleanly but required a couple of 
trivial
fixes to build probably because it was made on top of an older code base.

The trivial migration test worked fine. The libvirt scenario (attaching 
a device on
target before migration, try to unplug after migration) isn't working as 
expected
but we have a different result with this series. Instead of silently 
failing to unplug
with error messages on dmesg, the hot unplug works on QEMU level:

(qemu) device_del core1
(qemu)
(qemu) info cpus
* CPU #0: nip=0xc0000000000a3e0c thread_id=86162
(qemu) info hotpluggable-cpus
Hotpluggable CPUs:
   type: "host-spapr-cpu-core"
   vcpus_count: "1"
   CPUInstance Properties:
     core-id: "3"
   type: "host-spapr-cpu-core"
   vcpus_count: "1"
   CPUInstance Properties:
     core-id: "2"
   type: "host-spapr-cpu-core"
   vcpus_count: "1"
   CPUInstance Properties:
     core-id: "1"
   type: "host-spapr-cpu-core"
   vcpus_count: "1"
   qom_path: "/machine/unattached/device[0]"
   CPUInstance Properties:
     core-id: "0"
(qemu)


However, any operation on the guest afterwards (tried with lscpu and 
dmesg) seems
to hung the guest. This is what I got when trying to do a dmesg after the
hot unplug:

danielhb@ubuntu1704:~$
danielhb@ubuntu1704:~$
danielhb@ubuntu1704:~$ dmesg | tail -n 5
^C

[  362.749693] INFO: task kworker/u8:1:30 blocked for more than 120 seconds.
[  362.749819]       Not tainted 4.10.0-26-generic #30-Ubuntu
[  362.749892] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" 
disables this message.
[  362.750224] INFO: task kworker/0:3:1887 blocked for more than 120 
seconds.
[  362.750320]       Not tainted 4.10.0-26-generic #30-Ubuntu
[  362.750394] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" 
disables this message.
[  483.568842] INFO: task kworker/u8:1:30 blocked for more than 120 seconds.
[  483.568997]       Not tainted 4.10.0-26-generic #30-Ubuntu
[  483.569067] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" 
disables this message.
[  483.569364] INFO: task kworker/0:3:1887 blocked for more than 120 
seconds.
(...)


I am not sure if it was intended for this scenario to work with this 
patch set already. Figured
it can serve as a FYI for the next series.


Given that hotplug/unplug without migration still works and on the 
assumption that
we'll look more into this libvirt scenario in the next spins, +1.


Tested-by: Daniel Barboza <danielhb@linux.vnet.ibm.com>



On 06/21/2017 06:18 AM, David Gibson wrote:
> This sixth set of DRC cleanup patches (to be applied on top of the
> patches from part V) is a complete rework of DRC state management.  We
> stop tracking some unnecessary things, and change the basic state
> representation to a simpler and more robust model.
>
> Most of the patches in this set "break" migration from earlier git
> snapshots, but not from any released qemu version.  The previous
> migration stream format had multiple problems, so better to fix them
> now, before 2.10 is out.
>
> David Gibson (5):
>    spapr: Remove 'awaiting_allocation' DRC flag
>    spapr: Refactor spapr_drc_detach()
>    spapr: Cleanups relating to DRC awaiting_release field
>    spapr: Consolidate DRC state variables
>    spapr: Remove sPAPRConfigureConnectorState sub-structure
>
>   hw/ppc/spapr.c             |   9 +-
>   hw/ppc/spapr_drc.c         | 321 +++++++++++++++++++++------------------------
>   hw/ppc/spapr_pci.c         |  13 +-
>   hw/ppc/trace-events        |   3 +-
>   include/hw/ppc/spapr_drc.h |  53 +++++---
>   5 files changed, 187 insertions(+), 212 deletions(-)
>
