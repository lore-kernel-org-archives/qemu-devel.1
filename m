Received: from eggs.gnu.org ([2001:4830:134:3::10]:48369)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1d1VSf-0003e7-69
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 06:06:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1d1VSe-0006tO-3A
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 06:06:45 -0400
Date: Fri, 21 Apr 2017 11:06:29 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170421100629.GN27925@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20170420040003.31074-1-famz@redhat.com>
	<20170420153016.GI3227@redhat.com>
	<20170420203250.GI4747@noname.redhat.com>
	<87pog61fjr.fsf@dusky.pond.sub.org>
	<20170421083137.GD27925@redhat.com>
	<20170421085034.GD8342@lemon.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170421085034.GD8342@lemon.lan>
Subject: Re: [Qemu-devel] [PATCH] sheepdog: Set error when connection fails
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, Kevin Wolf <kwolf@redhat.com>, sheepdog@lists.wpkg.org, qemu-block@nongnu.org, Hitoshi Mitake <mitake.hitoshi@lab.ntt.co.jp>, Jeff Cody <jcody@redhat.com>, qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Liu Yuan <namei.unix@gmail.com>

On Fri, Apr 21, 2017 at 04:50:34PM +0800, Fam Zheng wrote:
> On Fri, 04/21 09:31, Daniel P. Berrange wrote:
> > On Fri, Apr 21, 2017 at 07:43:36AM +0200, Markus Armbruster wrote:
> > > Kevin Wolf <kwolf@redhat.com> writes:
> > > 
> > > > Am 20.04.2017 um 17:30 hat Daniel P. Berrange geschrieben:
> > > >> On Thu, Apr 20, 2017 at 12:00:03PM +0800, Fam Zheng wrote:
> > > >> > Signed-off-by: Fam Zheng <famz@redhat.com>
> > > >> > ---
> > > >> >  block/sheepdog.c | 1 +
> > > >> >  1 file changed, 1 insertion(+)
> > > >> > 
> > > >> > diff --git a/block/sheepdog.c b/block/sheepdog.c
> > > >> > index fb9203e..7e889ee 100644
> > > >> > --- a/block/sheepdog.c
> > > >> > +++ b/block/sheepdog.c
> > > >> > @@ -608,6 +608,7 @@ static int connect_to_sdog(BDRVSheepdogState *s, Error **errp)
> > > >> >          qemu_set_nonblock(fd);
> > > >> >      } else {
> > > >> >          fd = -EIO;
> > > >> > +        error_setg(errp, "Failed to connect to sheepdog server");
> > > >> >      }
> > > >> 
> > > >> This doesn't make much sense to me. The lines just above the
> > > >> diff context have this:
> > > >> 
> > > >>     fd = socket_connect(s->addr, errp, NULL, NULL);
> > > >> 
> > > >> socket_connect should have already reported an error on "errp"
> > > >> in the scenario that 'fd == -1'.
> > > >
> > > > By the way, am I the only one who thinks that having errp anywhere else
> > > > than as the last argument is bad style? I can easily see myself missing
> > > > that this functions sets it because the last argument is NULL.
> > > 
> > > Yes, it's bad style because it's suprising.  Worth fixing.
> > 
> > In fact we can simply delete the last two arguments to socket_connect()
> > entirely. Most code is now switched over to use QIOChannel APIs, so we
> > don't have anything which uses the non-blocking connect feature of
> > socket_connect() anymore.
> 
> There is one caller that passes non-NULL last two parameters, which seems
> non-trivial to convert:
> 
> static int net_socket_connect_init(NetClientState *peer,
>                                    const char *model,
>                                    const char *name,
>                                    const char *host_str)
> {
>     socket_connect_data *c = g_new0(socket_connect_data, 1);
>     int fd = -1;
>     Error *local_error = NULL;
> 
>     c->peer = peer;
>     c->model = g_strdup(model);
>     c->name = g_strdup(name);
>     c->saddr = socket_parse(host_str, &local_error);
>     if (c->saddr == NULL) {
>         goto err;
>     }
> 
>     fd = socket_connect(c->saddr, net_socket_connected, c, &local_error);
>     if (fd < 0) {
>         goto err;
>     }
> 
>     return 0;
> 
> err:
>     error_report_err(local_error);
>     socket_connect_data_free(c);
>     return -1;
> }

Oh i missed that in my grep. I think it could probably be converted to
QIOChannel though, at least for the initial connection setup. Then
just steal the FD from the QIOChannel object for direct usage thereafter
or something like that.


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
