Received: from eggs.gnu.org ([2001:4830:134:3::10]:35171)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1d81Zl-0005nA-Hu
	for qemu-devel@nongnu.org; Tue, 09 May 2017 05:37:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1d81Zk-00061t-Eb
	for qemu-devel@nongnu.org; Tue, 09 May 2017 05:37:01 -0400
Date: Tue, 9 May 2017 10:36:43 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170509093643.GE1669@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20170502144744.26815-1-berrange@redhat.com>
	<20170502144744.26815-4-berrange@redhat.com>
	<2f99bd19-4a9d-850e-ed56-7b998797c6a6@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2f99bd19-4a9d-850e-ed56-7b998797c6a6@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v7 3/4] qemu-img: introduce
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
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, Eric Blake <eblake@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Fam Zheng <famz@redhat.com>

On Wed, May 03, 2017 at 09:50:49PM +0200, Max Reitz wrote:
> On 02.05.2017 16:47, Daniel P. Berrange wrote:
> > The '--image-opts' flag indicates whether the source filename
> > includes options. The target filename has to remain in the
> > plain filename format though, since it needs to be passed to
> > bdrv_create().  When using --skip-create though, it would be
> > possible to use image-opts syntax. This adds --target-image-opts
> > to indicate that the target filename includes options. Currently
> > this mandates use of the --skip-create flag too.
> > 
> > Reviewed-by: Fam Zheng <famz@redhat.com>
> > Reviewed-by: Eric Blake <eblake@redhat.com>
> 
> Sure you want to keep this, considering that there are quite some
> changes since v5?
> 
> > Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> > ---
> >  qemu-img-cmds.hx |  4 +--
> >  qemu-img.c       | 77 +++++++++++++++++++++++++++++++++++++-------------------
> >  qemu-img.texi    | 12 +++++++--
> >  3 files changed, 63 insertions(+), 30 deletions(-)
> 
> [...]
> 
> > diff --git a/qemu-img.c b/qemu-img.c
> > index d8fdcb1..94c8cea 100644
> > --- a/qemu-img.c
> > +++ b/qemu-img.c
> 
> [...]
> 
> > @@ -1900,7 +1901,7 @@ static int img_convert(int argc, char **argv)
> >      char *options = NULL;
> >      Error *local_err = NULL;
> >      bool writethrough, src_writethrough, quiet = false, image_opts = false,
> > -         skip_create = false, progress = false;
> > +        skip_create = false, progress = false, tgt_image_opts = false;
> 
> Not sure about the indentation here. (I personally don't like spanning
> the declaration over multiple lines in the first place, but that's a
> different topic.) Indenting consecutive lines by four spaces is
> standard, but the indentation by five spaces had a reason.
> 
> I guess I'd personally rather keep the five-space indentation...

This change was just automatic reindent by the editor, I'll put it
back to 5.

> 
> >      int64_t ret = -EINVAL;
> >  
> >      ImgConvertState s = (ImgConvertState) {
> 
> [...]
> 
> > @@ -2047,12 +2056,22 @@ static int img_convert(int argc, char **argv)
> >          goto fail_getopt;
> >      }
> >  
> > +    if (tgt_image_opts && !skip_create) {
> > +        error_report("--target-image-opts requires use of -n flag");
> > +        goto fail_getopt;
> > +    }
> > +
> >      s.src_num = argc - optind - 1;
> >      out_filename = s.src_num >= 1 ? argv[argc - 1] : NULL;
> >  
> >      if (options && has_help_option(options)) {
> > -        ret = print_block_option_help(out_filename, out_fmt);
> > -        goto fail_getopt;
> > +        if (out_fmt) {
> > +            ret = print_block_option_help(out_filename, out_fmt);
> > +            goto out;
> 
> Shouldn't this remain goto fail_getopt;?

Yes

> 
> > +        } else {
> > +            error_report("Option help requires a format be specified");
> > +            goto fail_getopt;
> > +        }
> >      }
> >  
> >      if (s.src_num < 1) {
> 
> [...]
> 
> Why did you remove the compress &&
> !out_bs->drv->bdrv_co_pwritev_compressed check? I liked it. :-(

That's a rebase / conflict resolution mistake

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
