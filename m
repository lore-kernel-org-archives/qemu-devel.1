Received: from eggs.gnu.org ([209.51.188.92]:59433)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <robin.jarry@6wind.com>) id 1gtF8K-0001g1-38
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 12:12:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <robin.jarry@6wind.com>) id 1gtF5b-0005Qm-BQ
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 12:09:52 -0500
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433]:35537)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <robin.jarry@6wind.com>)
	id 1gtF5a-0005HM-Ss
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 12:09:51 -0500
Received: by mail-wr1-x433.google.com with SMTP id t18so1225294wrx.2
	for <qemu-devel@nongnu.org>; Mon, 11 Feb 2019 09:09:46 -0800 (PST)
Date: Mon, 11 Feb 2019 18:09:24 +0100
From: Robin Jarry <robin.jarry@6wind.com>
Message-ID: <20190211170924.uw6a6xyvmznk7w72@6wind.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [Qemu-devel] -device ipmi-bmc-sim attached to -netdev vde
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Corey Minyard <minyard@acm.org>
Cc: qemu-devel@nongnu.org

Hi,

I have several QEMU VMs connected via a vde_switch (with "-netdev vde"
interfaces). I use this to create virtual network topologies without
requiring root access (i.e. no tap + bridge on host). Performance is not
a concern here. To emulate "real" platforms, I would like one of the VMs
to control the others via remote IPMI over this "vde" link without any
implication of the host.

The current implementation in QEMU does not seem to support this. I only
found ways to create a "local" (i.e. only reachable from the guest
itself) IPMI interface with "isa-ipmi-kcs" or "isa-ipmi-bt" devices. Or
"remote" IPMI interfaces by using an external daemon that runs on the
host [1]. This makes communication from one of the VMs to the others
quite complex.

I am enclined to try an develop another IPMI device that can be
"attached" to a -netdev with a dedicated mac address + IP configuration
to support my use case.

However, this would be my first steps into QEMU code and I have a few
questions first:

- Did I miss something and is that already possible with the current
  code base?
- Is there another way to do this or is my idea completely stupid?
- I am aware that allowing to "attach" a simplistic bmc (without any
  authentication) to a netdev may be a security problem. This is not
  a concern for me at the moment.
- Could someone point me to what would need to be added for this? Do
  I need to implement a new ipmi device type that accepts
  a "netdev=<id>" argument? If so, would that make sense for this new
  device to also accept mac-address and ip configuration for this IPMI
  interface? Or does that need to go elsewhere?

Thanks in advance for your guidance.

[1] https://github.com/Zexi/vbmc-qemu

-- 
Robin
