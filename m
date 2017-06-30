Received: from eggs.gnu.org ([2001:4830:134:3::10]:41040)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dQlvY-0003YG-CQ
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 22:45:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dQlvX-0002ut-7R
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 22:45:00 -0400
References: <20170628232315.22777-1-mreitz@redhat.com>
	<20170629101008.GB4618@noname.redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <bc6ec1d8-f94c-904a-ff38-7c0b886d5d7b@redhat.com>
Date: Fri, 30 Jun 2017 04:44:45 +0200
MIME-Version: 1.0
In-Reply-To: <20170629101008.GB4618@noname.redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="S9XGWk04f1r8Mtfm5SLFXgrJTWidUeFiE"
Subject: Re: [Qemu-devel] [PATCH] iotests: Add test for dataplane mirroring
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--S9XGWk04f1r8Mtfm5SLFXgrJTWidUeFiE
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org
Message-ID: <bc6ec1d8-f94c-904a-ff38-7c0b886d5d7b@redhat.com>
Subject: Re: [PATCH] iotests: Add test for dataplane mirroring
References: <20170628232315.22777-1-mreitz@redhat.com>
 <20170629101008.GB4618@noname.redhat.com>
In-Reply-To: <20170629101008.GB4618@noname.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2017-06-29 12:10, Kevin Wolf wrote:
> Am 29.06.2017 um 01:23 hat Max Reitz geschrieben:
>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>> ---
>> Depends on Stefan's "virtio: use ioeventfd in TCG and qtest mode" seri=
es
>> to work at all, and on "mirror: Fix inconsistent backing AioContext fo=
r
>> after mirroring" (in my block branch) so it does not fail.
>> ---
>>  tests/qemu-iotests/106     | 97 +++++++++++++++++++++++++++++++++++++=
+++++++++
>>  tests/qemu-iotests/106.out | 14 +++++++
>=20
> Your initiative to fill up the numbering hole is laudable, but are you
> intentionally using 106 for multiple patches of yours? ;-)

Well, as I said, I'm fine with each new test having test number 001 and
then moving it when applying. O:-)

Wasn't intentional, but well, I find it easier to find free test numbers
when applying patches anyway...

In this case, though, since the other user of 106 is already fully
reviewed, it's probably better to move this out of the way.

>>  tests/qemu-iotests/group   |  1 +
>>  3 files changed, 112 insertions(+)
>>  create mode 100755 tests/qemu-iotests/106
>>  create mode 100644 tests/qemu-iotests/106.out
>>
>> diff --git a/tests/qemu-iotests/106 b/tests/qemu-iotests/106
>> new file mode 100755
>> index 0000000..ad438b5
>> --- /dev/null
>> +++ b/tests/qemu-iotests/106
>> @@ -0,0 +1,97 @@
>> +#!/bin/bash
>> +#
>> +# Test case for mirroring with dataplane
>> +#
>> +# Copyright (C) 2017 Red Hat, Inc.
>> +#
>> +# This program is free software; you can redistribute it and/or modif=
y
>> +# it under the terms of the GNU General Public License as published b=
y
>> +# the Free Software Foundation; either version 2 of the License, or
>> +# (at your option) any later version.
>> +#
>> +# This program is distributed in the hope that it will be useful,
>> +# but WITHOUT ANY WARRANTY; without even the implied warranty of
>> +# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>> +# GNU General Public License for more details.
>> +#
>> +# You should have received a copy of the GNU General Public License
>> +# along with this program.  If not, see <http://www.gnu.org/licenses/=
>.
>> +#
>> +
>> +# creator
>> +owner=3Dmreitz@redhat.com
>> +
>> +seq=3D$(basename $0)
>> +echo "QA output created by $seq"
>> +
>> +here=3D$PWD
>> +status=3D1    # failure is the default!
>> +
>> +_cleanup()
>> +{
>> +    _cleanup_qemu
>> +    _cleanup_test_img
>> +    _rm_test_img "$TEST_IMG.overlay0"
>> +    _rm_test_img "$TEST_IMG.overlay1"
>> +}
>> +trap "_cleanup; exit \$status" 0 1 2 3 15
>> +
>> +# get standard environment, filters and qemu instance handling
>> +. ./common.rc
>> +. ./common.filter
>> +. ./common.qemu
>> +
>> +_supported_fmt qcow2
>> +_supported_proto file
>> +_supported_os Linux
>> +
>> +IMG_SIZE=3D64K
>> +
>> +_make_test_img $IMG_SIZE
>> +TEST_IMG=3D"$TEST_IMG.overlay0" _make_test_img -b "$TEST_IMG" $IMG_SI=
ZE
>> +TEST_IMG=3D"$TEST_IMG.overlay1" _make_test_img -b "$TEST_IMG" $IMG_SI=
ZE
>> +
>> +# So that we actually have something to mirror and the job does not r=
eturn
>> +# immediately (which may be bad because then we cannot know whether t=
he
>> +# 'return' or the 'BLOCK_JOB_READY' comes first).
>> +$QEMU_IO -c 'write 0 64' "$TEST_IMG.overlay0" | _filter_qemu_io
>=20
> 64 bytes? Unusual, but yes, why not. We probably don't test this too
> often. :-)

*cough* well, somehow dropped the k there, but yes...

>> +# We cannot use virtio-blk here because that does not actually set th=
e attached
>> +# BB's AioContext in qtest mode
>=20
> Why that? I don't see any qtest special casing in the virtio-blk code,
> so is this intentional?

I don't know. But that's at least what I discovered when putting debug
code into bdrv_open_backing_file(); the overlay was still attached to
the main qemu AioContext.

>> +_launch_qemu \
>> +    -object iothread,id=3Diothr \
>> +    -blockdev node-name=3Dsource,driver=3D$IMGFMT,file.driver=3Dfile,=
file.filename=3D"$TEST_IMG.overlay0" \
>> +    -device virtio-scsi,id=3Dscsi-bus,iothread=3Diothr \
>> +    -device scsi-hd,bus=3Dscsi-bus.0,drive=3Dsource
>> +
>> +_send_qemu_cmd $QEMU_HANDLE \
>> +    "{ 'execute': 'qmp_capabilities' }" \
>> +    'return'
>> +
>> +_send_qemu_cmd $QEMU_HANDLE \
>> +    "{ 'execute': 'drive-mirror',
>> +       'arguments': {
>> +           'job-id': 'mirror',
>> +           'device': 'source',
>> +           'target': '$TEST_IMG.overlay1',
>> +           'mode':   'existing',
>> +           'sync':   'top'
>> +       } }" \
>> +    'BLOCK_JOB_READY'
>> +
>> +# The backing BDS should be assigned the overlay's AioContext
>> +_send_qemu_cmd $QEMU_HANDLE \
>> +    "{ 'execute': 'block-job-complete',
>> +       'arguments': { 'device': 'mirror' } }" \
>> +    'BLOCK_JOB_COMPLETED'
>> +
>> +_send_qemu_cmd $QEMU_HANDLE \
>> +    "{ 'execute': 'quit' }" \
>> +    'return'
>> +
>> +wait=3Dyes _cleanup_qemu
>> +
>> +# success, all done
>> +echo '*** done'
>> +rm -f $seq.full
>> +status=3D0
>=20
> The actual test looks good to me.

OK, thanks for reviewing. I'll just send a v2 because I'd like to fix
the 64 (at least change it to 42 so people don't think it's by accident!
*cough*) and doing both that and giving it a different test number at
the same time seems a bit much.

Or I can just follow your model which is to send it and keep it in my
branch at the same time. :-)

Max


--S9XGWk04f1r8Mtfm5SLFXgrJTWidUeFiE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEvBAEBCAAZBQJZVbseEhxtcmVpdHpAcmVkaGF0LmNvbQAKCRD0B9sAYdXPQPx2
B/9AaBp99OWHedeN8M96LVEE86/DXXotFm9p898VULcYlIFRoG3d46c79ULzB3lC
89JIuiqFoU4BTvkIqhSC1WkfgsmmqWtmJGkNfbuWXMcG98EM4w9xrnh/UZh8qn3T
UlEfZBpeOchzCO1XUdi3Wwvmps7LX/6sji2yT4X98HR8wECZtfFpkCv6ufr4IbE8
fWEGw5KCTb5aSUrmdgMnFHl9DVPc2rNaFgp4rO73hLoZPZ2iZCsIPnOKoqQzu/h1
BiYxJEHop1gBmhLPmweTilYJAhxz0qUFa/L7oEWEpk4SrDaQcP7oV5dC1q3l3A0T
DxGs3szoGH/h3Tw+ikR0jMM3
=Sa7u
-----END PGP SIGNATURE-----

--S9XGWk04f1r8Mtfm5SLFXgrJTWidUeFiE--
