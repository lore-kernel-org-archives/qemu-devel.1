Received: from eggs.gnu.org ([2001:4830:134:3::10]:43252)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1daeDT-0008SF-MJ
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 04:32:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1daeDS-0008LS-Vc
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 04:32:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55692)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1daeDS-0008L3-QQ
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 04:32:18 -0400
Date: Thu, 27 Jul 2017 10:32:14 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20170727103214.3b3070b2@gondolin>
In-Reply-To: <20170725224442.13383-3-pasic@linux.vnet.ibm.com>
References: <20170725224442.13383-1-pasic@linux.vnet.ibm.com>
	<20170725224442.13383-3-pasic@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 2/2] s390x/css: fix bits must be zero check
 for TIC
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Halil Pasic <pasic@linux.vnet.ibm.com>, Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, qemu-devel@nongnu.org

On Wed, 26 Jul 2017 00:44:42 +0200
Halil Pasic <pasic@linux.vnet.ibm.com> wrote:

> According to the PoP bit positions 0-3 and 8-32 of the format-1 CCW must
> contain zeros.  Bits 0-3 are already covered by cmd_code validity
> checking, and bit 32 is covered by the CCW address checking.
> 
> Bits 8-31 correspond to CCW1.flags and CCW1.count.  Currently we only
> check for the absence of certain flags.  Let's fix this.
> 
> Signed-off-by: Halil Pasic <pasic@linux.vnet.ibm.com>
> ---
>  hw/s390x/css.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/s390x/css.c b/hw/s390x/css.c
> index d17e21b7af..1f04ce4a1b 100644
> --- a/hw/s390x/css.c
> +++ b/hw/s390x/css.c
> @@ -884,7 +884,8 @@ static int css_interpret_ccw(SubchDev *sch, hwaddr ccw_addr,
>              ret = -EINVAL;
>              break;
>          }
> -        if (ccw.flags & (CCW_FLAG_CC | CCW_FLAG_DC)) {
> +        if (ccw.flags || ccw.count) {
> +            /* We have already sanitized these if fmt 0. */
>              ret = -EINVAL;
>              break;
>          }

Thanks, applied (with tweaked comment).

Dong Jia: I've added your R-b, please let me know if that's not ok.
