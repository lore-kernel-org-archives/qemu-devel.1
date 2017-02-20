Received: from eggs.gnu.org ([2001:4830:134:3::10]:50708)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cfnKW-0002HZ-Ac
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 07:44:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cfnKU-0000yb-Qh
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 07:44:36 -0500
Date: Mon, 20 Feb 2017 12:44:23 +0000
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170220124423.GN15874@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20170203120254.15062-1-berrange@redhat.com>
	<20170203120254.15062-6-berrange@redhat.com>
	<30f30db6-2bf4-44c6-5267-cd98e8d99bca@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <30f30db6-2bf4-44c6-5267-cd98e8d99bca@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 5/6] qemu-img: introduce
 --target-image-opts for 'convert' command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Eric Blake <eblake@redhat.com>, Fam Zheng <famz@redhat.com>

On Fri, Feb 03, 2017 at 11:32:13PM +0100, Max Reitz wrote:
> On 03.02.2017 13:02, Daniel P. Berrange wrote:
> > The '--image-opts' flags indicates whether the source filename
> > includes options. The target filename has to remain in the
> > plain filename format though, since it needs to be passed to
> > bdrv_create().  When using --skip-create though, it would be
> > possible to use image-opts syntax. This adds --target-image-opts
> > to indicate that the target filename includes options. Currently
> > this mandates use of the --skip-create flag too.
> > 
> > Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> > ---
> >  qemu-img-cmds.hx |   6 +--
> >  qemu-img.c       | 131 ++++++++++++++++++++++++++++++++++++-------------------
> >  qemu-img.texi    |  12 ++++-
> >  3 files changed, 98 insertions(+), 51 deletions(-)
> 
> Apart from what the commit message says, it also introduces that switch
> for dd, which I again don't like too much (quelle surprise), if only
> because it requires conv=nocreat and thus patch 5 to be useful.

Once again, I'll drop the 'dd' parts of this patch.

> > @@ -1918,7 +1933,7 @@ static int img_convert(int argc, char **argv)
> >      bs_n = argc - optind - 1;
> >      out_filename = bs_n >= 1 ? argv[argc - 1] : NULL;
> >  
> > -    if (options && has_help_option(options)) {
> > +    if (out_fmt && options && has_help_option(options)) {
> 
> "!out_fmt && options && has_help_option(options)" should probably be an
> error.

Ok.

> > @@ -1987,22 +2002,22 @@ static int img_convert(int argc, char **argv)
> >          goto out;
> >      }
> >  
> > -    /* Find driver and parse its options */
> > -    drv = bdrv_find_format(out_fmt);
> > -    if (!drv) {
> > -        error_report("Unknown file format '%s'", out_fmt);
> > -        ret = -1;
> > -        goto out;
> > -    }
> > +    if (!skip_create) {
> > +        /* Find driver and parse its options */
> > +        drv = bdrv_find_format(out_fmt);
> > +        if (!drv) {
> > +            error_report("Unknown file format '%s'", out_fmt);
> > +            ret = -1;
> > +            goto out;
> > +        }
> >  
> > -    proto_drv = bdrv_find_protocol(out_filename, true, &local_err);
> > -    if (!proto_drv) {
> > -        error_report_err(local_err);
> > -        ret = -1;
> > -        goto out;
> > -    }
> > +        proto_drv = bdrv_find_protocol(out_filename, true, &local_err);
> > +        if (!proto_drv) {
> > +            error_report_err(local_err);
> > +            ret = -1;
> > +            goto out;
> > +        }
> >  
> > -    if (!skip_create) {
> >          if (!drv->create_opts) {
> >              error_report("Format driver '%s' does not support image creation",
> >                           drv->format_name);
> 
> Compression may be used with -n. This involves the check whether
> drv->bdrv_co_pwritev_compressed is NULL or not -- which is bad if drv is
> still NULL:
> 
> $ ./qemu-img create -f qcow2 foo.qcow2 64M
> Formatting 'foo.qcow2', fmt=qcow2 size=67108864 encryption=off
> cluster_size=65536 lazy_refcounts=off refcount_bits=16
> $ ./qemu-img convert -c -O qcow2 -n null-co:// foo.qcow2
> [1]    17179 segmentation fault (core dumped)  ./qemu-img convert -c -O
> qcow2 -n null-co:// foo.qcow
> 
> Therefore, you should probably only do the check whether compression is
> supported if drv is non-NULL; and if it is NULL, do the check again
> after the target image has been opened and its driver is known.

Oh, yes, that's a fun combination. I'll do that.


> > diff --git a/qemu-img.texi b/qemu-img.texi
> > index 01acfb8..bda3cc3 100644
> > --- a/qemu-img.texi
> > +++ b/qemu-img.texi
> > @@ -45,9 +45,17 @@ keys.
> >  
> >  @item --image-opts
> >  
> > -Indicates that the @var{filename} parameter is to be interpreted as a
> > +Indicates that the source @var{filename} parameter is to be interpreted as a
> >  full option string, not a plain filename. This parameter is mutually
> > -exclusive with the @var{-f} and @var{-F} parameters.
> > +exclusive with the @var{-f} parameter.
> 
> -F is correct, that's the one for qemu-img compare, after all (which
> takes two source filenames).
> 
> > +
> > +@item --target-image-opts
> > +
> > +Indicates that the target @var{filename} parameter(s) are to be interpreted a
> > +a full option string, not a plain filename. This parameter is mutually
> > +exclusive with the @var{-F} or @var{-O} parameters. It is currently required
> 
> -F is unrelated to a target ("output") file.

Opps, yes.

Regards,
Daniel
-- 
|: http://berrange.com      -o-    http://www.flickr.com/photos/dberrange/ :|
|: http://libvirt.org              -o-             http://virt-manager.org :|
|: http://entangle-photo.org       -o-    http://search.cpan.org/~danberr/ :|
