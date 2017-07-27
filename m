Received: from eggs.gnu.org ([2001:4830:134:3::10]:56590)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dafRO-0007CK-6X
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 05:50:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dafRK-0003xw-W8
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 05:50:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53250)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1dafRK-0003wI-Eh
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 05:50:42 -0400
Date: Thu, 27 Jul 2017 10:50:33 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170727095033.GD2555@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20170724164601.21063-1-berrange@redhat.com>
	<88f8a661-f832-1d03-2736-d7b35c920e32@reactos.org>
	<20170725083251.GB26394@redhat.com>
	<1500983620.29790.3.camel@redhat.com>
	<20170726112826.GE7620@redhat.com>
	<1501069447.29903.4.camel@redhat.com>
	<20170726120529.GG7620@redhat.com>
	<1501072390.29903.6.camel@redhat.com>
	<20170726124551.GK7620@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170726124551.GK7620@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for 2.10] ps2: fix sending of PAUSE/BREAK
 scancodes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: =?utf-8?B?SGVydsOp?= Poussineau <hpoussin@reactos.org>, qemu-devel@nongnu.org

On Wed, Jul 26, 2017 at 01:45:51PM +0100, Daniel P. Berrange wrote:
> On Wed, Jul 26, 2017 at 02:33:10PM +0200, Gerd Hoffmann wrote:
> >   Hi,
> > 
> > > FYI, after adding qcodes to the keycodemapdb, (but not having picked
> > > your branch),
> > 
> > I don't think this is a good idea.  qkeycode numbers are a qemu-private 
> > thing, they can (and did in the past) change.  The names are api and
> > must not change.
> 
> Sorry, yes, I meant only adding the names  - libvirt needs to know the
> qcode names and what they map to in other key maps, to use the send-key
> command. 
> 
> > > I was actually just going add an entry for QKeyCode names to the
> > > keycodemapdb, so we can convert straight to that, and also let
> > > us auto-generate the qemu_input_linux_to_qcode() table.
> > 
> > Ok, with the names it should work.
> > 
> > > Strangely there is no Linux key code defined for AltGr, so if we
> > > map via Linux key codes, we would loose ability to send AltGr
> > 
> > KEY_RIGHTALT?
> 
> It seems KEY_RIGHTALT is different from AltGr - it maps to AT set 1
> extended scancode 0xe0 0x38, where as AltGr generates 0x64 on my
> keyboard

Opps, no I was mis-interpreting the evdev output.

Physical key AltGr *does* produce  KEY_RIGHTALT, Linux keycode 100,
AT set1 scan code 0xe0 0x38, QEMU qcode alt_r, QEMU scancode 0xb8


What is confusing is that QEMU defines qcodes for alt, alt_r *and*
altgr and altgr_r.


QEMU's  altgr scancode is 0x64 (qcode_to_number). The only Linux
keycode that produces that AT set1 scancode is KEY_OPEN. There is
no mapping in qcode_to_keycode_set1 for this, which is odd given
that the set1 mapping should be the same as qcode_to_number mapping
except different high bit handling. There is a mapping in
qcode_to_keycode_set2 which corresponds to 0x08 and afaik that
should not exist as there's no set2 scancode 0x08


QEMU's  altgr_r scan code is 0xe4 (qcode_to_number), which is equiv
to at set1 0xe0 0x64, and that should not exist afaik. There is
no mapping in qcode_to_keycode_set1, which is again odd given that
this should be the same as qcode_to_number.  There is a mapping
in qcode_to_keycode_set2 which corresponds to 0xe0 0x08 and afaik
that's not defined for set2 scancode.


So afaict, the altgr & altgr_r  qcodes are just broken and should
not even exist.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
