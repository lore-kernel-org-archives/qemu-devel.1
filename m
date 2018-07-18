Received: from eggs.gnu.org ([2001:4830:134:3::10]:38138)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1ffhzp-0001KV-7t
	for qemu-devel@nongnu.org; Wed, 18 Jul 2018 04:39:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1ffhzm-0003Ge-5G
	for qemu-devel@nongnu.org; Wed, 18 Jul 2018 04:39:41 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:38190)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1ffhzl-0003Em-Qp
	for qemu-devel@nongnu.org; Wed, 18 Jul 2018 04:39:38 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w6I8d4TV010852
	for <qemu-devel@nongnu.org>; Wed, 18 Jul 2018 04:39:36 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2k9xps8fa3-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 18 Jul 2018 04:39:35 -0400
Received: from localhost
	by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Wed, 18 Jul 2018 09:39:32 +0100
References: <20180718082425.14834-1-david@redhat.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Wed, 18 Jul 2018 10:39:28 +0200
MIME-Version: 1.0
In-Reply-To: <20180718082425.14834-1-david@redhat.com>
Content-Language: en-US
Message-Id: <148539ec-691f-5822-509f-d11dbfa3f88b@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [qemu-s390x] [PATCH] s390x/cpumodel: fix
 segmentation fault when baselining models
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>, qemu-s390x@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Chris Venteicher <cventeic@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Alexander Graf <agraf@suse.de>, qemu-devel@nongnu.org, Collin Walling <walling@linux.ibm.com>, Richard Henderson <rth@twiddle.net>



On 07/18/2018 10:24 AM, David Hildenbrand wrote:
> Usually, when baselining two CPU models, whereby one of them has base
> CPU features disabled (e.g. z14-base,msa=off), we fallback to an older
> model that did not have these features in the base model. We always try to
> create a "sane" CPU model (as far as possible), and one part of it is that
> removing base features is no good and to be avoided.
> 
> Now, if we disable base features that were part of a z900, we're out of
> luck. We won't find a CPU model and QEMU will segfault. This is a
> scenario that should never happen in real life, but it can be used to
> crash QEMU.
> 
> So let's make something like this:
> 
> { "execute": "query-cpu-model-baseline",
>   "arguments" : { "modela": { "name": "z14-base", "props": {"esan3" : false}},
>                   "modelb": { "name": "z14"}} }
> 
> Produce:
> 
> {"return": {"model": {"name": "z900-base", "props": {"esan3": false}}}}
> 
> Instead of segfaulting.
> 
> This could of course be improved (e.g. to z14-base,esan3=false), however
> as this ususally won't happen, let's just avoid crashes.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  target/s390x/cpu_models.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/target/s390x/cpu_models.c b/target/s390x/cpu_models.c
> index cfdbccf46d..13a5d4f095 100644
> --- a/target/s390x/cpu_models.c
> +++ b/target/s390x/cpu_models.c
> @@ -716,6 +716,12 @@ CpuModelBaselineInfo *arch_query_cpu_model_baseline(CpuModelInfo *infoa,
>  
>      model.def = s390_find_cpu_def(cpu_type, max_gen, max_gen_ga,
>                                    model.features);
> +
> +    /* models without early base features (esan3) are bad - fallback to z900 */
> +    if (!model.def) {
> +        model.def = s390_find_cpu_def(0x2064, 7, 1, NULL);
> +    }
> +

Is there a way to not even return z900 but retuning an empty model (e.g. no model that 
matches) ?


>      /* strip off features not part of the max model */
>      bitmap_and(model.features, model.features, model.def->full_feat,
>                 S390_FEAT_MAX);
> 
