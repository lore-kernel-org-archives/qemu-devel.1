Received: from eggs.gnu.org ([2001:4830:134:3::10]:50196)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gXKYC-0001Ft-Iv
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 01:32:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gXKY7-0005fs-Ja
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 01:32:48 -0500
References: <20181210135803.20208-1-peter.maydell@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <b26019e6-9ad7-229b-4ad5-c47273919bba@redhat.com>
Date: Thu, 13 Dec 2018 07:32:29 +0100
MIME-Version: 1.0
In-Reply-To: <20181210135803.20208-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [qemu-s390x] [PATCH] hw/s390/ccw.c: Don't take
 address of packed members
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

On 2018-12-10 14:58, Peter Maydell wrote:
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
>  hw/s390x/css.c | 20 ++++++++++++++++----
>  1 file changed, 16 insertions(+), 4 deletions(-)
> 
> diff --git a/hw/s390x/css.c b/hw/s390x/css.c
> index 04ec5cc9705..ef07691e36b 100644
> --- a/hw/s390x/css.c
> +++ b/hw/s390x/css.c
> @@ -1290,9 +1290,15 @@ void copy_scsw_to_guest(SCSW *dest, const SCSW *src)
>  static void copy_schib_to_guest(SCHIB *dest, const SCHIB *src)
>  {
>      int i;
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
>      dest->mba = cpu_to_be64(src->mba);
>      for (i = 0; i < ARRAY_SIZE(dest->mda); i++) {
>          dest->mda[i] = src->mda[i];
> @@ -1339,9 +1345,15 @@ static void copy_scsw_from_guest(SCSW *dest, const SCSW *src)
>  static void copy_schib_from_guest(SCHIB *dest, const SCHIB *src)
>  {
>      int i;
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
>      dest->mba = be64_to_cpu(src->mba);
>      for (i = 0; i < ARRAY_SIZE(dest->mda); i++) {
>          dest->mda[i] = src->mda[i];
> 

May I suggest to add a comment to the code here a la:

  /* Use a local copy to avoid unaligned access to packed structs */

or something similar? Otherwise, I'm pretty sure somebody will revert
this in a couple of years because they thinks the local copy is not
really necessary here...

 Thomas
