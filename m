Received: from eggs.gnu.org ([2001:4830:134:3::10]:41043)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1enmwq-0005Gf-Pw
	for qemu-devel@nongnu.org; Mon, 19 Feb 2018 10:01:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1enmwk-0003nJ-Rk
	for qemu-devel@nongnu.org; Mon, 19 Feb 2018 10:01:44 -0500
Date: Mon, 19 Feb 2018 16:01:18 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20180219160118.02f81264.cohuck@redhat.com>
In-Reply-To: <1518797321-28356-1-git-send-email-mihajlov@linux.vnet.ibm.com>
References: <1518797321-28356-1-git-send-email-mihajlov@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCHv5 0/5] add query-cpu-fast and related s390
 changes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Viktor Mihajlovski <mihajlov@linux.vnet.ibm.com>
Cc: qemu-devel@nongnu.org, agraf@suse.de, ehabkost@redhat.com, armbru@redhat.com, david@redhat.com, dgilbert@redhat.com, borntraeger@de.ibm.com, qemu-s390x@nongnu.org, pbonzini@redhat.com, rth@twiddle.net, eblake@redhat.com

On Fri, 16 Feb 2018 17:08:36 +0100
Viktor Mihajlovski <mihajlov@linux.vnet.ibm.com> wrote:

> v5 synopsis: Split out HMP changes from Patch 2 into Patch 5. Please
>    	     re-review, as I've removed the a-b/r-b from Patch 2
> 	     as well.

Series looks good to me. I'd be happy to take it through the s390 tree
with some a-bs/r-bs for patches 2 and 5, but have given some r-bs as
well in case someone else wants to take it.

> 
> This series consolidates patches around a performance issue
> caused by the usage of QMP query-cpus.
> 
> A performance issue was found in an OpenStack environment, where
> ceilometer was collecting domain statistics with libvirt. The domain
> statistics reported by libvirt include the vCPU halted state, which 
> in turn is retrieved with QMP query-cpus.
> 
> This causes two issues:
> 1. Performance: on most architectures query-cpus needs to issue a KVM ioctl
>    to find out whether a vCPU was halted. This is not the case for s390
>    but query-cpus is always causing the vCPU to exit the VM.
> 
> 2. Semantics: on x86 and other architectures, halted is a highly transient
>    state, which is likely to have already changed shortly after the state
>    information has been retrieved. This is not the case for s390, where
>    halted is an indication that the vCPU is stopped, meaning its not
>    available to the guest operating system until it has been restarted.
> 
> The following patches help to alleviate the issues:
> 
> Patch 1/5:
>   Adds architecture specific data to the QMP CpuInfo type, exposing
>   the existing s390 cpu-state in QMP. The cpu-state is a representation
>   more adequate than the ambiguous 'halted' condition.
> 
> Patch 2/5:
>   Adds a new QMP function query-cpus-fast, which will only retrieve
>   vCPU information that can be obtained without interrupting the
>   vCPUs of a running VM. It introduces a new return type CpuInfoFast
>   with the subset of fields meeting this condition. Specifically, the
>   halted state is not part of CpuInfoFast. QMP clients like libvirt
>   are encouraged to switch to the new API for vCPU information.
> 
> Patch 3/5:
>   Adds the s390-specific cpu state to CpuInfoFast, allowing management
>   apps to find out whether a vCPU is in the stopped state. This extension
>   leads to a partial duplication of field definitions from CpuInfo
>   to CpuInfoFast. This should be tolerable if CpuInfo is deprecated and
>   eventually removed.
> 
> Patch 4/5:
>   Starts the deprecation of query-cpus.
> 
> Patch 5/5 (NEW):
>   Changes HMP 'info cpus' to use query-cpus-fast. Was part of 2/5
>   initially.
> 
> Series v4 -> v5:
> Overall: Updated r-b's and moved HMP changes into a seperate patch.
> 
> Patch 1/5:
>   o Updated commit message to clarify why no HMP change
> 
> Patch 2/5:
>   o Split out HMP changes
>   o Removed r-b cohuck, a-b eblake
> 
> Series v3 -> v4:
> Overall: Instead of adding a new HMP 'info cpus_fast', changed
> 	 'info cpus' to use query-cpus-fast directly.
> 
> Patch 1/4:
>   o Don't report s390-specific data in HMP 'info cpus'
> 
> Patch 2/4:
>   o Change HMP 'info cpus' to use query-cpus-fast and
>     to return only basic information (no arch-specific data)
>   o Drop HMP 'info cpus_fast'
>   o Fixed typo in commit message
> 
> Patch 3/4:
>   o Drop HMP-related changes
> 
> Patch 4/4:
>   o Drop HMP-related changes
> 
> Series v2 -> v3:
> Overall: Added r-b's and a-b's.
> 
> Patch 2/4:
>   o Fixed commit message with respect to the halted field
>     disposition.
>   o Fixed grammar in qapi-schema documentation.
> 
> Patch 3/4:
>   o Use CpuInfoS390 type for both query-cpus and query-cpus-fast per
>     Eric Blake's comment.
>   o Dropped 'duplication blurb' from commit message as it doesn't
>     provide relevant information other than query-cpus should be
>     deprecated, which is done in the next patch now.
> 
> Series v1 -> v2:
> Patch 2/3:
>   o Changed formatting of hmp info cpus_fast to match that of
>     info cpus. This makes it easier for clients to switch to
>     the fast call.
> 
> Patch 3/3:
>   o Same formatting change for info cpus_fast as in 2/3, only
>     for s390-specific cpu state.
> 
> Luiz Capitulino (1):
>   qmp: add query-cpus-fast
> 
> Viktor Mihajlovski (4):
>   qmp: expose s390-specific CPU info
>   qmp: add architecture specific cpu data for query-cpus-fast
>   qemu-doc: deprecate query-cpus
>   hmp: change hmp_info_cpus to use query-cpus-fast
> 
>  cpus.c                     |  54 +++++++++++++++++++++
>  hmp.c                      |  41 +++-------------
>  hw/intc/s390_flic.c        |   4 +-
>  hw/s390x/s390-virtio-ccw.c |   2 +-
>  monitor.c                  |  13 +++--
>  qapi-schema.json           | 115 ++++++++++++++++++++++++++++++++++++++++++++-
>  qemu-doc.texi              |   4 ++
>  target/s390x/cpu.c         |  24 +++++-----
>  target/s390x/cpu.h         |   7 +--
>  target/s390x/kvm.c         |   8 ++--
>  target/s390x/sigp.c        |  38 +++++++--------
>  11 files changed, 228 insertions(+), 82 deletions(-)
> 
