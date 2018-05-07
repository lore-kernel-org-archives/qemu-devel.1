Received: from eggs.gnu.org ([2001:4830:134:3::10]:53227)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <geoff@hostfission.com>) id 1fFfTf-0003QG-6t
	for qemu-devel@nongnu.org; Mon, 07 May 2018 08:42:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <geoff@hostfission.com>) id 1fFfTc-0005CU-3x
	for qemu-devel@nongnu.org; Mon, 07 May 2018 08:42:51 -0400
Received: from mail1.hostfission.com ([139.99.139.48]:49986)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <geoff@hostfission.com>) id 1fFfTb-0005C9-OV
	for qemu-devel@nongnu.org; Mon, 07 May 2018 08:42:48 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Mon, 07 May 2018 22:42:46 +1000
From: geoff@hostfission.com
In-Reply-To: <20180507124108.4dit55yrviaw7foy@sirius.home.kraxel.org>
References: <fe730863e2af01b68c7086f2f1f74220@hostfission.com>
	<20180507122147.vvz4drashaxdoo7j@sirius.home.kraxel.org>
	<38223099073c815a806f66b124b58192@hostfission.com>
	<20180507124108.4dit55yrviaw7foy@sirius.home.kraxel.org>
Message-ID: <a3f6513551c0944bd94cbd5387e3a69e@hostfission.com>
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
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org

On 2018-05-07 22:41, Gerd Hoffmann wrote:
> On Mon, May 07, 2018 at 10:26:24PM +1000, geoff--- via Qemu-devel 
> wrote:
>> On 2018-05-07 22:21, Gerd Hoffmann wrote:
>> > On Mon, May 07, 2018 at 10:00:22PM +1000, geoff--- via Qemu-devel wrote:
>> > > This allows guest's to correctly reinitialize and identify the mouse
>> > > should the guest decide to re-scan or reset during mouse input events.
>> > >
>> > > Signed-off-by: Geoffrey McRae <geoff@hostfission.com>
>> > > ---
>> > >  hw/input/ps2.c | 4 ++++
>> > >  1 file changed, 4 insertions(+)
>> > >
>> > > diff --git a/hw/input/ps2.c b/hw/input/ps2.c
>> > > index 06f5d2ac4a..6edf046820 100644
>> > > --- a/hw/input/ps2.c
>> > > +++ b/hw/input/ps2.c
>> > > @@ -673,6 +673,9 @@ static void ps2_mouse_sync(DeviceState *dev)
>> > >  {
>> > >      PS2MouseState *s = (PS2MouseState *)dev;
>> > >
>> > > +    if (!(s->mouse_status & MOUSE_STATUS_ENABLED))
>> > > +        return;
>> > > +
>> >
>> > Why this is needed?
>> 
>> To quote: 
>> https://wiki.osdev.org/%228042%22_PS/2_Controller#Detecting_PS.2F2_Device_Types
>> 
>> The device should respond to the "identify" command by sending a 
>> sequence of
>> none, one or two identification bytes. However, if you just send the
>> "identify" command you can't prevent the response from the "identify"
>> command from being mixed up with keyboard/mouse data. To fix this 
>> problem,
>> you need to send the "disable scanning" command first. Disabling 
>> scanning
>> means that the device ignores the user (e.g. keyboards ignore 
>> keypresses,
>> mice ignore mouse movement and button presses, etc) and won't send 
>> data to
>> mess your device identification code up.
> 
> Ok.  Same check should be added to ps2_keyboard_event() then I guess?

Quite correct, I will include this in the next patch set.

> 
> cheers,
>   Gerd
