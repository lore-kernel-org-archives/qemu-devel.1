Received: from eggs.gnu.org ([2001:4830:134:3::10]:54447)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dUZCZ-0005B7-RR
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 09:58:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dUZCY-0000IJ-IF
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 09:58:15 -0400
Date: Mon, 10 Jul 2017 14:58:03 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170710135803.GE6770@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <1498733831-15254-1-git-send-email-pl@kamp.de>
	<1498733831-15254-6-git-send-email-pl@kamp.de>
	<20170710132546.GG5772@noname.redhat.com>
	<cbc8ec09-9de2-afe6-1cf0-e414482bc6a4@kamp.de>
	<20170710133459.GI5772@noname.redhat.com>
	<20170710134436.GB6770@redhat.com>
	<b1f2b8aa-219e-27f5-7e97-3b6ea6b7b2d0@kamp.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b1f2b8aa-219e-27f5-7e97-3b6ea6b7b2d0@kamp.de>
Subject: Re: [Qemu-devel] [PATCH V2 5/8] block/qcow2: read and write the
 compress format extension
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Lieven <pl@kamp.de>
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org, lersek@redhat.com, den@openvz.org, mreitz@redhat.com, eblake@redhat.com

On Mon, Jul 10, 2017 at 03:46:21PM +0200, Peter Lieven wrote:
> Am 10.07.2017 um 15:44 schrieb Daniel P. Berrange:
> > On Mon, Jul 10, 2017 at 03:34:59PM +0200, Kevin Wolf wrote:
> > > Am 10.07.2017 um 15:29 hat Peter Lieven geschrieben:
> > > > Am 10.07.2017 um 15:25 schrieb Kevin Wolf:
> > > > > Am 29.06.2017 um 12:57 hat Peter Lieven geschrieben:
> > > > > > we now read the extension on open and write it on update, but
> > > > > > do not yet use it.
> > > > > > 
> > > > > > Signed-off-by: Peter Lieven <pl@kamp.de>
> > > > > > ---
> > > > > >   block/qcow2.c | 100 ++++++++++++++++++++++++++++++++++++++++++++++++++--------
> > > > > >   block/qcow2.h |  23 +++++++++++---
> > > > > >   2 files changed, 104 insertions(+), 19 deletions(-)
> > > > > > 
> > > > > > diff --git a/block/qcow2.c b/block/qcow2.c
> > > > > > index 308121a..39a8afc 100644
> > > > > > --- a/block/qcow2.c
> > > > > > +++ b/block/qcow2.c
> > > > > > @@ -63,6 +63,7 @@ typedef struct {
> > > > > >   #define  QCOW2_EXT_MAGIC_END 0
> > > > > >   #define  QCOW2_EXT_MAGIC_BACKING_FORMAT 0xE2792ACA
> > > > > >   #define  QCOW2_EXT_MAGIC_FEATURE_TABLE 0x6803f857
> > > > > > +#define  QCOW2_EXT_MAGIC_COMPRESS_FORMAT 0xC03183A3
> > > > > >   static int qcow2_probe(const uint8_t *buf, int buf_size, const char *filename)
> > > > > >   {
> > > > > > @@ -76,6 +77,26 @@ static int qcow2_probe(const uint8_t *buf, int buf_size, const char *filename)
> > > > > >           return 0;
> > > > > >   }
> > > > > > +static int qcow2_compress_format_from_name(char *fmt)
> > > > > > +{
> > > > > > +    if (!fmt || !fmt[0]) {
> > > > > > +        return QCOW2_COMPRESS_ZLIB_COMPAT;
> > > > > > +    } else if (g_str_equal(fmt, "zlib")) {
> > > > > > +        return QCOW2_COMPRESS_ZLIB;
> > > > > > +    } else {
> > > > > > +        return -EINVAL;
> > > > > > +    }
> > > > > > +}
> > > > > It might make sense to allow specifying the old compression format in
> > > > > the compression header. But I'm not so sure about using the empty string
> > > > > rather than a proper name for it, and even less about not documenting
> > > > > it.
> > > > The old format is used if and only if the compression header is absent.
> > > > It makes no sense to write a header and use the old format. The old
> > > > settings are suboptimal and old versions can't open a qcow2 with a
> > > > compression header anyway.
> > > Your code allows an empty string in the header extension. If you don't
> > > want it there, you need to reject it.
> > This is a good reason to use the QAPI schema to parse the create options
> > instead of doing it using qemu_opts - the QAPI schema will generate correct
> > code to parse & validate enum values
> 
> Can you then please advise where to add the schematas and which functions
> to use for parsing it? You wrote that it is a bit hackish at the moment as not
> everything is available in qcow2_create path.

I just sent an (untested) example for patch 3 that should help. If you still
have problems let me know.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
