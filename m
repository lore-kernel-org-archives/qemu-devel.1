Received: from eggs.gnu.org ([209.51.188.92]:43844)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1h1XMH-0007ab-32
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 09:17:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1h1XMA-0003Qj-Kv
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 09:17:21 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:42103)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1h1XMA-0003QO-GW
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 09:17:14 -0500
Received: by mail-qt1-f195.google.com with SMTP id u7so12931093qtg.9
	for <qemu-devel@nongnu.org>; Wed, 06 Mar 2019 06:17:14 -0800 (PST)
Date: Wed, 6 Mar 2019 09:17:11 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20190306091704-mutt-send-email-mst@kernel.org>
References: <20190305225135.7060-1-marcandre.lureau@redhat.com>
	<53bdf4ee-d791-9983-6f1c-72b2b96e7342@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <53bdf4ee-d791-9983-6f1c-72b2b96e7342@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] vhost-user-test: fix leaks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org, pbonzini@redhat.com, Laurent Vivier <lvivier@redhat.com>

On Wed, Mar 06, 2019 at 07:35:28AM +0100, Thomas Huth wrote:
> On 05/03/2019 23.51, Marc-André Lureau wrote:
> > Spotted by ASAN.
> > 
> > Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> > ---
> >  tests/vhost-user-test.c | 3 +++
> >  1 file changed, 3 insertions(+)
> > 
> > diff --git a/tests/vhost-user-test.c b/tests/vhost-user-test.c
> > index 4cd0a97f13..9364227ba4 100644
> > --- a/tests/vhost-user-test.c
> > +++ b/tests/vhost-user-test.c
> > @@ -588,6 +588,7 @@ static void test_server_free(TestServer *server)
> >          g_test_message("unable to rmdir: path (%s): %s",
> >                         server->tmpfs, strerror(errno));
> >      }
> > +    g_free(server->tmpfs);
> >  
> >      qemu_chr_fe_deinit(&server->chr, true);
> >  
> > @@ -605,6 +606,8 @@ static void test_server_free(TestServer *server)
> >  
> >      g_main_loop_unref(server->loop);
> >      g_main_context_unref(server->context);
> > +    g_cond_clear(&server->data_cond);
> > +    g_mutex_clear(&server->data_mutex);
> >      g_free(server);
> >  }
> 
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> 
> ... and queued to my qtest-next branch (unless Michael wants to take it
> through hist vhost tree instead).

No it's fine.

Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
