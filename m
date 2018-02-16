Received: from eggs.gnu.org ([2001:4830:134:3::10]:51533)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1emfrs-0000rx-OU
	for qemu-devel@nongnu.org; Fri, 16 Feb 2018 08:16:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1emfrp-0005LC-HV
	for qemu-devel@nongnu.org; Fri, 16 Feb 2018 08:16:00 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:40584 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1emfrp-0005Kt-Ct
	for qemu-devel@nongnu.org; Fri, 16 Feb 2018 08:15:57 -0500
Date: Fri, 16 Feb 2018 14:15:40 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20180216131540.ioudb6rwf4y6qnxq@sirius.home.kraxel.org>
References: <20180203171743.13612-1-programmingkidx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180203171743.13612-1-programmingkidx@gmail.com>
Subject: Re: [Qemu-devel] [PATCH v6] ui/cocoa.m: Add ability for user to
 specify mouse ungrab key
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Arbuckle <programmingkidx@gmail.com>
Cc: peter.maydell@linaro.org, qemu-devel@nongnu.org

On Sat, Feb 03, 2018 at 12:17:43PM -0500, John Arbuckle wrote:
> Currently the ungrab keys for the Cocoa and GTK interface are Control-Alt-g.
> This combination may not be very fun for the user to have to enter, so we
> now enable the user to specify their own key(s) as the ungrab key(s). The
> list of keys that can be used is found in the file qapi/ui.json under QKeyCode.
> The max number of keys that can be used is three.
> 
> Syntax: -display cocoa,hotkey-grab=<key-key-key>
> 
> Example usage:  -display cocoa,hotkey-grab=home
> 	        -display cocoa,hotkey-grab=shift-ctrl
> 		-display cocoa,hotkey-grab=ctrl-x
> 		-display cocoa,hotkey-grab=pgup-pgdn
> 		-display cocoa,hotkey-grab=kp_5-kp_6
> 		-display cocoa,hotkey-grab=kp_4-kp_5-kp_6
> 		-display cocoa,hotkey-grab=ctrl-alt

Finally found the time for a closer look and some testing.

Problem is the hotkeys are all forwarded to the guest.
So when using -- for example -- the pgup-pgdn hotkey
and you press the combination the guest will see it.

I see basically two options to deal with that:

(a) Make the code more clever.  On pgup keydown event
    the code has to figure this might be part of a hotkey
    sequence, hold back the event to see what comes next.
    - If the next event is pgup keyup -> ok, normal pgup
      keypress, forward both keydown and keyup to the guest.
    - If the next event is pgdn keydown -> hotkey found.
      So do hotkey action, don't forward keydown (and
      following keyup) events to the guest.

(b) Restrict allowed hotkeys to modifier key(s) plus one
    non-modifier key.  Forwarding modifier keydown+keyup
    to the guest has typically effects inside the guest,
    so we only have to hold back that single non-modifier
    key.  That is alot easier to implement.

cheers,
  Gerd
