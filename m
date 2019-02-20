Received: from eggs.gnu.org ([209.51.188.92]:46163)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tcminyard@gmail.com>) id 1gwIE5-0005O3-De
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 22:07:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tcminyard@gmail.com>) id 1gwIE4-0004jK-BR
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 22:07:13 -0500
Received: from mail-ot1-x330.google.com ([2607:f8b0:4864:20::330]:39700)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <tcminyard@gmail.com>) id 1gwIE4-0004iR-5d
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 22:07:12 -0500
Received: by mail-ot1-x330.google.com with SMTP id n8so37815639otl.6
	for <qemu-devel@nongnu.org>; Tue, 19 Feb 2019 19:07:11 -0800 (PST)
Sender: Corey Minyard <tcminyard@gmail.com>
Date: Tue, 19 Feb 2019 21:07:08 -0600
From: Corey Minyard <minyard@acm.org>
Message-ID: <20190220030707.GA5504@minyard.net>
Reply-To: minyard@acm.org
References: <20190211170924.uw6a6xyvmznk7w72@6wind.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190211170924.uw6a6xyvmznk7w72@6wind.com>
Subject: Re: [Qemu-devel] -device ipmi-bmc-sim attached to -netdev vde
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Robin Jarry <robin.jarry@6wind.com>
Cc: qemu-devel@nongnu.org

On Mon, Feb 11, 2019 at 06:09:24PM +0100, Robin Jarry wrote:
> Hi,
> 
> I have several QEMU VMs connected via a vde_switch (with "-netdev vde"
> interfaces). I use this to create virtual network topologies without
> requiring root access (i.e. no tap + bridge on host). Performance is not
> a concern here. To emulate "real" platforms, I would like one of the VMs
> to control the others via remote IPMI over this "vde" link without any
> implication of the host.
> 
> The current implementation in QEMU does not seem to support this. I only
> found ways to create a "local" (i.e. only reachable from the guest
> itself) IPMI interface with "isa-ipmi-kcs" or "isa-ipmi-bt" devices. Or
> "remote" IPMI interfaces by using an external daemon that runs on the
> host [1]. This makes communication from one of the VMs to the others
> quite complex.
> 
> I am enclined to try an develop another IPMI device that can be
> "attached" to a -netdev with a dedicated mac address + IP configuration
> to support my use case.
> 
> However, this would be my first steps into QEMU code and I have a few
> questions first:

Sorry, I've been overfocused on something else and this has been sitting
waiting for a response.

The QEMU code is not going to be your problem here, but more on that later.

> 
> - Did I miss something and is that already possible with the current
>   code base?

I assume you want to use ipmitool or something like that to control the
remote system.

No, it is not possible at the moment, not without something like vbmc
like you mention.

> - Is there another way to do this or is my idea completely stupid?

It's not completely stupid.  Building a system with no security and a
partial IPMI implementation wouldn't be too hard, though the IPMI spec
is very hard to understand.  You could probably steal from the openipmi
library (what vbmc uses) to get the pieces you want an get it working.

Getting all the user management and other standard required IPMI
things would be a nightmare.  But you don't need all that to make
it do what you want.

There are obvious security concerns here with an open IPMI interface.

> - I am aware that allowing to "attach" a simplistic bmc (without any
>   authentication) to a netdev may be a security problem. This is not
>   a concern for me at the moment.

<semi-rant> Security is always a concern at the moment.  If you build
a base infrastructure on something that is insecure, it's hard to
rearchitect in the future to build a secure system.</semi-rant>

> - Could someone point me to what would need to be added for this? Do
>   I need to implement a new ipmi device type that accepts
>   a "netdev=<id>" argument? If so, would that make sense for this new
>   device to also accept mac-address and ip configuration for this IPMI
>   interface? Or does that need to go elsewhere?

If you really wanted to do this, you would need to implement the IPMI
LAN protocol inside QEMU and sit it on top of a UDP chardev.  It could
then plug into the standard IPMI infrastructure in QEMU.  The power
management functions are already there.

The openipmi lanserv code is something you can steal from, it's at
https://github.com/cminyard/openipmi/tree/master/lanserv

My suggestion, though, would be to implement something that ran over
TLS with two-way authentication.  It doesn't look too hard to do
in qemu (though I haven't tried it) but you could have a qemu console
running over TLS that would allow you control from another qemu session.
Plus it would give you authorization and encryption on your qemu
console logins, which is probably a good thing.

<shameless-plug> I have been working on a library that makes it easy
(easier?  The pain is always in the key management) to make TLS
connections.  It's at https://github.com/cminyard/gensio and you
can use it from C or Python.</shameless-plug>
But there are many tools to accomplish this.

-corey

> 
> Thanks in advance for your guidance.
> 
> [1] https://github.com/Zexi/vbmc-qemu
> 
> -- 
> Robin
> 
