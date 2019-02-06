Received: from eggs.gnu.org ([209.51.188.92]:52945)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1grQoJ-00035w-14
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 12:16:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1grQoH-0005Nj-4E
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 12:16:30 -0500
References: <20190206152919.5532-1-mreitz@redhat.com>
	<20190206163704.GV12500@redhat.com>
	<0d644429-0b16-bc7c-c583-d4684e47adb1@redhat.com>
	<20190206170046.GW12500@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <3a137eb6-1f78-5cc9-a995-3f46ed7eb1cc@redhat.com>
Date: Wed, 6 Feb 2019 18:16:20 +0100
MIME-Version: 1.0
In-Reply-To: <20190206170046.GW12500@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="mVm2mCyIt2TffUZC0CRfN4zYSnyzt7dWs"
Subject: Re: [Qemu-devel] [PATCH v2 0/2] block/ssh: Implement
 .bdrv_refresh_filename()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Richard W.M. Jones" <rjones@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--mVm2mCyIt2TffUZC0CRfN4zYSnyzt7dWs
From: Max Reitz <mreitz@redhat.com>
To: "Richard W.M. Jones" <rjones@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>
Message-ID: <3a137eb6-1f78-5cc9-a995-3f46ed7eb1cc@redhat.com>
Subject: Re: [PATCH v2 0/2] block/ssh: Implement .bdrv_refresh_filename()
References: <20190206152919.5532-1-mreitz@redhat.com>
 <20190206163704.GV12500@redhat.com>
 <0d644429-0b16-bc7c-c583-d4684e47adb1@redhat.com>
 <20190206170046.GW12500@redhat.com>
In-Reply-To: <20190206170046.GW12500@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 06.02.19 18:00, Richard W.M. Jones wrote:
> On Wed, Feb 06, 2019 at 05:42:15PM +0100, Max Reitz wrote:
>> On 06.02.19 17:37, Richard W.M. Jones wrote:
>>> On Wed, Feb 06, 2019 at 04:29:17PM +0100, Max Reitz wrote:
>>>> This series implements .bdrv_refresh_filename() for the ssh block
>>>> driver, along with an appropriate .bdrv_dirname() so we don't chop o=
ff
>>>> query strings for backing files with relative filenames.
>>>>
>>>> This series depends on my "block: Fix some filename generation issue=
s"
>>>> series.
>>>>
>>>> Based-on: 20190201192935.18394-1-mreitz@redhat.com
>>>
>>> I have verified that this doesn't appear to break the existing driver=
:
>>> ssh connections to block devices still work as well as they did befor=
e
>>> (which is to say, not very well, I wish we would replace this driver
>>> with Pino Toscano's reimplementation that uses libssh1).
>>>
>>> However I wasn't sure how I could trigger the bdrv_refresh_filename
>>> code path, so I don't think I tested that.
>>
>> One test case goes like this:
>>
>> Before this series:
>>
>> $ ./qemu-img create -f qcow2 /tmp/base.qcow2 64M
>> $ ./qemu-img create -f qcow2 -b base.qcow2 /tmp/top.qcow2
>> $ ./qemu-img info ssh://localhost/tmp/top.qcow2
>> image: json:{"driver": "qcow2", "file": {"server.host": "localhost",
>> "server.port": "22", "driver": "ssh", "path": "/tmp/top.qcow2"}}
>> [...]
>> backing file: base.qcow2 (cannot determine actual path)
>> [...]
>> $ ./qemu-io ssh://localhost/tmp/top.qcow2
>> can't open device ssh://localhost/tmp/top.qcow2: Cannot generate a bas=
e
>> directory for ssh nodes
>>
>>
>> So the filename is weird and you cannot open overlays with relative
>> backing files.
>>
>> After this series:
>>
>> $ ./qemu-img info ssh://localhost/tmp/top.qcow2
>> image: ssh://maxx@localhost:22/tmp/top.qcow2
>> [...]
>> backing file: base.qcow2 (actual path:
>> ssh://maxx@localhost:22/tmp/base.qcow2)
>> $ ./qemu-io ssh://localhost/tmp/top.qcow2
>> qemu-io> quit
>>
>> The filename looks better and the image is usable.
>=20
> I have to use ?host_key_check=3Dno because of my modern ssh server.  I
> see this error (with your patch series applied):
>=20
> $ ./qemu-img info 'ssh://localhost/tmp/top.qcow2?host_key_check=3Dno'
> image: ssh://rjones@localhost:22/tmp/top.qcow2?host_key_check=3Dno
> ...
> backing file: base.qcow2 (cannot determine actual path)
>=20
> $ ./qemu-io 'ssh://localhost/tmp/top.qcow2?host_key_check=3Dno'
> can't open device ssh://localhost/tmp/top.qcow2?host_key_check=3Dno: Ca=
nnot generate a base directory with host_key_check set
>=20
> I can see the error message in block/ssh.c:
>=20
> static char *ssh_bdrv_dirname(BlockDriverState *bs, Error **errp)
> {
>     if (qdict_haskey(bs->full_open_options, "host_key_check")) {
>         /*
>          * We cannot generate a simple prefix if we would have to
>          * append a query string.
>          */
>         error_setg(errp,
>                    "Cannot generate a base directory with host_key_chec=
k set");
>=20
> It seems as if bdrv_dirname is mis-designed?  Either it shouldn't
> assume dirname is always a strict prefix of a path, or g_strconcatdir
> [from bdrv_make_absolute_filename] should really be a bdrv_* function
> so that block devices can override it.

We can always make it more complicated, yes. :-)

> In any case I don't think this should hold up the patch, so:
>=20
> Tested-by: Richard W.M. Jones <rjones@redhat.com>

Thanks!

Max


--mVm2mCyIt2TffUZC0CRfN4zYSnyzt7dWs
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlxbFmQACgkQ9AfbAGHV
z0AajQf7BlJlNCxFimVPNKNTfcj8d9W2fGy5xveRB0YFQH3ne1jCi+lAjDL1AUAq
FeGlKsm1janZDUjBwE1N3ejX4XTRF/9GBOAGnNTnCjqoXd2oXQReAY6Axtyz/Uk2
qIIhtMpo/PvD86OGpozlpZYXc3nmPoyzc0IsautSIKCR+u3aY3dP86Cf3w1KK3D6
vCfUH5E8tv7qgY/luOo4WKRpRSpovRT+ApBSq5x2nwZ8xo17Qmv5gJrYIWqYWiqN
HokNRTNPWygRkXdKFhAHArLIEoCwQSKdO5wk+7xC8l7aZqmORebtcPME+Ycm+kVJ
RAcPL41Iq0+7dsl0uiWv5OXseCjhnw==
=7ttM
-----END PGP SIGNATURE-----

--mVm2mCyIt2TffUZC0CRfN4zYSnyzt7dWs--
