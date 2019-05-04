Received: from eggs.gnu.org ([209.51.188.92]:59315)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <shmuel.eiderman@oracle.com>) id 1hMu1F-0001HW-6p
	for qemu-devel@nongnu.org; Sat, 04 May 2019 08:43:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <shmuel.eiderman@oracle.com>) id 1hMu1D-0007iv-HZ
	for qemu-devel@nongnu.org; Sat, 04 May 2019 08:43:57 -0400
From: Sam <shmuel.eiderman@oracle.com>
Message-Id: <75AB1BD6-546D-4103-8A44-BEEC2FD3FF63@oracle.com>
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.8\))
Date: Sat, 4 May 2019 15:43:25 +0300
In-Reply-To: <a44ffb98-4cc2-47b9-2c9e-eeeda445a0a0@redhat.com>
References: <af928e13-bde2-a9ae-de74-853d9bfc5e65@redhat.com>
	<20190502130822.46858-1-shmuel.eiderman@oracle.com>
	<20190502130822.46858-2-shmuel.eiderman@oracle.com>
	<8d201096-ab9d-82e0-93cb-74bd23d93dbe@redhat.com>
	<a44ffb98-4cc2-47b9-2c9e-eeeda445a0a0@redhat.com>
Content-Type: text/plain;
	charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2] vmdk: Set vmdk parent backing_format to
 vmdk
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, Thomas Huth <thuth@redhat.com>
Cc: kwolf@redhat.com, qemu-block@nongnu.org, qemu-devel@nongnu.org, fam@euphon.net, Eric Blake <eblake@redhat.com>, Arbel Moshe <arbel.moshe@oracle.com>

Thanks Thomas, Thanks Max

So how do you want to proceed?

Apply Max=E2=80=99s RFC from here =
(http://lists.nongnu.org/archive/html/qemu-block/2019-04/msg00442.html =
<http://lists.nongnu.org/archive/html/qemu-block/2019-04/msg00442.html>) =
and add the commit id which is stable now?
Or should I resubmit my fix (which is very similar to what Max did) =
without the original change?

Sam

> On 3 May 2019, at 17:32, Max Reitz <mreitz@redhat.com> wrote:
>=20
> On 03.05.19 13:34, Thomas Huth wrote:
>> Hi Sam,
>>=20
>> On 02/05/2019 15.08, Sam Eiderman wrote:
>>> Commit b69864e ("vmdk: Support version=3D3 in VMDK descriptor =
files")
>>> fixed the probe function to correctly guess vmdk descriptors with
>>> version=3D3.
>>>=20
>>> This solves the issue where vmdk snapshot with parent vmdk =
descriptor
>>> containing "version=3D3" would be treated as raw instead vmdk.
>>>=20
>>> In the future case where a new vmdk version is introduced, we will =
again
>>> experience this issue, even if the user will provide "-f vmdk" it =
will
>>> only apply to the tip image and not to the underlying "misprobed" =
parent
>>> image.
>>>=20
>>> The code in vmdk.c already assumes that the backing file of vmdk =
must be
>>> vmdk (see vmdk_is_cid_valid which returns 0 if backing file is not
>>> vmdk).
>>>=20
>>> So let's make it official by supplying the backing_format as vmdk.
>>>=20
>>> Reviewed-by: Mark Kanda <mark.kanda@oracle.com>
>>> Reviewed-By: Liran Alon <liran.alon@oracle.com>
>>> Reviewed-by: Arbel Moshe <arbel.moshe@oracle.com>
>>> Signed-off-by: Shmuel Eiderman <shmuel.eiderman@oracle.com>
>>> ---
>>> block/vmdk.c           | 2 ++
>>> tests/qemu-iotests/110 | 6 +++---
>>> tests/qemu-iotests/126 | 4 ++--
>>> 3 files changed, 7 insertions(+), 5 deletions(-)
>>>=20
>>> diff --git a/block/vmdk.c b/block/vmdk.c
>>> index 8dec6ef767..de8cb859f8 100644
>>> --- a/block/vmdk.c
>>> +++ b/block/vmdk.c
>>> @@ -397,6 +397,8 @@ static int vmdk_parent_open(BlockDriverState =
*bs)
>>>         pstrcpy(bs->auto_backing_file, end_name - p_name + 1, =
p_name);
>>>         pstrcpy(bs->backing_file, sizeof(bs->backing_file),
>>>                 bs->auto_backing_file);
>>> +        pstrcpy(bs->backing_format, sizeof(bs->backing_format),
>>> +                "vmdk");
>>>     }
>>=20
>> Your patch with this change has already been merged into the QEMU =
master
>> branch...
>>=20
>>> diff --git a/tests/qemu-iotests/110 b/tests/qemu-iotests/110
>>> index fad672c1ae..982569dbc5 100755
>>> --- a/tests/qemu-iotests/110
>>> +++ b/tests/qemu-iotests/110
>>> @@ -54,7 +54,7 @@ _make_test_img -b "$TEST_IMG_REL.base" 64M
>>> # qemu should be able to reconstruct the filename, so relative =
backing names
>>> # should work
>>> =
TEST_IMG=3D"json:{'driver':'$IMGFMT','file':{'driver':'file','filename':'$=
TEST_IMG'}}" \
>>> -    _img_info | _filter_img_info
>>> +    _img_info | _filter_img_info | grep -v "backing file format"
>>>=20
>>> echo
>>> echo '=3D=3D=3D Non-reconstructable filename =3D=3D=3D'
>>> @@ -78,7 +78,7 @@ TEST_IMG=3D"json:{
>>>             }
>>>         ]
>>>     }
>>> -}" _img_info | _filter_img_info
>>> +}" _img_info | _filter_img_info | grep -v "backing file format"
>>>=20
>>> echo
>>> echo '=3D=3D=3D Backing name is always relative to the backed image =
=3D=3D=3D'
>>> @@ -110,7 +110,7 @@ TEST_IMG=3D"json:{
>>>             }
>>>         ]
>>>     }
>>> -}" _img_info | _filter_img_info
>>> +}" _img_info | _filter_img_info | grep -v "backing file format"
>>>=20
>>>=20
>>> # success, all done
>>> diff --git a/tests/qemu-iotests/126 b/tests/qemu-iotests/126
>>> index 96dc048d59..1f7618c8a5 100755
>>> --- a/tests/qemu-iotests/126
>>> +++ b/tests/qemu-iotests/126
>>> @@ -63,7 +63,7 @@ TEST_IMG=3D$BASE_IMG _make_test_img 64M
>>> TEST_IMG=3D$TOP_IMG _make_test_img -b ./image:base.$IMGFMT
>>>=20
>>> # The default cluster size depends on the image format
>>> -TEST_IMG=3D$TOP_IMG _img_info | grep -v 'cluster_size'
>>> +TEST_IMG=3D$TOP_IMG _img_info | grep -v 'cluster_size\|backing file =
format'
>>>=20
>>> _rm_test_img "$BASE_IMG"
>>> _rm_test_img "$TOP_IMG"
>>> @@ -79,7 +79,7 @@ TOP_IMG=3D"file:image:top.$IMGFMT"
>>> TEST_IMG=3D$BASE_IMG _make_test_img 64M
>>> TEST_IMG=3D$TOP_IMG _make_test_img -b "$BASE_IMG"
>>>=20
>>> -TEST_IMG=3D$TOP_IMG _img_info | grep -v 'cluster_size'
>>> +TEST_IMG=3D$TOP_IMG _img_info | grep -v 'cluster_size\|backing file =
format'
>>>=20
>>> _rm_test_img "$BASE_IMG"
>>> _rm_test_img "image:top.$IMGFMT"
>>>=20
>>=20
>> ... so please just send a patch with these fixes!
>=20
> I already did, it's here:
>=20
> http://lists.nongnu.org/archive/html/qemu-block/2019-04/msg00442.html =
<http://lists.nongnu.org/archive/html/qemu-block/2019-04/msg00442.html>
>=20
> Max
