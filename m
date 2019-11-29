Return-Path: <SRS0=xfvu=ZV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 494E3C432C0
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2019 13:50:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF1BE217AB
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2019 13:50:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LvTnFbDy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF1BE217AB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59286 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iagfV-0002T0-5n
	for qemu-devel@archiver.kernel.org; Fri, 29 Nov 2019 08:50:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35962)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iagbw-0000eZ-Qh
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 08:47:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iagbn-0001tL-VX
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 08:46:57 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:40476
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1iagbm-0001qA-4o
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 08:46:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575035211;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=y0O5RFyM/3rAFPuiPli/Sl8FFgJdpvXbRm9ZUPKiyQQ=;
 b=LvTnFbDyZ1f88litDWLglRYi5EbTrXjL0nmoyGzWVhfQ2I0653dlAhv46j6KXIQaLirCsO
 QTRSaYufk4nqK7/PLNP/FtcM4pTEITTClJDjpV5nClRKmNzr29ykqJGHZoYf1wtD0MGlRk
 WrlJhJUOHe7o8/ITsvxcSxAl4xjcMh8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-269-58HGZV4sPseOjFrkJnUmgg-1; Fri, 29 Nov 2019 08:46:44 -0500
X-MC-Unique: 58HGZV4sPseOjFrkJnUmgg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2BFC3DB20;
 Fri, 29 Nov 2019 13:46:43 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-206-40.brq.redhat.com
 [10.40.206.40])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9B168600C8;
 Fri, 29 Nov 2019 13:46:41 +0000 (UTC)
Subject: Re: [PATCH for-5.0 v2 15/23] mirror: Prevent loops
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>
References: <20191111160216.197086-1-mreitz@redhat.com>
 <20191111160216.197086-16-mreitz@redhat.com>
 <2c47c1be-e633-c769-88fe-684fe1ebe80f@virtuozzo.com>
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
Message-ID: <88baa19f-1433-178e-33eb-16c275dec909@redhat.com>
Date: Fri, 29 Nov 2019 14:46:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <2c47c1be-e633-c769-88fe-684fe1ebe80f@virtuozzo.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="EeQL2epo2LhXPecXPz5yGj7se0EZlKkxP"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
--EeQL2epo2LhXPecXPz5yGj7se0EZlKkxP
Content-Type: multipart/mixed; boundary="WhhLf9d1lr1v8KRe9NMsRtMDWCdF1jppd"

--WhhLf9d1lr1v8KRe9NMsRtMDWCdF1jppd
Content-Type: text/plain; charset=WINDOWS-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 29.11.19 13:01, Vladimir Sementsov-Ogievskiy wrote:
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
>=20
> Hmm.. So, we want the following valid case:
>=20
> (other parents of source) ----> source =3D to_replace <--- backing --- ta=
rget
>=20
> becomes
>=20
> (other parents of source) ----> target --- backing ---> source
>=20
> But it seems for me, that the following is not less valid:
>=20
> (other parents of source) ----> source =3D to_replace <--- backing --- X =
<--- backing --- target
>=20
> becomes
>=20
> (other parents of source) ----> target --- backing ---> X --- backing ---=
> source

I think it is less valid.  The first case works with sync=3Dnone, because
target is initially empty and then you just copy all new data, so the
target keeps looking like the source.

But in the second case, there are intermediate nodes that mean that
target may well not look like the source.

(Yes, you have the same problem if you use sync=3Dnone or sync=3Dfull to a
completely independent node.  But that still means that while the first
case is always valid, the second may be problematic.)

> And what we actually want to prevent, is when to_replace is not source, b=
ut child (may be not direct)
> of source..
>=20
> Also, with your check you still allow silent no-change in the following c=
ase:
>=20
> source --- backing --> to_replace <-- backing -- target

You mean if source is a filter on to_replace?  (Because otherwise you
can=92t replace that node.)

Is that really a no-change?  Shouldn=92t we get

source --> target --> to_replace

?  (And what else would you expect?)

So maybe we don=92t want to prevent that, because I think it can make sense=
.

Max

> =3D=3D=3D=3D
>=20
> In other words, replacing make sense, only if to_replace has some other p=
arents, which are not
> children (may be not direct) of target.. And the only known such case is =
when in the same time
> to_replace =3D=3D source.
>=20
> so, shouldn't the following be
>=20
> if (to_replace =3D=3D src || !bdrv_is_child_of(to_replace, target_bs, 1) =
{
>=20
> or, may be, to allow also replace filters above src, keeping backing link=
 :
>=20
> if (bdrv_is_child_of(src, to_replace, 0) || !bdrv_is_child_of(to_replace,=
 target_bs, 1) {
>=20
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



--WhhLf9d1lr1v8KRe9NMsRtMDWCdF1jppd--

--EeQL2epo2LhXPecXPz5yGj7se0EZlKkxP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl3hIT8ACgkQ9AfbAGHV
z0DxSgf7BH7lKgu18xauy2azBgVvAkQhW51BIv941EKK4TjE36ERwWybAij5Jr2o
2D56yoA9H+QiVcALPoiT2f4dwXdJ4rLSH2R4KDI6WICX9oKjPLRh40gvQ3xXM5hP
KOQralK/P3vw+bCYpTaT2sBocjmIF4f3n5+JgBDAr4DvTKJl3ffJbThjzIlQDad3
dlkJeBjZ41T+89THn4C72XEmo1amZvYP0/IYo32zhFWtjTpM1hhaE92zpAJWTRgH
yahFqyUgBsmIgOQ8LDLbqJbCOrP9YP3C7IxzI8vj+FUPMUGp6sStY3r8jafG8hI9
fd8o8kHDvSNyaemZTuQiaWseTet4Gw==
=nhxe
-----END PGP SIGNATURE-----

--EeQL2epo2LhXPecXPz5yGj7se0EZlKkxP--


