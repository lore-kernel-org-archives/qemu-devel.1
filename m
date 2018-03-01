Received: from eggs.gnu.org ([2001:4830:134:3::10]:41546)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1erMkt-0007qa-Dr
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 06:52:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1erMks-0007lV-AX
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 06:52:11 -0500
References: <1518702707-7077-1-git-send-email-vsementsov@virtuozzo.com>
	<1518702707-7077-10-git-send-email-vsementsov@virtuozzo.com>
	<8e580b8b-1614-9c83-4ac9-48f5d3cff3dc@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <b17a3d26-5f55-da0a-f083-159ebdf749b7@virtuozzo.com>
Date: Thu, 1 Mar 2018 14:51:41 +0300
MIME-Version: 1.0
In-Reply-To: <8e580b8b-1614-9c83-4ac9-48f5d3cff3dc@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH 9/9] iotests: new test 206 for NBD
 BLOCK_STATUS
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: mreitz@redhat.com, kwolf@redhat.com, pbonzini@redhat.com, den@openvz.org

17.02.2018 00:02, Eric Blake wrote:
> On 02/15/2018 07:51 AM, Vladimir Sementsov-Ogievskiy wrote:
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>> ---
>> =C2=A0 tests/qemu-iotests/206=C2=A0=C2=A0=C2=A0=C2=A0 | 34 +++++++++++++=
+++++++++++++++++++++
>> =C2=A0 tests/qemu-iotests/206.out |=C2=A0 2 ++
>> =C2=A0 tests/qemu-iotests/group=C2=A0=C2=A0 |=C2=A0 1 +
>> =C2=A0 3 files changed, 37 insertions(+)
>> =C2=A0 create mode 100644 tests/qemu-iotests/206
>> =C2=A0 create mode 100644 tests/qemu-iotests/206.out
>
> It's a race! Kevin already has test 206 and 207 claimed in his pending=20
> series:
> https://lists.gnu.org/archive/html/qemu-devel/2018-02/msg02363.html
> Whoever loses gets to rebase and renumber (or the maintainer on their=20
> behalf) ;)


is there any simple method to get a number for new test? Any way to=20
avoid such situations?

>
>>
>> diff --git a/tests/qemu-iotests/206 b/tests/qemu-iotests/206
>> new file mode 100644
>
> Oops, you forgot to mark this executable.=C2=A0 And oops, I forgot to fla=
g=20
> that on test 205.=C2=A0 Other inconsistent tests: 096, 124, 129, 132, 136=
,=20
> 139, 148, 152, 163. Separate cleanup patch coming up soon.
>
>> index 0000000000..259e991ec6
>> --- /dev/null
>> +++ b/tests/qemu-iotests/206
>> @@ -0,0 +1,34 @@
>> +#!/usr/bin/env python
>> +#
>> +# Tests for NBD BLOCK_STATUS extension
>> +#
>
>> +import iotests
>> +from iotests import qemu_img_create, qemu_io, qemu_img_verbose,=20
>> qemu_nbd, \
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 file_path
>> +
>> +iotests.verify_image_format(supported_fmts=3D['qcow2'])
>
> Don't we also need to blacklist v2 files (and only operate on v3 or=20
> newer), since the behavior of zero clusters is much worse on v2 images?

hm. I think if test passed, all is ok. qemu-img creates good enough=20
image to pass the test..

>
>> +
>> +disk, nbd_sock =3D file_path('disk', 'nbd-sock')
>> +nbd_uri =3D 'nbd+unix:///exp?socket=3D' + nbd_sock
>> +
>> +qemu_img_create('-f', iotests.imgfmt, disk, '1M')
>> +qemu_io('-f', iotests.imgfmt, '-c', 'write 0 512K', disk)
>
> Hopefully large enough for all the major filesystems with sparse=20
> support to show half-data, half-hole, and not run into any weird=20
> issues where granularity differences between filesystems change the=20
> outcome.
>
>> +
>> +qemu_nbd('-k', nbd_sock, '-x', 'exp', '-f', iotests.imgfmt, disk)
>> +qemu_img_verbose('map', '-f', 'raw', '--output=3Djson', nbd_uri)
>> diff --git a/tests/qemu-iotests/206.out b/tests/qemu-iotests/206.out
>> new file mode 100644
>> index 0000000000..0d29724e84
>> --- /dev/null
>> +++ b/tests/qemu-iotests/206.out
>> @@ -0,0 +1,2 @@
>> +[{ "start": 0, "length": 524288, "depth": 0, "zero": false, "data":=20
>> true},
>> +{ "start": 524288, "length": 524288, "depth": 0, "zero": true,=20
>> "data": false}]
>
> But definite evidence of getting block status over NBD! Progress!
>
> And kudos for producing an .out file that I can actually read and=20
> reproduce without the aid of python (in contrast to the more=20
> "unit-test"-y ones like 205, where we had a big long side-discussion=20
> about that. No need to repeat it here).
>
>> diff --git a/tests/qemu-iotests/group b/tests/qemu-iotests/group
>> index a2dfe79d86..2c3925566a 100644
>> --- a/tests/qemu-iotests/group
>> +++ b/tests/qemu-iotests/group
>> @@ -202,3 +202,4 @@
>> =C2=A0 203 rw auto
>> =C2=A0 204 rw auto quick
>> =C2=A0 205 rw auto quick
>> +206 rw auto quick
>>
>


--=20
Best regards,
Vladimir
