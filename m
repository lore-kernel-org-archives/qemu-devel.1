Return-Path: <SRS0=5yua=6H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 483D2C54FCB
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2020 17:22:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 04E8320728
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2020 17:22:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G5zCkU68"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04E8320728
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33522 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRfYp-0002bx-0s
	for qemu-devel@archiver.kernel.org; Thu, 23 Apr 2020 13:22:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48186)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1jRfY2-0001m5-Dd
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 13:22:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1jRfY0-00061A-U3
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 13:22:01 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:53180
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jRfY0-00060r-EG
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 13:22:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587662519;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=QM38zpm8dp78rVHEM9gQmvIcmA6Kxb7eomQwtWSw8ak=;
 b=G5zCkU68vCft4SMGlQeNYrismcqrv2aWuJ3+GuQZwaMQCiDKB7Bi9ulFUFZHMwv4ugJIn9
 elIPu0pTVcdqO2X+ND+kuhFq897AA9oxX9k6r2cogVoGmj6gPdw7M/kSePQ1wbvv+QWAfz
 phi9fbOk/sSUOYVQK74Wkpd6CjZSqJs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-164-DXc-NskrP9G-YJFv5hV1ZA-1; Thu, 23 Apr 2020 13:21:54 -0400
X-MC-Unique: DXc-NskrP9G-YJFv5hV1ZA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 22F88107ACF4;
 Thu, 23 Apr 2020 17:21:51 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-113-212.ams2.redhat.com
 [10.36.113.212])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 734A55D706;
 Thu, 23 Apr 2020 17:21:49 +0000 (UTC)
Subject: Re: [PATCH] qcow2: Allow resize of images with internal snapshots
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
References: <20200422205355.274706-1-eblake@redhat.com>
 <af50e0f6-3d78-ee51-5540-97fb0fc08f9b@redhat.com>
 <cee813a7-1540-aaa3-b8e1-98dbc84e90ff@redhat.com>
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
Message-ID: <0c3d69a7-9095-9f03-f83a-c527e0751880@redhat.com>
Date: Thu, 23 Apr 2020 19:21:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <cee813a7-1540-aaa3-b8e1-98dbc84e90ff@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="coXljKaW9mM66NppAWVqHQk7Speb679IW"
Received-SPF: pass client-ip=205.139.110.120; envelope-from=mreitz@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/23 05:42:05
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
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
Cc: Kevin Wolf <kwolf@redhat.com>, "open list:qcow2" <qemu-block@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--coXljKaW9mM66NppAWVqHQk7Speb679IW
Content-Type: multipart/mixed; boundary="kSteYWDvuxs7PR0SffDbb16os7OPxVRAK"

--kSteYWDvuxs7PR0SffDbb16os7OPxVRAK
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 23.04.20 16:35, Eric Blake wrote:
> On 4/23/20 8:55 AM, Max Reitz wrote:
>> On 22.04.20 22:53, Eric Blake wrote:
>>> We originally refused to allow resize of images with internal
>>> snapshots because the v2 image format did not require the tracking of
>>> snapshot size, making it impossible to safely revert to a snapshot
>>> with a different size than the current view of the image.=C2=A0 But the
>>> snapshot size tracking was rectified in v3, and our recent fixes to
>>> qemu-img amend (see 0a85af35) guarantee that we always have a valid
>>> snapshot size.=C2=A0 Thus, we no longer need to artificially limit imag=
e
>>> resizes, but it does become one more thing that would prevent a
>>> downgrade back to v2.=C2=A0 And now that we support different-sized
>>> snapshots, it's also easy to fix reverting to a snapshot to apply the
>>> new size.
>>>
>>> Upgrade iotest 61 to cover this (we previously had NO coverage of
>>> refusal to resize while snapshots exist).=C2=A0 Note that the amend pro=
cess
>>> can fail but still have effects: in particular, since we break things
>>> into upgrade, resize, downgrade, if a failure does not happen until a
>>> later phase (such as the downgrade attempt), earlier steps are still
>>> visible (a truncation and downgrade attempt will fail, but only after
>>> truncating data).=C2=A0 But even before this patch, an attempt to upgra=
de
>>> and resize would fail but only after changing the image to v3.=C2=A0 In
>>> some sense, partial image changes on failure are inevitible, since we
>>> can't avoid a mid-change EIO (if you are trying to amend more than one
>>> thing at once, but something fails, I hope you have a backup image).
>>>
>=20
>>> @@ -775,10 +776,22 @@ int qcow2_snapshot_goto(BlockDriverState *bs,
>>> const char *snapshot_id)
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (sn->disk_size !=3D bs->total_sectors=
 * BDRV_SECTOR_SIZE) {
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 error_report("qcow2: Loadin=
g snapshots with different disk "
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "si=
ze is not implemented");
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D -ENOTSUP;
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto fail;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 BlockBackend *blk =3D blk_n=
ew(bdrv_get_aio_context(bs),
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 BLK_PERM=
_RESIZE, BLK_PERM_ALL);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D blk_insert_bs(blk, =
bs, &local_err);
>>
>> I wonder whether maybe we should reintroduce blk_new_with_bs().
>=20
> This code segment is copied from what 'qemu-img amend' does, so adding a
> helper function would indeed make life a bit easier for more than one
> spot in the code base.=C2=A0 Separate patch, obviously.
>=20
>=20
>>> +++ b/block/qcow2.c
>>> @@ -3988,14 +3988,21 @@ static int coroutine_fn
>>> qcow2_co_truncate(BlockDriverState *bs, int64_t offset,
>>>
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 qemu_co_mutex_lock(&s->lock);
>>>
>>> -=C2=A0=C2=A0=C2=A0 /* cannot proceed if image has snapshots */
>>> -=C2=A0=C2=A0=C2=A0 if (s->nb_snapshots) {
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 error_setg(errp, "Can't res=
ize an image which has snapshots");
>>> +=C2=A0=C2=A0=C2=A0 /*
>>> +=C2=A0=C2=A0=C2=A0=C2=A0 * Even though we store snapshot size for all =
images, it was not
>>> +=C2=A0=C2=A0=C2=A0=C2=A0 * required until v3, so it is not safe to pro=
ceed for v2.
>>> +=C2=A0=C2=A0=C2=A0=C2=A0 */
>>> +=C2=A0=C2=A0=C2=A0 if (s->nb_snapshots && s->qcow_version < 3) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 error_setg(errp, "Can't res=
ize a v2 image which has
>>> snapshots");
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D -ENOTSUP=
;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto fail;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>
>>> -=C2=A0=C2=A0=C2=A0 /* cannot proceed if image has bitmaps */
>>> +=C2=A0=C2=A0=C2=A0 /*
>>> +=C2=A0=C2=A0=C2=A0=C2=A0 * For now, it's easier to not proceed if imag=
e has bitmaps, even
>>> +=C2=A0=C2=A0=C2=A0=C2=A0 * though we could resize bitmaps, because it =
is not obvious
>>> +=C2=A0=C2=A0=C2=A0=C2=A0 * whether new bits should be set or clear.
>>
>> The previous comment was incorrect as well, but actually
>> qcow2_truncate_bitmaps_check() doesn=E2=80=99t return an error when ther=
e is any
>> bitmap, but only if there are non-active bitmaps, or active bitmaps that
>> cannot be modified.=C2=A0 So for non-disabled bitmaps, we generally do
>> happily proceed.
>=20
> The comment change is collateral (only because I noticed it in the
> diff); but I could indeed reword it slightly more accurately as:
>=20
> Check if bitmaps prevent a resize.=C2=A0 Although bitmaps can be resized,
> there are situations where we don't know whether to set or clear new
> bits, so for now it's easiest to just prevent resize in those cases.

But I don=E2=80=99t know whether that explanation is actually correct.  I m=
ean,
that would apply for enabled active bitmaps just as well.  But we do
allow resizing an image with such bitmaps so it seems clear that we have
some idea on what to do.  (Or at least we pretend we do, for better or
worse).

(Which is that bdrv_dirty_bitmap_truncate() just calls
hbitmap_truncate(), which fills the new space with zeroes.)

The real reason we can=E2=80=99t resize with certain kinds of bitmaps prese=
nt
seems more like:
(1) There are some bitmaps that can=E2=80=99t be written to, but we=E2=80=
=99d have to if
we wanted to resize the image and they=E2=80=99re persistent,
(2) The second case are bitmaps that are persistent but present in
memory; we just haven=E2=80=99t implemented that case, I presume.

So it seems less like a case of =E2=80=9CWe don=E2=80=99t know what to do=
=E2=80=9D, but more a
combination of =E2=80=9CWe can=E2=80=99t=E2=80=9C and =E2=80=9CWe haven=E2=
=80=98t implemented this case, but
it=E2=80=99s clear what to do if we did=E2=80=9D.

> And since it is a collateral change, it may even be worth splitting into
> a separate patch.
>=20
>>> +++ b/tests/qemu-iotests/061
>>> @@ -111,6 +111,29 @@ $PYTHON qcow2.py "$TEST_IMG" dump-header
>>> =C2=A0 $QEMU_IO -c "read -P 0x2a 42M 64k" "$TEST_IMG" | _filter_qemu_io
>>> =C2=A0 _check_test_img
>>>
>>> +echo
>>> +echo "=3D=3D=3D Testing resize with snapshots =3D=3D=3D"
>>> +echo
>>> +_make_test_img -o "compat=3D0.10" 32M
>>> +$QEMU_IO -c "write -P 0x2a 24M 64k" "$TEST_IMG" | _filter_qemu_io
>>> +$QEMU_IMG snapshot -c foo "$TEST_IMG"
>>> +$QEMU_IMG resize "$TEST_IMG" 64M=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 # fails
>>> +$PYTHON qcow2.py "$TEST_IMG" dump-header
>>
>> What am I looking for in the header dump?
>=20
> I was looking primarily for version (2 vs. 3), size (did it change), and
> number of snapshots.=C2=A0 You're right that grepping for what changes wi=
ll
> make this easier to maintain.
>=20
>=20
>> Also, I personally prefer self-testing tests, because I don=E2=80=99t tr=
ust
>> myself when I have to interpret the reference output on my own...=C2=A0 =
As
>> such, I think it would make sense to not just put those =E2=80=9C# fails=
=E2=80=9D
>> comments here, but an explicit test on $? instead.=C2=A0 (E.g. by
>> =E2=80=9C|| echo ERROR=E2=80=9D, although I can see that would be weird =
in the
>> expected-failure case as =E2=80=9C&& echo ERROR=E2=80=9D.)
>=20
> Good idea.
>=20
>>
>>> +$QEMU_IMG snapshot -c bar "$TEST_IMG"
>>> +$QEMU_IMG resize --shrink "$TEST_IMG" 64M=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 # succeeds
>>> +$PYTHON qcow2.py "$TEST_IMG" dump-header
>>> +$QEMU_IMG amend -o "compat=3D0.10,size=3D32M" "$TEST_IMG"=C2=A0=C2=A0=
=C2=A0 # fails,
>>> image left v3
>>> +$PYTHON qcow2.py "$TEST_IMG" dump-header
>>
>> Again, a grep for the image size would help focus the reference output.
>>
>> (In addition, _img_info would give us snapshot information.=C2=A0 Might =
be
>> interesting.=C2=A0 So maybe the best thing would be to grep the image
>> version, image size, and snapshot list from the image info every time.)
>=20
> Yep, that's the same list I was noticing when writing the patch.
>=20
>>
>> Speaking of the image size.=C2=A0 Is it intentional that the size is cha=
nged
>> to 32 MB?=C2=A0 Should amend work more like a transaction, in that we sh=
ould
>> at least do a loose check on whether the options can be changed before
>> we touch the image?
>=20
> Yes, the commit message tried to call it out.=C2=A0 It's a pre-existing
> problem - during amend, we DO make changes to the disk in one step, with
> no way to roll back those changes, even if a later step fails.
>=20
> Pre-patch, if you request an upgrade to v3 as well as a resize, but
> resize fails, you still end up with the image being changed to v3.
> That's no different from post-patch where if you request a resize and a
> downgrade to v2, the resize happens but not the downgrade.=C2=A0 On the
> bright side, our current failure scenarios at least leave the resulting
> image viable, even if it is not the same as it was pre-attempt.

Yes.  OK.

>> Also, there=E2=80=99s a problem of ordering here.=C2=A0 The command as y=
ou=E2=80=99ve written
>> doesn=E2=80=99t have this specific problem, but imagine the size was sti=
ll 128
>> MB before (just like the snapshot).=C2=A0 Then what the command does dep=
ends
>> on the order in which the operations are executed: If we change the
>> version first, the size cannot be changed because of the internal
>> snapshot.=C2=A0 If we change the size first, the version can no longer b=
e
>> changed because the internal snapshot has a different size than the
>> image.
>=20
> Yes, it was a pain for me while writing the tests.=C2=A0 At one point I e=
ven
> considered swapping things to do the resize after the downgrade, but
> that introduces a different problem: the downgrade depends on knowing
> the post-transaction size (because downgrading is safe only when all
> internal snapshots match the post-resize length), but we aren't passing
> the desired size through to the upgrade and downgrade functions.=C2=A0 Wo=
rse,
> if we swap the downgrade first, and it succeeds but then resize fails,
> the image is no longer viable; at least with the current ordering, even
> though user data has been truncated, it remains v3 so the size
> differences in snapshots don't break the image (and the user DID request
> an image resize, so it's not like we are discarding data accidentally).
>=20
> If we want to avoid truncating an image at all costs on any potential
> failure path, we have to add a lot more plumbing (not to say it's a bad
> thing, just that it's more work).=C2=A0 And no matter how much plumbing w=
e
> add, or transaction-like rollback capabilities we add, there's still the
> risk that we will hit a late EIO error leaving the image in a
> half-changed state, even if none of our sanity checks failed.=C2=A0 Or pu=
t
> another way, without some sort of journaling, the best we can do is
> defer all writes until we know the full set of changes, which limits the
> likelihood of a half-baked change to a write failure.=C2=A0 But since we =
can
> only reduce, and not eliminate, the possibility of a half-baked change,
> the question then becomes whether it is worth the engineering effort of
> additional complexity for even more corner cases and less risk, or just
> leave things as they are (if qemu-img amend fails, we make no guarantees
> about the state of your image).

Yeah.  I don=E2=80=99t think anyone even would have realistic use for
transactional amends.  I suppose all users can easily split their amend
calls with multiple options into multiple amends in the order that would
be most likely reversible, if something went wrong along the way.  (And
that also works.  I.e., downgrading/upgrading is probably the most easy
to revert, but maybe you can only downgrade if your image has the
correct size, so you potentially need to truncate it first.  OTOH, I
can=E2=80=99t imagine many people actually use qemu-img amend to downgrade =
qcow2
images anyway...)

>> (Hypothetical problems that turn out not to be any in practice:
>>
>> Or, maybe more interesting: What if we try to amend to
>> compat=3D0.10,size=3D128M here?
>>
>> If the size is changed first, the command will succeed, because then the
>> snapshot size matches the image size again.=C2=A0 If qemu-img attempts t=
o
>> change the version first, the whole command will fail.
>>
>> As I noted above, the size is indeed changed before the version (hence
>> us getting a 32 MB v3 image here), so the compat=3D0.10,size=3D128M amen=
d
>> would indeed succeed.=C2=A0 But that=E2=80=99s luck.
>>
>> OTOH, that means that if you have a v2 image with a snapshot and want to
>> make it a v3 image and resize it at the same time, that would fail by
>> the same logic, because the size cannot be changed for v2 images.=C2=A0 =
So
>> for that case it=E2=80=99d be bad luck.
>>
>> But we always upgrade an image first in the amend process and downgrade
>> it last, to address specifically such cases: Allow adding new features
>> along with the upgrade, and strip unsupported features right before the
>> downgrade.=C2=A0 So that=E2=80=99s all good.=C2=A0 But I think it still =
shows that the
>> dependencies are getting a bit hairy.)
>=20
> I'm not sure the work in making amend more transaction-like is worth it
> - yes, we can add more validation code up front before making the first
> write change, but as some of the later changes depend on information
> that would be changed earlier, that becomes a lot more state we have to
> collect during our initial probes

I agree, but to me that seems to suggest that it might not be ideal to
consider the amend interface a =E2=80=9CThis is a description of the post-a=
mend
state I want=E2=80=9D interface, because implementing that correctly seems =
to be
very complicated.  The alternative would be =E2=80=9CThis is a description =
of
what I want to change=E2=80=9D, and you can give multiple things at once, b=
ut
there is no guarantee of whether that works or not.

I feel very much reminded of the LUKS keyslot discussion...

(That is to say, my thoughts on this have little to do with this
specific patch at this point.)

Max


--kSteYWDvuxs7PR0SffDbb16os7OPxVRAK--

--coXljKaW9mM66NppAWVqHQk7Speb679IW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl6hzqsACgkQ9AfbAGHV
z0ACUAgAqLzUsv/tUV9drsmKmsnQB9mWHsc9WaU7RCLNdECxM4JaxDsMNDDy/4fv
VL7nJiyxXnruyjAtcZlHQkvCOLwS4VJUW1xLBV1djBBc/QTjXYZP+tSQl2X2zBKb
dsYW/9ygftPGWj3kNpU0/aGHOMeU3XTPbH9CCsZshQJ6hQ6UBDThH422gLXNJFaC
ieDZwtlkwjjGRN0t4i4SrgN/CjjeB8uNeLl+77/ZFc+0F3fWC/Sw+yQqqkwnnkPx
BizIwhr/gd2HGarA8+2nHM3PTCqxKslvXmQO46ohohV5q34kYSxrYqXSc+Gyh5bv
MxOjh6N9xYva/nY+/zV7XRrg9JGMwQ==
=UcCT
-----END PGP SIGNATURE-----

--coXljKaW9mM66NppAWVqHQk7Speb679IW--


