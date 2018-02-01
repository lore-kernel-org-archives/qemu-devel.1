Received: from eggs.gnu.org ([2001:4830:134:3::10]:34680)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eh9vJ-0006y8-BN
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 03:08:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eh9vE-0002xd-7s
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 03:08:45 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58558)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1eh9vD-0002x8-Vz
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 03:08:40 -0500
Date: Thu, 1 Feb 2018 09:08:37 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20180201080837.ym5nv57wnex45q52@sirius.home.kraxel.org>
References: <20180126214731.23506-1-programmingkidx@gmail.com>
	<20180130121823.7h4brwivh7653znu@sirius.home.kraxel.org>
	<F79229CE-D35E-4895-A632-4211A7C526D8@gmail.com>
	<20180131090310.e4jlhu7euyeompkh@sirius.home.kraxel.org>
	<655BB356-66E8-4AC4-8EC4-47E3E2DA6B36@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <655BB356-66E8-4AC4-8EC4-47E3E2DA6B36@gmail.com>
Subject: Re: [Qemu-devel] [PATCH v5] cocoa.m: Add ability for user to
 specify mouse ungrab key
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Programmingkid <programmingkidx@gmail.com>
Cc: peter.maydell@linaro.org, berrange@redhat.com, qemu-devel@nongnu.org

  Hi,

> > Well, the modifier key changes are actually sent to the guest, but
> > usually they have no effect there.
> > 
> > So, if you press Ctrl-Alt-F, the guest will see the keydown and keyup
> > events for ctrl and alt.  It will not see the 'f', because SDL hijacks
> > that.
> 
> Maybe the f could be sent to the guest directly via qemu_input_event_send_key_qcode().

Why?  If the user presses the ctrl-alt-f hotkey it expects qemu react on
it (and toggle fullscreen mode), so it the 'f' keydown is
*intentionally* not sent to the guest.  But the guest still can see the
modifier (ctrl and alt) key events.

> > Just pulled latest master and recompiled, still not working for me.
> > This is sierra in a vm.
> 
> What software do you use to run the VM? It could be possible the VM
> software is interfering with the ungrab keys.

qemu, with vnc and virt-viewer.  Ahem, right, the qemu vnc server reacts
on ctrl-alt-<nr> too, so that is probably the reason.  The joy of nested
virtualization ...

> >> Basically there is a array that acts as a check list. It checks off
> >> keys that belong to the ungrab sequence as they are detected. Once a
> >> non-ungrab key is detected, the check list is cleared. If all the
> >> ungrab keys are detected the ungrab code is executed. This only
> >> happens on keyup events. That way if Control-ALT were the ungrab keys,
> >> sending Control-ALT-Delete to the guest is still possible because
> >> these are the keys detected on the keyup event. The Delete key would
> >> have cleared the check list. Daniel Berrange is the one I can thank
> >> for this idea. He might be able to explain it better than me.
> > 
> > Hmm, ok.
> > 
> > Doing the same for gtk would basically imply to not use any toolkit
> > support for hotkeys ...
> > 
> > It'll also become more difficuilt if we use that for multiple hotkeys.
> > 
> > But possibly we can share the code across all UIs, now that keycodemapdb
> > is used by qemu.  So first translate the keycode from the UI toolkit to
> > a QKeyCode, then feed that into shared hotkey detection code.
> 
> Sounds like a good idea. I will be more than happy to help. My cocoa code
> uses sets to implement keeping track of key presses. A set is a collection of data 
> that only allows for unique values. So no two items in a set can be the same
> value. My patch uses cocoa's NSSet so the shared code would probably not be
> able to use it. I don't currently know of an implementation of a set that is
> in C and available for us to use, so we may have to implement it ourselves. 

Yes, probably.  Using cocoa (or objc) features for shared code isn't
going to work.  Also I'm not sure a set is a good coice here, it looses
the ordering of the keydown events.  Which doesn't matter in case the
hotkey is pressed, but in case it turns out it wasn't the hotkey and we
have to forward the recorded events to the guest we should not re-order
them.

cheers,
  Gerd
