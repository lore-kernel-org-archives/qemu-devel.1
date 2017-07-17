Received: from eggs.gnu.org ([2001:4830:134:3::10]:40299)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dWwfd-0004Tm-0x
	for qemu-devel@nongnu.org; Sun, 16 Jul 2017 23:26:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dWwfZ-00087W-S5
	for qemu-devel@nongnu.org; Sun, 16 Jul 2017 23:26:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42136)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1dWwfZ-00085i-IL
	for qemu-devel@nongnu.org; Sun, 16 Jul 2017 23:26:01 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 515774E4C3
	for <qemu-devel@nongnu.org>; Mon, 17 Jul 2017 03:26:00 +0000 (UTC)
Date: Mon, 17 Jul 2017 11:25:58 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170717032558.GT27284@pxdev.xzpeter.org>
References: <1499842423-21101-1-git-send-email-peterx@redhat.com>
	<20170712190240.GM30658@work-vm>
	<20170714042306.GH27284@pxdev.xzpeter.org>
	<20170714155715.GE6020@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170714155715.GE6020@localhost.localdomain>
Subject: Re: [Qemu-devel] [PATCH 0/3] migration: export cap/params to qdev
 props
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu-devel@nongnu.org, Laurent Vivier <lvivier@redhat.com>, Markus Armbruster <armbru@redhat.com>, Juan Quintela <quintela@redhat.com>

On Fri, Jul 14, 2017 at 12:57:15PM -0300, Eduardo Habkost wrote:
> On Fri, Jul 14, 2017 at 12:23:06PM +0800, Peter Xu wrote:
> > On Wed, Jul 12, 2017 at 08:02:40PM +0100, Dr. David Alan Gilbert wrote:
> > > * Peter Xu (peterx@redhat.com) wrote:
> > > > We have the MigrationState as QDev now (which seems crazy). Let's
> > > > continue to benefit.
> > > > 
> > > > This series is exporting all migration capabilities/params as global
> > > > parameters. Then we can do something like this:
> > > > 
> > > >   qemu -global migration.postcopy-ram=true \
> > > >        -global migration.max-bandwidth=4096
> > > > 
> > > > The values will be inited just like we typed these values into HMP
> > > > monitor. It'll simplify lots of migration scripts.
> > > > 
> > > > The changes are fairly straightforward. One tiny loss is that we still
> > > > don't support:
> > > > 
> > > >   -global migration.max-bandwidth=1g
> > > > 
> > > > ...just like what we did in HMP:
> > > > 
> > > >   migrate_set_speed 1g
> > > > 
> > > > ...while we need to use:
> > > > 
> > > >   -global migration.max-bandwidth=1073741824
> > > > 
> > > > However that should only be used in scripts, and that's good enough
> > > > imho.
> > > > 
> > > > These properties should only be used for debugging/testing purpose,
> > > > and we should not guarantee any interface compatibility for them (just
> > > > like HMP).
> > > 
> > > I guess the sanity checks in qmp_migrate_set_parameters and
> > > qmp_migrate_set_capabilities aren't run?
> > 
> > Indeed I missed this point. Before that: Eduardo, do you think below
> > change would make any sense?
> > 
> > diff --git a/qom/object.c b/qom/object.c
> > index 5f6fdfa..ca077a9 100644
> > --- a/qom/object.c
> > +++ b/qom/object.c
> > @@ -347,13 +347,13 @@ static void object_init_with_type(Object *obj, TypeImpl *ti)
> >  
> >  static void object_post_init_with_type(Object *obj, TypeImpl *ti)
> >  {
> > -    if (ti->instance_post_init) {
> > -        ti->instance_post_init(obj);
> > -    }
> > -
> >      if (type_has_parent(ti)) {
> >          object_post_init_with_type(obj, type_get_parent(ti));
> >      }
> > +
> > +    if (ti->instance_post_init) {
> > +        ti->instance_post_init(obj);
> > +    }
> >  }
> >  
> >  static void object_initialize_with_type(void *data, size_t size, TypeImpl *type)
> > 
> > IMHO it'll make more sense if we call the parent post_init first (just
> > like most of the other object hooks). Or is current ordering intended?
> 
> I'm not sure.  The point of post_init was to allow the parent
> class to perform actions after all the children classes have done
> their tasks.
> 
> However, if you can prove this won't break existing code and you
> propose an amendment to ObjectClass::instance_post_init
> documentation, we can consider changing the ordering.
> 
> (A quick look at arm_cpu_post_init() seems to indicate the order
> you propose will be more useful for TYPE_ARM_CPU too.)

Exactly. That's one of the reason I asked. I do think it makes more
sense to post_init on parent first, since child always contains extra
things to handle, and it may possibly want to override something of
the parent rather than in a reversed order.

So as you may have already seen, it should not break anything, instead
it may benefit us for at least this series and possibly
arm_cpu_post_init() as well in the future.

Let me propose a patch for it then.  Thanks!

-- 
Peter Xu
