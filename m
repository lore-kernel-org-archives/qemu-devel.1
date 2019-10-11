Return-Path: <SRS0=T2pn=YE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D2C7C47404
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2019 09:09:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4FA222084C
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2019 09:09:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FA222084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47590 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIqvF-0008Tk-TB
	for qemu-devel@archiver.kernel.org; Fri, 11 Oct 2019 05:09:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48104)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iIql6-0006H3-Dz
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 04:58:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iIql5-0000G6-5D
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 04:58:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36062)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1iIql1-0000En-61; Fri, 11 Oct 2019 04:58:43 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 2E5268980E5;
 Fri, 11 Oct 2019 08:58:42 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-116-40.ams2.redhat.com
 [10.36.116.40])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5379B194BE;
 Fri, 11 Oct 2019 08:58:34 +0000 (UTC)
Subject: Re: [PATCH 3/4] block/mirror: support unaligned write in active mirror
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>
References: <20190912151338.21225-1-vsementsov@virtuozzo.com>
 <20190912151338.21225-4-vsementsov@virtuozzo.com>
 <6fd6a449-0443-ecfa-0eec-23e3b515b303@redhat.com>
 <eb11dfe2-fe3b-54bf-a23f-b9d208690680@virtuozzo.com>
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
Message-ID: <0cc82b6a-9a1c-4f5b-f133-153ab739c0a3@redhat.com>
Date: Fri, 11 Oct 2019 10:58:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <eb11dfe2-fe3b-54bf-a23f-b9d208690680@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="YaHqEzS97buV5lPXaSahXGd6U6uXQGQvI"
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.67]); Fri, 11 Oct 2019 08:58:42 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: "kwolf@redhat.com" <kwolf@redhat.com>,
 "jsnow@redhat.com" <jsnow@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Denis Lunev <den@virtuozzo.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--YaHqEzS97buV5lPXaSahXGd6U6uXQGQvI
Content-Type: multipart/mixed; boundary="12rfKbyLsCc8cN1fW2ys5Ez7dm7cxrMfe"

--12rfKbyLsCc8cN1fW2ys5Ez7dm7cxrMfe
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 11.10.19 10:33, Vladimir Sementsov-Ogievskiy wrote:
> 04.10.2019 19:31, Max Reitz wrote:
>> On 12.09.19 17:13, Vladimir Sementsov-Ogievskiy wrote:
>>> Prior 9adc1cb49af8d do_sync_target_write had a bug: it reset aligned-=
up
>>> region in the dirty bitmap, which means that we may not copy some byt=
es
>>> and assume them copied, which actually leads to producing corrupted
>>> target.
>>>
>>> So 9adc1cb49af8d forced dirty bitmap granularity to be
>>> request_alignment for mirror-top filter, so we are not working with
>>> unaligned requests. However forcing large alignment obviously decreas=
es
>>> performance of unaligned requests.
>>>
>>> This commit provides another solution for the problem: if unaligned
>>> padding is already dirty, we can safely ignore it, as
>>> 1. It's dirty, it will be copied by mirror_iteration anyway
>>> 2. It's dirty, so skipping it now we don't increase dirtiness of the
>>>     bitmap and therefore don't damage "synchronicity" of the
>>>     write-blocking mirror.
>>>
>>> If unaligned padding is not dirty, we just write it, no reason to tou=
ch
>>> dirty bitmap if we succeed (on failure we'll set the whole region
>>> ofcourse, but we loss "synchronicity" on failure anyway).
>>>
>>> Note: we need to disable dirty_bitmap, otherwise we will not be able =
to
>>> see in do_sync_target_write bitmap state before current operation. We=

>>> may of course check dirty bitmap before the operation in
>>> bdrv_mirror_top_do_write and remember it, but we don't need active
>>> dirty bitmap for write-blocking mirror anyway.
>>>
>>> New code-path is unused until the following commit reverts
>>> 9adc1cb49af8d.
>>>
>>> Suggested-by: Denis V. Lunev <den@openvz.org>
>>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com=
>
>>> ---
>>>   block/mirror.c | 39 ++++++++++++++++++++++++++++++++++++++-
>>>   1 file changed, 38 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/block/mirror.c b/block/mirror.c
>>> index d176bf5920..d192f6a96b 100644
>>> --- a/block/mirror.c
>>> +++ b/block/mirror.c
>>> @@ -1204,6 +1204,39 @@ do_sync_target_write(MirrorBlockJob *job, Mirr=
orMethod method,
>>>                        QEMUIOVector *qiov, int flags)
>>>   {
>>>       int ret;
>>> +    size_t qiov_offset =3D 0;
>>> +
>>> +    if (!QEMU_IS_ALIGNED(offset, job->granularity) &&
>>> +        bdrv_dirty_bitmap_get(job->dirty_bitmap, offset)) {
>>> +            /*
>>> +             * Dirty unaligned padding
>>> +             * 1. It's already dirty, no damage to "actively_synced"=
 if we just
>>> +             *    skip unaligned part.
>>> +             * 2. If we copy it, we can't reset corresponding bit in=

>>> +             *    dirty_bitmap as there may be some "dirty" bytes st=
ill not
>>> +             *    copied.
>>> +             * So, just ignore it.
>>> +             */
>>> +            qiov_offset =3D QEMU_ALIGN_UP(offset, job->granularity) =
- offset;
>>> +            if (bytes <=3D qiov_offset) {
>>> +                /* nothing to do after shrink */
>>> +                return;
>>> +            }
>>> +            offset +=3D qiov_offset;
>>> +            bytes -=3D qiov_offset;
>>> +    }
>>> +
>>> +    if (!QEMU_IS_ALIGNED(offset + bytes, job->granularity) &&
>>> +        bdrv_dirty_bitmap_get(job->dirty_bitmap, offset + bytes - 1)=
)
>>> +    {
>>> +        uint64_t tail =3D (offset + bytes) % job->granularity;
>>> +
>>> +        if (bytes <=3D tail) {
>>> +            /* nothing to do after shrink */
>>> +            return;
>>> +        }
>>> +        bytes -=3D tail;
>>> +    }
>>>  =20
>>>       bdrv_reset_dirty_bitmap(job->dirty_bitmap, offset, bytes);
>>>  =20
>>
>> The bdrv_set_dirty_bitmap() in the error case below needs to use the
>> original offset/bytes, I suppose.
>=20
> No, because we shrink tail only if it is already dirty. And we've locke=
d the
> region for in-flight operation, so nobody can clear the bitmap in a mea=
ntime.

True.  But wouldn=E2=80=99t it be simpler to understand to just use the o=
riginal
offsets?

> But still, here is something to do:
>=20
> for not-shrinked tails, if any, we should:
> 1. align down for reset
> 2. align up for set on failure

Well, the align up is done automatically, and I think that=E2=80=99s pret=
ty
self-explanatory.

Max

>>
>> Apart from that, looks good to me.
>>
>> Max
>>
>=20
>=20



--12rfKbyLsCc8cN1fW2ys5Ez7dm7cxrMfe--

--YaHqEzS97buV5lPXaSahXGd6U6uXQGQvI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl2gRDkACgkQ9AfbAGHV
z0ChXgf/Urz/EwQcEoiSdNmxDztVv3EY3oqVZzUFyJO/cxEUh9l7PxC+27GZ3tix
qKdqKGoQV2KwniHBgcSDHdjHywPorch4t0YobopTwBrByF9pSQhgHhjUYqFmx7Z1
v2aZnPA1e1FKVj8OT/nlm0mcL8pBQ7KCTZBkEQvFudYrTxcp2bXyfVrkgw+mDdx2
eBWiuScwa1Dq6wdVsB/KXr0sXMxz+EK/2jR3u0wcBsGw3roo93ag8Jcpn9fzOgA1
byS+0r0OJoUi6ISHa1nfe9UTSfva3WwvlBF4/KJDDGajmOiXOEzMn/JNO4Xk9s+x
KYQeadhS1XOJSz5/tp25RtFpnrJVGA==
=QQ34
-----END PGP SIGNATURE-----

--YaHqEzS97buV5lPXaSahXGd6U6uXQGQvI--

