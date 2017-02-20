Received: from eggs.gnu.org ([2001:4830:134:3::10]:48185)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cfn8Z-0003S3-6P
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 07:32:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cfn8Y-0005mq-5C
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 07:32:15 -0500
Date: Mon, 20 Feb 2017 12:32:02 +0000
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170220123202.GK15874@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20170203120254.15062-1-berrange@redhat.com>
	<20170203120254.15062-2-berrange@redhat.com>
	<506e3e55-ef59-ae96-51de-c8c98ef3953e@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <506e3e55-ef59-ae96-51de-c8c98ef3953e@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 1/6] qemu-img: add support for --object
 with 'dd' command
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

On Fri, Feb 03, 2017 at 10:01:53PM +0100, Max Reitz wrote:
> On 03.02.2017 13:02, Daniel P. Berrange wrote:
> > The qemu-img dd command added --image-opts support, but missed
> > the corresponding --object support. This prevented passing
> > secrets (eg auth passwords) needed by certain disk images.
> > 
> > Reviewed-by: Eric Blake <eblake@redhat.com>
> > Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> > ---
> >  qemu-img.c | 16 ++++++++++++++++
> >  1 file changed, 16 insertions(+)
> > 
> > diff --git a/qemu-img.c b/qemu-img.c
> > index 74e3362..391a141 100644
> > --- a/qemu-img.c
> > +++ b/qemu-img.c
> > @@ -3949,6 +3949,7 @@ static int img_dd(int argc, char **argv)
> >      };
> >      const struct option long_options[] = {
> >          { "help", no_argument, 0, 'h'},
> > +        { "object", required_argument, 0, OPTION_OBJECT},
> >          { "image-opts", no_argument, 0, OPTION_IMAGE_OPTS},
> >          { 0, 0, 0, 0 }
> >      };
> > @@ -3971,6 +3972,14 @@ static int img_dd(int argc, char **argv)
> >          case 'h':
> >              help();
> >              break;
> > +        case OPTION_OBJECT: {
> > +            QemuOpts *opts;
> > +            opts = qemu_opts_parse_noisily(&qemu_object_opts,
> > +                                           optarg, true);
> > +            if (!opts) {
> > +                return 1;
> > +            }
> > +        }   break;
> >          case OPTION_IMAGE_OPTS:
> >              image_opts = true;
> >              break;
> > @@ -4015,6 +4024,13 @@ static int img_dd(int argc, char **argv)
> >          ret = -1;
> >          goto out;
> >      }
> > +
> > +    if (qemu_opts_foreach(&qemu_object_opts,
> > +                          user_creatable_add_opts_foreach,
> > +                          NULL, NULL)) {
> > +        return 1;
> 
> Why not ret = -1; goto out; like the other code around this block?
> 
> (Same for the case block above.)

This was just copy+paste from other previous command handlers. I'll
change it to match img_dd() code style.

Regards,
Daniel
-- 
|: http://berrange.com      -o-    http://www.flickr.com/photos/dberrange/ :|
|: http://libvirt.org              -o-             http://virt-manager.org :|
|: http://entangle-photo.org       -o-    http://search.cpan.org/~danberr/ :|
