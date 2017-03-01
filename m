Received: from eggs.gnu.org ([2001:4830:134:3::10]:40439)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1cjCeG-0007gJ-Mu
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 17:23:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1cjCeC-0001DM-Ss
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 17:23:04 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60034)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1cjCeC-0001DA-KZ
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 17:23:00 -0500
Date: Thu, 2 Mar 2017 00:22:54 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20170302001915-mutt-send-email-mst@kernel.org>
References: <20170301185414-mutt-send-email-mst@kernel.org>
	<1d155a66-8806-8792-b82d-4bebabcd4971@linux.vnet.ibm.com>
	<20170301191459-mutt-send-email-mst@kernel.org>
	<4022b3c9-56c3-7cea-928c-9e0e7d070d90@linux.vnet.ibm.com>
	<20170301173823.GO10160@redhat.com>
	<20170301194704-mutt-send-email-mst@kernel.org>
	<20170301181117.GR10160@redhat.com>
	<20170301201347-mutt-send-email-mst@kernel.org>
	<CAJ+F1CKM1JEqCv5mVUmP8E8WxEsjKY7zVTqqcTckvgmCDgmrEw@mail.gmail.com>
	<20170301185617.GT10160@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20170301185617.GT10160@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v5 1/4] Provide support for the CUSE TPM
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@gmail.com>, Stefan Berger <stefanb@linux.vnet.ibm.com>, Stefan Berger <stefanb@us.ibm.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, "SERBAN, CRISTINA" <cs1731@att.com>, "Xu, Quan" <quan.xu@intel.com>, "silviu.vlasceanu@gmail.com" <silviu.vlasceanu@gmail.com>, "hagen.lauer@huawei.com" <hagen.lauer@huawei.com>, "SHIH, CHING C" <cs1815@att.com>

On Wed, Mar 01, 2017 at 06:56:17PM +0000, Daniel P. Berrange wrote:
> On Wed, Mar 01, 2017 at 06:32:19PM +0000, Marc-Andr=E9 Lureau wrote:
> > Hi
> >=20
> > On Wed, Mar 1, 2017 at 10:20 PM Michael S. Tsirkin <mst@redhat.com> w=
rote:
> >=20
> > >
> > > > You're also tieing the code
> > > > into the QEMU release cycle, again for no tangible benefit.
> > >
> > > No need for ABI stability would be the benefit.
> > >
> >=20
> > We are talking about the control channel ABI (the data channel is usi=
ng TCG
> > defined command streams afaict - don't remember what it is called)
> >=20
> >=20
> > >
> > > > Conceptually
> > > > swtpm does not depend on, or require, QEMU to be useful - it can =
have
> > > > other non-QEMU consumers - bundling with QEMU is not helpful ther=
e.
> > >
> > > Maybe it could but it isn't.
> > >
> >=20
> > Right, it would be reasonable to have qemu provide it's own private "=
swtpm"
> > (linking with libtpms, doing most of the job), that way it wouldn't h=
ave to
> > rely on a stable ABI (as long as the process isn't shared across diff=
erent
> > qemu versions, which should be quite easy to achieve)
>=20
> I think we need to expect to have a stable ABI no matter what. During
> upgrade cycles, it is desirable to be able to upgrade the swtpm process
> assocatied with a running VM.

Why? It should be part of the same rpm as QEMU,
upgrading QEMU requires VM restart and so should this.

We really really do not want a stable ABI if we can get
away with not having one.

> Whether this is done by restarting the
> process & having QEMU reconnect, or by re-exec'ing swtpm and keeping th=
e
> FD open, you still end up with newer swtpm talking to an older QEMU. Or
> conversely you might have setup swtpm processes to populate a number of
> CUSE devices, and then later launch QEMU binaries to connect to them - =
at
> which point there's no guarantee the QEMU version hasn't been upgraded =
-
> or the user could have requested a custom QEMU binary to virt-install,
> etc.

Sounds like feature creep to me. A separate processes for parts of QEMU
for extra security make sense. Stable ABI between parts does not.

>=20
> Regards,
> Daniel
> --=20
> |: http://berrange.com      -o-    http://www.flickr.com/photos/dberran=
ge/ :|
> |: http://libvirt.org              -o-             http://virt-manager.=
org :|
> |: http://entangle-photo.org       -o-    http://search.cpan.org/~danbe=
rr/ :|
