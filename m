Received: from eggs.gnu.org ([209.51.188.92]:56420)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gmgeu-0000GN-Fs
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 10:11:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gmget-0007hS-NR
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 10:11:12 -0500
Date: Thu, 24 Jan 2019 16:11:05 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20190124151105.GH4601@localhost.localdomain>
References: <20190124141731.21509-1-kwolf@redhat.com>
	<f3b34487-5c86-287e-00b5-331adf9ac931@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f3b34487-5c86-287e-00b5-331adf9ac931@virtuozzo.com>
Subject: Re: [Qemu-devel] [PATCH] file-posix: Cache lseek result for data
 regions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Cc: "qemu-block@nongnu.org" <qemu-block@nongnu.org>, "mreitz@redhat.com" <mreitz@redhat.com>, "eblake@redhat.com" <eblake@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

Am 24.01.2019 um 15:40 hat Vladimir Sementsov-Ogievskiy geschrieben:
> 24.01.2019 17:17, Kevin Wolf wrote:
> > Depending on the exact image layout and the storage backend (tmpfs is
> > konwn to have very slow SEEK_HOLE/SEEK_DATA), caching lseek results can
> > save us a lot of time e.g. during a mirror block job or qemu-img convert
> > with a fragmented source image (.bdrv_co_block_status on the protocol
> > layer can be called for every single cluster in the extreme case).
> > 
> > We may only cache data regions because of possible concurrent writers.
> > This means that we can later treat a recently punched hole as data, but
> > this is safe. We can't cache holes because then we might treat recently
> > written data as holes, which can cause corruption.
> > 
> > Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> > ---
> >   block/file-posix.c | 51 ++++++++++++++++++++++++++++++++++++++++++++--
> >   1 file changed, 49 insertions(+), 2 deletions(-)
> > 
> > diff --git a/block/file-posix.c b/block/file-posix.c
> > index 8aee7a3fb8..7272c7c99d 100644
> > --- a/block/file-posix.c
> > +++ b/block/file-posix.c
> > @@ -168,6 +168,12 @@ typedef struct BDRVRawState {
> >       bool needs_alignment;
> >       bool check_cache_dropped;
> >   
> > +    struct seek_data_cache {
> > +        bool        valid;
> > +        uint64_t    start;
> > +        uint64_t    end;
> > +    } seek_data_cache;
> 
> Should we have some mutex-locking to protect it?

It is protected by the AioContext lock, like everything else in
BDRVRawState.

Kevin
