Received: from eggs.gnu.org ([2001:4830:134:3::10]:43817)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1ffiPU-00048S-9f
	for qemu-devel@nongnu.org; Wed, 18 Jul 2018 05:06:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1ffiPP-0003Lf-JT
	for qemu-devel@nongnu.org; Wed, 18 Jul 2018 05:06:12 -0400
Date: Wed, 18 Jul 2018 11:06:03 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20180718110603.4933a4e4.cohuck@redhat.com>
In-Reply-To: <fb787a48-341a-cb53-a1ba-23bb1e4ef4ee@redhat.com>
References: <20180718082425.14834-1-david@redhat.com>
	<148539ec-691f-5822-509f-d11dbfa3f88b@de.ibm.com>
	<873c35d4-5a5f-d095-9485-4fb7ec8b746f@redhat.com>
	<46dcb3bc-4f7f-74cb-2351-7ad2f95ea461@de.ibm.com>
	<fb787a48-341a-cb53-a1ba-23bb1e4ef4ee@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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
To: David Hildenbrand <david@redhat.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org, Thomas Huth <thuth@redhat.com>, Chris Venteicher <cventeic@redhat.com>, qemu-devel@nongnu.org, Alexander Graf <agraf@suse.de>, Collin Walling <walling@linux.ibm.com>, Richard Henderson <rth@twiddle.net>

On Wed, 18 Jul 2018 10:50:01 +0200
David Hildenbrand <david@redhat.com> wrote:

> diff --git a/target/s390x/cpu_models.c b/target/s390x/cpu_models.c
> index cfdbccf46d..604898a882 100644
> --- a/target/s390x/cpu_models.c
> +++ b/target/s390x/cpu_models.c
> @@ -716,6 +716,14 @@ CpuModelBaselineInfo
> *arch_query_cpu_model_baseline(CpuModelInfo *infoa,
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
> 

+1, would queue.
