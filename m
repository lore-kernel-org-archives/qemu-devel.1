Received: from eggs.gnu.org ([2001:4830:134:3::10]:55151)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alifm@linux.ibm.com>) id 1gXQbs-000321-1t
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 08:01:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alifm@linux.ibm.com>) id 1gXQbn-0007aC-V9
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 08:00:59 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:43424)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alifm@linux.ibm.com>) id 1gXQbn-0007QX-ES
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 08:00:55 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	wBDCxSBl140341
	for <qemu-devel@nongnu.org>; Thu, 13 Dec 2018 08:00:51 -0500
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2pbmrd1ppd-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 13 Dec 2018 08:00:51 -0500
Received: from localhost
	by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <alifm@linux.ibm.com>;
	Thu, 13 Dec 2018 13:00:50 -0000
References: <20181213120252.21697-1-peter.maydell@linaro.org>
From: Farhan Ali <alifm@linux.ibm.com>
Date: Thu, 13 Dec 2018 08:00:34 -0500
MIME-Version: 1.0
In-Reply-To: <20181213120252.21697-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <f64a08c4-1801-7677-06a5-f30fe0a07aaf@linux.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v2] hw/s390/ccw.c: Don't take address of
 packed members
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: patches@linaro.org, qemu-s390x@nongnu.org, David Hildenbrand <david@redhat.com>, Richard Henderson <rth@twiddle.net>, Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Thomas Huth <thuth@redhat.com>



On 12/13/2018 07:02 AM, Peter Maydell wrote:
> Taking the address of a field in a packed struct is a bad idea, because
> it might not be actually aligned enough for that pointer type (and
> thus cause a crash on dereference on some host architectures). Newer
> versions of clang warn about this.
> 
> Avoid the problem by using local copies of the PMCW and SCSW
> struct fields in copy_schib_from_guest() and copy_schib_to_guest().
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> v1->v2 changes:
>   * add comment about why we're using locals
>   * name locals with underscores, as QEMU's naming conventions recommend
> 
> 
>   hw/s390x/css.c | 28 ++++++++++++++++++++++++----
>   1 file changed, 24 insertions(+), 4 deletions(-)
> 
> diff --git a/hw/s390x/css.c b/hw/s390x/css.c
> index 04ec5cc9705..f92b046cd33 100644
> --- a/hw/s390x/css.c
> +++ b/hw/s390x/css.c
> @@ -1290,9 +1290,19 @@ void copy_scsw_to_guest(SCSW *dest, const SCSW *src)
>   static void copy_schib_to_guest(SCHIB *dest, const SCHIB *src)
>   {
>       int i;
> +    /*
> +     * We copy the PMCW and SCSW in and out of local variables to
> +     * avoid taking the address of members of a packed struct.
> +     */
> +    PMCW src_pmcw, dest_pmcw;
> +    SCSW src_scsw, dest_scsw;
>   
> -    copy_pmcw_to_guest(&dest->pmcw, &src->pmcw);
> -    copy_scsw_to_guest(&dest->scsw, &src->scsw);
> +    src_pmcw = src->pmcw;
> +    copy_pmcw_to_guest(&dest_pmcw, &src_pmcw);
> +    dest->pmcw = dest_pmcw;
> +    src_scsw = src->scsw;
> +    copy_scsw_to_guest(&dest_scsw, &src_scsw);
> +    dest->scsw = dest_scsw;
>       dest->mba = cpu_to_be64(src->mba);
>       for (i = 0; i < ARRAY_SIZE(dest->mda); i++) {
>           dest->mda[i] = src->mda[i];
> @@ -1339,9 +1349,19 @@ static void copy_scsw_from_guest(SCSW *dest, const SCSW *src)
>   static void copy_schib_from_guest(SCHIB *dest, const SCHIB *src)
>   {
>       int i;
> +    /*
> +     * We copy the PMCW and SCSW in and out of local variables to
> +     * avoid taking the address of members of a packed struct.
> +     */
> +    PMCW src_pmcw, dest_pmcw;
> +    SCSW src_scsw, dest_scsw;
>   
> -    copy_pmcw_from_guest(&dest->pmcw, &src->pmcw);
> -    copy_scsw_from_guest(&dest->scsw, &src->scsw);
> +    src_pmcw = src->pmcw;
> +    copy_pmcw_from_guest(&dest_pmcw, &src_pmcw);
> +    dest->pmcw = dest_pmcw;
> +    src_scsw = src->scsw;
> +    copy_scsw_from_guest(&dest_scsw, &src_scsw);
> +    dest->scsw = dest_scsw;
>       dest->mba = be64_to_cpu(src->mba);
>       for (i = 0; i < ARRAY_SIZE(dest->mda); i++) {
>           dest->mda[i] = src->mda[i];
> 

Reviewed-by: Farhan Ali <alifm@linux.ibm.com>
