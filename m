Received: from eggs.gnu.org ([2001:4830:134:3::10]:34718)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fp9GT-000663-2O
	for qemu-devel@nongnu.org; Mon, 13 Aug 2018 05:35:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fp9GS-0002Mj-4x
	for qemu-devel@nongnu.org; Mon, 13 Aug 2018 05:35:53 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20180810162658.6562-1-kwolf@redhat.com>
	<20180810162658.6562-2-kwolf@redhat.com>
	<c134bab4-43ab-91c3-c7d9-cc8306fb4e3c@redhat.com>
	<20180813090819.GC4323@localhost.localdomain>
Date: Mon, 13 Aug 2018 11:35:44 +0200
In-Reply-To: <20180813090819.GC4323@localhost.localdomain> (Kevin Wolf's
	message of "Mon, 13 Aug 2018 11:08:19 +0200")
Message-ID: <877eku8v7z.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 1/2] commit: Add top-node/base-node options
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: Eric Blake <eblake@redhat.com>, pkrempa@redhat.com, qemu-devel@nongnu.org, qemu-block@nongnu.org, mreitz@redhat.com

Kevin Wolf <kwolf@redhat.com> writes:

> Am 10.08.2018 um 19:33 hat Eric Blake geschrieben:
>> On 08/10/2018 11:26 AM, Kevin Wolf wrote:
>> > The block-commit QMP command required specifying the top and base nodes
>> > of the commit jobs using the file name of that node. While this works
>> > in simple cases (local files with absolute paths), the file names
>> > generated for more complicated setups can be hard to predict.
>> > 
>> > This adds two new options top-node and base-node to the command, which
>> > allow specifying node names instead. They are mutually exclusive with
>> > the old options.
>> > 
>> > Signed-off-by: Kevin Wolf <kwolf@redhat.com>
>> > ---
>> >   qapi/block-core.json | 24 ++++++++++++++++++------
>> >   blockdev.c           | 32 ++++++++++++++++++++++++++++++--
>> >   2 files changed, 48 insertions(+), 8 deletions(-)
>> > 
>> > diff --git a/qapi/block-core.json b/qapi/block-core.json
>> > index 5b9084a394..91dd075c84 100644
>> > --- a/qapi/block-core.json
>> > +++ b/qapi/block-core.json
[...]
>> Or, here's an idea:
>> 
>> Keep the name @base and @top, but add a new '*by-node':'bool' parameter,
>> defaulting to false for now, but perhaps with a deprecation warning that
>> we'll switch the default to true in one release and delete the parameter
>> altogether in an even later release. When false, @base and @top are
>> filenames, as before; when true, @base and @top are node names instead.
>> Introspectible, nicer names in the long run, and avoids having to detect a
>> user providing two mutually-exclusive options at once.
>
> I don't like options that completely change the semantics of other
> options, but maybe that's just personal preference.

I happen to share it.

> Anyway, thinking about the long term for block-commit is useless, the
> command is just broken (for example, the @device option doesn't make any
> sense) and will have to be replaced. But libvirt needs something _now_
> for the -blockdev support, so I decided to add this as a quick hack
> before we get the proper replacement.
>
> I think it makes more sense to create a new blockdev-commit (which
> would be a name more in line with the other block job commands) and
> deprecate the old block-commit command as a whole.
>
>> > +++ b/blockdev.c
>> > @@ -3308,7 +3308,9 @@ out:
>> >   }
>> >   void qmp_block_commit(bool has_job_id, const char *job_id, const char *device,
>> > +                      bool has_base_node, const char *base_node,
>> >                         bool has_base, const char *base,
>> > +                      bool has_top_node, const char *top_node,
>> >                         bool has_top, const char *top,
>> >                         bool has_backing_file, const char *backing_file,
>> >                         bool has_speed, int64_t speed,
>> 
>> Getting to be a long signature. Should we use 'boxed':true in the QAPI file
>> to make this easier to write?  (Separate commit)
>
> It's an option.
>
> Has any progress been made on the plan to support defaults in QAPI, so
> that we could get rid of the has_* parameters?

No.  It's one of those things that keep getting pushed out by more
important or urgent stuff.

I expect it to be straightforward, if tedious.
