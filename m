Received: from eggs.gnu.org ([2001:4830:134:3::10]:45190)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1eoYDC-0001ON-3t
	for qemu-devel@nongnu.org; Wed, 21 Feb 2018 12:29:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1eoYD8-0007SE-1L
	for qemu-devel@nongnu.org; Wed, 21 Feb 2018 12:29:46 -0500
References: <20180221165628.78946-1-pasic@linux.vnet.ibm.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <724303ad-100b-109f-f843-44e0795f0ae6@redhat.com>
Date: Wed, 21 Feb 2018 18:29:19 +0100
MIME-Version: 1.0
In-Reply-To: <20180221165628.78946-1-pasic@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 1/1] 390x/cpumodel: document
 S390FeatDef.bit not applicable
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Halil Pasic <pasic@linux.vnet.ibm.com>
Cc: Alexander Graf <agraf@suse.de>, Richard Henderson <rth@twiddle.net>, Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>, qemu-devel@nongnu.org, qemu-s390x@nongnu.org

On 21.02.2018 17:56, Halil Pasic wrote:
> The 'bit' field of the 'S390FeatDef' structure is not applicable to all
> its instances. Currently this field is not applicable, and remains
> unused, iff the feature is of type S390_FEAT_TYPE_MISC. Having the value 0
> specified for multiple such feature definition  was a little confusing,

s/  / /

> as it's a perfectly legit bit value, and as the value of the bit
> field is usually ought to be unique for each feature of a given
> feature type.
> 
> Let us introduce a specialized macro for defining features of type
> S390_FEAT_TYPE_MISC so, that one does not have to specify neither bit nor
> type (as the later is implied).

s/later is implied/latter is implicit/

> 
> Signed-off-by: Halil Pasic <pasic@linux.vnet.ibm.com>
> ---
> 
> v1 -> v2
> * Specialized feature initializer macro for type MISC that does not
>   require a bit value instead of defining a 'not a bit number' (that
>   is extremal) bit number.
> ---
>  target/s390x/cpu_features.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/target/s390x/cpu_features.c b/target/s390x/cpu_features.c
> index a5619f2893..3b9e2745e9 100644
> --- a/target/s390x/cpu_features.c
> +++ b/target/s390x/cpu_features.c
> @@ -23,6 +23,10 @@
>          .desc = _desc,                               \
>      }
>  
> +/* S390FeatDef.bit is not applicable as there is no feature block. */
> +#define FEAT_INIT_MISC(_name, _desc)                 \
> +            FEAT_INIT(_name, S390_FEAT_TYPE_MISC, 0, _desc)
> +
>  /* indexed by feature number for easy lookup */
>  static const S390FeatDef s390_features[] = {
>      FEAT_INIT("esan3", S390_FEAT_TYPE_STFL, 0, "Instructions marked as n3"),
> @@ -123,8 +127,8 @@ static const S390FeatDef s390_features[] = {
>      FEAT_INIT("ib", S390_FEAT_TYPE_SCLP_CPU, 42, "SIE: Intervention bypass facility"),
>      FEAT_INIT("cei", S390_FEAT_TYPE_SCLP_CPU, 43, "SIE: Conditional-external-interception facility"),
>  
> -    FEAT_INIT("dateh2", S390_FEAT_TYPE_MISC, 0, "DAT-enhancement facility 2"),
> -    FEAT_INIT("cmm", S390_FEAT_TYPE_MISC, 0, "Collaborative-memory-management facility"),
> +    FEAT_INIT_MISC("dateh2", "DAT-enhancement facility 2"),
> +    FEAT_INIT_MISC("cmm", "Collaborative-memory-management facility"),
>  
>      FEAT_INIT("plo-cl", S390_FEAT_TYPE_PLO, 0, "PLO Compare and load (32 bit in general registers)"),
>      FEAT_INIT("plo-clg", S390_FEAT_TYPE_PLO, 1, "PLO Compare and load (64 bit in parameter list)"),
> 

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 

Thanks,

David / dhildenb
