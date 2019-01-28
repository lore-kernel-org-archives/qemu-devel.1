Received: from eggs.gnu.org ([209.51.188.92]:40386)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1go9cr-0003YW-Mh
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 11:19:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1go9cp-0002Ex-OF
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 11:19:09 -0500
Date: Mon, 28 Jan 2019 16:18:55 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20190128161855.GD3437@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20190128151521.13875-1-antonkuchin@yandex-team.ru>
	<9c6b6121-a071-58a3-942a-2f3909549782@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <9c6b6121-a071-58a3-942a-2f3909549782@redhat.com>
Subject: Re: [Qemu-devel] [libvirt] [PATCH] qmp: Deprecate query-nodes
 option of query-blockstats
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: Anton Kuchin <antonkuchin@yandex-team.ru>, qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, libvir-list@redhat.com, Max Reitz <mreitz@redhat.com>, Evgeny Yakovlev <wrfsh@yandex-team.ru>

On Mon, Jan 28, 2019 at 05:04:18PM +0100, Thomas Huth wrote:
> On 2019-01-28 16:15, Anton Kuchin wrote:
> > This option is broken since a6baa60807 in v2.9 and returns mostly
> > zeroes instead of real stats because actual querring of BlockStats
> 
> s/querring/querying/
> 
> > that resides in blk is missing.
> > 
> > And it makes no sense because with this option BlockDriverState-s
> > are iterated but BlockAcctStats belong to BlockBackend and not BDS
> > since 7f0e9da6f13 in v2.5
> > 
> > Signed-off-by: Anton Kuchin <antonkuchin@yandex-team.ru>
> > ---
> [...]
> > @@ -577,21 +576,10 @@ BlockStatsList *qmp_query_blockstats(bool has_query_nodes,
> >  {
> >      BlockStatsList *head = NULL, **p_next = &head;
> >      BlockBackend *blk;
> > -    BlockDriverState *bs;
> >  
> >      /* Just to be safe if query_nodes is not always initialized */
> >      if (has_query_nodes && query_nodes) {
> > -        for (bs = bdrv_next_node(NULL); bs; bs = bdrv_next_node(bs)) {
> > -            BlockStatsList *info = g_malloc0(sizeof(*info));
> > -            AioContext *ctx = bdrv_get_aio_context(bs);
> > -
> > -            aio_context_acquire(ctx);
> > -            info->value = bdrv_query_bds_stats(bs, false);
> > -            aio_context_release(ctx);
> > -
> > -            *p_next = info;
> > -            p_next = &info->next;
> > -        }
> > +        error_setg(errp, "Option query_nodes is deprecated");
> 
> You don't only deprecate the option here, you completely disable it ...
> that does not make too much sense IMHO. If it is really broken since
> multiple releases already and nobody complained or tried to fix it so
> far, I think it could be simply removed immediately. Otherwise, if it is
> only partly broken, please leave it in the current state (if it is not
> fixable), and only mark it as deprecated in the qemu-deprecated.texi and
> block-core.json documentation.

IIUC fro the commit message it is broken in the sense that it returns
all zeros, instead of real values. If some app is using it then they
have probably just been running with those all-zero values.

This change turns it into a fatal error in QMP, which is in turn going
to propagate back to apps which could turn the silent usage of bad data
into a hard error.

I'm torn about whether this must go through deprecation or not. Technically
this should go through the deprecation process, but I don't much like the
idea of continuing to feed back garbage to apps for another few releases.
Apps are effectively broken already even if they don't realize it. Reporting
a clear error will at least highlight this pre-existing brokeness in such
apps.

If we are going to raise an error though, IMHO this is not the right way to
go about it.  We should delete 'query-nodes' from the schema entirely, at
which point the QMP parser will raise an error automatically upfront. This
also allows apps to introspect to see if the parameter exists or not.


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
