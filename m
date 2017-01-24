Received: from eggs.gnu.org ([2001:4830:134:3::10]:49701)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cW005-0001Sx-Gu
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 07:15:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cW004-00045q-8Q
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 07:15:01 -0500
Date: Tue, 24 Jan 2017 12:14:49 +0000
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170124121449.GI14563@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20170103182801.9638-1-berrange@redhat.com>
	<20170103182801.9638-5-berrange@redhat.com>
	<3a4e16b4-b0a2-b732-cc6d-c61f0842c188@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3a4e16b4-b0a2-b732-cc6d-c61f0842c188@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v1 04/15] qcow: require image size to be >
 1 for new images
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org

On Mon, Jan 16, 2017 at 08:41:15PM +0100, Max Reitz wrote:
> On 03.01.2017 19:27, Daniel P. Berrange wrote:
> > The qcow driver refuses to open images which are less than
> > 2 bytes in size, but will happily create such images. Add
> > a check in the create path to avoid this discrepancy.
> > 
> > Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> > ---
> >  block/qcow.c | 6 ++++++
> >  1 file changed, 6 insertions(+)
> > 
> > diff --git a/block/qcow.c b/block/qcow.c
> > index 7540f43..8133fda 100644
> > --- a/block/qcow.c
> > +++ b/block/qcow.c
> > @@ -799,6 +799,12 @@ static int qcow_create(const char *filename, QemuOpts *opts, Error **errp)
> >      /* Read out options */
> >      total_size = ROUND_UP(qemu_opt_get_size_del(opts, BLOCK_OPT_SIZE, 0),
> >                            BDRV_SECTOR_SIZE);
> > +    if (total_size <= 1) {
> > +        error_setg(errp, "Image size is too small (must be at least 2 bytes)");
> > +        ret = -EINVAL;
> > +        goto cleanup;
> > +    }
> > +
> 
> Given the ROUND_UP() before, I can't see how total_size can be 1, but I
> can see how it can be 0. Since that is covered by this condition:
> 
> Reviewed-by: Max Reitz <mreitz@redhat.com>

I'll switch to == 0 none the less


Regards,
Daniel
-- 
|: http://berrange.com      -o-    http://www.flickr.com/photos/dberrange/ :|
|: http://libvirt.org              -o-             http://virt-manager.org :|
|: http://entangle-photo.org       -o-    http://search.cpan.org/~danberr/ :|
