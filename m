Received: from eggs.gnu.org ([2001:4830:134:3::10]:35833)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dPqpm-0007jv-TQ
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 09:47:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dPqpj-0001AQ-9K
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 09:47:14 -0400
Date: Tue, 27 Jun 2017 14:46:52 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170627134652.GI13634@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <1498566850-7934-1-git-send-email-pl@kamp.de>
	<1498566850-7934-5-git-send-email-pl@kamp.de>
	<20170627131605.GG13634@redhat.com>
	<ede8e3d7-7980-e065-e329-e35c988faaf0@kamp.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ede8e3d7-7980-e065-e329-e35c988faaf0@kamp.de>
Subject: Re: [Qemu-devel] [PATCH 4/4] block/qcow2: add zlib-fast compression
 algorithm
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Lieven <pl@kamp.de>
Cc: qemu-block@nongnu.org, kwolf@redhat.com, qemu-devel@nongnu.org, mreitz@redhat.com, den@openvz.org, lersek@redhat.com

On Tue, Jun 27, 2017 at 03:23:19PM +0200, Peter Lieven wrote:
> Am 27.06.2017 um 15:16 schrieb Daniel P. Berrange:
> > On Tue, Jun 27, 2017 at 02:34:10PM +0200, Peter Lieven wrote:
> > > this adds support for optimized zlib settings which almost
> > > tripples the compression speed while maintaining about
> > > the same compressed size.
> > > 
> > > Signed-off-by: Peter Lieven <pl@kamp.de>
> > > ---
> > >   block/qcow2-cluster.c |  3 ++-
> > >   block/qcow2.c         | 11 +++++++++--
> > >   block/qcow2.h         |  1 +
> > >   qemu-img.texi         |  1 +
> > >   4 files changed, 13 insertions(+), 3 deletions(-)
> > > diff --git a/qemu-img.texi b/qemu-img.texi
> > > index 043c1ba..83a5db2 100644
> > > --- a/qemu-img.texi
> > > +++ b/qemu-img.texi
> > > @@ -627,6 +627,7 @@ The following options are available if support for the respective libraries
> > >   has been enabled at compile time:
> > >      zlib            Uses standard zlib compression (default)
> > > +   zlib-fast       Uses zlib compression with optimized compression parameters
> > This looks like a poor design from a future proofing POV. I would much
> > rather see us introduce a more flexible modelling of compression at the
> > QAPI layer which lets us have tunables for each algorith, in the same
> > way that the qcow2 built-in encryption now has ability to set tunables
> > for each algorithm.
> > 
> > eg your "zlib-fast" impl which just uses zlib with a window size of -15
> > could be expressed as
> > 
> >     qemu-img create -o compress.format=zlib,compress.window=-15
> 
> It would also need a compress.level, but okay. This will make things
> more complicated as one might not know what good values for
> the algoritm are.
> 
> Wouldn't it be better to have sth like compress.level=1..9 and let
> the implementation decide which parameters it choose for the algorithm?

Yep, there's definitely a choice of approaches - exposing low level
details of each library as parameters, vs trying to come up with a
more abstracted, simplified notation and having the driver pick some
of the low level details implicitly from that. Both are valid, and I
don't have a particular opinion either way.

> Do you have a pointer where I can find out how to imlement that
> in QAPI? Maybe the patches that introduces the encryption settings?

It is a little messy since we don't fully use QAPI in the block create
code path. If you want to look at what I did for encryption though, see
the block/qcow2.c file. In the qcow2_create() method I grab the
encrypt.format option. Later in the qcow2_set_up_encryption() method
I then extract & parse the format specific options from the QemuOpts
array. My code is in Max's block branch, or on block-luks-qcow2-10 branch
at https://github.com/berrange/qemu

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
