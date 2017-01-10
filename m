Received: from eggs.gnu.org ([2001:4830:134:3::10]:48880)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cQv9r-0007qo-7T
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 07:04:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cQv9o-0001ts-4H
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 07:04:07 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42560)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1cQv9n-0001tQ-SD
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 07:04:04 -0500
Date: Tue, 10 Jan 2017 12:03:54 +0000
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170110120354.GH27720@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <58733617.3050503@huawei.com>
	<20170109134310.GE30228@stefanha-x1.localdomain>
	<20170109162504.GH29989@redhat.com>
	<33183CC9F5247A488A2544077AF19020DA182982@DGGEMA505-MBX.china.huawei.com>
	<20170110100355.GD27720@redhat.com>
	<33183CC9F5247A488A2544077AF19020DA182ADA@DGGEMA505-MBX.china.huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <33183CC9F5247A488A2544077AF19020DA182ADA@DGGEMA505-MBX.china.huawei.com>
Subject: Re: [Qemu-devel] Question about add AF_ALG backend for virtio-crypto
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Gonglei (Arei)" <arei.gonglei@huawei.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, longpeng <longpeng2@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>, QEMU-DEV <qemu-devel@nongnu.org>, "Wubin (H)" <wu.wubin@huawei.com>, "Zhoujian (jay, Euler)" <jianjay.zhou@huawei.com>

On Tue, Jan 10, 2017 at 11:36:19AM +0000, Gonglei (Arei) wrote:
> Hi Daniel,
> 
> >
> > >
> > > >
> > > > On Mon, Jan 09, 2017 at 01:43:10PM +0000, Stefan Hajnoczi wrote:
> > > > > On Mon, Jan 09, 2017 at 03:04:55PM +0800, Longpeng (Mike) wrote:
> > > > > > I'm one of Gonglei's virtio-crypto project members, and we plan to add a
> > > > AF_ALG
> > > > > > backend for virtio-crypto(there's only builtin-backend currently).
> > > > > >
> > > > > > I found that Catalin, Paolo and Stefan had discussed about this in 2015
> > > > > > (http://www.spinics.net/lists/kvm/msg115457.html), but it seems that
> > > > Catalin
> > > > > > didn't do it, so I'm confuse about wether it is need to add a AF_ALG
> > > > backend.
> > > > > >
> > > > > > Do you have any suggestion? Thanks :)
> > > > >
> > > > > I have no objections to an AF_ALG backend in QEMU.
> > > >
> > > > Rather than do another backend for virtio-crypto, IMHO, we should have
> > > > an AF_ALG impl of the crypto/ APIs. That way any potential performance
> > > > benefits will enhance our LUKS encryption code too.
> > > >
> > > According to the currently schemas of crypto/ APIs, we can't choose the
> > > specific backend dynamically. This is a limitation for virtio-crypto
> > > device I think.
> > 
> > Do we really need to be able to choose the backend explicitly. If the AF_ALG
> > backend is faster, why would you simply not use that automatically if it is
> > available.
> 
> Can we realize the purpose based on the crypto/ APIs? IIUC the crypto
> subsystem chooses a backend during the building according to the specific priority,
> nettle > gcrypt > cipher-builtin.
> 
> If we add an AF_ALG implementation for crypto subsystem, shall we set it
> as the highest priority? If so, other backends won't be used since AF_ALG
> is always available. If not, how can we use AF_ALG backend for crypto/ API?
> 
> Please correct me if I'm missing something.

While AF_ALG has been available for a while, not all features have. For
example AEAD support was only added in kernel 4.1

So if we had AF_ALG in QEMU, we would have to have a stacked impl, where
we try AF_ALG and then fallback to the current code when QEMU runs on a
kernel lacking the feature needed.

We could potentially also have a global arg to switch backends e.g.

 -crypto-backend [afalg|builtin]


Regards,
Daniel
-- 
|: http://berrange.com      -o-    http://www.flickr.com/photos/dberrange/ :|
|: http://libvirt.org              -o-             http://virt-manager.org :|
|: http://entangle-photo.org       -o-    http://search.cpan.org/~danberr/ :|
