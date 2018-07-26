Received: from eggs.gnu.org ([2001:4830:134:3::10]:55770)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1fiaO1-00023h-OU
	for qemu-devel@nongnu.org; Thu, 26 Jul 2018 03:08:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1fiaNy-0000UD-MW
	for qemu-devel@nongnu.org; Thu, 26 Jul 2018 03:08:33 -0400
Received: from mail.ispras.ru ([83.149.199.45]:32862)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1fiaNy-0000Ro-DP
	for qemu-devel@nongnu.org; Thu, 26 Jul 2018 03:08:30 -0400
From: "Pavel Dovgalyuk" <dovgaluk@ispras.ru>
References: <20180725121311.12867.21729.stgit@pasha-VirtualBox>
	<20180725121706.12867.98787.stgit@pasha-VirtualBox>
	<20180725134429.roe7iuzakjywdv7e@var.youpi.perso.aquilenet.fr>
In-Reply-To: <20180725134429.roe7iuzakjywdv7e@var.youpi.perso.aquilenet.fr>
Date: Thu, 26 Jul 2018 10:08:29 +0300
Message-ID: <000601d424af$74e5c900$5eb15b00$@ru>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Language: ru
Subject: Re: [Qemu-devel] [PATCH v5 24/24] slirp: fix ipv6 timers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: 'Samuel Thibault' <samuel.thibault@gnu.org>, 'Pavel Dovgalyuk' <Pavel.Dovgaluk@ispras.ru>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, peter.maydell@linaro.org, war2jordan@live.com, pbonzini@redhat.com, quintela@redhat.com, ciro.santilli@gmail.com, jasowang@redhat.com, crosthwaite.peter@gmail.com, zuban32s@gmail.com, armbru@redhat.com, maria.klimushenkova@ispras.ru, mst@redhat.com, kraxel@redhat.com, boost.lists@gmail.com, thomas.dullien@googlemail.com, mreitz@redhat.com, alex.bennee@linaro.org, dgilbert@redhat.com, rth@twiddle.net

> From: Samuel Thibault [mailto:samuel.thibault@gnu.org]
> Pavel Dovgalyuk, le mer. 25 juil. 2018 15:17:06 +0300, a ecrit:
> > ICMP implementation for IPv6 uses timers based on virtual clock.
> > This is incorrect because this service is not related to the guest state.
> 
> ? Why not?  The RAs are seen by the guest.  

Because virtual clock should be used by the virtual devices.
slirp module is not the virtual device. Therefore processed packets
become visible to the guest after passing to the virtual network card.
Before that it can create any timers that should not change the state of the guest.

> As documented:
> 
>  * @QEMU_CLOCK_REALTIME: Real time clock
>  *
>  * The real time clock should be used only for stuff which does not
>  * change the virtual machine state, as it runs even if the virtual
>  * machine is stopped.
> 
> There is no reason to "send RAs" while the machine is stopped.

I see.
Then we'll need one more clock. Which works like realtime+virtual:
intended to be used for the internal QEMU purposes, but stops when
VM is stopped.

Pavel Dovgalyuk
