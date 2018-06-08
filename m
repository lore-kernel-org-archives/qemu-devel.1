Received: from eggs.gnu.org ([2001:4830:134:3::10]:60490)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1fRBun-0004no-WA
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 03:34:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1fRBuk-00054u-TF
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 03:34:30 -0400
Received: from 10.mo178.mail-out.ovh.net ([46.105.76.150]:50827)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1fRBuk-00054B-M6
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 03:34:26 -0400
Received: from player772.ha.ovh.net (unknown [10.109.120.55])
	by mo178.mail-out.ovh.net (Postfix) with ESMTP id E83B21A5E7
	for <qemu-devel@nongnu.org>; Fri,  8 Jun 2018 09:34:24 +0200 (CEST)
Date: Fri, 8 Jun 2018 09:34:06 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20180608093406.30c878ec@bahia.lan>
In-Reply-To: <20180607165218.9558-3-david@redhat.com>
References: <20180607165218.9558-1-david@redhat.com>
	<20180607165218.9558-3-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 2/8] spapr: no need to verify the node
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, qemu-s390x@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <rth@twiddle.net>, "Michael S . Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Alexander Graf <agraf@suse.de>, Cornelia Huck <cohuck@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>

On Thu,  7 Jun 2018 18:52:12 +0200
David Hildenbrand <david@redhat.com> wrote:

> The node property can always be queried and the value has already been
> verified in pc_dimm_realize().
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  hw/ppc/spapr.c | 9 +--------
>  1 file changed, 1 insertion(+), 8 deletions(-)
> 
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 2375cbee12..d038f3243e 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -3578,14 +3578,7 @@ static void spapr_machine_device_plug(HotplugHandler *hotplug_dev,
>              error_setg(errp, "Memory hotplug not supported for this machine");
>              return;
>          }
> -        node = object_property_get_uint(OBJECT(dev), PC_DIMM_NODE_PROP, errp);
> -        if (*errp) {

Good riddance :)

> -            return;
> -        }
> -        if (node < 0 || node >= MAX_NODES) {
> -            error_setg(errp, "Invaild node %d", node);
> -            return;
> -        }
> +        node = object_property_get_uint(OBJECT(dev), PC_DIMM_NODE_PROP, NULL);

Maybe pass &error_abort ?

>  
>          spapr_memory_plug(hotplug_dev, dev, node, errp);
>      } else if (object_dynamic_cast(OBJECT(dev), TYPE_SPAPR_CPU_CORE)) {
