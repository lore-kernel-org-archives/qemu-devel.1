Received: from eggs.gnu.org ([2001:4830:134:3::10]:50324)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cbpFU-0004Mu-7i
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 08:59:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cbpFO-0004jM-8T
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 08:59:00 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38270)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1cbpFO-0004jG-0r
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 08:58:54 -0500
Date: Thu, 9 Feb 2017 13:58:51 +0000
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170209135851.GC4742@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <1486645277-4724-1-git-send-email-kraxel@redhat.com>
	<CAFEAcA_3end4WrkELu9LBxL8jnUWt0SKRwMJtuMh_1QeVQy4=g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFEAcA_3end4WrkELu9LBxL8jnUWt0SKRwMJtuMh_1QeVQy4=g@mail.gmail.com>
Subject: Re: [Qemu-devel] [PULL 00/10] vnc: add support for multiple
 listening sockets.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Gerd Hoffmann <kraxel@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>

On Thu, Feb 09, 2017 at 01:15:52PM +0000, Peter Maydell wrote:
> On 9 February 2017 at 13:01, Gerd Hoffmann <kraxel@redhat.com> wrote:
> >   Hi,
> >
> > Here comes the UI patch queue, carrying only vnc updates this time.  Big
> > chunk is the multiple sockets support patch series, but there are also
> > some smaller fixes and cleanups.
> >
> > please pull,
> >   Gerd
> >
> > The following changes since commit d0dff238a87fa81393ed72754d4dc8b09e50b08b:
> >
> >   Merge remote-tracking branch 'remotes/juanquintela/tags/migration/20170206' into staging (2017-02-07 15:29:26 +0000)
> >
> > are available in the git repository at:
> >
> >
> >   git://git.kraxel.org/qemu tags/pull-ui-20170209-1
> >
> > for you to fetch changes up to 7448e761356799d4e445e6ea3891a8067233465d:
> >
> >   ui: add ability to specify multiple VNC listen addresses (2017-02-08 14:59:40 +0100)
> >
> > ----------------------------------------------------------------
> > vnc: add support for multiple listening sockets.
> > vnc: misc fixes and cleanups.
> 
> Build failure on clang/OSX:
> 
> /Users/pm215/src/qemu-for-merges/ui/vnc.c:3566:21: error: variable
> 'baseport' is used uninitialized whenever 'if' condition is false
> [-Werror,-Wsometimes-uninitialized]
>                 if (displaynum == -1) {
>                     ^~~~~~~~~~~~~~~~
> /Users/pm215/src/qemu-for-merges/ui/vnc.c:3603:15: note: uninitialized
> use occurs here
>         ret = baseport;
>               ^~~~~~~~
>   CC      ui/vnc-enc-hextile.o
> /Users/pm215/src/qemu-for-merges/ui/vnc.c:3566:17: note: remove the
> 'if' if its condition is always true
>                 if (displaynum == -1) {
>                 ^~~~~~~~~~~~~~~~~~~~~~
> /Users/pm215/src/qemu-for-merges/ui/vnc.c:3564:17: error: variable
> 'baseport' is used uninitialized whenever 'if' condition is false
> [-Werror,-Wsometimes-uninitialized]
>             if (g_str_equal(addrstr, "") ||
>                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~
> /Users/pm215/src/qemu-for-merges/ui/vnc.c:3603:15: note: uninitialized
> use occurs here
>         ret = baseport;
>               ^~~~~~~~
> /Users/pm215/src/qemu-for-merges/ui/vnc.c:3564:13: note: remove the
> 'if' if its condition is always true
>             if (g_str_equal(addrstr, "") ||
>             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> /Users/pm215/src/qemu-for-merges/ui/vnc.c:3533:36: note: initialize
> the variable 'baseport' to silence this warning
>         unsigned long long baseport;
>                                    ^
>                                     = 0
> 
> That's slightly confused, but what it's saying is that in
> vnc_display_get_address() we don't set baseport in the
> if (websocket) codepath, but we use it unconditionally.

Yes, a huge list of messages for a single missed initialization.

Gerd, just squash

diff --git a/ui/vnc.c b/ui/vnc.c
index 77f2a99..bffc650 100644
--- a/ui/vnc.c
+++ b/ui/vnc.c
@@ -3529,7 +3529,7 @@ static int vnc_display_get_address(const char *addrstr,
     } else {
         const char *port;
         size_t hostlen;
-        unsigned long long baseport;
+        unsigned long long baseport = 0;
         InetSocketAddress *inet;
 
         port = strrchr(addrstr, ':');


Into this commit:

    ui: refactor code for populating SocketAddress from vnc_display_open

Just confirmed this fixes it with a local clang build

Regards,
Daniel
-- 
|: http://berrange.com      -o-    http://www.flickr.com/photos/dberrange/ :|
|: http://libvirt.org              -o-             http://virt-manager.org :|
|: http://entangle-photo.org       -o-    http://search.cpan.org/~danberr/ :|
