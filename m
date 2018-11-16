Received: from eggs.gnu.org ([2001:4830:134:3::10]:40047)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gNh5h-0004fz-Gn
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 11:35:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gNh5g-0007Kg-KE
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 11:35:33 -0500
References: <20181116155302.22472-1-mreitz@redhat.com>
	<20181116155302.22472-2-mreitz@redhat.com>
	<w51d0r5ui29.fsf@maestria.local.igalia.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <1d6d0fdd-1f44-0f41-1fa2-dd032921344e@redhat.com>
Date: Fri, 16 Nov 2018 17:35:18 +0100
MIME-Version: 1.0
In-Reply-To: <w51d0r5ui29.fsf@maestria.local.igalia.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="WpyhHotDK8StVU09sRkTZI0q8J2rtBkCn"
Subject: Re: [Qemu-devel] [PATCH for-3.1? 1/3] block: Always abort reopen
 after prepare succeeded
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Fam Zheng <famz@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--WpyhHotDK8StVU09sRkTZI0q8J2rtBkCn
From: Max Reitz <mreitz@redhat.com>
To: Alberto Garcia <berto@igalia.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Fam Zheng <famz@redhat.com>
Message-ID: <1d6d0fdd-1f44-0f41-1fa2-dd032921344e@redhat.com>
Subject: Re: [PATCH for-3.1? 1/3] block: Always abort reopen after prepare
 succeeded
References: <20181116155302.22472-1-mreitz@redhat.com>
 <20181116155302.22472-2-mreitz@redhat.com>
 <w51d0r5ui29.fsf@maestria.local.igalia.com>
In-Reply-To: <w51d0r5ui29.fsf@maestria.local.igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 16.11.18 17:02, Alberto Garcia wrote:
> On Fri 16 Nov 2018 04:53:00 PM CET, Max Reitz wrote:
>> bdrv_reopen_multiple() does not invoke bdrv_reopen_abort() for the
>> element of the reopen queue for which bdrv_reopen_prepare() failed,
>> because it assumes that the prepare function will have rolled back all=

>> changes already.
>>
>> However, bdrv_reopen_prepare() does not do this in every case: It may
>> notice an error after BlockDriver.bdrv_reopen_prepare() succeeded, and=

>> it will not invoke BlockDriver.bdrv_reopen_abort() then; and neither
>> will bdrv_reopen_multiple(), as explained above.
>>
>> This is wrong because we must always call .bdrv_reopen_commit() or
>> .bdrv_reopen_abort() after .bdrv_reopen_prepare() has succeeded.
>> Otherwise, the block driver has no chance to undo what it has done in
>> its implementation of .bdrv_reopen_prepare().
>>
>> To fix this, bdrv_reopen_prepare() has to call .bdrv_reopen_abort() if=

>> it wants to return an error after .bdrv_reopen_prepare() has succeeded=
=2E
>>
>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>> ---
>>  block.c | 17 +++++++++++++++--
>>  1 file changed, 15 insertions(+), 2 deletions(-)
>>
>> diff --git a/block.c b/block.c
>> index fd67e14dfa..7f5859aa74 100644
>> --- a/block.c
>> +++ b/block.c
>> @@ -3332,7 +3332,7 @@ int bdrv_reopen_prepare(BDRVReopenState *reopen_=
state, BlockReopenQueue *queue,
>>              if (!qobject_is_equal(new, old)) {
>>                  error_setg(errp, "Cannot change the option '%s'", ent=
ry->key);
>>                  ret =3D -EINVAL;
>> -                goto error;
>> +                goto late_error;
>>              }
>>          } while ((entry =3D qdict_next(reopen_state->options, entry))=
);
>>      }
>> @@ -3340,7 +3340,7 @@ int bdrv_reopen_prepare(BDRVReopenState *reopen_=
state, BlockReopenQueue *queue,
>>      ret =3D bdrv_check_perm(reopen_state->bs, queue, reopen_state->pe=
rm,
>>                            reopen_state->shared_perm, NULL, errp);
>>      if (ret < 0) {
>> -        goto error;
>> +        goto late_error;
>>      }
>> =20
>>      ret =3D 0;
>> @@ -3354,6 +3354,19 @@ error:
>>      qobject_unref(orig_reopen_opts);
>>      g_free(discard);
>>      return ret;
>> +
>> +late_error:
>> +    /* drv->bdrv_reopen_prepare() has succeeded, so we need to call
>> +     * drv->bdrv_reopen_abort() before signaling an error
>> +     * (bdrv_reopen_multiple() will not call bdrv_reopen_abort() when=

>> +     * the respective bdrv_reopen_prepare() failed) */
>> +    if (drv->bdrv_reopen_abort) {
>> +        drv->bdrv_reopen_abort(reopen_state);
>> +    }
>> +    qemu_opts_del(opts);
>> +    qobject_unref(orig_reopen_opts);
>> +    g_free(discard);
>> +    return ret;
>>  }
>=20
> Instead of having two exit points you could also have something like
> bool drv_prepared, set it to 'true' after drv->bdrv_reopen_prepare() ha=
s
> succeeded and then simply add this at the end:
>=20
> if (ret < 0 && drv_prepared) {
>    drv->bdrv_reopen_abort(reopen_state);
> }=20

Yup, sure.

Max



--WpyhHotDK8StVU09sRkTZI0q8J2rtBkCn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlvu8cYACgkQ9AfbAGHV
z0ATmAgArwiU2AQTLh6xYzhOSjEGaU+fTAUlVK/0KLYWOGLqCTaeJFoyJr5GS5NV
3Al2PMh0CUy4cf9Ihi1V+XIBB0ZpO7T9P3PUTB/MC407aIr9cUCsRvNRKqFaVU4w
tIihm1ivRZ5/yzoWNjJLakSCd6vTd0eeRHzwKwtc0ETQdpeO82JFXyCurg6aRXsv
l6PDUSwIDWRIf0CuUK2KmpYXiPjp4shvc5jN5xI/nFzT4CmihVVrP8oDUJEG4hCW
ospH/0nSyUKMwfaY+1B/bWawnZm3u+u75isaR9PdBaBzPFcHMA2WPOA2FIIxAlpu
Mh5M/8fJaxBtFp1eeT2sbaX9mT7BIw==
=u9cw
-----END PGP SIGNATURE-----

--WpyhHotDK8StVU09sRkTZI0q8J2rtBkCn--
