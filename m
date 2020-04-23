Return-Path: <SRS0=5yua=6H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2E6BC54FCB
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2020 13:56:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 53F0320728
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2020 13:56:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hruec9gq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53F0320728
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43942 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRcLH-0003Gr-In
	for qemu-devel@archiver.kernel.org; Thu, 23 Apr 2020 09:56:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48974)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1jRcK2-0001xE-1O
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 09:55:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1jRcK0-0006hg-DW
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 09:55:21 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:21314
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jRcJz-0006h5-T9
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 09:55:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587650118;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=WLVf62kfqwDydjVGHFF5Z9Hq32vvaIRzqZ1HwrAgtvI=;
 b=hruec9gq680HvC+ITDoWVHukj4weLwObLjMTrLAv/JImMDBJcf0pT+CmElqTArBx6yEdO2
 JwRnNkO95KNo9goOuotBcv5t0ItLCXcOGyr6CDu3IB65GiM/PeRnGAyXbs/hLH9Yno9Ie0
 cQyO1nD4xYHSGR6dqyuOOt9maOIrTh0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-413-4pCfYXqMPKqt-rALxXwmvA-1; Thu, 23 Apr 2020 09:55:14 -0400
X-MC-Unique: 4pCfYXqMPKqt-rALxXwmvA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9720291165;
 Thu, 23 Apr 2020 13:55:13 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-113-212.ams2.redhat.com
 [10.36.113.212])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id EF5115C1BD;
 Thu, 23 Apr 2020 13:55:11 +0000 (UTC)
Subject: Re: [PATCH] qcow2: Allow resize of images with internal snapshots
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
References: <20200422205355.274706-1-eblake@redhat.com>
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
Message-ID: <af50e0f6-3d78-ee51-5540-97fb0fc08f9b@redhat.com>
Date: Thu, 23 Apr 2020 15:55:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200422205355.274706-1-eblake@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="yjbxVrXAkgl6EGArlBmZcxzzrjkIT2iX1"
Received-SPF: pass client-ip=207.211.31.81; envelope-from=mreitz@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/23 02:14:02
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
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
Cc: Kevin Wolf <kwolf@redhat.com>, "open list:qcow2" <qemu-block@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--yjbxVrXAkgl6EGArlBmZcxzzrjkIT2iX1
Content-Type: multipart/mixed; boundary="30HUHPKbwetdiQ9n4J2txS9xpcInAXDh8"

--30HUHPKbwetdiQ9n4J2txS9xpcInAXDh8
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 22.04.20 22:53, Eric Blake wrote:
> We originally refused to allow resize of images with internal
> snapshots because the v2 image format did not require the tracking of
> snapshot size, making it impossible to safely revert to a snapshot
> with a different size than the current view of the image.  But the
> snapshot size tracking was rectified in v3, and our recent fixes to
> qemu-img amend (see 0a85af35) guarantee that we always have a valid
> snapshot size.  Thus, we no longer need to artificially limit image
> resizes, but it does become one more thing that would prevent a
> downgrade back to v2.  And now that we support different-sized
> snapshots, it's also easy to fix reverting to a snapshot to apply the
> new size.
>=20
> Upgrade iotest 61 to cover this (we previously had NO coverage of
> refusal to resize while snapshots exist).  Note that the amend process
> can fail but still have effects: in particular, since we break things
> into upgrade, resize, downgrade, if a failure does not happen until a
> later phase (such as the downgrade attempt), earlier steps are still
> visible (a truncation and downgrade attempt will fail, but only after
> truncating data).  But even before this patch, an attempt to upgrade
> and resize would fail but only after changing the image to v3.  In
> some sense, partial image changes on failure are inevitible, since we
> can't avoid a mid-change EIO (if you are trying to amend more than one
> thing at once, but something fails, I hope you have a backup image).
>=20
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---
>  block/qcow2-snapshot.c     |  21 ++++--
>  block/qcow2.c              |  31 ++++++--
>  tests/qemu-iotests/061     |  23 ++++++
>  tests/qemu-iotests/061.out | 144 +++++++++++++++++++++++++++++++++++++
>  4 files changed, 211 insertions(+), 8 deletions(-)
>=20
> diff --git a/block/qcow2-snapshot.c b/block/qcow2-snapshot.c
> index 82c32d4c9b08..3f9e48738d0b 100644
> --- a/block/qcow2-snapshot.c
> +++ b/block/qcow2-snapshot.c
> @@ -23,6 +23,7 @@
>   */
>=20
>  #include "qemu/osdep.h"
> +#include "sysemu/block-backend.h"
>  #include "qapi/error.h"
>  #include "qcow2.h"
>  #include "qemu/bswap.h"
> @@ -775,10 +776,22 @@ int qcow2_snapshot_goto(BlockDriverState *bs, const=
 char *snapshot_id)
>      }
>=20
>      if (sn->disk_size !=3D bs->total_sectors * BDRV_SECTOR_SIZE) {
> -        error_report("qcow2: Loading snapshots with different disk "
> -            "size is not implemented");
> -        ret =3D -ENOTSUP;
> -        goto fail;
> +        BlockBackend *blk =3D blk_new(bdrv_get_aio_context(bs),
> +                                    BLK_PERM_RESIZE, BLK_PERM_ALL);
> +        ret =3D blk_insert_bs(blk, bs, &local_err);

I wonder whether maybe we should reintroduce blk_new_with_bs().

> +        if (ret < 0) {
> +            blk_unref(blk);
> +            error_report_err(local_err);
> +            goto fail;
> +        }
> +
> +        ret =3D blk_truncate(blk, sn->disk_size, true, PREALLOC_MODE_OFF=
,
> +                           &local_err);
> +        blk_unref(blk);
> +        if (ret < 0) {
> +            error_report_err(local_err);
> +            goto fail;
> +        }
>      }
>=20
>      /*

Looks good.

> diff --git a/block/qcow2.c b/block/qcow2.c
> index b524b0c53f84..29047c33b7e5 100644
> --- a/block/qcow2.c
> +++ b/block/qcow2.c
> @@ -3988,14 +3988,21 @@ static int coroutine_fn qcow2_co_truncate(BlockDr=
iverState *bs, int64_t offset,
>=20
>      qemu_co_mutex_lock(&s->lock);
>=20
> -    /* cannot proceed if image has snapshots */
> -    if (s->nb_snapshots) {
> -        error_setg(errp, "Can't resize an image which has snapshots");
> +    /*
> +     * Even though we store snapshot size for all images, it was not
> +     * required until v3, so it is not safe to proceed for v2.
> +     */
> +    if (s->nb_snapshots && s->qcow_version < 3) {
> +        error_setg(errp, "Can't resize a v2 image which has snapshots");
>          ret =3D -ENOTSUP;
>          goto fail;
>      }
>=20
> -    /* cannot proceed if image has bitmaps */
> +    /*
> +     * For now, it's easier to not proceed if image has bitmaps, even
> +     * though we could resize bitmaps, because it is not obvious
> +     * whether new bits should be set or clear.

The previous comment was incorrect as well, but actually
qcow2_truncate_bitmaps_check() doesn=E2=80=99t return an error when there i=
s any
bitmap, but only if there are non-active bitmaps, or active bitmaps that
cannot be modified.  So for non-disabled bitmaps, we generally do
happily proceed.

> +     */
>      if (qcow2_truncate_bitmaps_check(bs, errp)) {
>          ret =3D -ENOTSUP;
>          goto fail;

[...]

> diff --git a/tests/qemu-iotests/061 b/tests/qemu-iotests/061
> index ce285d308408..fdfb8fab5fb6 100755
> --- a/tests/qemu-iotests/061
> +++ b/tests/qemu-iotests/061
> @@ -111,6 +111,29 @@ $PYTHON qcow2.py "$TEST_IMG" dump-header
>  $QEMU_IO -c "read -P 0x2a 42M 64k" "$TEST_IMG" | _filter_qemu_io
>  _check_test_img
>=20
> +echo
> +echo "=3D=3D=3D Testing resize with snapshots =3D=3D=3D"
> +echo
> +_make_test_img -o "compat=3D0.10" 32M
> +$QEMU_IO -c "write -P 0x2a 24M 64k" "$TEST_IMG" | _filter_qemu_io
> +$QEMU_IMG snapshot -c foo "$TEST_IMG"
> +$QEMU_IMG resize "$TEST_IMG" 64M                         # fails
> +$PYTHON qcow2.py "$TEST_IMG" dump-header

What am I looking for in the header dump?

> +$QEMU_IMG amend -o "compat=3D1.1,size=3D128M" "$TEST_IMG"    # succeeds
> +$PYTHON qcow2.py "$TEST_IMG" dump-header

The v2 -> v3 change?  I think a _img_info (| grep compat) would be
better suited (or just a =E2=80=9C$QEMU_IMG amend ... || echo ERROR=E2=80=
=9D).

(I don=E2=80=99t like changing that many dump-header outputs whenever the
header_length or the feature table length change for some reason.)

Also, I personally prefer self-testing tests, because I don=E2=80=99t trust
myself when I have to interpret the reference output on my own...  As
such, I think it would make sense to not just put those =E2=80=9C# fails=E2=
=80=9D
comments here, but an explicit test on $? instead.  (E.g. by
=E2=80=9C|| echo ERROR=E2=80=9D, although I can see that would be weird in =
the
expected-failure case as =E2=80=9C&& echo ERROR=E2=80=9D.)

> +$QEMU_IMG snapshot -c bar "$TEST_IMG"
> +$QEMU_IMG resize --shrink "$TEST_IMG" 64M                # succeeds
> +$PYTHON qcow2.py "$TEST_IMG" dump-header
> +$QEMU_IMG amend -o "compat=3D0.10,size=3D32M" "$TEST_IMG"    # fails, im=
age left v3
> +$PYTHON qcow2.py "$TEST_IMG" dump-header

Again, a grep for the image size would help focus the reference output.

(In addition, _img_info would give us snapshot information.  Might be
interesting.  So maybe the best thing would be to grep the image
version, image size, and snapshot list from the image info every time.)

Speaking of the image size.  Is it intentional that the size is changed
to 32 MB?  Should amend work more like a transaction, in that we should
at least do a loose check on whether the options can be changed before
we touch the image?

Also, there=E2=80=99s a problem of ordering here.  The command as you=E2=80=
=99ve written
doesn=E2=80=99t have this specific problem, but imagine the size was still =
128
MB before (just like the snapshot).  Then what the command does depends
on the order in which the operations are executed: If we change the
version first, the size cannot be changed because of the internal
snapshot.  If we change the size first, the version can no longer be
changed because the internal snapshot has a different size than the image.


(Hypothetical problems that turn out not to be any in practice:

Or, maybe more interesting: What if we try to amend to
compat=3D0.10,size=3D128M here?

If the size is changed first, the command will succeed, because then the
snapshot size matches the image size again.  If qemu-img attempts to
change the version first, the whole command will fail.

As I noted above, the size is indeed changed before the version (hence
us getting a 32 MB v3 image here), so the compat=3D0.10,size=3D128M amend
would indeed succeed.  But that=E2=80=99s luck.

OTOH, that means that if you have a v2 image with a snapshot and want to
make it a v3 image and resize it at the same time, that would fail by
the same logic, because the size cannot be changed for v2 images.  So
for that case it=E2=80=99d be bad luck.

But we always upgrade an image first in the amend process and downgrade
it last, to address specifically such cases: Allow adding new features
along with the upgrade, and strip unsupported features right before the
downgrade.  So that=E2=80=99s all good.  But I think it still shows that th=
e
dependencies are getting a bit hairy.)

Max


--30HUHPKbwetdiQ9n4J2txS9xpcInAXDh8--

--yjbxVrXAkgl6EGArlBmZcxzzrjkIT2iX1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl6hnj0ACgkQ9AfbAGHV
z0BY2gf6AtO8F1vmiKF0QK/87aGlUQJssP1sctcqEVg/fzcLVSMyEA1bADeO980S
qCEiwljXSJP9X68a41p16crA09SyzrPcHVZTy/gKNHhZy7/Hs4y1ZdBCY1u8LoER
SWAoO3nb6sbN5jUYLwYok97GYt403L6o0P7LRkd1LRjfSPxKFoxzAgPAecKCckZF
WXASGsQ08jaCkH8tzbQZGYYx49llVccPUG6/tED7XCtw1UzbzfZe+TPjNzC/94qR
B7WgpMIh6MxmVLYQrZPTOAPDYJ1vqqMUDc/wjdRzzfQztfhhIFg3hic8XcMCezjG
SPisVmGF/Q1CcSkrLE+zwhwnBkB7Ew==
=89NS
-----END PGP SIGNATURE-----

--yjbxVrXAkgl6EGArlBmZcxzzrjkIT2iX1--


