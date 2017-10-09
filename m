Received: from eggs.gnu.org ([2001:4830:134:3::10]:59840)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1e1ZEq-0005Ti-RG
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 10:41:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1e1ZEo-0007Vs-86
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 10:41:00 -0400
Received: from mail-wm0-f53.google.com ([74.125.82.53]:44626)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1e1ZEo-0007VG-1r
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 10:40:58 -0400
Received: by mail-wm0-f53.google.com with SMTP id 196so11845338wma.1
	for <qemu-devel@nongnu.org>; Mon, 09 Oct 2017 07:40:57 -0700 (PDT)
References: <20171006215244.27104-1-ehabkost@redhat.com>
	<20171006215244.27104-8-ehabkost@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <0484ea3f-4ba7-4b93-e976-098c5717166e@redhat.com>
Date: Mon, 9 Oct 2017 16:40:55 +0200
MIME-Version: 1.0
In-Reply-To: <20171006215244.27104-8-ehabkost@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 7/7] target/i386: Enable kvm_pv_unhalt by
 default
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org
Cc: Igor Mammedov <imammedo@redhat.com>, Alexander Graf <agraf@suse.de>, "Michael S. Tsirkin" <mst@redhat.com>

On 06/10/2017 23:52, Eduardo Habkost wrote:
>   Commit f010bc643a (target-i386: add feature kvm_pv_unhalt) introduced the
>   kvm_pv_unhalt feature but didn't enable it by default.
> 
>   Without kvm_pv_unhalt we see a measurable degradation in scheduling
>   performance, so enabling it by default does make sense IMHO. This patch
>   just flips it to default to on by default.
> 
>     [With kvm_pv_unhalt disabled]
>     $ perf bench sched messaging -l 10000
>       Total time: 8.573 [sec]
> 
>     [With kvm_pv_unhalt enabled]
>     $ perf bench sched messaging -l 10000
>       Total time: 4.416 [sec]

I cannot reproduce this:

Host CPU model: Haswell-EP (Xeon E5-2697 v3 @ 2.60 GHz)
Host physical CPUs: 56 (2 sockets 14 cores/sockets, 2 thread/core)
Host Linux kernel: 4.14 (more or less :))
Host memory: 64 GB
Guest Linux kernel: 4.10.13

QEMU command line:

/usr/libexec/qemu-kvm -cpu host,+kvm_pv_unhalt -M q35 \
   -m XXX -smp YYY \
   /path/to/vm.qcow2

(XXX = MiB of guest memory, YYY = number of guest processors)

"perf bench sched messaging -l 50000" has the following result for me:

Guest vCPUs    Guest memory     without PV unhalt      with PV unhalt
1*96           32 GB            24.6 s                 24.2 s
2*96           24 GB            47.9 s (both VMs)      46.8 s (both VMs)
2*48           16 GB            50.4 s (both VMs)      49.3 s (both VMs)
4*24           12 GB            82.1 - 89.0 s          82.3 - 88.8 s
4*4            12 GB            87.2 - 91.3 s          90.3 - 94.9 s

All but the first line are running the benchmark in multiple guests,
concurrently.  The improvement seems to be about 2-3% for guests larger
than 1 NUMA node, and zero or negative for smaller guests (especially as
the host is no longer overcommitted).

The difference for large NUMA guests is small but I ran the benchmark
multiple times and it is statistically significant---but not as large as
what Alex reported.

Paolo
