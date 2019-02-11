Received: from eggs.gnu.org ([209.51.188.92]:54119)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.ibm.com>) id 1gtIZr-0008Dt-NY
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 15:53:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.ibm.com>) id 1gtIZq-0007Iq-Vx
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 15:53:19 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:50792
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.ibm.com>)
	id 1gtIZq-0007Ie-Pu
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 15:53:18 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x1BKnII7038417
	for <qemu-devel@nongnu.org>; Mon, 11 Feb 2019 15:53:18 -0500
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2qkexn3s3g-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 11 Feb 2019 15:53:17 -0500
Received: from localhost
	by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.ibm.com>;
	Mon, 11 Feb 2019 20:53:17 -0000
References: <1549897385-10091-1-git-send-email-liam.merwick@oracle.com>
From: Stefan Berger <stefanb@linux.ibm.com>
Date: Mon, 11 Feb 2019 15:53:13 -0500
MIME-Version: 1.0
In-Reply-To: <1549897385-10091-1-git-send-email-liam.merwick@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-MW
Message-Id: <b00f6445-6288-24fa-9d30-b470a988331d@linux.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v2 1/3] tpm_tis: fix loop that cancels any
 seizure by a lower locality
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Liam Merwick <liam.merwick@oracle.com>, qemu-devel@nongnu.org

On 2/11/19 10:03 AM, Liam Merwick wrote:
> In tpm_tis_mmio_write() if the requesting locality is seizing
> access, any seizure by a lower locality is cancelled.  However the
> loop doing the seizure had an off-by-one error and the locality
> immediately preceding the requesting locality was not being cleared.
> This is fixed by adjusting the test in the for loop to check the
> localities up to the requesting locality.
>
> Signed-off-by: Liam Merwick <Liam.Merwick@oracle.com>
> ---
>   hw/tpm/tpm_tis.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/hw/tpm/tpm_tis.c b/hw/tpm/tpm_tis.c
> index fd6bb9b59a96..61a130beef35 100644
> --- a/hw/tpm/tpm_tis.c
> +++ b/hw/tpm/tpm_tis.c
> @@ -624,7 +624,7 @@ static void tpm_tis_mmio_write(void *opaque, hwaddr addr,
>                   }
>   
>                   /* cancel any seize by a lower locality */
> -                for (l = 0; l < locty - 1; l++) {
> +                for (l = 0; l < locty; l++) {
>                       s->loc[l].access &= ~TPM_TIS_ACCESS_SEIZE;
>                   }
>   


Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
