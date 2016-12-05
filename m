Received: from eggs.gnu.org ([2001:4830:134:3::10]:49315)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cDwXD-0006YX-Mx
	for qemu-devel@nongnu.org; Mon, 05 Dec 2016 11:54:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cDwX7-0001sN-QJ
	for qemu-devel@nongnu.org; Mon, 05 Dec 2016 11:54:35 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56790)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cDwX7-0001qn-Do
	for qemu-devel@nongnu.org; Mon, 05 Dec 2016 11:54:29 -0500
References: <1480895097-60463-1-git-send-email-eric.fangyi@huawei.com>
	<20161205110954.GF22443@stefanha-x1.localdomain>
From: Eric Blake <eblake@redhat.com>
Message-ID: <7c2e5e96-69e4-098c-2dca-22a03b823b5f@redhat.com>
Date: Mon, 5 Dec 2016 10:54:19 -0600
MIME-Version: 1.0
In-Reply-To: <20161205110954.GF22443@stefanha-x1.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="7GcKdLxpgKObivWGLKG2iHkdxmJh5jwH9"
Subject: Re: [Qemu-devel] [PATCH] nbd: Implement NBD_CMD_HAS_ZERO_INIT
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>, Yi Fang <eric.fangyi@huawei.com>
Cc: kwolf@redhat.com, xieyingtai@huawei.com, subo7@huawei.com, qemu-devel@nongnu.org, mreitz@redhat.com, wu.wubin@huawei.com, pbonzini@redhat.com, sochin.jiang@huawei.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--7GcKdLxpgKObivWGLKG2iHkdxmJh5jwH9
From: Eric Blake <eblake@redhat.com>
To: Stefan Hajnoczi <stefanha@gmail.com>, Yi Fang <eric.fangyi@huawei.com>
Cc: kwolf@redhat.com, xieyingtai@huawei.com, subo7@huawei.com,
 qemu-devel@nongnu.org, mreitz@redhat.com, wu.wubin@huawei.com,
 pbonzini@redhat.com, sochin.jiang@huawei.com
Message-ID: <7c2e5e96-69e4-098c-2dca-22a03b823b5f@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] nbd: Implement NBD_CMD_HAS_ZERO_INIT
References: <1480895097-60463-1-git-send-email-eric.fangyi@huawei.com>
 <20161205110954.GF22443@stefanha-x1.localdomain>
In-Reply-To: <20161205110954.GF22443@stefanha-x1.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 12/05/2016 05:09 AM, Stefan Hajnoczi wrote:
> On Sun, Dec 04, 2016 at 11:44:57PM +0000, Yi Fang wrote:
>> NBD client has not implemented callback for .bdrv_has_zero_init. So
>> bdrv_has_zero_init always returns 0 when doing non-shared storage
>> migration.
>> This patch implemented NBD_CMD_HAS_ZERO_INIT and will avoid unnecessar=
y
>> set-dirty.
>=20
> Please link to the NBD spec where this new command is defined.  Has it
> already been accepted by the NBD community?

No. This is the first I've seen of such a proposal.

>=20
> I think this is a weird command because it's information that doesn't
> change over the lifetime of an NBD session.  Your patch sends a command=

> and waits for the reply every time has_zero_init() is queried.
>=20
> Is there a better place to put this information in the NBD protocols,
> like some export information that is retried during connection?  (I
> haven't checked the protocol.)  It seems weird to send a command and
> wait for the response.

Agreed - this patch is wrong. Even if you DO get the NBD community to
buy into this, it should be done as a new NBD_FLAG_* sent once up-front
during handshake phase in reply to NBD_OPT_EXPORT_NAME/NBD_OPT_GO, and
NOT a new command that can be arbitrarily invoked multiple times during
transmission phase.

Is the goal of the flag for the server to be able to advertise to the
client that upon initial connection, the server asserts that the volume
currently reads as all zeroes (and therefore the client can optimize by
not writing zeroes)?

Do you need me to help re-write this into a proposal to the NBD
community that might stand a chance of being accepted?

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--7GcKdLxpgKObivWGLKG2iHkdxmJh5jwH9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYRZu7AAoJEKeha0olJ0NqlZkH/2kLJBuHLQ7dNfPw4hv8eJKl
ndC1hMF9EVGsxEi4qxuHFHwXB8W9iMsLScny6Qv8QpQf7KGTL/29wEhBJ/EhAUEM
r5QRlYrnXNGcv7CGbr8++EEJVey8OP4JJ3vbyWEe7Oe+UYV263WUNxOKRS1VW6gX
2PLbZDJrbHNX01XkS7haZgSHHtJNcEinrb+BNfJdo76ETikAGPHdRXy/TCANAK8R
P4m2jm5CyI7ScZ46Ib1tNFPeo/tMk+EciESpHgnwK5alJ2n2ivS214cSmRHo12Us
9H4lCsMAddSFdkpa8PSGsFwTV1jcQAoK3r3YF5ChG6xuCJzhUYEAGKEyYjyXClY=
=T1cB
-----END PGP SIGNATURE-----

--7GcKdLxpgKObivWGLKG2iHkdxmJh5jwH9--
