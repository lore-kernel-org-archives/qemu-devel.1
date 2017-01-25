Received: from eggs.gnu.org ([2001:4830:134:3::10]:34058)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cWPl6-0004YJ-8H
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 10:45:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cWPl5-0000ev-BF
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 10:45:16 -0500
References: <20170103182801.9638-1-berrange@redhat.com>
	<20170103182801.9638-13-berrange@redhat.com>
	<fdf48e56-2b65-b0cd-39da-010ca751cc02@redhat.com>
	<20170124135848.GA28745@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <5344f8c8-7869-24bc-7bbb-8ecc958f3ce5@redhat.com>
Date: Wed, 25 Jan 2017 16:45:04 +0100
MIME-Version: 1.0
In-Reply-To: <20170124135848.GA28745@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="sdPOg0T7m0de7OB8lXrwTcssQKQo5WmHq"
Subject: Re: [Qemu-devel] [PATCH v1 12/15] qcow2: add support for LUKS
 encryption format
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--sdPOg0T7m0de7OB8lXrwTcssQKQo5WmHq
From: Max Reitz <mreitz@redhat.com>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org
Message-ID: <5344f8c8-7869-24bc-7bbb-8ecc958f3ce5@redhat.com>
Subject: Re: [PATCH v1 12/15] qcow2: add support for LUKS encryption format
References: <20170103182801.9638-1-berrange@redhat.com>
 <20170103182801.9638-13-berrange@redhat.com>
 <fdf48e56-2b65-b0cd-39da-010ca751cc02@redhat.com>
 <20170124135848.GA28745@redhat.com>
In-Reply-To: <20170124135848.GA28745@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 24.01.2017 14:58, Daniel P. Berrange wrote:
> On Sat, Jan 21, 2017 at 07:57:45PM +0100, Max Reitz wrote:
>> On 03.01.2017 19:27, Daniel P. Berrange wrote:

[...]

>>> diff --git a/tests/qemu-iotests/174 b/tests/qemu-iotests/174
>>> new file mode 100755
>>> index 0000000..27d4870
>>> --- /dev/null
>>> +++ b/tests/qemu-iotests/174
>>> +_supported_fmt qcow2
>>> +_supported_proto generic
>>> +_supported_os Linux
>>> +
>>> +
>>> +size=3D128M
>>> +
>>> +SECRET=3D"secret,id=3Dsec0,data=3Dastrochicken"
>>> +SECRETALT=3D"secret,id=3Dsec0,data=3Dplatypus"
>>> +
>>> +_make_test_img --object $SECRET -o "encryption-format=3Dluks,luks-ke=
y-secret=3Dsec0" $size
>>> +
>>> +IMGSPEC=3D"driver=3D$IMGFMT,file.filename=3D$TEST_IMG,luks-key-secre=
t=3Dsec0"
>>> +
>>> +QEMU_IO_OPTIONS=3D$QEMU_IO_OPTIONS_NO_FMT
>>> +
>>> +echo
>>> +echo "=3D=3D reading whole image =3D=3D"
>>> +$QEMU_IO --object $SECRET -c "read 0 $size" --image-opts $IMGSPEC | =
_filter_qemu_io | _filter_testdir
>>
>> Shouldn't "read -P 0 0 $size" work here, too?
>=20
> The underlying disk image contents will be zeros, but we'll then decryp=
t
> those zeros and get random garbage.

There are not disk image contents yet because you didn't use
preallocation. qcow2_co_preadv() always returns 0 for unallocated
clusters (without a backing file) and zero clusters.

While looking at that place in qcow2_co_preadv(), I also noticed that
compressed clusters are not encrypted. That looks like a flaw to me that
the user should at least be warned about when invoking qemu-img convert
with the -c option.

(You can test this by converting a disk image to an encrypted compressed
image (qemu-img convert with -c and -o encryption-format=3Dluks; note thi=
s
doesn't actually work unless you hack into qemu-img.c, I'll write a
separate mail about this as a response to the cover letter) and then
just set the crypt_method field to 0 and overwrite the disk encryption
header extension type with 0. If all of the clusters could be compressed
(which is the case if the original image was all filled with 42-bytes or
something), then qemu-img compare will happily declare your image to be
equal to the original, without requiring any key.)

> We could only use -P 0 if we explicitly fill with encrypted-zeros.

Max


--sdPOg0T7m0de7OB8lXrwTcssQKQo5WmHq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAliIyAASHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AzSUIAIMl2AUBt49AFQFIpBJRuMMwuJXOI3F5
gtiy8NB7ho8sipRNrojFPrfgDlIfrLBXkzbp+neajh32evgia5HyEYqlgThzk0he
osIVm3KcwZErsRu5u0W/WfQIFhbMEzos+wr3zsiz5xbnTOD0Nl2goYcPlQSAwLZx
XJtJ+YMiuRZlVCVDvI4BH7NSt5t0cRUVYo1TTezR/ECvKsF5d5mSrcCGL2sBl589
JJzXoNIutGfadSb6U0uB0OIhZ2plNXMVZKqxfDjNT6TEU92MRtSt+XmaBWARxTAj
HSNXhb6EZQSb40R4DaSOTjjDzrcpsBWOMujlvROx7v3995QiusZVuxg=
=wAAC
-----END PGP SIGNATURE-----

--sdPOg0T7m0de7OB8lXrwTcssQKQo5WmHq--
