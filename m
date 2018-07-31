Received: from eggs.gnu.org ([2001:4830:134:3::10]:49267)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1fkOc2-0001ou-0u
	for qemu-devel@nongnu.org; Tue, 31 Jul 2018 02:58:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1fkOby-0005yS-VL
	for qemu-devel@nongnu.org; Tue, 31 Jul 2018 02:58:30 -0400
Received: from mail.ispras.ru ([83.149.199.45]:36926)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1fkOby-0005y5-Hd
	for qemu-devel@nongnu.org; Tue, 31 Jul 2018 02:58:26 -0400
From: "Pavel Dovgalyuk" <dovgaluk@ispras.ru>
References: <20180725121311.12867.21729.stgit@pasha-VirtualBox>
	<20180725121706.12867.98787.stgit@pasha-VirtualBox>
	<20180725134429.roe7iuzakjywdv7e@var.youpi.perso.aquilenet.fr>
	<000601d424af$74e5c900$5eb15b00$@ru>
	<20180726080718.pdzxwxoj4sjjpycm@var.youpi.perso.aquilenet.fr>
	<000801d424bb$f4b23130$de169390$@ru>
	<20180726091527.j3zw677cprhpfazu@var.youpi.perso.aquilenet.fr>
In-Reply-To: <20180726091527.j3zw677cprhpfazu@var.youpi.perso.aquilenet.fr>
Date: Tue, 31 Jul 2018 09:58:26 +0300
Message-ID: <000101d4289b$e1874e90$a495ebb0$@ru>
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
To: 'Samuel Thibault' <samuel.thibault@gnu.org>
Cc: 'Pavel Dovgalyuk' <Pavel.Dovgaluk@ispras.ru>, qemu-devel@nongnu.org, kwolf@redhat.com, peter.maydell@linaro.org, war2jordan@live.com, pbonzini@redhat.com, quintela@redhat.com, ciro.santilli@gmail.com, jasowang@redhat.com, crosthwaite.peter@gmail.com, zuban32s@gmail.com, armbru@redhat.com, maria.klimushenkova@ispras.ru, mst@redhat.com, kraxel@redhat.com, boost.lists@gmail.com, thomas.dullien@googlemail.com, mreitz@redhat.com, alex.bennee@linaro.org, dgilbert@redhat.com, rth@twiddle.net

> From: Samuel Thibault [mailto:samuel.thibault@gnu.org]
> Pavel Dovgalyuk, le jeu. 26 juil. 2018 11:37:57 +0300, a ecrit:
> > > From: Samuel Thibault [mailto:samuel.thibault@gnu.org]
> > > Pavel Dovgalyuk, le jeu. 26 juil. 2018 10:08:29 +0300, a ecrit:
> > > > virtual clock should be used by the virtual devices.
> > > > slirp module is not the virtual device. Therefore processed packets
> > > > become visible to the guest after passing to the virtual network card.
> > > > Before that it can create any timers that should not change the state of the guest.
> > >
> > > I'm not sure I understand that part correctly. slirp is not a "device"
> > > strictly speaking, but it has a whole foot in the virtual world. All
> > > TCP/UDP/ARP/RA timings are related to the guest timing, so
> >
> > I don't know all details of slirp, so let me ask:
> > if the virtual timer runs very slowly (when it configured this way with icount option),
> > should the timings relate this speed?
> 
> Yes. Otherwise the guest will not be fast enough to answer promptly
> according to slirp's TCP delays.
> 
> > Or the timers are related to the network devices (e.g., servers in the
> > outer world)?
> 
> No.
> 
> > > > > > this service is not related to the guest state.
> > >
> > > seems incorrect. At the moment the ip6_icmp timer's current value is not
> > > saved in the guest state, but in principle it should, so that the guest
> > > does see the RAs at a regular rate. In practice we don't care because
> > > the timing is randomized anyway.
> >
> > Isn't this just a side effect?
> > I mean that slirp may be replaced by, say, tap, and the guest should not notice
> > the difference.
> 
> Well, if a guest is connected through a tap, the virtual time should
> really run as fast as the realtime, and it should not be paused.
> Otherwise TCP connections will break since the guest won't be able to
> reply fast enough, without even knowing about the issue. Slirp can
> compensate this thanks to a buffer between what happens in the real
> world and what happens in the virtual world. Real world timings are
> handled by the OS socket implementation, and virtual world timings are
> handled with the qemu timer.

Then maybe the solution is the new clock with the frequency of the virtual
clock, but which does not affect the replayed core?
This clock should stop when VM is paused.
It also could be saved in vmstate. As it does not affect the replay,
saving and restoring its state won't break anything.

> > > > intended to be used for the internal QEMU purposes, but stops when VM
> > > > is stopped.
> > >
> > > I again don't understand this. The ip6_icmp timing is not for internal
> > > QEMU purpose, its whole point is how often RAs are sent to the guest.
> > >
> > > slirp's guest part is not a device as directly seen by guest I/O, but
> > > it's a router device as seen through guest packets. Think of it like a
> > > USB device, which is seen by the guest through USB packets.
> >
> > Record/replay implementation creates a line between the guest state and
> > the outer world. Everything crossing this line is saved in the log replayed.
> > In case of network, this line is implemented with the network filter.
> > It takes packets from slirp(or anything) and passes(or not) them to the guest nic.
> > When replaying, the saved packets are injected into the filter directly.
> 
> > Slirp is the part of the outer world,
> 
> In normal uses it is not. It is a virtual world (its DHCP server, tftp
> server, TCP connexions, etc.) that lives along the guest.
> 
> Now, I understand that for record/replay it's simpler to put the line
> after slirp.
> 
> Ideally slirp's state should ideally be split it two: the part connected
> to the real world (data from/to the sockets), and the part connected to
> the virtual world (TCP buffering with the guest). So that when pausing,
> going back, going forward etc. the slirp buffers act accordingly, TCP
> knowing exactly what is supposed to be sent or not (otherwise, TCP
> would for instance be really astonished if the guest happens to insist
> requesting old data that it has already ACKed).
> 
> But that's tricky, and I understand it's simpler to just put the line
> after slirp, and let the replay of frames provide the guest (which for
> instance has been reset to an older time) with the missing data, and TCP
> will nicely cope with duplicate ACKs and spurious re-emissions from the
> guest.
> 
> That being said, there will be problems with TCP connections if you
> pause the guest for a long time: slirp's TCP will timeout and reset the
> connexion. Yes, that happens with tap devices anyway, but slirp acting
> as a buffer seems more useful to me.

Pavel Dovgalyuk
