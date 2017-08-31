Received: from eggs.gnu.org ([2001:4830:134:3::10]:35677)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rjones@redhat.com>) id 1dnKBJ-0000Gr-Fg
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 03:46:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rjones@redhat.com>) id 1dnKBI-0006oN-GV
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 03:46:29 -0400
Date: Thu, 31 Aug 2017 08:46:20 +0100
From: "Richard W.M. Jones" <rjones@redhat.com>
Message-ID: <20170831074620.GR20914@redhat.com>
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
Cc: Jeff Cody <jcody@redhat.com>, qemu-devel@nongnu.org, mitake.hitoshi@lab.ntt.co.jp, namei.unix@gmail.com, kwolf@redhat.com, qemu-block@nongnu.org, ptoscano@redhat.com


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

FWIW documentation says:

  "Returns 0 if succeeded, or a negative value for error."

I was holding off on reviewing this patch in general since there's a
libssh-based alternative driver under development, which should be
better.

Rich.

-- 
Richard Jones, Virtualization Group, Red Hat http://people.redhat.com/~rjones
Read my programming and virtualization blog: http://rwmj.wordpress.com
virt-p2v converts physical machines to virtual machines.  Boot with a
live CD or over the network (PXE) and turn machines into KVM guests.
http://libguestfs.org/virt-v2v
