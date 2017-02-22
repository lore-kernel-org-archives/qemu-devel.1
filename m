Received: from eggs.gnu.org ([2001:4830:134:3::10]:37129)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cgVso-0001ac-Ng
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 07:18:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cgVsn-0004uf-Ni
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 07:18:58 -0500
Date: Wed, 22 Feb 2017 13:18:49 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170222121849.GI4112@noname.str.redhat.com>
References: <20170220151921.22842-1-berrange@redhat.com>
	<20170220151921.22842-5-berrange@redhat.com>
	<20170222112036.GH4112@noname.str.redhat.com>
	<20170222113321.GK28937@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170222113321.GK28937@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 4/4] qemu-img: copy *key-secret opts
 when opening newly created files
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, Eric Blake <eblake@redhat.com>, Max Reitz <mreitz@redhat.com>, Fam Zheng <famz@redhat.com>

Am 22.02.2017 um 12:33 hat Daniel P. Berrange geschrieben:
> On Wed, Feb 22, 2017 at 12:20:36PM +0100, Kevin Wolf wrote:
> > Am 20.02.2017 um 16:19 hat Daniel P. Berrange geschrieben:
> > > The qemu-img dd/convert commands will create a image file and
> > > then try to open it. Historically it has been possible to open
> > > new files without passing any options. With encrypted files
> > > though, the *key-secret options are mandatory, so we need to
> > > provide those options when opening the newly created file.
> > > 
> > > Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> > > ---
> > >  qemu-img.c | 44 ++++++++++++++++++++++++++++++++++++++++++--
> > >  1 file changed, 42 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/qemu-img.c b/qemu-img.c
> > > index e48e676..bad19fd 100644
> > > --- a/qemu-img.c
> > > +++ b/qemu-img.c
> > > @@ -317,6 +317,46 @@ static BlockBackend *img_open_file(const char *filename,
> > >  }
> > >  
> > >  
> > > +static int img_add_key_secrets(void *opaque,
> > > +                               const char *name, const char *value,
> > > +                               Error **errp)
> > > +{
> > > +    QDict *options = opaque;
> > > +
> > > +    if (g_str_has_suffix(name, "key-secret")) {
> > > +        qdict_put(options, name, qstring_from_str(value));
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
> > > +    options = qdict_new();
> > > +    if (fmt) {
> > > +        qdict_put(options, "driver", qstring_from_str(fmt));
> > > +    }
> > > +
> > > +    qemu_opt_foreach(create_opts, img_add_key_secrets, options, NULL);
> > > +
> > > +    blk = blk_new_open(filename, NULL, options, flags, &local_err);
> > > +    if (!blk) {
> > > +        error_reportf_err(local_err, "Could not open '%s': ", filename);
> > > +        return NULL;
> > > +    }
> > > +    blk_set_enable_write_cache(blk, !writethrough);
> > > +
> > > +    return blk;
> > > +}
> > 
> > Why not make this a small wrapper around img_open_file(), which does
> > almost the same except that it can ask for a password? Leaving out the
> > img_open_password() call means that simple '-o encryption=on' breaks,
> > so it's a bug anyway:
> > 
> > $ ./qemu-img convert -O qcow2 -o encryption ~/images/hd.img /tmp/crypt.qcow2
> > qemu-img: block/qcow2.c:1613: qcow2_co_pwritev: Assertion `s->cipher' failed.
> 
> I had written this after my conversion of qcow2 to use secrets, but I
> presume you just tested this series in isolation. If this series merges
> before my qcow2+luks series, then yeah, we'd need to handle the scearnio
> you describe.

I see. Your commit message doesn't make clear that it depends on the
qcow2 series, so I was thinking that this could go into 2.9 even if the
qcow2 series might not make it (I think it touches the I/O path, so I'm
a bit more cautious there so short before the freeze).

Anyway, doesn't the wrapper instead of duplicating code make sense
anyway, even if the duplication didn't result in a bug?

Kevin
