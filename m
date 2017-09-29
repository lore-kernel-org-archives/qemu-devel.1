Received: from eggs.gnu.org ([2001:4830:134:3::10]:42837)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dxwQt-0004WK-HE
	for qemu-devel@nongnu.org; Fri, 29 Sep 2017 10:38:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dxwQo-0007NA-IX
	for qemu-devel@nongnu.org; Fri, 29 Sep 2017 10:38:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59084)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1dxwQo-0007MT-96
	for qemu-devel@nongnu.org; Fri, 29 Sep 2017 10:38:22 -0400
Date: Fri, 29 Sep 2017 15:38:12 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170929143812.GG11930@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <1506679874-22284-1-git-send-email-a.perevalov@samsung.com>
	<CGME20170929101125eucas1p1ed4a290bfc6fcbf6f492fc45d4e9cc10@eucas1p1.samsung.com>
	<1506679874-22284-2-git-send-email-a.perevalov@samsung.com>
	<20170929104043.GB11930@redhat.com>
	<a7622d89-a067-648c-ae97-4943c7554343@samsung.com>
	<20170929130536.GF11930@redhat.com>
	<9195f261-08fb-c71d-0d95-3c8ae0080142@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <9195f261-08fb-c71d-0d95-3c8ae0080142@samsung.com>
Subject: Re: [Qemu-devel] [PATCH] configure: correctly define PTHREAD_LIB
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: Alexey Perevalov <a.perevalov@samsung.com>
Cc: qemu-devel@nongnu.org, i.maximets@samsung.com, heetae82.ahn@samsung.com, quintela@redhat.com, dgilbert@redhat.com, peterx@redhat.com
List-ID: <qemu-devel.nongnu.org>

On Fri, Sep 29, 2017 at 04:47:01PM +0300, Alexey Perevalov wrote:
> On 09/29/2017 04:05 PM, Daniel P. Berrange wrote:
> > On Fri, Sep 29, 2017 at 03:52:34PM +0300, Alexey Perevalov wrote:
> > > On 09/29/2017 01:40 PM, Daniel P. Berrange wrote:
> > > > On Fri, Sep 29, 2017 at 01:11:14PM +0300, Alexey Perevalov wrote:
> > > > > In case of -pthread already exists in QEMU_CFLAGS,
> > > > > compilation of sample pthread program successed,
> > > > > but -pthread is not putting into PTHREAD_LIBS in this case.
> > > > > PTHREAD_LIB is using while compiling tests/migration/stress.
> > > > > 
> > > > > Signed-off-by: Alexey Perevalov <a.perevalov@samsung.com>
> > > > > ---
> > > > >    configure | 1 +
> > > > >    1 file changed, 1 insertion(+)
> > > > > 
> > > > > diff --git a/configure b/configure
> > > > > index 6587e80..a2dd044 100755
> > > > > --- a/configure
> > > > > +++ b/configure
> > > > > @@ -3359,6 +3359,7 @@ int main(void) {
> > > > >    EOF
> > > > >    if compile_prog "" "" ; then
> > > > >      pthread=yes
> > > > > +  PTHREAD_LIB="-pthread"
> > > > >    else
> > > > >      for pthread_lib in $PTHREADLIBS_LIST; do
> > > > >        if compile_prog "" "$pthread_lib" ; then
> > > > We shouldn't do this because it affects whole of QEMU. The stress program
> > > > needs -lpthread because it is linking statically, so just add it to the
> > > > Makefile rule for building stress.
> > > ok, but I didn't find any explicit usage of PTHREAD_LIB,
> > > and avoiding it in Makefile I think will make PTHREAD_LIB
> > > redundant.
> > Oh yeah, actually PTHREAD_LIB is a variable i introduced specifically
> > for the stress program, so my comment above is wrong and I think your
> > patch is ok.
> in that hardcoded form or trying to generalize it somehow?
> 
> -pthread comes to QEMU_CFLAGS from pkg-config --cflags for glib library
> so it's hard to say which one from list -pthread -lpthread -lpthreadGC2
> really lead to success build of the sample.
> So it's better to cut pthread from QEMU_CFLAGS, or you thing it's overkill?

The stress program uses pthreads so we can't just cut it. We just need to
set -pthread IMHO.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
