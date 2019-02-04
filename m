Received: from eggs.gnu.org ([209.51.188.92]:46018)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gqc2o-0007Bu-E7
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 06:04:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gqc2n-000639-JW
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 06:04:06 -0500
Date: Mon, 4 Feb 2019 12:03:59 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20190204120359.70a0e511.cohuck@redhat.com>
In-Reply-To: <1548768562-20007-10-git-send-email-jjherne@linux.ibm.com>
References: <1548768562-20007-1-git-send-email-jjherne@linux.ibm.com>
	<1548768562-20007-10-git-send-email-jjherne@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 09/15] s390-bios: ptr2u32 and u32toptr
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Jason J. Herne" <jjherne@linux.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, pasic@linux.ibm.com, alifm@linux.ibm.com, borntraeger@de.ibm.com

On Tue, 29 Jan 2019 08:29:16 -0500
"Jason J. Herne" <jjherne@linux.ibm.com> wrote:

> Introduce inline functions to convert between pointers and unsigned 32-bit
> ints. These are used to hide the ugliness required to  avoid compiler
> warnings.
> 
> Signed-off-by: Jason J. Herne <jjherne@linux.ibm.com>
> ---
>  pc-bios/s390-ccw/libc.h | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/pc-bios/s390-ccw/libc.h b/pc-bios/s390-ccw/libc.h
> index 818517f..e198f0b 100644
> --- a/pc-bios/s390-ccw/libc.h
> +++ b/pc-bios/s390-ccw/libc.h
> @@ -19,6 +19,18 @@ typedef unsigned short     uint16_t;
>  typedef unsigned int       uint32_t;
>  typedef unsigned long long uint64_t;
>  
> +/* Avoids compiler warnings when casting a pointer to a u32 */
> +static inline uint32_t ptr2u32(void *ptr)
> +{
> +    return (uint32_t)(uint64_t)ptr;
> +}
> +
> +/* Avoids compiler warnings when casting a u32 to a pointer */
> +static inline void *u32toptr(uint32_t n)
> +{
> +    return (void *)(uint64_t)n;
> +}
> +
>  static inline void *memset(void *s, int c, size_t n)
>  {
>      size_t i;

Ugly, but I hope any users of these already know what they're doing :)

Acked-by: Cornelia Huck <cohuck@redhat.com>
