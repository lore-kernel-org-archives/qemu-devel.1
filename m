Received: from eggs.gnu.org ([2001:4830:134:3::10]:35709)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <brak@gameservers.com>) id 1eeO1D-000488-Gt
	for qemu-devel@nongnu.org; Wed, 24 Jan 2018 11:35:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <brak@gameservers.com>) id 1eeO1C-0004PX-AJ
	for qemu-devel@nongnu.org; Wed, 24 Jan 2018 11:35:23 -0500
Received: from mail2015.choopa.net ([2001:19f0:200:4d0f::10]:44171)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <brak@gameservers.com>)
	id 1eeO1C-0004P9-6J
	for qemu-devel@nongnu.org; Wed, 24 Jan 2018 11:35:22 -0500
From: Brian Rak <brak@gameservers.com>
References: <e9d36f5e-fc14-9c54-c519-7e1615959973@gameservers.com>
Message-ID: <055bd0a3-80b7-15c8-ac31-bb220a95fc91@gameservers.com>
Date: Wed, 24 Jan 2018 11:35:20 -0500
MIME-Version: 1.0
In-Reply-To: <e9d36f5e-fc14-9c54-c519-7e1615959973@gameservers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] virtio_net occasionally stops sending packets
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel <qemu-devel@nongnu.org>, netdev@vger.kernel.org

Interestingly, we thought we had just been seeing this on the second=20
nic.=C2=A0 However, we've went back through some older logs and realized =
that=20
it's been happening on the first nic as well, though it's presenting=20
itself slightly differently there (ping just says "Destination Host=20
Unreachable").=C2=A0 I think this is because the VM is unable to resolve =
it's=20
default-route via ARP.

Unfortunately, this machine doesn't have drop monitoring enabled, so I=20
can't tell if it's getting dropped in the same spot (it probably is=20
though.. tc is still showing the drop counter incrementing)


On 1/19/2018 3:28 PM, Brian Rak wrote:
> We've been running into a fairly persistent issue where virtio_net=20
> adapters will suddenly stop sending packets when running under KVM.=C2=A0=
=20
> This has persisted through several qemu versions, and a large number=20
> of guest kernel upgrades.
>
> What we end up seeing is the guest continuing to receive packets, but=20
> refusing to transmit anything.
>
> If we leave ping running for a minute or two, it will eventually start=20
> printing "ping: sendmsg: No buffer space available" messages.=C2=A0 tcp=
dump=20
> will show nothing being sent from the guest. `ip -s link` will show RX=20
> bytes/packets incrementing, but not TX. `tc -s qdisc show dev eth1`=20
> shows the 'dropped' counter incrementing with every new ping attempt.
>
> I attempted to run 'dropwatch -l kas', which showed me a bunch of=20
> lines that looked like '4 drops at pfifo_fast_enqueue+85'.
>
> So far, we haven't been able to consistently reproduce this.=C2=A0 We h=
ave=20
> a few guests that will hit this issue roughly once every two weeks,=20
> but we haven't been able to reproduce it on demand.=C2=A0 This seems to=
=20
> happen with guests that have more then one network adapter attached.=C2=
=A0=20
> I do not think we've seen it on guests that only have one NIC.
>
> We've tried guest kernels as new as 4.14.13, and qemu versions as new=20
> as 2.11.0.=C2=A0 This doesn't appear to be related to the physical netw=
ork=20
> at all, we've seen this happen with a variety of network backends:
> * qemu 'multicast' networks
> * macvtap attached to a vxlan interface
> * bridged interface
>
> We've tried disabling a variety of offloads (gso, tso4, tso6, ecn)=20
> from both the host and guest sides.=C2=A0 This didn't really have any e=
ffect.
>
> The only way to fix this once it breaks is to restart the guest OS.=C2=A0=
=20
> `ifdown eth1; ifup eth1` doesn't seem to help.
>
> How can I determine if this is a qemu issue, or an issue with the=20
> virtio_net driver?=C2=A0 We have not tried this with other virtual nic=20
> types yet.=C2=A0 I'm not sure if that would provide any useful informat=
ion=20
> or not.=C2=A0 We're still working on figuring out how to reproduce this=
,=20
> but I'm not terribly hopeful about coming up with a simple set of=20
> reproduction steps.
>
> This was my post about it a few years ago:=20
> https://lists.nongnu.org/archive/html/qemu-devel/2015-01/msg03907.html
>
