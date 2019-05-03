Received: from eggs.gnu.org ([209.51.188.92]:45027)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1hMWz5-00019H-78
	for qemu-devel@nongnu.org; Fri, 03 May 2019 08:08:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1hMWz3-0003bR-Jr
	for qemu-devel@nongnu.org; Fri, 03 May 2019 08:08:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57514)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1hMWz2-0003a7-Il
	for qemu-devel@nongnu.org; Fri, 03 May 2019 08:08:08 -0400
Date: Fri, 3 May 2019 13:08:02 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20190503120802.GF17905@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <8C02D03E-96CD-414F-BC2C-C59972B26F94@kernelobjects.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8C02D03E-96CD-414F-BC2C-C59972B26F94@kernelobjects.org>
Subject: Re: [Qemu-devel] Request for comment - dynamic VNC keyboard mapping
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mario <ml@kernelobjects.org>
Cc: qemu-devel@nongnu.org

On Fri, May 03, 2019 at 01:47:15PM +0200, Mario wrote:
> Hi all,
> 
> I have a question related to the VNC server keyboard settings. Currently
> the user of qemu has to decide before VM startup which language is used
> for VNC keyboard mapping. If no keyboard is configured, the en-us keyboard
> will be loaded for keysym to scancode conversion. A later reconfiguration
> of the keyboard is not possible at present.

That isn't actually correct. In fact best practice is to *not* set and
"-k keymap" arg when launching QEMU.

Any kind of keysym to scancode conversion done by QEMU is inherantly
lossy and fragile as it requires a 100% matching keymap between QEMU
and the guest OS. QEMU keymaps are much better than the past, but
they're never going to be guaranteed to match what the guest OS is
using because they're potentialy using completely different data
sources.

By not setting "-k", you let the QEMU VNC server activate its keyboard
scancode VNC protocol extension. With this active, a compatible VNC
client will then send raw hardware scancodes to QEMU alongside keysyms.

QEMU will thus ignore the keysyms and send the scancodes straight to
the guest with no keymap conversion performed at all. 

With this working you can just dynamically change your guest OS keymap
as needed to match your VNC client machine's keyboard and QEMU stays
out of the way entirely. 

Obviously the important thing here is to have a VNC client that supports
this scancode extension. This was originally done in the GTK-VNC widget,
and thus virt-viewer, remote-viewer, vinagre, virt-manager, GNOME Boxes
all support this.  More recently the TigerVNC client app also supports
this, as does the in browser noVNC client.

> So here is my idea:
> 
> The VNC Display context stores a list of loaded keyboards (like
> vs->vd->kbds). If no keyboard was specified, at least the default
> will be added to the list ("en-us"?). If a client connects, a copy
> of the (latest configured) pointer will be stored within the
> VncState structure. For any keys sent by this client the own
> keyboard reference will be used.
> 
> As (in theory) every VNC client may have a differen keyboard layout,
> in my point of view it makes sense to attach the keyboard used for
> keysym2scancode() to the client context rather to the VNC server
> context. However as (most likely) all clients do have the same
> keyboard mapping it would be an overhead to parse and store the
> mapping list each time the client connects.
> 
> Now in my idea two mechanisms may change the behavior of the client
> keyboard.
> 
> 1.) a qmp command was sent, that sets /configures for a particular/
>     default keyboard.
> 2.) within the VNC protocol a "VNC_MSG_CLIENT_QEMU/
>     VNC_MSG_CLIENT_QEMU_EXT_KEYBOARD_LAYOUT" message arrives
> 
> If the new keyboard was not already loaded and stored inside
> vs->vd->kbds , qemu initializes the new mapping. The affected VNC
> client (VncState) again stores the reference only.
> 
> This enables switching the keyboard layout during runtime as well
> as using multiple different keyboard layouts at atime.
> 
> Together with a corresponding patch I would also add a patch for
> libvncclient to have a reference implmentation for the integrated
> keyboard layout switching.
> 
> What are your thoughts about this kind of improvement?

I don't think it is worth creating a new VNC protocol extension for this,
since any kind of keymap conversion done on the server is inherantly
lossy so can never be bug free. Since a new extension requires modifying
VNC clients regardless, it is better to just modify them to support the
raw scancode extension instead.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
