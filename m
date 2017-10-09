Received: from eggs.gnu.org ([2001:4830:134:3::10]:40066)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1e1cp3-0002Gn-KL
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 14:30:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1e1cp2-00044k-IG
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 14:30:37 -0400
From: Max Reitz <mreitz@redhat.com>
References: <20170913181910.29688-1-mreitz@redhat.com>
	<20170913181910.29688-3-mreitz@redhat.com>
	<20170918034431.GA15551@lemon.lan>
	<85fd9e96-4135-a62d-76ff-631104cd02f1@redhat.com>
Message-ID: <cdbbf746-e432-37b3-b941-03006e6f9519@redhat.com>
Date: Mon, 9 Oct 2017 20:30:13 +0200
MIME-Version: 1.0
In-Reply-To: <85fd9e96-4135-a62d-76ff-631104cd02f1@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="m0Q4rX1kppHQgMjPOhj4awGdSR7spaqpW"
Subject: Re: [Qemu-devel] [PATCH 02/18] block: BDS deletion during
 bdrv_drain_recurse
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, John Snow <jsnow@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--m0Q4rX1kppHQgMjPOhj4awGdSR7spaqpW
From: Max Reitz <mreitz@redhat.com>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 John Snow <jsnow@redhat.com>
Message-ID: <cdbbf746-e432-37b3-b941-03006e6f9519@redhat.com>
Subject: Re: [PATCH 02/18] block: BDS deletion during bdrv_drain_recurse
References: <20170913181910.29688-1-mreitz@redhat.com>
 <20170913181910.29688-3-mreitz@redhat.com> <20170918034431.GA15551@lemon.lan>
 <85fd9e96-4135-a62d-76ff-631104cd02f1@redhat.com>
In-Reply-To: <85fd9e96-4135-a62d-76ff-631104cd02f1@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2017-09-18 18:13, Max Reitz wrote:
> On 2017-09-18 05:44, Fam Zheng wrote:
>> On Wed, 09/13 20:18, Max Reitz wrote:
>>> Drainined a BDS child may lead to both the original BDS and/or its ot=
her
>>> children being deleted (e.g. if the original BDS represents a block
>>> job).  We should prepare for this in both bdrv_drain_recurse() and
>>> bdrv_drained_begin() by monitoring whether the BDS we are about to dr=
ain
>>> still exists at all.
>>
>> Can the deletion happen when IOThread calls
>> bdrv_drain_recurse/bdrv_drained_begin?
>=20
> I don't think so, because (1) my issue was draining a block job and tha=
t
> can only be completed in the main loop, and (2) I would like to think
> it's always impossible, considering that bdrv_unref() may only be calle=
d
> with the BQL.
>=20
>>                                         If not, is it enough to do
>>
>>     ...
>>     if (in_main_loop) {
>>         bdrv_ref(bs);
>>     }
>>     ...
>>     if (in_main_loop) {
>>         bdrv_unref(bs);
>>     }
>>
>> to protect the main loop case? So the BdrvDeletedStatus state is not n=
eeded.
>=20
> We already have that in bdrv_drained_recurse(), don't we?
>=20
> The issue here is, though, that QLIST_FOREACH_SAFE() stores the next
> child pointer to @tmp.  However, once the current child @child is
> drained, @tmp may no longer be valid -- it may have been detached from
> @bs, and it may even have been deleted.
>=20
> We could work around the latter by increasing the next child's referenc=
e
> somehow (but BdrvChild doesn't really have a refcount, and in order to
> do so, we would probably have to emulate being a parent or
> something...), but then you'd still have the issue of @tmp being
> detached from the children list we're trying to iterate over.  So
> tmp->next is no longer valid.
>=20
> Anyway, so the latter is the reason why I decided to introduce the bs_l=
ist.
>=20
> But maybe that actually saves us from having to fiddle with BdrvChild..=
=2E
>  Since it's just a list of BDSs now, it may be enough to simply
> bdrv_ref() all of the BDSs in that list before draining any of them.  S=
o
>  we'd keep creating the bs_list and then we'd move the existing
> bdrv_ref() from the drain loop into the loop filling bs_list.
>=20
> And adding a bdrv_ref()/bdrv_unref() pair to bdrv_drained_begin() shoul=
d
> hopefully work there, too.

It turns out it isn't so simple after all... because bdrv_close()
invokes bdrv_drained_begin(). So we may end up with an endless recursion
here.

One way to fix this would be to skip the bdrv_drained_begin() in
bdrv_close() if this would result in such a recursion...  But any
solution that comes quickly to my mind would require another BDS field,
too -- just checking the quiesce_counter is probably not enough because
this might just indicate concurrent drainage that stops before
bdrv_close() wants it to stop.

So maybe BdrvDeletedStatus is the simplest solution after all...?

Max


--m0Q4rX1kppHQgMjPOhj4awGdSR7spaqpW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlnbwDUSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9A6AUH/A58EEeB3s2qaFsrpM8GwxTTp2XN+r0D
uDVTJ9d3xDB4WVHmDQszCoXp7K1v5Q5TtGZ3ZQNkE1bZoEqFi9G96sFJ6X9dTJQ3
GIHe/otVoBMo09XU3HwqRn/Afu4+Ngu6THG7G0He74Tn6CfwYOAZWzwFfM3HZw0m
d9Xnk5g0KYhGJWM6TJipDslKijcmaP/gDntGEOwE1/nsUUZOGIx66yXslWpjAfFi
yU7ILcRfekDR0/5Hueg5krRbO5zN2Y6VsKBP/hEvo6keVE8Kw2xMy5W1xECUuNdV
UIBi5emqW8V0RJP4t9zj3Iwlho2on8ME14ezNhxuW0EH/N0rPLJVN2I=
=RGVE
-----END PGP SIGNATURE-----

--m0Q4rX1kppHQgMjPOhj4awGdSR7spaqpW--
