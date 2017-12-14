Received: from eggs.gnu.org ([2001:4830:134:3::10]:59640)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1ePQja-0006LH-20
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 05:27:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1ePQjW-0008JP-Ps
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 05:27:22 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39434)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1ePQjW-0008I7-GC
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 05:27:18 -0500
Date: Thu, 14 Dec 2017 10:27:13 +0000
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20171214102713.GA7572@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20B182CA-4FA6-444D-87B1-46B04FFC81AE@gmail.com>
	<20171212143421.GD26971@redhat.com>
	<11216FAC-3F62-43AF-ACD8-00F28B7AD886@gmail.com>
	<20171213091458.GA28379@redhat.com>
	<7D487247-C5DA-4902-A21E-B16861F763C8@gmail.com>
	<alpine.BSF.2.21.1712131914560.26243@zero.eik.bme.hu>
	<99BD2069-929C-402A-B38A-778DAB427449@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <99BD2069-929C-402A-B38A-778DAB427449@gmail.com>
Subject: Re: [Qemu-devel] Adding more function keys support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Programmingkid <programmingkidx@gmail.com>
Cc: BALATON Zoltan <balaton@eik.bme.hu>, QEMU Developers <qemu-devel@nongnu.org>

On Wed, Dec 13, 2017 at 02:18:49PM -0500, Programmingkid wrote:
> 
> > On Dec 13, 2017, at 1:22 PM, BALATON Zoltan <balaton@eik.bme.hu> wrote:
> > 
> > On Wed, 13 Dec 2017, Programmingkid wrote:
> >>> On Dec 13, 2017, at 4:14 AM, Daniel P. Berrange <berrange@redhat.com> wrote:
> >>> 
> >>> On Tue, Dec 12, 2017 at 12:49:34PM -0500, Programmingkid wrote:
> >>>> 
> >>>>> On Dec 12, 2017, at 9:34 AM, Daniel P. Berrange <berrange@redhat.com> wrote:
> >>>>> 
> >>>>> On Sun, Dec 10, 2017 at 02:10:41AM -0500, Programmingkid wrote:
> >>>>>> On Macintosh keyboards there is a key called fn that is used to give the
> >>>>>> function keys more functionality. Does this key exist in the keyboard keys
> >>>>>> database?
> >>>>> 
> >>>>> When you say "Macintosh keyboards" are you talking about the old style
> >>>>> keyboards with Apple's custom ADB connector, or simply Apple branded
> >>>>> USB keyboards ?
> >>>> 
> >>>> USB keyboards.
> >>>> 
> >>>>> 
> >>>>> If its the latter (USB), then please plug it into a Linux machine, and
> >>>>> in a text console (ie not X11) run 'showkey' and press this 'fn' key on
> >>>>> its own and tell me what (if any) hex code gets printed.
> >>>> 
> >>>> There was no response to the fn key.
> >>> 
> >>> Doh, I made a mistake - you need to run   'showkey -s'  to get raw scancodes.
> >>> Can you try this again, pressing 'fn' on its own, and also press 'fn' in
> >>> combination with some function keys.
> >> 
> >> Sorry but showkey still did not register the fn key being pushed.
> > 
> > I don't know how the fn key is handled but the Linux driver knows about it so maybe it could help to understand:
> > 
> > https://github.com/torvalds/linux/blob/master/drivers/hid/hid-apple.c

> I think the input_event() function is what sends key input to the applications. It appears that the function key is not sent to input_event().

Linux works by turning the keyboard specific scancodes into a standardized
set of key codes that are agnostic of any hardware. Thus Linux doesn't
send the 'fn' key itself. It sees the 'fn'+XXX key combination and sends
a single event. You can see the mapping Linux uses:

static const struct apple_key_translation macbookair_fn_keys[] = {
	{ KEY_BACKSPACE, KEY_DELETE },
	{ KEY_ENTER,	KEY_INSERT },
	{ KEY_F1,	KEY_BRIGHTNESSDOWN, APPLE_FLAG_FKEY },
	{ KEY_F2,	KEY_BRIGHTNESSUP,   APPLE_FLAG_FKEY },
	{ KEY_F3,	KEY_SCALE,          APPLE_FLAG_FKEY },
	{ KEY_F4,	KEY_DASHBOARD,      APPLE_FLAG_FKEY },
	{ KEY_F6,	KEY_PREVIOUSSONG,   APPLE_FLAG_FKEY },
	{ KEY_F7,	KEY_PLAYPAUSE,      APPLE_FLAG_FKEY },
	{ KEY_F8,	KEY_NEXTSONG,       APPLE_FLAG_FKEY },
	{ KEY_F9,	KEY_MUTE,           APPLE_FLAG_FKEY },
	{ KEY_F10,	KEY_VOLUMEDOWN,     APPLE_FLAG_FKEY },
	{ KEY_F11,	KEY_VOLUMEUP,       APPLE_FLAG_FKEY },
	{ KEY_F12,	KEY_EJECTCD,        APPLE_FLAG_FKEY },
	{ KEY_UP,	KEY_PAGEUP },
	{ KEY_DOWN,	KEY_PAGEDOWN },
	{ KEY_LEFT,	KEY_HOME },
	{ KEY_RIGHT,	KEY_END },
	{ }
};

static const struct apple_key_translation apple_fn_keys[] = {
	{ KEY_BACKSPACE, KEY_DELETE },
	{ KEY_ENTER,	KEY_INSERT },
	{ KEY_F1,	KEY_BRIGHTNESSDOWN, APPLE_FLAG_FKEY },
	{ KEY_F2,	KEY_BRIGHTNESSUP,   APPLE_FLAG_FKEY },
	{ KEY_F3,	KEY_SCALE,          APPLE_FLAG_FKEY },
	{ KEY_F4,	KEY_DASHBOARD,      APPLE_FLAG_FKEY },
	{ KEY_F5,	KEY_KBDILLUMDOWN,   APPLE_FLAG_FKEY },
	{ KEY_F6,	KEY_KBDILLUMUP,     APPLE_FLAG_FKEY },
	{ KEY_F7,	KEY_PREVIOUSSONG,   APPLE_FLAG_FKEY },
	{ KEY_F8,	KEY_PLAYPAUSE,      APPLE_FLAG_FKEY },
	{ KEY_F9,	KEY_NEXTSONG,       APPLE_FLAG_FKEY },
	{ KEY_F10,	KEY_MUTE,           APPLE_FLAG_FKEY },
	{ KEY_F11,	KEY_VOLUMEDOWN,     APPLE_FLAG_FKEY },
	{ KEY_F12,	KEY_VOLUMEUP,       APPLE_FLAG_FKEY },
	{ KEY_UP,	KEY_PAGEUP },
	{ KEY_DOWN,	KEY_PAGEDOWN },
	{ KEY_LEFT,	KEY_HOME },
	{ KEY_RIGHT,	KEY_END },
	{ }
};

static const struct apple_key_translation powerbook_fn_keys[] = {
	{ KEY_BACKSPACE, KEY_DELETE },
	{ KEY_F1,	KEY_BRIGHTNESSDOWN,     APPLE_FLAG_FKEY },
	{ KEY_F2,	KEY_BRIGHTNESSUP,       APPLE_FLAG_FKEY },
	{ KEY_F3,	KEY_MUTE,               APPLE_FLAG_FKEY },
	{ KEY_F4,	KEY_VOLUMEDOWN,         APPLE_FLAG_FKEY },
	{ KEY_F5,	KEY_VOLUMEUP,           APPLE_FLAG_FKEY },
	{ KEY_F6,	KEY_NUMLOCK,            APPLE_FLAG_FKEY },
	{ KEY_F7,	KEY_SWITCHVIDEOMODE,    APPLE_FLAG_FKEY },
	{ KEY_F8,	KEY_KBDILLUMTOGGLE,     APPLE_FLAG_FKEY },
	{ KEY_F9,	KEY_KBDILLUMDOWN,       APPLE_FLAG_FKEY },
	{ KEY_F10,	KEY_KBDILLUMUP,         APPLE_FLAG_FKEY },
	{ KEY_UP,	KEY_PAGEUP },
	{ KEY_DOWN,	KEY_PAGEDOWN },
	{ KEY_LEFT,	KEY_HOME },
	{ KEY_RIGHT,	KEY_END },
	{ }
};

The first column in these tables is the physical key pressed, and the
second column is what Linux sends with the 'fn' key is combined.

IOW,  'fn'+'f1' results in 'brightnessdown'

QEMU will work in a similar way - we're not going to send around the 'fn'
key internally to QEMU, instead we'll only send the combination keys.
IOW, we'll need to make sure QEMU has keycodes defined for everything in
the second columns of these tables.

> This key is usable with QEMU on Mac OS X. The NSEventTypeFlagsChanged event
> is what detects it in the cocoa.m file. Currently the code does not account
> for this key. I will make a patch to add support for the function key soon.

So if Cocoa can see the 'fn' key, then it'll need todo similar to what
Linux does - comibing the 'fn' key and keystroke that follows, into a
single QEMU keycode.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
