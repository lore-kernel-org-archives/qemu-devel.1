Received: from eggs.gnu.org ([2001:4830:134:3::10]:54208)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <danielhb@linux.vnet.ibm.com>) id 1dDDzV-00015k-K7
	for qemu-devel@nongnu.org; Tue, 23 May 2017 13:53:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <danielhb@linux.vnet.ibm.com>) id 1dDDzQ-0000Qu-O4
	for qemu-devel@nongnu.org; Tue, 23 May 2017 13:53:05 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:38215
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <danielhb@linux.vnet.ibm.com>)
	id 1dDDzQ-0000QZ-Hk
	for qemu-devel@nongnu.org; Tue, 23 May 2017 13:53:00 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v4NHnA9a056314
	for <qemu-devel@nongnu.org>; Tue, 23 May 2017 13:52:59 -0400
Received: from e24smtp04.br.ibm.com (e24smtp04.br.ibm.com [32.104.18.25])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2amreh4f4w-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 23 May 2017 13:52:59 -0400
Received: from localhost
	by e24smtp04.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <danielhb@linux.vnet.ibm.com>;
	Tue, 23 May 2017 14:52:57 -0300
References: <20170523111812.13469-1-lvivier@redhat.com>
From: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
Date: Tue, 23 May 2017 14:52:54 -0300
MIME-Version: 1.0
In-Reply-To: <20170523111812.13469-1-lvivier@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Message-Id: <7509d665-566e-2570-9936-44a04bad75fe@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH 0/4] spapr: disable hotplugging
 without OS
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <lvivier@redhat.com>, David Gibson <david@gibson.dropbear.id.au>
Cc: Thomas Huth <thuth@redhat.com>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Michael Roth <mdroth@linux.vnet.ibm.com>

Hi Laurent,

This is an interesting patch series. I've been working in the last weeks 
in the DRC
migration, mainly to solve the problem in which a hot CPU unplug will 
not succeed after
a migration if the CPU was hotplugged in the source. The problem 
happened when
migrating with virsh because Libvirt hotplugs the CPU in both source and 
target, and
the DRC state of the hotplugged after the migration is inconsistent. 
This series solves the
issue by preventing it from happening in the first place. Of course that 
migrating DRC states
has other uses (pending unplug operations during a migration, for 
example) so both patch
series can coexist.

One possible issue I see with this series is that it breaks Libvirt 
migration entirely if
a CPU/mem hotplug happens in the target. With your series applied the 
migration
fails before start with:


# ./virsh -c 'qemu:///system' migrate --live --domain dhb_ub1704_nfs 
--desturi qemu+ssh://target_ip/system --timeout 60 --verbose
error: internal error: unable to execute QEMU command 'device_add': CPU 
hotplug not supported without OS

Note that I say "possible issue" because, although I believe we do not 
want to break Libvirt
if possible, I also believe that we need to think about what makes sense 
in QEMU first.



Thanks,


Daniel


On 05/23/2017 08:18 AM, Laurent Vivier wrote:
> If the OS is not started, QEMU sends an event to the OS
> that is lost and cannot be recovered. An unplug is not
> able to restore QEMU in a coherent state.
> So, while the OS is not started, disable CPU and memory hotplug.
> We use option vector 6 to know if the OS is started
>
> This series moves error checking for memory hotplug
> in a pre_plug function, and introduces the option
> vector 6 management. It also revert previous
> fix which was not really fixing the hotplug problem
> when the OS is not running.
>
> Laurent Vivier (4):
>    spapr: add pre_plug function for memory
>    spapr: add option vector 6
>    spapr: disable hotplugging without OS
>    Revert "spapr: fix memory hot-unplugging"
>
>   hw/ppc/spapr.c              | 103 ++++++++++++++++++++++++++++++++++++--------
>   hw/ppc/spapr_drc.c          |  20 ++-------
>   hw/ppc/spapr_hcall.c        |   5 ++-
>   hw/ppc/spapr_ovec.c         |   8 ++++
>   include/hw/ppc/spapr.h      |   2 +
>   include/hw/ppc/spapr_drc.h  |   1 -
>   include/hw/ppc/spapr_ovec.h |   7 +++
>   7 files changed, 109 insertions(+), 37 deletions(-)
>
