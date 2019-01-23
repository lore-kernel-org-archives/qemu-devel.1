Received: from eggs.gnu.org ([209.51.188.92]:46537)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gmJkb-0005Y3-Og
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 09:43:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gmJka-0006d5-2Z
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 09:43:33 -0500
Date: Wed, 23 Jan 2019 14:43:20 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20190123144320.GJ27270@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20181221234750.23577-1-mreitz@redhat.com>
	<20181221234750.23577-4-mreitz@redhat.com>
	<84e62d4a-bf74-ba1c-d802-e01de14d693c@redhat.com>
	<3bf30595-c8fc-9058-3860-c4640718b33d@redhat.com>
	<c63ab4a5-7e28-2a21-c16e-a114a6ce7358@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c63ab4a5-7e28-2a21-c16e-a114a6ce7358@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 3/3] iotests: Allow 147 to be run
 concurrently
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org

On Wed, Jan 23, 2019 at 08:33:41AM -0600, Eric Blake wrote:
> On 1/23/19 7:12 AM, Max Reitz wrote:
> > On 21.01.19 22:02, Eric Blake wrote:
> >> On 12/21/18 5:47 PM, Max Reitz wrote:
> >>> To do this, we need to allow creating the NBD server on various ports
> >>> instead of a single one (which may not even work if you run just one
> >>> instance, because something entirely else might be using that port).
> >>
> >> Can you instead reuse the ideas from nbd_server_set_tcp_port() from
> >> qemu-iotests/common.nbd?
> >>
> >>>
> >>> So we just pick a random port in [32768, 32768 + 1024) and try to create
> >>> a server there.  If that fails, we just retry until something sticks.
> >>
> >> That has the advantage of checking whether a port is actually in use
> >> (using 'ss' - although it does limit the test to Linux-only; perhaps
> >> using socat instead of ss could make the test portable to non-Linux?)
> > 
> > But doesn't that give you race conditions?  That's the point of this
> > series, so you can run multiple instances of 147 concurrently.
> 
> Hmm - that does imply that common.nbd's use of ss IS racy because it
> checks in linear fashion and has a TOCTTOU window (affects at least
> iotest 233). Your observation that random probes within a range are less
> susceptible (although not immune) to the race is correct.
> 
> >> Do you actually need to attempt a qemu-nbd process, if you take my
> >> suggestion of using ss to probe for an unused port?  And if not, do we
> >> still need qemu_nbd_pipe() added earlier in the series?
> >>
> >>
> >>> -        address = { 'type': 'inet',
> >>> -                    'data': {
> >>> -                        'host': 'localhost',
> >>> -                        'port': str(NBD_PORT)
> >>> -                    } }
> >>> -        self._server_up(address, export_name)
> >>> +        while True:
> >>> +            nbd_port = random.randrange(NBD_PORT_START, NBD_PORT_END)
> >>
> >> common.nbd just iterates, instead of trying random ports.
> > 
> > I'm not sure which is better.  Iterating gives guaranteed termination,
> > trying random ports means the first one you try will usually work.
> 
> Is there any other way we can make the test more robust, perhaps by
> using socket activation (that is, pre-open the port prior to starting
> qemu_nbd, so that our code for finding a free socket is more easily
> reusable), or by using Unix sockets for test 147 (that test seems to be
> using TCP sockets only as a means to get to the real feature under test,
> and not as the actual thing being tested)?

The problem with using socket activation is that you then are not getting
test coverage of the non-activation code paths which are quite significant
things we really want to be testing.

I do wonder if there's a case to be made for having iotests run inside a
container with private network namespace such that they then have a
predictable environment.  You could then simply declare that if a test
needs a TCP port, it should use  "port 9000 + $TEST_NUM". So every
test can safely run in parallel.

If the entire test harness needs to be run multiple in parallel each
run woudl be a separate container, and so again avoid clashing.


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
