Received: from eggs.gnu.org ([209.51.188.92]:46884)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1hJ2sN-0004HR-PE
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 17:22:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1hJ2sK-0007Xh-Ka
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 17:22:50 -0400
References: <20190418113110.160664-1-borntraeger@de.ibm.com>
	<20190418113110.160664-7-borntraeger@de.ibm.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <4b340a67-62a6-7667-5c04-0c30859bb31a@redhat.com>
Date: Tue, 23 Apr 2019 23:22:44 +0200
MIME-Version: 1.0
In-Reply-To: <20190418113110.160664-7-borntraeger@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 06/10] s390x/cpumodel: enhanced sort
 facility
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
> add the enhanced sort facility.
> 
> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> ---
>  target/s390x/cpu_features.c     | 10 ++++++++++
>  target/s390x/cpu_features.h     |  1 +
>  target/s390x/cpu_features_def.h |  8 ++++++++
>  target/s390x/gen-features.c     | 14 ++++++++++++++
>  target/s390x/kvm.c              |  6 ++++++
>  5 files changed, 39 insertions(+)
> 
> diff --git a/target/s390x/cpu_features.c b/target/s390x/cpu_features.c
> index ed3f6aa969..e0a4769c19 100644
> --- a/target/s390x/cpu_features.c
> +++ b/target/s390x/cpu_features.c
> @@ -109,6 +109,7 @@ static const S390FeatDef s390_features[] = {
>      FEAT_INIT("msa8-base", S390_FEAT_TYPE_STFL, 146, "Message-security-assist-extension-8 facility (excluding subfunctions)"),
>      FEAT_INIT("cmmnt", S390_FEAT_TYPE_STFL, 147, "CMM: ESSA-enhancement (no translate) facility"),
>      FEAT_INIT("vxeh2", S390_FEAT_TYPE_STFL, 148, "Vector Enhancements facility 2"),
> +    FEAT_INIT("esort-base", S390_FEAT_TYPE_STFL, 150, "Enhanced-sort facility (excluding subfunctions)"),
>      FEAT_INIT("vxbeh", S390_FEAT_TYPE_STFL, 152, "Vector BCD enhancements facility 1"),
>      FEAT_INIT("msa9-base", S390_FEAT_TYPE_STFL, 155, "Message-security-assist-extension-9 facility (excluding subfunctions)"),
>      FEAT_INIT("etoken", S390_FEAT_TYPE_STFL, 156, "Etoken facility"),
> @@ -340,6 +341,12 @@ static const S390FeatDef s390_features[] = {
>      FEAT_INIT("kdsa-eddsa-sign-ed448", S390_FEAT_TYPE_KDSA, 44, "KDSA EdDSA-Sign-Ed448"),
>      FEAT_INIT("kdsa-eeddsa-sign-ed25519", S390_FEAT_TYPE_KDSA, 48, "KDSA Encrypted-EdDSA-Sign-Ed25519"),
>      FEAT_INIT("kdsa-eeddsa-sign-ed448", S390_FEAT_TYPE_KDSA, 52, "KDSA Encrypted-EdDSA-Sign-Ed448"),
> +
> +    FEAT_INIT("sortl-sflr", S390_FEAT_TYPE_SORTL, 1, "SORTL SFLR"),
> +    FEAT_INIT("sortl-svlr", S390_FEAT_TYPE_SORTL, 2, "SORTL SVLR"),
> +    FEAT_INIT("sortl-32", S390_FEAT_TYPE_SORTL, 130, "SORTL 32 input lists"),
> +    FEAT_INIT("sortl-128", S390_FEAT_TYPE_SORTL, 132, "SORTL 128 input lists"),
> +    FEAT_INIT("sortl-f0", S390_FEAT_TYPE_SORTL, 192, "SORTL format 0 parameter-block"),
>  };
>  
>  const S390FeatDef *s390_feat_def(S390Feat feat)
> @@ -403,6 +410,7 @@ void s390_fill_feat_block(const S390FeatBitmap features, S390FeatType type,
>      case S390_FEAT_TYPE_PPNO:
>      case S390_FEAT_TYPE_KMA:
>      case S390_FEAT_TYPE_KDSA:
> +    case S390_FEAT_TYPE_SORTL:
>          set_be_bit(0, data); /* query is always available */
>          break;
>      default:
> @@ -430,6 +438,7 @@ void s390_add_from_feat_block(S390FeatBitmap features, S390FeatType type,
>         nr_bits = 16384;
>         break;
>      case S390_FEAT_TYPE_PLO:
> +    case S390_FEAT_TYPE_SORTL:
>         nr_bits = 256;
>         break;
>      default:
> @@ -501,6 +510,7 @@ static S390FeatGroupDef s390_feature_groups[] = {
>      FEAT_GROUP_INIT("msa9", MSA_EXT_9, "Message-security-assist-extension 9 facility"),
>      FEAT_GROUP_INIT("msa9_pckmo", MSA_EXT_9_PCKMO, "Message-security-assist-extension 9 PCKMO subfunctions"),
>      FEAT_GROUP_INIT("mepochptff", MULTIPLE_EPOCH_PTFF, "PTFF enhancements introduced with Multiple-epoch facility"),
> +    FEAT_GROUP_INIT("esort", ENH_SORT, "Enhanced-sort facility"),
>  };
>  
>  const S390FeatGroupDef *s390_feat_group_def(S390FeatGroup group)
> diff --git a/target/s390x/cpu_features.h b/target/s390x/cpu_features.h
> index 5ffd3db083..3b8c5b25dd 100644
> --- a/target/s390x/cpu_features.h
> +++ b/target/s390x/cpu_features.h
> @@ -40,6 +40,7 @@ typedef enum {
>      S390_FEAT_TYPE_PPNO,
>      S390_FEAT_TYPE_KMA,
>      S390_FEAT_TYPE_KDSA,
> +    S390_FEAT_TYPE_SORTL,
>  } S390FeatType;
>  
>  /* Definition of a CPU feature */
> diff --git a/target/s390x/cpu_features_def.h b/target/s390x/cpu_features_def.h
> index ce2223c9d7..bb8585847f 100644
> --- a/target/s390x/cpu_features_def.h
> +++ b/target/s390x/cpu_features_def.h
> @@ -97,6 +97,7 @@ typedef enum {
>      S390_FEAT_MSA_EXT_8,
>      S390_FEAT_CMM_NT,
>      S390_FEAT_VECTOR_ENH2,
> +    S390_FEAT_ESORT_BASE,
>      S390_FEAT_VECTOR_BCD_ENH,
>      S390_FEAT_MSA_EXT_9,
>      S390_FEAT_ETOKEN,
> @@ -346,6 +347,13 @@ typedef enum {
>      S390_FEAT_EEDDSA_SIGN_ED25519,
>      S390_FEAT_EEDDSA_SIGN_ED448,
>  
> +    /* SORTL */
> +    S390_FEAT_SORTL_SFLR,
> +    S390_FEAT_SORTL_SVLR,
> +    S390_FEAT_SORTL_32,
> +    S390_FEAT_SORTL_128,
> +    S390_FEAT_SORTL_F0,
> +
>      S390_FEAT_MAX,
>  } S390Feat;
>  
> diff --git a/target/s390x/gen-features.c b/target/s390x/gen-features.c
> index 64fe850ff2..3db323fc0c 100644
> --- a/target/s390x/gen-features.c
> +++ b/target/s390x/gen-features.c
> @@ -245,6 +245,15 @@
>      S390_FEAT_PCKMO_ECC_ED25519, \
>      S390_FEAT_PCKMO_ECC_ED448
>  
> +#define S390_FEAT_GROUP_ENH_SORT \
> +    S390_FEAT_ESORT_BASE, \
> +    S390_FEAT_SORTL_SFLR, \
> +    S390_FEAT_SORTL_SVLR, \
> +    S390_FEAT_SORTL_32, \
> +    S390_FEAT_SORTL_128, \
> +    S390_FEAT_SORTL_F0
> +
> +
>  /* cpu feature groups */
>  static uint16_t group_PLO[] = {
>      S390_FEAT_GROUP_PLO,
> @@ -294,6 +303,10 @@ static uint16_t group_MSA_EXT_9_PCKMO[] = {
>      S390_FEAT_GROUP_MSA_EXT_9_PCKMO,
>  };
>  
> +static uint16_t group_ENH_SORT[] = {
> +    S390_FEAT_GROUP_ENH_SORT,
> +};
> +
>  /* Base features (in order of release)
>   * Only non-hypervisor managed features belong here.
>   * Base feature sets are static meaning they do not change in future QEMU
> @@ -751,6 +764,7 @@ static FeatGroupDefSpec FeatGroupDef[] = {
>      FEAT_GROUP_INITIALIZER(MSA_EXT_9),
>      FEAT_GROUP_INITIALIZER(MSA_EXT_9_PCKMO),
>      FEAT_GROUP_INITIALIZER(MULTIPLE_EPOCH_PTFF),
> +    FEAT_GROUP_INITIALIZER(ENH_SORT),
>  };
>  
>  #define QEMU_FEAT_INITIALIZER(_name)                   \
> diff --git a/target/s390x/kvm.c b/target/s390x/kvm.c
> index 88cef3476c..7681492c41 100644
> --- a/target/s390x/kvm.c
> +++ b/target/s390x/kvm.c
> @@ -2083,6 +2083,9 @@ static int query_cpu_subfunc(S390FeatBitmap features)
>      if (test_bit(S390_FEAT_MSA_EXT_9, features)) {
>          s390_add_from_feat_block(features, S390_FEAT_TYPE_KDSA, prop.kdsa);
>      }
> +    if (test_bit(S390_FEAT_ESORT_BASE, features)) {
> +        s390_add_from_feat_block(features, S390_FEAT_TYPE_SORTL, prop.sortl);
> +    }
>      return 0;
>  }
>  
> @@ -2130,6 +2133,9 @@ static int configure_cpu_subfunc(const S390FeatBitmap features)
>      if (test_bit(S390_FEAT_MSA_EXT_9, features)) {
>          s390_fill_feat_block(features, S390_FEAT_TYPE_KDSA, prop.kdsa);
>      }
> +    if (test_bit(S390_FEAT_ESORT_BASE, features)) {
> +        s390_fill_feat_block(features, S390_FEAT_TYPE_SORTL, prop.sortl);
> +    }
>      return kvm_vm_ioctl(kvm_state, KVM_SET_DEVICE_ATTR, &attr);
>  }
>  
> 

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 

Thanks,

David / dhildenb
