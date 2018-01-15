Received: from eggs.gnu.org ([2001:4830:134:3::10]:45843)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eb4jS-00067z-5G
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 08:23:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eb4jR-0007Ob-3t
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 08:23:22 -0500
Date: Mon, 15 Jan 2018 14:23:07 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180115132307.GC32271@localhost.localdomain>
References: <20171221224411.8901-1-jsnow@redhat.com>
	<20171222130018.GE3763@localhost.localdomain>
	<00bb48ca-52e9-e6d1-9a84-d78144464ab3@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00bb48ca-52e9-e6d1-9a84-d78144464ab3@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] file-posix: refuse to open directories
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>
Cc: mreitz@redhat.com, qemu-devel@nongnu.org, qemu-block@nongnu.org, dgilbert@redhat.com

Am 13.01.2018 um 00:30 hat John Snow geschrieben:
> On 12/22/2017 08:00 AM, Kevin Wolf wrote:
> > Am 21.12.2017 um 23:44 hat John Snow geschrieben:
> >> I don't think there's a legitimate reason to open directories as if
> >> they were files. This prevents QEMU from opening and attempting to probe
> >> a directory inode, which can break in exciting ways. One of those ways
> >> is lseek on ext4/xfs, which will return 0x7fffffffffffffff as the file
> >> size instead of EISDIR. This can coax QEMU into responding with a
> >> confusing "file too big" instead of "Hey, that's not a file".
> >>
> >> See: https://bugs.launchpad.net/qemu/+bug/1739304/
> >> Signed-off-by: John Snow <jsnow@redhat.com>
> >> ---
> >>  block/file-posix.c | 5 +++++
> >>  1 file changed, 5 insertions(+)
> >>
> >> diff --git a/block/file-posix.c b/block/file-posix.c
> >> index 36ee89e940..bd29bdada6 100644
> >> --- a/block/file-posix.c
> >> +++ b/block/file-posix.c
> >> @@ -589,6 +589,11 @@ static int raw_open_common(BlockDriverState *bs, QDict *options,
> >>          s->needs_alignment = true;
> >>      }
> >>  #endif
> >> +    if (S_ISDIR(st.st_mode)) {
> >> +        ret = -EISDIR;
> >> +        error_setg_errno(errp, errno, "Cannot open directory as file");
> >> +        goto fail;
> >> +    }
> > 
> > I think instead of blacklisting directories, the callers should somehow
> > pass the file types they expect. Which would probably initially be
> > something like:
> > 
> > file:
> >     S_IFREG: expected
> >     S_IFBLK or S_IFCHR: deprecation warning
> >     else: error
> > 
> > host_device / host_cdrom:
> >     S_IFBLK or S_IFCHR: expected (which one depends on the OS)
> >     else: error
> > 
> > Kevin
> > 
> 
> "Hey, I'll just mask S_IFBLK and S_IFCHR into a field, and..."
> 
> Oh, they're not mutually-bit-exclusive constants. That's... annoying.

The same thought process led to the "somehow" in my mail...

> Is there some un-annoying way to do this? I could create a new mask, and
> a new function to pick bits off the bitmask and check, and ...
> 
> (it feels like a lot of spinning to accomplish not much.)

We have only two cases, so maybe just pass a bool device_node or
something? Or maybe we could check in the callers of raw_open_common()
afterwards instead of passing the information. But I think I like the
bool parameter better.

Kevin
