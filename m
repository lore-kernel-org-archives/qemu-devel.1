Received: from eggs.gnu.org ([2001:4830:134:3::10]:35221)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dsymv-00025o-El
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 18:08:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dsymu-0000io-6j
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 18:08:41 -0400
References: <20170913164424.32129-1-awg@digitalocean.com>
	<20170915123327.GD4077@localhost.localdomain>
From: Eric Blake <eblake@redhat.com>
Message-ID: <7d812c2f-8352-dc1a-866a-c482755f0827@redhat.com>
Date: Fri, 15 Sep 2017 17:08:32 -0500
MIME-Version: 1.0
In-Reply-To: <20170915123327.GD4077@localhost.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="UgcmRTPHb5qFphACgEHRBii1J9Pm8OlD9"
Subject: Re: [Qemu-devel] [PATCH] rbd: Detect rbd image resizes and
 propagate them
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, Adam Wolfe Gordon <awg@digitalocean.com>
Cc: "open list:All patches CC here" <qemu-devel@nongnu.org>, Josh Durgin <jdurgin@redhat.com>, Jeff Cody <jcody@redhat.com>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--UgcmRTPHb5qFphACgEHRBii1J9Pm8OlD9
From: Eric Blake <eblake@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, Adam Wolfe Gordon <awg@digitalocean.com>
Cc: "open list:All patches CC here" <qemu-devel@nongnu.org>,
 Josh Durgin <jdurgin@redhat.com>, Jeff Cody <jcody@redhat.com>,
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>
Message-ID: <7d812c2f-8352-dc1a-866a-c482755f0827@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] rbd: Detect rbd image resizes and propagate
 them
References: <20170913164424.32129-1-awg@digitalocean.com>
 <20170915123327.GD4077@localhost.localdomain>
In-Reply-To: <20170915123327.GD4077@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 09/15/2017 07:33 AM, Kevin Wolf wrote:
> Am 13.09.2017 um 18:44 hat Adam Wolfe Gordon geschrieben:
>> Register a watcher with rbd so that we get notified when an image is
>> resized. Propagate resizes to parent block devices so that guest devic=
es
>> get resized without user intervention.
>>
>> Signed-off-by: Adam Wolfe Gordon <awg@digitalocean.com>
>> ---

>=20
> There's more wrong about this than just making assumptions about the
> graph layout above our own node (which would be wrong enough already).
>=20
> Other assumptions that you are making here and that don't hold true
> generally are that there is only one parent node (no reason why the
> image couldn't be used by two different users) and that we always
> inherit from a parent. If this node was created explicitly by the user
> with its own -blockdev (or -drive) option, it doesn't inherit options
> from any of its parents.
>=20
> Basically, a block driver shouldn't care about its users and it can't
> access them in a clean way. This is intentional.
>=20
>> +    if (parent =3D=3D NULL) {
>> +        error_report("bs %s does not have parent", bdrv_get_device_or=
_node_name(bs));
>> +        return;
>> +    }
>> +
>> +    /* Force parents to re-read our size. */
>> +    was_variable_length =3D bs->drv->has_variable_length;
>> +    bs->drv->has_variable_length =3D true;
>> +    new_parent_len =3D bdrv_getlength(parent);
>> +    if (new_parent_len < 0) {
>> +        error_report("getlength failed on parent %s", bdrv_get_device=
_or_node_name(parent));
>> +        bs->drv->has_variable_length =3D was_variable_length;
>> +        return;
>> +    }
>> +    bs->drv->has_variable_length =3D was_variable_length;
>> +
>> +    /* Notify block backends that that we have resized.
>> +       Copied from bdrv_parent_cb_resize. */
>> +    QLIST_FOREACH(c, &parent->parents, next_parent) {
>> +        if (c->role->resize) {
>> +            c->role->resize(c);
>> +        }
>> +    }
>=20
> This is the right approach that you should use consistently instead.

Also, we need to fix existing bugs in block.c first; right now,
bdrv_truncate() forgets that refresh_total_sectors() can fail, and then
calls bdrv_dirty_bitmap_truncate() even though that will act on the
wrong length.  If we are going to allow devices to recognize that they
have been externally resized outside of qemu's control, then we need to
make sure that we react to size updates consistently.

I'm trying to fix that [1], but it may interact with what you are trying
to do here.

[1] https://lists.gnu.org/archive/html/qemu-devel/2017-09/msg03776.html

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--UgcmRTPHb5qFphACgEHRBii1J9Pm8OlD9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlm8T2AACgkQp6FrSiUn
Q2rQpQgAhGwnof08gb2pkcRCnn1Wrw+SCExW33mgoXVqFC+3FyOxeH2XlT06BGvB
5jwMfmj0vG7cQ0K/CqFJvrXpop7yfbSJkepG+T4fis2SRROEOmnqVsG3WzNSHG5n
PXKIpXiSEpJIWDe7fi6g8MFXG6sZhLK4HApkaZstu+pw1tS4+PT0ZvKN0db6mbWM
tCEuQJtKNcmXQU+XIQxz1Mhdj3lNmoAXwYoIKMscb+OT5MEx05hHh6ItVzbPE9g4
nHLtzvChPhX1FLFY3UKAi+dFPJtfjdfigSaiwRRJz4jGaPJ0eJaBgfIoC+W3jAZv
LNP7JDY3TR2VGc8ABftbFBxhElVFdg==
=afDr
-----END PGP SIGNATURE-----

--UgcmRTPHb5qFphACgEHRBii1J9Pm8OlD9--
