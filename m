Received: from eggs.gnu.org ([2001:4830:134:3::10]:52826)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fFfSC-0002fh-N6
	for qemu-devel@nongnu.org; Mon, 07 May 2018 08:41:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fFfS9-0004Au-IT
	for qemu-devel@nongnu.org; Mon, 07 May 2018 08:41:20 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:55284 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1fFfS9-0004AR-DT
	for qemu-devel@nongnu.org; Mon, 07 May 2018 08:41:17 -0400
Date: Mon, 7 May 2018 14:41:08 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20180507124108.4dit55yrviaw7foy@sirius.home.kraxel.org>
References: <fe730863e2af01b68c7086f2f1f74220@hostfission.com>
	<20180507122147.vvz4drashaxdoo7j@sirius.home.kraxel.org>
	<38223099073c815a806f66b124b58192@hostfission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <38223099073c815a806f66b124b58192@hostfission.com>
Subject: Re: [Qemu-devel] [PATCH 1/2] ps2: Clear the queue on PS/2 mouse
 reset and obey device disable
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: geoff@hostfission.com
Cc: qemu-devel@nongnu.org

On Mon, May 07, 2018 at 10:26:24PM +1000, geoff--- via Qemu-devel wrote:
> On 2018-05-07 22:21, Gerd Hoffmann wrote:
> > On Mon, May 07, 2018 at 10:00:22PM +1000, geoff--- via Qemu-devel wrote:
> > > This allows guest's to correctly reinitialize and identify the mouse
> > > should the guest decide to re-scan or reset during mouse input events.
> > > 
> > > Signed-off-by: Geoffrey McRae <geoff@hostfission.com>
> > > ---
> > >  hw/input/ps2.c | 4 ++++
> > >  1 file changed, 4 insertions(+)
> > > 
> > > diff --git a/hw/input/ps2.c b/hw/input/ps2.c
> > > index 06f5d2ac4a..6edf046820 100644
> > > --- a/hw/input/ps2.c
> > > +++ b/hw/input/ps2.c
> > > @@ -673,6 +673,9 @@ static void ps2_mouse_sync(DeviceState *dev)
> > >  {
> > >      PS2MouseState *s = (PS2MouseState *)dev;
> > > 
> > > +    if (!(s->mouse_status & MOUSE_STATUS_ENABLED))
> > > +        return;
> > > +
> > 
> > Why this is needed?
> 
> To quote: https://wiki.osdev.org/%228042%22_PS/2_Controller#Detecting_PS.2F2_Device_Types
> 
> The device should respond to the "identify" command by sending a sequence of
> none, one or two identification bytes. However, if you just send the
> "identify" command you can't prevent the response from the "identify"
> command from being mixed up with keyboard/mouse data. To fix this problem,
> you need to send the "disable scanning" command first. Disabling scanning
> means that the device ignores the user (e.g. keyboards ignore keypresses,
> mice ignore mouse movement and button presses, etc) and won't send data to
> mess your device identification code up.

Ok.  Same check should be added to ps2_keyboard_event() then I guess?

cheers,
  Gerd
