Received: from eggs.gnu.org ([2001:4830:134:3::10]:33549)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eguIo-0003dY-SV
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 10:28:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eguIf-0005Dr-6Q
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 10:27:58 -0500
Date: Wed, 31 Jan 2018 15:26:30 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180131152630.GM3255@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <1517253224-14361-1-git-send-email-whois.zihan.yang@gmail.com>
	<1517253224-14361-3-git-send-email-whois.zihan.yang@gmail.com>
	<20180131095118.GE3255@redhat.com>
	<CAKwiv-hsjACjNqPSz36JGPv17UAQr0Utga7Krw7iZ-iCEC9gmQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAKwiv-hsjACjNqPSz36JGPv17UAQr0Utga7Krw7iZ-iCEC9gmQ@mail.gmail.com>
Subject: Re: [Qemu-devel] Fwd: [RFC 2/4] qemu-socket: Allow custom socket
 options in socket_connect
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Zihan Yang <whois.zihan.yang@gmail.com>
Cc: qemu-devel@nongnu.org, Hitoshi Mitake <mitake.hitoshi@lab.ntt.co.jp>, Liu Yuan <namei.unix@gmail.com>, Jeff Cody <jcody@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, "Richard W.M. Jones" <rjones@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, "open list:Sheepdog" <qemu-block@nongnu.org>, "open list:Sheepdog" <sheepdog@lists.wpkg.org>

On Wed, Jan 31, 2018 at 11:20:16PM +0800, Zihan Yang wrote:
> Hi, Daniel
> 
> >You've added all this extra functionality to pass arbitrary
> >options, but then not used it in any of the later patches.
> >We've been trying to remove complexity from this code, so
> >I'm not in favour of adding new functionality that is not
> >even used.
> 
> You are right, unused functionality should not be added. I was thinking
> about future usage, but that seems really unnecessary now.
> 
> >I'm not seeing the point of adding the support for the O_NONBLOCK
> >in the listener socket either - that can easily be turned on after
> >you have the listener socket created.
> 
> I don't quite understand how I can turn it on in socket_listen, because
> socket_listen will create a listener socket inside it, then bind and listen.
> Are there other ways than passing some kind of 'config parameter'?

You don't need to turn it on in socket_listen(). You can just do

   fd = socket_listen()
   qemu_set_nonblock(fd)
   ...do stuff...

> >The O_NONBLOCK functionality makes more sense in this context
> >but the implementation is really broken.
> 
> Well.. sorry for the broken implementation, I guess I need more practice.
> 
> >These functions do hostname lookups, so can never do non-blocking
> >mode correctly as the hostname lookup itself does blocking I/O
> >to the nameserver(s).  Ignoring that, the way you handle the
> >connect() is wrong too. You're iterating over many addresses
> >returned by getaddrinfo() and doing a non-blocking connect
> >on each of them. These will essentially all fail with EAGAIN
> >and you'll skip onto the next address which is wrong.
> 
> Why would the hostname lookup affect the listener socket
> afterwards? The socket is created after the lookup procedure is done.
> Therefore, the config should only affect the listener socket, not the
> hostname lookup process. Would you explain in more detail? I'm not
> an expert in socket programming, so I'm confused.
> 
> Also, connect() indeed could return EAGAIN, however, the continue
> expression is inside the do-while loop of inet_connect_addr(),
> rather than the for loop inside inet_connect_saddr(), which is the
> caller of inet_connect_addr(). So it would just try to connect again
> instead of skipping to next address.

The point of using  O_NONBLOCK is so that the caller does not get
delayed for a long time while network traffic runs.  There are two
places network traffic is used in socket_connect(). First it is
used to resolve the hostname to an IP address via DNS servers, and
second it is used in the TCP connection handshake.

The O_NONBLOCK code only affects the connection handshake, so the
caller can still be delayed an abitrary amount of time by the DNS
lookup.

IOW, if the caller must *not* be delayed, then simply using O_NONBLOCK
is not sufficient to avoid the delay. If the caller can tolerate
delays, then using O_NONBLOCK is pointless.


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
