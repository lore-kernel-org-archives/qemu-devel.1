Received: from eggs.gnu.org ([2001:4830:134:3::10]:39077)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1ffkIL-0000AS-9j
	for qemu-devel@nongnu.org; Wed, 18 Jul 2018 07:07:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1ffkII-00069V-56
	for qemu-devel@nongnu.org; Wed, 18 Jul 2018 07:06:57 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:58030
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1ffkIH-00069C-VM
	for qemu-devel@nongnu.org; Wed, 18 Jul 2018 07:06:54 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w6IB4RbX143490
	for <qemu-devel@nongnu.org>; Wed, 18 Jul 2018 07:06:52 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2ka2gyw1ws-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 18 Jul 2018 07:06:52 -0400
Received: from localhost
	by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Wed, 18 Jul 2018 12:06:50 +0100
References: <20180718092330.19465-1-david@redhat.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Wed, 18 Jul 2018 13:06:45 +0200
MIME-Version: 1.0
In-Reply-To: <20180718092330.19465-1-david@redhat.com>
Content-Language: en-US
Message-Id: <a19801cd-2e30-f403-ca7a-c53e7cd34b55@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2] s390x/cpumodel: fix segmentation fault
 when baselining models
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>, qemu-s390x@nongnu.org
Cc: qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>, Alexander Graf <agraf@suse.de>, Cornelia Huck <cohuck@redhat.com>, Thomas Huth <thuth@redhat.com>, Chris Venteicher <cventeic@redhat.com>, Collin Walling <walling@linux.ibm.com>



On 07/18/2018 11:23 AM, David Hildenbrand wrote:
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
> So let's properly report an error if we baseline e.g.:
> 
> { "execute": "query-cpu-model-baseline",
>   "arguments" : { "modela": { "name": "z14-base", "props": {"esan3" : false}},
>                   "modelb": { "name": "z14"}} }
> 
> Instead of segfaulting.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>

Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>

> ---
>  target/s390x/cpu_models.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/target/s390x/cpu_models.c b/target/s390x/cpu_models.c
> index cfdbccf46d..604898a882 100644
> --- a/target/s390x/cpu_models.c
> +++ b/target/s390x/cpu_models.c
> @@ -716,6 +716,14 @@ CpuModelBaselineInfo *arch_query_cpu_model_baseline(CpuModelInfo *infoa,
>  
>      model.def = s390_find_cpu_def(cpu_type, max_gen, max_gen_ga,
>                                    model.features);
> +
> +    /* models without early base features (esan3) are bad */
> +    if (!model.def) {
> +        error_setg(errp, "No compatible CPU model could be created as"
> +                   " important base features are disabled");
> +        return NULL;
> +    }
> +
>      /* strip off features not part of the max model */
>      bitmap_and(model.features, model.features, model.def->full_feat,
>                 S390_FEAT_MAX);
> 
