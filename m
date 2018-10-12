Received: from eggs.gnu.org ([2001:4830:134:3::10]:57465)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gAvGf-0004KA-My
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 07:06:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gAvGc-00045D-Gh
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 07:06:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53630)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1gAvGc-00044P-8U
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 07:06:02 -0400
Date: Fri, 12 Oct 2018 13:05:58 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20181012110558.dwy3id7voutvnkxk@sirius.home.kraxel.org>
References: <20181009131052.18500-1-lhrazky@redhat.com>
	<20181011134336.w55g5ts6kln6cgtt@sirius.home.kraxel.org>
	<1539268208.16655.144.camel@redhat.com>
	<20181011150944.5qfaflgkcekdlz3o@sirius.home.kraxel.org>
	<1539272266.16655.154.camel@redhat.com>
	<20181012092700.np256rvz6octswia@sirius.home.kraxel.org>
	<2078529305.33241973.1539339318932.JavaMail.zimbra@redhat.com>
	<20181012104222.vzwu73lanjbelnbl@sirius.home.kraxel.org>
	<1782383806.33244849.1539341197428.JavaMail.zimbra@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1782383806.33244849.1539341197428.JavaMail.zimbra@redhat.com>
Subject: Re: [Qemu-devel] [Spice-devel] [RFC PATCH spice 1/2] QXL interface:
 add functions to identify monitors in the guest
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Frediano Ziglio <fziglio@redhat.com>
Cc: spice-devel@lists.freedesktop.org, =?utf-8?B?THVrw6HFoSBIcsOhemvDvQ==?= <lhrazky@redhat.com>, qemu-devel@nongnu.org

On Fri, Oct 12, 2018 at 06:46:37AM -0400, Frediano Ziglio wrote:
> > 
> > Hi,
> > 
> > > > When using qemu_console_get_head() it doesn't work correctly, it would
> > > > use the qxl card's data.  It would work if spice-server would filter the
> > > > list to only include the entries for the given display channel before
> > > > calling the ->client_monitors_config() callback.  But it doesn't, we get
> > > > the complete set.
> > > 
> > > That's why I said is a bug, IMHO it should.
> > 
> > Hmm, this should be easily detectable on qemu side I think.  If
> > num_of_monitors (for a non-qxl card) is > 1, then we have an old,
> > non-filtering spice-server.  If num_of_monitors == 1, then it is a new,
> > filtering spice-server.  Or a single-head channel configuration, in
> > which case it doesn't matter whenever it filters or not.
> > 
> > So this should be fixable without causing too much compatibility pain.
> > 
> > cheers,
> >   Gerd
> > 
> 
> Sorry, why fixing in Qemu is the bug is in spice-server?
> I really don't follow your reasoning.

I had a thinko in one of the previous messages.
qemu_console_get_head() is never correct, so qemu is buggy too.

It should be either qemu_console_get_index() (equals channel id), for
the non-filtering case, or just 0, for the filtering case, because every
virtio-gpu head has its own display channel.  Patch below.

> For me Qemu should not change at all and spice-server should
> do the filtering. Is this not fixing everything?

Well, fixed qemu being able to deal with all spice-server versions
(fixed and unifixed) is certainly useful to reduce the damage caused
by this incompatible change.

The qxl version of that callback can stay as-is, the spice-server side
fix should make sure the current code continues to work when we start
supporting new configurations (qxl and non-qxl devices mixed).

cheers,
  Gerd

diff --git a/ui/spice-display.c b/ui/spice-display.c
index 2f8adb6b9f..52f8cb5ae1 100644
--- a/ui/spice-display.c
+++ b/ui/spice-display.c
@@ -674,10 +674,28 @@ static int
interface_client_monitors_config(QXLInstance *sin,
 
     memset(&info, 0, sizeof(info));
 
-    head = qemu_console_get_head(ssd->dcl.con);
-    if (mc->num_of_monitors > head) {
-        info.width  = mc->monitors[head].width;
-        info.height = mc->monitors[head].height;
+    if (mc->num_of_monitors == 1) {
+        /*
+         * New spice-server version which filters the list of monitors
+         * to only include those that belong to our display channel.
+         *
+         * single-head configuration (where filtering doesn't matter)
+         * takes this code path too.
+         */
+        info.width  = mc->monitors[0].width;
+        info.height = mc->monitors[0].height;
+    } else {
+        /*
+         * Old spice-server which gives us all monitors, so we have to
+         * figure ourself which entry we need.  Array index is the
+         * channel_id, which is the qemu console index, see
+         * qemu_spice_add_display_interface().
+         */
+        head = qemu_console_get_index(ssd->dcl.con);
+        if (mc->num_of_monitors > head) {
+            info.width  = mc->monitors[head].width;
+            info.height = mc->monitors[head].height;
+        }
     }
 
     trace_qemu_spice_ui_info(ssd->qxl.id, info.width, info.height);
