Received: from eggs.gnu.org ([2001:4830:134:3::10]:47467)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1cGPfV-00047W-Nz
	for qemu-devel@nongnu.org; Mon, 12 Dec 2016 07:25:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1cGPfS-0002ym-58
	for qemu-devel@nongnu.org; Mon, 12 Dec 2016 07:25:21 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:52430
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cornelia.huck@de.ibm.com>)
	id 1cGPfR-0002y6-Vt
	for qemu-devel@nongnu.org; Mon, 12 Dec 2016 07:25:18 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
	uBCCOwuc079851
	for <qemu-devel@nongnu.org>; Mon, 12 Dec 2016 07:25:17 -0500
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
	by mx0b-001b2d01.pphosted.com with ESMTP id 279psmx28w-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 12 Dec 2016 07:25:16 -0500
Received: from localhost
	by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <cornelia.huck@de.ibm.com>;
	Mon, 12 Dec 2016 12:25:15 -0000
Date: Mon, 12 Dec 2016 13:25:09 +0100
From: Cornelia Huck <cornelia.huck@de.ibm.com>
In-Reply-To: <20161206193159.GE4027@thinpad.lan.raisama.net>
References: <148104617887.7699.984921868108236415.stgit@bahia.lab.toulouse-stg.fr.ibm.com>
	<20161206191952.GD4027@thinpad.lan.raisama.net>
	<20161206193159.GE4027@thinpad.lan.raisama.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <20161212132509.6a031fb6.cornelia.huck@de.ibm.com>
Subject: Re: [Qemu-devel] [RFC for-2.8] machine: Convert abstract typename
 on compat_props to subclass names
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org, Halil Pasic <pasic@linux.vnet.ibm.com>, "Michael S. Tsirkin" <mst@redhat.com>, qemu-stable@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

On Tue, 6 Dec 2016 17:31:59 -0200
Eduardo Habkost <ehabkost@redhat.com> wrote:

> What about this?
> 
> (untested)

Have not tested it either, but I think it looks good. Some nits below.

> 
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> ---
>  hw/core/machine.c | 35 ++++++++++++++++++++++++++++++++---
>  1 file changed, 32 insertions(+), 3 deletions(-)
> 

> @@ -565,10 +584,20 @@ void machine_register_compat_props(MachineState *machine)
>      }
> 
>      for (i = 0; i < mc->compat_props->len; i++) {
> +        ObjectClass *oc;

Move the declaration out of the loop?

>          p = g_array_index(mc->compat_props, GlobalProperty *, i);
> -        /* Machine compat_props must never cause errors: */
> -        p->errp = &error_abort;
> -        qdev_prop_register_global(p);
> +        oc = object_class_by_name(p->driver);
> +        if (oc && object_class_is_abstract(oc)) {
> +            /* temporary hack to make sure we will never override
> +             * globals set explicitly on -global: if an abstract class
> +             * is on compat_props, register globals for each of their
> +             * subclasses instead.
> +             */

I think this should not just be a 'temporary hack'... rather document
this behaviour for abstract classes?

> +            object_class_foreach(machine_register_compat_for_subclass,
> +                                 p->driver, false, p);
> +        } else {
> +            register_compat_prop(p->driver, p->property, p->value);
> +        }
>      }
>  }
> 
