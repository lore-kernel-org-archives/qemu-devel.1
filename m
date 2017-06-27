Received: from eggs.gnu.org ([2001:4830:134:3::10]:33072)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dPeiL-0005ci-0D
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 20:50:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dPeiJ-0001AH-Qx
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 20:50:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40976)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1dPeiJ-00019S-Hh
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 20:50:43 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C97DD7486C
	for <qemu-devel@nongnu.org>; Tue, 27 Jun 2017 00:50:41 +0000 (UTC)
From: "Eduardo Habkost" <ehabkost@redhat.com>
Date: Mon, 26 Jun 2017 21:50:36 -0300
Message-ID: <20170627005036.GJ12152@localhost.localdomain>
References: <1498193206-18007-1-git-send-email-peterx@redhat.com>
	<1498193206-18007-3-git-send-email-peterx@redhat.com>
	<20170623213127.GC10776@localhost.localdomain>
	<20170626023953.GF3936@pxdev.xzpeter.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170626023953.GF3936@pxdev.xzpeter.org>
Subject: Re: [Qemu-devel] [PATCH v5 02/10] accel: introduce
 AccelClass.global_props
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Laurent Vivier <lvivier@redhat.com>, Juan Quintela <quintela@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Markus Armbruster <armbru@redhat.com>

On Mon, Jun 26, 2017 at 10:39:53AM +0800, Peter Xu wrote:
> On Fri, Jun 23, 2017 at 06:31:27PM -0300, Eduardo Habkost wrote:
> > On Fri, Jun 23, 2017 at 12:46:38PM +0800, Peter Xu wrote:
> > > Introduce this new field for the accelerator classes so that each
> > > specific accelerator in the future can register its own global
> > > properties to be used further by the system. It works just like how the
> > > old machine compatible properties do, but only tailored for
> > > accelerators.
> > > 
> > > Introduce register_compat_props_array() for it. Export it so that it may
> > > be used in other codes as well in the future.
> > > 
> > > Suggested-by: Eduardo Habkost <ehabkost@redhat.com>
> > > Signed-off-by: Peter Xu <peterx@redhat.com>
> > > ---
> > >  accel/accel.c                |  6 ++++++
> > >  hw/core/qdev-properties.c    |  7 +++++++
> > >  include/hw/qdev-properties.h |  1 +
> > >  include/sysemu/accel.h       | 10 ++++++++++
> > >  vl.c                         |  1 +
> > >  5 files changed, 25 insertions(+)
> > > 
> > > diff --git a/accel/accel.c b/accel/accel.c
> > > index 7c079a5..fa85844 100644
> > > --- a/accel/accel.c
> > > +++ b/accel/accel.c
> > > @@ -120,6 +120,12 @@ void configure_accelerator(MachineState *ms)
> > >      }
> > >  }
> > >  
> > > +void accel_register_compat_props(AccelState *accel)
> > > +{
> > > +    AccelClass *class = ACCEL_GET_CLASS(accel);
> > > +    register_compat_props_array(class->global_props);
> > > +}
> > > +
> > >  static void register_accel_types(void)
> > >  {
> > >      type_register_static(&accel_type);
> > > diff --git a/hw/core/qdev-properties.c b/hw/core/qdev-properties.c
> > > index 6ff1ac3..19fa335 100644
> > > --- a/hw/core/qdev-properties.c
> > > +++ b/hw/core/qdev-properties.c
> > > @@ -1060,6 +1060,13 @@ void register_compat_prop(const char *driver,
> > >      qdev_prop_register_global(p);
> > >  }
> > >  
> > > +void register_compat_props_array(GlobalProperty *prop)
> > 
> > Note for a later: we need to stop reusing struct GlobalProperty here,
> > because the 'user_provided', 'used', and 'errp' fields are ignored by
> > register_compat_prop(), but people may believe the are not.
> > 
> > I suggest defining:
> > 
> >   struct GlobalPropertyValue {
> >       const char *driver, *property, *value;
> >   };
> > 
> > and use it instead of GlobalProperty for MachineClass::compat_props,
> > AccelClass::global_props, and register_compat_prop().
> 
> Yeah maybe another definition would be nicer.
> 
> Do you mind I skip this change in this series? After all it can be
> done on top, and can be separated from current work.
> 

No problem.  This was just a suggestion for later.

-- 
Eduardo
