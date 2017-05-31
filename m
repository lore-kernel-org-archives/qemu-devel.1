Received: from eggs.gnu.org ([2001:4830:134:3::10]:36046)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dGBQC-0006kx-Eo
	for qemu-devel@nongnu.org; Wed, 31 May 2017 17:44:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dGBQ7-000806-Ts
	for qemu-devel@nongnu.org; Wed, 31 May 2017 17:44:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55472)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dGBQ7-0007zk-LY
	for qemu-devel@nongnu.org; Wed, 31 May 2017 17:44:47 -0400
References: <CAEB0U7P0Sk0cNQbPynrzJ5MMdQ5=zdMFnf5neWc6PjfQ1Z=Z2Q@mail.gmail.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <5c096fa0-ba9b-86aa-6f08-e5b9d30a2743@redhat.com>
Date: Wed, 31 May 2017 16:44:43 -0500
MIME-Version: 1.0
In-Reply-To: <CAEB0U7P0Sk0cNQbPynrzJ5MMdQ5=zdMFnf5neWc6PjfQ1Z=Z2Q@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="1F8URSpsNNkd98HIW8uI4okGREED7qKpu"
Subject: Re: [Qemu-devel] Doubts about Kvm architecture
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Maur=c3=adcio_Almeida?= <malmeida@inf.ufsm.br>, qemu-devel@nongnu.org, kvm@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--1F8URSpsNNkd98HIW8uI4okGREED7qKpu
From: Eric Blake <eblake@redhat.com>
To: =?UTF-8?Q?Maur=c3=adcio_Almeida?= <malmeida@inf.ufsm.br>,
 qemu-devel@nongnu.org, kvm@vger.kernel.org
Message-ID: <5c096fa0-ba9b-86aa-6f08-e5b9d30a2743@redhat.com>
Subject: Re: [Qemu-devel] Doubts about Kvm architecture
References: <CAEB0U7P0Sk0cNQbPynrzJ5MMdQ5=zdMFnf5neWc6PjfQ1Z=Z2Q@mail.gmail.com>
In-Reply-To: <CAEB0U7P0Sk0cNQbPynrzJ5MMdQ5=zdMFnf5neWc6PjfQ1Z=Z2Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 05/31/2017 11:56 AM, Maur=C3=ADcio Almeida wrote:

> The Traffic of Virtio was 956 MB/s while e1000 Emulated Driver was 192
> MB/s, both using Packet size of 1518 Bytes.

The quick answer - yes, that's the expected results, because paravirt is
SOOO much more direct than fully-emulated.  Everything done in the e1000
driver has to emulate what hardware would do, which tends to be a LOT of
register reads and writes to device memory, which in turn implies a LOT
of VMEXITs with corresponding overhead as you are paging between the
guest and host to handle the full sequence.  Meanwhile, the virtio
driver was designed from the ground up to be as efficient as possible,
by intentionally arranging memory layout and handshake protocols so that
there are as few memory-mapped register writes, and therefore as few
VMEXITs, as possible, for better speed and multithreading.

>=20
> Why when it used e1000 Emulated Driver the traffic was to low and use o=
nly
> one Cpu all the time?

For any modern OS, the e1000 driver should only be used as a crutch to
get the system up and running until you can install and switch over to
the virtio drivers (we have it because it is a driver that is most
likely already installed on a guest OS out-of-the-box, while the virtio
driver might be an extra download or install after the initial guest
install has completed).  So optimizing the e1000 driver to run on
multiple vcpus is not our priority; rather, you should be optimizing
your guest provisioning setup to get switched over to the virtio drivers
as soon as possible.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--1F8URSpsNNkd98HIW8uI4okGREED7qKpu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZLzlLAAoJEKeha0olJ0NqoP0IAIjAzEqzu2NI8GlFNRVjfVK4
HZiBFDxSoRMuJCNDBvtG4KFLpDThv6Nvh+RFA/DxFVpNy0hrOnCr0/ZCK3VnaS5B
z0hkabiccIwLtcM/hc8rDj8gjuTFhrBchXzAJWPTzxL/eZf8YYzCExqtxU+NfS+n
8orjym3ITYZKr8X7KRzKY9Yq9tu0kuRD/V+Fx32ERDewrOPNCMghDDI07T5waNP8
GcHVj3RQS67dKhIB1PC7gv2UVDaRU2KjOeE6O8dPpX1Q2WyNtnB7nzX4sdrb2cqi
ZK34YzBoeLpIgcCwc2OY0nabSOz5ObLsl8obVvml65WTyi3QVmwLH2L/AhiIGTM=
=L4MQ
-----END PGP SIGNATURE-----

--1F8URSpsNNkd98HIW8uI4okGREED7qKpu--
