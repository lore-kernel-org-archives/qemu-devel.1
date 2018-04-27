Received: from eggs.gnu.org ([2001:4830:134:3::10]:55954)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fC3U6-00035K-Ho
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 09:32:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fC3U1-0001df-Ke
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 09:32:22 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:36362 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1fC3U1-0001dW-Eo
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 09:32:17 -0400
Date: Fri, 27 Apr 2018 14:31:46 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20180427133146.GB11150@stefanha-x1.localdomain>
References: <20180425112415.12327-1-pagupta@redhat.com>
	<20180425112415.12327-2-pagupta@redhat.com>
	<20180426131236.GA30991@stefanha-x1.localdomain>
	<197910974.22984070.1524757499459.JavaMail.zimbra@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ZoaI/ZTpAVc4A5k6"
Content-Disposition: inline
In-Reply-To: <197910974.22984070.1524757499459.JavaMail.zimbra@redhat.com>
Subject: Re: [Qemu-devel] [RFC v2 1/2] virtio: add pmem driver
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pankaj Gupta <pagupta@redhat.com>
Cc: Stefan Hajnoczi <stefanha@gmail.com>, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, qemu-devel@nongnu.org, linux-nvdimm@ml01.01.org, linux-mm@kvack.org, kwolf@redhat.com, haozhong zhang <haozhong.zhang@intel.com>, jack@suse.cz, xiaoguangrong eric <xiaoguangrong.eric@gmail.com>, riel@surriel.com, niteshnarayanlal@hotmail.com, david@redhat.com, ross zwisler <ross.zwisler@intel.com>, lcapitulino@redhat.com, hch@infradead.org, mst@redhat.com, imammedo@redhat.com, marcel@redhat.com, pbonzini@redhat.com, dan j williams <dan.j.williams@intel.com>, nilal@redhat.com


--ZoaI/ZTpAVc4A5k6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 26, 2018 at 11:44:59AM -0400, Pankaj Gupta wrote:
> > > +	int err;
> > > +
> > > +	sg_init_one(&sg, buf, sizeof(buf));
> > > +
> > > +	err =3D virtqueue_add_outbuf(vpmem->req_vq, &sg, 1, buf, GFP_KERNEL=
);
> > > +
> > > +	if (err) {
> > > +		dev_err(&vdev->dev, "failed to send command to virtio pmem device\=
n");
> > > +		return;
> > > +	}
> > > +
> > > +	virtqueue_kick(vpmem->req_vq);
> >=20
> > Is any locking necessary?  Two CPUs must not invoke virtio_pmem_flush()
> > at the same time.  Not sure if anything guarantees this, maybe you're
> > relying on libnvdimm but I haven't checked.
>=20
> I thought about it to some extent, and wanted to go ahead with simple ver=
sion first:
>=20
> - I think file 'inode -> locking' sill is there for request on single fil=
e.
> - For multiple files, our aim is to just flush the backend block image.
> - Even there is collision for virt queue read/write entry it should just =
trigger a Qemu fsync.=20
>   We just want most recent flush to assure guest writes are synced proper=
ly.
>=20
> Important point here: We are doing entire block fsync for guest virtual d=
isk.

I don't understand your answer.  Is locking necessary or not?

=46rom the virtqueue_add_outbuf() documentation:

 * Caller must ensure we don't call this with other virtqueue operations
 * at the same time (except where noted).

Stefan

--ZoaI/ZTpAVc4A5k6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJa4yZCAAoJEJykq7OBq3PIfAEH/3CKVcVGxsuzmV7lgfXlV3nb
96loKX3VPv78+trdSImeDZ+PYUzATi5humWaCgcbM/QHrpDhsmKxh/Cu+a2ynVeI
5QQ2E2tvlqBC7MO2NTy1Qty2UEPy3p5x7Qqz/SsCs4k1j6c2i0eBTC4LxJNmtgQI
Ipy0wz76skwaGeo3yrcRGha8CxbHZDQQIELuvroOo9RMifqUWyY66s7VGHA9CDLd
/URZJGr4qS4RlK1Xk2fyFQWLZTijCEcWvZGSP9rWcuZtWzTHeOEm7SjY3jZghlbg
CLKTy6+fxRirY8yEsQKI9rpfGUNTJ0ny/vvg8nsSPXtz0EmmRd85aDOtY+5Cb4E=
=fxXv
-----END PGP SIGNATURE-----

--ZoaI/ZTpAVc4A5k6--
