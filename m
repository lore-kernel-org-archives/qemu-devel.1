Received: from eggs.gnu.org ([2001:4830:134:3::10]:50579)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eFgdg-0003I2-GS
	for qemu-devel@nongnu.org; Fri, 17 Nov 2017 08:25:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eFgdc-000434-F3
	for qemu-devel@nongnu.org; Fri, 17 Nov 2017 08:25:00 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49696)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1eFgdc-00041U-8A
	for qemu-devel@nongnu.org; Fri, 17 Nov 2017 08:24:56 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 78C7C6A7DC
	for <qemu-devel@nongnu.org>; Fri, 17 Nov 2017 13:24:55 +0000 (UTC)
Date: Fri, 17 Nov 2017 14:24:54 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20171117132454.33pngiqu7vcdbmm5@sirius.home.kraxel.org>
References: <20171117103046.15943-1-kraxel@redhat.com>
	<20171117103046.15943-20-kraxel@redhat.com>
	<20171117125535.dhyvy5qwnh6d6e7d@starbug-vm.ie.oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171117125535.dhyvy5qwnh6d6e7d@starbug-vm.ie.oracle.com>
Subject: Re: [Qemu-devel] [PATCH 19/24] console: add and use
 qemu_display_find_default
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>

  Hi,

> > -        dpy.type = DISPLAY_TYPE_NONE;
> > +        if (!qemu_display_find_default(&dpy)) {
> > +            dpy.type = DISPLAY_TYPE_NONE;
> > +#if defined(CONFIG_VNC)
> > +            vnc_parse("localhost:0,to=99,id=default", &error_abort);
> > #endif
> 
> Mostly some questions on this:
> 
> - I'm curious, why is VNC not just one of the ones searched for in
>  qemu_display_find_default()?

vnc is a bit different.  It's a remote display protocol, not a (local)
user interface.  There is no DISPLAY_TYPE_VNC for that reason (without
this series too).  And IMO it was a bad idea to add -display vnc=$config
(same as -vnc $config) in the first place.

There can be only one user interface instance, i.e. you can't have gtk
and sdl at the same time.  With vnc (and spice) that works though, i.e.
you can start qemu with some local user interface and enable vnc or
spice (even both) remote access at the same time.

> - What if there is another display type added? Would it be added to
>  qemu_display_find_default() or in this if statement?

qemu_display_find_default() most likely,
but depends on what exactly it is.

> - Is there a reason that VNC doesn't follow the same registration
>  mechanism you're proposing here (as in you've no changes to that
>  module in this patch set).

See above ;)

> - In the spirit of encapsulation, would it not make sense for the
>  vnc_parse() to be in the VNC code itself as a fall back if no
>  specific options are given to the -vnc option?

It's not that simple.  The default vnc server is started only in case
no (graphical) local user interface is available, so it's not something
the vnc code can figure purely on its own.

cheers,
  Gerd
