Received: from eggs.gnu.org ([2001:4830:134:3::10]:41596)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fQsEK-0006l9-00
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 06:33:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fQsEI-0005oS-QS
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 06:33:19 -0400
Date: Thu, 7 Jun 2018 11:33:07 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180607103307.GI28827@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20180603203412.11033-1-contrib@steffen-goertz.de>
	<20180604092008.GA13674@stefanha-x1.localdomain>
	<CAFEAcA9kdvxa61HNxv-cDhcv07E_NUpwVcSJVYNw4weS3k7nUw@mail.gmail.com>
	<20180604101221.nhvjum467ier3txx@sirius.home.kraxel.org>
	<20180607102455.GD19032@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180607102455.GD19032@stefanha-x1.localdomain>
Subject: Re: [Qemu-devel] [RFC v3] qapi: command category to stimulate
 high-level machine devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Jim Mussared <jim@groklearning.com>, Steffen =?utf-8?B?R8O2cnR6?= <contrib@steffen-goertz.de>, QEMU Developers <qemu-devel@nongnu.org>, Markus Armbruster <armbru@redhat.com>, "open list:ARM" <qemu-arm@nongnu.org>, Joel Stanley <joel@jms.id.au>, Julia Suvorova <jusual@mail.ru>

On Thu, Jun 07, 2018 at 11:24:55AM +0100, Stefan Hajnoczi wrote:
> On Mon, Jun 04, 2018 at 12:12:21PM +0200, Gerd Hoffmann wrote:
> > On Mon, Jun 04, 2018 at 10:29:40AM +0100, Peter Maydell wrote:
> > > On 4 June 2018 at 10:20, Stefan Hajnoczi <stefanha@gmail.com> wrote:
> > > > Many of these inputs/outputs can be tied to an external UI.  A degree of
> > > > timing precision is required so that the UI is responsive, although
> > > > cycle-accurate timing is not what I'd expect from QMP.
> > > 
> > > Would we also be able to tie them to an internal UI, ie
> > > something that appears as another view in the GTK/etc
> > > UI frontends we have?
> > 
> > Should be doable too.  Basically a display device, which isn't a *real*
> > display but the UI.  Could show a rendering of the board, simliar to how
> > web emulation environments are doing it.  LED status could be rendered
> > directly to the board.  A virtual mouse could map mouse clicks to button
> > presses.
> > 
> > Doing more complex input that way (say a slider for the temperature
> > sensor) isn't going to work very well though ...
> > 
> > Sensor input in general is pretty much unsupported in qemu.
> 
> For the micro:bit we've been thinking of a WebSocket monitor interface.
> This way a web UI can work with both local and remote QEMU instances.
> 
> For security reasons, the WebSocket cannot be the regular QMP monitor.

FWIW, add ability to use websockets protocol over chardevs is fairly
easy. We already have a QIOChannelWebsock for the VNC server, so it
is just a little work to wire it into the chardev.

If the -monitor / -qmp arg took a filename containing a whitelist of
allowed monitor commands, you could indeed use the regular QMP monitor
instead of writing something new.

> A slimmed down monitor is required with a subset of QMP commands and
> events.  For example, users must not be able to migrate to an exec:
> destination so we need to ban that command on the UI monitor :-).

FWIW, you could  use the "-sandbox spawn=off,elevateprivileges=off"
arg to prevent ability of QEMU to fork/exec/setuid. Even if the
monitor still allows it, it thus get blocked, albeit by immediately
terminating the process.

> Pros:
>  + Remote control is possible over sockets
>    (Important for hosting QEMU on a server.  Nowadays this is becoming a
>    popular way to deliver emulation to users.  They don't need to
>    install software locally.)
>  + UI is cleanly isolated from QEMU process
> Cons:
>  - Binary or high-frequency I/O is a bad fit for a JSON WebSocket
>    interface
> 
> I prefer the WebSocket route over creating a fake display that will not
> be able to implement complex widgets well.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
