Received: from eggs.gnu.org ([2001:4830:134:3::10]:54867)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <walling@linux.ibm.com>) id 1f705d-0000VF-Fj
	for qemu-devel@nongnu.org; Fri, 13 Apr 2018 10:54:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <walling@linux.ibm.com>) id 1f705Y-0008P5-RQ
	for qemu-devel@nongnu.org; Fri, 13 Apr 2018 10:54:13 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:39340)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <walling@linux.ibm.com>)
	id 1f705Y-0008OY-JE
	for qemu-devel@nongnu.org; Fri, 13 Apr 2018 10:54:08 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w3DEq58q026756
	for <qemu-devel@nongnu.org>; Fri, 13 Apr 2018 10:54:06 -0400
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2hav5h86ge-1
	(version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 13 Apr 2018 10:54:06 -0400
Received: from localhost
	by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <walling@linux.ibm.com>;
	Fri, 13 Apr 2018 10:54:05 -0400
References: <1523629847-22369-1-git-send-email-thuth@redhat.com>
From: Collin Walling <walling@linux.ibm.com>
Date: Fri, 13 Apr 2018 10:54:03 -0400
MIME-Version: 1.0
In-Reply-To: <1523629847-22369-1-git-send-email-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <82bc6a4d-c51f-ee71-39e5-f37f24a4927c@linux.ibm.com>
Subject: Re: [Qemu-devel] [PATCH for-2.13] pc-bios/s390-ccw: size_t should
 be unsigned
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org
Cc: Cornelia Huck <cohuck@redhat.com>, qemu-devel@nongnu.org

On 04/13/2018 10:30 AM, Thomas Huth wrote:
> "size_t" should be an unsigned type - the signed counterpart is called
> "ssize_t" in the C standard instead. Thus we should also use this
> convention in the s390-ccw firmware to avoid confusion. I checked the
> sources, and apart from one spot in libc.c (which now uses ssize_t with
> this patch), the code should all be fine with this change.
> 
> Buglink: https://bugs.launchpad.net/qemu/+bug/1753437
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  pc-bios/s390-ccw/libc.c | 2 +-
>  pc-bios/s390-ccw/libc.h | 3 ++-
>  2 files changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/pc-bios/s390-ccw/libc.c b/pc-bios/s390-ccw/libc.c
> index 38ea77d..827d204 100644
> --- a/pc-bios/s390-ccw/libc.c
> +++ b/pc-bios/s390-ccw/libc.c
> @@ -63,7 +63,7 @@ uint64_t atoui(const char *str)
>   */
>  char *uitoa(uint64_t num, char *str, size_t len)
>  {
> -    size_t num_idx = 1; /* account for NUL */
> +    ssize_t num_idx = 1; /* account for NUL */
>      uint64_t tmp = num;
>  
>      IPL_assert(str != NULL, "uitoa: no space allocated to store string");
> diff --git a/pc-bios/s390-ccw/libc.h b/pc-bios/s390-ccw/libc.h
> index 63ece70..57c4199 100644
> --- a/pc-bios/s390-ccw/libc.h
> +++ b/pc-bios/s390-ccw/libc.h
> @@ -12,7 +12,8 @@
>  #ifndef S390_CCW_LIBC_H
>  #define S390_CCW_LIBC_H
>  
> -typedef long               size_t;
> +typedef unsigned long      size_t;
> +typedef signed long        ssize_t;
>  typedef int                bool;
>  typedef unsigned char      uint8_t;
>  typedef unsigned short     uint16_t;
> 

Looks good to me as well.

If another r-b is even necessary:

Reviewed-by: Collin Walling <walling@linux.ibm.com>

-- 
Respectfully,
- Collin Walling
