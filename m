Received: from eggs.gnu.org ([2001:4830:134:3::10]:35773)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cEavp-0006Qw-I9
	for qemu-devel@nongnu.org; Wed, 07 Dec 2016 07:02:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cEavk-0005yo-Q0
	for qemu-devel@nongnu.org; Wed, 07 Dec 2016 07:02:41 -0500
Received: from mail-vk0-f53.google.com ([209.85.213.53]:36624)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cEavk-0005yS-L9
	for qemu-devel@nongnu.org; Wed, 07 Dec 2016 07:02:36 -0500
Received: by mail-vk0-f53.google.com with SMTP id p9so210821043vkd.3
	for <qemu-devel@nongnu.org>; Wed, 07 Dec 2016 04:02:35 -0800 (PST)
MIME-Version: 1.0
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 7 Dec 2016 12:01:14 +0000
Message-ID: <CAFEAcA9kODkdK96a=rdZS7+xSW0drj4vLMev-AVio-uewm6Cbw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: [Qemu-devel] qemu -netdev tun/tap support can't handle macvtap type
 devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU Developers <qemu-devel@nongnu.org>
Cc: Jason Wang <jasowang@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>

Hi; this is a bug report I'm forwarding for somebody else.

The problem is that QEMU's tun/tap support in net/tap-linux.c only
supports the legacy /dev/net/tun interface (the filename is hardcoded).
If you created the tap device via macvtap, then this is the wrong
filename, but there's no code in QEMU to get the correct /dev/tapN
filename from the user-provided ifname=whatever option.

Talking on IRC, the answer suggested was that we ought to
do a SIOCGIFINDEX ioctl passing in the user-specified ifname
string, which then gives you the index N to construct the
/dev/tapN filename. There is probably complexity in working out
whether we should do that or use the legacy interface (or try both
always?) This is probably overall not a very large amount of code,
though.

The usual suggested workaround is to use the -netdev fd option, like
  fd=3 3<>/dev/tap$(< /sys/class/net/tap0/ifindex)
(which gets the shell to open the right /dev/tap device).
Unfortunately this isn't compatible with multi-queue support
because netdev complains
"ifname=, script=, downscript=, vnet_hdr=, helper=, queues=, fds=,
and vhostfds= are invalid with fd="
so you can't pass options like "queues=4"...

Detailed repro case below if required (uses aarch64 but none
of this is arch-specific as far as I know).

------------<Begin Reproducer>--------------

To reproduce, here are the steps I followed.

Create a tap device on the host
===============================

    # ip link add link eth0 name tap0 type macvtap mode bridge

To create the tap device the host kernel needs CONFIG_MACVTAP enabled.

You can check that the device is created by running

    $ ip a

    1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state
UNKNOWN group default qlen 1
        link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
        inet 127.0.0.1/8 scope host lo
           valid_lft forever preferred_lft forever
        inet6 ::1/128 scope host
           valid_lft forever preferred_lft forever
    2: eth0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc mq state
UP group default qlen 1000
        link/ether 02:a1:a2:a3:a4:a5 brd ff:ff:ff:ff:ff:ff
        inet 10.1.194.30/23 brd 10.1.195.255 scope global eth0
           valid_lft forever preferred_lft forever
        inet6 fe80::a1:a2ff:fea3:a4a5/64 scope link
           valid_lft forever preferred_lft forever
    [...]
    8: tap0@eth0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc
pfifo_fast state UP group default qlen 500
        link/ether 5e:fc:d2:28:f2:f9 brd ff:ff:ff:ff:ff:ff
        inet6 fe80::5cfc:d2ff:fe28:f2f9/64 scope link
           valid_lft forever preferred_lft forever

Creating a tap device creates a character device. The character device
created is "/dev/tap" followed by the interface index (8 in our example above).

The interface index can also be discovered by reading a node in sysfs.

    $ cat /sys/class/net/tap0/ifindex
    8

Modify tap device permissions
=============================

By default, the device node is created with permissions root:root.

    $ ls -l /dev/tap8
    crw------- 1 root root 242, 1 Nov 30 11:57 /dev/tap8

Update the permissions so that qemu-system-aarch64 can access the node.

    # chgrp kvm /dev/tap8
    # chmod g+rw /dev/tap8

    $ ls -l /dev/tap8
    crw-rw---- 1 root kvm 242, 1 Nov 30 11:57 /dev/tap8

Run qemu
========
I am using a locally built qemu (tag: v2.8.0-rc2). When attempting to
start a guest I get the following complaint -

    $ qemu-system-aarch64 -M virt -m 4096 -cpu host -smp 4 -enable-kvm
-nographic \
         -pflash flash0.img -pflash flash1.img \
         -drive if=none,file=hda.qcow2,id=hd0" \
         -device virtio-blk-device,drive=hd0   \
         -netdev tap,id=eth0,script=,ifname=tap0,queues=4 \
         -device
virtio-net-pci,netdev=eth0,mq=on,vectors=12,mac=22:22:3a:57:07:ed

    qemu-system-aarch64: -netdev
tap,id=eth0,script=,ifname=tap0,queues=4: could not open /dev/net/tun:
No such file or directory

------------<End of Reproducer>--------------

thanks
-- PMM
