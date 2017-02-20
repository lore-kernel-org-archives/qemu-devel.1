Received: from eggs.gnu.org ([2001:4830:134:3::10]:33234)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cfpef-0002gc-Qd
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 10:13:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cfpee-00066K-9L
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 10:13:33 -0500
Date: Mon, 20 Feb 2017 15:13:20 +0000
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170220151320.GU15874@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20170203120254.15062-1-berrange@redhat.com>
	<20170203120254.15062-7-berrange@redhat.com>
	<2a209a6e-338c-f352-6634-555b36daafb9@redhat.com>
	<20170220124652.GO15874@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170220124652.GO15874@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 6/6] qemu-img: copy *key-secret opts
 when opening newly created files
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org

On Mon, Feb 20, 2017 at 12:46:52PM +0000, Daniel P. Berrange wrote:
> On Fri, Feb 03, 2017 at 11:39:35PM +0100, Max Reitz wrote:
> > On 03.02.2017 13:02, Daniel P. Berrange wrote:
> > > The qemu-img dd/convert commands will create a image file and
> > > then try to open it. Historically it has been possible to open
> > > new files without passing any options. With encrypted files
> > > though, the *key-secret options are mandatory, so we need to
> > > provide those options when opening the newly created file.
> > > 
> > > Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> > > ---
> > >  qemu-img.c | 51 +++++++++++++++++++++++++++++++++++++++++++++++----
> > >  1 file changed, 47 insertions(+), 4 deletions(-)
> > > 
> > > diff --git a/qemu-img.c b/qemu-img.c
> > > index dc4c6eb..98522dd 100644
> > > --- a/qemu-img.c
> > > +++ b/qemu-img.c
> > > @@ -319,6 +319,49 @@ static BlockBackend *img_open_file(const char *filename,
> > >  }
> > >  
> > >  
> > > +static int img_add_key_secrets(void *opaque,
> > > +                               const char *name, const char *value,
> > > +                               Error **errp)
> > > +{
> > > +    QDict **options = opaque;
> > > +
> > > +    if (g_str_has_suffix(name, "key-secret")) {
> > > +        if (!*options) {
> > > +            *options = qdict_new();
> > > +        }
> > > +        qdict_put(*options, name, qstring_from_str(value));
> > > +    }
> > > +
> > > +    return 0;
> > > +}
> > > +
> > > +static BlockBackend *img_open_new_file(const char *filename,
> > > +                                       QemuOpts *create_opts,
> > > +                                       const char *fmt, int flags,
> > > +                                       bool writethrough, bool quiet)
> > > +{
> > > +    BlockBackend *blk;
> > > +    Error *local_err = NULL;
> > > +    QDict *options = NULL;
> > > +
> > > +    if (fmt) {
> > > +        options = qdict_new();
> > > +        qdict_put(options, "driver", qstring_from_str(fmt));
> > > +    }
> > > +
> > > +    qemu_opt_foreach(create_opts, img_add_key_secrets, &options, NULL);
> > 
> > It would probably be easier to just unconditionally create an options
> > QDict. It doesn't hurt if it's empty.
> 
> Ok, I will make that change.
> 
> > Anyway:
> > 
> > Reviewed-by: Max Reitz <mreitz@redhat.com>
> > 
> > > +
> > > +    blk = blk_new_open(filename, NULL, options, flags, &local_err);
> > > +    if (!blk) {
> > > +        error_reportf_err(local_err, "Could not open '%s': ", filename);
> > > +        return NULL;
> > > +    }
> > > +    blk_set_enable_write_cache(blk, !writethrough);
> > > +
> > > +    return blk;
> 
> it seems I'm also leaking "options" so will adda  QDECREF too

Actually I'm wrong here - I forgot this is an unusual case where
blk_new_open grabs the existing reference rather than incref'ing
it.

Regards,
Daniel
-- 
|: http://berrange.com      -o-    http://www.flickr.com/photos/dberrange/ :|
|: http://libvirt.org              -o-             http://virt-manager.org :|
|: http://entangle-photo.org       -o-    http://search.cpan.org/~danberr/ :|
