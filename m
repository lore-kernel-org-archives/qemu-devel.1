Received: from eggs.gnu.org ([2001:4830:134:3::10]:36601)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dUJei-0000pS-J9
	for qemu-devel@nongnu.org; Sun, 09 Jul 2017 17:22:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dUJeh-0002JA-An
	for qemu-devel@nongnu.org; Sun, 09 Jul 2017 17:22:16 -0400
References: <20170707143028.692-1-pbutsykin@virtuozzo.com>
	<20170707143028.692-2-pbutsykin@virtuozzo.com>
	<02872724-780e-cfbf-4e19-eb772764c645@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <4df4fd60-07f4-c0ca-c0b5-f5a777230d32@redhat.com>
Date: Sun, 9 Jul 2017 23:22:01 +0200
MIME-Version: 1.0
In-Reply-To: <02872724-780e-cfbf-4e19-eb772764c645@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="MnfMDcxa02mwejikm28I9Gb6JBkB2INCk"
Subject: Re: [Qemu-devel] [PATCH v3 1/4] qemu-img: add --shrink flag for
 resize
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, Pavel Butsykin <pbutsykin@virtuozzo.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, armbru@redhat.com, den@openvz.org, Alistair Francis <alistair.francis@xilinx.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--MnfMDcxa02mwejikm28I9Gb6JBkB2INCk
From: Max Reitz <mreitz@redhat.com>
To: Eric Blake <eblake@redhat.com>, Pavel Butsykin <pbutsykin@virtuozzo.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, armbru@redhat.com, den@openvz.org,
 Alistair Francis <alistair.francis@xilinx.com>
Message-ID: <4df4fd60-07f4-c0ca-c0b5-f5a777230d32@redhat.com>
Subject: Re: [PATCH v3 1/4] qemu-img: add --shrink flag for resize
References: <20170707143028.692-1-pbutsykin@virtuozzo.com>
 <20170707143028.692-2-pbutsykin@virtuozzo.com>
 <02872724-780e-cfbf-4e19-eb772764c645@redhat.com>
In-Reply-To: <02872724-780e-cfbf-4e19-eb772764c645@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2017-07-07 23:12, Eric Blake wrote:
> On 07/07/2017 09:30 AM, Pavel Butsykin wrote:
>> The flag as additional precaution of data loss. Perhaps in the future =
the
>=20
> s/as/is/ s/of/against/
>=20
>> operation shrink without this flag will be blocked for all formats, bu=
t while
>=20
> s/while/for now/
>=20
>> we need to maintain compatibility with raw.
>>
>> Signed-off-by: Pavel Butsykin <pbutsykin@virtuozzo.com>
>> ---
>>  qemu-img-cmds.hx       |  4 ++--
>>  qemu-img.c             | 23 +++++++++++++++++++++++
>>  qemu-img.texi          |  7 ++++++-
>>  tests/qemu-iotests/102 |  4 ++--
>>  4 files changed, 33 insertions(+), 5 deletions(-)
>>
>=20
>> @@ -3568,6 +3574,23 @@ static int img_resize(int argc, char **argv)
>>          goto out;
>>      }
>> =20
>> +    if (total_size < blk_getlength(blk) && !shrink) {
>> +        error_report("Warning: Shrinking an image will delete all dat=
a beyond"
>=20
> Alistair has a pending thread to create a unified warning function; if
> that lands first, you'll have to tweak this (if yours lands first, it's=

> one more place for that series to clean up).
>=20
>> +                     "the shrunken image's end. Before performing suc=
h an"
>> +                     "operation, make sure there is no important data=
 there.");
>> +
>> +        if (g_strcmp0(bdrv_get_format_name(blk_bs(blk)), "raw") !=3D =
0) {
>> +            error_report(
>> +              "Use the --shrink option to perform a shrink operation.=
");
>> +            ret =3D -1;
>> +            goto out;
>> +        } else {
>> +            error_report("Using the --shrink option will suppress thi=
s message."
>> +                         "Note that future versions of qemu-img may r=
efuse to "
>> +                         "shrink images without this option!");
>=20
> No need to shout at the user ('.' is better than '!')
>=20
>> +        }
>> +    }
>> +
>>      ret =3D blk_truncate(blk, total_size, &err);
>>      if (!ret) {
>>          qprintf(quiet, "Image resized.\n");
>> diff --git a/qemu-img.texi b/qemu-img.texi
>> index 5b925ecf41..6324abef48 100644
>> --- a/qemu-img.texi
>> +++ b/qemu-img.texi
>> @@ -499,7 +499,7 @@ qemu-img rebase -b base.img diff.qcow2
>>  At this point, @code{modified.img} can be discarded, since
>>  @code{base.img + diff.qcow2} contains the same information.
>> =20
>> -@item resize @var{filename} [+ | -]@var{size}
>> +@item resize [--shrink] @var{filename} [+ | -]@var{size}
>> =20
>>  Change the disk image as if it had been created with @var{size}.
>> =20
>> @@ -507,6 +507,11 @@ Before using this command to shrink a disk image,=
 you MUST use file system and
>>  partitioning tools inside the VM to reduce allocated file systems and=
 partition
>>  sizes accordingly.  Failure to do so will result in data loss!
>> =20
>> +@code{--shrink} informs qemu-img that the user is certain about wanti=
ng
>> +to shrink an image and is aware that any data beyond the truncated
>> +image's end will be lost. Trying to shrink an image without this opti=
on
>> +results in a warning; future versions may make it an error.
>=20
> You made it an error for all but raw already, but I'm not sure how word=
y
> we want this to be.

Easy, just make it "...image's end will be lost. This option must always
be specified when shrinking images."

(Or even just put it up front: "When shrinking images, the
@code{--shrink} option must be given.  This informs qemu-img that the
user acknowledges all loss of data beyond the truncated image's end.")

Sure, this is not entirely correct for raw images right now, but we
basically want it to be mandatory there, too.  We just cannot do it for
compatibility reasons(TM) yet -- it won't hurt to tell users the
future-proof way already.

>> +
>>  After using this command to grow a disk image, you must use file syst=
em and
>>  partitioning tools inside the VM to actually begin using the new spac=
e on the
>>  device.
>> diff --git a/tests/qemu-iotests/102 b/tests/qemu-iotests/102
>> index 87db1bb1bf..d7ad8d9840 100755
>> --- a/tests/qemu-iotests/102
>> +++ b/tests/qemu-iotests/102
>> @@ -54,7 +54,7 @@ _make_test_img $IMG_SIZE
>>  $QEMU_IO -c 'write 0 64k' "$TEST_IMG" | _filter_qemu_io
>>  # Remove data cluster from image (first cluster: image header, second=
: reftable,
>>  # third: refblock, fourth: L1 table, fifth: L2 table)
>> -$QEMU_IMG resize -f raw "$TEST_IMG" $((5 * 64 * 1024))
>> +$QEMU_IMG resize -f raw --shrink "$TEST_IMG" $((5 * 64 * 1024))
>> =20
>>  $QEMU_IO -c map "$TEST_IMG"
>>  $QEMU_IMG map "$TEST_IMG"
>> @@ -69,7 +69,7 @@ $QEMU_IO -c 'write 0 64k' "$TEST_IMG" | _filter_qemu=
_io
>> =20
>>  qemu_comm_method=3Dmonitor _launch_qemu -drive if=3Dnone,file=3D"$TES=
T_IMG",id=3Ddrv0
>> =20
>> -$QEMU_IMG resize -f raw "$TEST_IMG" $((5 * 64 * 1024))
>> +$QEMU_IMG resize -f raw --shrink "$TEST_IMG" $((5 * 64 * 1024))
>=20
> This tests a successful shrink. Please also test the error message when=

> attempting to shrink but --shrink was not supplied.

This doesn't test this, it just modifies an existing test to continue to
work.  The test is added in patch 4.

With the spelling fixed as proposed by Eric, and the man page indeed
telling users to always use --shrink:

Reviewed-by: Max Reitz <mreitz@redhat.com>


--MnfMDcxa02mwejikm28I9Gb6JBkB2INCk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEvBAEBCAAZBQJZYp55EhxtcmVpdHpAcmVkaGF0LmNvbQAKCRD0B9sAYdXPQJvh
CADEFpAD1CrgY/g3kNRlJd7DTc81yf/B84Fl1i8pjRJ8h9MON7yPEKwiBM0Yw5LM
JNbAtOiyv8omgXqdQ/XnWf2EqjZmo7JsQ8LHOg8me3y9TyYOkCQSgwKUqpyUKxMn
sJD8gQYtKQJETcPv4HGt27CvIKMBVpc3QlXpPpdJCnwEEXhjx+fyLWdKDoSoY5te
3jUmXlHmqR6Q8YUg4QEsmkc/hhBJ74ds/KQNzcAcQ76wHsqX86Ya/tUR+1f/W+Op
ldf29kOtINnNMpgeHjppiFhOOW3k4o9/IM5jc2mjcIA7DlhxtmVcExG3v/hQoW5a
LDqBA+4FqmFotZJKs8naGy6B
=P+GL
-----END PGP SIGNATURE-----

--MnfMDcxa02mwejikm28I9Gb6JBkB2INCk--
