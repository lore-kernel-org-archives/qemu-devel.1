Received: from eggs.gnu.org ([2001:4830:134:3::10]:35861)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1d3f1U-0002Fm-G9
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 04:43:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1d3f1T-0006Ca-DQ
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 04:43:36 -0400
Date: Thu, 27 Apr 2017 09:43:22 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170427084322.GE5346@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20170424091659.26708-1-berrange@redhat.com>
	<20170424091659.26708-4-berrange@redhat.com>
	<37ab2b55-5586-64a5-01d9-d122f4b5b432@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <37ab2b55-5586-64a5-01d9-d122f4b5b432@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v5 3/4] qemu-img: introduce
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

On Wed, Apr 26, 2017 at 09:23:25PM +0200, Max Reitz wrote:
> On 24.04.2017 11:16, Daniel P. Berrange wrote:
> > The '--image-opts' flags indicates whether the source filename
> > includes options. The target filename has to remain in the
> > plain filename format though, since it needs to be passed to
> > bdrv_create().  When using --skip-create though, it would be
> > possible to use image-opts syntax. This adds --target-image-opts
> > to indicate that the target filename includes options. Currently
> > this mandates use of the --skip-create flag too.
> > 
> > Reviewed-by: Eric Blake <eblake@redhat.com>
> > Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> > ---
> >  qemu-img-cmds.hx |  4 +--
> >  qemu-img.c       | 86 ++++++++++++++++++++++++++++++++++++++++----------------
> >  qemu-img.texi    | 12 ++++++--
> >  3 files changed, 73 insertions(+), 29 deletions(-)
> 
> I'm afraid this will need a rebase onto block-next now (because of
> Peter's "qemu-img: simplify img_convert" patch).

Ok.

> Besides the obvious rebase conflicts, there are some less obvious things
> that may/should thus be changed:
> 
> > diff --git a/qemu-img-cmds.hx b/qemu-img-cmds.hx
> > index 8ac7822..93b50ef 100644
> > --- a/qemu-img-cmds.hx
> > +++ b/qemu-img-cmds.hx
> 
> [...]
> 
> > @@ -2090,6 +2100,12 @@ static int img_convert(int argc, char **argv)
> >          goto fail_getopt;
> >      }
> >  
> > +    if (tgt_image_opts && !skip_create) {
> > +        error_report("--target-image-opts requires use of -n flag");
> > +        ret = -1;
> 
> Depending on whether you decide to put this below
> bdrv_parse_cache_mode() or above, you might actually no longer have to
> set ret anymore.

ok

> 
> > +        goto fail_getopt;
> > +    }
> > +
> >      /* Initialize before goto out */
> >      if (quiet) {
> >          progress = 0;
> > @@ -2100,8 +2116,14 @@ static int img_convert(int argc, char **argv)
> >      out_filename = bs_n >= 1 ? argv[argc - 1] : NULL;
> >  
> >      if (options && has_help_option(options)) {
> > -        ret = print_block_option_help(out_filename, out_fmt);
> > -        goto out;
> > +        if (out_fmt) {
> > +            ret = print_block_option_help(out_filename, out_fmt);
> > +            goto out;
> > +        } else {
> > +            error_report("Option help requires a format be specified");
> > +            ret = -1;
> 
> Since this is most likely above bdrv_parse_cache_mode() (and may thus
> end up above the previous hunk?), you probably don't have to set ret
> here either (Sorry...).
> 
> The changes from v4 look good, but the rebase will result in non-trivial
> changes, so I giving an R-b would not be of any real use, I'm afraid...

No problem, i'll respin.


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
