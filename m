Received: from eggs.gnu.org ([2001:4830:134:3::10]:38765)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fBFC9-0001nb-A9
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 03:50:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fBFC8-0006DJ-4l
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 03:50:29 -0400
Date: Wed, 25 Apr 2018 09:50:19 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180425075019.GA4652@localhost.localdomain>
References: <20180405170619.20480-1-kwolf@redhat.com>
	<87d0ywv9j0.fsf@dusky.pond.sub.org>
	<20180418162823.GH4971@localhost.localdomain>
	<87fu3qx7qx.fsf@dusky.pond.sub.org>
	<20180424182621.GX12302@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180424182621.GX12302@localhost.localdomain>
Subject: Re: [Qemu-devel] [RFC][BROKEN] rbd: Allow configuration of
 authentication scheme
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jeff Cody <jcody@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, jdurgin@redhat.com, mreitz@redhat.com, qemu-devel@nongnu.org, qemu-block@nongnu.org

Am 24.04.2018 um 20:26 hat Jeff Cody geschrieben:
> On Fri, Apr 20, 2018 at 04:39:02PM +0200, Markus Armbruster wrote:
> > >> Ways to avoid the troublesome auth-cephx: {}:
> > >> 
> > >> (A) Make auth-cephx a bool, rely on the other ways to provide the key
> > >> 
> > >> (B) Make auth-cephx a bool and add the @key-secret member next to it
> > >> 
> > >>     Like @user, the member is meaningless with auth-none.
> > >> 
> > >> (C) Make auth-cephx.key-secret a mandatory StrOrNull
> > >> 
> > >>     Should take care of "vanishes on flattening" problem, but dotted key
> > >>     syntax is still screwed: since any value is a valid string, there's
> > >>     none left for null.  My take would be that if you want to say
> > >>     auth-cephx.key-secret: {}, you get to say it in JSON.
> > >> 
> > >>     Aside: check_alternate() tries to catch such alternates, but we
> > >>     failed to update it when we added first class null.  *sigh*
> > >> 
> > >> Which one do you hate least?
> > >
> > > What should happen with null when you stringify it? If we want to take
> > > the options QDict, stringify all entries and run them through the keyval
> > > visitor, I'm almost sure that null will be lost.
> > 
> > For the stringify idea to work, the keyval visitor needs to map the
> > string right back to the original value.
> > 
> > The keyval visitor currently requires the value to be null, not a
> > string.
> > 
> > Therefore, the stringify operation must leave null alone.  Not pretty,
> > but works.

Okay, I didn't know that the keyval visitor has any way to specify null.
It doesn't really matter what the exact representation is as long as we
can generate it. So sure, that's workable then.

> > You might ask why not change the keyval visitor instead so it expects ""
> > rather than null.  That's no good, because it makes StrOrNull ambiguous.
> > 
> > keyval.c can only create string scalars.  I think "use JSON if you want
> > to specify null" is still good enough.  We can make keyval.c more
> > expressive if we need to, but (1) I don't think we should block this
> > work on it, and (2) see "hairy" above.
> > 
> > > So (A) doesn't work unless we can specify what "other ways" are that are
> > > acceptable for libvirt,
> > 
> > Yes.
> > 
> > >                         and (C) probably doesn't play well with b. above
> > > (the qdict_stringify_entries() for handling mixed type QDicts).
> > 
> > I think it could be done, and tried to sketch how.
> > 
> > > Looks like only (B) is left as viable, so that's automatically the one I
> > > hate least of these. If we can fix the problems, I think I'd prefer (C),
> > > though.
> > 
> > I could accept (B), in particular since it mirrors existing @user.

I don't like (B) much because it adds additional rules which options
must, may or can be present depending on the presence or value of other
options. This kind of dependencies should be visible in the schema with
nested structs and unions, and checked for consistency by QAPI, rather
than being checked individually in .bdrv_open() implementations.

As for @user, you had sources to confirm that it is indeed irrelevant
for 'none', so I'd rather do the opposite thing and move it to
RbdAuthCephx.

> > I'm happy to help with exploring (C).
> > 
> > What's the next step?
> 
> My preference is (B).  Primarily because I don't like the idea of breaking
> dotted key syntax for null keys.  I'd rather see something more verbose like
> (B), that can still be navigated correctly both ways.

Yes, it's not perfect, but it doesn't make any functionality unavailable
because you can always using JSON, even on the command line. Dotted
syntax is nicer for manual use, but in this specific case I think null
will be the default, so there is no need to specify it explicitly
anyway - neither with dotted key syntax nor with JSON.

I prefer slightly unwieldy command line syntax to getting the internally
used data types wrong (= hard to use correctly).

> How about I put together a patch with (B) for an RFC v2?

How about doing the same with (C) and moving @user? :-)

Kevin
