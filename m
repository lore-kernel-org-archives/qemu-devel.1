Received: from eggs.gnu.org ([2001:4830:134:3::10]:51873)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fqTkn-0005fN-MJ
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 21:40:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fqTkm-0002Gf-FC
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 21:40:41 -0400
Date: Thu, 16 Aug 2018 22:40:29 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180817014029.GV15372@localhost.localdomain>
References: <1531470464-21522-1-git-send-email-thuth@redhat.com>
	<1531470464-21522-2-git-send-email-thuth@redhat.com>
	<20180713225718.GP914@localhost.localdomain>
	<4551aa70-343e-1362-cfd3-d567c476d6fe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4551aa70-343e-1362-cfd3-d567c476d6fe@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 01/16] qom/object: Add a new function
 object_initialize_child()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, Alistair Francis <alistair@alistair23.me>, Markus Armbruster <armbru@redhat.com>, Subbaraya Sundeep <sundeep.lkml@gmail.com>, Beniamino Galvani <b.galvani@gmail.com>, qemu-arm@nongnu.org, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>

On Thu, Aug 16, 2018 at 01:59:49PM +0200, Thomas Huth wrote:
> On 07/14/2018 12:57 AM, Eduardo Habkost wrote:
> > On Fri, Jul 13, 2018 at 10:27:29AM +0200, Thomas Huth wrote:
> >> A lot of code is using the object_initialize() function followed by a call
> >> to object_property_add_child() to add the newly initialized object as a child
> >> of the current object. Both functions increase the reference counter of the
> >> new object, but many spots that call these two functions then forget to drop
> >> one of the superfluous references. So the newly created object is often not
> >> cleaned up correctly when the parent is destroyed. In the worst case, this
> >> can cause crashes, e.g. because device objects are not correctly removed from
> >> their parent_bus.
> >>
> >> Since this is a common pattern between many code spots, let's introdcue a
> >> new function that takes care of calling all three required initialization
> >> functions, first object_initialize(), then object_property_add_child() and
> >> finally object_unref().
> >>
> >> And while we're at object.h, also fix some copy-n-paste errors in the
> >> comments there ("to store the area" --> "to store the error").
> >>
> >> Signed-off-by: Thomas Huth <thuth@redhat.com>
> > 
> > Potential candidates for using the new function, found using the
> > following Coccinelle patch:
> > 
> > @@
> > expression child, size, type, parent, errp, propname;
> > @@
> > -object_initialize(child, size, type);
> > -object_property_add_child(
> > +object_initialize_child(
> >                            parent, propname, 
> > -                          OBJECT(child),
> > +                          child, size, type,
> >                            errp);
> > 
> > Some of them (very few) already call object_unref() and need to
> > be fixed manually.
> > 
> > Most of the remaining ~50 object_initialize() callers are also
> > candidates, even if they don't call object_property_add_child()
> > today.
> > 
> > Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> 
> Care to turn this into a proper patch, now that we left the freeze period?

It's possible, but we need a volunteer to review each hunk
because the existing code might be (correctly) calling
object_unref() (either immediately or when parent is finalized).

I will keep this in my TODO list, but it's not my top priority
right now.

-- 
Eduardo
