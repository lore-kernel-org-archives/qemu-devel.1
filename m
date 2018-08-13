Received: from eggs.gnu.org ([2001:4830:134:3::10]:57188)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fp8px-0001Qk-0u
	for qemu-devel@nongnu.org; Mon, 13 Aug 2018 05:08:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fp8pv-0000yL-Fc
	for qemu-devel@nongnu.org; Mon, 13 Aug 2018 05:08:28 -0400
Date: Mon, 13 Aug 2018 11:08:19 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180813090819.GC4323@localhost.localdomain>
References: <20180810162658.6562-1-kwolf@redhat.com>
	<20180810162658.6562-2-kwolf@redhat.com>
	<c134bab4-43ab-91c3-c7d9-cc8306fb4e3c@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c134bab4-43ab-91c3-c7d9-cc8306fb4e3c@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 1/2] commit: Add top-node/base-node options
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

Am 10.08.2018 um 19:33 hat Eric Blake geschrieben:
> On 08/10/2018 11:26 AM, Kevin Wolf wrote:
> > The block-commit QMP command required specifying the top and base nodes
> > of the commit jobs using the file name of that node. While this works
> > in simple cases (local files with absolute paths), the file names
> > generated for more complicated setups can be hard to predict.
> > 
> > This adds two new options top-node and base-node to the command, which
> > allow specifying node names instead. They are mutually exclusive with
> > the old options.
> > 
> > Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> > ---
> >   qapi/block-core.json | 24 ++++++++++++++++++------
> >   blockdev.c           | 32 ++++++++++++++++++++++++++++++--
> >   2 files changed, 48 insertions(+), 8 deletions(-)
> > 
> > diff --git a/qapi/block-core.json b/qapi/block-core.json
> > index 5b9084a394..91dd075c84 100644
> > --- a/qapi/block-core.json
> > +++ b/qapi/block-core.json
> > @@ -1455,12 +1455,23 @@
> >   #
> >   # @device:  the device name or node-name of a root node
> >   #
> > -# @base:   The file name of the backing image to write data into.
> > -#                    If not specified, this is the deepest backing image.
> > +# @base-node: The node name of the backing image to write data into.
> > +#             If not specified, this is the deepest backing image.
> > +#             (since: 2.10)
> 
> I'd word this as (since 3.1)...

Whoops. Apparently I didn't read the documentation change carefully
enough when resurrecting this patch from an old branch.

> >  #
> > -# @top:    The file name of the backing image within the image chain,
> > -#                    which contains the topmost data to be committed down. If
> > -#                    not specified, this is the active layer.
> > +# @base: Same as @base-node, except that it is a file name rather than a node
> > +#        name. This must be the exact filename string that was used to open the
> > +#        node; other strings, even if addressing the same file, are not
> > +#        accepted (deprecated, use @base-node instead)
> 
> ...and this as (since 2.10).

No, 2.10 is just completely wrong. @base exists since the command was
introduced, which is commit ed61fc10e8c or QEMU 1.3.

> When we finish the deprecation and remove @base, then we might
> consolidate the 'since' documentation at that time, but until then, I
> think listing the two separate releases gives users an idea of how far
> back they might have been using the deprecated code, and when the
> preferred form was introduced.

Yes, obviously.

> > +#
> > +# @top-node: The node name of the backing image within the image chain
> > +#            which contains the topmost data to be committed down. If
> > +#            not specified, this is the active layer. (since: 2.10)
> > +#
> > +# @top: Same as @top-node, except that it is a file name rather than a node
> > +#       name. This must be the exact filename string that was used to open the
> > +#       node; other strings, even if addressing the same file, are not
> > +#       accepted (deprecated, use @base-node instead)
> 
> Likewise.
> 
> Actually, do we NEED new arguments? Can we just make @base and @top accept
> either an exact file name OR a node name?

No, no, no, no, no!

You can't tell whether "foo" is a file name or a node name, and they
could both exist at the same time, so it would be ambiguous. We should
avoid mixing semantically different things in a single field whenever
it's possible.

The reason why node name and BlockBackend name can be used in the same
option is that they share a name space, i.e. if there is already a node
name "foo", trying to create a BlockBackend "foo" will fail, and vice
versa.

> On the other hand, new arguments are introspectible, overloading the
> old argument to take two forms is not.
> So that doesn't help :(

That, too, yes.

> Or, here's an idea:
> 
> Keep the name @base and @top, but add a new '*by-node':'bool' parameter,
> defaulting to false for now, but perhaps with a deprecation warning that
> we'll switch the default to true in one release and delete the parameter
> altogether in an even later release. When false, @base and @top are
> filenames, as before; when true, @base and @top are node names instead.
> Introspectible, nicer names in the long run, and avoids having to detect a
> user providing two mutually-exclusive options at once.

I don't like options that completely change the semantics of other
options, but maybe that's just personal preference.

Anyway, thinking about the long term for block-commit is useless, the
command is just broken (for example, the @device option doesn't make any
sense) and will have to be replaced. But libvirt needs something _now_
for the -blockdev support, so I decided to add this as a quick hack
before we get the proper replacement.

I think it makes more sense to create a new blockdev-commit (which
would be a name more in line with the other block job commands) and
deprecate the old block-commit command as a whole.

> > +++ b/blockdev.c
> > @@ -3308,7 +3308,9 @@ out:
> >   }
> >   void qmp_block_commit(bool has_job_id, const char *job_id, const char *device,
> > +                      bool has_base_node, const char *base_node,
> >                         bool has_base, const char *base,
> > +                      bool has_top_node, const char *top_node,
> >                         bool has_top, const char *top,
> >                         bool has_backing_file, const char *backing_file,
> >                         bool has_speed, int64_t speed,
> 
> Getting to be a long signature. Should we use 'boxed':true in the QAPI file
> to make this easier to write?  (Separate commit)

It's an option.

Has any progress been made on the plan to support defaults in QAPI, so
that we could get rid of the has_* parameters?

Kevin
