Received: from eggs.gnu.org ([2001:4830:134:3::10]:32910)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dIwoM-00052i-4b
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 08:45:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dIwoH-00056U-6V
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 08:45:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48962)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1dIwoG-00055r-UI
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 08:45:09 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E725279704
	for <qemu-devel@nongnu.org>; Thu,  8 Jun 2017 12:45:07 +0000 (UTC)
Date: Thu, 8 Jun 2017 20:44:58 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170608124458.GF3628@pxdev.xzpeter.org>
References: <1496745042-2379-1-git-send-email-peterx@redhat.com>
	<1496745042-2379-3-git-send-email-peterx@redhat.com>
	<87k24nd78e.fsf@secure.mitica>
	<20170608104127.GE3628@pxdev.xzpeter.org>
	<87efuubun6.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87efuubun6.fsf@secure.mitica>
Subject: Re: [Qemu-devel] [PATCH 2/6] migration: move global_state.optional
 out
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Juan Quintela <quintela@redhat.com>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, Laurent Vivier <lvivier@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

On Thu, Jun 08, 2017 at 01:12:29PM +0200, Juan Quintela wrote:
> Peter Xu <peterx@redhat.com> wrote:
> > On Wed, Jun 07, 2017 at 07:42:57PM +0200, Juan Quintela wrote:
> 
> >> > +/* This is only used if MigrationState.store_global_state is set. */
> >> >  static GlobalState global_state;
> >> >  
> >> >  int global_state_store(void)
> >> > @@ -179,7 +179,7 @@ static RunState global_state_get_runstate(void)
> >> >  
> >> >  void global_state_set_optional(void)
> >> >  {
> >> > -    global_state.optional = true;
> >> > +    migrate_get_current()->store_global_state = false;
> >> 
> >> Part of the advantage (for me) of using qapi was not to have to export
> >> a function to set this.  I.e.  isn't a way to call
> >> 
> >> qemu_opt_get_bool(migration_opts, "store_global_state", true)
> >> 
> >> qapi_<magic>_set_bool(migration_opts, "store_global_state",false);
> >> ?
> >
> > I didn't catch the comment here... Do you mean e.g.
> > qemu_opt_set_bool()? Here can we use it in some way?
> >
> > (I thought we were using the "-global migration.store_global_state"
> >  parameter, then it'll setup MigrationState.store_global_state, isn't
> >  that the trick?)
> 
> Yeap.  Althought for me would be the same if that is stored anywhare
> else.  I don't really care where it is stored.
> 
> >> 
> >> So, I don't have to eport global_state_set_optional()?
> >> 
> >
> > As mentioned in latter patch, xen_init() still uses it, so looks like
> > we still need it?
> 
> Yeap.  I *thought* that there was a way to test/set thing
> programatically also so I didn't have to create/export that functions.
> My ideal world would be that there were something like that
> 
> qemu_opt_get_bool(migration_opts, "store_global_state", true);
> 
> so I only have to export migration_opts (or whatever), and just set/read
> values from places like xen_init.  Im my ideal world, if I have to
> create a new "property", I don't want to have to export a function to
> set/read it.  For instance, the case of xen_init().  We haven't been
> able to remove global_state_set_optional() because they don't know about
> properties.
> 
> I still love the patches are they are.  Boing able to set things from
> the command line makes things so much better/easier O:-)

Oh, looks like what we need to do is just export
register_compat_prop(), then xen_init() can use it.

I'll try that tomorrow. :)

-- 
Peter Xu
