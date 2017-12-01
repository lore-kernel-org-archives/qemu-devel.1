Received: from eggs.gnu.org ([2001:4830:134:3::10]:36677)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1eKozO-0002GT-In
	for qemu-devel@nongnu.org; Fri, 01 Dec 2017 12:20:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1eKozL-0008UM-TS
	for qemu-devel@nongnu.org; Fri, 01 Dec 2017 12:20:38 -0500
Received: from 17.mo4.mail-out.ovh.net ([46.105.41.16]:43088)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1eKozL-0008G5-MR
	for qemu-devel@nongnu.org; Fri, 01 Dec 2017 12:20:35 -0500
Received: from player159.ha.ovh.net (gw6.ovh.net [213.251.189.206])
	by mo4.mail-out.ovh.net (Postfix) with ESMTP id 7CA33111EB7
	for <qemu-devel@nongnu.org>; Fri,  1 Dec 2017 18:20:27 +0100 (CET)
Date: Fri, 1 Dec 2017 18:20:14 +0100
From: Greg Kurz <groug@kaod.org>
Message-ID: <20171201182014.44b0602e@bahia.lan>
In-Reply-To: <1512127449-11114-1-git-send-email-s1seetee@linux.vnet.ibm.com>
References: <1512127449-11114-1-git-send-email-s1seetee@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH v1] spapr.c: Update qemu's
 maxcpus for pseries machine.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Seeteena Thoufeek <s1seetee@linux.vnet.ibm.com>
Cc: david@gibson.dropbear.id.au, agraf@suse.de, qemu-ppc@nongnu.org, qemu-devel@nongnu.org

On Fri,  1 Dec 2017 16:54:09 +0530
Seeteena Thoufeek <s1seetee@linux.vnet.ibm.com> wrote:

> Need to adjust the max cpus supported number from error message since
> it was conflicting with KVM's.
> 
> Steps to Reproduce:
> 1.boot up with
> "-smp 64,maxcpus=102464,cores=8,threads=1,sockets=8"
> 
> qemu-kvm: Number of SMP CPUs requested (102464) exceeds max CPUs
> supported by machine 'pseries-rhel7.4.0alt' (1024)
> 

The above error message was dumped by commit c0dd10991903 (authored by
you apparently). Now it should be:

Invalid SMP CPUs 102464. The max CPUs supported by
 machine 'pseries-rhel7.4.0alt' is 1024

> 2. On KVM machine it shows
> 
> boot up with
> "-m 6G,maxmem=300G,slots=256 -smp 64,maxcpus=1024,cores=8,threads=1
> ,sockets=128"
> 
> Number of hotpluggable cpus requested (1024) exceeds the maximum cpus
>  supported by KVM (240)
> 
> It seemed that 1024 was useless since KVM only support 240 so far.

This is the limit imposed by KVM, which is basically the number of
CPUs on the host system. On some bigger systems, it can be up to
1536 AFAIK.

The machine limit is a different beast and someone could legitimately
run a fully emulated guest (TCG) with 1024 CPUs.

Hence it really doesn't make sense to hardcode the KVM value from your
system into QEMU.

> Hence,we need to adjust it to an reasonable value 240.
> 
> Signed-off-by: Seeteena Thoufeek <s1seetee@linux.vnet.ibm.com>
> ---
>  hw/ppc/spapr.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 9efddea..c753254 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -3691,6 +3691,7 @@ static const TypeInfo spapr_machine_info = {
>          if (latest) {                                                \
>              mc->alias = "pseries";                                   \
>              mc->is_default = 1;                                      \
> +            mc->max_cpus = 240;                                      \

BTW, this isn't the right place: the limit is set in spapr_machine_class_init()

>          }                                                            \
>      }                                                                \
>      static void spapr_machine_##suffix##_instance_init(Object *obj)  \
