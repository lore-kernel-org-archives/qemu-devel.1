Received: from eggs.gnu.org ([2001:4830:134:3::10]:42843)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1eJdOw-000345-Kq
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 05:46:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1eJdOt-0006oS-G8
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 05:46:06 -0500
Date: Tue, 28 Nov 2017 11:45:58 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20171128114558.5284f736.cohuck@redhat.com>
In-Reply-To: <1511816136-30068-2-git-send-email-walling@linux.vnet.ibm.com>
References: <1511816136-30068-1-git-send-email-walling@linux.vnet.ibm.com>
	<1511816136-30068-2-git-send-email-walling@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 1/5] s390-ccw: update libc.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Collin L. Walling" <walling@linux.vnet.ibm.com>
Cc: borntraeger@de.ibm.com, frankja@linux.vnet.ibm.com, qemu-s390x@nongnu.org, qemu-devel@nongnu.org

On Mon, 27 Nov 2017 15:55:32 -0500
"Collin L. Walling" <walling@linux.vnet.ibm.com> wrote:

> Moved:
>   memcmp from bootmap.h to libc.h (renamed from _memcmp)
>   strlen from sclp.c to libc.h (renamed from _strlen)
> 
> Added C standard functions:
>   isdigit
>   atoi
> 
> Added non-C standard function:
>   itostr
> 
> Signed-off-by: Collin L. Walling <walling@linux.vnet.ibm.com>
> Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>
> Reviewed-by: frankja@linux.vnet.ibm.com

You might want to include Janosch's complete name :)

> ---
>  pc-bios/s390-ccw/bootmap.c |  4 +-
>  pc-bios/s390-ccw/bootmap.h | 16 +-------
>  pc-bios/s390-ccw/libc.h    | 94 ++++++++++++++++++++++++++++++++++++++++++++++
>  pc-bios/s390-ccw/main.c    | 17 +--------
>  pc-bios/s390-ccw/sclp.c    | 10 +----
>  5 files changed, 99 insertions(+), 42 deletions(-)
> 

> diff --git a/pc-bios/s390-ccw/libc.h b/pc-bios/s390-ccw/libc.h
> index 0142ea8..703c34d 100644
> --- a/pc-bios/s390-ccw/libc.h
> +++ b/pc-bios/s390-ccw/libc.h

(...)

> +/* itostr
> + *
> + * Given an integer, convert it to a string. The string must be allocated
> + * beforehand. The resulting string will be null terminated and returned.
> + *
> + * @str - the integer to be converted
> + * @num - a pointer to a string to store the conversion
> + *
> + * @return - the string of the converted integer
> + */

That one's a bit unusual as it does not match the semantics of any
library function I'd normally use for that kind of thing, but it seems
to do the job and more would be overkill, so fine with me.

> +static inline char *itostr(int num, char *str)
> +{
> +    int i;
> +    int len = 0;
> +    long tens = 1;
> +
> +    /* Handle 0 */
> +    if (num == 0) {
> +        str[0] = '0';
> +        str[1] = '\0';
> +        return str;
> +    }
> +
> +    /* Count number of digits */
> +    while (num / tens != 0) {
> +        tens *= 10;
> +        len++;
> +    }
> +
> +    /* Convert int -> string */
> +    for (i = 0; i < len; i++) {
> +        tens /= 10;
> +        str[i] = num / tens % 10 + '0';
> +    }
> +
> +    str[i] = '\0';
> +
> +    return str;
> +}
> +
>  #endif
