Received: from eggs.gnu.org ([2001:4830:134:3::10]:47913)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dUrhy-0002rB-Ad
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 05:43:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dUrhv-0003s2-8h
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 05:43:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59930)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1dUrhu-0003rl-VL
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 05:43:51 -0400
References: <1499700760-4777-1-git-send-email-thuth@redhat.com>
	<1499700760-4777-3-git-send-email-thuth@redhat.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <de3c0088-d12c-b2d7-d138-4013028f44f8@redhat.com>
Date: Tue, 11 Jul 2017 11:43:45 +0200
MIME-Version: 1.0
In-Reply-To: <1499700760-4777-3-git-send-email-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 02/10] pc-bios/s390-ccw: Move ebc2asc to
 sclp.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>
Cc: Alexander Graf <agraf@suse.de>, Farhan Ali <alifm@linux.vnet.ibm.com>, Viktor Mihajlovski <mihajlov@linux.vnet.ibm.com>, Alexey Kardashevskiy <aik@ozlabs.ru>

On 10.07.2017 17:32, Thomas Huth wrote:
> We will later need this array in a file that we will link to the
> netboot code, too. Since there is some ebcdic conversion done
> in sclp_get_loadparm_ascii(), the sclp.c file seems to be a good
> candidate.
> 
> Acked-by: Cornelia Huck <cohuck@redhat.com>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  pc-bios/s390-ccw/main.c | 11 -----------
>  pc-bios/s390-ccw/sclp.c | 11 +++++++++++
>  2 files changed, 11 insertions(+), 11 deletions(-)
> 
> diff --git a/pc-bios/s390-ccw/main.c b/pc-bios/s390-ccw/main.c
> index 40cba8d..0580eac 100644
> --- a/pc-bios/s390-ccw/main.c
> +++ b/pc-bios/s390-ccw/main.c
> @@ -17,17 +17,6 @@ static SubChannelId blk_schid = { .one = 1 };
>  IplParameterBlock iplb __attribute__((__aligned__(PAGE_SIZE)));
>  static char loadparm[8] = { 0, 0, 0, 0, 0, 0, 0, 0 };
>  
> -const unsigned char ebc2asc[256] =
> -      /* 0123456789abcdef0123456789abcdef */
> -        "................................" /* 1F */
> -        "................................" /* 3F */
> -        " ...........<(+|&.........!$*);." /* 5F first.chr.here.is.real.space */
> -        "-/.........,%_>?.........`:#@'=\""/* 7F */
> -        ".abcdefghi.......jklmnopqr......" /* 9F */
> -        "..stuvwxyz......................" /* BF */
> -        ".ABCDEFGHI.......JKLMNOPQR......" /* DF */
> -        "..STUVWXYZ......0123456789......";/* FF */
> -
>  /*
>   * Priniciples of Operations (SA22-7832-09) chapter 17 requires that
>   * a subsystem-identification is at 184-187 and bytes 188-191 are zero
> diff --git a/pc-bios/s390-ccw/sclp.c b/pc-bios/s390-ccw/sclp.c
> index aa1c862..2ee204a 100644
> --- a/pc-bios/s390-ccw/sclp.c
> +++ b/pc-bios/s390-ccw/sclp.c
> @@ -14,6 +14,17 @@
>  
>  static char _sccb[PAGE_SIZE] __attribute__((__aligned__(4096)));
>  
> +const unsigned char ebc2asc[256] =
> +      /* 0123456789abcdef0123456789abcdef */
> +        "................................" /* 1F */
> +        "................................" /* 3F */
> +        " ...........<(+|&.........!$*);." /* 5F first.chr.here.is.real.space */
> +        "-/.........,%_>?.........`:#@'=\""/* 7F */
> +        ".abcdefghi.......jklmnopqr......" /* 9F */
> +        "..stuvwxyz......................" /* BF */
> +        ".ABCDEFGHI.......JKLMNOPQR......" /* DF */
> +        "..STUVWXYZ......0123456789......";/* FF */
> +
>  /* Perform service call. Return 0 on success, non-zero otherwise. */
>  static int sclp_service_call(unsigned int command, void *sccb)
>  {
> 

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 

Thanks,

David
