Received: from eggs.gnu.org ([2001:4830:134:3::10]:57891)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <walling@linux.ibm.com>) id 1f85Bf-00073M-0b
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 10:32:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <walling@linux.ibm.com>) id 1f85BZ-0008MW-Ux
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 10:32:55 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:41734
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <walling@linux.ibm.com>)
	id 1f85BZ-0008M6-Po
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 10:32:49 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w3GER4Fu107091
	for <qemu-devel@nongnu.org>; Mon, 16 Apr 2018 10:32:49 -0400
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2hcwe2rwfs-1
	(version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 16 Apr 2018 10:32:48 -0400
Received: from localhost
	by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <walling@linux.ibm.com>;
	Mon, 16 Apr 2018 10:32:48 -0400
References: <1523864720-4680-1-git-send-email-thuth@redhat.com>
From: Collin Walling <walling@linux.ibm.com>
Date: Mon, 16 Apr 2018 10:32:45 -0400
MIME-Version: 1.0
In-Reply-To: <1523864720-4680-1-git-send-email-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <12c50e1f-0bcc-1eb7-502c-d772a8b47790@linux.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v2 for-2.13] pc-bios/s390-ccw: size_t
 should be unsigned
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org
Cc: Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.vnet.ibm.com>, qemu-devel@nongnu.org, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>

On 04/16/2018 03:45 AM, Thomas Huth wrote:
> "size_t" should be an unsigned type according to the C standard.
> Thus we should also use this convention in the s390-ccw firmware to avoid
> confusion. I checked the sources, and apart from one spot in libc.c, the
> code should all be fine with this change.
> 
> Buglink: https://bugs.launchpad.net/qemu/+bug/1753437
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  v2: Use long instead of ssize_t in uitoa()
> 
>  pc-bios/s390-ccw/libc.c | 2 +-
>  pc-bios/s390-ccw/libc.h | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/pc-bios/s390-ccw/libc.c b/pc-bios/s390-ccw/libc.c
> index 38ea77d..a786566 100644
> --- a/pc-bios/s390-ccw/libc.c
> +++ b/pc-bios/s390-ccw/libc.c
> @@ -63,7 +63,7 @@ uint64_t atoui(const char *str)
>   */
>  char *uitoa(uint64_t num, char *str, size_t len)
>  {
> -    size_t num_idx = 1; /* account for NUL */
> +    long num_idx = 1; /* account for NUL */
>      uint64_t tmp = num;
>  
>      IPL_assert(str != NULL, "uitoa: no space allocated to store string");
> diff --git a/pc-bios/s390-ccw/libc.h b/pc-bios/s390-ccw/libc.h
> index 63ece70..818517f 100644
> --- a/pc-bios/s390-ccw/libc.h
> +++ b/pc-bios/s390-ccw/libc.h
> @@ -12,7 +12,7 @@
>  #ifndef S390_CCW_LIBC_H
>  #define S390_CCW_LIBC_H
>  
> -typedef long               size_t;
> +typedef unsigned long      size_t;
>  typedef int                bool;
>  typedef unsigned char      uint8_t;
>  typedef unsigned short     uint16_t;
> 

Reviewed-by: Collin Walling <walling@linux.ibm.com>

-- 
Respectfully,
- Collin Walling
