Received: from eggs.gnu.org ([2001:4830:134:3::10]:38827)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <i.maximets@samsung.com>) id 1g7Nng-0008HE-H0
	for qemu-devel@nongnu.org; Tue, 02 Oct 2018 12:45:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <i.maximets@samsung.com>) id 1g7Nnd-00048o-4Y
	for qemu-devel@nongnu.org; Tue, 02 Oct 2018 12:45:32 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:41734)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <i.maximets@samsung.com>)
	id 1g7Nnc-0003Xh-JQ
	for qemu-devel@nongnu.org; Tue, 02 Oct 2018 12:45:28 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id
	20181002164517euoutp013a465d65614b8e18d21b57a3209ecd97~Z2G6xLZU-0899208992euoutp01N
	for <qemu-devel@nongnu.org>; Tue,  2 Oct 2018 16:45:17 +0000 (GMT)
From: Ilya Maximets <i.maximets@samsung.com>
Date: Tue, 2 Oct 2018 19:47:32 +0300
MIME-Version: 1.0
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Message-Id: <20181002164516eucas1p146cf7b26519eba34b629625fa60efc16~Z2G5WrTa-2244722447eucas1p1j@eucas1p1.samsung.com>
Content-Type: text/plain; charset="utf-8"
References: <CGME20181002164516eucas1p146cf7b26519eba34b629625fa60efc16@eucas1p1.samsung.com>
Subject: [Qemu-devel]  Have multiple virtio-net devices,
 but only one of them receives all traffic
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: jintack@cs.columbia.edu

> Hi,
> 
> I'm using QEMU 3.0.0 and Linux kernel 4.15.0 on x86 machines. I'm
> observing pretty weird behavior when I have multiple virtio-net
> devices. My KVM VM has two virtio-net devices (vhost=off) and I'm
> using a Linux bridge in the host. The two devices have different
> MAC/IP addresses.
> 
> When I tried to access the VM using two different IP addresses (e.g
> ping or ssh), I found that only one device in VM gets all incoming
> network traffic while I expected that two devices get traffic for
> their own IP addresses.
> 
> I checked it in the several ways.
> 
> 1) I did ping with two IP addresses from the host/other physical
> machines in the same subnet, and only one device's interrupt count is
> increased.
> 2) I checked the ARP table from the ping sources, and two different IP
> addresses have the same MAC address. In fact, I dumped ARP messages
> using tcpdump, and the VM (or the bridge?) replied with the same MAC
> address for two different IP addresses as attached below.
> 3) I monitored the host bridge (# bridge monitor) and found that only
> one device's MAC address is registered.
> 
> It looks like one device's IP/MAC address is not advertised properly,
> but I'm not really sure. When I turned off the device getting all the
> traffic, then the other device starts getting incoming packets; the
> device's MAC address is registered in the host bridge. The active
> device only gets traffic for its own IP address, of course.
> 
> Here's the tcpdump result. IP 10.10.1.100 and 10.10.1.221 are VM's IP
> addresses. IP 10.10.1.221 is assigned to a device having
> 52:54:00:12:34:58, but the log shows it is advertised as having
> ...:57.

I assume that both devices are in the same subnet. In this case kernel
inside guest confused about to which port packets from this subnet should
go. Look at the routing table (route -n) and you'll see that it uses only
one port for sending packets. You just can't have two interfaces in the
same subnet in Linux/any other OS. There is nothing QEMU specific here.

> 
> 23:24:10.983700 ARP, Ethernet (len 6), IPv4 (len 4), Request who-has
> 10.10.1.100 tell kvm-dest-link-1, length 46
> 23:24:10.983771 ARP, Ethernet (len 6), IPv4 (len 4), Reply 10.10.1.100
> is-at 52:54:00:12:34:57 (oui Unknown), length 28
> 23:24:17.794811 ARP, Ethernet (len 6), IPv4 (len 4), Request who-has
> 10.10.1.211 tell kvm-dest-link-1, length 46
> 23:24:17.794869 ARP, Ethernet (len 6), IPv4 (len 4), Reply 10.10.1.211
> is-at 52:54:00:12:34:57 (oui Unknown), length 28
> 
> I would appreciate any help!
> 
> Thanks,
> Jintack
