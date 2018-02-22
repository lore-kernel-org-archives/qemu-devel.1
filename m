Received: from eggs.gnu.org ([2001:4830:134:3::10]:45478)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1eopeJ-0000VG-HP
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 07:06:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1eopeG-0003MW-9x
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 07:06:55 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:51620
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1eopeG-0003M4-41
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 07:06:52 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w1MC4TqF056467
	for <qemu-devel@nongnu.org>; Thu, 22 Feb 2018 07:06:51 -0500
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2g9urjvtu9-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 22 Feb 2018 07:06:49 -0500
Received: from localhost
	by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Thu, 22 Feb 2018 12:06:41 -0000
References: <20180221165628.78946-1-pasic@linux.vnet.ibm.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Thu, 22 Feb 2018 13:06:36 +0100
MIME-Version: 1.0
In-Reply-To: <20180221165628.78946-1-pasic@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <1f66a73d-a34a-e808-ab3d-8bd5a6059a43@de.ibm.com>
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
To: Halil Pasic <pasic@linux.vnet.ibm.com>, David Hildenbrand <david@redhat.com>
Cc: Alexander Graf <agraf@suse.de>, Richard Henderson <rth@twiddle.net>, Cornelia Huck <cohuck@redhat.com>, qemu-devel@nongnu.org, qemu-s390x@nongnu.org



On 02/21/2018 05:56 PM, Halil Pasic wrote:
> The 'bit' field of the 'S390FeatDef' structure is not applicable to all
> its instances. Currently this field is not applicable, and remains
> unused, iff the feature is of type S390_FEAT_TYPE_MISC. Having the value 0
> specified for multiple such feature definition  was a little confusing,
> as it's a perfectly legit bit value, and as the value of the bit
> field is usually ought to be unique for each feature of a given
> feature type.
> 
> Let us introduce a specialized macro for defining features of type
> S390_FEAT_TYPE_MISC so, that one does not have to specify neither bit nor
> type (as the later is implied).
> 
> Signed-off-by: Halil Pasic <pasic@linux.vnet.ibm.com>

Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>


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
