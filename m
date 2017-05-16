Received: from eggs.gnu.org ([2001:4830:134:3::10]:56743)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dAXhs-0005GA-3u
	for qemu-devel@nongnu.org; Tue, 16 May 2017 04:19:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dAXhq-0007RX-RS
	for qemu-devel@nongnu.org; Tue, 16 May 2017 04:19:48 -0400
Date: Tue, 16 May 2017 09:19:35 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170516081935.GB9105@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20170515140410.14172-1-berrange@redhat.com>
	<20170515140410.14172-5-berrange@redhat.com>
	<e2a74028-c9c0-6b6a-4c13-27fab303a2e1@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e2a74028-c9c0-6b6a-4c13-27fab303a2e1@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v9 4/4] qemu-img: copy *key-secret opts
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
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, Eric Blake <eblake@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Fam Zheng <famz@redhat.com>

On Mon, May 15, 2017 at 07:43:15PM +0200, Max Reitz wrote:
> On 2017-05-15 16:04, Daniel P. Berrange wrote:
> > The qemu-img dd/convert commands will create an image file and
> > then try to open it. Historically it has been possible to open
> > new files without passing any options. With encrypted files
> > though, the *key-secret options are mandatory, so we need to
> > provide those options when opening the newly created file.
> > 
> > Reviewed-by: Max Reitz <mreitz@redhat.com>
> > Reviewed-by: Fam Zheng <famz@redhat.com>
> > Reviewed-by: Eric Blake <eblake@redhat.com>
> > Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> > ---
> >  qemu-img.c | 42 +++++++++++++++++++++++++++++++++++++-----
> >  1 file changed, 37 insertions(+), 5 deletions(-)
> > 
> > diff --git a/qemu-img.c b/qemu-img.c
> > index e0e3d31..dcddded 100644
> > --- a/qemu-img.c
> > +++ b/qemu-img.c
> > @@ -314,15 +314,18 @@ static BlockBackend *img_open_opts(const char *optstr,
> >  }
> >  
> >  static BlockBackend *img_open_file(const char *filename,
> > +                                   QDict *options,
> >                                     const char *fmt, int flags,
> >                                     bool writethrough, bool quiet,
> >                                     bool force_share)
> >  {
> >      BlockBackend *blk;
> >      Error *local_err = NULL;
> > -    QDict *options = qdict_new();
> >  
> >      if (fmt) {
> > +        if (!options) {
> > +            options = qdict_new();
> > +        }
> 
> This is the only place where my attempted rebase and your version
> differ. I think this has to be done unconditionally, because otherwise:
> 
> $ ./qemu-img info -U null-co://
> [1]    16327 segmentation fault (core dumped)  ./qemu-img info -U null-co://

Yep, sorry this was the mistake that made me send v10.

> Also, I'm not sure the R-bs apply for this patch any longer.
> 
> (They do for patch 1 because it's just a contextual difference. For
> patch 2, it's a borderline case (I would drop it, but I can understand
> keeping it). For patch 3 it's more than just borderline - I would
> definitely drop the R-b, but the differences are still rather
> mechanical, so it is acceptable to keep it.
> But I think there are too many changes here in this patch to keep the
> R-bs. In fact, I'm pretty sure none of Eric, Fam and me have given an
> R-b to this segfault...)

True, I'm never too sure what level of changes is large enough to
require dropping the R-b. Normally I just do it if it is feature
changes or non-trivial review feedback, where as this was just
(supposedly easy) conflict resolution, but it did go wrong this
time :-(



Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
