Received: from eggs.gnu.org ([2001:4830:134:3::10]:44150)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1dXnG9-0003m0-SY
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 07:35:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1dXnG6-0006JL-N5
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 07:35:17 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:53809
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1dXnG6-0006J9-IZ
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 07:35:14 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v6JBY9aV019608
	for <qemu-devel@nongnu.org>; Wed, 19 Jul 2017 07:35:13 -0400
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2bsu0st58m-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 19 Jul 2017 07:35:12 -0400
Received: from localhost
	by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Wed, 19 Jul 2017 07:35:12 -0400
References: <20170719095033.20482-1-david@redhat.com>
	<20170719095033.20482-4-david@redhat.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Wed, 19 Jul 2017 13:35:06 +0200
MIME-Version: 1.0
In-Reply-To: <20170719095033.20482-4-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-IE
Content-Transfer-Encoding: 7bit
Message-Id: <3ba69989-8077-2027-9540-22d63addf825@de.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v1 3/5] target/s390x: introduce
 (test|set)_be_bit
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
> Using ordinary bitmap operations to set/test bits does not work properly
> on architectures !s390x. Let's drop (test|set)_bit_inv and introduce
> (test|set)_be_bit instead. These functions work on uint8_t array, not on
> unsigned longs arrays and are for now only used in the context of
> CPU features.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  target/s390x/cpu_features.c |  8 ++++----
>  target/s390x/cpu_features.h |  8 ++++++++
>  target/s390x/kvm.c          | 14 ++------------
>  3 files changed, 14 insertions(+), 16 deletions(-)
> 
> diff --git a/target/s390x/cpu_features.c b/target/s390x/cpu_features.c
> index 8b14917..1d3a036 100644
> --- a/target/s390x/cpu_features.c
> +++ b/target/s390x/cpu_features.c
> @@ -340,8 +340,8 @@ void s390_fill_feat_block(const S390FeatBitmap features, S390FeatType type,
>      case S390_FEAT_TYPE_STFL:
>          if (test_bit(S390_FEAT_ZARCH, features)) {
>              /* Features that are always active */
> -            data[0] |= 0x20;  /* z/Architecture */
> -            data[17] |= 0x20; /* Configuration-z-architectural-mode */
> +            set_be_bit(2, data);   /* z/Architecture */
> +            set_be_bit(138, data); /* Configuration-z-architectural-mode */

this looks much nicer, but as seen from patchew, please make this patch compile :-p
