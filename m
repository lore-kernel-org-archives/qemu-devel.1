Received: from eggs.gnu.org ([2001:4830:134:3::10]:52926)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjrosato@linux.vnet.ibm.com>) id 1dpnJP-0006y3-Ea
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 23:17:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjrosato@linux.vnet.ibm.com>) id 1dpnJL-0005pV-Dx
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 23:17:03 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:34112
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mjrosato@linux.vnet.ibm.com>)
	id 1dpnJL-0005pJ-7y
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 23:16:59 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v873DmO4134871
	for <qemu-devel@nongnu.org>; Wed, 6 Sep 2017 23:16:58 -0400
Received: from e18.ny.us.ibm.com (e18.ny.us.ibm.com [129.33.205.208])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2ctq9sj52k-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 06 Sep 2017 23:16:58 -0400
Received: from localhost
	by e18.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mjrosato@linux.vnet.ibm.com>;
	Wed, 6 Sep 2017 23:16:57 -0400
References: <20170904154316.4148-1-david@redhat.com>
	<20170904154316.4148-17-david@redhat.com>
From: Matthew Rosato <mjrosato@linux.vnet.ibm.com>
Date: Wed, 6 Sep 2017 23:16:52 -0400
MIME-Version: 1.0
In-Reply-To: <20170904154316.4148-17-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Message-Id: <87f49e42-13fd-e884-ff73-9516e2c09455@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v2 16/19] s390x: allow cpu hotplug via
 device_add
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
Cc: thuth@redhat.com, Eduardo Habkost <ehabkost@redhat.com>, cohuck@redhat.com, Richard Henderson <richard.henderson@linaro.org>, Alexander Graf <agraf@suse.de>, borntraeger@de.ibm.com

On 09/04/2017 11:43 AM, David Hildenbrand wrote:
> E.g. the following now works:
>     device_add host-s390-cpu,id=cpu1,core-id=1
> 
> The system will perform the same checks as when using cpu_add:
> - If the core_id is already in use
> - If the next sequential core_id isn't used
> - If core-id >= max_cpu is specified
> 
> In addition, mixed CPU models are checked. E.g. if starting with
> -cpu host and trying to hotplug "qemu-s390-cpu":
>     "Mixed CPU models are not supported on s390x."
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>

As easy as flipping a switch, right?

Tested the new device_add path, the old cpu-add path and mixed cases
where I alternated adding cpus via both methods -- looking good.

Reviewed-by: Matthew Rosato <mjrosato@linux.vnet.ibm.com>

> ---
>  target/s390x/cpu.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/target/s390x/cpu.c b/target/s390x/cpu.c
> index 105ff13034..be20c2fb0f 100644
> --- a/target/s390x/cpu.c
> +++ b/target/s390x/cpu.c
> @@ -466,6 +466,7 @@ static void s390_cpu_class_init(ObjectClass *oc, void *data)
>      scc->parent_realize = dc->realize;
>      dc->realize = s390_cpu_realizefn;
>      dc->props = s390x_cpu_properties;
> +    dc->user_creatable = true;
> 
>      scc->parent_reset = cc->reset;
>  #if !defined(CONFIG_USER_ONLY)
> 
