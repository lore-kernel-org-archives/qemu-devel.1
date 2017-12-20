Received: from eggs.gnu.org ([2001:4830:134:3::10]:59063)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eRhBS-0005Uh-CS
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 11:25:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eRhBO-0001nb-Fm
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 11:25:30 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45404)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1eRhBO-0001mk-A0
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 11:25:26 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 59965272D5
	for <qemu-devel@nongnu.org>; Wed, 20 Dec 2017 16:25:25 +0000 (UTC)
Date: Wed, 20 Dec 2017 16:25:20 +0000
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20171220162520.GU21216@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20171218135417.28301-1-berrange@redhat.com>
	<20171218135417.28301-2-berrange@redhat.com>
	<b38ef134-69ac-5b90-adb4-6a38190d2dcf@redhat.com>
	<f2953a7c-a107-4b42-527e-05e708f1fffd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f2953a7c-a107-4b42-527e-05e708f1fffd@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 1/1] chardev: convert the socket server
 to QIONetListener
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>

On Wed, Dec 20, 2017 at 05:23:17PM +0100, Paolo Bonzini wrote:
> On 19/12/2017 09:48, Paolo Bonzini wrote:
> > On 18/12/2017 14:54, Daniel P. Berrange wrote:
> >> Instead of creating a QIOChannelSocket directly for the chardev
> >> server socket, use a QIONetListener. This provides the ability
> >> to listen on multiple sockets at the same time, so enables
> >> full support for IPv4/IPv6 dual stack.
> >>
> >> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> >> ---
> >>  chardev/char-socket.c | 72 +++++++++++++++++++++------------------------------
> >>  1 file changed, 29 insertions(+), 43 deletions(-)
> > 
> > Queued, thanks.
> 
> I think this has to be squashed in to avoid use-after-free issues left and right
> (visible with test-hmp):
> 
> diff --git a/chardev/char-socket.c b/chardev/char-socket.c
> index 2d2252a..630a7f2 100644
> --- a/chardev/char-socket.c
> +++ b/chardev/char-socket.c
> @@ -930,6 +930,7 @@ static void qmp_chardev_open_socket(Chardev *chr,
>  
>              if (qio_net_listener_open_sync(s->listener, s->addr, errp) < 0) {
>                  object_unref(OBJECT(s->listener));
> +                s->listener = NULL;
>                  goto error;
>              }

Yes, that makes sense given the context, though I can't reproduce the test
failures myself yet. Any, please do squash it into the patch, as it makes
sense. Reviewed-by: Daniel P. Berrange <berrange@redhat.com>



Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
