Received: from eggs.gnu.org ([2001:4830:134:3::10]:38463)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <brak@gameservers.com>) id 1ecdGh-0006qK-TU
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 15:28:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <brak@gameservers.com>) id 1ecdGd-0005k8-W5
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 15:28:07 -0500
Received: from mail2015.choopa.net ([208.167.225.251]:38121)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <brak@gameservers.com>)
	id 1ecdGd-0005jq-RQ
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 15:28:03 -0500
From: Brian Rak <brak@gameservers.com>
Message-ID: <e9d36f5e-fc14-9c54-c519-7e1615959973@gameservers.com>
Date: Fri, 19 Jan 2018 15:28:00 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] virtio_net occasionally stops sending packets
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel <qemu-devel@nongnu.org>, netdev@vger.kernel.org

We've been running into a fairly persistent issue where virtio_net=20
adapters will suddenly stop sending packets when running under KVM.=C2=A0=
=20
This has persisted through several qemu versions, and a large number of=20
guest kernel upgrades.

What we end up seeing is the guest continuing to receive packets, but=20
refusing to transmit anything.

If we leave ping running for a minute or two, it will eventually start=20
printing "ping: sendmsg: No buffer space available" messages.=C2=A0 tcpdu=
mp=20
will show nothing being sent from the guest. `ip -s link` will show RX=20
bytes/packets incrementing, but not TX. `tc -s qdisc show dev eth1`=20
shows the 'dropped' counter incrementing with every new ping attempt.

I attempted to run 'dropwatch -l kas', which showed me a bunch of lines=20
that looked like '4 drops at pfifo_fast_enqueue+85'.

So far, we haven't been able to consistently reproduce this.=C2=A0 We hav=
e a=20
few guests that will hit this issue roughly once every two weeks, but we=20
haven't been able to reproduce it on demand.=C2=A0 This seems to happen w=
ith=20
guests that have more then one network adapter attached.=C2=A0 I do not t=
hink=20
we've seen it on guests that only have one NIC.

We've tried guest kernels as new as 4.14.13, and qemu versions as new as=20
2.11.0.=C2=A0 This doesn't appear to be related to the physical network a=
t=20
all, we've seen this happen with a variety of network backends:
* qemu 'multicast' networks
* macvtap attached to a vxlan interface
* bridged interface

We've tried disabling a variety of offloads (gso, tso4, tso6, ecn) from=20
both the host and guest sides.=C2=A0 This didn't really have any effect.

The only way to fix this once it breaks is to restart the guest OS.=C2=A0=
=20
`ifdown eth1; ifup eth1` doesn't seem to help.

How can I determine if this is a qemu issue, or an issue with the=20
virtio_net driver?=C2=A0 We have not tried this with other virtual nic ty=
pes=20
yet.=C2=A0 I'm not sure if that would provide any useful information or n=
ot.=C2=A0=20
We're still working on figuring out how to reproduce this, but I'm not=20
terribly hopeful about coming up with a simple set of reproduction steps.

This was my post about it a few years ago:=20
https://lists.nongnu.org/archive/html/qemu-devel/2015-01/msg03907.html
