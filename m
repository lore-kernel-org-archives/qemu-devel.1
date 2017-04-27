Received: from eggs.gnu.org ([2001:4830:134:3::10]:50226)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1d3mBg-0008Ki-DT
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 12:22:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1d3mBd-0003dH-P5
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 12:22:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34568)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1d3mBd-0003cl-FL
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 12:22:33 -0400
Date: Thu, 27 Apr 2017 17:22:27 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170427162227.GC30599@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <cover.1493191677.git.maozy.fnst@cn.fujitsu.com>
	<6824abf3c4e5b865de1799c302f60e8055c8d3dc.1493191677.git.maozy.fnst@cn.fujitsu.com>
	<874lx9yht7.fsf@dusky.pond.sub.org>
	<87y3ulu8k9.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87y3ulu8k9.fsf@dusky.pond.sub.org>
Subject: Re: [Qemu-devel] [PATCH v2 1/4] net/socket: Convert the
 non-blocking connection mechanism to QIOchannel
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: Mao Zhongyi <maozy.fnst@cn.fujitsu.com>, pbonzini@redhat.com, jasowang@redhat.com, qemu-devel@nongnu.org

On Thu, Apr 27, 2017 at 06:19:50PM +0200, Markus Armbruster wrote:
> Markus Armbruster <armbru@redhat.com> writes:
> 
> > Mao Zhongyi <maozy.fnst@cn.fujitsu.com> writes:
> >
> >> Currently, socket connection in net is realized by an old
> >> mechanism which is non-blocking.
> >>
> >> That old mechanism may cause net blocks on DNS lookups and
> >> QEmu has already replaced it with QIOchannel in many features,
> >> such as migration.
> >>
> >> Convert it to QIOchannel for net as well.
> >>
> >> CC: berrange@redhat.com, pbonzini@redhat.com, jasowang@redhat.com
> >> Signed-off-by: Mao Zhongyi <maozy.fnst@cn.fujitsu.com>
> >> ---
> >> The test steps like this:
> >>
> >>     $ qemu-system-x86_64 -net nic -net socket,listen=:1234 ~/img/test.img
> >>     $ qemu-system-x86_64 -net nic -net socket,connect=127.0.0.1:1234 ~/img/test.img
> >>
> >> No exception.
> >>
> >>  net/socket.c | 30 +++++++++++++++++++-----------
> >>  1 file changed, 19 insertions(+), 11 deletions(-)
> >>
> >> diff --git a/net/socket.c b/net/socket.c
> >> index b8c931e..52f9dce 100644
> >> --- a/net/socket.c
> >> +++ b/net/socket.c
> >> @@ -33,6 +33,7 @@
> >>  #include "qemu/sockets.h"
> >>  #include "qemu/iov.h"
> >>  #include "qemu/main-loop.h"
> >> +#include "io/channel-socket.h"
> >>  
> >>  typedef struct NetSocketState {
> >>      NetClientState nc;
> >> @@ -525,16 +526,22 @@ typedef struct {
> >>      char *name;
> >>  } socket_connect_data;
> >>  
> >> -static void socket_connect_data_free(socket_connect_data *c)
> >> +static void socket_connect_data_free(void *opaque)
> >>  {
> >> +    socket_connect_data *c = opaque;
> >
> > Blank line between declarations and statements, please.
> >
> >> +    if (!c) {
> >> +        return;
> >> +    }
> >> +
> >>      qapi_free_SocketAddress(c->saddr);
> >>      g_free(c->model);
> >>      g_free(c->name);
> >>      g_free(c);
> >>  }
> >>  
> >> -static void net_socket_connected(int fd, Error *err, void *opaque)
> >> +static void net_socket_connected(QIOTask *task, void *opaque)
> >>  {
> >> +    QIOChannelSocket *sioc = QIO_CHANNEL_SOCKET(qio_task_get_source(task));
> >>      socket_connect_data *c = opaque;
> >>      NetSocketState *s;
> >>      char *addr_str = NULL;
> >> @@ -543,13 +550,13 @@ static void net_socket_connected(int fd, Error *err, void *opaque)
> >>      addr_str = socket_address_to_string(c->saddr, &local_error);
> >>      if (addr_str == NULL) {
> >>          error_report_err(local_error);
> >> -        closesocket(fd);
> >> +        closesocket(sioc->fd);
> >>          goto end;
> >>      }
> >>  
> >> -    s = net_socket_fd_init(c->peer, c->model, c->name, fd, true);
> >> +    s = net_socket_fd_init(c->peer, c->model, c->name, sioc->fd, true);
> >>      if (!s) {
> >> -        closesocket(fd);
> >> +        closesocket(sioc->fd);
> 
> Actually, net_socket_fd_init() closes sioc->fd when it fails.  Closing
> it again in the caller is wrong.  None of the other callers does it.
> Please drop this line in a separate patch, before this one.

NB, technically the 'fd' is still owned by the 'sioc' object, so nothing
should close it. If we weren't already leaking the 'sioc' object we would
have a double close here....

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
