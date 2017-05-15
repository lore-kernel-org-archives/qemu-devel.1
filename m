Received: from eggs.gnu.org ([2001:4830:134:3::10]:33513)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dAJ1I-0006QN-Ek
	for qemu-devel@nongnu.org; Mon, 15 May 2017 12:38:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dAJ1F-000713-9O
	for qemu-devel@nongnu.org; Mon, 15 May 2017 12:38:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40338)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1dAJ1F-00070X-0M
	for qemu-devel@nongnu.org; Mon, 15 May 2017 12:38:49 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 642B761A14
	for <qemu-devel@nongnu.org>; Mon, 15 May 2017 16:38:47 +0000 (UTC)
Date: Mon, 15 May 2017 17:38:41 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170515163841.GB2324@work-vm>
References: <20170511163228.6666-1-quintela@redhat.com>
	<20170511163228.6666-3-quintela@redhat.com>
	<20170512034033.GN28293@pxdev.xzpeter.org>
	<877f1mgx9h.fsf@secure.mitica>
	<5bab598f-30eb-fcf6-9d06-8f683b466414@redhat.com>
	<87lgpyfo28.fsf@secure.mitica> <87k25iqf4m.fsf@dusky.pond.sub.org>
	<87efvqdqqj.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87efvqdqqj.fsf@secure.mitica>
Subject: Re: [Qemu-devel] [PATCH 2/3] migration: Remove use of old
 MigrationParams
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Juan Quintela <quintela@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>, lvivier@redhat.com, qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>

* Juan Quintela (quintela@redhat.com) wrote:
> Markus Armbruster <armbru@redhat.com> wrote:
> > Juan Quintela <quintela@redhat.com> writes:
> >
> >> Eric Blake <eblake@redhat.com> wrote:
> 
> 
> >>> Or is the proposal that we are also going to simplify the QMP 'migrate'
> >>> command to get rid of crufty parameters?
> >>
> >> I didn't read it that way, but I would not oppose O:-)
> >>
> >> Later, Juan.
> >
> > I'm not too familiar with this stuff, so please correct my
> > misunderstandings.
> >
> > "Normal" migration configuration is global state, i.e. it applies to all
> > future migrations.
> >
> > Except the "migrate" command's flags apply to just the migration kicked
> > off by that command.
> >
> > QMP command "migrate" has two flags "blk" (HMP: -b) and "inc" (HMP: -i).
> > !blk && inc makes no sense and is silently treated like !blk && !inc.
> >
> > There's a third flag "detach" (HMP: -d), but it does nothing in QMP.
> 
> As qmp command is asynchronous, you can think that -d is *always* on in
> QMP O:-)
> 
> > You'd like to deprecate these flags in favour of "normal" configuration.
> > However, we need to maintain QMP backward compatibility at least for a
> > while.  HMP backward compatibility is nice to have, but not required.
> >
> > First step is to design the new interface you want.  Second step is to
> > figure out backward compatibility.
> >
> > The new interface adds a block migration tri-state (off,
> > non-incremental, incremental) to global state, default off.  Whether
> > it's done as two bools or an enum of three values doesn't matter here.
> 
> Tristates will complicate it.  I still think that:
> 
> - capability: block_migration
> - parameter: block_shared
> 
> Makes more sense, no?

I don't understand what making block_shared a parameter gives you as
opposed to simply having two capabilities.

(And how did we get 'shared'? We started off with block & incremental)

Dave

> If block_migration is not enabled, we ignore the shared parameter.  We
> already do that for other parameters.
> 
> > If the new interface isn't used, the old one still needs to work.  If it
> > is used, the old one either has to do "the right thing", or fail
> > cleanly.
> >
> > We approximate "new interface isn't used" by "block migration is off in
> > global state".  When it is off, the migration command needs to honor its
> > two flags for compatibility.  It must leave block migration off in
> > global state.  Yes, this will complicate the implementation until we
> > actually remove the deprecated flags.  Par for the backward compatility
> > course.
> >
> > When block migration isn't off in global state, we can either
> >
> > * let the flags take precedence over the global state (one
> >   interpretation of "do the right thing"), or
> >
> > * reject flags that conflict with global state (another interpretation),
> >   or
> >
> > * reject *all* flags (fail cleanly).
> >
> > The last one looks perfectly servicable to me.
> 
> Yeap,  I think that makes sense.  If you use capabilities, parameters,
> old interface don't work at all.
> 
> We still have a problem that is what happens if the user does:
> 
> migrate -b <foo>
> migrate_cancel (or error)
> migrate <bar> (without -b)
> 
> With current patches, it will still use -b.  Fixing it requires still
> anding more code.  But I think that this use case is so weird what we
> should not even care about it.
> 
> Later, Juan.
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
