Received: from eggs.gnu.org ([2001:4830:134:3::10]:50971)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dACsk-0004Ac-71
	for qemu-devel@nongnu.org; Mon, 15 May 2017 06:05:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dACsi-0007qP-Rk
	for qemu-devel@nongnu.org; Mon, 15 May 2017 06:05:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58326)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1dACsi-0007qC-JU
	for qemu-devel@nongnu.org; Mon, 15 May 2017 06:05:36 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B553580C27
	for <qemu-devel@nongnu.org>; Mon, 15 May 2017 10:05:35 +0000 (UTC)
Date: Mon, 15 May 2017 18:05:30 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170515100530.GA31572@pxdev.xzpeter.org>
References: <20170511163228.6666-1-quintela@redhat.com>
	<20170511163228.6666-3-quintela@redhat.com>
	<20170512034033.GN28293@pxdev.xzpeter.org>
	<877f1mgx9h.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <877f1mgx9h.fsf@secure.mitica>
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
Cc: qemu-devel@nongnu.org, dgilbert@redhat.com, lvivier@redhat.com

On Fri, May 12, 2017 at 12:55:22PM +0200, Juan Quintela wrote:
> Peter Xu <peterx@redhat.com> wrote:
> > On Thu, May 11, 2017 at 06:32:27PM +0200, Juan Quintela wrote:
> 
> >> @@ -1214,9 +1218,6 @@ void qmp_migrate(const char *uri, bool has_blk, bool blk,
> >>      MigrationParams params;
> >>      const char *p;
> >>  
> >> -    params.blk = has_blk && blk;
> >> -    params.shared = has_inc && inc;
> >> -
> >>      if (migration_is_setup_or_active(s->state) ||
> >>          s->state == MIGRATION_STATUS_CANCELLING ||
> >>          s->state == MIGRATION_STATUS_COLO) {
> >> @@ -1239,6 +1240,7 @@ void qmp_migrate(const char *uri, bool has_blk, bool blk,
> >>      }
> >>  
> >>      if (has_inc && inc) {
> >> +        migrate_set_block_enabled(s, true);
> >>          migrate_set_block_shared(s, true);
> >
> > [2]
> >
> > IIUC for [1] & [2] we are solving the same problem that "shared"
> > depends on "enabled" bit. Would it be good to unitfy this dependency
> > somewhere? E.g., by changing migrate_set_block_shared() into:
> >
> > void migrate_set_block_shared(MigrationState *s, bool value)
> > {
> >     s->enabled_capabilities[MIGRATION_CAPABILITY_BLOCK_SHARED] = value;
> >     if (value) {
> >         migrate_set_block_enabled(s, true);
> >     }
> > }
> 
> ok with this.
> I will add once here that when we disable block enabled, we also disable
> shared, or just let it that way?

I should mark "nitpick" in my above comment. Any way works for me. :)

> 
> > Another thing to mention: after switching to the capability interface,
> > we'll cache the "enabled" and "shared" bits now while we don't cache
> > it before, right? IIUC it'll affect behavior of such sequence:
> >
> > - 1st migrate with enabled=1, shared=1, then
> > - 2nd migrate with enabled=0, shared=0
> >
> > Before the series, the 2nd migrate will use enabled=shared=0, but
> > after the series it should be using enabled=shared=1. Not sure whether
> > this would be a problem (or I missed anything?).
> 
> We can't be consistent with both old/new way.
> 
> Old way: we always setup the capabilities on command line (that should
> have been deprecated long, long ago)
> 
> New way: Once set, they stay set.
> 
> So, alternatives are:
> - If we are going to deprecate the old way, just let things as they are
>   on this patch (easier for me O:-)
> 
> - Always disable this features at the end of migration: Compatible with
>   old migration semantics, bet we are inconsistent with all other
>   capabilities.
> 
> - Add yet more code to only disable them when we are setting them
>   through the command line.  More code to maintain.
> 
> My idea would be to deprecate the migrate command line parameter, that
> is the reason why I did the 1st option.  I hope that in due curse, we
> would be able to remove the code.  But if anyone strongly think that any
> of the other options is better, please let me know.

I assume that sending continuous "migrate" is very rare, right (after
all, normally source VM is useless after that...)? I was just trying
to post this question up, and so... If you/Dave/others won't worry
about its compatibility, I won't either. ;)

Thanks!

-- 
Peter Xu
