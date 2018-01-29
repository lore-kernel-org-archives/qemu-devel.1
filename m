Received: from eggs.gnu.org ([2001:4830:134:3::10]:57987)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1egDuF-0005IE-1U
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 13:11:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1egDuD-0006Mi-Oe
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 13:11:46 -0500
References: <20180111195225.4226-1-kwolf@redhat.com>
	<20180111195225.4226-5-kwolf@redhat.com>
	<99b05d90-756d-be4c-f6b5-240a26176d57@redhat.com>
	<20180129181046.GQ6141@localhost.localdomain>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <38a47c05-5e24-f9e6-30fc-8b446e431588@redhat.com>
Date: Mon, 29 Jan 2018 19:11:36 +0100
MIME-Version: 1.0
In-Reply-To: <20180129181046.GQ6141@localhost.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="m2AjRh12CdEo2wzZzeL5qrMfu8NIbpCft"
Subject: Re: [Qemu-devel] [RFC PATCH 04/10] qcow2: Pass
 BlockdevCreateOptions to qcow2_create2()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, pkrempa@redhat.com, eblake@redhat.com, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--m2AjRh12CdEo2wzZzeL5qrMfu8NIbpCft
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, pkrempa@redhat.com, eblake@redhat.com,
 qemu-devel@nongnu.org
Message-ID: <38a47c05-5e24-f9e6-30fc-8b446e431588@redhat.com>
Subject: Re: [RFC PATCH 04/10] qcow2: Pass BlockdevCreateOptions to
 qcow2_create2()
References: <20180111195225.4226-1-kwolf@redhat.com>
 <20180111195225.4226-5-kwolf@redhat.com>
 <99b05d90-756d-be4c-f6b5-240a26176d57@redhat.com>
 <20180129181046.GQ6141@localhost.localdomain>
In-Reply-To: <20180129181046.GQ6141@localhost.localdomain>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 2018-01-29 19:10, Kevin Wolf wrote:
> Am 29.01.2018 um 18:12 hat Max Reitz geschrieben:
>> On 2018-01-11 20:52, Kevin Wolf wrote:
>>> All of the simple options are now passed to qcow2_create2() in a
>>> BlockdevCreateOptions object. Still missing: node-name and the
>>> encryption options.
>>>
>>> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
>>> ---
>>>  block/qcow2.c | 186 ++++++++++++++++++++++++++++++++++++++++++++++--=
----------
>>>  1 file changed, 148 insertions(+), 38 deletions(-)
>>>
>>> diff --git a/block/qcow2.c b/block/qcow2.c
>>> index b02bc39a01..09e567324d 100644
>>> --- a/block/qcow2.c
>>> +++ b/block/qcow2.c
>>
>> [...]
>>
>>> @@ -2690,12 +2697,11 @@ static uint64_t qcow2_opt_get_refcount_bits_d=
el(QemuOpts *opts, int version,
>>>      return refcount_bits;
>>>  }
>>> =20
>>> -static int qcow2_create2(BlockDriverState *bs, int64_t total_size,
>>> -                         const char *backing_file, const char *backi=
ng_format,
>>> -                         int flags, size_t cluster_size, PreallocMod=
e prealloc,
>>> -                         QemuOpts *opts, int version, int refcount_o=
rder,
>>> -                         const char *encryptfmt, Error **errp)
>>> +static int qcow2_create2(BlockDriverState *bs,
>>> +                         BlockdevCreateOptions *create_options,
>>
>> I'd personally really prefer this to be const...
>>
>>> +                         QemuOpts *opts, const char *encryptfmt, Err=
or **errp)
>>>  {
>>> +    BlockdevCreateOptionsQcow2 *qcow2_opts;
>>>      QDict *options;
>>> =20
>>>      /*
>>> @@ -2712,10 +2718,88 @@ static int qcow2_create2(BlockDriverState *bs=
, int64_t total_size,
>>
>> [...]
>>
>>> +
>>> +    if (!qcow2_opts->has_preallocation) {
>>> +        qcow2_opts->preallocation =3D PREALLOC_MODE_OFF;
>>> +    }
>>> +    if (qcow2_opts->backing_file &&
>>> +        qcow2_opts->preallocation !=3D PREALLOC_MODE_OFF)
>>> +    {
>>> +        error_setg(errp, "Backing file and preallocation cannot be u=
sed at "
>>> +                   "the same time");
>>> +        return -EINVAL;
>>> +    }
>>> +
>>> +    if (!qcow2_opts->has_lazy_refcounts) {
>>> +        qcow2_opts->lazy_refcounts =3D false;
>>
>> ...because modifying some ideally QMP-provided objects just looks wron=
g.
>=20
> Isn't this pretty standard, though? Most commands don't use boxed
> options, so there they only modify stack variables, but if you look at
> boxed ones like do_blockdev_backup() or qmp_drive_mirror(), they do the=

> same.

:C


--m2AjRh12CdEo2wzZzeL5qrMfu8NIbpCft
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlpvY9gSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9Aqv0IALPfQGtt9FHCiFfU3iHdveubiwV/KCE8
UJk6c5k47n6fTWQt5EOLNslMVJABb9mTbBSHiEfA1TRi/4b+O7jVa+7A9W6Diaqe
Ggq7FDRcf43h4TmU2bbKEW9qvs5Qhx9u54dRUKtQkyQFTkS+Aj9O5v0nt5wHM1PY
21gXdd8HEHU5PSOIURRDHtSHyAeaRZg6rYirl3iEuJ3XuunfLCA4geRThORZWDg4
CCxcmAXWDEn1Q+uBVYNLW9Y/KhwfvBB6Pfstog7M32vavEMtgoZBNGmeowSzn5wD
GVPXsIjXsGj/HtYeTNrv8EKYz+PV9xTYTIu0l3HA8guSI6gMWq6H3+o=
=kc5l
-----END PGP SIGNATURE-----

--m2AjRh12CdEo2wzZzeL5qrMfu8NIbpCft--
