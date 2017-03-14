Received: from eggs.gnu.org ([2001:4830:134:3::10]:50401)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cnnVF-0004jA-Hi
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 10:32:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cnnVE-0003SQ-H6
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 10:32:45 -0400
References: <20170314111157.14464-2-pbonzini@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <bb3ff9f0-2bad-803b-6f7d-16c0386a37c1@redhat.com>
Date: Tue, 14 Mar 2017 09:32:37 -0500
MIME-Version: 1.0
In-Reply-To: <20170314111157.14464-2-pbonzini@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="iM7LrHkueES7e00BuIqxCFej6OH1QVauI"
Subject: Re: [Qemu-devel] [PATCH] block: quiesce AioContext when detaching
 from it
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: Halil Pasic <pasic@linux.vnet.ibm.com>, qemu-block@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, Max Reitz <mreitz@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--iM7LrHkueES7e00BuIqxCFej6OH1QVauI
From: Eric Blake <eblake@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: Halil Pasic <pasic@linux.vnet.ibm.com>, qemu-block@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>, Max Reitz <mreitz@redhat.com>
Message-ID: <bb3ff9f0-2bad-803b-6f7d-16c0386a37c1@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] block: quiesce AioContext when detaching
 from it
References: <20170314111157.14464-2-pbonzini@redhat.com>
In-Reply-To: <20170314111157.14464-2-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/14/2017 06:11 AM, Paolo Bonzini wrote:
> While it is true that bdrv_set_aio_context only works on a single
> BlockDriverState subtree (see commit message for 53ec73e, "block: Use
> bdrv_drain to replace uncessary bdrv_drain_all", 2015-07-07), it works

I was about to correct the typo, but see it was in the original commit :)=


> at the AioContext level rather than the BlockDriverState level.
>=20
> Therefore, it is also necessary to trigger pending bottom halves too,
> even if no requests are pending.
>=20
> For NBD this ensures that the aio_co_schedule of a previous call to
> nbd_attach_aio_context is completed before detaching from the old
> AioContext; it fixes qemu-iotest 094.  Another similar bug happens
> when the VM is stopped and the virtio-blk dataplane irqfd is torn down.=

> In this case it's possible that guest I/O gets stuck if notify_guest_bh=

> was scheduled but doesn't run.
>=20
> Calling aio_poll from another AioContext is safe if non-blocking; races=

> such as the one mentioned in the commit message for c9d1a56 ("block:
> only call aio_poll on the current thread's AioContext", 2016-10-28)
> are a concern for blocking calls.
>=20
> I considered other options, including:
>=20
> - moving the bs->wakeup mechanism to AioContext, and letting the caller=

> check.  This might work for virtio which has a clear place to wakeup
> (notify_place_bh) and check the condition (virtio_blk_data_plane_stop).=

> For aio_co_schedule I couldn't find a clear place to check the conditio=
n.
>=20
> - adding a dummy oneshot bottom half and waiting for it to trigger.
> This has the complication that bottom half list is LIFO for historical
> reasons.  There were performance issues caused by bottom half ordering
> in the past, so I decided against it for 2.9.
>=20
> Fixes: 99723548561978da8ef44cf804fb7912698f5d88
> Reported-by: Max Reitz <mreitz@redhat.com>
> Reported-by: Halil Pasic <pasic@linux.vnet.ibm.com>
> Tested-by: Halil Pasic <pasic@linux.vnet.ibm.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  block.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>=20

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--iM7LrHkueES7e00BuIqxCFej6OH1QVauI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYx/8FAAoJEKeha0olJ0Nqk/0IAIUVpbH/6drTrjVUCPe62Yj/
oblp7sd6EeQv2TlHScPkAdvMcQR4e5RhEhT8SFH+Q6Ftic4HqcJiRTEIlTTvWEne
EgjjjdjkWAwvf2iJVYguE4eJV/Gdglgn0GYuzIic66e5+SH8wzBC41TUU3UfAFj8
fdpkISHzthsz6zBySr/fN3G3A+3KVqw39S9lktyNmOTiFLJSlxtMOS7ucIUdlRYX
HBOMM5mL3bpCnijmc1UY6Zxa6gPAq4hiLXwUzZuTBsRoW3UO2TFx/q41vTnlunjL
hoPOO6QKaILWVaA6hpf+0mfM/90yKBHVxcuFB3uL+SQ5kJnxDxcvhW/7FNs/NzI=
=gqGx
-----END PGP SIGNATURE-----

--iM7LrHkueES7e00BuIqxCFej6OH1QVauI--
