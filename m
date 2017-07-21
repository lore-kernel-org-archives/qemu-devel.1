Received: from eggs.gnu.org ([2001:4830:134:3::10]:33418)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dYaKO-000270-5z
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 11:58:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dYaKK-0002iO-AA
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 11:58:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34464)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1dYaKK-0002hL-0p
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 11:58:52 -0400
Date: Fri, 21 Jul 2017 16:58:48 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170721155848.GO18014@stefanha-x1.localdomain>
References: <1455443283.33337333.1500618150787.JavaMail.zimbra@redhat.com>
	<945864462.33340808.1500620194836.JavaMail.zimbra@redhat.com>
	<20170721121241.GA18014@stefanha-x1.localdomain>
	<46101617.33460557.1500643755247.JavaMail.zimbra@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="qse+WBH4guesipZ+"
Content-Disposition: inline
In-Reply-To: <46101617.33460557.1500643755247.JavaMail.zimbra@redhat.com>
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
Cc: Stefan Hajnoczi <stefanha@gmail.com>, kvm-devel <kvm@vger.kernel.org>, Qemu Developers <qemu-devel@nongnu.org>, "linux-nvdimm@lists.01.org" <linux-nvdimm@ml01.01.org>, Rik van Riel <riel@redhat.com>, Dan Williams <dan.j.williams@intel.com>, ross zwisler <ross.zwisler@linux.intel.com>, Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Nitesh Narayan Lal <nilal@redhat.com>, xiaoguangrong eric <xiaoguangrong.eric@gmail.com>, Haozhong Zhang <haozhong.zhang@intel.com>


--qse+WBH4guesipZ+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 21, 2017 at 09:29:15AM -0400, Pankaj Gupta wrote:
>=20
> > > A] Problems to solve:
> > > ------------------
> > >=20
> > > 1] We are considering two approaches for 'fake DAX flushing interface=
'.
> > >    =20
> > >  1.1] fake dax with NVDIMM flush hints & KVM async page fault
> > >=20
> > >      - Existing interface.
> > >=20
> > >      - The approach to use flush hint address is already nacked upstr=
eam.
> > >
> > >      - Flush hint not queued interface for flushing. Applications mig=
ht
> > >        avoid to use it.
> >=20
> > This doesn't contradicts the last point about async operation and vcpu
> > control.  KVM async page faults turn the Address Flush Hints write into
> > an async operation so the guest can get other work done while waiting
> > for completion.
> >=20
> > >=20
> > >      - Flush hint address traps from guest to host and do an entire f=
sync
> > >        on backing file which itself is costly.
> > >=20
> > >      - Can be used to flush specific pages on host backing disk. We c=
an
> > >        send data(pages information) equal to cache-line size(limitati=
on)
> > >        and tell host to sync corresponding pages instead of entire di=
sk
> > >        sync.
> >=20
> > Are you sure?  Your previous point says only the entire device can be
> > synced.  The NVDIMM Adress Flush Hints interface does not involve
> > address range information.
>=20
> Just syncing entire block device should be simple but costly. Using flush=
=20
> hint address to write data which contains list/info of dirty pages to=20
> flush requires more thought. This calls mmio write callback at Qemu side.
> As per Intel (ACPI spec 6.1, Table 5-135) there is limit to max length=20
> of data guest can write and is equal to cache line size.
> =20
> >=20
> > >=20
> > >      - This will be an asynchronous operation and vCPU control is ret=
urned
> > >        quickly.
> > >=20
> > >=20
> > >  1.2] Using additional para virt device in addition to pmem device(fa=
ke dax
> > >  with device flush)
> >=20
> > Perhaps this can be exposed via ACPI as part of the NVDIMM standards
> > instead of a separate KVM-only paravirt device.
>=20
> Same reason as above. If we decide on sending list of dirty pages there is
> limit to send max size of data to host using flush hint address. =20

I understand now: you are proposing to change the semantics of the
Address Flush Hints interface.  You want the value written to have
meaning (the address range that needs to be flushed).

Today the spec says:

  The content of the data is not relevant to the functioning of the
  flush hint mechanism.

Maybe the NVDIMM folks can comment on this idea.

--qse+WBH4guesipZ+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZciS4AAoJEJykq7OBq3PIMYYIAJey2Ca+81kxB+uzV2QnDt/4
Yne3m9SNsxgLjOJfeHU6e/2mwCZkayDllcfpoqqAl6Cf+HyjJUL2Y0SuRlbLZzw+
IAhmZ6cBCnKUUb1DRdJQrBFXcWjABu4SUn3r7oWhPwrMkhfnq9DzqFkMqX3/AcPk
Xs18nW11/nFeCS2JmFAE4TLAxV416GlvyY6xx7EKVQk04rWbKbFXiH/S0cykii5N
i2AQdNzo4xbRNRCvZsTraUYnBVMh8wUQ7GK2ySaioS5ILPPR1f9gfIiREGfvdRiS
4GyfhJ0BO6Ln3DnSiFWcKAYzfjbf/3qzm9LV4hcI/cnE/3Ch9SdihBodYP9tScU=
=aED0
-----END PGP SIGNATURE-----

--qse+WBH4guesipZ+--
