Received: from eggs.gnu.org ([2001:4830:134:3::10]:40698)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1d2XCp-0007Wp-U6
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 02:10:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1d2XCo-0002wm-Jd
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 02:10:39 -0400
Date: Mon, 24 Apr 2017 14:10:30 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170424061030.GC316@lemon.lan>
References: <20170421035606.448-1-famz@redhat.com>
	<20170421035606.448-5-famz@redhat.com>
	<20170421132509.GD4318@noname.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170421132509.GD4318@noname.redhat.com>
Subject: Re: [Qemu-devel] [PATCH v14 04/20] qemu-img: Add --share-rw option
 to subcommands
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, eblake@redhat.com, Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org

On Fri, 04/21 15:25, Kevin Wolf wrote:
> Am 21.04.2017 um 05:55 hat Fam Zheng geschrieben:
> > Similar to share-rw qdev property, this will force the opened images to
> > allow shared write permission of other programs.
> > 
> > Signed-off-by: Fam Zheng <famz@redhat.com>
> 
> General observation: We were considering to make share-rw require
> read-only. Some of the commands converted here always open the image
> read-write, so if we go ahead with the restriction, will the option
> become useless in many of the subcommands?

share-rw on qdev doesn't require read-only, so I personally perfer we follow
that manner. Because even with --share-rw for the read-write commands,
the image is still protected from corruption by the fact that the other side
probably uses non-share-rw.

But on the other hand, we can always add the option when necessary, so it's okay
to leave them as is. If you insist, I can remove them in next version.

> 
> >  qemu-img.c | 155 +++++++++++++++++++++++++++++++++++++++++++++++--------------
> >  1 file changed, 119 insertions(+), 36 deletions(-)
> > 
> > diff --git a/qemu-img.c b/qemu-img.c
> > index ed24371..df88a79 100644
> > --- a/qemu-img.c
> > +++ b/qemu-img.c
> > @@ -28,6 +28,7 @@
> >  #include "qapi/qobject-output-visitor.h"
> >  #include "qapi/qmp/qerror.h"
> >  #include "qapi/qmp/qjson.h"
> > +#include "qapi/qmp/qbool.h"
> >  #include "qemu/cutils.h"
> >  #include "qemu/config-file.h"
> >  #include "qemu/option.h"
> > @@ -283,12 +284,15 @@ static int img_open_password(BlockBackend *blk, const char *filename,
> >  
> >  static BlockBackend *img_open_opts(const char *optstr,
> >                                     QemuOpts *opts, int flags, bool writethrough,
> > -                                   bool quiet)
> > +                                   bool quiet, bool share_rw)
> >  {
> >      QDict *options;
> >      Error *local_err = NULL;
> >      BlockBackend *blk;
> >      options = qemu_opts_to_qdict(opts, NULL);
> > +    if (share_rw) {
> > +        qdict_put(options, BDRV_OPT_FORCE_SHARED_WRITE, qbool_from_bool(true));
> > +    }
> 
> It's interesting that you chose a conditional qdict_put for true rather
> than an unconditional one for share_rw here. The difference becomes
> visible when someone sets both -U and share-rw=off; we need to decide
> which one should take precedence.

I don't have a preference here.  Setting both -U and share-rw=off is
inconsistent, it's not a problem to yield an "undefined" result.

> 
> Generally, we always give explicit options the precedence, so if we were
> to follow suit here, we would set share-rw here only if the option isn't
> already set. For strings, we have qdict_set_default_str() to achieve
> this, for bools we probably need a new function (or does Eric's series
> which introduces qdict_put_bool() also introduce a similar function,
> like some qdict_set_default_bool?)
> 
> >      blk = blk_new_open(NULL, NULL, options, flags, &local_err);
> >      if (!blk) {
> >          error_reportf_err(local_err, "Could not open '%s': ", optstr);
> 
> > @@ -2985,6 +3035,7 @@ static int img_rebase(int argc, char **argv)
> >      int c, flags, src_flags, ret;
> >      bool writethrough, src_writethrough;
> >      int unsafe = 0;
> > +    bool share_rw = 0;
> 
> Not false?

Will fix.

> 
> >      int progress = 0;
> >      bool quiet = false;
> >      Error *local_err = NULL;
> > @@ -3001,9 +3052,10 @@ static int img_rebase(int argc, char **argv)
> >              {"help", no_argument, 0, 'h'},
> >              {"object", required_argument, 0, OPTION_OBJECT},
> >              {"image-opts", no_argument, 0, OPTION_IMAGE_OPTS},
> > +            {"share-rw", no_argument, 0, 'U'},
> >              {0, 0, 0, 0}
> >          };
> > -        c = getopt_long(argc, argv, ":hf:F:b:upt:T:q",
> > +        c = getopt_long(argc, argv, ":hf:F:b:upt:T:qU",
> >                          long_options, NULL);
> >          if (c == -1) {
> >              break;
> > @@ -3053,6 +3105,9 @@ static int img_rebase(int argc, char **argv)
> >          case OPTION_IMAGE_OPTS:
> >              image_opts = true;
> >              break;
> > +        case 'U':
> > +            share_rw = true;
> > +            break;
> >          }
> >      }
> >  
> > @@ -3101,7 +3156,8 @@ static int img_rebase(int argc, char **argv)
> >       * Ignore the old backing file for unsafe rebase in case we want to correct
> >       * the reference to a renamed or moved backing file.
> >       */
> > -    blk = img_open(image_opts, filename, fmt, flags, writethrough, quiet);
> > +    blk = img_open(image_opts, filename, fmt, flags, writethrough, quiet,
> > +                   share_rw);
> >      if (!blk) {
> >          ret = -1;
> >          goto out;
> > @@ -3126,6 +3182,9 @@ static int img_rebase(int argc, char **argv)
> >              qdict_put(options, "driver", qstring_from_str(bs->backing_format));
> >          }
> >  
> > +        if (share_rw) {
> > +            qdict_put(options, BDRV_OPT_FORCE_SHARED_WRITE, qbool_from_bool(true));
> 
> This is longer than 80 lines and wrapping wouldn't make it unreadable. I
> think there are more similar instances in this series (even though you
> replied to the patchew mail that they are intentional).

OK, I can wrap it.

> 
> > +        }
> >          bdrv_get_backing_filename(bs, backing_name, sizeof(backing_name));
> >          blk_old_backing = blk_new_open(backing_name, NULL,
> >                                         options, src_flags, &local_err);
> 
> Why don't you apply share_rw to blk_new_backing, which is opened a few
> lines down from here?

I missed that one, will fix.

Fam
