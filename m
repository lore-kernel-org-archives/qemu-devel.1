Received: from eggs.gnu.org ([2001:4830:134:3::10]:58096)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1clUu8-0005Gn-3N
	for qemu-devel@nongnu.org; Wed, 08 Mar 2017 01:16:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1clUu7-0006lM-AN
	for qemu-devel@nongnu.org; Wed, 08 Mar 2017 01:16:56 -0500
Date: Wed, 8 Mar 2017 14:16:47 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170308061647.GD7835@lemon.lan>
References: <20170307021748.7743-1-famz@redhat.com>
	<453cf467-9b0c-efa8-a523-a3f35072e70d@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <453cf467-9b0c-efa8-a523-a3f35072e70d@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] file-posix: Incoporate max_segments in
 block limit
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org, eblake@redhat.com

On Tue, 03/07 11:58, Paolo Bonzini wrote:
> 
> 
> On 07/03/2017 03:17, Fam Zheng wrote:
> > Linux exposes a separate limit, /sys/block/.../queue/max_segments, which
> > in the worst case can be more restrictive than BLKSECTGET (as they are
> > two different things). Similar to the BLKSECTGET story, guests don't see
> > this limit and send big requests will get -EINVAL error on SG_IO.
> > 
> > Lean on the safer side to clamp max_transfer according to max_segments
> > and page size, because in the end what host HBA gets is the mapped host
> > pages rather than a guest buffer.
> > 
> > Signed-off-by: Fam Zheng <famz@redhat.com>
> > ---
> >  block/file-posix.c | 58 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 58 insertions(+)
> > 
> > diff --git a/block/file-posix.c b/block/file-posix.c
> > index 4de1abd..b615262 100644
> > --- a/block/file-posix.c
> > +++ b/block/file-posix.c
> > @@ -668,6 +668,59 @@ static int hdev_get_max_transfer_length(BlockDriverState *bs, int fd)
> >  #endif
> >  }
> >  
> > +static int hdev_get_max_segments(BlockDriverState *bs)
> > +{
> > +#ifdef CONFIG_LINUX
> > +    char buf[32];
> > +    const char *end;
> > +    char *sysfspath, *fullpath;
> > +    int ret;
> > +    int fd = -1;
> > +    long max_segments;
> > +
> > +    fullpath = realpath(bs->exact_filename, NULL);
> > +    if (!fullpath) {
> > +        return -errno;
> > +    }
> > +    if (strncmp(fullpath, "/dev/", 5) || !fullpath[5]) {
> > +        ret = -ENOTSUP;
> > +        goto out;
> > +    }
> > +    sysfspath = g_strdup_printf("/sys/block/%s/queue/max_segments",
> > +                                &fullpath[5]);
> 
> I think you cannot rely on the /dev/... path.  Luckily, there is an
> alternative path to "queue" via /sys/dev/block/MAJOR:MINOR/queue, where
> MAJOR:MINOR can be retrieved via fstat.  This also avoids any possible
> TOC-TOU races.

Sounds good, I'll send another version.

Fam
