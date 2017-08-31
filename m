Received: from eggs.gnu.org ([2001:4830:134:3::10]:47871)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dnOyJ-0001rf-Gb
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 08:53:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dnOyG-0007NL-FV
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 08:53:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35756)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1dnOyG-0007Mu-8G
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 08:53:20 -0400
References: <20170831121828.85885-1-pasic@linux.vnet.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <9df365ed-4c97-34b6-e739-360866929f5d@redhat.com>
Date: Thu, 31 Aug 2017 14:53:16 +0200
MIME-Version: 1.0
In-Reply-To: <20170831121828.85885-1-pasic@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/1] s390x/css: fix cc handling for XSCH
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Halil Pasic <pasic@linux.vnet.ibm.com>, Cornelia Huck <cohuck@redhat.com>
Cc: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>, Pierre Morel <pmorel@linux.vnet.ibm.com>, qemu-devel@nongnu.org

On 31.08.2017 14:18, Halil Pasic wrote:
> The function ioinst_handle_xsch is presenting cc 2 when it's supposed to
> present cc 1 and the other way around, because css_do_xsch has the error
> codes mixed up. Because cc 1 has precedence over cc 2 we also have to
> swap the two checks.
> 
> Let us fix this.
> 
> Signed-off-by: Halil Pasic <pasic@linux.vnet.ibm.com>
> Reported-by: Pierre Morel <pmorel@linux.vnet.ibm.com>
> ---
> 
> Was previously a part of a series (due to an accident the
> series had no name). This version also fixes the priority
> (aka precedence) problem.
> 
> ---
>  hw/s390x/css.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/hw/s390x/css.c b/hw/s390x/css.c
> index 1880b1a0ff..e04e0ea3a8 100644
> --- a/hw/s390x/css.c
> +++ b/hw/s390x/css.c
> @@ -1276,16 +1276,16 @@ int css_do_xsch(SubchDev *sch)
>          goto out;
>      }
>  
> +    if (s->ctrl & SCSW_CTRL_MASK_STCTL) {
> +        ret = -EINPROGRESS;
> +        goto out;
> +    }
> +
>      if (!(s->ctrl & SCSW_CTRL_MASK_FCTL) ||
>          ((s->ctrl & SCSW_CTRL_MASK_FCTL) != SCSW_FCTL_START_FUNC) ||
>          (!(s->ctrl &
>             (SCSW_ACTL_RESUME_PEND | SCSW_ACTL_START_PEND | SCSW_ACTL_SUSP))) ||
>          (s->ctrl & SCSW_ACTL_SUBCH_ACTIVE)) {
> -        ret = -EINPROGRESS;
> -        goto out;
> -    }
> -
> -    if (s->ctrl & SCSW_CTRL_MASK_STCTL) {
>          ret = -EBUSY;
>          goto out;
>      }
> 

Reviewed-by: Thomas Huth <thuth@redhat.com>
