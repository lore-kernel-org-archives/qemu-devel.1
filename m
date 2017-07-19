Received: from eggs.gnu.org ([2001:4830:134:3::10]:42814)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1dXn9E-00018H-4p
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 07:28:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1dXn9A-00032D-4q
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 07:28:08 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:53884)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1dXn99-000323-Qj
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 07:28:04 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v6JBOaUX082105
	for <qemu-devel@nongnu.org>; Wed, 19 Jul 2017 07:28:02 -0400
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2bt1uvcnhv-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 19 Jul 2017 07:28:01 -0400
Received: from localhost
	by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Wed, 19 Jul 2017 07:28:00 -0400
References: <20170719095033.20482-1-david@redhat.com>
	<20170719095033.20482-3-david@redhat.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Wed, 19 Jul 2017 13:27:54 +0200
MIME-Version: 1.0
In-Reply-To: <20170719095033.20482-3-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-IE
Content-Transfer-Encoding: 7bit
Message-Id: <43c37bcc-089e-1df9-5a38-e886e996cd4a@de.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v1 2/5] target/s390x: indicate query
 subfunction in s390_fill_feat_block
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
Cc: rth@twiddle.net, thuth@redhat.com, cohuck@redhat.com, jjherne@linux.vnet.ibm.com

On 07/19/2017 11:50 AM, David Hildenbrand wrote:
> We'll have to do the same for TCG, so let's just move it in there.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>

looks sane.

Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>

> ---
>  target/s390x/cpu_features.c | 31 ++++++++++++++++++++++++++-----
>  target/s390x/kvm.c          | 13 -------------
>  2 files changed, 26 insertions(+), 18 deletions(-)
> 
> diff --git a/target/s390x/cpu_features.c b/target/s390x/cpu_features.c
> index fa887d9..8b14917 100644
> --- a/target/s390x/cpu_features.c
> +++ b/target/s390x/cpu_features.c
> @@ -336,11 +336,32 @@ void s390_fill_feat_block(const S390FeatBitmap features, S390FeatType type,
>      S390Feat feat;
>      int bit_nr;
> 
> -    if (type == S390_FEAT_TYPE_STFL && test_bit(S390_FEAT_ZARCH, features)) {
> -        /* Features that are always active */
> -        data[0] |= 0x20;  /* z/Architecture */
> -        data[17] |= 0x20; /* Configuration-z-architectural-mode */
> -    }
> +    switch (type) {
> +    case S390_FEAT_TYPE_STFL:
> +        if (test_bit(S390_FEAT_ZARCH, features)) {
> +            /* Features that are always active */
> +            data[0] |= 0x20;  /* z/Architecture */
> +            data[17] |= 0x20; /* Configuration-z-architectural-mode */
> +        }
> +        break;
> +    case S390_FEAT_TYPE_PTFF:
> +    case S390_FEAT_TYPE_KMAC:
> +    case S390_FEAT_TYPE_KMC:
> +    case S390_FEAT_TYPE_KM:
> +    case S390_FEAT_TYPE_KIMD:
> +    case S390_FEAT_TYPE_KLMD:
> +    case S390_FEAT_TYPE_PCKMO:
> +    case S390_FEAT_TYPE_KMCTR:
> +    case S390_FEAT_TYPE_KMF:
> +    case S390_FEAT_TYPE_KMO:
> +    case S390_FEAT_TYPE_PCC:
> +    case S390_FEAT_TYPE_PPNO:
> +    case S390_FEAT_TYPE_KMA:
> +        data[0] |= 0x80; /* query is always available */
> +        break;
> +    default:
> +        break;
> +    };
> 
>      feat = find_first_bit(features, S390_FEAT_MAX);
>      while (feat < S390_FEAT_MAX) {
> diff --git a/target/s390x/kvm.c b/target/s390x/kvm.c
> index 831492f..999ea57 100644
> --- a/target/s390x/kvm.c
> +++ b/target/s390x/kvm.c
> @@ -2506,41 +2506,28 @@ static int configure_cpu_subfunc(const S390FeatBitmap features)
>      s390_fill_feat_block(features, S390_FEAT_TYPE_PLO, prop.plo);
>      if (test_bit(S390_FEAT_TOD_CLOCK_STEERING, features)) {
>          s390_fill_feat_block(features, S390_FEAT_TYPE_PTFF, prop.ptff);
> -        prop.ptff[0] |= 0x80; /* query is always available */
>      }
>      if (test_bit(S390_FEAT_MSA, features)) {
>          s390_fill_feat_block(features, S390_FEAT_TYPE_KMAC, prop.kmac);
> -        prop.kmac[0] |= 0x80; /* query is always available */
>          s390_fill_feat_block(features, S390_FEAT_TYPE_KMC, prop.kmc);
> -        prop.kmc[0] |= 0x80; /* query is always available */
>          s390_fill_feat_block(features, S390_FEAT_TYPE_KM, prop.km);
> -        prop.km[0] |= 0x80; /* query is always available */
>          s390_fill_feat_block(features, S390_FEAT_TYPE_KIMD, prop.kimd);
> -        prop.kimd[0] |= 0x80; /* query is always available */
>          s390_fill_feat_block(features, S390_FEAT_TYPE_KLMD, prop.klmd);
> -        prop.klmd[0] |= 0x80; /* query is always available */
>      }
>      if (test_bit(S390_FEAT_MSA_EXT_3, features)) {
>          s390_fill_feat_block(features, S390_FEAT_TYPE_PCKMO, prop.pckmo);
> -        prop.pckmo[0] |= 0x80; /* query is always available */
>      }
>      if (test_bit(S390_FEAT_MSA_EXT_4, features)) {
>          s390_fill_feat_block(features, S390_FEAT_TYPE_KMCTR, prop.kmctr);
> -        prop.kmctr[0] |= 0x80; /* query is always available */
>          s390_fill_feat_block(features, S390_FEAT_TYPE_KMF, prop.kmf);
> -        prop.kmf[0] |= 0x80; /* query is always available */
>          s390_fill_feat_block(features, S390_FEAT_TYPE_KMO, prop.kmo);
> -        prop.kmo[0] |= 0x80; /* query is always available */
>          s390_fill_feat_block(features, S390_FEAT_TYPE_PCC, prop.pcc);
> -        prop.pcc[0] |= 0x80; /* query is always available */
>      }
>      if (test_bit(S390_FEAT_MSA_EXT_5, features)) {
>          s390_fill_feat_block(features, S390_FEAT_TYPE_PPNO, prop.ppno);
> -        prop.ppno[0] |= 0x80; /* query is always available */
>      }
>      if (test_bit(S390_FEAT_MSA_EXT_8, features)) {
>          s390_fill_feat_block(features, S390_FEAT_TYPE_KMA, prop.kma);
> -        prop.kma[0] |= 0x80; /* query is always available */
>      }
>      return kvm_vm_ioctl(kvm_state, KVM_SET_DEVICE_ATTR, &attr);
>  }
> 
