Received: from eggs.gnu.org ([2001:4830:134:3::10]:60786)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alifm@linux.ibm.com>) id 1gWN1J-0000kH-By
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 09:58:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alifm@linux.ibm.com>) id 1gWN1F-0006Mt-CR
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 09:58:53 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:58348
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alifm@linux.ibm.com>) id 1gWN1F-0006Lv-6U
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 09:58:49 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	wBAEs0ZZ183533
	for <qemu-devel@nongnu.org>; Mon, 10 Dec 2018 09:58:47 -0500
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2p9s6741kw-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 10 Dec 2018 09:58:47 -0500
Received: from localhost
	by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <alifm@linux.ibm.com>;
	Mon, 10 Dec 2018 14:58:46 -0000
References: <20181210135803.20208-1-peter.maydell@linaro.org>
From: Farhan Ali <alifm@linux.ibm.com>
Date: Mon, 10 Dec 2018 09:58:42 -0500
MIME-Version: 1.0
In-Reply-To: <20181210135803.20208-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <10299eda-e310-5711-cb09-f3b725daec90@linux.ibm.com>
Subject: Re: [Qemu-devel] [PATCH] hw/s390/ccw.c: Don't take address of
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
Cc: David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org, patches@linaro.org, Richard Henderson <rth@twiddle.net>



On 12/10/2018 08:58 AM, Peter Maydell wrote:
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
> This seemed like a not totally ugly and reasonably localised fix
> that satisfies clang. Oddly, this makes the generated object file
> 15K smaller (421K vs 406K), so it might even be better code...
> 
>   hw/s390x/css.c | 20 ++++++++++++++++----
>   1 file changed, 16 insertions(+), 4 deletions(-)
> 
> diff --git a/hw/s390x/css.c b/hw/s390x/css.c
> index 04ec5cc9705..ef07691e36b 100644
> --- a/hw/s390x/css.c
> +++ b/hw/s390x/css.c
> @@ -1290,9 +1290,15 @@ void copy_scsw_to_guest(SCSW *dest, const SCSW *src)
>   static void copy_schib_to_guest(SCHIB *dest, const SCHIB *src)
>   {
>       int i;
> +    PMCW srcpmcw, destpmcw;
> +    SCSW srcscsw, destscsw;
> 
> -    copy_pmcw_to_guest(&dest->pmcw, &src->pmcw);
> -    copy_scsw_to_guest(&dest->scsw, &src->scsw);
> +    srcpmcw = src->pmcw;
> +    copy_pmcw_to_guest(&destpmcw, &srcpmcw);
> +    dest->pmcw = destpmcw;
> +    srcscsw = src->scsw;
> +    copy_scsw_to_guest(&destscsw, &srcscsw);
> +    dest->scsw = destscsw;
>       dest->mba = cpu_to_be64(src->mba);
>       for (i = 0; i < ARRAY_SIZE(dest->mda); i++) {
>           dest->mda[i] = src->mda[i];
> @@ -1339,9 +1345,15 @@ static void copy_scsw_from_guest(SCSW *dest, const SCSW *src)
>   static void copy_schib_from_guest(SCHIB *dest, const SCHIB *src)
>   {
>       int i;
> +    PMCW srcpmcw, destpmcw;
> +    SCSW srcscsw, destscsw;
> 
> -    copy_pmcw_from_guest(&dest->pmcw, &src->pmcw);
> -    copy_scsw_from_guest(&dest->scsw, &src->scsw);
> +    srcpmcw = src->pmcw;
> +    copy_pmcw_from_guest(&destpmcw, &srcpmcw);
> +    dest->pmcw = destpmcw;
> +    srcscsw = src->scsw;
> +    copy_scsw_from_guest(&destscsw, &srcscsw);
> +    dest->scsw = destscsw;
>       dest->mba = be64_to_cpu(src->mba);
>       for (i = 0; i < ARRAY_SIZE(dest->mda); i++) {
>           dest->mda[i] = src->mda[i];
> 

Reviewed-by: Farhan Ali <alifm@linux.ibm.com>
