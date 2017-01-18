Received: from eggs.gnu.org ([2001:4830:134:3::10]:60474)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1cTqZq-0004De-Ln
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 08:47:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1cTqZm-0003wj-Jp
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 08:47:02 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56246)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1cTqZm-0003wZ-AP
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 08:46:58 -0500
Date: Wed, 18 Jan 2017 14:46:53 +0100
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20170118144653.0d851927@nial.brq.redhat.com>
In-Reply-To: <1484743207-10721-1-git-send-email-douly.fnst@cn.fujitsu.com>
References: <1484743207-10721-1-git-send-email-douly.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 0/3] cpu: numa: Fix the mapping
 initialization of VCPUs and NUMA nodes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Dou Liyang <douly.fnst@cn.fujitsu.com>
Cc: ehabkost@redhat.com, qemu-devel@nongnu.org, peter.maydell@linaro.org, fanc.fnst@cn.fujitsu.com, caoj.fnst@cn.fujitsu.com, stefanha@redhat.com, izumi.taku@jp.fujitsu.com, vilanova@ac.upc.edu

On Wed, 18 Jan 2017 20:40:04 +0800
Dou Liyang <douly.fnst@cn.fujitsu.com> wrote:

> As we fixed a bug(Bug 1) in below links, Named "Method-A":
> 
> https://lists.nongnu.org/archive/html/qemu-devel/2017-01/msg03354.html
> 
> Then, Eduardo gave us many suggests. Thanks very much!
> when we try them, we also find another bugs named "Bug 2".
I have an alternative fix for both issues for which
I've been writing cover letter when I saw this series.

My fix series more intrusive though as it's goal isn't
just to fix 'info numa' but rather switch away from
cpu-index based mapping to socket/core/thread based mapping
and stop using bitmaps for mapping. And as 'info numa' was
getting in the way, I fixed both issues in a slightly
different way.

So pls wait a bit, once travis build is completed,
I'll post series here.

> [Problem]
> ---------
> 
> As I use this command:
> 
> ./x86_64-softmmu/qemu-system-x86_64 \
> 	-hda /image/fedora.img \
> 	-m 1G,slots=4,maxmem=4G \
> 	-enable-kvm \
> 	-smp 2,maxcpus=16,sockets=4,cores=2,threads=2 \
> 	-device qemu64-x86_64-cpu,id=cpu1,socket-id=0,core-id=1,thread-id=0 \
> 	-device qemu64-x86_64-cpu,id=cpu2,socket-id=0,core-id=1,thread-id=1 \
> 	-device qemu64-x86_64-cpu,id=cpu3,socket-id=1,core-id=0,thread-id=0 \
> 	-device qemu64-x86_64-cpu,id=cpu4,socket-id=1,core-id=0,thread-id=1 \
> 	-device qemu64-x86_64-cpu,id=cpu5,socket-id=1,core-id=1,thread-id=0 \
> 	-device qemu64-x86_64-cpu,id=cpu6,socket-id=1,core-id=1,thread-id=1 \
> 	-numa node,nodeid=0,cpus=0-3 \
> 	-numa node,nodeid=1,cpus=4-7 \
> 	-numa node,nodeid=2,cpus=8-11 \
> 	-numa node,nodeid=3,cpus=12-15 \
> 	-monitor stdio \
> 
> 1. Bug 1
> --------
> In Qemu monitor:
> 
> (qemu) info numa 
> 4 nodes
> node 0 cpus: 0 1 2 3 4 5 6 7
> node 0 size: 256 MB
> node 1 cpus:
> node 1 size: 256 MB
> node 2 cpus:
> node 2 size: 256 MB
> node 3 cpus:
> node 3 size: 256 MB
> 
> 2. Bug 2
> --------
> (qemu) device_add qemu64-x86_64-cpu,id=cpu7,socket-id=2,core-id=0,thread-id=0
> 
> (qemu) info numa
> 4 nodes
> node 0 cpus: 0 1 2 3 4 5 6 7 8
> node 0 size: 256 MB
> node 1 cpus:
> node 1 size: 256 MB
> node 2 cpus:
> node 2 size: 256 MB
> node 3 cpus:
> node 3 size: 256 MB
> 
> [Method-A]
> ----------
> 
> 1. Method-A that we provided above: 
>   * Ensure the numa_post_machine_init func in the appropriate location in
> vl.c::main().
> 
> It can fix Bug 1, but, can't work for Bug 2.
> 
> 1.1. For Bug 1: fixed
> 
> (qemu) info numa
> 4 nodes
> node 0 cpus: 0 1 2 3
> node 0 size: 256 MB
> node 1 cpus: 4 5 6 7
> node 1 size: 256 MB
> node 2 cpus:
> node 2 size: 256 MB
> node 3 cpus:
> node 3 size: 256 MB
> 
> 1.2. For Bug 2: can not fixed
> 
> (qemu) device_add qemu64-x86_64-cpu,id=cpu7,socket-id=2,core-id=0,thread-id=0
> 
> (qemu) info numa
> node 0 cpus: 0 1 2 3 8
> node 0 size: 256 MB
> node 1 cpus: 4 5 6 7
> node 1 size: 256 MB
> node 2 cpus:
> node 2 size: 256 MB
> node 3 cpus:
> node 3 size: 256 MB
> 
> [Solution]
> ----------
> 
> Move the CPUState::numa_node initialization to qom/cpu.c:cpu_common_realizefn(),
> and remove numa_post_machine_init() completely.
> 
> It can fix Bug 1 and Bug 2. The result shows that:
> 
> (qemu) info numa
> 4 nodes
> node 0 cpus: 0 1 2 3
> node 0 size: 256 MB
> node 1 cpus: 4 5 6 7
> node 1 size: 256 MB
> node 2 cpus:
> node 2 size: 256 MB
> node 3 cpus:
> node 3 size: 256 MB
> 
> (qemu) device_add qemu64-x86_64-cpu,id=cpu7,socket-id=2,core-id=0,thread-id=0
> (qemu) info numa
> 4 nodes
> node 0 cpus: 0 1 2 3
> node 0 size: 256 MB
> node 1 cpus: 4 5 6 7
> node 1 size: 256 MB
> node 2 cpus: 8
> node 2 size: 256 MB
> node 3 cpus:
> node 3 size: 256 MB
> 
> (qemu) device_add qemu64-x86_64-cpu,id=cpu8,socket-id=3,core-id=0,thread-id=0
> (qemu) info numa
> 4 nodes
> node 0 cpus: 0 1 2 3
> node 0 size: 256 MB
> node 1 cpus: 4 5 6 7
> node 1 size: 256 MB
> node 2 cpus: 8
> node 2 size: 256 MB
> node 3 cpus: 12
> node 3 size: 256 MB
> 
> (qemu) device_del cpu5
> (qemu) info numa
> 4 nodes
> node 0 cpus: 0 1 2 3
> node 0 size: 256 MB
> node 1 cpus: 4 5 7
> node 1 size: 256 MB
> node 2 cpus: 8
> node 2 size: 256 MB
> node 3 cpus: 12
> node 3 size: 256 MB
> 
> Dou Liyang (3):
>   cpu: Make the mapping of CPUs and NUMA nodes in cpu_common_realizefn
>   numa: Remove the numa_post_machine_init function
>   cpu: make the function of cpu_common_map_numa_node more efficiently
> 
>  include/sysemu/numa.h |  1 -
>  numa.c                | 15 ---------------
>  qom/cpu.c             | 16 ++++++++++++++++
>  vl.c                  |  2 --
>  4 files changed, 16 insertions(+), 18 deletions(-)
> 
