Received: from eggs.gnu.org ([2001:4830:134:3::10]:34970)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1ctaCC-0003F0-VW
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 09:33:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1ctaC5-00009K-Pk
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 09:33:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55216)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1ctaC5-00007G-HI
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 09:32:53 -0400
Date: Thu, 30 Mar 2017 10:32:48 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170330133248.GF3709@thinpad.lan.raisama.net>
References: <20170329194148.19015-1-ehabkost@redhat.com>
	<afd04dba-4ebd-24a7-d149-2e6f079c2868@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <afd04dba-4ebd-24a7-d149-2e6f079c2868@redhat.com>
Subject: Re: [Qemu-devel] [RFC v2 0/9] qom: Make
 object_get_class()/*_GET_CLASS return const pointers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, Alexander Graf <agraf@suse.de>, =?iso-8859-1?Q?Herv=E9?= Poussineau <hpoussin@reactos.org>, Juergen Gross <jgross@suse.com>, Matthew Rosato <mjrosato@linux.vnet.ibm.com>, Laszlo Ersek <lersek@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>

On Thu, Mar 30, 2017 at 10:59:10AM +0200, Paolo Bonzini wrote:
> 
> 
> On 29/03/2017 21:41, Eduardo Habkost wrote:
> > QOM has a data model where class struct data is static: class
> > structs are initialized at class_init, and never changed again.
> 
> Isn't that just the way class data is being used?  There's no reason for
> class data to be static.  It happens to be that way because our
> hierarchies are pretty shallow and global static variables are used
> instead of class data.  But it doesn't _have_ to be like that.

I disagree. I believe this is how class data is meant to be used.
if we change per-class data at runtime outside class_init, we
have a hard time providing querying and introspection mechanisms
for types. If something really needs to be changed at runtime
outside class_init, it belongs to object instance fields, not
class data fields.

e.g. the main benefit we got from eliminating the compat_* global
variables in machine/pc code wasn't simply the global variable
elimination: it was making the compat data static and available
at the MachineClass structs, instead of burying it inside
machine_init functions. If we kept the old model where
class-specific data was initialized at machine_init-time,
extending query-machines with that info, and writing new machine
data queries would still be impossible.


For reference, this is how I think we could have dealt with the
existing cases of non-const class variables:

> >   qbus_realize(), code added by:
> >   commit 61de36761b565a4138d8ad7ec75489ab28fe84b6
> >   Date:   Thu Feb 6 16:08:15 2014 +0100
> >       qdev: Keep global allocation counter per bus

This one might make sense: it's easier to keep data in a BusClass
field than a automatic_id[bus_type] dictionary somewhere else.

But I would still prefer to have a automatic_id[bus_type]
dictionary inside MachineState instead of this.

> > 
> >   mips_jazz_init(), code added by:
> >   commit 54e755588cf1e90f0b1460c4e8e6b6a54b6d3a32
> >   Date:   Mon Nov 4 23:26:17 2013 +0100
> >       mips jazz: do not raise data bus exception when accessing invalid addresses

IMO, a simple MIPSCPU::ignore_invalid_exec_access boolean flag
would be better than hijacking TYPE_MIPS_CPU's
do_unassigned_access() method on the fly.

> > 
> >   xen_set_dynamic_sysbus(), code added by:
> >   commit 3a6c9172ac5951e6dac2b3f6cbce3cfccdec5894
> >   Date:   Tue Nov 22 07:10:58 2016 +0100
> >       xen: create qdev for each backend device

Here, setting has_dynamic_sysbus for all PC classes would be
better, so a future supported-device-types/device-slot querying
mechanism wouldn't incorrectly report xen-backend as unsupported.
But there are additional problems I want to sove regarding sysbus
before doing that.

BTW, this is the case that prompted me to write this series in
the first place. I believe changing
MachineClass::has_dynamic_sysbus at runtime was a mistake, and a
const object_get_class() would have helped us catch that.

> > 
> >   s390_cpu_realizefn(), code added by:
> >   commit c6644fc88bed1176f67b4b7a9df691bcf25c0c5b
> >   Date:   Fri Mar 4 12:34:31 2016 -0500
> >       s390x/cpu: Get rid of side effects when creating a vcpu

Here, I see no reason for a per-cpu-class field at all. Even a
static next_cpu_id variable wouldn't hurt.

Also, this is the only remaining code still using cpu_exists(),
and the same logic probably can be implemented using
MachineClass::possible_cpu_arch_ids() instead.

> 
> That said, the QUALIFIED_CAST concept is very interesting and I'd even
> extend it to OBJECT_CHECK, object_dynamic_cast and
> object_dynamic_cast_assert.  I'm just not sure about returning const
> from object_get_class()/*_GET_CLASS, which ironically is the thing that
> prompted you to write the series. :)

Makes sense. I will send extra patches to change the object cast
macros, too.

> 
> Paolo
> 

-- 
Eduardo
