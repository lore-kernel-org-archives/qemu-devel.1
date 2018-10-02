Received: from eggs.gnu.org ([2001:4830:134:3::10]:57892)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jl4312@columbia.edu>) id 1g7CQv-0003Bi-VS
	for qemu-devel@nongnu.org; Tue, 02 Oct 2018 00:37:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jl4312@columbia.edu>) id 1g7COm-0003Mf-8h
	for qemu-devel@nongnu.org; Tue, 02 Oct 2018 00:35:07 -0400
Received: from outprodmail02.cc.columbia.edu ([128.59.72.51]:59746)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jl4312@columbia.edu>) id 1g7COm-0003Ju-3q
	for qemu-devel@nongnu.org; Tue, 02 Oct 2018 00:35:04 -0400
Received: from hazelnut (hazelnut.cc.columbia.edu [128.59.213.250])
	by outprodmail02.cc.columbia.edu (8.14.4/8.14.4) with ESMTP id
	w924VFFN025713
	for <qemu-devel@nongnu.org>; Tue, 2 Oct 2018 00:34:58 -0400
Received: from hazelnut (localhost.localdomain [127.0.0.1])
	by hazelnut (Postfix) with ESMTP id 49D0F7E
	for <qemu-devel@nongnu.org>; Tue,  2 Oct 2018 00:34:58 -0400 (EDT)
Received: from sendprodmail04.cc.columbia.edu (sendprodmail04.cc.columbia.edu
	[128.59.72.16]) by hazelnut (Postfix) with ESMTP id 25C157E
	for <qemu-devel@nongnu.org>; Tue,  2 Oct 2018 00:34:58 -0400 (EDT)
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
	[209.85.208.71])
	by sendprodmail04.cc.columbia.edu (8.14.4/8.14.4) with ESMTP id
	w924Yv69023361
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 2 Oct 2018 00:34:57 -0400
Received: by mail-ed1-f71.google.com with SMTP id x24-v6so577424edm.13
	for <qemu-devel@nongnu.org>; Mon, 01 Oct 2018 21:34:57 -0700 (PDT)
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com.
	[209.85.221.50]) by smtp.gmail.com with ESMTPSA id
	b9-v6sm5768093edk.62.2018.10.01.21.34.53 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 01 Oct 2018 21:34:54 -0700 (PDT)
Received: by mail-wr1-f50.google.com with SMTP id b11-v6so503760wru.9
	for <qemu-devel@nongnu.org>; Mon, 01 Oct 2018 21:34:53 -0700 (PDT)
MIME-Version: 1.0
From: Jintack Lim <jintack@cs.columbia.edu>
Date: Tue, 2 Oct 2018 00:34:48 -0400
Message-ID: <CAHyh4xhtVzxZgwhTCw=aedGgKHDNzqyOZLTL-qnAqAVWMBb6jQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [Qemu-devel] Have multiple virtio-net devices,
 but only one of them receives all traffic
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU Devel Mailing List <qemu-devel@nongnu.org>, virtio-dev@lists.oasis-open.org

Hi,

I'm using QEMU 3.0.0 and Linux kernel 4.15.0 on x86 machines. I'm
observing pretty weird behavior when I have multiple virtio-net
devices. My KVM VM has two virtio-net devices (vhost=off) and I'm
using a Linux bridge in the host. The two devices have different
MAC/IP addresses.

When I tried to access the VM using two different IP addresses (e.g
ping or ssh), I found that only one device in VM gets all incoming
network traffic while I expected that two devices get traffic for
their own IP addresses.

I checked it in the several ways.

1) I did ping with two IP addresses from the host/other physical
machines in the same subnet, and only one device's interrupt count is
increased.
2) I checked the ARP table from the ping sources, and two different IP
addresses have the same MAC address. In fact, I dumped ARP messages
using tcpdump, and the VM (or the bridge?) replied with the same MAC
address for two different IP addresses as attached below.
3) I monitored the host bridge (# bridge monitor) and found that only
one device's MAC address is registered.

It looks like one device's IP/MAC address is not advertised properly,
but I'm not really sure. When I turned off the device getting all the
traffic, then the other device starts getting incoming packets; the
device's MAC address is registered in the host bridge. The active
device only gets traffic for its own IP address, of course.

Here's the tcpdump result. IP 10.10.1.100 and 10.10.1.221 are VM's IP
addresses. IP 10.10.1.221 is assigned to a device having
52:54:00:12:34:58, but the log shows it is advertised as having
...:57.

23:24:10.983700 ARP, Ethernet (len 6), IPv4 (len 4), Request who-has
10.10.1.100 tell kvm-dest-link-1, length 46
23:24:10.983771 ARP, Ethernet (len 6), IPv4 (len 4), Reply 10.10.1.100
is-at 52:54:00:12:34:57 (oui Unknown), length 28
23:24:17.794811 ARP, Ethernet (len 6), IPv4 (len 4), Request who-has
10.10.1.211 tell kvm-dest-link-1, length 46
23:24:17.794869 ARP, Ethernet (len 6), IPv4 (len 4), Reply 10.10.1.211
is-at 52:54:00:12:34:57 (oui Unknown), length 28

I would appreciate any help!

Thanks,
Jintack
