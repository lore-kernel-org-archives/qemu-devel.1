Received: from eggs.gnu.org ([2001:4830:134:3::10]:60243)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1egp3T-0004Cx-Ot
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 04:51:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1egp3N-0000rx-Tx
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 04:51:47 -0500
Date: Wed, 31 Jan 2018 09:51:18 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180131095118.GE3255@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <1517253224-14361-1-git-send-email-whois.zihan.yang@gmail.com>
	<1517253224-14361-3-git-send-email-whois.zihan.yang@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1517253224-14361-3-git-send-email-whois.zihan.yang@gmail.com>
Subject: Re: [Qemu-devel] [RFC 2/4] qemu-socket: Allow custom socket options
 in socket_connect
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

On Tue, Jan 30, 2018 at 03:13:42AM +0800, Zihan Yang wrote:
> Currently, socket_connect doesn't allow custom socket options,
> which is inconvenient when the caller wants a different kind of
> socket from that the socket_connect provides. This patch allows
> custom config in socket_connect by providing an extra parameter.
> Existing functions can just pass a NULL pointer.

Again adding options functionality hwich is not actually used
is bad.

The O_NONBLOCK functionality makes more sense in this context
but the implementation is really broken.

These functions do hostname lookups, so can never do non-blocking
mode correctly as the hostname lookup itself does blocking I/O
to the nameserver(s).  Ignoring that, the way you handle the
connect() is wrong too. You're iterating over many addresses
returned by getaddrinfo() and doing a non-blocking connect
on each of them. These will essentially all fail with EAGAIN
and you'll skip onto the next address which is wrong.

This code used to have support for O_NONBLOCK but it was removed
because the DNS problem means that any code relying on it was
already broken.  The rest of the QEMU codebase has been converted
to use QIOChannelSocket instead which can handle non-blocking
DNS properly

So overall I'm against this patch too.


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
