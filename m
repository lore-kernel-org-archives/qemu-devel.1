Received: from eggs.gnu.org ([2001:4830:134:3::10]:52203)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1ce1Zy-0006HI-Ma
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 10:33:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1ce1Zt-0007tG-OI
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 10:33:14 -0500
Received: from mail-wr0-x242.google.com ([2a00:1450:400c:c0c::242]:35099)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1ce1Zt-0007s5-F8
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 10:33:09 -0500
Received: by mail-wr0-x242.google.com with SMTP id q39so1001838wrb.2
	for <qemu-devel@nongnu.org>; Wed, 15 Feb 2017 07:33:09 -0800 (PST)
Date: Wed, 15 Feb 2017 15:33:06 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170215153306.GF16064@stefanha-x1.localdomain>
References: <58A4707602000062000D0393@prv-mh.provo.novell.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="5Mfx4RzfBqgnTE/w"
Content-Disposition: inline
In-Reply-To: <58A4707602000062000D0393@prv-mh.provo.novell.com>
Subject: Re: [Qemu-devel] [RFC] virtio-fc: draft idea of virtual fibre
 channel HBA
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Lin Ma <lma@suse.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, Zhiqiang Zhou <ZZhou@suse.com>, hare@suse.de, stefanha@redhat.com, mst@redhat.com, Fam Zheng <famz@redhat.com>


--5Mfx4RzfBqgnTE/w
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 15, 2017 at 12:15:02AM -0700, Lin Ma wrote:
> Hi all,
> =20
> We know that libvirt can create fibre channels vHBA on host
> based on npiv, and present the LUNs to guest.
> =20
> I'd like to implement a virtual fibre channel HBA for qemu,
> I havn't investigate it deeply yet. The idea presents a fc
> vHBA in guest, interact with remote fc switch through npiv,
> The LUNs will be recognized inside guest. I sent this email
> here to see if you are in agreement with this approach and
> hope to get some ideas/suggestions.
> =20
> The frontend is based on virtio, say virtio-fc-pci; the backend
> is based on npiv of physical fc hba on host.
> The implementation of this virtual fc hba doesn't support Fc-al,
> only supports Fabric. It wrappers scsi data info fc frames, then
> forwards them to backend, sounds like scsi over fc.
> (maybe I can re-use some of virtio-scsi code/idea to deal with scsi data)
> =20
> The minimum invocation may look like:
> qemu-system-x86_64 \
> ...... \
> -object fibrechannel-backend,id=3Dfcdev0,host=3D0000:81:00.0 \
> -device virtio-fc-pci,id=3Dvfc0,fc_backend=3Dfcdev0,wwpn=3D10000000000000=
01,wwnn=3D1100000000000001 \
> ......
> =20
> BTW, I have no idea how to make migration works:
> How to deal with the BDF during migration?
> How to deal with the Fabric ID during migration?
> =20
> It's a draft idea, There are lots of related code I need to
> investigate, Currently this is all thoughts I have.
> =20
> Hello Paolo and Stefan, You are the authors of virtio-scsi,
> and had some in-depth discuss about virtio-scsi in 2011
> with Hannes, May I have your ideas/thoughts?

I'm not sure it's necessary for the guest to have FC access.  Fam Zheng
and Paolo are working on virtio-scsi FC NPIV enhancements.  It should
make NPIV work better without adding a whole new FC device.

https://lkml.org/lkml/2017/1/16/439

The plan is:

1. libvirt listens to udev events on the host so it can add/remove
   QEMU SCSI LUNs.

2. virtio-scsi is extended to include a WWPN that the guest can see.

The guest doesn't do any FC fabric level stuff, it just does virtio-scsi
as usual.

It supports live migration by swapping between a pair of WWPNs across
migration.

What are the benefits of having FC access from the guest?

Stefan

--5Mfx4RzfBqgnTE/w
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYpHSyAAoJEJykq7OBq3PIBqAH/3Gi8BQATlJhnT7NrLuwmwKj
JJNBz9lU3TcO25SjyjJ6jw0w8uqVta6rmD1jbMse4jV8LGAYOAABI/DLSKbBtDKz
L7Vv4jOjj/SSnXWPgDJZZGJhA4PLuCWIG0RR5q2rL5lKYsSRxCf828Gkr3CzuApg
8W+KdxAxnb6SmsxDASAII+pzd4okoX0aKgz3EBU5JtVNa8lyDGyVbHdFsG3ZHZMW
mbT/aft12B41TaHtW7TXqRTXN3zM7eCcOhoVV6bcOAXDnVz9ld8JV2JoVwuyeNTB
Q+yoB+ThhKML5vPKGtt2VLPKFda84y3T2HNwE//rH5hE38ZY0jLMSiRYHRsawkY=
=3RX3
-----END PGP SIGNATURE-----

--5Mfx4RzfBqgnTE/w--
