Received: from eggs.gnu.org ([2001:4830:134:3::10]:44929)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wexu@redhat.com>) id 1eWN5a-0004tH-Eo
	for qemu-devel@nongnu.org; Tue, 02 Jan 2018 08:58:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wexu@redhat.com>) id 1eWN5V-00034J-HC
	for qemu-devel@nongnu.org; Tue, 02 Jan 2018 08:58:46 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45802)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wexu@redhat.com>) id 1eWN5V-00031r-AU
	for qemu-devel@nongnu.org; Tue, 02 Jan 2018 08:58:41 -0500
Date: Tue, 2 Jan 2018 22:20:54 +0800
From: Wei Xu <wexu@redhat.com>
Message-ID: <20180102142054.jqhbg3zrhjlppg2q@Wei-Dev>
References: <77f0c119-236d-9d4e-0a99-3519ecc26b23@profihost.ag>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <77f0c119-236d-9d4e-0a99-3519ecc26b23@profihost.ag>
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

On Tue, Jan 02, 2018 at 12:17:29PM +0100, Stefan Priebe - Profihost AG wrote:
> Hello,
> 
> currently i'm trying to fix a problem where we have "random" missing
> packets.
> 
> We're doing an ssh connect from machine a to machine b every 5 minutes
> via rsync and ssh.
> 
> Sometimes it happens that we get this cron message:
> "Connection to 192.168.0.2 closed by remote host.
> rsync: connection unexpectedly closed (0 bytes received so far) [sender]
> rsync error: unexplained error (code 255) at io.c(226) [sender=3.1.2]
> ssh: connect to host 192.168.0.2 port 22: Connection refused"

Hi Stefan,
What kind of virtio-net backend are you using? Can you paste your qemu
command line here?

'Connection refused' usually means that the client gets a TCP Reset rather
than losing packets, so this might not be a relevant issue.

Also you can do a tcpdump on both guests and see what happened to SSH packets
(tcpdump -i tapXXX port 22).

> 
> The tap devices on the target vm shows dropped RX packages on BOTH tap
> interfaces - strangely with the same amount of pkts?
> 
> # ifconfig tap317i0; ifconfig tap317i1
> tap317i0  Link encap:Ethernet  HWaddr 6e:cb:65:94:bb:bf
>           UP BROADCAST RUNNING PROMISC MULTICAST  MTU:1500  Metric:1
>           RX packets:2238445 errors:0 dropped:13159 overruns:0 frame:0
>           TX packets:9655853 errors:0 dropped:0 overruns:0 carrier:0
>           collisions:0 txqueuelen:1000
>           RX bytes:177991267 (169.7 MiB)  TX bytes:910412749 (868.2 MiB)
> 
> tap317i1  Link encap:Ethernet  HWaddr 96:f8:b5:d0:9a:07
>           UP BROADCAST RUNNING PROMISC MULTICAST  MTU:1500  Metric:1
>           RX packets:1516085 errors:0 dropped:13159 overruns:0 frame:0
>           TX packets:1446964 errors:0 dropped:0 overruns:0 carrier:0
>           collisions:0 txqueuelen:1000
>           RX bytes:1597564313 (1.4 GiB)  TX bytes:3517734365 (3.2 GiB)
> 
> Any ideas how to inspect this issue?

It seems both tap interfaces lose RX pkts, dropping pkts of RX means the
host(backend) cann't receive packets from the guest as fast as the guest sends.

Are you running some symmetrical test on both guests? 

Wei

> 
> Greets,
> Stefan
> 
