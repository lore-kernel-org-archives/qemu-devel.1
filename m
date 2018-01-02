Received: from eggs.gnu.org ([2001:4830:134:3::10]:33000)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <s.priebe@profihost.ag>) id 1eWTwD-0004w0-RR
	for qemu-devel@nongnu.org; Tue, 02 Jan 2018 16:17:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <s.priebe@profihost.ag>) id 1eWTw8-0007Nh-Ov
	for qemu-devel@nongnu.org; Tue, 02 Jan 2018 16:17:33 -0500
Received: from cloud1-vm154.de-nserver.de ([178.250.10.56]:52478)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <s.priebe@profihost.ag>)
	id 1eWTw8-0007NH-Dd
	for qemu-devel@nongnu.org; Tue, 02 Jan 2018 16:17:28 -0500
References: <77f0c119-236d-9d4e-0a99-3519ecc26b23@profihost.ag>
	<20180102142054.jqhbg3zrhjlppg2q@Wei-Dev>
	<895f121e-c8fb-e669-592c-73e807d1f8f7@profihost.ag>
	<20180102170459.wkvqrrlal4jbobdu@Wei-Dev>
From: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Message-ID: <de5af082-f6b5-6b96-9503-54e3105d46f4@profihost.ag>
Date: Tue, 2 Jan 2018 22:17:25 +0100
MIME-Version: 1.0
In-Reply-To: <20180102170459.wkvqrrlal4jbobdu@Wei-Dev>
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] dropped pkts with Qemu on tap interace (RX)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Wei Xu <wexu@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>


Am 02.01.2018 um 18:04 schrieb Wei Xu:
> On Tue, Jan 02, 2018 at 04:24:33PM +0100, Stefan Priebe - Profihost AG wrote:
>> Hi,
>> Am 02.01.2018 um 15:20 schrieb Wei Xu:
>>> On Tue, Jan 02, 2018 at 12:17:29PM +0100, Stefan Priebe - Profihost AG wrote:
>>>> Hello,
>>>>
>>>> currently i'm trying to fix a problem where we have "random" missing
>>>> packets.
>>>>
>>>> We're doing an ssh connect from machine a to machine b every 5 minutes
>>>> via rsync and ssh.
>>>>
>>>> Sometimes it happens that we get this cron message:
>>>> "Connection to 192.168.0.2 closed by remote host.
>>>> rsync: connection unexpectedly closed (0 bytes received so far) [sender]
>>>> rsync error: unexplained error (code 255) at io.c(226) [sender=3.1.2]
>>>> ssh: connect to host 192.168.0.2 port 22: Connection refused"
>>>
>>> Hi Stefan,
>>> What kind of virtio-net backend are you using? Can you paste your qemu
>>> command line here?
>>
>> Sure netdev part:
>> -netdev
>> type=tap,id=net0,ifname=tap317i0,script=/var/lib/qemu-server/pve-bridge,downscript=/var/lib/qemu-server/pve-bridgedown,vhost=on
>> -device
>> virtio-net-pci,mac=EA:37:42:5C:F3:33,netdev=net0,bus=pci.0,addr=0x12,id=net0,bootindex=300
>> -netdev
>> type=tap,id=net1,ifname=tap317i1,script=/var/lib/qemu-server/pve-bridge,downscript=/var/lib/qemu-server/pve-bridgedown,vhost=on,queues=4
>> -device
>> virtio-net-pci,mac=6A:8E:74:45:1A:0B,nedev=net1,bus=pci.0,addr=0x13,id=net1,vectors=10,mq=on,bootindex=301
> 
> According to what you have mentioned, the traffic is not heavy for the guests,
> the dropping shouldn't happen for regular case.

The avg traffic is around 300kb/s.

> What is your hardware platform?

Dual Intel Xeon E5-2680 v4

> and Which versions are you using for both
> guest/host kernel
Kernel v4.4.103

> and qemu?
2.9.1

> Are there other VMs on the same host?
Yes.


>>> 'Connection refused' usually means that the client gets a TCP Reset rather
>>> than losing packets, so this might not be a relevant issue.
>>
>> Mhm so you mean these might be two seperate ones?
> 
> Yes.
> 
>>
>>> Also you can do a tcpdump on both guests and see what happened to SSH packets
>>> (tcpdump -i tapXXX port 22).
>>
>> Sadly not as there's too much traffic on that part as rsync is syncing
>> every 5 minutes through ssh.
> 
> You can do a tcpdump for the entire traffic from the guest and host and compare
> what kind of packets are dropped if the traffic is not overloaded.

Are you sure? I don't get why the same amount and same kind of packets
should be received by both tap which are connected to different bridges
to different HW and physical interfaces.

Stefan

> Wei
> 
>>
>>>> The tap devices on the target vm shows dropped RX packages on BOTH tap
>>>> interfaces - strangely with the same amount of pkts?
>>>>
>>>> # ifconfig tap317i0; ifconfig tap317i1
>>>> tap317i0  Link encap:Ethernet  HWaddr 6e:cb:65:94:bb:bf
>>>>           UP BROADCAST RUNNING PROMISC MULTICAST  MTU:1500  Metric:1
>>>>           RX packets:2238445 errors:0 dropped:13159 overruns:0 frame:0
>>>>           TX packets:9655853 errors:0 dropped:0 overruns:0 carrier:0
>>>>           collisions:0 txqueuelen:1000
>>>>           RX bytes:177991267 (169.7 MiB)  TX bytes:910412749 (868.2 MiB)
>>>>
>>>> tap317i1  Link encap:Ethernet  HWaddr 96:f8:b5:d0:9a:07
>>>>           UP BROADCAST RUNNING PROMISC MULTICAST  MTU:1500  Metric:1
>>>>           RX packets:1516085 errors:0 dropped:13159 overruns:0 frame:0
>>>>           TX packets:1446964 errors:0 dropped:0 overruns:0 carrier:0
>>>>           collisions:0 txqueuelen:1000
>>>>           RX bytes:1597564313 (1.4 GiB)  TX bytes:3517734365 (3.2 GiB)
>>>>
>>>> Any ideas how to inspect this issue?
>>>
>>> It seems both tap interfaces lose RX pkts, dropping pkts of RX means the
>>> host(backend) cann't receive packets from the guest as fast as the guest sends.
>>
>> Inside the guest i see no dropped packets at all. It's only on the host
>> and strangely on both taps at the same value? And both are connected to
>> absolutely different networks.
>>
>>> Are you running some symmetrical test on both guests? 
>>
>> No.
>>
>> Stefan
>>
>>
>>> Wei
>>>
>>>>
>>>> Greets,
>>>> Stefan
>>>>
