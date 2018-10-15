Received: from eggs.gnu.org ([2001:4830:134:3::10]:33110)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gBzK9-0005iM-Q4
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 05:38:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gBzK8-0003Wv-Fz
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 05:38:05 -0400
Date: Mon, 15 Oct 2018 11:37:53 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20181015093753.GB10459@localhost.localdomain>
References: <20181012115532.12645-1-kwolf@redhat.com>
	<20181012115532.12645-3-kwolf@redhat.com>
	<12e95cce-ab82-08e3-b0ae-2307fe94a392@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <12e95cce-ab82-08e3-b0ae-2307fe94a392@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 2/8] block: Add auto-read-only option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-block@nongnu.org, mreitz@redhat.com, pkrempa@redhat.com, qemu-devel@nongnu.org

Am 12.10.2018 um 18:47 hat Eric Blake geschrieben:
> On 10/12/18 6:55 AM, Kevin Wolf wrote:
> > If a management application builds the block graph node by node, the
> > protocol layer doesn't inherit its read-only option from the format
> > layer any more, so it must be set explicitly.
> > 
> 
> > The documentation for this option is consciously phrased in a way that
> > allows QEMU to switch to a better model eventually: Instead of trying
> > when the image is first opened, making the read-only flag dynamic and
> > changing it automatically whenever the first BLK_PERM_WRITE user is
> > attached or the last one is detached would be much more useful
> > behaviour.
> > 
> > Unfortunately, this more useful behaviour is also a lot harder to
> > implement, and libvirt needs a solution now before it can switch to
> > -blockdev, so let's start with this easier approach for now.
> 
> I agree both with the approach of getting the simpler implementation in now
> (always writable, even when we don't need to write) as well as wording the
> documentation to permit a future stricter approach (only writable at the
> points where we need to write).
> 
> > 
> > Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> > ---
> >   qapi/block-core.json  |  6 ++++++
> >   include/block/block.h |  2 ++
> >   block.c               | 21 ++++++++++++++++++++-
> >   block/vvfat.c         |  1 +
> >   4 files changed, 29 insertions(+), 1 deletion(-)
> > 
> > diff --git a/qapi/block-core.json b/qapi/block-core.json
> > index cfb37f8c1d..3a899298de 100644
> > --- a/qapi/block-core.json
> > +++ b/qapi/block-core.json
> > @@ -3651,6 +3651,11 @@
> >   #                 either generally or in certain configurations. In this case,
> >   #                 the default value does not work and the option must be
> >   #                 specified explicitly.
> > +# @auto-read-only: if true, QEMU may ignore the @read-only option and
> > +#                  automatically decide whether to open the image read-only or
> > +#                  read-write (and switch between the modes later), e.g.
> > +#                  depending on whether the image file is writable or whether a
> > +#                  writing user is attached to the node (default: false).
> 
> Bike-shedding: Do we really want to ignore @read-only? Here's the table of 9
> combinations ('t'rue, 'f'alse, 'o'mitted), with '*' on the rows that must be
> preserved for back-compat:
> 
> RO   Auto   effect
> o    o      *open for write, fail if not possible
> f    o      *open for write, fail if not possible
> t    o      *open for read, no conversion to write
> o    f      open for write, fail if not possible
> f    f      open for write, fail if not possible
> t    f      open for read, no conversion to write
> o    t      attempt write but graceful fall back to read
> f    t      attempt write but graceful fall back to read
> t    t      ignore RO flag, attempt write anyway
> 
> That last row is weird, why not make it an explicit error instead of
> ignoring the implied difference in semantics between the two?

You're right that the description allows this. In practice,
auto-read-only can only make a node go from rw to ro, not the other way
round.

So our options are to document the current behaviour (auto-read-only has
no effect when the image is already read-only) or to make it an error.

One thought I had is that for convenience options like -hda (or in fact
-drive), auto-read-only=on could be the default, and only -blockdev and
blockdev-add would disable it by default. That would suggest that we
don't want to make it an error.

> Or, another idea: is it worth trying to support a single tri-state member
> (via an alternative between bool and enum, since the existing code uses a
> JSON bool):
> 
> "read-only": false (open for write, fail if not possible)
> "read-only": true (open read-only, no later switching)
> "read-only": "auto" (switch as needed; or for initial implementation attempt
> for write with graceful fallback to read)
> omitting read-only: same as "read-only":false for back-compat

If read-only were new, I would probably make it an enum, but adding it
now isn't very practical. I did actually start with an alternate and it
just wasn't very nice. One thing I remember is places that directly
accessed the options QDict, for which you could now have either a bool, a
string, an int or not present. It becomes a bit too much.

As read-only is optional, we could make it true/false/absent without
introducing an alternate and the additional int/string options, but I
don't like that very much either.


While we're talking about the schema, another thing I considered was
making auto-read-only an option only for the specific drivers that
support it so introspection could tell the management tool whether the
functionality is available. However, if we do this, we can't parse it in
block.c code and use a flag any more, but need to parse it in each
driver individually. Maybe it would be a better design anyway?

> > @@ -1328,6 +1338,11 @@ QemuOptsList bdrv_runtime_opts = {
> >               .type = QEMU_OPT_BOOL,
> >               .help = "Node is opened in read-only mode",
> >           },
> > +        {
> > +            .name = BDRV_OPT_AUTO_READ_ONLY,
> > +            .type = QEMU_OPT_BOOL,
> > +            .help = "Node can become read-only if opening read-write fails",
> > +        },
> 
> If we keep your current approach, is it worth mentioning that
> auto-read-only true overrides read-only true?

This help text is never printed anywhere anyway... Maybe we should just
delete it. What we refer to is the QAPI documentation anyway.

Kevin
