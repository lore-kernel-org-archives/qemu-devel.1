Received: from eggs.gnu.org ([2001:4830:134:3::10]:59958)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <whois.zihan.yang@gmail.com>) id 1eguBU-0000me-63
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 10:20:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <whois.zihan.yang@gmail.com>) id 1eguBP-0001bV-Nr
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 10:20:24 -0500
MIME-Version: 1.0
In-Reply-To: <20180131095118.GE3255@redhat.com>
References: <1517253224-14361-1-git-send-email-whois.zihan.yang@gmail.com>
	<1517253224-14361-3-git-send-email-whois.zihan.yang@gmail.com>
	<20180131095118.GE3255@redhat.com>
From: Zihan Yang <whois.zihan.yang@gmail.com>
Date: Wed, 31 Jan 2018 23:20:16 +0800
Message-ID: <CAKwiv-hsjACjNqPSz36JGPv17UAQr0Utga7Krw7iZ-iCEC9gmQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [Qemu-devel] Fwd: [RFC 2/4] qemu-socket: Allow custom socket
 options in socket_connect
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Hitoshi Mitake <mitake.hitoshi@lab.ntt.co.jp>, Liu Yuan <namei.unix@gmail.com>, Jeff Cody <jcody@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, "Richard W.M. Jones" <rjones@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, "open list:Sheepdog" <qemu-block@nongnu.org>, "open list:Sheepdog" <sheepdog@lists.wpkg.org>

Hi, Daniel

>You've added all this extra functionality to pass arbitrary
>options, but then not used it in any of the later patches.
>We've been trying to remove complexity from this code, so
>I'm not in favour of adding new functionality that is not
>even used.

You are right, unused functionality should not be added. I was thinking
about future usage, but that seems really unnecessary now.

>I'm not seeing the point of adding the support for the O_NONBLOCK
>in the listener socket either - that can easily be turned on after
>you have the listener socket created.

I don't quite understand how I can turn it on in socket_listen, because
socket_listen will create a listener socket inside it, then bind and listen.
Are there other ways than passing some kind of 'config parameter'?

>The O_NONBLOCK functionality makes more sense in this context
>but the implementation is really broken.

Well.. sorry for the broken implementation, I guess I need more practice.

>These functions do hostname lookups, so can never do non-blocking
>mode correctly as the hostname lookup itself does blocking I/O
>to the nameserver(s).  Ignoring that, the way you handle the
>connect() is wrong too. You're iterating over many addresses
>returned by getaddrinfo() and doing a non-blocking connect
>on each of them. These will essentially all fail with EAGAIN
>and you'll skip onto the next address which is wrong.

Why would the hostname lookup affect the listener socket
afterwards? The socket is created after the lookup procedure is done.
Therefore, the config should only affect the listener socket, not the
hostname lookup process. Would you explain in more detail? I'm not
an expert in socket programming, so I'm confused.

Also, connect() indeed could return EAGAIN, however, the continue
expression is inside the do-while loop of inet_connect_addr(),
rather than the for loop inside inet_connect_saddr(), which is the
caller of inet_connect_addr(). So it would just try to connect again
instead of skipping to next address.

I know this is not a well-written patch, but if you forget about the broken
implementation for a while, it actually won't fail them all. I did a little
test
by connecting two VMs through socket, and they can ping each other.
The docker test fails because I missed the NULL pointer check for sconf,
which I ignored in the ping test above, but it is irrelevant to the problem
here. After I fix it, the test passes.

>This code used to have support for O_NONBLOCK but it was removed
>because the DNS problem means that any code relying on it was
>already broken.  The rest of the QEMU codebase has been converted
>to use QIOChannelSocket instead which can handle non-blocking
>DNS properly

I didn't know this, thanks for clarifying it. Do you mean if I want to use
non-blocking socket, it's better to use QIOChannelSocket instead of
socket_listen/socket_connect? If I want to set some other
options, do I have to use the bind/listen/connect series functions
directly? That seems the way in some functions in net/socket.c.

Anyway, thanks for your comment, it helps clarify things. I had
intended to get start with this task, but it seems to have already been
fully explored before. I guess I need to review my patches throughly,

Regards
Zihan
