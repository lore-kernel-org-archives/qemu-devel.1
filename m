Received: from eggs.gnu.org ([2001:4830:134:3::10]:46287)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1eieqz-00058n-1b
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 06:22:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1eieqv-00042H-Ss
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 06:22:29 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:40538)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1eieqv-00041S-Ir
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 06:22:25 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w15BJcvk108293
	for <qemu-devel@nongnu.org>; Mon, 5 Feb 2018 06:22:24 -0500
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2fxp9r84de-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 05 Feb 2018 06:22:23 -0500
Received: from localhost
	by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Mon, 5 Feb 2018 11:22:21 -0000
References: <20180205102935.14736-1-david@redhat.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Mon, 5 Feb 2018 12:22:18 +0100
MIME-Version: 1.0
In-Reply-To: <20180205102935.14736-1-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <8c8fc2e6-24b2-5206-9a75-9d5595623d9a@de.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v2] s390x/cpumodel: model PTFF subfunctions
 for Multiple-epoch facility
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>, qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: Cornelia Huck <cohuck@redhat.com>, Richard Henderson <rth@twiddle.net>, Alexander Graf <agraf@suse.de>, Thomas Huth <thuth@redhat.com>

Looks sane on a z14.
Tested-by: Christian Borntraeger <borntraeger@de.ibm.com>


On 02/05/2018 11:29 AM, David Hildenbrand wrote:
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

Do you also want to add something to check_consistency ?

Right now the following user error 
-cpu z14,mepoch=off,mepochptff=on
is accepted.
On the other hand we also have no consistency checks for other subfunctions.
