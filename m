Received: from eggs.gnu.org ([2001:4830:134:3::10]:44167)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1fTLrZ-0004Ub-Ds
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 02:36:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1fTLrW-0008TS-97
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 02:36:05 -0400
Received: from 11.mo5.mail-out.ovh.net ([46.105.47.167]:58681)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1fTLrW-0008TA-2I
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 02:36:02 -0400
Received: from player738.ha.ovh.net (unknown [10.109.122.28])
	by mo5.mail-out.ovh.net (Postfix) with ESMTP id 056531BC9A9
	for <qemu-devel@nongnu.org>; Thu, 14 Jun 2018 08:35:59 +0200 (CEST)
Date: Thu, 14 Jun 2018 08:35:52 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20180614083552.4c6a9085@bahia.lab.toulouse-stg.fr.ibm.com>
In-Reply-To: <20180614044129.13606-3-david@gibson.dropbear.id.au>
References: <20180614044129.13606-1-david@gibson.dropbear.id.au>
	<20180614044129.13606-3-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCHv3 2/7] pnv: Fix some error handling cpu
 realize()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: clg@kaod.org, qemu-devel@nongnu.org, qemu-ppc@nongnu.org

On Thu, 14 Jun 2018 14:41:24 +1000
David Gibson <david@gibson.dropbear.id.au> wrote:

> In pnv_core_realize() we call two functions with an Error * parameter in
> succession, which will go badly if they both cause errors.  In fact, a
> failure in either of them indicates a qemu internal error, so we can just
> use &error_abort in both cases.
> 
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> ---

Reviewed-by: Greg Kurz <groug@kaod.org>

>  hw/ppc/pnv_core.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/hw/ppc/pnv_core.c b/hw/ppc/pnv_core.c
> index 13ad7d9e04..01f47c8037 100644
> --- a/hw/ppc/pnv_core.c
> +++ b/hw/ppc/pnv_core.c
> @@ -172,12 +172,9 @@ static void pnv_core_realize(DeviceState *dev, Error **errp)
>          object_initialize(obj, size, typename);
>  
>          snprintf(name, sizeof(name), "thread[%d]", i);
> -        object_property_add_child(OBJECT(pc), name, obj, &local_err);
> +        object_property_add_child(OBJECT(pc), name, obj, &error_abort);
>          object_property_add_alias(obj, "core-pir", OBJECT(pc),
> -                                  "pir", &local_err);
> -        if (local_err) {
> -            goto err;
> -        }
> +                                  "pir", &error_abort);
>          object_unref(obj);
>      }
>  
