Received: from eggs.gnu.org ([2001:4830:134:3::10]:40300)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1f6zqA-0004Bm-Dl
	for qemu-devel@nongnu.org; Fri, 13 Apr 2018 10:38:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1f6zq7-00061n-Af
	for qemu-devel@nongnu.org; Fri, 13 Apr 2018 10:38:14 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <1523629847-22369-1-git-send-email-thuth@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <0a7eee8b-1196-7217-6dd8-a8f3752abce9@amsat.org>
Date: Fri, 13 Apr 2018 11:37:45 -0300
MIME-Version: 1.0
In-Reply-To: <1523629847-22369-1-git-send-email-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
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
Cc: Collin Walling <walling@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>, qemu-devel@nongnu.org

On 04/13/2018 11:30 AM, Thomas Huth wrote:
> "size_t" should be an unsigned type - the signed counterpart is called
> "ssize_t" in the C standard instead. Thus we should also use this
> convention in the s390-ccw firmware to avoid confusion. I checked the
> sources, and apart from one spot in libc.c (which now uses ssize_t with
> this patch), the code should all be fine with this change.
> 
> Buglink: https://bugs.launchpad.net/qemu/+bug/1753437
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

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
