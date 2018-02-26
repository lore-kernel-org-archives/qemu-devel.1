Received: from eggs.gnu.org ([2001:4830:134:3::10]:46950)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imbrenda@linux.vnet.ibm.com>) id 1eqETu-00052W-8g
	for qemu-devel@nongnu.org; Mon, 26 Feb 2018 03:49:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imbrenda@linux.vnet.ibm.com>) id 1eqETr-0003w3-6v
	for qemu-devel@nongnu.org; Mon, 26 Feb 2018 03:49:58 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:53232)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imbrenda@linux.vnet.ibm.com>)
	id 1eqETq-0003vL-Um
	for qemu-devel@nongnu.org; Mon, 26 Feb 2018 03:49:55 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w1Q8nTlF016091
	for <qemu-devel@nongnu.org>; Mon, 26 Feb 2018 03:49:52 -0500
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2gcd0acw8f-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 26 Feb 2018 03:49:52 -0500
Received: from localhost
	by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <imbrenda@linux.vnet.ibm.com>;
	Mon, 26 Feb 2018 08:49:50 -0000
Date: Mon, 26 Feb 2018 09:49:44 +0100
From: Claudio Imbrenda <imbrenda@linux.vnet.ibm.com>
In-Reply-To: <20180223173657.29125-1-david@redhat.com>
References: <20180223173657.29125-1-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <20180226094944.6c1bcd4d@p-imbrenda.boeblingen.de.ibm.com>
Subject: Re: [Qemu-devel] [qemu-s390x] [PATCH v1] numa: s390x has no NUMA
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>
Cc: qemu-s390x@nongnu.org, Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>, qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>

On Fri, 23 Feb 2018 18:36:57 +0100
David Hildenbrand <david@redhat.com> wrote:

> Right now it is possible to crash QEMU for s390x by providing e.g.
>     -numa node,nodeid=0,cpus=0-1
> 
> Problem is, that numa.c uses mc->cpu_index_to_instance_props as an
> indicator whether NUMA is supported by a machine type. We don't
> implement NUMA on s390x (and that concept also doesn't really exist).
> We need mc->cpu_index_to_instance_props for query-cpus.
> 
> So let's fix this case.
> 
> qemu-system-s390x: -numa node,nodeid=0,cpus=0-1: NUMA is not
> supported by this machine-type
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  numa.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/numa.c b/numa.c
> index 7e0e789b02..3b9be613d9 100644
> --- a/numa.c
> +++ b/numa.c
> @@ -80,10 +80,16 @@ static void parse_numa_node(MachineState *ms,
> NumaNodeOptions *node, return;
>      }
> 
> +#ifdef TARGET_S390X
> +    /* s390x provides cpu_index_to_instance_props but has no NUMA */
> +    error_report("NUMA is not supported by this machine-type");
> +    exit(1);
> +#else
>      if (!mc->cpu_index_to_instance_props) {
>          error_report("NUMA is not supported by this machine-type");
>          exit(1);
>      }
> +#endif
>      for (cpus = node->cpus; cpus; cpus = cpus->next) {
>          CpuInstanceProperties props;
>          if (cpus->value >= max_cpus) {

seems straightforward

Reviewed-by: Claudio Imbrenda <imbrenda@linux.vnet.ibm.com>
