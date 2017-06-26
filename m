Received: from eggs.gnu.org ([2001:4830:134:3::10]:36591)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <el13635@mail.ntua.gr>) id 1dPclX-0001wJ-59
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 18:45:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <el13635@mail.ntua.gr>) id 1dPclV-0006fr-T6
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 18:45:55 -0400
Date: Tue, 27 Jun 2017 01:45:07 +0300
From: Manos Pitsidianakis <el13635@mail.ntua.gr>
Message-ID: <20170626224507.ep2hqzpxknfimf55@postretch>
References: <20170623124700.1389-1-el13635@mail.ntua.gr>
	<20170623124700.1389-8-el13635@mail.ntua.gr>
	<20170626154444.GH29664@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="m2b43yy3q4txuigf"
Content-Disposition: inline
In-Reply-To: <20170626154444.GH29664@stefanha-x1.localdomain>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH RFC v3 7/8] block: remove
 legacy I/O throttling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, qemu-block <qemu-block@nongnu.org>, Alberto Garcia <berto@igalia.com>


--m2b43yy3q4txuigf
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 26, 2017 at 04:44:44PM +0100, Stefan Hajnoczi wrote:
>On Fri, Jun 23, 2017 at 03:46:59PM +0300, Manos Pitsidianakis wrote:
>> -void blk_io_limits_disable(BlockBackend *blk)
>> +void blk_io_limits_disable(BlockBackend *blk, Error **errp)
>>  {
>> -    assert(blk->public.throttle_group_member.throttle_state);
>> -    bdrv_drained_begin(blk_bs(blk));
>> -    throttle_group_unregister_tgm(&blk->public.throttle_group_member);
>> -    bdrv_drained_end(blk_bs(blk));
>> +    Error *local_err =3D NULL;
>> +    BlockDriverState *bs, *throttle_node;
>> +
>> +    throttle_node =3D blk_get_public(blk)->throttle_node;
>> +
>> +    assert(throttle_node && throttle_node->refcnt =3D=3D 1);
>
>I'm not sure if we can enforce refcnt =3D=3D 1.  What stops other graph
>manipulation operations from inserting a node above or a BB that uses
>throttle_node as the root?

Is this possible unless the user explicitly does this? I suppose going=20
down the path and removing it from any place is okay. If the=20
throttle_node has more than one parent then the result would be invalid=20
anyway. I don't see anything in the code doing this (removing a BDS from=20
a BB->leaf path) or wrapping it in some way, is that what should be=20
done?

>
>> +
>> +    /* ref throttle_node's child bs so that it isn't lost when throttle=
_node is
>> +     * destroyed */
>> +    bdrv_ref(bs);
>> +
>> +    /* this destroys throttle_node */
>> +    blk_remove_bs(blk);
>
>This assumes that throttle_node is the top node.  How is this=20
>constraint enforced?


Kevin had said in a previous discussion:
> The throttle node affects only the backing file now, but not the new
> top-level node. With manually created filter nodes we may need to
> provide a way so that the QMP command tells where in the tree the
> snapshot is actually taken. With automatically created ones, we need to
> make sure that they always stay on top.
>=20
> Similar problems arise when block jobs manipulate the graph. For
> example, think of a commit block job, which will remove the topmost node
> from the backing file chain. We don't want it to remove the throttling
> filter together with the qcow2 node. (Or do we? It might be something
> that needs to be configurable.)
>=20
> We also have several QMP that currently default to working on the
> topmost image of the chain. Some of them may actually want to work on
> the topmost node that isn't an automatically inserted filter.
>=20
>=20
> I hope this helps you understand why I keep saying that automatic
> insertion/removal of filter nodes is tricky and we should do it as
> little as we possibly can.

Yes, this constraint isn't enforced. The automatically inserted filter=20
is not a very clean concept. I'll have to think about it a little more,=20
unless there are some ideas.

--m2b43yy3q4txuigf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEvy2VxhCrsoeMN1aIc2J8L2kN9xAFAllRjnMACgkQc2J8L2kN
9xCaFg/8CdWwUEV8v2x5KpQvIcfoKD/njnQlce1SIp82aF1AOzJAYeLoBtFB+Nhw
/Gi3rKHEJFcaBlEMl+uFft9spp6/UtOXIEKMjwrG3pv5Ip7qncrq6xQ3hPbb+X+c
GBmHcQxjOO0YRKupeTDFFY31Jb4aUQwEgkHsPnq1XsHfJZdHF0pP+DzucG3kBGBe
zYB4GUIWl2oN7Ht5MbD606C4e7ZTSL2rYDy56bCFJCbmXfR9hT/gUsjtDVTJa25N
zaSIaKDNGXoF96W4bb+TxieaA2uKWK4a4dttypvQppjrjRWZ6DAXi+t3DjEiTE57
tq/P+2wB+x+87llN9CtbUcPSwa6vP7lPLIpedvwC7Azt2ePb+gvPrlBolHlIwVPz
Kx2quGAF70De7go8OaQCefvMfOUfFXyEMM4ms2OrPBU4LCTp283UrH+NTMm91wUu
OgLdR65A98g2NRr6YQF0Mu39TM9elshlFaVrgowJ8eS9bp4F9/MosJa3sX7HmfZh
c3rMXQ1K3dzNLpTReXjntZVzxbebkzf8fqrWW2Wc1oJPrDJD2uU3HKb6hFNxc/nu
l61juC+XWgaDXl1Y5M54n1+PJh/At/jch0RSzNHA5KPVckOOH7hNsL3uLtp/al5q
mhu61EK5GHmvUewYgsQzt7QJwNDIwBWh+IBcdSTkwi8KrL2egV8=
=2QS7
-----END PGP SIGNATURE-----

--m2b43yy3q4txuigf--
