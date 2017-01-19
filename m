Received: from eggs.gnu.org ([2001:4830:134:3::10]:52445)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cUDmo-0004Ix-Mp
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 09:33:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cUDmj-00017v-Q7
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 09:33:58 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39152)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1cUDmj-00017a-LC
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 09:33:53 -0500
Date: Thu, 19 Jan 2017 12:33:48 -0200
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170119143348.GO3491@thinpad.lan.raisama.net>
References: <148474442644.214.12638212197331646848@790289a7ca88>
	<21a27c35-8495-3b55-b809-5499118660b9@cn.fujitsu.com>
	<20170118170618.GD3491@thinpad.lan.raisama.net>
	<a0329668-205f-5d2f-3759-bcdff31be6ed@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a0329668-205f-5d2f-3759-bcdff31be6ed@cn.fujitsu.com>
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
Cc: qemu-devel@nongnu.org, famz@redhat.com, peter.maydell@linaro.org, fanc.fnst@cn.fujitsu.com, caoj.fnst@cn.fujitsu.com, stefanha@redhat.com, izumi.taku@jp.fujitsu.com, imammedo@redhat.com, vilanova@ac.upc.edu

On Thu, Jan 19, 2017 at 08:17:02PM +0800, Dou Liyang wrote:
> Hi, Eduardo
> 
> At 01/19/2017 01:06 AM, Eduardo Habkost wrote:
> > On Wed, Jan 18, 2017 at 09:26:36PM +0800, Dou Liyang wrote:
> > > Hi, All
> > > 
> > > > **
> > > > ERROR:/tmp/qemu-test/src/tests/vhost-user-test.c:668:test_migrate: assertion failed: (qdict_haskey(rsp, "return"))
> > > > GTester: last random seed: R02Sf52546c4daff8087416f43fa7c146db8
> > > > ftruncate: Permission denied
> > > > ftruncate: Permission denied
> > > > qemu-system-aarch64: /tmp/qemu-test/src/qom/cpu.c:346: cpu_common_map_numa_node: Assertion `cpu->cpu_index < max_cpus' failed.
> > > > Broken pipe
> > > 
> > > I don't know What's the meaning of this log ?
> > > 
> > > Is the qemu-system-aarch64 can't recognize the
> > > qom/cpu.c:346: assert(cpu->cpu_index < max_cpus);
> > 
> > This means the assert() line is being triggered for some reason,
> > and cpu_index is >= max_cpus when we cpu_common_map_numa_node()
> > gets called. We need to investigate why.
> > 
> 
> I have investigated the reason why it is failed.
> 
> Because not all targets(aarch64-linux-user, x86_64-linux-user ...)
> need to compile the vl.c(include the max_cpus) and numa.c, but the all
> may compile the ./qom/cpu.c.
> So, when we Link those targets, we may can't find the vl.o or numa.o
> that we want.
> 
> Add "#ifdef CONFIG_NUMA" to fix it.
> 
> +static void cpu_common_map_numa_node(CPUState *cpu)
> +{
> +    #ifdef CONFIG_NUMA
> +    int i;
> +
> +    assert(cpu->cpu_index < max_cpus);
> +    for (i = 0; i < nb_numa_nodes; i++) {
> +        if (test_bit(cpu->cpu_index, numa_info[i].node_cpu)) {
> +            cpu->numa_node = i;
> +            return;
> +        }
> +    }
> +    #endif
> +}
> +
> 
> And I am not sure if it is necessary to resend this patch for
> fixing the bug before Igor's patches is OK completely?

No need to resend this patch: I have already applied your
previous patch that moved the numa_post_machine_init() call, and
Igor is taking care of removing numa_post_machine_init() in a
different way.

Thanks!

-- 
Eduardo
