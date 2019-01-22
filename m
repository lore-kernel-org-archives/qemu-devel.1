Received: from eggs.gnu.org ([209.51.188.92]:53197)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1glrvP-0000s7-Pp
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 04:00:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1glrvM-0004EK-0I
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 04:00:51 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43241)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1glrvK-000481-1g
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 04:00:47 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 8DE7313985D
	for <qemu-devel@nongnu.org>; Tue, 22 Jan 2019 09:00:39 +0000 (UTC)
Date: Tue, 22 Jan 2019 10:00:36 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20190122090036.p7hfsgezzokpovlh@sirius.home.kraxel.org>
References: <20181219120904.17643-1-kraxel@redhat.com>
	<20181219120904.17643-6-kraxel@redhat.com>
	<20181221111801.GI7439@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181221111801.GI7439@redhat.com>
Subject: Re: [Qemu-devel] [RFC PATCH v2 5/7] kbd-state: use state tracker
 for vnc
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org

> > @@ -1859,30 +1828,25 @@ static void do_key_event(VncState *vs, int down, int keycode, int sym)
> >             toggles capslock away from the VNC window.
> >          */
> >          int uppercase = !!(sym >= 'A' && sym <= 'Z');
> > -        int shift = !!(vs->modifiers_state[0x2a] | vs->modifiers_state[0x36]);
> > -        int capslock = !!(vs->modifiers_state[0x3a]);
> > +        bool shift = kbd_state_modifier_get(vs->vd->kbd, KBD_MOD_SHIFT);
> > +        bool capslock = kbd_state_modifier_get(vs->vd->kbd, KBD_MOD_CAPSLOCK);
> 
> This uses the modifier state
> 
> In old code it would use the newly updated modifier state
> 
> In new code it now uses the old modifier state.

Ordering doesn't matter.  This code doesn't run on modifier key events.
On letter keydown events it checks whenever shift and capslock state are
consistent, and if not it generates a capslock keypress.

cheers,
  Gerd
