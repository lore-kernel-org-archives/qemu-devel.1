Received: from eggs.gnu.org ([2001:4830:134:3::10]:42534)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gRHNb-0003Um-Fp
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 08:56:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gRHNY-0003eV-RJ
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 08:56:51 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54436)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1gRHNW-0003dn-TG
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 08:56:48 -0500
Date: Mon, 26 Nov 2018 14:56:43 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20181126135643.442lbaj2dz35gdso@sirius.home.kraxel.org>
References: <20181126100836.8805-1-kraxel@redhat.com>
	<BN6PR18MB1220C6FD680DB5E2C2AEA9F09FD70@BN6PR18MB1220.namprd18.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <BN6PR18MB1220C6FD680DB5E2C2AEA9F09FD70@BN6PR18MB1220.namprd18.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] ehci: fix fetch qtd race
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: li qiang <liq3ea@outlook.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

On Mon, Nov 26, 2018 at 10:34:13AM +0000, li qiang wrote:
>=20
> =E5=9C=A8 2018/11/26 18:08, Gerd Hoffmann =E5=86=99=E9=81=93:
> > The token field contains the (guest-filled) state of the qtd, which
> > indicates whenever the other fields are valid or not.  So make sure
> > we read the token first, otherwise we may end up with an stale next
> > pointer:
> >
> >    (1) ehci reads next
> >    (2) guest writes next
> >    (3) guest writes token
> >    (4) ehci reads token
> >    (5) ehci operates with stale next.
>=20
> Hello Gerd,
>=20
> Could you please explain how this can happen?
>=20
> IMO, the device emulation holds the BQL and the guest can't execute, ho=
w=20
> can the guest

No.  vcpus can run in parallel to the iothread (at least as long as they
are running in guest context, when they vmexit they have to wait for the
BQL).

cheers,
  Gerd
