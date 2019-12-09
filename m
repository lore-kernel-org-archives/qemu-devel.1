Return-Path: <SRS0=fi8h=Z7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 605FBC2BD09
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2019 14:45:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1FE042080D
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2019 14:45:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O9/yJBPu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FE042080D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40954 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ieKIO-0007Qu-Al
	for qemu-devel@archiver.kernel.org; Mon, 09 Dec 2019 09:45:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42059)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1ieKGZ-0005Qm-KC
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 09:44:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1ieKGX-00074w-Se
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 09:44:03 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:47909
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1ieKGX-00074i-Nb
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 09:44:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575902640;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=zB/R33o7RWuNy1Lq9hSjYM1fc/csOQac4PnxSp7n+lw=;
 b=O9/yJBPuACLyCQOBXLsnYiapkrwX/F7QM6XUjMS2MHpqLLZV/A2txsw+lHvno5nQhSPhPb
 He2Bp68DQ9czqs6hFyZ1Dkptd0n+i/E84LAJzcINgiS2EFhEJnmd6Qr8hKTbAbmJS43jJ2
 cpKPse2Jd/55NlrObCpNyk5DWkQ2eOY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-310-jZVEc399M-uU_t3g7_89Qw-1; Mon, 09 Dec 2019 09:43:56 -0500
X-MC-Unique: jZVEc399M-uU_t3g7_89Qw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E37FE107ACC7;
 Mon,  9 Dec 2019 14:43:54 +0000 (UTC)
Received: from dresden.str.redhat.com (unknown [10.36.118.51])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 01FDF5D6C5;
 Mon,  9 Dec 2019 14:43:52 +0000 (UTC)
Subject: Re: [PATCH for-5.0 v2 15/23] mirror: Prevent loops
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>
References: <20191111160216.197086-1-mreitz@redhat.com>
 <20191111160216.197086-16-mreitz@redhat.com>
 <7f50c050-38ca-a7f2-361b-a08e82b420af@virtuozzo.com>
From: Max Reitz <mreitz@redhat.com>
Autocrypt: addr=mreitz@redhat.com; prefer-encrypt=mutual; keydata=
 mQENBFXOJlcBCADEyyhOTsoa/2ujoTRAJj4MKA21dkxxELVj3cuILpLTmtachWj7QW+TVG8U
 /PsMCFbpwsQR7oEy8eHHZwuGQsNpEtNC2G/L8Yka0BIBzv7dEgrPzIu+W3anZXQW4702+uES
 U29G8TP/NGfXRRHGlbBIH9KNUnOSUD2vRtpOLXkWsV5CN6vQFYgQfFvmp5ZpPeUe6xNplu8V
 mcTw8OSEDW/ZnxJc8TekCKZSpdzYoxfzjm7xGmZqB18VFwgJZlIibt1HE0EB4w5GsD7x5ekh
 awIe3RwoZgZDLQMdOitJ1tUc8aqaxvgA4tz6J6st8D8pS//m1gAoYJWGwwIVj1DjTYLtABEB
 AAG0HU1heCBSZWl0eiA8bXJlaXR6QHJlZGhhdC5jb20+iQFTBBMBCAA9AhsDBQkSzAMABQsJ
 CAcCBhUICQoLAgQWAgMBAh4BAheABQJVzie5FRhoa3A6Ly9rZXlzLmdudXBnLm5ldAAKCRD0
 B9sAYdXPQDcIB/9uNkbYEex1rHKz3mr12uxYMwLOOFY9fstP5aoVJQ1nWQVB6m2cfKGdcRe1
 2/nFaHSNAzT0NnKz2MjhZVmcrpyd2Gp2QyISCfb1FbT82GMtXFj1wiHmPb3CixYmWGQUUh+I
 AvUqsevLA+WihgBUyaJq/vuDVM1/K9Un+w+Tz5vpeMidlIsTYhcsMhn0L9wlCjoucljvbDy/
 8C9L2DUdgi3XTa0ORKeflUhdL4gucWoAMrKX2nmPjBMKLgU7WLBc8AtV+84b9OWFML6NEyo4
 4cP7cM/07VlJK53pqNg5cHtnWwjHcbpGkQvx6RUx6F1My3y52vM24rNUA3+ligVEgPYBuQEN
 BFXOJlcBCADAmcVUNTWT6yLWQHvxZ0o47KCP8OcLqD+67T0RCe6d0LP8GsWtrJdeDIQk+T+F
 xO7DolQPS6iQ6Ak2/lJaPX8L0BkEAiMuLCKFU6Bn3lFOkrQeKp3u05wCSV1iKnhg0UPji9V2
 W5eNfy8F4ZQHpeGUGy+liGXlxqkeRVhLyevUqfU0WgNqAJpfhHSGpBgihUupmyUg7lfUPeRM
 DzAN1pIqoFuxnN+BRHdAecpsLcbR8sQddXmDg9BpSKozO/JyBmaS1RlquI8HERQoe6EynJhd
 64aICHDfj61rp+/0jTIcevxIIAzW70IadoS/y3DVIkuhncgDBvGbF3aBtjrJVP+5ABEBAAGJ
 ASUEGAEIAA8FAlXOJlcCGwwFCRLMAwAACgkQ9AfbAGHVz0CbFwf9F/PXxQR9i4N0iipISYjU
 sxVdjJOM2TMut+ZZcQ6NSMvhZ0ogQxJ+iEQ5OjnIputKvPVd5U7WRh+4lF1lB/NQGrGZQ1ic
 alkj6ocscQyFwfib+xIe9w8TG1CVGkII7+TbS5pXHRxZH1niaRpoi/hYtgzkuOPp35jJyqT/
 /ELbqQTDAWcqtJhzxKLE/ugcOMK520dJDeb6x2xVES+S5LXby0D4juZlvUj+1fwZu+7Io5+B
 bkhSVPb/QdOVTpnz7zWNyNw+OONo1aBUKkhq2UIByYXgORPFnbfMY7QWHcjpBVw9MgC4tGeF
 R4bv+1nAMMxKmb5VvQCExr0eFhJUAHAhVg==
Message-ID: <c2fde7aa-21fc-f8bb-02fa-af28ddd297f7@redhat.com>
Date: Mon, 9 Dec 2019 15:43:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <7f50c050-38ca-a7f2-361b-a08e82b420af@virtuozzo.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="QGrMx2ztDsGRJL1YnJBsQV7e9AodTSSRi"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Kevin Wolf <kwolf@redhat.com>, Alberto Garcia <berto@igalia.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--QGrMx2ztDsGRJL1YnJBsQV7e9AodTSSRi
Content-Type: multipart/mixed; boundary="M3LzYkEBB7aVpGYXfvW2GGHzGhZS6e4kc"

--M3LzYkEBB7aVpGYXfvW2GGHzGhZS6e4kc
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 02.12.19 13:12, Vladimir Sementsov-Ogievskiy wrote:
> 11.11.2019 19:02, Max Reitz wrote:
>> While bdrv_replace_node() will not follow through with it, a specific
>> @replaces asks the mirror job to create a loop.
>>
>> For example, say both the source and the target share a child where the
>> source is a filter; by letting @replaces point to the common child, you
>> ask for a loop.
>>
>> Or if you use @replaces in drive-mirror with sync=3Dnone and
>> mode=3Dabsolute-paths, you generally ask for a loop (@replaces must poin=
t
>> to a child of the source, and sync=3Dnone makes the source the backing
>> file of the target after the job).
>>
>> bdrv_replace_node() will not create those loops, but by doing so, it
>> ignores the user-requested configuration, which is not ideally either.
>> (In the first example above, the target's child will remain what it was,
>> which may still be reasonable.  But in the second example, the target
>> will just not become a child of the source, which is precisely what was
>> requested with @replaces.)
>>
>> So prevent such configurations, both before the job, and before it
>> actually completes.
>>
>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>> ---
>>   block.c                   | 30 ++++++++++++++++++++++++
>>   block/mirror.c            | 19 +++++++++++++++-
>>   blockdev.c                | 48 ++++++++++++++++++++++++++++++++++++++-
>>   include/block/block_int.h |  3 +++
>>   4 files changed, 98 insertions(+), 2 deletions(-)
>>
>> diff --git a/block.c b/block.c
>> index 0159f8e510..e3922a0474 100644
>> --- a/block.c
>> +++ b/block.c
>> @@ -6259,6 +6259,36 @@ out:
>>       return to_replace_bs;
>>   }
>>  =20
>> +/*
>> + * Return true iff @child is a (recursive) child of @parent, with at
>> + * least @min_level edges between them.
>> + *
>> + * (If @min_level =3D=3D 0, return true if @child =3D=3D @parent.  For
>> + * @min_level =3D=3D 1, @child needs to be at least a real child; for
>> + * @min_level =3D=3D 2, it needs to be at least a grand-child; and so o=
n.)
>> + */
>> +bool bdrv_is_child_of(BlockDriverState *child, BlockDriverState *parent=
,
>> +                      int min_level)
>> +{
>> +    BdrvChild *c;
>> +
>> +    if (child =3D=3D parent && min_level <=3D 0) {
>> +        return true;
>> +    }
>> +
>> +    if (!parent) {
>> +        return false;
>> +    }
>> +
>> +    QLIST_FOREACH(c, &parent->children, next) {
>> +        if (bdrv_is_child_of(child, c->bs, min_level - 1)) {
>> +            return true;
>> +        }
>> +    }
>> +
>> +    return false;
>> +}
>> +
>>   /**
>>    * Iterates through the list of runtime option keys that are said to
>>    * be "strong" for a BDS.  An option is called "strong" if it changes
>> diff --git a/block/mirror.c b/block/mirror.c
>> index 68a4404666..b258c7e98b 100644
>> --- a/block/mirror.c
>> +++ b/block/mirror.c
>> @@ -701,7 +701,24 @@ static int mirror_exit_common(Job *job)
>>            * there.
>>            */
>>           if (bdrv_recurse_can_replace(src, to_replace)) {
>> -            bdrv_replace_node(to_replace, target_bs, &local_err);
>> +            /*
>> +             * It is OK for @to_replace to be an immediate child of
>> +             * @target_bs, because that is what happens with
>> +             * drive-mirror sync=3Dnone mode=3Dabsolute-paths: target_b=
s's
>> +             * backing file will be the source node, which is also
>> +             * to_replace (by default).
>> +             * bdrv_replace_node() handles this case by not letting
>> +             * target_bs->backing point to itself, but to the source
>> +             * still.
>> +             */
>> +            if (!bdrv_is_child_of(to_replace, target_bs, 2)) {
>> +                bdrv_replace_node(to_replace, target_bs, &local_err);
>> +            } else {
>> +                error_setg(&local_err, "Can no longer replace '%s' by '=
%s', "
>> +                           "because the former is now a child of the la=
tter, "
>> +                           "and doing so would thus create a loop",
>> +                           to_replace->node_name, target_bs->node_name)=
;
>> +            }
>=20
> you may swap if and else branch, dropping "!" mark..

Yes, but I just personally prefer to have the error case in the else branch=
.

>>           } else {
>>               error_setg(&local_err, "Can no longer replace '%s' by '%s'=
, "
>>                          "because it can no longer be guaranteed that do=
ing so "
>> diff --git a/blockdev.c b/blockdev.c
>> index 9dc2238bf3..d29f147f72 100644
>> --- a/blockdev.c
>> +++ b/blockdev.c
>> @@ -3824,7 +3824,7 @@ static void blockdev_mirror_common(const char *job=
_id, BlockDriverState *bs,
>>       }
>>  =20
>>       if (has_replaces) {
>> -        BlockDriverState *to_replace_bs;
>> +        BlockDriverState *to_replace_bs, *target_backing_bs;
>>           AioContext *replace_aio_context;
>>           int64_t bs_size, replace_size;
>>  =20
>> @@ -3839,6 +3839,52 @@ static void blockdev_mirror_common(const char *jo=
b_id, BlockDriverState *bs,
>>               return;
>>           }
>>  =20
>> +        if (bdrv_is_child_of(to_replace_bs, target, 1)) {
>> +            error_setg(errp, "Replacing %s by %s would result in a loop=
, "
>> +                       "because the former is a child of the latter",
>> +                       to_replace_bs->node_name, target->node_name);
>> +            return;
>> +        }
>=20
> here min_level=3D1, so we don't handle the case, described in mirror_exit=
_common..
> I don't see why.. blockdev_mirror_common is called from qmp_drive_mirror,
> including the case with MIRROR_SYNC_MODE_NONE and NEW_IMAGE_MODE_ABSOLUTE=
_PATHS..
>=20
> What I'm missing?

Hmm.  Well.

If it broke drive-mirror sync=3Dnone, I suppose I would have noticed by
running the iotests.  But I didn=92t, and that=92s because this code here i=
s
reached only if the user actually specified @replaces.  (As opposed to
the mirror_exit_common code, where @to_replace may simply be @src if not
overridden by the user.)

The only reason why I allow it in mirror_exit_common is because we have
to.  But if the user manually specifies this configuration, we can=92t
guarantee it=92s safe.

OTOH, well, if we allow it for drive-mirror sync=3Dnone, why not allow it
when manually specified with blockdev-mirror?

What=92s your opinion?

>> +
>> +        if (backing_mode =3D=3D MIRROR_SOURCE_BACKING_CHAIN ||
>> +            backing_mode =3D=3D MIRROR_OPEN_BACKING_CHAIN)
>> +        {
>> +            /*
>> +             * While we do not quite know what OPEN_BACKING_CHAIN
>> +             * (used for mode=3Dexisting) will yield, it is probably
>> +             * best to restrict it exactly like SOURCE_BACKING_CHAIN,
>> +             * because that is our best guess.
>> +             */
>> +            switch (sync) {
>> +            case MIRROR_SYNC_MODE_FULL:
>> +                target_backing_bs =3D NULL;
>> +                break;
>> +
>> +            case MIRROR_SYNC_MODE_TOP:
>> +                target_backing_bs =3D backing_bs(bs);
>> +                break;
>> +
>> +            case MIRROR_SYNC_MODE_NONE:
>> +                target_backing_bs =3D bs;
>> +                break;
>> +
>> +            default:
>> +                abort();
>> +            }
>> +        } else {
>> +            assert(backing_mode =3D=3D MIRROR_LEAVE_BACKING_CHAIN);
>> +            target_backing_bs =3D backing_bs(target);
>> +        }
>> +
>> +        if (bdrv_is_child_of(to_replace_bs, target_backing_bs, 0)) {
>> +            error_setg(errp, "Replacing '%s' by '%s' with this sync mod=
e would "
>> +                       "result in a loop, because the former would be a=
 child "
>> +                       "of the latter's backing file ('%s') after the m=
irror "
>> +                       "job", to_replace_bs->node_name, target->node_na=
me,
>> +                       target_backing_bs->node_name);
>> +            return;
>> +        }
>=20
> hmm.. so for MODE_NONE we disallow to_replace =3D=3D src?

I suppose that=92s basically the same as above.  Should we allow this case
when specified explicitly by the user?

Max

>> +
>>           replace_aio_context =3D bdrv_get_aio_context(to_replace_bs);
>>           aio_context_acquire(replace_aio_context);
>>           replace_size =3D bdrv_getlength(to_replace_bs);
>> diff --git a/include/block/block_int.h b/include/block/block_int.h
>> index 589a797fab..7064a1a4fa 100644
>> --- a/include/block/block_int.h
>> +++ b/include/block/block_int.h
>> @@ -1266,6 +1266,9 @@ void bdrv_format_default_perms(BlockDriverState *b=
s, BdrvChild *c,
>>   bool bdrv_recurse_can_replace(BlockDriverState *bs,
>>                                 BlockDriverState *to_replace);
>>  =20
>> +bool bdrv_is_child_of(BlockDriverState *child, BlockDriverState *parent=
,
>> +                      int min_level);
>> +
>>   /*
>>    * Default implementation for drivers to pass bdrv_co_block_status() t=
o
>>    * their file.
>>
>=20
>=20



--M3LzYkEBB7aVpGYXfvW2GGHzGhZS6e4kc--

--QGrMx2ztDsGRJL1YnJBsQV7e9AodTSSRi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl3uXaYACgkQ9AfbAGHV
z0BUgQf9F6OTPsaLtr4F4BWForfbGNqoa45MWxz15PrfpP+mBCK851L9LpCx35k/
fj6SKXfQveAOxATbnxzftZSrsxj36HtKnlgYWHXbnOOOThXeBXv1a3CE8hed1+Sk
wB/4anlUqRupzOJ9bElvSqJRqWaA1HEJazFyflRGejymMFMHTsqtG5zfjYyob5UN
toqHrqsViA0EPiMsEn9nGJOTTk8Zki9gj1L3GtdBaRUPyOZfnQZwPF/bDoU2y4mO
3ojid0TeKnK+RX+mTO1R0g6rDYu5R2nqhDJI7y2PK9QUGVjPtpX5F2MMZg9naIlQ
npw0AxhPehab8Sh9lb08YlFyYUKMYA==
=UI5z
-----END PGP SIGNATURE-----

--QGrMx2ztDsGRJL1YnJBsQV7e9AodTSSRi--


