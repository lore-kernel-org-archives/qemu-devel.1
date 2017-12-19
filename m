Received: from eggs.gnu.org ([2001:4830:134:3::10]:50758)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eRFCy-00057W-Li
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 05:33:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eRFCo-0001a7-Uu
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 05:33:08 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35786)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1eRFCo-0001Y5-PC
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 05:33:02 -0500
Date: Tue, 19 Dec 2017 10:32:57 +0000
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20171219103257.GC32479@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20171218191228.31018-1-berrange@redhat.com>
	<20171218191228.31018-2-berrange@redhat.com>
	<20171219072629.4c23icd27ggxayc5@starbug-vm.ie.oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20171219072629.4c23icd27ggxayc5@starbug-vm.ie.oracle.com>
Subject: Re: [Qemu-devel] [PATCH v1 01/13] ui: remove 'sync' parametr from
 vnc_update_client
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Darren Kenny <darren.kenny@oracle.com>, qemu-devel@nongnu.org

Just cc'ing  qemu-devel back on the mail since it was accidentally dropped.

On Tue, Dec 19, 2017 at 07:26:29AM +0000, Darren Kenny wrote:
> Small nit on the subject s/parametr/parameter/
> 
> Otherwise, looks good.
> 
> Reviewed-by: Darren Kenny <darren.kenny@oracle.com>
> 
> Thanks,
> 
> Darren.
> 
> On Mon, Dec 18, 2017 at 07:12:16PM +0000, Daniel P. Berrange wrote:
> > There is only one caller of vnc_update_client and that always passes false
> > for the 'sync' parameter.
> > 
> > Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> > ---
> > ui/vnc.c | 11 +++--------
> > 1 file changed, 3 insertions(+), 8 deletions(-)
> > 
> > diff --git a/ui/vnc.c b/ui/vnc.c
> > index 9f8d5a1b1f..7ba3297dfa 100644
> > --- a/ui/vnc.c
> > +++ b/ui/vnc.c
> > @@ -596,7 +596,7 @@ VncInfo2List *qmp_query_vnc_servers(Error **errp)
> >    3) resolutions > 1024
> > */
> > 
> > -static int vnc_update_client(VncState *vs, int has_dirty, bool sync);
> > +static int vnc_update_client(VncState *vs, int has_dirty);
> > static void vnc_disconnect_start(VncState *vs);
> > 
> > static void vnc_colordepth(VncState *vs);
> > @@ -961,7 +961,7 @@ static int find_and_clear_dirty_height(VncState *vs,
> >     return h;
> > }
> > 
> > -static int vnc_update_client(VncState *vs, int has_dirty, bool sync)
> > +static int vnc_update_client(VncState *vs, int has_dirty)
> > {
> >     if (vs->disconnecting) {
> >         vnc_disconnect_finish(vs);
> > @@ -1025,9 +1025,6 @@ static int vnc_update_client(VncState *vs, int has_dirty, bool sync)
> >         }
> > 
> >         vnc_job_push(job);
> > -        if (sync) {
> > -            vnc_jobs_join(vs);
> > -        }
> >         vs->force_update = 0;
> >         vs->has_dirty = 0;
> >         return n;
> > @@ -1035,8 +1032,6 @@ static int vnc_update_client(VncState *vs, int has_dirty, bool sync)
> > 
> >     if (vs->disconnecting) {
> >         vnc_disconnect_finish(vs);
> > -    } else if (sync) {
> > -        vnc_jobs_join(vs);
> >     }
> > 
> >     return 0;
> > @@ -2863,7 +2858,7 @@ static void vnc_refresh(DisplayChangeListener *dcl)
> >     vnc_unlock_display(vd);
> > 
> >     QTAILQ_FOREACH_SAFE(vs, &vd->clients, next, vn) {
> > -        rects += vnc_update_client(vs, has_dirty, false);
> > +        rects += vnc_update_client(vs, has_dirty);
> >         /* vs might be free()ed here */
> >     }
> > 
> > -- 
> > 2.14.3
> > 
> > 

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
