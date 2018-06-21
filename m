Received: from eggs.gnu.org ([2001:4830:134:3::10]:37847)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tiwei.bie@intel.com>) id 1fVzcc-0008Lh-0Q
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 09:27:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tiwei.bie@intel.com>) id 1fVzcX-0003lT-6h
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 09:27:34 -0400
Received: from mga05.intel.com ([192.55.52.43]:25660)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <tiwei.bie@intel.com>) id 1fVzcW-0003kT-Sg
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 09:27:29 -0400
Date: Thu, 21 Jun 2018 21:27:30 +0800
From: Tiwei Bie <tiwei.bie@intel.com>
Message-ID: <20180621132730.GA3345@debian>
References: <20180618161729.334-1-marcandre.lureau@redhat.com>
	<20180618161729.334-5-marcandre.lureau@redhat.com>
	<20180621123320.GA19274@debian>
	<CAJ+F1CKPbdXx5sAA1ershQ_YeSOupocjfZsFWqha8-7ObkvUTg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJ+F1CKPbdXx5sAA1ershQ_YeSOupocjfZsFWqha8-7ObkvUTg@mail.gmail.com>
Subject: Re: [Qemu-devel] [PATCH v3 04/26] vhost-user: simplify
 vhost_user_init/vhost_user_cleanup
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>
Cc: QEMU <qemu-devel@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>

On Thu, Jun 21, 2018 at 02:48:08PM +0200, Marc-André Lureau wrote:
> On Thu, Jun 21, 2018 at 2:33 PM, Tiwei Bie <tiwei.bie@intel.com> wrote:
> > On Mon, Jun 18, 2018 at 06:17:07PM +0200, Marc-André Lureau wrote:
> > [...]
> >> diff --git a/hw/virtio/vhost-stub.c b/hw/virtio/vhost-stub.c
> >> index 049089b5e2..323dfcc46a 100644
> >> --- a/hw/virtio/vhost-stub.c
> >> +++ b/hw/virtio/vhost-stub.c
> >> @@ -7,7 +7,7 @@ bool vhost_has_free_slot(void)
> >>      return true;
> >>  }
> >>
> >> -VhostUserState *vhost_user_init(void)
> >> +bool vhost_user_init(VhostUserState *user, CharBackend *chr, Error **errp)
> >>  {
> >>      return NULL;
> >
> > It would be better to return false.
> >
> 
> Good catch, fixed.
> 
> Except that, would you give a reviewed-by?

Sorry, I missed something previously. In below diff:

diff --git a/net/vhost-user.c b/net/vhost-user.c
index a39f9c9974..5e5b8f3fc9 100644
--- a/net/vhost-user.c
+++ b/net/vhost-user.c
@@ -291,14 +291,14 @@ static int net_vhost_user_init(NetClientState *peer, const char *device,
 {
     Error *err = NULL;
     NetClientState *nc, *nc0 = NULL;
-    VhostUserState *user = NULL;
     NetVhostUserState *s = NULL;
+    VhostUserState *user;
     int i;
 
     assert(name);
     assert(queues > 0);
 
-    user = vhost_user_init();
+    user = g_new0(struct VhostUserState, 1);
     if (!user) {
         error_report("failed to init vhost_user");
         goto err;

It might be better to change the error message
to something like:

"failed to allocate vhost-user state".

Except that, it looks good to me and you can add
my reviewed-by.

Best regards,
Tiwei Bie

> 
> > Best regards,
> > Tiwei Bie
> >
> >>  }
> > [...]
> >
> 
> 
> 
> -- 
> Marc-André Lureau
