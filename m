Received: from eggs.gnu.org ([2001:4830:134:3::10]:55706)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yuzibode@126.com>) id 1fTSrO-0001ua-Rs
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 10:04:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yuzibode@126.com>) id 1fTSrK-000190-Ic
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 10:04:22 -0400
Received: from m50-111.126.com ([123.125.50.111]:55756)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yuzibode@126.com>) id 1fTSrK-00018E-0Z
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 10:04:18 -0400
Date: Thu, 14 Jun 2018 22:04:09 +0800
From: Bo YU <yuzibode@126.com>
Message-ID: <20180614140409.tn22ucju5dcizvwc@debian.debian>
References: <20180614034744.dcato6eemcrr3drq@debian.debian>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <20180614034744.dcato6eemcrr3drq@debian.debian>
Subject: Re: [Qemu-devel] Error: virtio_net: Too few free TX rings available.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Hello,
On Thu, Jun 14, 2018 at 11:47:44AM +0800, Bo YU wrote:
>Hello,
>A am newbie to qemu.
>I am using qemu now:
>qemu-io --version
>qemu-io version 2.12.50 (v2.12.0-1296-g2ab09bf2f9-dirty)
>Copyright (c) 2003-2017 Fabrice Bellard and the QEMU Project developers
>
>I have to talk about using qemu with libvirt recently libvirt deadlocked
>when libvirt fetching qemu capabilities.Under Michal Privoznik help, i
>restart my VM.
>
>The reason which cause recompile  qume from version 2.8 is:
>i want to modify some features:
>
>Fowllowing the instrustions:
>
>http://cilium.readthedocs.io/en/latest/bpf/#bpftool
>
>$ clang -O2 -Wall -target bpf -c xdp-example.c -o xdp-example.o
>
>I get the error:
>
># sudo /sbin/ip link set dev ens3 xdp obj xdp_2.o
>Error: virtio_net: Too few free TX rings available.
># sudo dmesg
>virtio_net virtio0 ens3: request 4 queues but max is 1
>
>
>And i type: sudo ethtool -g ens3
>Ring parameters for ens3:
>Pre-set maximums:
>RX: 256
>RX Mini:0
>RX Jumbo:0
>TX:256
>Current hardware settings:
>RX:256
>RX Mini:0
>RX Jumbo:0
>TX:256
>
>sudo ethtool -G ens3 rx 512
>Cannot set device ring parameters: Operation not supported
>
>
>I have trace the mail-list:
>https://bugzilla.redhat.com/show_bug.cgi?id=1301548
>and there:
>https://groups.google.com/forum/#!topic/snabb-devel/ng78LbcaFgII
>I remeber there is a patch for qemu for modfing paramertes in
>hw/virtio-net.c,sorry, i can't find the patch.
>
>If i modify the rx_queue_max by hand to 1024, Is it ok?
qemu-io  --version
qemu-io version 2.12.50 (v2.12.0-1296-g2ab09bf2f9-dirty)
Copyright (c) 2003-2017 Fabrice Bellard and the QEMU Project developers

Under the above version of qemu,i modifyi and recompile qemu:
+#define VIRTIO_NET_RX_QUEUE_DEFAULT_SIZE 1024
in hw/net/virtio-net.c
Now, i have got the result:

sudo ethtool -g ens3
[sudo] password for yubo-2:
Ring parameters for ens3:
Pre-set maximums:
RX:   1024
RX Mini:0
RX Jumbo:0
TX:   1024
Current hardware settings:
RX:    1024
RX Mini:0
RX Jumbo:0
TX:    1024

If you want to test xdp expertiment,maybe you have to do it follow below.

https://marc.info/?l=xdp-newbies&m=14948693111365&w=2

Here is the right incantation to add to the "interface" section(with 4 vcpus)
<driver name='vhost' queue='8'>
	<host tso4='off' tso6='off' ecn='off' ufo='off'/>
	<guest tso4='off' tso6='off' ecn='off' ufo='off'/>
</driiver>

Bo
>
>Thank you in advance!
>
>
