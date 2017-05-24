Received: from eggs.gnu.org ([2001:4830:134:3::10]:46372)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ndevos@redhat.com>) id 1dDSBM-0004bE-QI
	for qemu-devel@nongnu.org; Wed, 24 May 2017 05:02:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ndevos@redhat.com>) id 1dDSBL-0001Jf-N7
	for qemu-devel@nongnu.org; Wed, 24 May 2017 05:02:16 -0400
Date: Wed, 24 May 2017 11:02:02 +0200
From: Niels de Vos <ndevos@redhat.com>
Message-ID: <20170524090202.GI6614@ndevos-x240.usersys.redhat.com>
References: <87c0140e9407c08f6e74b04131b610f2e27c014c.1495560397.git.jcody@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87c0140e9407c08f6e74b04131b610f2e27c014c.1495560397.git.jcody@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] block/gluster: glfs_lseek() workaround
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jeff Cody <jcody@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org

On Tue, May 23, 2017 at 01:27:50PM -0400, Jeff Cody wrote:
> On current released versions of glusterfs, glfs_lseek() will sometimes
> return invalid values for SEEK_DATA or SEEK_HOLE.  For SEEK_DATA and
> SEEK_HOLE, the returned value should be >= the passed offset, or < 0 in
> the case of error:
> 
> LSEEK(2):
> 
>     off_t lseek(int fd, off_t offset, int whence);
> 
>     [...]
> 
>     SEEK_HOLE
>               Adjust  the file offset to the next hole in the file greater
>               than or equal to offset.  If offset points into the middle of
>               a hole, then the file offset is set to offset.  If there is no
>               hole past offset, then the file offset is adjusted to the end
>               of the file (i.e., there is  an implicit hole at the end of
>               any file).
> 
>     [...]
> 
>     RETURN VALUE
>               Upon  successful  completion,  lseek()  returns  the resulting
>               offset location as measured in bytes from the beginning of the
>               file.  On error, the value (off_t) -1 is returned and errno is
>               set to indicate the error
> 
> However, occasionally glfs_lseek() for SEEK_HOLE/DATA will return a
> value less than the passed offset, yet greater than zero.
> 
> For instance, here are example values observed from this call:
> 
>     offs = glfs_lseek(s->fd, start, SEEK_HOLE);
>     if (offs < 0) {
>         return -errno;          /* D1 and (H3 or H4) */
>     }
> 
> start == 7608336384
> offs == 7607877632
> 
> This causes QEMU to abort on the assert test.  When this value is
> returned, errno is also 0.
> 
> This is a reported and known bug to glusterfs:
> https://bugzilla.redhat.com/show_bug.cgi?id=1425293
> 
> Although this is being fixed in gluster, we still should work around it
> in QEMU, given that multiple released versions of gluster behave this
> way.

Versions of GlusterFS 3.8.0 - 3.8.8 are affected, 3.8.9 has the fix
already and was released in February this year. We encourage users to
update to recent versions, and provide a stable (bugfix only) update
each month.

The Red Hat Gluster Storage product that is often used in combination
with QEMU (+oVirt) does unfortunately not have an update where this is
fixed.

Using an unfixed Gluster storage environment can cause QEMU to segfault.
Although fixes exist for Gluster, not all users will have them
installed. Preventing the segfault in QEMU due to a broken storage
environment makes sense to me.

> This patch treats the return case of (offs < start) the same as if an
> error value other than ENXIO is returned; we will assume we learned
> nothing, and there are no holes in the file.
> 
> Signed-off-by: Jeff Cody <jcody@redhat.com>
> ---
>  block/gluster.c | 18 ++++++++++++++++--
>  1 file changed, 16 insertions(+), 2 deletions(-)
> 
> diff --git a/block/gluster.c b/block/gluster.c
> index 7c76cd0..c147909e 100644
> --- a/block/gluster.c
> +++ b/block/gluster.c
> @@ -1275,7 +1275,14 @@ static int find_allocation(BlockDriverState *bs, off_t start,
>      if (offs < 0) {
>          return -errno;          /* D3 or D4 */
>      }
> -    assert(offs >= start);
> +
> +    if (offs < start) {
> +        /* This is not a valid return by lseek().  We are safe to just return
> +         * -EIO in this case, and we'll treat it like D4. Unfortunately some
> +         *  versions of libgfapi will return offs < start, so an assert here
> +         *  will unneccesarily abort QEMU. */

This is not really correct, the problem is not in libgfapi, but in the
protocol translator on the server-side. The version of libgfapi does not
matter here, it is the version on the server. But that might be too much
detail for the comment.

> +        return -EIO;
> +    }
>  
>      if (offs > start) {
>          /* D2: in hole, next data at offs */
> @@ -1307,7 +1314,14 @@ static int find_allocation(BlockDriverState *bs, off_t start,
>      if (offs < 0) {
>          return -errno;          /* D1 and (H3 or H4) */
>      }
> -    assert(offs >= start);
> +
> +    if (offs < start) {
> +        /* This is not a valid return by lseek().  We are safe to just return
> +         * -EIO in this case, and we'll treat it like H4. Unfortunately some
> +         *  versions of libgfapi will return offs < start, so an assert here
> +         *  will unneccesarily abort QEMU. */
> +        return -EIO;
> +    }
>  
>      if (offs > start) {
>          /*
> -- 
> 2.9.3
> 

You might want to explain the problem a little different in the commit
message. It is fine too if you think it would become too detailed, my
explanation is in the archives now in any case.

Reviewed-by: Niels de Vos <ndevos@redhat.com>
