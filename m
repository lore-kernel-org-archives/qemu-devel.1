Received: from eggs.gnu.org ([209.51.188.92]:48482)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1hL3R5-0006df-4q
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 06:23:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1hL3O3-0007WW-F9
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 06:19:52 -0400
References: <20190429090250.7648-1-borntraeger@de.ibm.com>
	<20190429090250.7648-8-borntraeger@de.ibm.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <42919d38-cd8e-0bb0-e218-e163d93479ff@redhat.com>
Date: Mon, 29 Apr 2019 12:19:43 +0200
MIME-Version: 1.0
In-Reply-To: <20190429090250.7648-8-borntraeger@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 7/9] s390x/cpumodel: add
 Deflate-conversion facility
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

On 29.04.19 11:02, Christian Borntraeger wrote:
> add the deflate conversion facility.
> 
> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> ---
>  target/s390x/cpu_features.c     |  9 +++++++++
>  target/s390x/cpu_features.h     |  1 +
>  target/s390x/cpu_features_def.h |  7 +++++++
>  target/s390x/gen-features.c     | 12 ++++++++++++
>  target/s390x/kvm.c              |  6 ++++++
>  5 files changed, 35 insertions(+)
> 
> diff --git a/target/s390x/cpu_features.c b/target/s390x/cpu_features.c
> index 1d19b3072e..f64f581c86 100644
> --- a/target/s390x/cpu_features.c
> +++ b/target/s390x/cpu_features.c
> @@ -110,6 +110,7 @@ static const S390FeatDef s390_features[] = {
>      FEAT_INIT("cmmnt", S390_FEAT_TYPE_STFL, 147, "CMM: ESSA-enhancement (no translate) facility"),
>      FEAT_INIT("vxeh2", S390_FEAT_TYPE_STFL, 148, "Vector Enhancements facility 2"),
>      FEAT_INIT("esort-base", S390_FEAT_TYPE_STFL, 150, "Enhanced-sort facility (excluding subfunctions)"),
> +    FEAT_INIT("deflate-base", S390_FEAT_TYPE_STFL, 151, "Deflate-conversion facility (excluding subfunctions)"),
>      FEAT_INIT("vxbeh", S390_FEAT_TYPE_STFL, 152, "Vector BCD enhancements facility 1"),
>      FEAT_INIT("msa9-base", S390_FEAT_TYPE_STFL, 155, "Message-security-assist-extension-9 facility (excluding subfunctions)"),
>      FEAT_INIT("etoken", S390_FEAT_TYPE_STFL, 156, "Etoken facility"),
> @@ -347,6 +348,11 @@ static const S390FeatDef s390_features[] = {
>      FEAT_INIT("sortl-32", S390_FEAT_TYPE_SORTL, 130, "SORTL 32 input lists"),
>      FEAT_INIT("sortl-128", S390_FEAT_TYPE_SORTL, 132, "SORTL 128 input lists"),
>      FEAT_INIT("sortl-f0", S390_FEAT_TYPE_SORTL, 192, "SORTL format 0 parameter-block"),
> +
> +    FEAT_INIT("dfltcc-gdht", S390_FEAT_TYPE_DFLTCC, 1, "DFLTCC GDHT"),
> +    FEAT_INIT("dfltcc-cmpr", S390_FEAT_TYPE_DFLTCC, 2, "DFLTCC CMPR"),
> +    FEAT_INIT("dfltcc-xpnd", S390_FEAT_TYPE_DFLTCC, 4, "DFLTCC XPND"),
> +    FEAT_INIT("dfltcc-f0", S390_FEAT_TYPE_DFLTCC, 192, "DFLTCC format 0 parameter-block"),
>  };
>  
>  const S390FeatDef *s390_feat_def(S390Feat feat)
> @@ -411,6 +417,7 @@ void s390_fill_feat_block(const S390FeatBitmap features, S390FeatType type,
>      case S390_FEAT_TYPE_KMA:
>      case S390_FEAT_TYPE_KDSA:
>      case S390_FEAT_TYPE_SORTL:
> +    case S390_FEAT_TYPE_DFLTCC:
>          set_be_bit(0, data); /* query is always available */
>          break;
>      default:
> @@ -439,6 +446,7 @@ void s390_add_from_feat_block(S390FeatBitmap features, S390FeatType type,
>         break;
>      case S390_FEAT_TYPE_PLO:
>      case S390_FEAT_TYPE_SORTL:
> +    case S390_FEAT_TYPE_DFLTCC:
>         nr_bits = 256;
>         break;
>      default:
> @@ -511,6 +519,7 @@ static S390FeatGroupDef s390_feature_groups[] = {
>      FEAT_GROUP_INIT("msa9_pckmo", MSA_EXT_9_PCKMO, "Message-security-assist-extension 9 PCKMO subfunctions"),
>      FEAT_GROUP_INIT("mepochptff", MULTIPLE_EPOCH_PTFF, "PTFF enhancements introduced with Multiple-epoch facility"),
>      FEAT_GROUP_INIT("esort", ENH_SORT, "Enhanced-sort facility"),
> +    FEAT_GROUP_INIT("deflate", DEFLATE_CONVERSION, "Deflate-conversion facility"),
>  };
>  
>  const S390FeatGroupDef *s390_feat_group_def(S390FeatGroup group)
> diff --git a/target/s390x/cpu_features.h b/target/s390x/cpu_features.h
> index 3b8c5b25dd..da695a8346 100644
> --- a/target/s390x/cpu_features.h
> +++ b/target/s390x/cpu_features.h
> @@ -41,6 +41,7 @@ typedef enum {
>      S390_FEAT_TYPE_KMA,
>      S390_FEAT_TYPE_KDSA,
>      S390_FEAT_TYPE_SORTL,
> +    S390_FEAT_TYPE_DFLTCC,
>  } S390FeatType;
>  
>  /* Definition of a CPU feature */
> diff --git a/target/s390x/cpu_features_def.h b/target/s390x/cpu_features_def.h
> index bb8585847f..292b17b35d 100644
> --- a/target/s390x/cpu_features_def.h
> +++ b/target/s390x/cpu_features_def.h
> @@ -98,6 +98,7 @@ typedef enum {
>      S390_FEAT_CMM_NT,
>      S390_FEAT_VECTOR_ENH2,
>      S390_FEAT_ESORT_BASE,
> +    S390_FEAT_DEFLATE_BASE,
>      S390_FEAT_VECTOR_BCD_ENH,
>      S390_FEAT_MSA_EXT_9,
>      S390_FEAT_ETOKEN,
> @@ -354,6 +355,12 @@ typedef enum {
>      S390_FEAT_SORTL_128,
>      S390_FEAT_SORTL_F0,
>  
> +    /* DEFLATE */
> +    S390_FEAT_DEFLATE_GHDT,
> +    S390_FEAT_DEFLATE_CMPR,
> +    S390_FEAT_DEFLATE_XPND,
> +    S390_FEAT_DEFLATE_F0,
> +
>      S390_FEAT_MAX,
>  } S390Feat;
>  
> diff --git a/target/s390x/gen-features.c b/target/s390x/gen-features.c
> index 0a62cc5631..8fc2e8e72f 100644
> --- a/target/s390x/gen-features.c
> +++ b/target/s390x/gen-features.c
> @@ -254,6 +254,13 @@
>      S390_FEAT_SORTL_F0
>  
>  
> +#define S390_FEAT_GROUP_DEFLATE_CONVERSION \
> +    S390_FEAT_DEFLATE_BASE, \
> +    S390_FEAT_DEFLATE_GHDT, \
> +    S390_FEAT_DEFLATE_CMPR, \
> +    S390_FEAT_DEFLATE_XPND, \
> +    S390_FEAT_DEFLATE_F0
> +
>  /* cpu feature groups */
>  static uint16_t group_PLO[] = {
>      S390_FEAT_GROUP_PLO,
> @@ -307,6 +314,10 @@ static uint16_t group_ENH_SORT[] = {
>      S390_FEAT_GROUP_ENH_SORT,
>  };
>  
> +static uint16_t group_DEFLATE_CONVERSION[] = {
> +    S390_FEAT_GROUP_DEFLATE_CONVERSION,
> +};
> +
>  /* Base features (in order of release)
>   * Only non-hypervisor managed features belong here.
>   * Base feature sets are static meaning they do not change in future QEMU
> @@ -766,6 +777,7 @@ static FeatGroupDefSpec FeatGroupDef[] = {
>      FEAT_GROUP_INITIALIZER(MSA_EXT_9_PCKMO),
>      FEAT_GROUP_INITIALIZER(MULTIPLE_EPOCH_PTFF),
>      FEAT_GROUP_INITIALIZER(ENH_SORT),
> +    FEAT_GROUP_INITIALIZER(DEFLATE_CONVERSION),
>  };
>  
>  #define QEMU_FEAT_INITIALIZER(_name)                   \
> diff --git a/target/s390x/kvm.c b/target/s390x/kvm.c
> index f91f436a31..e5e2b691f2 100644
> --- a/target/s390x/kvm.c
> +++ b/target/s390x/kvm.c
> @@ -2079,6 +2079,9 @@ static int query_cpu_subfunc(S390FeatBitmap features)
>      if (test_bit(S390_FEAT_ESORT_BASE, features)) {
>          s390_add_from_feat_block(features, S390_FEAT_TYPE_SORTL, prop.sortl);
>      }
> +    if (test_bit(S390_FEAT_DEFLATE_BASE, features)) {
> +        s390_add_from_feat_block(features, S390_FEAT_TYPE_DFLTCC, prop.dfltcc);
> +    }
>      return 0;
>  }
>  
> @@ -2129,6 +2132,9 @@ static int configure_cpu_subfunc(const S390FeatBitmap features)
>      if (test_bit(S390_FEAT_ESORT_BASE, features)) {
>          s390_fill_feat_block(features, S390_FEAT_TYPE_SORTL, prop.sortl);
>      }
> +    if (test_bit(S390_FEAT_DEFLATE_BASE, features)) {
> +        s390_fill_feat_block(features, S390_FEAT_TYPE_DFLTCC, prop.dfltcc);
> +    }
>      return kvm_vm_ioctl(kvm_state, KVM_SET_DEVICE_ATTR, &attr);
>  }
>  
> 


Reviewed-by: David Hildenbrand <david@redhat.com>


-- 

Thanks,

David / dhildenb
