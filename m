Received: from eggs.gnu.org ([209.51.188.92]:60315)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hM85C-0002jR-MO
	for qemu-devel@nongnu.org; Thu, 02 May 2019 05:32:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hM85A-0003Sn-LN
	for qemu-devel@nongnu.org; Thu, 02 May 2019 05:32:50 -0400
References: <20190326195837.8416-1-shmuel.eiderman@oracle.com>
	<891af075-0e1d-de0b-b874-738b0c8f34ae@redhat.com>
	<AC82FB5B-34EF-453F-B4CB-33F1BBF58623@oracle.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <af928e13-bde2-a9ae-de74-853d9bfc5e65@redhat.com>
Date: Thu, 2 May 2019 11:31:27 +0200
MIME-Version: 1.0
In-Reply-To: <AC82FB5B-34EF-453F-B4CB-33F1BBF58623@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH] vmdk: Set vmdk parent
 backing_format to vmdk
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Sam Eiderman <shmuel.eiderman@oracle.com>, Eric Blake <eblake@redhat.com>
Cc: fam@euphon.net, kwolf@redhat.com, qemu-block@nongnu.org, arbel.moshe@oracle.com, QEMU <qemu-devel@nongnu.org>, mreitz@redhat.com, liran.alon@oracle.com, yoav.elnekave@oracle.com

On 27/03/2019 10.28, Sam Eiderman wrote:
> Thanks,
>=20
> Also please notice that the mentioned commit in the commit message has =
it=E2=80=99s commit id changed to b69864e.
>=20
> Sam
>=20
>> On 27 Mar 2019, at 2:35, Eric Blake <eblake@redhat.com> wrote:
>>
>> On 3/26/19 2:58 PM, Sam Eiderman wrote:
>>> Commit fb2105b ("vmdk: Support version=3D3 in VMDK descriptor files")=
 fixed
>>> the probe function to correctly guess vmdk descriptors with version=3D=
3.
>>
>> All patches need to cc qemu-devel in addition to their maintainers (I'=
ve
>> added that now).
>>
>>>
>>> This solves the issue where vmdk snapshot with parent vmdk descriptor
>>> containing "version=3D3" would be treated as raw instead vmdk.
>>>
>>> In the future case where a new vmdk version is introduced, we will ag=
ain
>>> experience this issue, even if the user will provide "-f vmdk" it wil=
l
>>> only apply to the tip image and not to the underlying "misprobed" par=
ent
>>> image.
>>>
>>> The code in vmdk.c already assumes that the backing file of vmdk must=
 be
>>> vmdk (see vmdk_is_cid_valid which returns 0 if backing file is not
>>> vmdk).
>>>
>>> So let's make it official by supplying the backing_format as vmdk.
>>>
>>> Reviewed-by: Mark Kanda <mark.kanda@oracle.com>
>>> Reviewed-By: Liran Alon <liran.alon@oracle.com>
>>> Reviewed-by: Arbel Moshe <arbel.moshe@oracle.com>
>>> Signed-off-by: Shmuel Eiderman <shmuel.eiderman@oracle.com>
>>> ---
>>> block/vmdk.c | 2 ++
>>> 1 file changed, 2 insertions(+)
>>>
>>> diff --git a/block/vmdk.c b/block/vmdk.c
>>> index 8dec6ef767..de8cb859f8 100644
>>> --- a/block/vmdk.c
>>> +++ b/block/vmdk.c
>>> @@ -397,6 +397,8 @@ static int vmdk_parent_open(BlockDriverState *bs)
>>>         pstrcpy(bs->auto_backing_file, end_name - p_name + 1, p_name)=
;
>>>         pstrcpy(bs->backing_file, sizeof(bs->backing_file),
>>>                 bs->auto_backing_file);
>>> +        pstrcpy(bs->backing_format, sizeof(bs->backing_format),
>>> +                "vmdk");
>>>     }

 Hi,

this patch broke the vmdk qemu-iotests:

$ cd tests/qemu-iotests/ ; ./check -vmdk 110 126 ; cd ../..
[...]
110 0s ... - output mismatch (see 110.out.bad)
--- /home/thuth/devel/qemu/tests/qemu-iotests/110.out	2019-05-02
11:27:41.000000000 +0200
+++ /home/thuth/tmp/qemu-build/tests/qemu-iotests/110.out.bad	2019-05-02
11:27:54.000000000 +0200
@@ -8,6 +8,7 @@
 file format: IMGFMT
 virtual size: 64M (67108864 bytes)
 backing file: t.IMGFMT.base (actual path: TEST_DIR/t.IMGFMT.base)
+backing file format: IMGFMT

 =3D=3D=3D Non-reconstructable filename =3D=3D=3D

@@ -15,6 +16,7 @@
 file format: IMGFMT
 virtual size: 64M (67108864 bytes)
 backing file: t.IMGFMT.base (actual path: TEST_DIR/t.IMGFMT.base)
+backing file format: IMGFMT

 =3D=3D=3D Backing name is always relative to the backed image =3D=3D=3D

@@ -26,4 +28,5 @@
 file format: IMGFMT
 virtual size: 64M (67108864 bytes)
 backing file: t.IMGFMT.base (cannot determine actual path)
+backing file format: IMGFMT
 *** done
126 0s ... - output mismatch (see 126.out.bad)
--- /home/thuth/devel/qemu/tests/qemu-iotests/126.out	2019-05-02
11:27:41.000000000 +0200
+++ /home/thuth/tmp/qemu-build/tests/qemu-iotests/126.out.bad	2019-05-02
11:27:55.000000000 +0200
@@ -13,6 +13,7 @@
 file format: IMGFMT
 virtual size: 64M (67108864 bytes)
 backing file: ./image:base.IMGFMT (actual path:
TEST_DIR/./image:base.IMGFMT)
+backing file format: IMGFMT

 Formatting 'base.IMGFMT', fmt=3DIMGFMT size=3D67108864
 Formatting 'file:image:top.IMGFMT', fmt=3DIMGFMT size=3D67108864
backing_file=3Dbase.IMGFMT
@@ -20,4 +21,5 @@
 file format: IMGFMT
 virtual size: 64M (67108864 bytes)
 backing file: base.IMGFMT (actual path: ./base.IMGFMT)
+backing file format: IMGFMT
 *** done
Failures: 110 126
Failed 2 of 2 tests

Could you please send a patch to fix this?

 Thanks,
  Thomas
