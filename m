Received: from eggs.gnu.org ([2001:4830:134:3::10]:50433)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dYWnb-0003Vb-4o
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 08:12:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dYWnW-0008Tc-1g
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 08:12:51 -0400
Received: from mail-wm0-x234.google.com ([2a00:1450:400c:c09::234]:37966)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1dYWnV-0008Ro-Qv
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 08:12:45 -0400
Received: by mail-wm0-x234.google.com with SMTP id w191so12359217wmw.1
	for <qemu-devel@nongnu.org>; Fri, 21 Jul 2017 05:12:44 -0700 (PDT)
Date: Fri, 21 Jul 2017 13:12:41 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170721121241.GA18014@stefanha-x1.localdomain>
References: <1455443283.33337333.1500618150787.JavaMail.zimbra@redhat.com>
	<945864462.33340808.1500620194836.JavaMail.zimbra@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="YZ5djTAD1cGYuMQK"
Content-Disposition: inline
In-Reply-To: <945864462.33340808.1500620194836.JavaMail.zimbra@redhat.com>
Subject: Re: [Qemu-devel] KVM "fake DAX" flushing interface - discussion
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pankaj Gupta <pagupta@redhat.com>
Cc: kvm-devel <kvm@vger.kernel.org>, Qemu Developers <qemu-devel@nongnu.org>, "linux-nvdimm@lists.01.org" <linux-nvdimm@ml01.01.org>, Rik van Riel <riel@redhat.com>, Dan Williams <dan.j.williams@intel.com>, Stefan Hajnoczi <stefanha@redhat.com>, ross.zwisler@linux.intel.com, Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Nitesh Narayan Lal <nilal@redhat.com>, xiaoguangrong.eric@gmail.com, Haozhong Zhang <haozhong.zhang@intel.com>


--YZ5djTAD1cGYuMQK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 21, 2017 at 02:56:34AM -0400, Pankaj Gupta wrote:
> A] Problems to solve:
> ------------------
>=20
> 1] We are considering two approaches for 'fake DAX flushing interface'.
>    =20
>  1.1] fake dax with NVDIMM flush hints & KVM async page fault
>=20
>      - Existing interface.
>=20
>      - The approach to use flush hint address is already nacked upstream.
>
>      - Flush hint not queued interface for flushing. Applications might=
=20
>        avoid to use it.

This doesn't contradicts the last point about async operation and vcpu
control.  KVM async page faults turn the Address Flush Hints write into
an async operation so the guest can get other work done while waiting
for completion.

>=20
>      - Flush hint address traps from guest to host and do an entire fsync=
=20
>        on backing file which itself is costly.
>=20
>      - Can be used to flush specific pages on host backing disk. We can=
=20
>        send data(pages information) equal to cache-line size(limitation)=
=20
>        and tell host to sync corresponding pages instead of entire disk s=
ync.

Are you sure?  Your previous point says only the entire device can be
synced.  The NVDIMM Adress Flush Hints interface does not involve
address range information.

>=20
>      - This will be an asynchronous operation and vCPU control is returne=
d=20
>        quickly.
>=20
>=20
>  1.2] Using additional para virt device in addition to pmem device(fake d=
ax with device flush)

Perhaps this can be exposed via ACPI as part of the NVDIMM standards
instead of a separate KVM-only paravirt device.

--YZ5djTAD1cGYuMQK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZce+5AAoJEJykq7OBq3PIFbAH/jSdCCHJDmBAoM15NhcbFhz3
VQyBg2oHvp0Rh70raY2tKnvixRRxxT36to+NqOioNrTPEN3kNBmO8Sgks551ov4Q
dsqKSHThnRmf4G8jdv/Dst7dArF56XrCiAfVLtokYf1fkE3HVDiY8VcoFmi825Q5
w5HxTHRYSH/4KhEyv1y2FYWKWWnP7GLT2NxDywiGg1amWEThkhgUjwFwQOeQayr5
IoprsZAP64AcLLxw3qABB9FgMeIhnDIrA6GL9tLEz5YRt9ztRvWkb35FChdV8Jps
XqPhUzC2l7XSRVmt7JeEwDuMWgrUpSGuJ1XT5WtVQxtMwHC2TqWp+T3yYERdqT8=
=suLS
-----END PGP SIGNATURE-----

--YZ5djTAD1cGYuMQK--
