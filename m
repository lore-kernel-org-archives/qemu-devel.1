Received: from eggs.gnu.org ([2001:4830:134:3::10]:46741)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fn30m-0001Kw-FY
	for qemu-devel@nongnu.org; Tue, 07 Aug 2018 10:31:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fn30j-0007VL-Rd
	for qemu-devel@nongnu.org; Tue, 07 Aug 2018 10:31:00 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:35412 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1fn30j-0007VF-Ms
	for qemu-devel@nongnu.org; Tue, 07 Aug 2018 10:30:57 -0400
Date: Tue, 7 Aug 2018 16:30:55 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20180807143055.pkx7l2ufb36lyq3b@sirius.home.kraxel.org>
References: <20180803173614.12358-1-marcandre.lureau@redhat.com>
	<20180803173614.12358-11-marcandre.lureau@redhat.com>
	<20180807101505.GF7335@redhat.com>
	<CAJ+F1C+=aucconH7EZ8D2g_Wir2wEeq4GMobK+jNPZ8b0LbZKA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJ+F1C+=aucconH7EZ8D2g_Wir2wEeq4GMobK+jNPZ8b0LbZKA@mail.gmail.com>
Subject: Re: [Qemu-devel] [PATCH 10/10] display: add -display app launching
 external application
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>
Cc: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, QEMU <qemu-devel@nongnu.org>, Markus Armbruster <armbru@redhat.com>

  Hi,

> > spice arguments over time.  So if we want auto-launching of a remote app,
> > I think it is preferrable to do it via extra args to the existing
> > "-display spice" format. eg we could add a "client=yes|no" to control
> > launching the client
> >
> >    -display spice,client=yes
> 
> There is no -display spice, atm.
> 
> However there is a -display vnc.

That should not be there.  Now that we have a deprecation process
I should probably actually deprecate it in favor of -vnc.

> It's a bit unclear to me the relation between -display and
> -vnc/-spice/-curses etc. In the end, I tend to think of -display foo
> as a shortcut for a longer -foo configuration.

-display is for builtin UIs.  You can have exactly one of these.

-spice and -vnc is for remote protocols.  They can be used together with
builtin UIs (even though that isn't a typical use case).  Configuring
both spice and vnc works too.

-sdl and -curses are shortcuts for -display sdl and -display curses.

> So -display spice,client=yes is a reasonable proposal to me, making it
> clear that it will run spice. (client=yes is less clear to me but
> fine)

Hmm, this will both configure some standard stuff and start an external
application.  Doesn't really fit with "-spice ...".

Adding "-display remote-client" doesn't really fit either.  But still
looks better to me.  Or we just create a new -remote-client top level
switch.  Adding higher-level config options (protocol=spice/vnc,
monitor=on/off, serial=on/off, ...) is less confusing then (especially
vnc support :) ), compared to have a bunch of more -spice options which
only have an effect with client=yes.

Also:  remote-viewer accepts config files.  I'd suggest to write one, so
it is easy to restart remote-viewer.  Also I would not use a temp dir
for the files and sockets, but some fixed location.
/run/user/$uid/qemu/$vmname for example (where $vmname is whatever you
passed to qemu using -name).

cheers,
  Gerd
