Received: from eggs.gnu.org ([2001:4830:134:3::10]:54627)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cEd9W-0005g6-Al
	for qemu-devel@nongnu.org; Wed, 07 Dec 2016 09:24:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cEd9T-0002rX-6t
	for qemu-devel@nongnu.org; Wed, 07 Dec 2016 09:24:58 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54144)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1cEd9T-0002rQ-1A
	for qemu-devel@nongnu.org; Wed, 07 Dec 2016 09:24:55 -0500
Date: Wed, 7 Dec 2016 14:24:49 +0000
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20161207142449.GC1476@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <CAFEAcA9kODkdK96a=rdZS7+xSW0drj4vLMev-AVio-uewm6Cbw@mail.gmail.com>
	<20161207120419.GA1476@redhat.com>
	<CAFEAcA8UofRa9Yo93vsFYDqJaW5YuKKF68X+2ae=GKdp8w9HWg@mail.gmail.com>
	<20161207140715.GB1476@redhat.com>
	<CAFEAcA-8P3cv=ce_jjQRAa5Oh-1EDUByuJq-tX2sX29vVm-5mQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFEAcA-8P3cv=ce_jjQRAa5Oh-1EDUByuJq-tX2sX29vVm-5mQ@mail.gmail.com>
Subject: Re: [Qemu-devel] qemu -netdev tun/tap support can't handle macvtap
 type devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Jason Wang <jasowang@redhat.com>

On Wed, Dec 07, 2016 at 02:21:24PM +0000, Peter Maydell wrote:
> On 7 December 2016 at 14:07, Daniel P. Berrange <berrange@redhat.com> wrote:
> > On Wed, Dec 07, 2016 at 12:30:31PM +0000, Peter Maydell wrote:
> >> On 7 December 2016 at 12:04, Daniel P. Berrange <berrange@redhat.com> wrote:
> >> > On Wed, Dec 07, 2016 at 12:01:14PM +0000, Peter Maydell wrote:
> >> >> The usual suggested workaround is to use the -netdev fd option, like
> >> >>   fd=3 3<>/dev/tap$(< /sys/class/net/tap0/ifindex)
> >> >> (which gets the shell to open the right /dev/tap device).
> >> >> Unfortunately this isn't compatible with multi-queue support
> >> >> because netdev complains
> >> >> "ifname=, script=, downscript=, vnet_hdr=, helper=, queues=, fds=,
> >> >> and vhostfds= are invalid with fd="
> >> >> so you can't pass options like "queues=4"...
> >> >
> >> > FWIW you should be able to instead do
> >> >
> >> >    fds=3 3<>/dev/tap$(< /sys/class/net/tap0/ifindex)
> >> >
> >> > note 'fds' plural, instead of 'fd'
> >>
> >> What's the difference between that and the "usual suggested workaround"
> >> I described above that doesn't work with queues=... ?
> >
> > It just seems the 'queues' param always wants you to use 'fds' instead
> > of 'fd' - 'fds' takes a comma-separated list of FDs - one per queue
> > and 'fd' only takes a single FD.
> 
> Oh, I see. That seems a bit obscure :-)

And pointless, because QemuOpts would have allowed use of 'fd' multiple
times instead of inventing a new arg.  fd=1,fd=3,fd=6 could have worked
fine with multi-queue :-(

Regards,
Daniel
-- 
|: http://berrange.com      -o-    http://www.flickr.com/photos/dberrange/ :|
|: http://libvirt.org              -o-             http://virt-manager.org :|
|: http://entangle-photo.org       -o-    http://search.cpan.org/~danberr/ :|
