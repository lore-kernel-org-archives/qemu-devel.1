Received: from eggs.gnu.org ([2001:4830:134:3::10]:51129)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1db0Q9-0001E8-Oo
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 04:14:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1db0Q3-0006Ph-G4
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 04:14:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51242)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1db0Q3-0006KB-6i
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 04:14:47 -0400
Date: Fri, 28 Jul 2017 10:14:41 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20170728101441.24d64f14@gondolin>
In-Reply-To: <20170727154842.23427-1-pasic@linux.vnet.ibm.com>
References: <20170727154842.23427-1-pasic@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 1/1] s390x/css: check ccw address
 validity
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Halil Pasic <pasic@linux.vnet.ibm.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>, qemu-devel@nongnu.org

On Thu, 27 Jul 2017 17:48:42 +0200
Halil Pasic <pasic@linux.vnet.ibm.com> wrote:

> According to the PoP channel command words (CCW) must be doubleword
> aligned and 31 bit addressable for format 1 and 24 bit addressable for
> format 0 CCWs.
> 
> If the channel subsystem encounters ccw address which does not satisfy

missing 'a' (fixed up while applying)

> this alignment requirement a program-check condition is recognised.
> 
> The situation with 31 bit addressable is a bit more complicated: both the
> ORB and a format 1 CCW TIC hold the address of (the rest of) the channel
> program, that is the address of the next CCW in a word, and the PoP
> mandates that bit 0 of that word shall be zero -- or a program-check
> condition is to be recognized -- and does not belong to the field holding
> the ccw address.
> 
> Since in code the corresponding fields span across the whole word (unlike
> in PoP where these are defined as 31 bit wide) we can check this by
> applying a mask. The 24 addressable case isn't affecting TIC because the
> address is composed of a halfword and a byte portion (no additional zero
> bit requirements) and just slightly complicates the ORB case where also
> bits 1-7 need to be zero.
> 
> The same requirements (especially n-bit addressability) apply to the
> ccw addresses generated while chaining.
> 
> Let's make our CSS implementation follow the AR more closely.
> 
> Signed-off-by: Halil Pasic <pasic@linux.vnet.ibm.com>
> ---
> 
> This patch used to be a patch used to be a part of the series 'ccw
> interpretation AR compliance improvements' but the other patch was
> already applied.
> 
> I would still like this one being in front of '390x/css: fix bits must be
> zero check for TIC' as the commit message of that change relies the
> changes done in this patch.

No worries, I've switched the patches around.

> 
> v1 -> v2
> * fixed condition (precedence was wrong -- thanks Dong Jia)
> * check on each iteration when chaining (every ccw of the channel
> program needs to be 31 or 24 bit addressable (if touched), not only
> the addresses in TIC and ORB)
> ---
>  hw/s390x/css.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/hw/s390x/css.c b/hw/s390x/css.c
> index 6a42b95cee..177cbfc92d 100644
> --- a/hw/s390x/css.c
> +++ b/hw/s390x/css.c
> @@ -795,6 +795,10 @@ static int css_interpret_ccw(SubchDev *sch, hwaddr ccw_addr,
>      if (!ccw_addr) {
>          return -EIO;
>      }
> +    /* Check doubleword aligned and 31 or 24 (fmt 0) bit addressable. */
> +    if (ccw_addr & (sch->ccw_fmt_1 ? 0x80000007 : 0xff000007)) {
> +        return -EINVAL;
> +    }

I like that this has now collapsed to that one check :)

>  
>      /* Translate everything to format-1 ccws - the information is the same. */
>      ccw = copy_ccw_from_guest(ccw_addr, sch->ccw_fmt_1);

Thanks, applied.
