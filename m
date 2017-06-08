Received: from eggs.gnu.org ([2001:4830:134:3::10]:58412)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dJ1UT-0006xx-So
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 13:45:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dJ1UP-0005wN-Kt
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 13:45:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47568)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1dJ1UP-0005v6-Be
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 13:44:57 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 530748F226
	for <qemu-devel@nongnu.org>; Thu,  8 Jun 2017 17:44:56 +0000 (UTC)
Date: Thu, 8 Jun 2017 14:44:51 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170608174451.GJ22043@thinpad.lan.raisama.net>
References: <20170608133906.12737-1-ehabkost@redhat.com>
	<20170608133906.12737-6-ehabkost@redhat.com>
	<b27cc65d-1a07-c320-0bbc-8bb11dc22e63@redhat.com>
	<20170608160516.GL5016@thinpad.lan.raisama.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170608160516.GL5016@thinpad.lan.raisama.net>
Subject: Re: [Qemu-devel] [PATCH 5/5] vnc: No need for Error** parameter at
 vnc_client_io_error()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>

On Thu, Jun 08, 2017 at 01:05:16PM -0300, Eduardo Habkost wrote:
> On Thu, Jun 08, 2017 at 10:17:45AM -0500, Eric Blake wrote:
> > On 06/08/2017 08:39 AM, Eduardo Habkost wrote:
> > > The only callers of vnc_client_io_error() with non-NULL errp don't use
> > > *errp after the function gets called, so there's no need to use an
> > > Error** argument.  Change parameter to Error* and simplify the code.
> > > 
> > > Cc: Gerd Hoffmann <kraxel@redhat.com>
> > > Cc: Daniel P. Berrange <berrange@redhat.com>
> > > Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> > > ---
> > >  ui/vnc.h |  2 +-
> > >  ui/vnc.c | 13 +++++--------
> > >  2 files changed, 6 insertions(+), 9 deletions(-)
> > 
> > >  
> > > -ssize_t vnc_client_io_error(VncState *vs, ssize_t ret, Error **errp)
> > > +ssize_t vnc_client_io_error(VncState *vs, ssize_t ret, Error *err)
> > >  {
> > 
> > This is unusual.
> 
> Why?  I would say that using Error** for input (and not output)
> is the unusual pattern.
> 
> This is the only remaining place in the whole tree where code
> assigns something to *errp outside util/error.c (and no callers
> of this function rely on this feature).
> 
> 
> 
> > 
> > >      if (ret <= 0) {
> > >          if (ret == 0) {
> > > @@ -1188,14 +1188,11 @@ ssize_t vnc_client_io_error(VncState *vs, ssize_t ret, Error **errp)
> > >              vnc_disconnect_start(vs);
> > >          } else if (ret != QIO_CHANNEL_ERR_BLOCK) {
> > >              VNC_DEBUG("Closing down client sock: ret %zd (%s)\n",
> > > -                      ret, errp ? error_get_pretty(*errp) : "Unknown");
> > > +                      ret, err ? error_get_pretty(err) : "Unknown");
> > >              vnc_disconnect_start(vs);
> > >          }
> > >  
> > > -        if (errp) {
> > > -            error_free(*errp);
> > > -            *errp = NULL;
> > > -        }
> > > +        error_free(err);
> > 
> > Worse, it's action at a distance. You are freeing memory here that was
> > allocated in the callers.
> 
> Isn't this one of the purposes of this function?
> 
> The difference here is that now the function function is just
> taking ownership of err, making the interface and the
> implementation simpler.  If I document this more clearly at
> vnc_client_io_error()'s declaration, would it make this change
> acceptable?

What about the following?

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 ui/vnc.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/ui/vnc.c b/ui/vnc.c
index 51f13f0c29..cb55554210 100644
--- a/ui/vnc.c
+++ b/ui/vnc.c
@@ -1180,6 +1180,15 @@ void vnc_disconnect_finish(VncState *vs)
     g_free(vs);
 }
 
+
+/*
+ * Handle I/O error (@ret < 0) or EOF (@ret == 0) from I/O
+ * channel.  In case of errors or EOF, @err is freed using
+ * error_free().
+ *
+ * Returns 0 in case @ret <= 0 and the error was properly
+ * handled, otherwise returns @ret.
+ */
 ssize_t vnc_client_io_error(VncState *vs, ssize_t ret, Error *err)
 {
     if (ret <= 0) {
-- 
2.11.0.259.g40922b1

-- 
Eduardo
