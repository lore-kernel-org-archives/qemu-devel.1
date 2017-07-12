Received: from eggs.gnu.org ([2001:4830:134:3::10]:57703)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <el13635@mail.ntua.gr>) id 1dVDBx-0005tn-Un
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 04:40:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <el13635@mail.ntua.gr>) id 1dVDBw-00040H-Ss
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 04:40:17 -0400
Date: Wed, 12 Jul 2017 11:39:30 +0300
From: Manos Pitsidianakis <el13635@mail.ntua.gr>
Message-ID: <20170712083930.tkit2nqxsras4trw@postretch>
References: <20170701153906.16588-1-el13635@mail.ntua.gr>
	<20170711151617.GK4335@noname.str.redhat.com>
	<20170711185035.peu4mbxiab5axwvz@postretch>
	<20170712083337.GC4917@noname.str.redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="i5ax5nu5qls32tmv"
Content-Disposition: inline
In-Reply-To: <20170712083337.GC4917@noname.str.redhat.com>
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


--i5ax5nu5qls32tmv
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 12, 2017 at 10:33:37AM +0200, Kevin Wolf wrote:
>Am 11.07.2017 um 20:50 hat Manos Pitsidianakis geschrieben:
>> On Tue, Jul 11, 2017 at 05:16:17PM +0200, Kevin Wolf wrote:
>> >Am 01.07.2017 um 17:39 hat Manos Pitsidianakis geschrieben:
>> >>bdrv_open_driver() is called in two places, bdrv_new_open_driver() and
>> >>bdrv_open_common(). In the latter, failure cleanup in is in its caller,
>> >>bdrv_open_inherit(), which unrefs the bs->file of the failed driver op=
en if it
>> >>exists.
>> >>
>> >>Let's move the bs->file cleanup to bdrv_open_driver() to take care of =
all
>> >>callers and do not set bs->drv to NULL unless the driver's open functi=
on
>> >>failed. When bs is destroyed by removing its last reference, bdrv_clos=
e()
>> >>checks bs->drv to perform the needed cleanups and also call the driver=
's close
>> >>function.
>> >>
>> >>Signed-off-by: Manos Pitsidianakis <el13635@mail.ntua.gr>
>> >>---
>> >>
>> >>v2:
>> >> move bdrv_unref_child(bs, bs->file) to bdrv_open_driver
>> >> do not set bs->drv to NULL if open succeeds
>> >>
>> >> block.c | 21 +++++++++++++--------
>> >> 1 file changed, 13 insertions(+), 8 deletions(-)
>> >>
>> >>diff --git a/block.c b/block.c
>> >>index 694396281b..df2a46990c 100644
>> >>--- a/block.c
>> >>+++ b/block.c
>> >>@@ -1091,6 +1091,7 @@ static int bdrv_open_driver(BlockDriverState *bs=
, BlockDriver *drv,
>> >> {
>> >>     Error *local_err =3D NULL;
>> >>     int ret;
>> >>+    bool open_failed;
>> >>
>> >>     bdrv_assign_node_name(bs, node_name, &local_err);
>> >>     if (local_err) {
>> >>@@ -1111,7 +1112,9 @@ static int bdrv_open_driver(BlockDriverState *bs=
, BlockDriver *drv,
>> >>         ret =3D 0;
>> >>     }
>> >>
>> >>-    if (ret < 0) {
>> >>+    open_failed =3D ret < 0;
>> >>+
>> >>+    if (open_failed) {
>> >>         if (local_err) {
>> >>             error_propagate(errp, local_err);
>> >>         } else if (bs->filename[0]) {
>> >>@@ -1142,10 +1145,15 @@ static int bdrv_open_driver(BlockDriverState *=
bs, BlockDriver *drv,
>> >>     return 0;
>> >>
>> >> free_and_fail:
>> >>-    /* FIXME Close bs first if already opened*/
>> >>-    g_free(bs->opaque);
>> >>-    bs->opaque =3D NULL;
>> >>-    bs->drv =3D NULL;
>> >>+    if (open_failed) {
>> >>+        g_free(bs->opaque);
>> >>+        bs->opaque =3D NULL;
>> >>+        bs->drv =3D NULL;
>> >>+    }
>> >>+    if (bs->file !=3D NULL) {
>> >>+        bdrv_unref_child(bs, bs->file);
>> >>+        bs->file =3D NULL;
>> >>+    }
>> >
>> >Is this bdrv_unref_child() safe if we leave bs->drv set? Format drivers
>> >expect that if an image is opened, it also has a valid bs->file.
>> >
>> >For example, if I add ret =3D -1 after refresh_total_sectors() (because=
 I
>> >couldn't find an easier way to make it fail intentionally), I get an
>> >ugly heap corruption crash instead of a nice error message with this
>> >patch.
>> >
>> This is triggered by bdrv_open_inherit doing
>> QDECREF(bs->explicit_options) and leaving the dangling pointer. Not
>> setting bs->drv means bdrv_close was called and tried to decref it
>> again, causing the heap error. Setting bs->explicit_options =3D NULL;
>> right below that fixes the heap corruption for me.
>
>Wouldn't it be better to call drv->bdrv_close() instead and then set
>bs->drv/opaque =3D NULL like for the other error path?

That was my first approach but I thought it wouldn't look nice since=20
bdrv_close is called anyway on delete. I will do it in the next version.
>
>> I can send a seperate fix for this.
>
>No, this doesn't fail before this patch, so it's a regression and we
>can't merge the patch without a fix. You need to respin this one.
Yes, I meant to first fix this and then apply this patch. It's a=20
dangling pointer anyway.
>
>> I also saw that there's no reason to use a boolean, a label would do
>> just fine so I can change that and finalize the patch in the next
>> version if everything is okay with it.
>
>Yes, that sounds better.
>
>Kevin



--i5ax5nu5qls32tmv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEvy2VxhCrsoeMN1aIc2J8L2kN9xAFAlll4EIACgkQc2J8L2kN
9xBmcg/+JcfEb3ZZGGgE9sq93hLBPVL7DX0f9MIrQrZP6UMyO550dq/3fP8a6t+a
0iM8GLw9mzTFre2crABE25MsdK588vDEDHYYaIUIL8XEHgdYT0lEcEsEvjc3vkom
6jK1xgwo91PF50xSTu+xSjMNmEDFcKV8pTT3jRVgHPvGaiuu2D9TbWmFnf1xfI0n
QbIcfkNCEjkwLz1JwBDfcVza8ZAoEIRfZDQnRgKS/0dyrFlDpn5poFtK02PqkyNF
ljtPs89ugTX0g4BPPDI/dTjUrMu2Bu1B5I0EGy7GfAqcaY/33mqdXr5y1vx4rRT4
fokun3Sws/DmiYDLcSORGd1vnzswPLv8M/nzJU7d/JwEtEjhAX08r1HPbRLZ9Gp+
InI2fGWMRTB4abXgdlFtajbGVqSAZsWO1zdJr9fhd8ykw2jrGzQOxsg1jQDTHNkA
11yWb5z75FBoZFfuEamfefMzZyDIPDpXBn1U10lRuZIKOgi1AZGiUjQrW6yDGz3m
441JaTFGgI+MzLcez5oUNWY8yywdS5PwseSw7FE+QDtj7IumYgO8gfounnuNR8hk
loyTLLThbk603Spsntlk8XZx9vtKPiS28lqPBbciVbyMKF/m8H4qBQpMVKkIgqNC
ChRndzOY4rAw42gqxvOG70WJ43JJtDlPIT1aARWST3CVIn+J9A8=
=1Dps
-----END PGP SIGNATURE-----

--i5ax5nu5qls32tmv--
