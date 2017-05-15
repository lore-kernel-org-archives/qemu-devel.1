Received: from eggs.gnu.org ([2001:4830:134:3::10]:59228)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dADTb-00070t-4T
	for qemu-devel@nongnu.org; Mon, 15 May 2017 06:43:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dADTY-0001Vm-3T
	for qemu-devel@nongnu.org; Mon, 15 May 2017 06:43:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35020)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1dADTX-0001V8-Q3
	for qemu-devel@nongnu.org; Mon, 15 May 2017 06:43:40 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id BC5CB15567
	for <qemu-devel@nongnu.org>; Mon, 15 May 2017 10:43:38 +0000 (UTC)
Date: Mon, 15 May 2017 11:43:33 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170515104332.GE2089@work-vm>
References: <20170511163228.6666-1-quintela@redhat.com>
	<20170511163228.6666-3-quintela@redhat.com>
	<20170512034033.GN28293@pxdev.xzpeter.org>
	<877f1mgx9h.fsf@secure.mitica>
	<5bab598f-30eb-fcf6-9d06-8f683b466414@redhat.com>
	<87lgpyfo28.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87lgpyfo28.fsf@secure.mitica>
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
Cc: Eric Blake <eblake@redhat.com>, Peter Xu <peterx@redhat.com>, lvivier@redhat.com, qemu-devel@nongnu.org

* Juan Quintela (quintela@redhat.com) wrote:
> Eric Blake <eblake@redhat.com> wrote:
> > On 05/12/2017 05:55 AM, Juan Quintela wrote:
> >>>> @@ -1239,6 +1240,7 @@ void qmp_migrate(const char *uri, bool has_blk, bool blk,
> >>>>      }
> >>>>  
> >>>>      if (has_inc && inc) {
> >>>> +        migrate_set_block_enabled(s, true);
> >>>>          migrate_set_block_shared(s, true);
> >>>
> >>> [2]
> >>>
> >>> IIUC for [1] & [2] we are solving the same problem that "shared"
> >>> depends on "enabled" bit. Would it be good to unitfy this dependency
> >>> somewhere? E.g., by changing migrate_set_block_shared() into:
> >>>
> >>> void migrate_set_block_shared(MigrationState *s, bool value)
> >>> {
> >>>     s->enabled_capabilities[MIGRATION_CAPABILITY_BLOCK_SHARED] = value;
> >>>     if (value) {
> >>>         migrate_set_block_enabled(s, true);
> >>>     }
> >>> }
> >> 
> >> ok with this.
> >
> > Or, as I commented on 1/3, maybe having a single property that is a
> > tri-state enum value, instead of 2 separate boolean properties, might be
> > nicer (but certainly a bit more complex to code up).
> 
> If you teach me how to do the qapi/qmp part, I will do the other bits.
> I don't really care if we do it one way or the other.
> 
> >> I will add once here that when we disable block enabled, we also disable
> >> shared, or just let it that way?
> >> 
> >>> Another thing to mention: after switching to the capability interface,
> >>> we'll cache the "enabled" and "shared" bits now while we don't cache
> >>> it before, right? IIUC it'll affect behavior of such sequence:
> >>>
> >>> - 1st migrate with enabled=1, shared=1, then
> >>> - 2nd migrate with enabled=0, shared=0
> >>>
> >>> Before the series, the 2nd migrate will use enabled=shared=0, but
> >>> after the series it should be using enabled=shared=1. Not sure whether
> >>> this would be a problem (or I missed anything?).
> >> 
> >> We can't be consistent with both old/new way.
> >> 
> >> Old way: we always setup the capabilities on command line (that should
> >> have been deprecated long, long ago)
> >
> > Well, the easy way out is to have the HMP migrate command (I assume
> > that's what you mean by "on command line") explicitly clear the
> > parameters if it is called without the -b/-i flag.  So the start of each
> > migration is what changes the properties, so long as you are still using
> > HMP to start the migration.  Or, on the QMP side, since 'migrate' has
> > optional 'blk' and 'inc' booleans, basically leave the settings alone if
> > the parameters were omitted, and explicitly update the property to the
> > value of those parameters if they were present.
> 
> We are going to have trouble whatever way that we do it, or we start
> doing lots of strange things.
> 
> Forget about qmp, we are going to assume that it is consistent with hmp.
> 
> migrate_set_capabilities block_enabled on
> migrate -b .....
> 
> Should migrate disable the block_enabled capability?  Give one
> warning/error?
> 
> And notice that this only matter if we do a migration, we cancel/get one
> error, and then we migrate again.
> 
> What I tried to do is assume that -b/-i arguments don't exist.  And if
> the user use them, we implement its behaviour with the minimal fuss
> possibly.
> 
> Only way that I can think of being consistent and bug compatible will be
> to store:
> - old block_shared/enanbeld capability value
> - if we set -b/-i on the command line
> 
> In migration cleanup do the right thing depending on this four
> variables.  I think that it is adding lots of complexity for very few
> improvement.
> 
> 
> > Or is the proposal that we are also going to simplify the QMP 'migrate'
> > command to get rid of crufty parameters?
> 
> I didn't read it that way, but I would not oppose O:-)
> 

Ewww this is messy; you end up with almost as much code as the old
flags you're trying to remove.
For HMP you could gently deprecate the flags over time and give
a warning telling people to use the capabilities; but doing that
in one go is a bit nasty, and you still have to do something
cleverer for the QMP which is similar.
 
I think I agree though that migrate, cancel, migrate should work
sensibly and it's hard to get it right.

Dave

> Later, Juan.
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
