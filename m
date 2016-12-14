Received: from eggs.gnu.org ([2001:4830:134:3::10]:38022)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1cHBhQ-0005xA-Nf
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 10:42:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1cHBhN-0005jg-IA
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 10:42:32 -0500
Received: from 6.mo179.mail-out.ovh.net ([46.105.56.76]:53523)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1cHBhN-0005j3-Ba
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 10:42:29 -0500
Received: from player732.ha.ovh.net (b7.ovh.net [213.186.33.57])
	by mo179.mail-out.ovh.net (Postfix) with ESMTP id 9DBAF10B7E
	for <qemu-devel@nongnu.org>; Wed, 14 Dec 2016 16:42:26 +0100 (CET)
Date: Wed, 14 Dec 2016 16:42:14 +0100
From: Greg Kurz <groug@kaod.org>
Message-ID: <20161214164214.54254668@bahia.lan>
In-Reply-To: <1481575745-26120-1-git-send-email-ehabkost@redhat.com>
References: <1481575745-26120-1-git-send-email-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH for-2.8.1 v2] machine: Convert abstract
 typename on compat_props to subclass names
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>, qemu-stable@nongnu.org, Halil Pasic <pasic@linux.vnet.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, Stefan Hajnoczi <stefanha@redhat.com>

On Mon, 12 Dec 2016 18:49:05 -0200
Eduardo Habkost <ehabkost@redhat.com> wrote:

> Original problem description by Greg Kurz:
> 
> > Since commit "9a4c0e220d8a hw/virtio-pci: fix virtio
> > behaviour", passing -device virtio-blk-pci.disable-modern=off
> > has no effect on 2.6 machine types because the internal
> > virtio-pci.disable-modern=on compat property always prevail.  
> 
> The same bug also affects other abstract type names mentioned on
> compat_props by machine-types: apic-common, i386-cpu, pci-device,
> powerpc64-cpu, s390-skeys, spapr-pci-host-bridge, usb-device,
> virtio-pci, x86_64-cpu.
> 
> The right fix for this problem is to make sure compat_props and
> -global options are always applied in the order they are
> registered, instead of reordering them based on the type
> hierarchy. But changing the ordering rules of -global is risky
> and might break existing configurations, so we shouldn't do that
> on a stable branch.
> 
> This is a temporary hack that will work around the bug when
> registering compat_props properties: if we find an abstract class
> on compat_props, register properties for all its non-abstract
> subtypes instead. This will make sure -global won't be overridden
> by compat_props, while keeping the existing ordering rules on
> -global options.
> 
> Note that there's one case that won't be fixed by this hack:
> "-global spapr-pci-vfio-host-bridge.<option>=<value>" won't be
> able to override compat_props, because spapr-pci-host-bridge is
> not an abstract class.
> 
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> ---

This patch had 3 r-b. Is there any good reason to hold
it up to 2.8.1 ?

> Changes v1 (RFC) -> v2:
> * New commit message
> * Clarified comments
>   Suggested-by: Halil Pasic <pasic@linux.vnet.ibm.com>
> * Moved variable declaration outside of loop
>   Suggested-by: Cornelia Huck <cornelia.huck@de.ibm.com>
> ---
>  hw/core/machine.c | 39 ++++++++++++++++++++++++++++++++++++---
>  1 file changed, 36 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/core/machine.c b/hw/core/machine.c
> index b0fd91f..213e8e0 100644
> --- a/hw/core/machine.c
> +++ b/hw/core/machine.c
> @@ -554,11 +554,31 @@ static void machine_class_finalize(ObjectClass *klass, void *data)
>      g_free(mc->name);
>  }
>  
> +static void register_compat_prop(const char *driver,
> +                                 const char *property,
> +                                 const char *value)
> +{
> +    GlobalProperty *p = g_new0(GlobalProperty, 1);
> +    /* Machine compat_props must never cause errors: */
> +    p->errp = &error_abort;
> +    p->driver = driver;
> +    p->property = property;
> +    p->value = value;
> +    qdev_prop_register_global(p);
> +}
> +
> +static void machine_register_compat_for_subclass(ObjectClass *oc, void *opaque)
> +{
> +    GlobalProperty *p = opaque;
> +    register_compat_prop(object_class_get_name(oc), p->property, p->value);
> +}
> +
>  void machine_register_compat_props(MachineState *machine)
>  {
>      MachineClass *mc = MACHINE_GET_CLASS(machine);
>      int i;
>      GlobalProperty *p;
> +    ObjectClass *oc;
>  
>      if (!mc->compat_props) {
>          return;
> @@ -566,9 +586,22 @@ void machine_register_compat_props(MachineState *machine)
>  
>      for (i = 0; i < mc->compat_props->len; i++) {
>          p = g_array_index(mc->compat_props, GlobalProperty *, i);
> -        /* Machine compat_props must never cause errors: */
> -        p->errp = &error_abort;
> -        qdev_prop_register_global(p);
> +        oc = object_class_by_name(p->driver);
> +        if (oc && object_class_is_abstract(oc)) {
> +            /* temporary hack to make sure we do not override
> +             * globals set explicitly on -global: if an abstract class
> +             * is on compat_props, register globals for all its
> +             * non-abstract subtypes instead.
> +             *
> +             * This doesn't solve the problem for cases where
> +             * a non-abstract typename mentioned on compat_props
> +             * has subclasses, like spapr-pci-host-bridge.
> +             */
> +            object_class_foreach(machine_register_compat_for_subclass,
> +                                 p->driver, false, p);
> +        } else {
> +            register_compat_prop(p->driver, p->property, p->value);
> +        }
>      }
>  }
>  
