Received: from eggs.gnu.org ([2001:4830:134:3::10]:39925)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1cMWFC-0005GF-VD
	for qemu-devel@nongnu.org; Thu, 29 Dec 2016 03:39:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1cMWF9-0000xd-T7
	for qemu-devel@nongnu.org; Thu, 29 Dec 2016 03:39:27 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34362)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1cMWF9-0000wf-N0
	for qemu-devel@nongnu.org; Thu, 29 Dec 2016 03:39:23 -0500
Date: Thu, 29 Dec 2016 09:39:18 +0100
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20161229093918.0d7bc742@nial.brq.redhat.com>
In-Reply-To: <20161228170842.GB23551@thinpad.lan.raisama.net>
References: <1479466974-249781-1-git-send-email-imammedo@redhat.com>
	<20161228170842.GB23551@thinpad.lan.raisama.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH for-2.9] numa: make -numa parser
 dynamically allocate CPUs masks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: qemu-devel@nongnu.org, Alexey Kardashevskiy <aik@ozlabs.ru>, Paolo Bonzini <pbonzini@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Greg Kurz <gkurz@linux.vnet.ibm.com>

On Wed, 28 Dec 2016 15:08:42 -0200
Eduardo Habkost <ehabkost@redhat.com> wrote:

> On Fri, Nov 18, 2016 at 12:02:54PM +0100, Igor Mammedov wrote:
> > so it won't impose an additional limits on max_cpus limits
> > supported by different targets.
> > 
> > It removes global MAX_CPUMASK_BITS constant and need to
> > bump it up whenever max_cpus is being increased for
> > a target above MAX_CPUMASK_BITS value.
> > 
> > Use runtime max_cpus value instead to allocate sufficiently
> > sized node_cpu bitmasks in numa parser.
> > 
> > Signed-off-by: Igor Mammedov <imammedo@redhat.com>  
> 
> Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
> 
> As the cpu_index assignment code isn't obviously safe against
> setting cpu_index > max_cpus, I would like to squash this into
> the patch. Is that OK for you?
Go ahead, change looks good to me.

> 
> diff --git a/numa.c b/numa.c
> index 1b6fa78..33f2fd4 100644
> --- a/numa.c
> +++ b/numa.c
> @@ -401,6 +401,7 @@ void numa_post_machine_init(void)
>  
>      CPU_FOREACH(cpu) {
>          for (i = 0; i < nb_numa_nodes; i++) {
> +            assert(cpu->cpu_index < max_cpus);
>              if (test_bit(cpu->cpu_index, numa_info[i].node_cpu)) {
>                  cpu->numa_node = i;
>              }
> @@ -559,6 +560,8 @@ int numa_get_node_for_cpu(int idx)
>  {
>      int i;
>  
> +    assert(idx < max_cpus);
> +
>      for (i = 0; i < nb_numa_nodes; i++) {
>          if (test_bit(idx, numa_info[i].node_cpu)) {
>              break;
> 
