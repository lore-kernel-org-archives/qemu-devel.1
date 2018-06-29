Received: from eggs.gnu.org ([2001:4830:134:3::10]:59452)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fZ0ZB-0003F3-8x
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 17:04:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fZ0Z9-000156-FD
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 17:04:29 -0400
References: <20180629151524.138542-1-vsementsov@virtuozzo.com>
	<20180629151524.138542-4-vsementsov@virtuozzo.com>
	<fadc548f-0cde-769a-8523-80fa0a28ac81@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <73a74a66-1a16-5cb5-1851-3598c908700b@redhat.com>
Date: Fri, 29 Jun 2018 17:04:19 -0400
MIME-Version: 1.0
In-Reply-To: <fadc548f-0cde-769a-8523-80fa0a28ac81@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 3/3] qemu-iotests: Image fleecing test
 case 222
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: kwolf@redhat.com, famz@redhat.com, armbru@redhat.com, mreitz@redhat.com, den@openvz.org



On 06/29/2018 01:58 PM, Eric Blake wrote:
> On 06/29/2018 10:15 AM, Vladimir Sementsov-Ogievskiy wrote:
>> From: Fam Zheng <famz@redhat.com>
>>
>> This tests the workflow of creating a lightweight point-in-time snapsh=
ot
>> with blockdev-backup command, and exporting it with built-in NBD serve=
r.
>>
>> It's tested that any post-snapshot writing to the original device
>> doesn't change data seen in NBD target.
>>
>> Signed-off-by: Fam Zheng <famz@redhat.com>
>> [vsementsov: add -f iotests.imgfmt to qemu_io, fix target_img to be
>> always qcow2, add -r to qemu_io for nbd, add fleecing-filter layer,
>> wrap long lines]
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>=20
> For my own records: Fam's most recent post was:
> https://lists.gnu.org/archive/html/qemu-devel/2014-05/msg03895.html
> [Qemu-devel] [PATCH v20 15/15] qemu-iotests: Image fleecing test case 0=
89
>=20
> Wow - has it really been FOUR YEARS since we first proposed this?
>=20

Yup...

> I'm trying to figure out why that original post was abandoned; it looks
> like:
> https://lists.gnu.org/archive/html/qemu-devel/2014-05/msg04333.html
>=20
> split that v20 series into stuff that was ready (which made it in back
> then), and stuff that was still undergoing comments (which then stalled
> and got lost in the shuffle until now).
>=20
> My next question: how does this compare to John's recent patch?=C2=A0 A=
nd how
> much of Fam's original work did John borrow (that self.patterns array
> looks pretty common, now that I'm looking at multiple mails - although
> John's version lacks any commit message body):
> https://lists.gnu.org/archive/html/qemu-devel/2018-06/msg08594.html
>=20

Mine was indeed inspired by Fam's version, but I opted to rewrite it
instead of continue with the python unit tests approach. This is why I
lost the commit message, existing copyright text, etc.

I can re-add him as author credit to my version, or at least mention in
the commit message that it was based on a proposed test that he wrote.

I'm sorry if that was a faux pas.

> And given the iterative improvements that have gone into John's version
> (such as checking that the fleece image reads overwritten zeroes just a=
s
> correctly as overwritten data), we definitely need to merge the two
> approaches into one patch.
>=20

And before we do that, getting to the bottom of patch 2/3 in this series
is in order.

>> +++ b/tests/qemu-iotests/222
>> @@ -0,0 +1,112 @@
>> +#!/usr/bin/env python
>> +#
>> +# Tests for image fleecing (point in time snapshot export to NBD)
>> +#
>> +# Copyright (C) 2014 Red Hat, Inc.
>> +#
>=20
> Interesting copyright line; it matches Fam's original post (and the fac=
t
> that you kept him as author); whereas John's version had the humorous:
>=20
> +# Copyright (C) 2018 Red Hat, Inc.
> +# John helped, too.
>=20
>> +# Based on 055.
>=20
> Is this information still useful? John dropped it.
>=20

My version started with a blank test which was based on an unmerged
test, so it didn't have anything useful to reference as a "source." If
we keep the python unit test style here, keeping this line is fine.

>> +
>> +test_img =3D os.path.join(iotests.test_dir, 'test.img')
>> +target_img =3D os.path.join(iotests.test_dir, 'target.img')
>> +nbd_sock =3D os.path.join(iotests.test_dir, 'nbd.sock')
>> +
>> +class TestImageFleecing(iotests.QMPTestCase):
>> +=C2=A0=C2=A0=C2=A0 image_len =3D 64 * 1024 * 1024 # MB
>> +
>> +=C2=A0=C2=A0=C2=A0 def setUp(self):
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 # Write data to the image =
so we can compare later
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 qemu_img('create', '-f', i=
otests.imgfmt, test_img,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 str(TestImageFleecing.image_len))
>=20
> Difference in style between nested methods of a class, vs. directly
> using 'with iotests.FilePath(..., iotests.VM() as vm:'
>=20

Because this version will use the cleanup infrastructure as part of the
unit tests, unlike the python scripting approach which needs to manage
its own cleanup.

>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self.patterns =3D [
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 ("0x5d", "0", "64k"),
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 ("0xd5", "1M", "64k"),
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 ("0xdc", "32M", "64k"),
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 ("0xdc", "67043328", "64k")]
>=20
> John spelled it:
> =C2=A0("0xcd", "0x3ff0000", "64k"]=C2=A0 # 64M - 64K
>=20
> The 0xdc vs. 0xcd doesn't matter all that much, but having distinct
> patterns in distinct ranges is kind of nice if we have to later inspect
> a file.
>=20

I felt like the hex aided clarity to show which cluster we were
targeting. I'm not very good at reading raw byte values.

>> +
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 for p in self.patterns:
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 qe=
mu_io('-f', iotests.imgfmt, '-c', 'write -P%s %s %s' % p,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 test_img)
>> +
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 qemu_img('create', '-f', '=
qcow2', target_img,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 str(TestImageFleecing.image_len))
>> +
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self.vm =3D iotests.VM().a=
dd_drive(test_img)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self.vm.launch()
>> +
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self.overwrite_patterns =3D=
 [
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 ("0xa0", "0", "64k"),
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 ("0x0a", "1M", "64k"),
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 ("0x55", "32M", "64k"),
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 ("0x56", "67043328", "64k")]
>> +
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self.nbd_uri =3D "nbd+unix=
:///drive1?socket=3D%s" % nbd_sock
>> +
>> +=C2=A0=C2=A0=C2=A0 def tearDown(self):
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self.vm.shutdown()
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 os.remove(test_img)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 os.remove(target_img)
>=20
> I'm not seeing anything that stops the NBD server; John's version added
> that at my insistence.
>=20
>> +
>> +=C2=A0=C2=A0=C2=A0 def verify_patterns(self):
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 for p in self.patterns:
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 se=
lf.assertEqual(
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -1,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 qemu_io(self.nbd_uri, '-r',=
 '-c', 'read -P%s %s
>> %s' % p)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .fi=
nd("verification failed"),
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "Failed to verify pattern: =
%s %s %s" % p)
>> +
>> +=C2=A0=C2=A0=C2=A0 def test_image_fleecing(self):
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 result =3D self.vm.qmp("bl=
ockdev-add", **{
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "d=
river": "fleecing-filter",
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "n=
ode-name": "drive1",
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "f=
ile": {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 "driver": "qcow2",
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 "file": {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "driver": "file",
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "filename": target_img,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 },
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 "backing": "drive0",
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 })
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self.assert_qmp(result, 'r=
eturn', {})
>> +
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 result =3D self.vm.qmp(
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 "nbd-server-start",
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 **{"addr": { "type": "unix", "data": { "path":
>> nbd_sock } } })
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self.assert_qmp(result, 'r=
eturn', {})
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 result =3D self.vm.qmp("bl=
ockdev-backup", device=3D"drive0",
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 target=3D"drive1", sync=3D"none")
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self.assert_qmp(result, 'r=
eturn', {})
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 result =3D self.vm.qmp("nb=
d-server-add", device=3D"drive1")
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self.assert_qmp(result, 'r=
eturn', {})
>> +
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self.verify_patterns()
>> +
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 for p in self.overwrite_pa=
tterns:
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 se=
lf.vm.hmp_qemu_io("drive0", "write -P%s %s %s" % p)
>> +
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self.verify_patterns()
>> +
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self.cancel_and_wait(resum=
e=3DTrue)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self.assert_no_active_bloc=
k_jobs()
>> +
>> +if __name__ =3D=3D '__main__':
>> +=C2=A0=C2=A0=C2=A0 iotests.main(supported_fmts=3D['raw', 'qcow2'])
>> diff --git a/tests/qemu-iotests/222.out b/tests/qemu-iotests/222.out
>> new file mode 100644
>> index 0000000000..ae1213e6f8
>> --- /dev/null
>> +++ b/tests/qemu-iotests/222.out
>> @@ -0,0 +1,5 @@
>> +.
>> +---------------------------------------------------------------------=
-
>> +Ran 1 tests
>> +
>=20
> I also much prefer the output style that resulted in John's version.
>=20

Yes, I think the "python script" style is superior because you can get
debug printfs from a test build of QEMU into the diff output instead of
having to edit the iotests infrastructure to stop deleting the logs so
you can read them.

>> +OK
>> diff --git a/tests/qemu-iotests/group b/tests/qemu-iotests/group
>> index eea75819d2..8019a9f721 100644
>> --- a/tests/qemu-iotests/group
>> +++ b/tests/qemu-iotests/group
>> @@ -220,3 +220,4 @@
>> =C2=A0 218 rw auto quick
>> =C2=A0 219 rw auto
>> =C2=A0 221 rw auto quick
>> +222 rw auto quick
>>
>=20
I would prefer to use "my" version as a base, but we can modify it to
use the fleecing filter if that winds up being requisite. Your patch 1/3
is better, though.
