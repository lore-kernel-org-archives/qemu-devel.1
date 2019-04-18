Received: from eggs.gnu.org ([209.51.188.92]:38903)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1hH6ZL-0001Z8-Ae
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 08:55:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1hH6ZK-0004bo-2R
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 08:55:11 -0400
References: <20190418113110.160664-1-borntraeger@de.ibm.com>
	<20190418113110.160664-11-borntraeger@de.ibm.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <e17bf7a1-bd4c-8715-96aa-84b8ad11d99e@redhat.com>
Date: Thu, 18 Apr 2019 14:48:39 +0200
MIME-Version: 1.0
In-Reply-To: <20190418113110.160664-11-borntraeger@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 10/10] s390x/cpumodel: do not claim csske
 for expanded models in qmp
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, qemu-s390x <qemu-s390x@nongnu.org>, Halil Pasic <pasic@linux.ibm.com>, Richard Henderson <rth@twiddle.net>, Collin Walling <walling@linux.ibm.com>, "Jason J . Herne" <jjherne@linux.ibm.com>

On 18.04.19 13:31, Christian Borntraeger wrote:
> While we have removed csske and bpb from the default model, the very
> common case of "host-model" in libvirt (expanded to a base model
> + features) would still contain bpb and csske. This can prevent
> migration to a future machine for a host-model machine. Let us fence
> bpb and csske when we run on a generation 15. If necessary the
> user can still use -cpu 8561,csske=on,bpb=on to force enable these
> features.
> 
> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> ---
>  target/s390x/cpu_models.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/target/s390x/cpu_models.c b/target/s390x/cpu_models.c
> index e727519686..03bdca1fb8 100644
> --- a/target/s390x/cpu_models.c
> +++ b/target/s390x/cpu_models.c
> @@ -629,6 +629,17 @@ CpuModelExpansionInfo *qmp_query_cpu_model_expansion(CpuModelExpansionType type,
>          return NULL;
>      }
>  
> +    /*
> +     * Do not claim CSSKE and BPB if the host model expands to
> +     * generation 15 or newer
> +     */
> +    if (s390_model.def->gen >= 15) {
> +        clear_bit(S390_FEAT_CONDITIONAL_SSKE,
> +                  (unsigned long *) &s390_model.features);
> +        clear_bit(S390_FEAT_BPB,
> +                  (unsigned long *) &s390_model.features);
> +    }
> +
>      if (type == CPU_MODEL_EXPANSION_TYPE_STATIC) {
>          delta_changes = true;
>      } else if (type != CPU_MODEL_EXPANSION_TYPE_FULL) {
> 

The bad thing about it is, it hinders migration *to* this hw generation.
Will have to think about this some more. As alternative, simply ignore
S390_FEAT_CONDITIONAL_SSKE and S390_FEAT_BPB when baselining/comparing.

-- 

Thanks,

David / dhildenb
