Received: from eggs.gnu.org ([2001:4830:134:3::10]:39198)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1dVLlW-0001EX-8V
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 13:49:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1dVLlR-00072z-BM
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 13:49:34 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:45540
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.vnet.ibm.com>)
	id 1dVLlR-00072h-5j
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 13:49:29 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v6CHmwc3127993
	for <qemu-devel@nongnu.org>; Wed, 12 Jul 2017 13:49:28 -0400
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2bnp3cxupx-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 12 Jul 2017 13:49:28 -0400
Received: from localhost
	by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.vnet.ibm.com>;
	Wed, 12 Jul 2017 18:49:26 +0100
References: <20170711004303.3902-1-ehabkost@redhat.com>
	<20170711004303.3902-4-ehabkost@redhat.com>
From: Halil Pasic <pasic@linux.vnet.ibm.com>
Date: Wed, 12 Jul 2017 19:49:22 +0200
MIME-Version: 1.0
In-Reply-To: <20170711004303.3902-4-ehabkost@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Message-Id: <2cda5b0b-0169-d12e-114e-77fcb1a4bb07@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH 3/3] Revert "machine: Convert abstract
 typename on compat_props to subclass names"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org
Cc: Marcel Apfelbaum <marcel@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Greg Kurz <groug@kaod.org>



On 07/11/2017 02:43 AM, Eduardo Habkost wrote:
> This reverts commit 0bcba41fe379e4c6834adcf1456d9099db31a5b2.
> 
> The bug addressed by that commit is now fixed in a better way by the
> commit "qdev: fix the order compat and global properties are applied".
> 
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>

Reviewed-by: Halil Pasic <pasic@linux.vnet.ibm.com>

Note: It is not like the effect of commit 0bcba41fe3 is canceled
out with your first patch in place. It depends on the client
code (the implementation of the individual devices) wether
this patch changes something or not. I did not check myself.
So the did you verify that nothing breaks with this change applies
here too.

> ---
>  hw/core/machine.c | 26 +++-----------------------
>  1 file changed, 3 insertions(+), 23 deletions(-)
> 
> diff --git a/hw/core/machine.c b/hw/core/machine.c
> index ecb5552..1d10b01 100644
> --- a/hw/core/machine.c
> +++ b/hw/core/machine.c
> @@ -770,18 +770,11 @@ static void machine_class_finalize(ObjectClass *klass, void *data)
>      g_free(mc->name);
>  }
> 
> -static void machine_register_compat_for_subclass(ObjectClass *oc, void *opaque)
> -{
> -    GlobalProperty *p = opaque;
> -    register_compat_prop(object_class_get_name(oc), p->property, p->value);
> -}
> -
>  void machine_register_compat_props(MachineState *machine)
>  {
>      MachineClass *mc = MACHINE_GET_CLASS(machine);
>      int i;
>      GlobalProperty *p;
> -    ObjectClass *oc;
> 
>      if (!mc->compat_props) {
>          return;
> @@ -789,22 +782,9 @@ void machine_register_compat_props(MachineState *machine)
> 
>      for (i = 0; i < mc->compat_props->len; i++) {
>          p = g_array_index(mc->compat_props, GlobalProperty *, i);
> -        oc = object_class_by_name(p->driver);
> -        if (oc && object_class_is_abstract(oc)) {
> -            /* temporary hack to make sure we do not override
> -             * globals set explicitly on -global: if an abstract class
> -             * is on compat_props, register globals for all its
> -             * non-abstract subtypes instead.
> -             *
> -             * This doesn't solve the problem for cases where
> -             * a non-abstract typename mentioned on compat_props
> -             * has subclasses, like spapr-pci-host-bridge.
> -             */
> -            object_class_foreach(machine_register_compat_for_subclass,
> -                                 p->driver, false, p);
> -        } else {
> -            register_compat_prop(p->driver, p->property, p->value);
> -        }
> +        /* Machine compat_props must never cause errors: */
> +        p->errp = &error_abort;
> +        qdev_prop_register_global(p);
>      }
>  }
> 
