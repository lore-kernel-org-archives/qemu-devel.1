Received: from eggs.gnu.org ([2001:4830:134:3::10]:56919)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1ej2ri-0008C8-PS
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 08:00:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1ej2rc-0005GR-H4
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 08:00:50 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:37568)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1ej2rc-0005Fc-7W
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 08:00:44 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w16D0Tvf097728
	for <qemu-devel@nongnu.org>; Tue, 6 Feb 2018 08:00:43 -0500
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2fycty05gv-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 06 Feb 2018 08:00:42 -0500
Received: from localhost
	by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Tue, 6 Feb 2018 13:00:40 -0000
References: <20180205102935.14736-1-david@redhat.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Tue, 6 Feb 2018 14:00:35 +0100
MIME-Version: 1.0
In-Reply-To: <20180205102935.14736-1-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <e0bc1c70-26c4-bd8a-7d88-8749d305cb48@de.ibm.com>
Subject: Re: [Qemu-devel] [qemu-s390x] [PATCH v2] s390x/cpumodel: model PTFF
 subfunctions for Multiple-epoch facility
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>, qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Alexander Graf <agraf@suse.de>, Richard Henderson <rth@twiddle.net>



On 02/05/2018 11:29 AM, David Hildenbrand wrote:
> For now, the kernel does not properly indicate configured CPU subfunctions
> to the guest, but simply uses the host values (as support in KVM is still
> missing). That's why we missed to model the PTFF subfunctions that come
> with Multiple-epoch facility.
> 
> Let's properly add these, along with a new feature group.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>

Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>

> ---
> 
> v1 -> v2:
> - s/MEPOCH/MULTIPLE_EPOCH/ (only internally visible)
> - Add the features to the z14 full model
> - Clear the features if Multiple-epoch facility is not installed
> 
>  target/s390x/cpu_features.c     |  5 +++++
>  target/s390x/cpu_features_def.h |  4 ++++
>  target/s390x/gen-features.c     | 11 +++++++++++
>  target/s390x/kvm.c              |  8 ++++++++
>  4 files changed, 28 insertions(+)
> 
> diff --git a/target/s390x/cpu_features.c b/target/s390x/cpu_features.c
> index 85d10b5710..a5619f2893 100644
> --- a/target/s390x/cpu_features.c
> +++ b/target/s390x/cpu_features.c
> @@ -156,8 +156,12 @@ static const S390FeatDef s390_features[] = {
>      FEAT_INIT("ptff-qpc", S390_FEAT_TYPE_PTFF, 3, "PTFF Query Physical Clock"),
>      FEAT_INIT("ptff-qui", S390_FEAT_TYPE_PTFF, 4, "PTFF Query UTC Information"),
>      FEAT_INIT("ptff-qtou", S390_FEAT_TYPE_PTFF, 5, "PTFF Query TOD Offset User"),
> +    FEAT_INIT("ptff-qsie", S390_FEAT_TYPE_PTFF, 10, "PTFF Query Steering Information Extended"),
> +    FEAT_INIT("ptff-qtoue", S390_FEAT_TYPE_PTFF, 13, "PTFF Query TOD Offset User Extended"),
>      FEAT_INIT("ptff-sto", S390_FEAT_TYPE_PTFF, 65, "PTFF Set TOD Offset"),
>      FEAT_INIT("ptff-stou", S390_FEAT_TYPE_PTFF, 69, "PTFF Set TOD Offset User"),
> +    FEAT_INIT("ptff-stoe", S390_FEAT_TYPE_PTFF, 73, "PTFF Set TOD Offset Extended"),
> +    FEAT_INIT("ptff-stoue", S390_FEAT_TYPE_PTFF, 77, "PTFF Set TOD Offset User Extended"),
> 
>      FEAT_INIT("kmac-dea", S390_FEAT_TYPE_KMAC, 1, "KMAC DEA"),
>      FEAT_INIT("kmac-tdea-128", S390_FEAT_TYPE_KMAC, 2, "KMAC TDEA-128"),
> @@ -445,6 +449,7 @@ static S390FeatGroupDef s390_feature_groups[] = {
>      FEAT_GROUP_INIT("plo", PLO, "Perform-locked-operation facility"),
>      FEAT_GROUP_INIT("tods", TOD_CLOCK_STEERING, "Tod-clock-steering facility"),
>      FEAT_GROUP_INIT("gen13ptff", GEN13_PTFF, "PTFF enhancements introduced with z13"),
> +    FEAT_GROUP_INIT("mepochptff", MULTIPLE_EPOCH_PTFF, "PTFF enhancements introduced with Multiple-epoch facility"),
>      FEAT_GROUP_INIT("msa", MSA, "Message-security-assist facility"),
>      FEAT_GROUP_INIT("msa1", MSA_EXT_1, "Message-security-assist-extension 1 facility"),
>      FEAT_GROUP_INIT("msa2", MSA_EXT_2, "Message-security-assist-extension 2 facility"),
> diff --git a/target/s390x/cpu_features_def.h b/target/s390x/cpu_features_def.h
> index 4d930871b4..7c5915c7b2 100644
> --- a/target/s390x/cpu_features_def.h
> +++ b/target/s390x/cpu_features_def.h
> @@ -151,8 +151,12 @@ typedef enum {
>      S390_FEAT_PTFF_QPT,
>      S390_FEAT_PTFF_QUI,
>      S390_FEAT_PTFF_QTOU,
> +    S390_FEAT_PTFF_QSIE,
> +    S390_FEAT_PTFF_QTOUE,
>      S390_FEAT_PTFF_STO,
>      S390_FEAT_PTFF_STOU,
> +    S390_FEAT_PTFF_STOE,
> +    S390_FEAT_PTFF_STOUE,
> 
>      /* KMAC */
>      S390_FEAT_KMAC_DEA,
> diff --git a/target/s390x/gen-features.c b/target/s390x/gen-features.c
> index 58b6ac484e..716b06f726 100644
> --- a/target/s390x/gen-features.c
> +++ b/target/s390x/gen-features.c
> @@ -59,6 +59,12 @@
>      S390_FEAT_PTFF_QTOU, \
>      S390_FEAT_PTFF_STOU
> 
> +#define S390_FEAT_GROUP_MULTIPLE_EPOCH_PTFF \
> +    S390_FEAT_PTFF_QSIE, \
> +    S390_FEAT_PTFF_QTOUE, \
> +    S390_FEAT_PTFF_STOE, \
> +    S390_FEAT_PTFF_STOUE
> +
>  #define S390_FEAT_GROUP_MSA \
>      S390_FEAT_MSA, \
>      S390_FEAT_KMAC_DEA, \
> @@ -219,6 +225,9 @@ static uint16_t group_TOD_CLOCK_STEERING[] = {
>  static uint16_t group_GEN13_PTFF[] = {
>      S390_FEAT_GROUP_GEN13_PTFF,
>  };
> +static uint16_t group_MULTIPLE_EPOCH_PTFF[] = {
> +    S390_FEAT_GROUP_MULTIPLE_EPOCH_PTFF,
> +};
>  static uint16_t group_MSA[] = {
>      S390_FEAT_GROUP_MSA,
>  };
> @@ -466,6 +475,7 @@ static uint16_t full_GEN14_GA1[] = {
>      S390_FEAT_CMM_NT,
>      S390_FEAT_HPMA2,
>      S390_FEAT_SIE_KSS,
> +    S390_FEAT_GROUP_MULTIPLE_EPOCH_PTFF,
>  };
> 
>  /* Default features (in order of release)
> @@ -665,6 +675,7 @@ static FeatGroupDefSpec FeatGroupDef[] = {
>      FEAT_GROUP_INITIALIZER(PLO),
>      FEAT_GROUP_INITIALIZER(TOD_CLOCK_STEERING),
>      FEAT_GROUP_INITIALIZER(GEN13_PTFF),
> +    FEAT_GROUP_INITIALIZER(MULTIPLE_EPOCH_PTFF),
>      FEAT_GROUP_INITIALIZER(MSA),
>      FEAT_GROUP_INITIALIZER(MSA_EXT_1),
>      FEAT_GROUP_INITIALIZER(MSA_EXT_2),
> diff --git a/target/s390x/kvm.c b/target/s390x/kvm.c
> index bfd14723f1..deb870921b 100644
> --- a/target/s390x/kvm.c
> +++ b/target/s390x/kvm.c
> @@ -2221,6 +2221,14 @@ void kvm_s390_get_host_cpu_model(S390CPUModel *model, Error **errp)
>          return;
>      }
> 
> +    /* PTFF subfunctions might be indicated although kernel support missing */
> +    if (!test_bit(S390_FEAT_MULTIPLE_EPOCH, model->features)) {
> +        clear_bit(S390_FEAT_PTFF_QSIE, model->features);
> +        clear_bit(S390_FEAT_PTFF_QTOUE, model->features);
> +        clear_bit(S390_FEAT_PTFF_STOE, model->features);
> +        clear_bit(S390_FEAT_PTFF_STOUE, model->features);
> +    }
> +
>      /* with cpu model support, CMM is only indicated if really available */
>      if (kvm_s390_cmma_available()) {
>          set_bit(S390_FEAT_CMM, model->features);
> 
