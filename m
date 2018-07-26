Received: from eggs.gnu.org ([2001:4830:134:3::10]:59680)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1fiatB-0002dl-Rb
	for qemu-devel@nongnu.org; Thu, 26 Jul 2018 03:40:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1fiat8-00012m-Sg
	for qemu-devel@nongnu.org; Thu, 26 Jul 2018 03:40:45 -0400
Received: from hera.aquilenet.fr ([2a0c:e300::1]:38716)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <samuel.thibault@ens-lyon.org>)
	id 1fiat8-00012B-K0
	for qemu-devel@nongnu.org; Thu, 26 Jul 2018 03:40:42 -0400
Date: Thu, 26 Jul 2018 09:40:38 +0200
From: Samuel Thibault <samuel.thibault@gnu.org>
Message-ID: <20180726074038.55k64nkf7fqtbpzl@var.youpi.perso.aquilenet.fr>
References: <20180725121311.12867.21729.stgit@pasha-VirtualBox>
	<20180725121706.12867.98787.stgit@pasha-VirtualBox>
	<20180725134429.roe7iuzakjywdv7e@var.youpi.perso.aquilenet.fr>
	<000601d424af$74e5c900$5eb15b00$@ru>
	<20180726073549.j277pe6ykdtgbn6k@var.youpi.perso.aquilenet.fr>
	<000701d424b3$74319760$5c94c620$@ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000701d424b3$74319760$5c94c620$@ru>
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

Pavel Dovgalyuk, le jeu. 26 juil. 2018 10:37:03 +0300, a ecrit:
> > From: Samuel Thibault [mailto:samuel.thibault@gnu.org]
> > Pavel Dovgalyuk, le jeu. 26 juil. 2018 10:08:29 +0300, a ecrit:
> > > > As documented:
> > > >
> > > >  * @QEMU_CLOCK_REALTIME: Real time clock
> > > >  *
> > > >  * The real time clock should be used only for stuff which does not
> > > >  * change the virtual machine state, as it runs even if the virtual
> > > >  * machine is stopped.
> > > >
> > > > There is no reason to "send RAs" while the machine is stopped.
> > >
> > > I see.
> > > Then we'll need one more clock. Which works like realtime+virtual:
> > > intended to be used for the internal QEMU purposes, but stops when
> > > VM is stopped.
> > 
> > Just to be sure: what is meant by "is stopped"? Is it a pause (thus time
> > does not advance within the guest), or is it just sleeping because it
> > has nothing to do?
> 
> Paused with HMP/QMP command.
> As virtual clock runs only if VM is not paused.

Then all other uses of qemu_clock in slirp are bogus and need to be
fixed like ip6_icmp: they are using QEMU_CLOCK_REALTIME, but they want
it not to progress while the guest time is not advancing. Otherwise on
guest resume after a long pause basically all TCP/UDP/ARP timings will
have expired.

Samuel
