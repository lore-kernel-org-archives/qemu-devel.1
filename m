Received: from eggs.gnu.org ([2001:4830:134:3::10]:50493)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cGUh1-00044F-OS
	for qemu-devel@nongnu.org; Mon, 12 Dec 2016 12:47:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cGUgw-0007HE-OI
	for qemu-devel@nongnu.org; Mon, 12 Dec 2016 12:47:15 -0500
Date: Mon, 12 Dec 2016 15:47:07 -0200
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20161212174707.GE3808@thinpad.lan.raisama.net>
References: <148104617887.7699.984921868108236415.stgit@bahia.lab.toulouse-stg.fr.ibm.com>
	<20161206191952.GD4027@thinpad.lan.raisama.net>
	<20161206193159.GE4027@thinpad.lan.raisama.net>
	<20161212132509.6a031fb6.cornelia.huck@de.ibm.com>
	<f1f93b66-c414-9dce-ecc4-2239ceaa1774@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f1f93b66-c414-9dce-ecc4-2239ceaa1774@linux.vnet.ibm.com>
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
To: Halil Pasic <pasic@linux.vnet.ibm.com>
Cc: Cornelia Huck <cornelia.huck@de.ibm.com>, "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org, Greg Kurz <groug@kaod.org>, qemu-stable@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

On Mon, Dec 12, 2016 at 06:13:50PM +0100, Halil Pasic wrote:
> 
> 
> On 12/12/2016 01:25 PM, Cornelia Huck wrote:
> >> +        if (oc && object_class_is_abstract(oc)) {
> >> +            /* temporary hack to make sure we will never override
>                                                ~~~~~~~~~~~~~~~~~~~~~~
> 
> I would say this is not enough to provide that guarantee. Inheriting
> from non-abstract, or something like I described below, would still
> get us in trouble. Or am I wrong? 

Yes, inheriting from non-abstract would still be broken, so this
hack is not enough for some cases. In the current tree, it won't
fix the problem for the spapr-pci-host-bridge properties.

> 
> How about s/we will never/we do not/?

I will change it.

> 
> >> +             * globals set explicitly on -global: if an abstract class
> >> +             * is on compat_props, register globals for each of their
> >> +             * subclasses instead.
> 
> I'm not sure if this is clear enough regarding multilevel inheritance.
> I would prefer "subtype" or "class derived from it".

I can rewrite it as "for all of their subtypes".

> 
> >> +             */
> > I think this should not just be a 'temporary hack'... rather document
> > this behaviour for abstract classes?
> > 
> 
> Connie, I have to disagree with you on this. I'm fine with this as a
> temporary hack provided it remedies the acute problem, but I would this
> becoming state of art.
> 
> The reason for this how abstract class is usually understood in OOP:
> it's like a normal class except you can not instantiate it.  Adding an
> extra property rule, and especially such a convoluted one, could result
> in a conflict between intuition and reality.  And it's not like we have
> no plan how to do this cleanly.
> 
> Why do I say convoluted:
> * Inheriting form abstract and from non-abstract behaves differently.
> * Theoretically we have something like non-abstract (C_3) inherits for
> abstract (AC_2) inherits from non-abstract (C_1)  inherits from abstract
> (AC_0), and we set the property P both via AC_0 and AC_2 for an instance
> of C1 we would/could end up having the same problem as we have now (via
> AC_0 taking precedence over AC_2) -- at least I think so. 

Well, we could change the code to:
1) Not check object_class_is_abstract(), and simply register the
   globals for all subtypes;
2) Call qdev_prop_set_globals_for_type() only for
   object_class_get_name(), instead of doing it for all
   parent classes in qdev_prop_set_globals().

But this sounds like a more complicated way of implementing
exactly the same behavior implemented by Greg Kurz in "qdev: fix
the order compat and global properties are applied".

> 
> I did not test it either, but it looks sane to me. Regardless of the
> comments on the comment (if you are going to consider them or not) you
> can take my r-b.

Thanks!

-- 
Eduardo
