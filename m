Received: from eggs.gnu.org ([2001:4830:134:3::10]:49794)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gRGFk-00085c-V5
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 07:44:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gRGFj-0008AR-HS
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 07:44:40 -0500
References: <20181126112828.23047-1-kwolf@redhat.com>
	<20181126112828.23047-2-kwolf@redhat.com>
	<7b3288b3-f7f8-b6cf-d4b1-b0540205e3df@redhat.com>
	<20181126123359.GC6612@localhost.localdomain>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <1ebf8831-fd8a-28ab-9ea9-4664ce93949a@redhat.com>
Date: Mon, 26 Nov 2018 13:44:32 +0100
MIME-Version: 1.0
In-Reply-To: <20181126123359.GC6612@localhost.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="JoJo5fBu3zSMaMhqL1R7yj27rqtsTpkCW"
Subject: Re: [Qemu-devel] [PATCH for-3.1 1/2] block: Don't inactivate
 children before parents
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
--JoJo5fBu3zSMaMhqL1R7yj27rqtsTpkCW
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org
Message-ID: <1ebf8831-fd8a-28ab-9ea9-4664ce93949a@redhat.com>
Subject: Re: [PATCH for-3.1 1/2] block: Don't inactivate children before
 parents
References: <20181126112828.23047-1-kwolf@redhat.com>
 <20181126112828.23047-2-kwolf@redhat.com>
 <7b3288b3-f7f8-b6cf-d4b1-b0540205e3df@redhat.com>
 <20181126123359.GC6612@localhost.localdomain>
In-Reply-To: <20181126123359.GC6612@localhost.localdomain>
Content-Type: multipart/mixed;
 boundary="------------A960B8FC29B45F93628E7FC0"

--------------A960B8FC29B45F93628E7FC0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 26.11.18 13:33, Kevin Wolf wrote:
> Am 26.11.2018 um 13:05 hat Max Reitz geschrieben:
>> On 26.11.18 12:28, Kevin Wolf wrote:
>>> bdrv_child_cb_inactivate() asserts that parents are already inactive
>>> when children get inactivated. This precondition is necessary because=

>>> parents could still issue requests in their inactivation code.
>>>
>>> When block nodes are created individually with -blockdev, all of them=

>>> are monitor owned and will be returned by bdrv_next() in an undefined=

>>> order (in practice, in the order of their creation, which is usually
>>> children before parents), which obviously fails the assertion.
>>>
>>> This patch fixes the ordering by skipping nodes with still active
>>> parents in bdrv_inactivate_recurse() because we know that they will b=
e
>>> covered by recursion when the last active parent becomes inactive.
>>>
>>> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
>>> ---
>>>  block.c | 22 ++++++++++++++++++++++
>>>  1 file changed, 22 insertions(+)
>>>
>>> diff --git a/block.c b/block.c
>>> index 5ba3435f8f..0569275e31 100644
>>> --- a/block.c
>>> +++ b/block.c
>>> @@ -4612,6 +4612,22 @@ void bdrv_invalidate_cache_all(Error **errp)
>>>      }
>>>  }
>>> =20
>>> +static bool bdrv_has_active_bds_parent(BlockDriverState *bs)
>>> +{
>>> +    BdrvChild *parent;
>>> +
>>> +    QLIST_FOREACH(parent, &bs->parents, next_parent) {
>>> +        if (parent->role->parent_is_bds) {
>>> +            BlockDriverState *parent_bs =3D parent->opaque;
>>> +            if (!(parent_bs->open_flags & BDRV_O_INACTIVE)) {
>>> +                return true;
>>> +            }
>>> +        }
>>> +    }
>>
>> Now I see why you say this might make sense as a permission.
>=20
> You do? To be honest, now that I found this solution, I don't think a
> permission makes much sense any more, because you would have the same
> loop, and you would only be checking a different flag in the end.
>=20
>>> +
>>> +    return false;
>>> +}
>>> +
>>>  static int bdrv_inactivate_recurse(BlockDriverState *bs,
>>>                                     bool setting_flag)
>>>  {
>>> @@ -4622,6 +4638,12 @@ static int bdrv_inactivate_recurse(BlockDriver=
State *bs,
>>>          return -ENOMEDIUM;
>>>      }
>>> =20
>>> +    /* Make sure that we don't inactivate a child before its parent.=

>>> +     * It will be covered by recursion from the yet active parent. *=
/
>>> +    if (bdrv_has_active_bds_parent(bs)) {
>>> +        return 0;
>>> +    }
>>> +
>>
>> Hm.  Wouldn't it make more sense to always return early when there are=

>> any BDS parents?  Because if there are any BDS parents and none of the=
m
>> are active (anymore), then this child will have been inactivated
>> already, and we can save ourselves the trouble of going through the re=
st
>> of the function again.
>=20
> I don't quite follow... If we always return early no matter whether
> there is an active parent, who will have inactivated the child?
>=20
> After trying to write up why you're wrong, I think there are two cases
> and both of us have a point:
>=20
> 1. bdrv_next() enumerates the child node first and then the last BDS
>    parent. This is what this patch fixes.
>=20
>    It will inactivate the child exactly once, at the time that the last=

>    parent has become inactive (and recursively calls this function for
>    each of its children). If you remove that one inactivation, too,
>    children won't be inactivated at all.
>=20
> 2. bdrv_next() enumerates the last BDS parent first and then the child.=

>    This is unlikely and might even be impossible today, but once we
>    expose bdrv_reopen() in QMP and let the user reconfigure the edges,
>    it probably becomes possible.

blockdev-snapshot exists today.

>    In this case, even after my patch we inactivate drivers twice. Maybe=

>    we should just return early if BDRV_O_INACTIVE is already set. What
>    makes me kind of unsure is that we already test for this flag, but
>    only for part of the function.
>=20
>    Any ideas how to test this? Can we create such a situation today?

As I wrote in my second mail just now, I think bdrv_inactivate_all()
needs to check this.

See attached diff to 234, but I don't know whether we can really test
this, as there is no failure when .bdrv_inactivate() is called multiple
times.  (What I've done is add debugging code to see that it is called
multiple times).

Max

>> Do drivers support multiple calls to .bdrv_in_activate() at all?
>=20
> They were probably not designed for that... Not sure if there was ever =
a
> commit where we used to call them multiple times without failing the
> assertion first.
>=20
> Kevin
>=20


--------------A960B8FC29B45F93628E7FC0
Content-Type: text/plain; charset=UTF-8;
 name="diff"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="diff"

diff --git a/tests/qemu-iotests/234 b/tests/qemu-iotests/234
index 1f695d337a..b119b4cc4d 100755
--- a/tests/qemu-iotests/234
+++ b/tests/qemu-iotests/234
@@ -27,11 +27,13 @@ iotests.verify_image_format(supported_fmts=3D['raw', =
'qcow2'])
 iotests.verify_platform(['linux'])
=20
 with iotests.FilePath('img') as img_path, \
+     iotests.FilePath('backing') as backing_path, \
      iotests.FilePath('mig_fifo_a') as fifo_a, \
      iotests.FilePath('mig_fifo_b') as fifo_b, \
      iotests.VM(path_suffix=3D'a') as vm_a, \
      iotests.VM(path_suffix=3D'b') as vm_b:
=20
+    iotests.qemu_img_pipe('create', '-f', iotests.imgfmt, backing_path, =
'64M')
     iotests.qemu_img_pipe('create', '-f', iotests.imgfmt, img_path, '64M=
')
=20
     os.mkfifo(fifo_a)
@@ -40,14 +42,20 @@ with iotests.FilePath('img') as img_path, \
     iotests.log('Launching source VM...')
     (vm_a.add_blockdev('file,filename=3D%s,node-name=3Ddrive0-file' % (i=
mg_path))
          .add_blockdev('%s,file=3Ddrive0-file,node-name=3Ddrive0' % (iot=
ests.imgfmt))
+         .add_blockdev('file,filename=3D%s,node-name=3Ddrive0-backing-fi=
le' % (backing_path))
+         .add_blockdev('%s,file=3Ddrive0-backing-file,node-name=3Ddrive0=
-backing' % (iotests.imgfmt))
          .launch())
=20
     iotests.log('Launching destination VM...')
     (vm_b.add_blockdev('file,filename=3D%s,node-name=3Ddrive0-file' % (i=
mg_path))
          .add_blockdev('%s,file=3Ddrive0-file,node-name=3Ddrive0' % (iot=
ests.imgfmt))
+         .add_blockdev('file,filename=3D%s,node-name=3Ddrive0-backing-fi=
le' % (backing_path))
+         .add_blockdev('%s,file=3Ddrive0-backing-file,node-name=3Ddrive0=
-backing' % (iotests.imgfmt))
          .add_incoming("exec: cat '%s'" % (fifo_a))
          .launch())
=20
+    vm_a.qmp('blockdev-snapshot', node=3D'drive0-backing', overlay=3D'dr=
ive0')
+
     iotests.log('Enabling migration QMP events on A...')
     iotests.log(vm_a.qmp('migrate-set-capabilities', capabilities=3D[
         {

--------------A960B8FC29B45F93628E7FC0--

--JoJo5fBu3zSMaMhqL1R7yj27rqtsTpkCW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlv76rAACgkQ9AfbAGHV
z0CpCwf/RdlAUgCGCTAw0xuDc0nHcMYFTGMnVdESjiq1XEjK5DdLsXfRDP4RDWix
pEpQ4O6eiF/20fLZH3v96WSGDkbwUoDX6bc8BH/QojspMFQ4F+xv4DeWKV+lmZtz
w9ofHgTJV6lJNkFSwxwnmtVKHRmH0lqUNvpGAL95RO55uCBDFpvrKXv6EQy3ph/b
0EQS5WCutA6iDslVgevrmgUgBW9kOZbQLqWrav1H0jAZWZtIn7aFwNXL4oiVTfYg
xtd+PzjeY9uEuYIJK3wTs7rWlNbyHUOQj2k0gnF2F59M7qiTr7xbxxWhlrruB3gz
MkhKRCw7+MANl5M2LTw6kgQohGLSZw==
=MiU2
-----END PGP SIGNATURE-----

--JoJo5fBu3zSMaMhqL1R7yj27rqtsTpkCW--
