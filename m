Received: from eggs.gnu.org ([2001:4830:134:3::10]:39302)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1f8UcU-0002yk-7A
	for qemu-devel@nongnu.org; Tue, 17 Apr 2018 13:42:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1f8UcR-0003b1-1a
	for qemu-devel@nongnu.org; Tue, 17 Apr 2018 13:42:18 -0400
Received: from 5.mo178.mail-out.ovh.net ([46.105.51.53]:40644)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1f8UcQ-0003VZ-Pr
	for qemu-devel@nongnu.org; Tue, 17 Apr 2018 13:42:14 -0400
Received: from player772.ha.ovh.net (unknown [10.109.120.63])
	by mo178.mail-out.ovh.net (Postfix) with ESMTP id 90EAE1064D
	for <qemu-devel@nongnu.org>; Tue, 17 Apr 2018 19:42:05 +0200 (CEST)
Date: Tue, 17 Apr 2018 19:17:51 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20180417191751.709bb564@bahia.lan>
In-Reply-To: <1523982095-17175-1-git-send-email-spopovyc@redhat.com>
References: <1523982095-17175-1-git-send-email-spopovyc@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH for 2.13] spapr: Correct max
 associativity domains value for non-NUMA configs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Serhii Popovych <spopovyc@redhat.com>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

Cc'ing David who should always be in the recipient list when posting ppc related
patches :)

On Tue, 17 Apr 2018 12:21:35 -0400
Serhii Popovych <spopovyc@redhat.com> wrote:

> In non-NUMA configurations nb_numa_nodes is zero and we set 5th cell
> in ibm,max-associativity-domains to -1. That causes to stall Linux
> guests during boot after following line:
> 
> [    0.000000] NUMA associativity depth for CPU/Memory: 4
> 
> Make last possible NUMA in property zero to correct support for
> non-NUMA guests.
> 

Alternatively, as suggested by David in some other mail, you could drop the
property in this case. I've checked it fixes the hang too, and it probably
makes more sense than exposing only zeroes.

> Fixes: c1df49a670ef ("spapr: Add ibm,max-associativity-domains property")

Since c1df49a670ef hasn't hit master yet, I guess we should squash this
patch (or any alternative) there to preserve bisect, ie, either David
does it for you or you post a v4 of your previous series.

> Signed-off-by: Serhii Popovych <spopovyc@redhat.com>
> ---
>  hw/ppc/spapr.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 7b2bc4e..bff2125 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -914,7 +914,7 @@ static void spapr_dt_rtas(sPAPRMachineState *spapr, void *fdt)
>          cpu_to_be32(0),
>          cpu_to_be32(0),
>          cpu_to_be32(0),
> -        cpu_to_be32(nb_numa_nodes - 1),
> +        cpu_to_be32(nb_numa_nodes ? nb_numa_nodes - 1 : 0),
>      };
>  
>      _FDT(rtas = fdt_add_subnode(fdt, 0, "rtas"));
