Received: from eggs.gnu.org ([209.51.188.92]:33676)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1hGPYC-00087a-MR
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 10:59:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1hGPYB-00007H-4l
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 10:59:08 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55916)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1hGPYA-00006h-Q9
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 10:59:07 -0400
Date: Tue, 16 Apr 2019 11:58:52 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20190416145852.GF32317@habkost.net>
References: <1555124080-27089-1-git-send-email-puwen@hygon.cn>
	<20190415203917.GA32317@habkost.net>
	<20190416081605.GB31311@redhat.com>
	<20190416142313.GE32317@habkost.net>
	<20190416142745.GP31311@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20190416142745.GP31311@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2] i386: Add new Hygon 'Dhyana' CPU model
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: Pu Wen <puwen@hygon.cn>, qemu-devel@nongnu.org, pbonzini@redhat.com, rth@twiddle.net, mst@redhat.com, marcel.apfelbaum@gmail.com

On Tue, Apr 16, 2019 at 03:27:45PM +0100, Daniel P. Berrang=E9 wrote:
> On Tue, Apr 16, 2019 at 11:23:13AM -0300, Eduardo Habkost wrote:
> > On Tue, Apr 16, 2019 at 09:16:05AM +0100, Daniel P. Berrang=E9 wrote:
> > > On Mon, Apr 15, 2019 at 05:39:17PM -0300, Eduardo Habkost wrote:
> > > > On Sat, Apr 13, 2019 at 10:54:40AM +0800, Pu Wen wrote:
> > > > > Add a new base CPU model called 'Dhyana' to model processors fr=
om Hygon
> > > > > Dhyana(family 18h), which derived from AMD EPYC(family 17h).
> > > > >=20
> > > > > The following features bits have been removed compare to AMD EP=
YC:
> > > > > aes, pclmulqdq, sha_ni
> > > > >=20
> > > > > The Hygon Dhyana support to KVM in Linux is already accepted up=
stream[1].
> > > > > So add Hygon Dhyana support to Qemu is necessary to create Hygo=
n's own
> > > > > CPU model.
> > > > >=20
> > > > > Reference:
> > > > > [1] https://git.kernel.org/tip/fec98069fb72fb656304a3e52265e0c2=
fc9adf87
> > > > >=20
> > > > > Signed-off-by: Pu Wen <puwen@hygon.cn>
> > > >=20
> > > > Thanks for the patch.
> > > >=20
> > > > I'm wondering if we should let the CPU model be used only on
> > > > Hygon hosts, to avoid confusion.
> > >=20
> > > Why should we artificially restrict it ?  All the other CPUs are ab=
le to
> > > be used on any host that is able to support the feature list requir=
ed by
> > > the CPU model. If some other host has sufficient features to run Dh=
yana
> > > the CPU model we shouldn't block it.
> >=20
> > Running it on Intel or AMD hosts will create a frankenstein CPU
> > with vendor=3DAuthenticAMD|GenuineIntel but with
> > family/model/stepping/model_id values that make sense only on
> > Hygon CPUs.  I don't see why this is preferable to simply telling
> > the user that the CPU model is unavailable.
>=20
> IIUC, you're saying that we don't (can't?) honour the "vendor" field
> QEMU has listed against the CPU model, so the guest sees the vendor
> of the real physical host ?
>=20
> If so that's news to me, and does indeed make it interesting to
> disable the mismatched combination.
>=20
> > If somebody really needs that specific set of features and know
> > they are runnable on their AMD host, they can easily run
> > "-cpu EPYC,+aes,+pclmulqdq,+sha-ni".
> >=20
> > We have the same issue with Intel & AMD CPUs.  The only reason we
> > don't prevent this with AMD or Intel CPU models is our huge fear
> > of breaking backwards compatibility.
>=20
> We could put a deprecation warning that we intended to stop allowing
> this mismatch Intel/AMD guest vs host models and tie it to machine
> type.
>=20
> ie, if we deprecate in 4.1, then in 5.0 we can make pc-i440fx-5.0
> machine type refuse to allow this combination.
>=20
> That way existing deployed guests keep working, and users get some
> warning that we're going to stop future guests doing this.

Yes, it makes sense.

I would prefer to make pc-4.2 refuse to allow this combination,
but this would require making libvirt versions released before
QEMU 4.2 not translate "pc" to "pc-4.2".

--=20
Eduardo
