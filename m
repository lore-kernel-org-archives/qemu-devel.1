Received: from eggs.gnu.org ([2001:4830:134:3::10]:53158)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fhZ99-0007Nt-BI
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 07:37:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fhZ94-0005p4-9Z
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 07:36:59 -0400
Received: from 10.mo5.mail-out.ovh.net ([46.105.52.148]:47091)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1fhZ94-0005Oe-2E
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 07:36:54 -0400
Received: from player696.ha.ovh.net (unknown [10.109.159.159])
	by mo5.mail-out.ovh.net (Postfix) with ESMTP id 38AC11CB13C
	for <qemu-devel@nongnu.org>; Mon, 23 Jul 2018 13:36:45 +0200 (CEST)
References: <153138970964.331720.14349788349972574256.stgit@bahia>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <821367d0-c3ef-43bd-071c-b2ff50dae7bd@kaod.org>
Date: Mon, 23 Jul 2018 13:36:36 +0200
MIME-Version: 1.0
In-Reply-To: <153138970964.331720.14349788349972574256.stgit@bahia>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] ppc/xics: fix ICP reset path
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, Bharata B Rao <bharata@linux.vnet.ibm.com>, Satheesh Rajendran <sathnaga@linux.vnet.ibm.com>

On 07/12/2018 12:01 PM, Greg Kurz wrote:
> Recent cleanup in commit a028dd423ee6 dropped the ICPStateClass::reset
> handler. It is now up to child ICP classes to call the DeviceClass::reset
> handler of the parent class, thanks to device_class_set_parent_reset().
> This is a better object programming pattern,

I think that the device_class_set_parent* routines just obfuscate a little
more the object programming approach of QEMU. 

> but unfortunately it causes QEMU to crash during CPU hotplug:

I guess I did not try that :/ Would it be complex to add a spapr unit test 
for CPU hotplug ? It would be useful.

> (qemu) device_add host-spapr-cpu-core,id=core1,core-id=1
> Segmentation fault (core dumped)
> 
> When the hotplug path tries to reset the ICP device, we end up calling:
> 
> static void icp_kvm_reset(DeviceState *dev)
> {
>     ICPStateClass *icpc = ICP_GET_CLASS(dev);
> 
>     icpc->parent_reset(dev);
> 
> but icpc->parent_reset is NULL... This happens because icp_kvm_class_init()
> calls:
> 
>     device_class_set_parent_reset(dc, icp_kvm_reset,
>                                   &icpc->parent_reset);
> 
> but dc->reset, ie, DeviceClass::reset for the TYPE_ICP type, is
> itself NULL.>
> This patch hence sets DeviceClass::reset for the TYPE_ICP type to
> point to icp_reset(). It then registers a reset handler that calls
> DeviceClass::reset. If the ICP subtype has configured its own reset
> handler with device_class_set_parent_reset(), this ensures it will
> be called first and it can then call ICPStateClass::parent_reset
> safely. This fixes the reset path for the TYPE_KVM_ICP type, which
> is the only subtype that defines its own reset function.

So, now, isn't ICP reset called twice on KVM ? 

Anyway, we can sort that out if necessary.

Thanks,

C.
 
> Reported-by: Satheesh Rajendran <sathnaga@linux.vnet.ibm.com>
> Suggested-by: David Gibson <david@gibson.dropbear.id.au>
> Fixes: a028dd423ee6dfd091a8c63028240832bf10f671
> Signed-off-by: Greg Kurz <groug@kaod.org>
> ---
>  hw/intc/xics.c |   14 +++++++++++---
>  1 file changed, 11 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/intc/xics.c b/hw/intc/xics.c
> index b9f1a3c97214..c90c893228dc 100644
> --- a/hw/intc/xics.c
> +++ b/hw/intc/xics.c
> @@ -291,7 +291,7 @@ static const VMStateDescription vmstate_icp_server = {
>      },
>  };
>  
> -static void icp_reset(void *dev)
> +static void icp_reset(DeviceState *dev)
>  {
>      ICPState *icp = ICP(dev);
>  
> @@ -303,6 +303,13 @@ static void icp_reset(void *dev)
>      qemu_set_irq(icp->output, 0);
>  }
>  
> +static void icp_reset_handler(void *dev)
> +{
> +    DeviceClass *dc = DEVICE_GET_CLASS(dev);
> +
> +    dc->reset(dev);
> +}
> +
>  static void icp_realize(DeviceState *dev, Error **errp)
>  {
>      ICPState *icp = ICP(dev);
> @@ -345,7 +352,7 @@ static void icp_realize(DeviceState *dev, Error **errp)
>          return;
>      }
>  
> -    qemu_register_reset(icp_reset, dev);
> +    qemu_register_reset(icp_reset_handler, dev);
>      vmstate_register(NULL, icp->cs->cpu_index, &vmstate_icp_server, icp);
>  }
>  
> @@ -354,7 +361,7 @@ static void icp_unrealize(DeviceState *dev, Error **errp)
>      ICPState *icp = ICP(dev);
>  
>      vmstate_unregister(NULL, &vmstate_icp_server, icp);
> -    qemu_unregister_reset(icp_reset, dev);
> +    qemu_unregister_reset(icp_reset_handler, dev);
>  }
>  
>  static void icp_class_init(ObjectClass *klass, void *data)
> @@ -363,6 +370,7 @@ static void icp_class_init(ObjectClass *klass, void *data)
>  
>      dc->realize = icp_realize;
>      dc->unrealize = icp_unrealize;
> +    dc->reset = icp_reset;
>  }
>  
>  static const TypeInfo icp_info = {
> 
