Received: from eggs.gnu.org ([2001:4830:134:3::10]:41561)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fjn32-0003lT-52
	for qemu-devel@nongnu.org; Sun, 29 Jul 2018 10:51:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fjn31-0003RS-4U
	for qemu-devel@nongnu.org; Sun, 29 Jul 2018 10:51:52 -0400
References: <20180725151011.25951-1-armbru@redhat.com>
	<5e713599-997f-7dda-917c-80902f6ef328@redhat.com>
	<20180725160144.GJ12855@redhat.com>
	<20180728043238.GC1325070@localhost.localdomain>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <371fc437-1330-6873-7f6d-99af8d56c5df@redhat.com>
Date: Sun, 29 Jul 2018 16:51:40 +0200
MIME-Version: 1.0
In-Reply-To: <20180728043238.GC1325070@localhost.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="Q4wEcTnqIu4lUw3ERilshQwzhSbeNsxNP"
Subject: Re: [Qemu-devel] [RFC PATCH] rbd: Don't convert keypairs to JSON
 and back
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jeff Cody <jcody@redhat.com>, "=?UTF-8?Q?Daniel_P._Berrang=c3=a9?=" <berrange@redhat.com>
Cc: Eric Blake <eblake@redhat.com>, kwolf@redhat.com, jdurgin@redhat.com, qemu-block@nongnu.org, Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Q4wEcTnqIu4lUw3ERilshQwzhSbeNsxNP
From: Max Reitz <mreitz@redhat.com>
To: Jeff Cody <jcody@redhat.com>, =?UTF-8?Q?Daniel_P._Berrang=c3=a9?=
 <berrange@redhat.com>
Cc: Eric Blake <eblake@redhat.com>, kwolf@redhat.com, jdurgin@redhat.com,
 qemu-block@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 qemu-devel@nongnu.org
Message-ID: <371fc437-1330-6873-7f6d-99af8d56c5df@redhat.com>
Subject: Re: [Qemu-devel] [RFC PATCH] rbd: Don't convert keypairs to JSON and
 back
References: <20180725151011.25951-1-armbru@redhat.com>
 <5e713599-997f-7dda-917c-80902f6ef328@redhat.com>
 <20180725160144.GJ12855@redhat.com>
 <20180728043238.GC1325070@localhost.localdomain>
In-Reply-To: <20180728043238.GC1325070@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-07-28 06:32, Jeff Cody wrote:
> On Wed, Jul 25, 2018 at 05:01:44PM +0100, Daniel P. Berrang=C3=A9 wrote=
:
>> On Wed, Jul 25, 2018 at 10:56:48AM -0500, Eric Blake wrote:
>>> On 07/25/2018 10:10 AM, Markus Armbruster wrote:
>>>> qemu_rbd_parse_filename() builds a keypairs QList, converts it to JS=
ON, and
>>>> stores the resulting QString in a QDict.
>>>>
>>>> qemu_rbd_co_create_opts() and qemu_rbd_open() get the QString from t=
he
>>>> QDict, pass it to qemu_rbd_set_keypairs(), which converts it back in=
to
>>>> a QList.
>>>>
>>>> Drop both conversions, store the QList instead.
>>>>
>>>> This affects output of qemu-img info.  Before this patch:
>>>>
>>>>      $ qemu-img info rbd:rbd/testimg.raw:mon_host=3D192.168.15.180:r=
bd_cache=3Dtrue:conf=3D/tmp/ceph.conf
>>>>      [junk printed by Ceph library code...]
>>>>      image: json:{"driver": "raw", "file": {"pool": "rbd", "image": =
"testimg.raw", "conf": "/tmp/ceph.conf", "driver": "rbd", "=3Dkeyvalue-pa=
irs": "[\"mon_host\", \"192.168.15.180\", \"rbd_cache\", \"true\"]"}}
>>>>      [more output, not interesting here]
>>>>
>>>> After this patch, we get
>>>>
>>>>      image: json:{"driver": "raw", "file": {"pool": "rbd", "image": =
"testimg.raw", "conf": "/tmp/ceph.conf", "driver": "rbd", "=3Dkeyvalue-pa=
irs": ["mon_host", "192.168.15.180", "rbd_cache", "true"]}}
>>>>
>>>> The value of member "=3Dkeyvalue-pairs" changes from a string contai=
ning
>>>> a JSON array to that JSON array.  That's an improvement of sorts.  H=
owever:
>>>>
>>>> * Should "=3Dkeyvalue-pairs" even be visible here?  It's supposed to=
 be
>>>>    purely internal...
>>>
>>> I'd argue that since it is supposed to be internal (as evidenced by t=
he
>>> leading '=3D' that does not name a normal variable), changing it does=
n't hurt
>>> stability. But yes, it would be nicer if we could filter it entirely =
so that
>>> it does not appear in json: output, if it doesn't truly affect the co=
ntents
>>> that the guest would see.
>>
>> If it appears in the json: output, then that means it could get writte=
n
>> into qcow2 headers as a backing file name, which would make it ABI
>> sensitive. This makes it even more important to filter it if it is sup=
posed
>> to be internal only, with no ABI guarantee.
>>
>=20
> It's been present for a couple releases (counting 3.0); is it safe to
> assume that, although it could be present in the qcow2 headers, that it=
 will
> not break anything by altering it or removing it?

Did =3Dkeyvalue-pairs even work in json:{} filename?  If so, it will
continue to work even after filtering it.  If not, then filtering it
won't break existing files because they didn't work before either.

To me personally the issue is that if you can specify a plain filename,
bdrv_refresh_filename() should give you that plain filename back.  So
rbd's implementation of that is lacking.  Well, it just doesn't exist.

> If so, and we are comfortable changing the output the way this patch do=
es
> (technically altering ABI anyway), we might as well go all the way and
> filter it out completely.  That would be preferable to cleaning up the =
json
> output of the internal key/value pairs, IMO.

Well, this filtering at least is done by my "Fix some filename
generation issues" series.

Max


--Q4wEcTnqIu4lUw3ERilshQwzhSbeNsxNP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAltd1HwACgkQ9AfbAGHV
z0A+VAgAio1hlPY9EagPirtz31giaUVEuRTVFrhz/7jFjlcRKxysxtuNGaKb5YxB
NcRivQ1QAjMus0EnJQO2qgZU7TNNiM+eW5ubw8LShibg2TgQ+PgqdrRIg6ToxDHA
kH+PGxuCGTYddHRldQTQXc/OV/9LNKThrJxLkxKgEy3Z8btkQQDsCfZN3xPyvDTl
gfvSNPQS/QqhsgEgVcPcgbQ8jvjh6T5iq+xaraKiVNs4dYTkzymaHckKz4Lf1ltA
9TjJnsjlTbFleteXiymYdugmgi2e2zdpgOum7Y6a8MRc9cFWjbfZXWTGHzn7Tn/8
LihWVg5H7sFxhH7BwkOl/mlnrNv7nQ==
=nAt1
-----END PGP SIGNATURE-----

--Q4wEcTnqIu4lUw3ERilshQwzhSbeNsxNP--
