Received: from eggs.gnu.org ([2001:4830:134:3::10]:40195)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fEG2C-0006qz-5v
	for qemu-devel@nongnu.org; Thu, 03 May 2018 11:20:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fEG2B-0004Xg-4i
	for qemu-devel@nongnu.org; Thu, 03 May 2018 11:20:40 -0400
References: <20180502125221.4877-1-cohuck@redhat.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <72d0bc42-ee4f-9743-26d4-677765f17ec4@redhat.com>
Date: Thu, 3 May 2018 17:20:35 +0200
MIME-Version: 1.0
In-Reply-To: <20180502125221.4877-1-cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [qemu-s390x] [PATCH] s390-ccw: force diag 308
 subcode to unsigned long
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Thomas Huth <thuth@redhat.com>
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org, qemu-stable@nongnu.org

On 02.05.2018 14:52, Cornelia Huck wrote:
> We currently pass an integer as the subcode parameter. However,
> the upper bits of the register containing the subcode need to
> be 0, which is not guaranteed unless we explicitly specify the
> subcode to be an unsigned long value.
> 
> Fixes: d046c51dad3 ("pc-bios/s390-ccw: Get device address via diag 308/6")
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
> ---
>  pc-bios/s390-ccw/iplb.h | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/pc-bios/s390-ccw/iplb.h b/pc-bios/s390-ccw/iplb.h
> index 5357a36d51..ded20c834e 100644
> --- a/pc-bios/s390-ccw/iplb.h
> +++ b/pc-bios/s390-ccw/iplb.h
> @@ -101,10 +101,11 @@ static inline bool manage_iplb(IplParameterBlock *iplb, bool store)
>  {
>      register unsigned long addr asm("0") = (unsigned long) iplb;
>      register unsigned long rc asm("1") = 0;
> +    unsigned long subcode = store ? 6 : 5;
>  
>      asm volatile ("diag %0,%2,0x308\n"
>                    : "+d" (addr), "+d" (rc)
> -                  : "d" (store ? 6 : 5)
> +                  : "d" (subcode)
>                    : "memory", "cc");
>      return rc == 0x01;
>  }
> 

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 

Thanks,

David / dhildenb
