Received: from eggs.gnu.org ([2001:4830:134:3::10]:49079)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ndevos@redhat.com>) id 1gBeBy-0006H2-Af
	for qemu-devel@nongnu.org; Sun, 14 Oct 2018 07:04:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ndevos@redhat.com>) id 1gBeBx-0004aF-GR
	for qemu-devel@nongnu.org; Sun, 14 Oct 2018 07:04:14 -0400
Date: Sun, 14 Oct 2018 13:04:03 +0200
From: Niels de Vos <ndevos@redhat.com>
Message-ID: <20181014110403.GD22957@ndevos-x270>
References: <20181012115532.12645-1-kwolf@redhat.com>
	<20181012115532.12645-8-kwolf@redhat.com>
	<0b377575-4838-c436-3867-a875bc8bab76@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0b377575-4838-c436-3867-a875bc8bab76@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v2 7/8] gluster: Support
 auto-read-only option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org, mreitz@redhat.com

On Fri, Oct 12, 2018 at 12:31:21PM -0500, Eric Blake wrote:
> On 10/12/18 6:55 AM, Kevin Wolf wrote:
> > If read-only=off, but auto-read-only=on is given, open the file
> > read-write if we have the permissions, but instead of erroring out for
> > read-only files, just degrade to read-only.
> > 
> > Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> > ---
> >   block/gluster.c | 9 +++++++++
> >   1 file changed, 9 insertions(+)
> > 
> > diff --git a/block/gluster.c b/block/gluster.c
> > index 4fd55a9cc5..68d20c8830 100644
> > --- a/block/gluster.c
> > +++ b/block/gluster.c
> > @@ -849,6 +849,15 @@ static int qemu_gluster_open(BlockDriverState *bs,  QDict *options,
> >       qemu_gluster_parse_flags(bdrv_flags, &open_flags);
> >       s->fd = glfs_open(s->glfs, gconf->path, open_flags);
> > +    if (!s->fd && errno == EACCES) {
> 
> EROFS is not possible as it was for posix file?

EROFS can happen, depending on the configuration of the Gluster volume.
In that case, opening read-only should work fine.

Niels
