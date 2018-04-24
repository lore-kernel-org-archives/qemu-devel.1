Received: from eggs.gnu.org ([2001:4830:134:3::10]:44645)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1fB2e7-0006i9-BS
	for qemu-devel@nongnu.org; Tue, 24 Apr 2018 14:26:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1fB2e4-0003Ap-Jm
	for qemu-devel@nongnu.org; Tue, 24 Apr 2018 14:26:31 -0400
Date: Tue, 24 Apr 2018 14:26:21 -0400
From: Jeff Cody <jcody@redhat.com>
Message-ID: <20180424182621.GX12302@localhost.localdomain>
References: <20180405170619.20480-1-kwolf@redhat.com>
	<87d0ywv9j0.fsf@dusky.pond.sub.org>
	<20180418162823.GH4971@localhost.localdomain>
	<87fu3qx7qx.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87fu3qx7qx.fsf@dusky.pond.sub.org>
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
To: Markus Armbruster <armbru@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, jdurgin@redhat.com, mreitz@redhat.com, qemu-devel@nongnu.org, qemu-block@nongnu.org

On Fri, Apr 20, 2018 at 04:39:02PM +0200, Markus Armbruster wrote:
> Kevin Wolf <kwolf@redhat.com> writes:
> 
> > Am 18.04.2018 um 17:06 hat Markus Armbruster geschrieben:
> >> Kevin Wolf <kwolf@redhat.com> writes:
> >> 
> >> > The legacy command line syntax supports a "password-secret" option that
> >> > allows to pass an authentication key to Ceph. This was not supported in
> >> > QMP so far.
> >> 
> >> We tried during development of v2.9.0 (commit 0a55679b4a5), but reverted
> >> before the release:
> >> 
> >> commit 464444fcc161284ac0e743b99251debc297d5236
> >> Author: Markus Armbruster <armbru@redhat.com>
> >> Date:   Tue Mar 28 10:56:06 2017 +0200
> >> 
> >>     rbd: Revert -blockdev and -drive parameter auth-supported
> >>     
> >>     This reverts half of commit 0a55679.  We're having second thoughts on
> >>     the QAPI schema (and thus the external interface), and haven't reached
> >>     consensus, yet.  Issues include:
> >>     
> >>     * The implementation uses deprecated rados_conf_set() key
> >>       "auth_supported".  No biggie.
> >>     
> >>     * The implementation makes -drive silently ignore invalid parameters
> >>       "auth" and "auth-supported.*.X" where X isn't "auth".  Fixable (in
> >>       fact I'm going to fix similar bugs around parameter server), so
> >>       again no biggie.
> >>     
> >>     * BlockdevOptionsRbd member @password-secret applies only to
> >>       authentication method cephx.  Should it be a variant member of
> >>       RbdAuthMethod?
> >>     
> >>     * BlockdevOptionsRbd member @user could apply to both methods cephx
> >>       and none, but I'm not sure it's actually used with none.  If it
> >>       isn't, should it be a variant member of RbdAuthMethod?
> >>     
> >>     * The client offers a *set* of authentication methods, not a list.
> >>       Should the methods be optional members of BlockdevOptionsRbd instead
> >>       of members of list @auth-supported?  The latter begs the question
> >>       what multiple entries for the same method mean.  Trivial question
> >>       now that RbdAuthMethod contains nothing but @type, but less so when
> >>       RbdAuthMethod acquires other members, such the ones discussed above.
> >>     
> >>     * How BlockdevOptionsRbd member @auth-supported interacts with
> >>       settings from a configuration file specified with @conf is
> >>       undocumented.  I suspect it's untested, too.
> >>     
> >>     Let's avoid painting ourselves into a corner now, and revert the
> >>     feature for 2.9.
> >
> > We tried to address all of these points in the schema of this RFC. Maybe
> > things become easier if we compromise on some.
> >
> >>     Note that users can still configure authentication methods with a
> >>     configuration file.  They probably do that anyway if they use Ceph
> >>     outside QEMU as well.
> >
> > This solution that we originally intended to offer was dismissed by
> > libvirt as unpractical: libvirt allows the user to specify both a config
> > file and a key, and if it wanted to use a config file to pass the key,
> > it would have to create a merged config file and keep it sync with the
> > user config file at all times. Understandable that they want to avoid
> > this.
> >
> >>     Further note that this doesn't affect use of key "auth-supported" in
> >>     -drive file=rbd:...:key=value.
> >>     
> >>     qemu_rbd_array_opts()'s parameter @type now must be RBD_MON_HOST,
> >>     which is silly.  This will be cleaned up shortly.
> >>     
> >>     Signed-off-by: Markus Armbruster <armbru@redhat.com>
> >>     Reviewed-by: Max Reitz <mreitz@redhat.com>
> >>     Reviewed-by: Eric Blake <eblake@redhat.com>
> >>     Reviewed-by: Jeff Cody <jcody@redhat.com>
> >>     Message-id: 1490691368-32099-9-git-send-email-armbru@redhat.com
> >>     Signed-off-by: Jeff Cody <jcody@redhat.com>
> >> 
> >> > This patch introduces authentication options in the QAPI schema, makes
> >> > them do the corresponding rados_conf_set() calls and adds compatibility
> >> > code that translates the old "password-secret" option both for opening
> >> 
> >> Suggest 'the old "password-secret" command line option parameter'.
> >> 
> >> > and creating images to the new set of options.
> >> >
> >> > Note that the old option didn't allow to explicitly specify the set of
> >> 
> >> Likewise, 'the old option parameter'.
> >> 
> >> > allowed authentication schemes. The compatibility code assumes that if
> >> > "password-secret" is given, only the cephx scheme is allowed. If it's
> >> > missing, both none and cephx are allowed because the configuration file
> >> > could still provide a key.
> >> 
> >> This is a bit terse for readers who aren't familiar with the way things
> >> work now (or have since forgotten pretty much everything about it, like
> >> me).
> >> 
> >> Perhaps spelling out how the compatibility code translates the old
> >> option parameter to BlockdevOptionsRbd would help.
> >> 
> >> > Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> >> > ---
> >> >
> >> > This doesn't actually work correctly yet because the way that options
> >> > are passed through the block layer (QAPI -> QemuOpts -> QDict). Before
> >> > we fix or hack around this, let's make sure this is the schema that we
> >> > want.
> >> 
> >> Makes sense.
> >> 
> >> > The two known problems are:
> >> >
> >> > 1. QDict *options in qemu_rbd_open() may contain options either in their
> >> >    proper QObject types (if passed from blockdev-add) or as strings
> >> >    (-drive). Both forms can be mixed in the same options QDict.
> >> 
> >> Remind me, how can such a mix happen?
> >
> > The way I'm aware of is that you use blockdev-add, so you get the real
> > types for some options, and then the block layer adds strings for
> > default values.
> 
> I see.
> 
> >> >    rbd uses the keyval visitor to convert the options into a QAPI
> >> >    object. This means that it requires all options to be strings. This
> >> >    patch, however, introduces a bool property, so the visitor breaks
> >> >    when it gets its input from blockdev-add.
> >> >
> >> >    Options to hack around the problem:
> >> >
> >> >    a. Do an extra conversion step or two and go through QemuOpts like
> >> >       some other block drivers. When I offered something like this to
> >> >       Markus a while ago in a similar case, he rejected the idea.
> >> 
> >> Going through QemuOpts just to get rid of strings is a bit like going
> >> down Niagara Falls in a barrel just to get rid of sleepiness: it'll do
> >> that, sure, but it's probably not all it'll do.
> >
> > Nice comparison. I tend to agree, though there is much more precedence
> > for this one than for all other options. Almost all block drivers use
> > QemuOpts to parse their driver-specific options from the QDict.
> 
> For historical reasons.  If I remember correctly, QemuOpts got there
> first, QDict was spliced in later.
> 
> >> >    b. Introduce a qdict_stringify_entries() that just does what its name
> >> >       says. It would be called before the running keyval visitor so that
> >> >       only strings will be present in the QDict.
> >> 
> >> Precedence: a bunch of other QDict operations that are used only by the
> >> block layer.  One more won't make a difference, I guess.
> >> 
> >> Aside: I'm tempted to move them out of qdict.h to reduce the temptation
> >> to use them outside the block layer.
> >
> > Unrelated cleanup, but seems reasonable. block/qdict.h?
> 
> Works for me.  No rush.
> 
> >> >    c. Do a local one-off hack that checks if the entry with the key
> >> >       "auth-none" is a QBool, and if so, overwrite it with a string. The
> >> >       problem will reappear with the next non-string option.
> >> 
> >> Defensible only if we're fairly confident such options will remain rare.
> >> 
> >> >    (d. Get rid of the QDict detour and work only with QAPI objects
> >> >        everywhere. Support rbd authentication only in QEMU 4.0.)
> >> 
> >> This is of course the proper solution, but it's a big project that will
> >> take time.  The occasional stop gaps are unavoidable.  We just need to
> >> take care not to spend all of our cycles on stop gaps, and none on
> >> actual progress.
> >> 
> >>      e. Make the keyval visitor accept scalars other than strings.
> >> 
> >> More efficient than b., doubt it matters.  Complicates the visitor.
> >> Harder to back out than b. when we no longer need it.
> >> 
> >> I'm leaning towards b.
> >
> > Okay, that's what I was leaning towards, too.
> 
> Good.
> 
> >> > 2. The proposed schema allows 'auth-cephx': {} as a valid option with
> >> >    the meaning that the cephx authentication scheme is enabled, but no
> >> >    key is given (e.g. it is taken from the config file).
> >> 
> >> Apropos config file: we need to be careful to maintain the QAPI schema's
> >> promise that "Values in the configuration file will be overridden by
> >> options specified via QAPI."
> >
> > Yes, though it's made a bit easier by the fact that most options are
> > implemented with a rados_conf_set() call. If you call the function, you
> > override the config, if not, you don't.
> 
> Good.
> 
> As mentioned in my reply to Dan, the config file can't serve as stable
> interface here: we break it whenever we add options to QAPI.  Can't see
> anything we could do but document the issue.
> 
> >> >    However, an empty dict cannot currently be represented by flattened
> >> >    QDicts.
> >> 
> >> Flattening a QDict moves nested scalars to the root (with dotted keys),
> >> and drops nested non-scalars, i.e. QDict, QList.  A nested empty QDict
> >> (or QList) vanishes without trace.
> >> 
> >> >            We need to find a way to enable this. I think this will be
> >> >    externally visible because it directly translates into the dotted
> >> >    syntax of -blockdev, so we may want to be careful.
> >> 
> >> Quote keyval.c:
> >> 
> >>  * Design flaw: there is no way to denote an empty array or non-root
> >>  * object.  While interpreting "key absent" as empty seems natural
> >>  * (removing a key-val from the input string removes the member when
> >>  * there are more, so why not when it's the last), it doesn't work:
> >>  * "key absent" already means "optional object/array absent", which
> >>  * isn't the same as "empty object/array present".
> >> 
> >> Getting that syntax right was hairy (you'll probably remember the
> >> lengthy e-mail discussions).  I'm reluctant to revisit it.  We concluded
> >> back then that dotted key syntax capable of expressing arbitrary JSON
> >> wasn't in the cards, but that the cases it can't do are so exotic that
> >> users should just fall back to JSON.  And that would be my advice here.
> >> 
> >> Can we design a schema that avoids this case?  Let's see below.
> >
> > Can we design such a schema? Yes.
> >
> > Will we like it enough to accept it as a compromise? Maybe.
> 
> That's fine.  We explore the design space, and pick what we hate least.
> This RFC is a fine start.
> 
> >> > Any thoughts on the proposed QAPI schema or the two implementation
> >> > problems are welcome.
> >> >
> >> >  qapi/block-core.json |  22 +++++++++++
> >> >  block/rbd.c          | 102 ++++++++++++++++++++++++++++++++++++++-------------
> >> >  2 files changed, 99 insertions(+), 25 deletions(-)
> >> >
> >> > diff --git a/qapi/block-core.json b/qapi/block-core.json
> >> > index c50517bff3..d5ce588add 100644
> >> > --- a/qapi/block-core.json
> >> > +++ b/qapi/block-core.json
> >> > @@ -3170,6 +3170,19 @@
> >> >  
> >> >  
> >> >  ##
> >> > +# @RbdAuthCephx:
> >> > +#
> >> > +# @key-secret:         ID of a QCryptoSecret object providing a key for cephx
> >> > +#                      authentication. If not specified, a key from the
> >> > +#                      specified configuration file, or the system default
> >> > +#                      configuration is used, if present.
> >> > +#
> >> > +# Since: 2.13
> >> > +##
> >> > +{ 'struct': 'RbdAuthCephx',
> >> > +  'data': { '*key-secret': 'str' } }
> >> > +
> >> > +##
> >> >  # @BlockdevOptionsRbd:
> >> >  #
> >> >  # @pool:               Ceph pool name.
> >> > @@ -3184,6 +3197,13 @@
> >> >  #
> >> >  # @user:               Ceph id name.
> >> >  #
> >> > +# @auth-none:          true if connecting to a server without authentication
> >> > +#                      should be allowed (default: false; since 2.13)
> >> > +#
> >> > +# @auth-cephx:         Configuration for cephx authentication if specified. If
> >> > +#                      not specified, cephx authentication is not allowed.
> >> > +#                      (since 2.13)
> >> > +#
> >> >  # @server:             Monitor host address and port.  This maps
> >> >  #                      to the "mon_host" Ceph option.
> >> >  #
> >> > @@ -3195,6 +3215,8 @@
> >> >              '*conf': 'str',
> >> >              '*snapshot': 'str',
> >> >              '*user': 'str',
> >> > +            '*auth-none': 'bool',
> >> > +            '*auth-cephx': 'RbdAuthCephx',
> >> >              '*server': ['InetSocketAddressBase'] } }
> >> >  
> >> >  ##
> >> 
> >> Two new optional members @auth-none, @auth-cephx.
> >> 
> >> For backwards compatibility, behavior needs to remain unchanged when
> >> both are absent.  What is the behavior we need to preserve?  Config
> >> file, then default?
> >
> > Yes. (rados_conf_set("auth_client_required") is not called at all.)
> >
> >> The schema permits four cases, which get translated to an auth client
> >> required setting by qemu_rbd_set_auth(), visible below:
> >> 
> >> (1) just auth-none: we set auth_client_required to "none"
> >> 
> >> (2) just auth-cephx: we set auth_client_required to "cephx"
> >> 
> >> (3) both: we set auth_client_required to "none;cephx", which I can't
> >>     find in the documentation right now, but according to my notes means
> >>     "either method"
> >
> > The state of the Ceph documentation indeed wasn't very helpful. On the
> > other hand, I'm afraid we're not in a position to complain about bad
> > documentation...
> 
> Right on both counts.
> 
> >> (4) neither: rejected with "No authentication scheme allowed"
> >>     Uh, why isn't this a compatibility break?  Or am I confused?
> >
> > It is, and that is one of the reasons why this patch is broken. I failed
> > to mention this in the commit message, but I replied to the patch the
> > next day to add this.
> 
> You mean I'm supposed to read the whole thread before I start posting to
> it?!?
> 
> >> When auth-cephx is present, we get subcases
> >> 
> >> (2a) and (3a) key-secret present: key is in the QCryptoSecret named, and
> >> we set
> >> 
> >> (2b) and (3b) key-secret absent: key must be provided some other way,
> >>      say in a configuration file, default keyring, whatever, or else
> >>      we'll fail somehow, I guess
> >> 
> >> Related: existing BlockdevOptionsRbd member @user.  As far as I know,
> >> it's meaningless with auth-none.
> >
> > I don't know otherwise and suspect you are right, but Jeff and I
> > couldn't find any definite confirmation for this assumption, so we left
> > it where it is instead of moving it into RbdAuthCephx.
> 
> I pestered Jason Dillaman about this stuff back then, and he explained
> 
>     If the auth is set to none, the user is technically irreverent.  I
>     can run a command like "rbd --id this_user_does_not_exist rm
>     image_name" and it will succeed if cephx is disabled on the server.
> 
> Off list, Jeff was cc'ed, you weren't.
> 
> >> Ways to avoid the troublesome auth-cephx: {}:
> >> 
> >> (A) Make auth-cephx a bool, rely on the other ways to provide the key
> >> 
> >> (B) Make auth-cephx a bool and add the @key-secret member next to it
> >> 
> >>     Like @user, the member is meaningless with auth-none.
> >> 
> >> (C) Make auth-cephx.key-secret a mandatory StrOrNull
> >> 
> >>     Should take care of "vanishes on flattening" problem, but dotted key
> >>     syntax is still screwed: since any value is a valid string, there's
> >>     none left for null.  My take would be that if you want to say
> >>     auth-cephx.key-secret: {}, you get to say it in JSON.
> >> 
> >>     Aside: check_alternate() tries to catch such alternates, but we
> >>     failed to update it when we added first class null.  *sigh*
> >> 
> >> Which one do you hate least?
> >
> > What should happen with null when you stringify it? If we want to take
> > the options QDict, stringify all entries and run them through the keyval
> > visitor, I'm almost sure that null will be lost.
> 
> For the stringify idea to work, the keyval visitor needs to map the
> string right back to the original value.
> 
> The keyval visitor currently requires the value to be null, not a
> string.
> 
> Therefore, the stringify operation must leave null alone.  Not pretty,
> but works.
> 
> You might ask why not change the keyval visitor instead so it expects ""
> rather than null.  That's no good, because it makes StrOrNull ambiguous.
> 
> keyval.c can only create string scalars.  I think "use JSON if you want
> to specify null" is still good enough.  We can make keyval.c more
> expressive if we need to, but (1) I don't think we should block this
> work on it, and (2) see "hairy" above.
> 
> > So (A) doesn't work unless we can specify what "other ways" are that are
> > acceptable for libvirt,
> 
> Yes.
> 
> >                         and (C) probably doesn't play well with b. above
> > (the qdict_stringify_entries() for handling mixed type QDicts).
> 
> I think it could be done, and tried to sketch how.
> 
> > Looks like only (B) is left as viable, so that's automatically the one I
> > hate least of these. If we can fix the problems, I think I'd prefer (C),
> > though.
> 
> I could accept (B), in particular since it mirrors existing @user.
> 
> I'm happy to help with exploring (C).
> 
> What's the next step?

My preference is (B).  Primarily because I don't like the idea of breaking
dotted key syntax for null keys.  I'd rather see something more verbose like
(B), that can still be navigated correctly both ways.

How about I put together a patch with (B) for an RFC v2?


-Jeff
