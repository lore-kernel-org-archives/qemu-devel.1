Received: from eggs.gnu.org ([2001:4830:134:3::10]:52737)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1dn9KX-0002U1-IZ
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 16:11:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1dn9KW-0002ab-9G
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 16:11:17 -0400
Date: Wed, 30 Aug 2017 16:11:07 -0400
From: Jeff Cody <jcody@redhat.com>
Message-ID: <20170830201107.GL4770@localhost.localdomain>
References: <cover.1504112061.git.jcody@redhat.com>
	<af4268153bce149a9599e4079a0f8908e32fdef8.1504112061.git.jcody@redhat.com>
	<94eb9a23-1cb7-a139-039e-4d0f138a6244@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <94eb9a23-1cb7-a139-039e-4d0f138a6244@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 1/7] block/ssh: don't call
 libssh2_init() in block_init()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, mitake.hitoshi@lab.ntt.co.jp, namei.unix@gmail.com, kwolf@redhat.com, rjones@redhat.com, qemu-block@nongnu.org

On Wed, Aug 30, 2017 at 02:40:16PM -0500, Eric Blake wrote:
> On 08/30/2017 11:56 AM, Jeff Cody wrote:
> > We don't need libssh2 failure to be fatal (we could just opt to not
> > register the driver on failure). But, it is probably a good idea to
> > avoid external library calls during the block_init(), and call the
> > libssh2 global init function on the first usage, returning any errors.
> > 
> > Signed-off-by: Jeff Cody <jcody@redhat.com>
> > ---
> >  block/ssh.c | 40 +++++++++++++++++++++++++++++-----------
> >  1 file changed, 29 insertions(+), 11 deletions(-)
> > 
> 
> > +static int ssh_state_init(BDRVSSHState *s, Error **errp)
> >  {
> > +    int ret;
> > +
> > +    if (!ssh_libinit_called) {
> > +        ret = libssh2_init(0);
> > +        if (ret) {
> > +            error_setg(errp, "libssh2 initialization failed with %d", ret);
> > +            return ret;
> 
> Do we know if this number is always positive or negative?
> 

>From the documentation [1], it returns 0 on success, or a negative value
for error.  (I guess presumably that means a positive value is by definition
an error, as well).

[1] https://www.libssh2.org/libssh2_init.html

> > @@ -772,8 +788,13 @@ static int ssh_file_open(BlockDriverState *bs, QDict *options, int bdrv_flags,
> >      BDRVSSHState *s = bs->opaque;
> >      int ret;
> >      int ssh_flags;
> > +    Error *local_err = NULL;
> >  
> > -    ssh_state_init(s);
> > +    ret = ssh_state_init(s, &local_err);
> > +    if (local_err) {
> > +        error_propagate(errp, local_err);
> > +        return ret;
> 
> Is returning 'ret' from libssh2_init() wise?
> 
> If 'ret' is not important, you could simplify this:
> 
> if (ssh_state_init(s, errp)) {
>     return -1;
> }

Good point, not sure if a non-zero ret from libssh2_init() provides meaning
beyond 'error' for us.  Maybe return -EIO instead of -1, though?
