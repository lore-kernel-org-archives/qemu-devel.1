Received: from eggs.gnu.org ([2001:4830:134:3::10]:41382)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cj9QL-0007Cg-K6
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 13:56:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cj9QJ-0006CH-2z
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 13:56:29 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55480)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1cj9QI-0006Bj-Qe
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 13:56:27 -0500
Date: Wed, 1 Mar 2017 18:56:17 +0000
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170301185617.GT10160@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20170301163104.GJ10160@redhat.com>
	<20170301185414-mutt-send-email-mst@kernel.org>
	<1d155a66-8806-8792-b82d-4bebabcd4971@linux.vnet.ibm.com>
	<20170301191459-mutt-send-email-mst@kernel.org>
	<4022b3c9-56c3-7cea-928c-9e0e7d070d90@linux.vnet.ibm.com>
	<20170301173823.GO10160@redhat.com>
	<20170301194704-mutt-send-email-mst@kernel.org>
	<20170301181117.GR10160@redhat.com>
	<20170301201347-mutt-send-email-mst@kernel.org>
	<CAJ+F1CKM1JEqCv5mVUmP8E8WxEsjKY7zVTqqcTckvgmCDgmrEw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJ+F1CKM1JEqCv5mVUmP8E8WxEsjKY7zVTqqcTckvgmCDgmrEw@mail.gmail.com>
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
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Stefan Berger <stefanb@linux.vnet.ibm.com>, Stefan Berger <stefanb@us.ibm.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, "SERBAN, CRISTINA" <cs1731@att.com>, "Xu, Quan" <quan.xu@intel.com>, "silviu.vlasceanu@gmail.com" <silviu.vlasceanu@gmail.com>, "hagen.lauer@huawei.com" <hagen.lauer@huawei.com>, "SHIH, CHING C" <cs1815@att.com>

On Wed, Mar 01, 2017 at 06:32:19PM +0000, Marc-Andr=C3=A9 Lureau wrote:
> Hi
>=20
> On Wed, Mar 1, 2017 at 10:20 PM Michael S. Tsirkin <mst@redhat.com> wro=
te:
>=20
> >
> > > You're also tieing the code
> > > into the QEMU release cycle, again for no tangible benefit.
> >
> > No need for ABI stability would be the benefit.
> >
>=20
> We are talking about the control channel ABI (the data channel is using=
 TCG
> defined command streams afaict - don't remember what it is called)
>=20
>=20
> >
> > > Conceptually
> > > swtpm does not depend on, or require, QEMU to be useful - it can ha=
ve
> > > other non-QEMU consumers - bundling with QEMU is not helpful there.
> >
> > Maybe it could but it isn't.
> >
>=20
> Right, it would be reasonable to have qemu provide it's own private "sw=
tpm"
> (linking with libtpms, doing most of the job), that way it wouldn't hav=
e to
> rely on a stable ABI (as long as the process isn't shared across differ=
ent
> qemu versions, which should be quite easy to achieve)

I think we need to expect to have a stable ABI no matter what. During
upgrade cycles, it is desirable to be able to upgrade the swtpm process
assocatied with a running VM. Whether this is done by restarting the
process & having QEMU reconnect, or by re-exec'ing swtpm and keeping the
FD open, you still end up with newer swtpm talking to an older QEMU. Or
conversely you might have setup swtpm processes to populate a number of
CUSE devices, and then later launch QEMU binaries to connect to them - at
which point there's no guarantee the QEMU version hasn't been upgraded -
or the user could have requested a custom QEMU binary to virt-install,
etc.


Regards,
Daniel
--=20
|: http://berrange.com      -o-    http://www.flickr.com/photos/dberrange=
/ :|
|: http://libvirt.org              -o-             http://virt-manager.or=
g :|
|: http://entangle-photo.org       -o-    http://search.cpan.org/~danberr=
/ :|
