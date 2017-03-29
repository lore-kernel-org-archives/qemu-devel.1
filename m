Received: from eggs.gnu.org ([2001:4830:134:3::10]:58708)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ctKGj-0004CQ-Vz
	for qemu-devel@nongnu.org; Wed, 29 Mar 2017 16:32:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ctKGi-0006qh-S6
	for qemu-devel@nongnu.org; Wed, 29 Mar 2017 16:32:38 -0400
References: <1490805920-17029-1-git-send-email-armbru@redhat.com>
	<1490805920-17029-9-git-send-email-armbru@redhat.com>
	<a33b1054-201c-9f5e-2c0e-35a86b1262e1@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <f7c8116c-db13-4aaf-e5e4-60590705a134@redhat.com>
Date: Wed, 29 Mar 2017 15:32:28 -0500
MIME-Version: 1.0
In-Reply-To: <a33b1054-201c-9f5e-2c0e-35a86b1262e1@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="XwOSbjENwUpjdP1fExqTJKxGmnAdG9Kgk"
Subject: Re: [Qemu-devel] [for-2.9 8/8] sheepdog: Fix blockdev-add
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, mitake.hitoshi@lab.ntt.co.jp, namei.unix@gmail.com, jcody@redhat.com, kwolf@redhat.com, pbonzini@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--XwOSbjENwUpjdP1fExqTJKxGmnAdG9Kgk
From: Eric Blake <eblake@redhat.com>
To: Max Reitz <mreitz@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, mitake.hitoshi@lab.ntt.co.jp,
 namei.unix@gmail.com, jcody@redhat.com, kwolf@redhat.com, pbonzini@redhat.com
Message-ID: <f7c8116c-db13-4aaf-e5e4-60590705a134@redhat.com>
Subject: Re: [for-2.9 8/8] sheepdog: Fix blockdev-add
References: <1490805920-17029-1-git-send-email-armbru@redhat.com>
 <1490805920-17029-9-git-send-email-armbru@redhat.com>
 <a33b1054-201c-9f5e-2c0e-35a86b1262e1@redhat.com>
In-Reply-To: <a33b1054-201c-9f5e-2c0e-35a86b1262e1@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/29/2017 02:59 PM, Max Reitz wrote:
> On 29.03.2017 18:45, Markus Armbruster wrote:
>> Commit 831acdc "sheepdog: Implement bdrv_parse_filename()" and commit
>> d282f34 "sheepdog: Support blockdev-add" have different ideas on how
>> the QemuOpts parameters for the server address are named.  Fix that.
>> While there, rename BlockdevOptionsSheepdog member addr to server, for=

>> consistency with BlockdevOptionsSsh, BlockdevOptionsGluster,
>> BlockdevOptionsNbd.
>>
>> Commit 831acdc's example becomes
>>
>>     --drive driver=3Dsheepdog,server.host=3Dfido,vdi=3Ddolly
>>
>> instead of
>>
>>     --drive driver=3Dsheepdog,host=3Dfido,vdi=3Ddolly
>>
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> ---
>>  block/sheepdog.c     | 18 +++++++++---------
>>  qapi/block-core.json |  4 ++--
>>  2 files changed, 11 insertions(+), 11 deletions(-)
>=20
> OK, so let me get this straight: Before this patch, @addr was advertise=
d
> as a runtime parameter that actually wasn't supported at all? (Because =
I
> can't see any place in block/sheepdog.c where it would be parsed.)

Both commits mentioned in the commit message are new to 2.9, so we
aren't breaking any back-compat, but are avoiding cementing in a mistake.=


Before this patch, @addr was the QMP spelling (inconsistent with all the
others, where ssh, gluster, and nbd spelled it @server); and because it
was NOT mentioned in the sheepdog.c QemuOpts code, it was impossible to
parse it through -drive.  Which means we have a needless difference
between -drive and -blockdev-add.

After this patch, it is spelled @server for both -drive and
-blockdev-add, and QMP is consistent (both with the QemuOpts code, and
with the other network storage drivers).

>=20
> This patch now renames @addr to @server and instead of actually parsing=

> the option, it just removes the so-far convenience[1] options @host,
> @port, and @path and just fetches the from @server?

But the convenience options have not been released, so fixing them now
is the right way to go.

>=20
> If that is true, I can't say I like it the least. I guess it works for
> 2.9, but there should be a FIXME somewhere in this patch.

A fixme to what? Unlike patch 7/8 which has to deal with legacy -drive
code, here, we have nothing released to break.

>=20
> Also, if you set any of server.* in bdrv_parse_filename(), you also hav=
e
> to set server.type. It's a SocketAddressFlat, .type is a required field=
=2E
> I know it's just for internal use, but that doesn't change the fact tha=
t
> it's an invalid SocketAddressFlat object without.

That part's true. Also, you can't set server.host and server.path at the
same time (compare to nbd_process_legacy_socket_options taking pains to
make sure that a valid QAPI object is constructed).

>=20
> Max
>=20
>=20
> [1] Originally there were apparently introduced for
> bdrv_parse_filename() -- but of course you can just use them in -drive
> directly...

There's a difference between the psuedo-file '-drive sheepdog:...'
(where you can use them directly, and that doesn't change in this
patch), and the structured '-drive driver=3Dsheepdog,...' (which didn't
exist before 831acdc, and which we want to match to our QMP).

I'm in favor of this patch, but think you found a real issue with not
constructing a valid qapi object.

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--XwOSbjENwUpjdP1fExqTJKxGmnAdG9Kgk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJY3BncAAoJEKeha0olJ0NqpH0H/R5ZOYG0r3c6MXC18zVMQwLU
yiy3Ck7jY42EWsFUhKBdm9PSheYt11SZh+aFQbA+VIoPixcdhSc6ASgGuv5KgPI1
Sh0d7zol1XPt9svDVRTmwxcZUWtauNnKluSd/al9VlOG2j+dQfQXQV92l5kYF+fR
x0m8oAj0hD+Do/y2k7hOv+yuRbKaYcM+c+1j8edGKtu026NC1KPPG5oWsl5uS0b1
FGxFOdlGtRjoZfYdAfqY875wCdE8K+0Yu+1uOOPuD/W4U4Gxtqhq92tw1sgNBM+9
fKvcjtfSh78TpHeLPZuSu23CSfheHpysyPcIsu+z4gm6aX4ONqvV6M4FL3tbgO4=
=yZgK
-----END PGP SIGNATURE-----

--XwOSbjENwUpjdP1fExqTJKxGmnAdG9Kgk--
