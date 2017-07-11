Received: from eggs.gnu.org ([2001:4830:134:3::10]:44876)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <el13635@mail.ntua.gr>) id 1dV0Fl-0002qQ-Pr
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 14:51:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <el13635@mail.ntua.gr>) id 1dV0Fk-0008L9-Od
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 14:51:21 -0400
Date: Tue, 11 Jul 2017 21:50:35 +0300
From: Manos Pitsidianakis <el13635@mail.ntua.gr>
Message-ID: <20170711185035.peu4mbxiab5axwvz@postretch>
References: <20170701153906.16588-1-el13635@mail.ntua.gr>
	<20170711151617.GK4335@noname.str.redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="lu33rwp3yylkcj4c"
Content-Disposition: inline
In-Reply-To: <20170711151617.GK4335@noname.str.redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2] block: fix leaks in bdrv_open_driver()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, qemu-block <qemu-block@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>, Alberto Garcia <berto@igalia.com>, Max Reitz <mreitz@redhat.com>


--lu33rwp3yylkcj4c
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 11, 2017 at 05:16:17PM +0200, Kevin Wolf wrote:
>Am 01.07.2017 um 17:39 hat Manos Pitsidianakis geschrieben:
>> bdrv_open_driver() is called in two places, bdrv_new_open_driver() and
>> bdrv_open_common(). In the latter, failure cleanup in is in its caller,
>> bdrv_open_inherit(), which unrefs the bs->file of the failed driver open=
 if it
>> exists.
>>
>> Let's move the bs->file cleanup to bdrv_open_driver() to take care of all
>> callers and do not set bs->drv to NULL unless the driver's open function
>> failed. When bs is destroyed by removing its last reference, bdrv_close()
>> checks bs->drv to perform the needed cleanups and also call the driver's=
 close
>> function.
>>
>> Signed-off-by: Manos Pitsidianakis <el13635@mail.ntua.gr>
>> ---
>>
>> v2:
>>  move bdrv_unref_child(bs, bs->file) to bdrv_open_driver
>>  do not set bs->drv to NULL if open succeeds
>>
>>  block.c | 21 +++++++++++++--------
>>  1 file changed, 13 insertions(+), 8 deletions(-)
>>
>> diff --git a/block.c b/block.c
>> index 694396281b..df2a46990c 100644
>> --- a/block.c
>> +++ b/block.c
>> @@ -1091,6 +1091,7 @@ static int bdrv_open_driver(BlockDriverState *bs, =
BlockDriver *drv,
>>  {
>>      Error *local_err =3D NULL;
>>      int ret;
>> +    bool open_failed;
>>
>>      bdrv_assign_node_name(bs, node_name, &local_err);
>>      if (local_err) {
>> @@ -1111,7 +1112,9 @@ static int bdrv_open_driver(BlockDriverState *bs, =
BlockDriver *drv,
>>          ret =3D 0;
>>      }
>>
>> -    if (ret < 0) {
>> +    open_failed =3D ret < 0;
>> +
>> +    if (open_failed) {
>>          if (local_err) {
>>              error_propagate(errp, local_err);
>>          } else if (bs->filename[0]) {
>> @@ -1142,10 +1145,15 @@ static int bdrv_open_driver(BlockDriverState *bs=
, BlockDriver *drv,
>>      return 0;
>>
>>  free_and_fail:
>> -    /* FIXME Close bs first if already opened*/
>> -    g_free(bs->opaque);
>> -    bs->opaque =3D NULL;
>> -    bs->drv =3D NULL;
>> +    if (open_failed) {
>> +        g_free(bs->opaque);
>> +        bs->opaque =3D NULL;
>> +        bs->drv =3D NULL;
>> +    }
>> +    if (bs->file !=3D NULL) {
>> +        bdrv_unref_child(bs, bs->file);
>> +        bs->file =3D NULL;
>> +    }
>
>Is this bdrv_unref_child() safe if we leave bs->drv set? Format drivers
>expect that if an image is opened, it also has a valid bs->file.
>
>For example, if I add ret =3D -1 after refresh_total_sectors() (because I
>couldn't find an easier way to make it fail intentionally), I get an
>ugly heap corruption crash instead of a nice error message with this
>patch.
>
This is triggered by bdrv_open_inherit doing=20
QDECREF(bs->explicit_options) and leaving the dangling pointer. Not=20
setting bs->drv means bdrv_close was called and tried to decref it=20
again, causing the heap error. Setting bs->explicit_options =3D NULL;
right below that fixes the heap corruption for me.

I can send a seperate fix for this. I also saw that there's no reason to=20
use a boolean, a label would do just fine so I can change that and=20
finalize the patch in the next version if everything is okay with it.

--lu33rwp3yylkcj4c
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEvy2VxhCrsoeMN1aIc2J8L2kN9xAFAlllHfsACgkQc2J8L2kN
9xDEjRAAkO9fsXblcsmQxwcuoHhaUrNBC+ee4RWf5ZZazFGVgSPCKwe4oUUunkfG
9eNUXOvouddHnFdbvBPjCKIgMh9RV3FslxuBfDbJU572M04/tTXCtzR+/9P/l09Q
zzdYAkrFAsqihreh6CcW2G0LBfnBuCsYpk8sRxQf8glNcJucGlmwIevjrr4shb6v
8ULRX789zOb9AKpo3MeNL0GzV+9jNbKoH6CE0D3rWhJY4pAHGYZES0gnU0gr1Jnq
lDi8gK3qIbYZWdEBXnRd+OT8om2uufI2CXtT4nS+LsSgVtrCfe60Do/shOtEuQSZ
p02BFGvV1Rk2ovfiy+DyjByjPzN0ZO6DIrkljn7OvJJwy582pW1AjTfFTzgxFbKI
GwbfP3CfzLEtqif+ImYk/25e91J/a2CwLdgjwKiAweLVmWUguA0hB0qcCP3Z2v57
T5h8X0Ue5KrKynGyZ+hk0OFezt7MPzw8l7LFSWUFZYzMPpX2JgJTBRTXC/T5mO+k
C8G2xnT/lQDj4xs0sZxHWGkrJ4Ar17lT6zf/4bbHVH3yNEf06WDz68MdH+EjhYlX
sdxGiaRxGCd0M9W2kGZ+Udg2PVAQYCyK0bdoepD4go0WMvZqnG5iFsSQ3G4+BrGf
jYMuAHSHEgO6V8xnEBQ5D5ECRjKhOhqfoQdJsUGGLW22sSt0BmE=
=1e5K
-----END PGP SIGNATURE-----

--lu33rwp3yylkcj4c--
