Received: from eggs.gnu.org ([2001:4830:134:3::10]:37692)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1fibIz-0004pH-O0
	for qemu-devel@nongnu.org; Thu, 26 Jul 2018 04:07:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1fibIw-0000jh-NX
	for qemu-devel@nongnu.org; Thu, 26 Jul 2018 04:07:25 -0400
Received: from hera.aquilenet.fr ([185.233.100.1]:37696)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <samuel.thibault@ens-lyon.org>)
	id 1fibIw-0000fs-GS
	for qemu-devel@nongnu.org; Thu, 26 Jul 2018 04:07:22 -0400
Date: Thu, 26 Jul 2018 10:07:18 +0200
From: Samuel Thibault <samuel.thibault@gnu.org>
Message-ID: <20180726080718.pdzxwxoj4sjjpycm@var.youpi.perso.aquilenet.fr>
References: <20180725121311.12867.21729.stgit@pasha-VirtualBox>
	<20180725121706.12867.98787.stgit@pasha-VirtualBox>
	<20180725134429.roe7iuzakjywdv7e@var.youpi.perso.aquilenet.fr>
	<000601d424af$74e5c900$5eb15b00$@ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000601d424af$74e5c900$5eb15b00$@ru>
Subject: Re: [Qemu-devel] [PATCH v5 24/24] slirp: fix ipv6 timers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pavel Dovgalyuk <dovgaluk@ispras.ru>
Cc: 'Pavel Dovgalyuk' <Pavel.Dovgaluk@ispras.ru>, qemu-devel@nongnu.org, kwolf@redhat.com, peter.maydell@linaro.org, war2jordan@live.com, pbonzini@redhat.com, quintela@redhat.com, ciro.santilli@gmail.com, jasowang@redhat.com, crosthwaite.peter@gmail.com, zuban32s@gmail.com, armbru@redhat.com, maria.klimushenkova@ispras.ru, mst@redhat.com, kraxel@redhat.com, boost.lists@gmail.com, thomas.dullien@googlemail.com, mreitz@redhat.com, alex.bennee@linaro.org, dgilbert@redhat.com, rth@twiddle.net

Pavel Dovgalyuk, le jeu. 26 juil. 2018 10:08:29 +0300, a ecrit:
> virtual clock should be used by the virtual devices.
> slirp module is not the virtual device. Therefore processed packets
> become visible to the guest after passing to the virtual network card.
> Before that it can create any timers that should not change the state of the guest.

I'm not sure I understand that part correctly. slirp is not a "device"
strictly speaking, but it has a whole foot in the virtual world. All
TCP/UDP/ARP/RA timings are related to the guest timing, so

> > > this service is not related to the guest state.

seems incorrect. At the moment the ip6_icmp timer's current value is not
saved in the guest state, but in principle it should, so that the guest
does see the RAs at a regular rate. In practice we don't care because
the timing is randomized anyway.

> intended to be used for the internal QEMU purposes, but stops when VM
> is stopped.

I again don't understand this. The ip6_icmp timing is not for internal
QEMU purpose, its whole point is how often RAs are sent to the guest.

slirp's guest part is not a device as directly seen by guest I/O, but
it's a router device as seen through guest packets. Think of it like a
USB device, which is seen by the guest through USB packets.

Samuel
