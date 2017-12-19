Received: from eggs.gnu.org ([2001:4830:134:3::10]:53873)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eRGB7-00028t-Pa
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 06:35:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eRGAy-0000fa-Vq
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 06:35:21 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35100)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1eRGAy-0000eX-C8
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 06:35:12 -0500
Date: Tue, 19 Dec 2017 11:35:05 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20171219113505.GA8499@stefanha-x1.localdomain>
References: <1512444796-30615-1-git-send-email-wei.w.wang@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="7JfCtLOvnd9MIVvH"
Content-Disposition: inline
In-Reply-To: <1512444796-30615-1-git-send-email-wei.w.wang@intel.com>
Subject: Re: [Qemu-devel] [virtio-dev] [PATCH v3 0/7] Vhost-pci for inter-VM
 communication
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Wei Wang <wei.w.wang@intel.com>
Cc: virtio-dev@lists.oasis-open.org, qemu-devel@nongnu.org, mst@redhat.com, marcandre.lureau@redhat.com, jasowang@redhat.com, pbonzini@redhat.com, jan.kiszka@siemens.com, avi.cohen@huawei.com, zhiyong.yang@intel.com


--7JfCtLOvnd9MIVvH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 05, 2017 at 11:33:09AM +0800, Wei Wang wrote:
> Vhost-pci is a point-to-point based inter-VM communication solution. This
> patch series implements the vhost-pci-net device setup and emulation. The
> device is implemented as a virtio device, and it is set up via the
> vhost-user protocol to get the neessary info (e.g the memory info of the
> remote VM, vring info).
>=20
> Currently, only the fundamental functions are implemented. More features,
> such as MQ and live migration, will be updated in the future.
>=20
> The DPDK PMD of vhost-pci has been posted to the dpdk mailinglist here:
> http://dpdk.org/ml/archives/dev/2017-November/082615.html

This thread has become long so I've summarized outstanding issues:

 * Whether to define a virtio device for each device type or to have a sing=
le
   virtio device that speaks the vhost-user protocol.  Discussion ongoing.

 * Please structure the code so there is a common vhost-pci component that
   other device types (scsi, blk) could use.  This will show that the code =
is
   designed with other device types (scsi, blk) in mind.

 * Please validate all inputs from vhost-user protocol messages to protect
   against buffer overflows and other bugs.

 * Please handle short reads/writes and EAGAIN with the UNIX domain socket.=
  Do
   not use read/write_all() functions because they hang QEMU until I/O
   completes.

 * What happens when the vhost-user master disconnects while we're running?

 * How does the guest know when the QEMU vhost-user slave has finished
   initializing everything?  It seems like a guest driver could access the
   device before things are initialized.

 * How can the vhost-user slave inside the guest participate in feature
   negotiation?  It must be able to participate, otherwise slaves cannot
   disable features that QEMU supports but they don't want to support.

   It's not feasible to pass in host_features as a QEMU parameter because
   that would require libvirt, OpenStack, cloud providers, etc to add
   support so users can manually set the bits for their slave
   implementation.

 * How can the the guest limit the number of virtqueues?

 * Please include tests.  See tests/virtio-net-test.c and
   tests/vhost-user-test.c for examples.

--7JfCtLOvnd9MIVvH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJaOPlpAAoJEJykq7OBq3PI13YH/Rw3/QmvSXYL4F/riixoW0Wp
ar9AVht/MIYYZsaeQYgeffAhodUgYvNsuW4M2OgFv1/u2rQwKU2x+09cA4qLvY0Y
OqGRpPEXzr5k0UGtlJCn+d6cAUwvYgnftu7L30vKbgHUb+cH/3u2lDGzfi6s5wfz
BnQNSO3PBpne7syqS3yFQeUT22XzbYjB4LE95/ZvCnDWeqBY86F1Rh0W8p+Z8IEN
2DJg3raO3qyeQf8DylHWYQVHb4w/Gl7UfNoYcgzZWn3O/WYoBzdBs8062HwUGE2K
0qnM1Fy3hGtdX9jr1t8/nUTlVvhly/heYzrBth7Cr72XTHw//5kIrrVYXGSCpuc=
=8/bp
-----END PGP SIGNATURE-----

--7JfCtLOvnd9MIVvH--
