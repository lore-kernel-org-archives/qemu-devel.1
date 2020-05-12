Return-Path: <SRS0=ZOtl=62=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE35FC54E4B
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 06:20:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 78ECE20746
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 06:20:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VIWq32ME"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78ECE20746
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50322 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYOHI-0007i6-Gk
	for qemu-devel@archiver.kernel.org; Tue, 12 May 2020 02:20:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49104)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jYOGd-0007DI-VE
 for qemu-devel@nongnu.org; Tue, 12 May 2020 02:19:52 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:36818
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jYOGd-0003kg-0u
 for qemu-devel@nongnu.org; Tue, 12 May 2020 02:19:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589264390;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=GZ/zzcgb/O7b5PtWHpDSOzWNzwoYKL8rkCHv/vHImzk=;
 b=VIWq32ME0VgS3Bw3p2mbf0eUNWQ51OcPtJpqMabpuoDcN0FhtCn1JE+l+YrdijRaF6BaN+
 QA+fnTzchyF8C4Mhxn1DG6XhbtzShBmtX0U4wdbRakajj9tkU9HpBD2LVSrcz5CB+mNjge
 Fc1QnA92dITnv6AZUYOJVhKPigLfKk8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-484-sEJpbZIwNR2vrfqQUwemnA-1; Tue, 12 May 2020 02:19:46 -0400
X-MC-Unique: sEJpbZIwNR2vrfqQUwemnA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 205AE189952C;
 Tue, 12 May 2020 06:19:45 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-112-248.ams2.redhat.com
 [10.36.112.248])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 903F36199C;
 Tue, 12 May 2020 06:19:43 +0000 (UTC)
Subject: Re: [PATCH v3 3/9] block: Make it easier to learn which BDS support
 bitmaps
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
References: <20200508180340.675712-1-eblake@redhat.com>
 <20200508180340.675712-4-eblake@redhat.com>
 <aba3eddd-1201-9182-6011-9fe0bbca1b76@redhat.com>
 <b6c61cc5-8a7c-ef2c-76f1-def580827e14@redhat.com>
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
Message-ID: <b9d8e2bd-6f53-51dd-b529-4c0fefd7a310@redhat.com>
Date: Tue, 12 May 2020 08:19:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <b6c61cc5-8a7c-ef2c-76f1-def580827e14@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="ZdWUiVHyyanP6F6jKwFpZHJO6zneu5yju"
Received-SPF: pass client-ip=205.139.110.120; envelope-from=mreitz@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/12 02:02:04
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: kwolf@redhat.com, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 John Snow <jsnow@redhat.com>, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ZdWUiVHyyanP6F6jKwFpZHJO6zneu5yju
Content-Type: multipart/mixed; boundary="rbLs3AcreBqFWJWPqXZsuNkXcg23eN9LH"

--rbLs3AcreBqFWJWPqXZsuNkXcg23eN9LH
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 11.05.20 20:16, Eric Blake wrote:
> On 5/11/20 4:21 AM, Max Reitz wrote:
>> On 08.05.20 20:03, Eric Blake wrote:
>>> Upcoming patches will enhance bitmap support in qemu-img, but in doing
>>> so, it turns out to be nice to suppress output when bitmaps make no
>>> sense (such as on a qcow2 v2 image).=C2=A0 Add a hook to make this easi=
er
>>> to query.
>>>
>>> In the future, when we improve the ability to look up bitmaps through
>>> a filter, we will probably also want to teach the block layer to
>>> automatically let filters pass this request on through.
>>>
>>> Signed-off-by: Eric Blake <eblake@redhat.com>
>>> ---
>>> =C2=A0 block/qcow2.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 1 +
>>> =C2=A0 include/block/block_int.h=C2=A0=C2=A0=C2=A0 | 1 +
>>> =C2=A0 include/block/dirty-bitmap.h | 1 +
>>> =C2=A0 block/dirty-bitmap.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 | 9 +++++++++
>>> =C2=A0 block/qcow2-bitmap.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 | 7 +++++++
>>> =C2=A0 block/qcow2.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 1 +
>>> =C2=A0 6 files changed, 20 insertions(+)
>>>
>>> diff --git a/block/qcow2.h b/block/qcow2.h
>>> index f4de0a27d5c3..fb2b2b5a7b4d 100644
>>> --- a/block/qcow2.h
>>> +++ b/block/qcow2.h
>>> @@ -764,6 +764,7 @@ bool
>>> qcow2_co_can_store_new_dirty_bitmap(BlockDriverState *bs,
>>> =C2=A0 int qcow2_co_remove_persistent_dirty_bitmap(BlockDriverState *bs=
,
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const char *name,
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Error **errp);
>>> +bool qcow2_dirty_bitmap_supported(BlockDriverState *bs);
>>>
>>> =C2=A0 ssize_t coroutine_fn
>>> =C2=A0 qcow2_co_compress(BlockDriverState *bs, void *dest, size_t dest_=
size,
>>> diff --git a/include/block/block_int.h b/include/block/block_int.h
>>> index df6d0273d679..cb1082da4c43 100644
>>> --- a/include/block/block_int.h
>>> +++ b/include/block/block_int.h
>>> @@ -560,6 +560,7 @@ struct BlockDriver {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uint64_t parent_perm, uint64_t
>>> parent_shared,
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uint64_t *nperm, uint64_t *nshared);
>>>
>>> +=C2=A0=C2=A0=C2=A0 bool (*bdrv_dirty_bitmap_supported)(BlockDriverStat=
e *bs);
>>
>> All BDSs support bitmaps, but only some support persistent dirty
>> bitmaps, so I think the name should reflect that.
>=20
> How about .bdrv_dirty_bitmap_supports_persistent?

Sure.  Or .bdrv_supports_persistent_dirty_bitmaps.  Or
.bdrv_persistent_dirty_bitmaps_supported.  You decide what sounds best. :)

>> Conceptually, this looks reasonable.=C2=A0 This information might indeed=
 be
>> nice to have, and I=E2=80=99m not sure whether we should extend any exis=
ting
>> interface to return it.
>>
>> (The interfaces that come to my mind are:
>> (1) bdrv_can_store_new_dirty_bitmap() below, which we could make accept
>> a NULL @name to return basically the same information.=C2=A0 But it=E2=
=80=99s still a
>> bit different, because I=E2=80=99d expect that function to return whethe=
r any
>> bitmap can be stored then, not whether the node supports bitmaps at all.
>> =C2=A0 So e.g. if there are already too many bitmaps, it should return f=
alse,
>> even though the node itself does support bitmaps.
>=20
> [which reminds me - a while ago, we had patches for qcow2 handling with
> 64k bitmaps, or whatever insane number it took to overflow data
> structures, and I don't know if those ever got applied...]

I think that was a1db8733d28.  As far as I remember I just didn=E2=80=99t m=
erge
the test, because it took like five minutes to run.

>> (2) bdrv_get_info()/BlockDriverInfo: This information would fit in very
>> nicely here, but do we have to put it here just because it does?=C2=A0 I
>> don=E2=80=99t think so.=C2=A0 This patch adds 20 lines of code, that sho=
ws that it=E2=80=99s
>> very simple to add a dedicated method, and it=E2=80=99s certainly a bit =
easier
>> to use than to invoke bdrv_get_info() and throw away all the other
>> information.=C2=A0 Perhaps this patch only shows that BlockDriverInfo do=
esn=E2=80=99t
>> make much sense in the first place, and most of its fields should have
>> been scalar return values from dedicated functions.)
>=20
> Indeed, you (re-)discovered some of the very reasons why I chose to make
> a new interface.=C2=A0 I could tweak the commit message to mention
> alternatives, if that would help.

I suppose it wouldn=E2=80=99t help me, but it can=E2=80=99t harm either.  S=
o if it isn=E2=80=99t
too difficult, why not.

Max


--rbLs3AcreBqFWJWPqXZsuNkXcg23eN9LH--

--ZdWUiVHyyanP6F6jKwFpZHJO6zneu5yju
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl66P/0ACgkQ9AfbAGHV
z0BZnwf/TEoa8j+Co9bNtDLNmS2dJKoZEqxD52eDPV7JtKbFOQwTvLkVNxM4t/C/
O/S9smb+GOCbQ5SuZPF4MJeXn0VcAn3s3zyrii69ktcu0y5hLQON7EMhX2oscB8N
UWOCykqDlKWJaG7bTj/40lmEmPd4ffB0/IhwUViGjowVoKCOrzy2jYkEyJz+ezO0
Qr+gbm41HqM3YwGo54VPghUQJJ7kraztUs70y1KN1eZ70xvrgqoFTh1BppoQg0J0
jfmszY7FjWlGyYMhAnHDXWa2Rn9sYosCplugOQVeXFlcPBPhsiNqa0aiBVRFjdE3
GIBx2V7pKr9Rv5LgeOrcOMKouYVcXw==
=iJfd
-----END PGP SIGNATURE-----

--ZdWUiVHyyanP6F6jKwFpZHJO6zneu5yju--


