Received: from eggs.gnu.org ([2001:4830:134:3::10]:41277)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cgqdk-0003mJ-Rp
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 05:28:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cgqdj-0007m0-U9
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 05:28:48 -0500
Date: Thu, 23 Feb 2017 11:28:39 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170223102839.GB6931@noname.redhat.com>
References: <20170221115512.21918-1-berrange@redhat.com>
	<20170221115512.21918-3-berrange@redhat.com>
	<20170222151833.GM4112@noname.str.redhat.com>
	<20170222154925.GT28937@redhat.com>
	<21ccca53-659f-aa79-3b81-6a8cf1e66ba3@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="jRHKVT23PllUwdXP"
Content-Disposition: inline
In-Reply-To: <21ccca53-659f-aa79-3b81-6a8cf1e66ba3@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v5 02/18] block: add ability to set a
 prefix for opt names
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, Alberto Garcia <berto@igalia.com>


--jRHKVT23PllUwdXP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 22.02.2017 um 19:28 hat Eric Blake geschrieben:
> Using '.' would mean a layer of {} nesting on the wire, maybe as in:
>=20
> { "driver": "qcow2", ..., "luks" : { "hash-alg": ... } }
>=20
> but conceptually, I like that a bit better, as it consolidates all the
> luks-related options in one place, and may indeed make it possible to
> reuse the type rather than having two variants (one prefixed, one not,
> depending on whether it is standalone or qcow2).

Right, and this extra nesting to keep everything luks related in one
place is exactly what I wanted to achieve with it.

> I'm also looking later in your series (13/18), where you have:
>=20
>=20
> @@ -2344,7 +2348,8 @@
>              '*l2-cache-size': 'int',
>              '*refcount-cache-size': 'int',
>              '*cache-clean-interval': 'int',
> -            '*aes-key-secret': 'str' } }
> +            '*aes-key-secret': 'str',
> +            '*luks-key-secret': 'str' } }
>=20
>=20
> Uggh - we have two optional parameters, that must not both be present at
> once.  I'm wondering if we can instead do this (hmm, my patches for
> anonymous base/branches in a flat union haven't been taken yet, but you
> get the idea):
>=20
> ...
> '*cache-clean-interval': 'int',
> '*encryption': 'Qcow2Encryption' } }
>=20
> { 'enum': 'Qcow2EncryptionType': [ 'aes', 'luks' ] }
> { 'union': 'Qcow2Encryption', 'base': { 'type': 'Qcow2EncryptionType' },
>   'discriminator': 'type', 'data': {
>     'aes': { 'key-secret': 'str' },
>     'luks': { 'key-secret': 'str', '*hash-alg': ..., '*slot': 'int' } } }
>=20
> so that you can only provide one encryption type, but once you have that
> type, you can then provide all the associated fields for that type.  So
> the QMP would look like:
>=20
> { "driver": "qcow2", ..., "encryption" : { "type": "luks", "hash-alg":
> ... } }

That's actually even better, a more accurate description of the options
on the QAPI level. I like it.

> > Hence, I wanted to have separation between the legacy AES & LUKS
> > namespaces, to make it clear what applies to what scenario.
>=20
> Again, I think the idea of a flat union, with the discriminator, makes
> it easier to enforce mutual exclusion, rather than having two top-level
> optional fields that cannot both be specified at once.  Maybe we should
> also consider making qapi flat unions support a default discriminator,
> so that the "type":"luks" can be omitted, but that's sugar.

With the default discriminator, I'm not sure if that's still "sugar" or
already "too much magic".

Kevin

--jRHKVT23PllUwdXP
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJYrrlXAAoJEH8JsnLIjy/WMe0P/Ajnwk5XWF2pm2ZxBCtfvf+A
dhIHRw8UTo7O/745JX+6DlnOq4Cg/w0EOELAJbrqFjGXibvPcGWVB5tJbraDgqw8
/GHAPyArm37HffvTuVPFTI39vP83I6doOUWFsttlSgoujaXSs8Q1x/6TZDMQQxFo
5e1EuPrIDeTeuaMjYNdEKhUcCle19WR/H7eGFSzfG30Awq1TQJL2qISMosbyCkcR
fj3GQjwfVXoLJEQOvogkvZHUtJs4U3SW5QKVyS6w/iKA/7dzNY+jEoCbrBO6pJX3
96RikqF74/Avn6bUADmFeVpw1WOTz2WZqFtlSdvvMtHbtehtPKChw4d2orztKbdc
vBzdS5YTw7fTqvmov6d77ALehK1412n9iRcASOiqA+h0q3cYnDjWzX8mVECLdqlg
mYMErsA0pm2XfufR4TNFn0eLn6N0VmwC4x5fyCuZxGA5z6UePshuaXWrqVF6fnSx
OezR8yEzQTty2Ra5EkME1QulEV3Oe6M5X6v7szhSBSZAnN+Q6KpwLRb5H+cOqaNz
lTejVO4UwDcC42AmhzPjN32VDtW1JfX73TvHMX73S+dzHRBsY7r180vxdbynSKfj
dcUDeJKKLs6S2GU9ygnbXyNGzf4cINcPhaEQHmQywAMwGWcqoxh+AgndNg/XUDzD
G5PqG3BzZAPGTqvg4b9V
=okQ1
-----END PGP SIGNATURE-----

--jRHKVT23PllUwdXP--
