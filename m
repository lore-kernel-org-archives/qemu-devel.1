Received: from eggs.gnu.org ([2001:4830:134:3::10]:44465)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1f843z-0003cV-AB
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 09:21:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1f843w-0007GH-MU
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 09:20:55 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:41388 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1f843w-0007EM-Gw
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 09:20:52 -0400
Date: Mon, 16 Apr 2018 15:20:40 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20180416152040.7b88b902@redhat.com>
In-Reply-To: <bc4100f4-0a01-a526-c6ce-c2602a96e28a@redhat.com>
References: <20180329032149.44685-1-aik@ozlabs.ru>
	<bc4100f4-0a01-a526-c6ce-c2602a96e28a@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH qemu] RFC: memory/hmp: Print owners/parents
 in "info mtree"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, qemu-devel@nongnu.org, "Dr. David
	Alan Gilbert" <dgilbert@redhat.com>, Markus Armbruster <armbru@redhat.com>

On Thu, 12 Apr 2018 11:15:04 +0200
Paolo Bonzini <pbonzini@redhat.com> wrote:

> On 29/03/2018 05:21, Alexey Kardashevskiy wrote:
> > +    DeviceState *dev = (DeviceState *) object_dynamic_cast(obj, TYPE_DEVICE);
> > +    const char *id = object_property_print(obj, "id", true, NULL);  
> 
> I learnt now about commit e1ff3c67e8544f41f1bea76ba76385faee0d2bb7 and I
> find it a mistake.  The "id" is available through
> object_get_canonical_path_component.  Can you change the "id" assignment
> to use object_get_canonical_path_component instead?

object_get_canonical_path_component() should be used with care as it
assumes that object HAS parent. It will crash if parent is NULL
or hasn't been assigned yet.

Generally object doesn't need to know its own name,
we use it only for debugging and nice error reporting so far.
I'd rather have 'id' property at Object level so we won't have
to fish out ID from parent /which we aren't supposed to do and
which doesn't work in some cases/ when it's needed within
object itself.


> > +    const char *name = object_property_print(obj, "name", true, NULL);  
> 
> Who defines a name property?
> 
> > +    mon_printf(f, " %s:{", label);
> > +    if (dev) {
> > +        mon_printf(f, "dev");
> > +        if (dev->id) {
> > +            mon_printf(f, " id=%s", dev->id);
> > +        }
> > +    } else {
> > +        mon_printf(f, "obj");  
> 
> > +    }
> > +    if (name) {
> > +        mon_printf(f, " name=%s ", name);
> > +    }
> > +    if (id) {
> > +        mon_printf(f, " id=%s ", id);
> > +    }
> > +    if (dev && (!name && !id && !dev->id)) {
> > +        mon_printf(f, " path=%s", dev->canonical_path);  
> 
> Why not print the path for the !dev case?  I think we can just have
> 
>     mon_prinf(f, " %s:{%s", label, dev ? "dev" : "obj");
>     if (dev ? dev->id : id) {
>         mon_printf(f, " id=%s", dev ? dev->id : id);
>     } else {
>         canonical_path = object_get_canonical_path(...)
>         mon_printf(f, " path=%s", canonical_path);
>         g_free(canonical_path);
>     }
> 
> Thanks,
> 
> Paolo
