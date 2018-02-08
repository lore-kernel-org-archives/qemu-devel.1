Received: from eggs.gnu.org ([2001:4830:134:3::10]:33188)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1ejl8h-0001Cz-Hg
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 07:17:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1ejl8d-0002v1-IV
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 07:17:19 -0500
Received: from 10.mo68.mail-out.ovh.net ([46.105.79.203]:36909)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1ejl8d-0002uC-Bl
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 07:17:15 -0500
Received: from player711.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo68.mail-out.ovh.net (Postfix) with ESMTP id BAF23C4A96
	for <qemu-devel@nongnu.org>; Thu,  8 Feb 2018 13:17:13 +0100 (CET)
Date: Thu, 8 Feb 2018 13:03:19 +0100
From: Greg Kurz <groug@kaod.org>
Message-ID: <20180208130319.53d9f654@bahia.lan>
In-Reply-To: <20180208094241.13839-1-lvivier@redhat.com>
References: <20180208094241.13839-1-lvivier@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH v2] spapr: check smp_threads <=
 vsmt
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <lvivier@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

On Thu,  8 Feb 2018 10:42:41 +0100
Laurent Vivier <lvivier@redhat.com> wrote:

> We ignore silently the value of smp_threads when we set
> the default VSMT value, and if smp_threads is greater than VSMT
> kernel is going into trouble later.
> 
> Fixes: 8904e5a750
> ("spapr: Adjust default VSMT value for better migration compatibility")
> 
> Signed-off-by: Laurent Vivier <lvivier@redhat.com>
> ---
> 

Reviewed-by: Greg Kurz <groug@kaod.org>

> Notes:
>     v2: display a specific error message when the default VSMT is used
>         fix subject
> 
>  hw/ppc/spapr.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 32a876be56..11de276cd5 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -2311,6 +2311,12 @@ static void spapr_set_vsmt_mode(sPAPRMachineState *spapr, Error **errp)
>           * overwhelmingly common case in production systems.
>           */
>          spapr->vsmt = 8;
> +        if (spapr->vsmt < smp_threads) {
> +            error_setg(&local_err, "Cannot support %d threads/core"
> +                         " because it must be <= to default VSMT mode (%d)",
> +                         smp_threads, spapr->vsmt);
> +            goto out;
> +        }
>      }
>  
>      /* KVM: If necessary, set the SMT mode: */
