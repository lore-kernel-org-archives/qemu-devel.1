Received: from eggs.gnu.org ([2001:4830:134:3::10]:37569)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wexu@redhat.com>) id 1eWZq7-0001sJ-DR
	for qemu-devel@nongnu.org; Tue, 02 Jan 2018 22:35:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wexu@redhat.com>) id 1eWZq3-0006Bh-58
	for qemu-devel@nongnu.org; Tue, 02 Jan 2018 22:35:39 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33328)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wexu@redhat.com>) id 1eWZq2-0006B2-SZ
	for qemu-devel@nongnu.org; Tue, 02 Jan 2018 22:35:35 -0500
Date: Wed, 3 Jan 2018 11:57:49 +0800
From: Wei Xu <wexu@redhat.com>
Message-ID: <20180103035749.uz4lmjsc7z4kuewu@Wei-Dev>
References: <77f0c119-236d-9d4e-0a99-3519ecc26b23@profihost.ag>
	<20180102142054.jqhbg3zrhjlppg2q@Wei-Dev>
	<895f121e-c8fb-e669-592c-73e807d1f8f7@profihost.ag>
	<20180102170459.wkvqrrlal4jbobdu@Wei-Dev>
	<de5af082-f6b5-6b96-9503-54e3105d46f4@profihost.ag>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <de5af082-f6b5-6b96-9503-54e3105d46f4@profihost.ag>
Subject: Re: [Qemu-devel] dropped pkts with Qemu on tap interace (RX)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Cc: qemu-devel <qemu-devel@nongnu.org>

On Tue, Jan 02, 2018 at 10:17:25PM +0100, Stefan Priebe - Profihost AG wrote:
> 
> Am 02.01.2018 um 18:04 schrieb Wei Xu:
> > On Tue, Jan 02, 2018 at 04:24:33PM +0100, Stefan Priebe - Profihost AG wrote:
> >> Hi,
> >> Am 02.01.2018 um 15:20 schrieb Wei Xu:
> >>> On Tue, Jan 02, 2018 at 12:17:29PM +0100, Stefan Priebe - Profihost AG wrote:
> >>>> Hello,
> >>>>
> >>>> currently i'm trying to fix a problem where we have "random" missing
> >>>> packets.
> >>>>
> >>>> We're doing an ssh connect from machine a to machine b every 5 minutes
> >>>> via rsync and ssh.
> >>>>
> >>>> Sometimes it happens that we get this cron message:
> >>>> "Connection to 192.168.0.2 closed by remote host.
> >>>> rsync: connection unexpectedly closed (0 bytes received so far) [sender]
> >>>> rsync error: unexplained error (code 255) at io.c(226) [sender=3.1.2]
> >>>> ssh: connect to host 192.168.0.2 port 22: Connection refused"
> >>>
> >>> Hi Stefan,
> >>> What kind of virtio-net backend are you using? Can you paste your qemu
> >>> command line here?
> >>
> >> Sure netdev part:
> >> -netdev
> >> type=tap,id=net0,ifname=tap317i0,script=/var/lib/qemu-server/pve-bridge,downscript=/var/lib/qemu-server/pve-bridgedown,vhost=on
> >> -device
> >> virtio-net-pci,mac=EA:37:42:5C:F3:33,netdev=net0,bus=pci.0,addr=0x12,id=net0,bootindex=300
> >> -netdev
> >> type=tap,id=net1,ifname=tap317i1,script=/var/lib/qemu-server/pve-bridge,downscript=/var/lib/qemu-server/pve-bridgedown,vhost=on,queues=4
> >> -device
> >> virtio-net-pci,mac=6A:8E:74:45:1A:0B,nedev=net1,bus=pci.0,addr=0x13,id=net1,vectors=10,mq=on,bootindex=301
> > 
> > According to what you have mentioned, the traffic is not heavy for the guests,
> > the dropping shouldn't happen for regular case.
> 
> The avg traffic is around 300kb/s.
> 
> > What is your hardware platform?
> 
> Dual Intel Xeon E5-2680 v4
> 
> > and Which versions are you using for both
> > guest/host kernel
> Kernel v4.4.103
> 
> > and qemu?
> 2.9.1
> 
> > Are there other VMs on the same host?
> Yes.

What about the CPU load? 

> 
> 
> >>> 'Connection refused' usually means that the client gets a TCP Reset rather
> >>> than losing packets, so this might not be a relevant issue.
> >>
> >> Mhm so you mean these might be two seperate ones?
> > 
> > Yes.
> > 
> >>
> >>> Also you can do a tcpdump on both guests and see what happened to SSH packets
> >>> (tcpdump -i tapXXX port 22).
> >>
> >> Sadly not as there's too much traffic on that part as rsync is syncing
> >> every 5 minutes through ssh.
> > 
> > You can do a tcpdump for the entire traffic from the guest and host and compare
> > what kind of packets are dropped if the traffic is not overloaded.
> 
> Are you sure? I don't get why the same amount and same kind of packets
> should be received by both tap which are connected to different bridges
> to different HW and physical interfaces.

Exactly, possibly this would be a host or guest kernel bug cos than qemu issue
you are using vhost kernel as the backend and the two stats are independent,
you might have to check out what is happening inside the traffic.

Wei
