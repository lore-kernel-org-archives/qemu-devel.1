Return-Path: <SRS0=e3er=AV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59B17C433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 15:25:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 151AF20720
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 15:25:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KpelBSH1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 151AF20720
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55292 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtutt-0006hD-AM
	for qemu-devel@archiver.kernel.org; Fri, 10 Jul 2020 11:25:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56508)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jtut3-0005gh-Fk
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 11:24:29 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:34853
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jtut1-0004jC-7w
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 11:24:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594394665;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=Fo+kfY8phiHhNzZbx9QvUT5Ew4X71yABJimvv44+rCE=;
 b=KpelBSH1u2MdVvBYo8gKyuXrbA+BdDxjdJY9kS4aEQYgLsyZdeA2V2SKZQxzuP3Fon7EZb
 lFC3e7GI/ZdY46y69UpCuyDQVyP9XrZ/3/ogdR22ybopX4XrauHEoOI3dtNDmBlPNLZn9s
 E9RrY4zyDuVXDn14CFz6Zzpvw0JEp3g=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-450-QtL0QMe7Mk2ItbiWD2iKQQ-1; Fri, 10 Jul 2020 11:24:23 -0400
X-MC-Unique: QtL0QMe7Mk2ItbiWD2iKQQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5FA41100CCC0;
 Fri, 10 Jul 2020 15:24:22 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-113-127.ams2.redhat.com
 [10.36.113.127])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 055425D9EF;
 Fri, 10 Jul 2020 15:24:20 +0000 (UTC)
Subject: Re: [PATCH v7 14/47] stream: Deal with filters
To: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>, qemu-block@nongnu.org
References: <20200625152215.941773-1-mreitz@redhat.com>
 <20200625152215.941773-15-mreitz@redhat.com>
 <ed502f80-f4a2-bfb8-7395-5842f8103991@virtuozzo.com>
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
Message-ID: <63ad2152-3861-1f9f-1bb9-1c14fd68cfbd@redhat.com>
Date: Fri, 10 Jul 2020 17:24:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <ed502f80-f4a2-bfb8-7395-5842f8103991@virtuozzo.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="JSYgP1lqE3wvsphKi39Ri95XB6TcxIQyD"
Received-SPF: pass client-ip=205.139.110.120; envelope-from=mreitz@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/10 04:36:30
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--JSYgP1lqE3wvsphKi39Ri95XB6TcxIQyD
Content-Type: multipart/mixed; boundary="2MKmjT0Ndq5qyfUMWTdgbQalst3qlUHHh"

--2MKmjT0Ndq5qyfUMWTdgbQalst3qlUHHh
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 09.07.20 16:52, Andrey Shinkevich wrote:
> On 25.06.2020 18:21, Max Reitz wrote:
>> Because of the (not so recent anymore) changes that make the stream job
>> independent of the base node and instead track the node above it, we
>> have to split that "bottom" node into two cases: The bottom COW node,
>> and the node directly above the base node (which may be an R/W filter
>> or the bottom COW node).
>>
>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>> ---
>> =C2=A0 qapi/block-core.json |=C2=A0 4 +++
>> =C2=A0 block/stream.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 63 +++++++++=
+++++++++++++++++++++++------------
>> =C2=A0 blockdev.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 |=C2=A0 4 ++-
>> =C2=A0 3 files changed, 53 insertions(+), 18 deletions(-)
>>
>> diff --git a/qapi/block-core.json b/qapi/block-core.json
>> index b20332e592..df87855429 100644
>> --- a/qapi/block-core.json
>> +++ b/qapi/block-core.json
>> @@ -2486,6 +2486,10 @@
>> =C2=A0 # On successful completion the image file is updated to drop the
>> backing file
>> =C2=A0 # and the BLOCK_JOB_COMPLETED event is emitted.
>> =C2=A0 #
>> +# In case @device is a filter node, block-stream modifies the first
>> non-filter
>> +# overlay node below it to point to base's backing node (or NULL if
>> @base was
>> +# not specified) instead of modifying @device itself.
>> +#
>> =C2=A0 # @job-id: identifier for the newly-created block job. If
>> =C2=A0 #=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 omitted, =
the device name will be used. (Since 2.7)
>> =C2=A0 #
>> diff --git a/block/stream.c b/block/stream.c
>> index aa2e7af98e..b9c1141656 100644
>> --- a/block/stream.c
>> +++ b/block/stream.c
>> @@ -31,7 +31,8 @@ enum {
>> =C2=A0 =C2=A0 typedef struct StreamBlockJob {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 BlockJob common;
>> -=C2=A0=C2=A0=C2=A0 BlockDriverState *bottom;
>> +=C2=A0=C2=A0=C2=A0 BlockDriverState *base_overlay; /* COW overlay (stre=
am from this) */
>> +=C2=A0=C2=A0=C2=A0 BlockDriverState *above_base;=C2=A0=C2=A0 /* Node di=
rectly above the base */
>=20
> Keeping the base_overlay is enough to complete the stream job.

Depends on the definition.  If we decide it isn=E2=80=99t enough, then it i=
sn=E2=80=99t
enough.

> The above_base may disappear during the job and we can't rely on it.

In this version of this series, it may not, because the chain is frozen.
 So the above_base cannot disappear.

We can discuss whether we should allow it to disappear, but I think not.

The problem is, we need something to set as the backing file after
streaming.  How do we figure out what that should be?  My proposal is we
keep above_base and use its immediate child.

If we don=E2=80=99t keep above_base, then we=E2=80=99re basically left gues=
sing as to
what should be the backing file after the stream job.

>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 BlockdevOnError on_error;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 char *backing_file_str;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bool bs_read_only;
>> @@ -53,7 +54,7 @@ static void stream_abort(Job *job)
>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (s->chain_frozen) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 BlockJob *bjob =
=3D &s->common;
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bdrv_unfreeze_backing_chain(=
blk_bs(bjob->blk), s->bottom);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bdrv_unfreeze_backing_chain(=
blk_bs(bjob->blk), s->above_base);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> =C2=A0 }
>> =C2=A0 @@ -62,14 +63,15 @@ static int stream_prepare(Job *job)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 StreamBlockJob *s =3D container_of(job, S=
treamBlockJob, common.job);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 BlockJob *bjob =3D &s->common;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 BlockDriverState *bs =3D blk_bs(bjob->blk=
);
>> -=C2=A0=C2=A0=C2=A0 BlockDriverState *base =3D backing_bs(s->bottom);
>> +=C2=A0=C2=A0=C2=A0 BlockDriverState *unfiltered_bs =3D bdrv_skip_filter=
s(bs);
>> +=C2=A0=C2=A0=C2=A0 BlockDriverState *base =3D bdrv_filter_or_cow_bs(s->=
above_base);
>=20
> The initial base node may be a top node for a concurrent commit job and
>=20
> may disappear.
Then it would just be replaced by another node, though, so above_base
keeps a child.  The @base here is not necessarily the initial @base, and
that=E2=80=99s intentional.

> base =3D bdrv_filter_or_cow_bs(s->base_overlay) is more reliable.

But also wrong.  The point of keeping above_base around is to get its
child here to use that child as the new backing child of the top node.

>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Error *local_err =3D NULL;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int ret =3D 0;
>> =C2=A0 -=C2=A0=C2=A0=C2=A0 bdrv_unfreeze_backing_chain(bs, s->bottom);
>> +=C2=A0=C2=A0=C2=A0 bdrv_unfreeze_backing_chain(bs, s->above_base);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 s->chain_frozen =3D false;
>> =C2=A0 -=C2=A0=C2=A0=C2=A0 if (bs->backing) {
>> +=C2=A0=C2=A0=C2=A0 if (bdrv_cow_child(unfiltered_bs)) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const char *base_=
id =3D NULL, *base_fmt =3D NULL;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (base) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 base_id =3D s->backing_file_str;
>> @@ -77,8 +79,8 @@ static int stream_prepare(Job *job)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 base_fmt =3D base->drv->format_name;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 }
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bdrv_set_backing_hd(bs, base=
, &local_err);
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D bdrv_change_backing_=
file(bs, base_id, base_fmt);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bdrv_set_backing_hd(unfilter=
ed_bs, base, &local_err);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D bdrv_change_backing_=
file(unfiltered_bs, base_id,
>> base_fmt);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (local_err) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 error_report_err(local_err);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 return -EPERM;
>> @@ -109,14 +111,15 @@ static int coroutine_fn stream_run(Job *job,
>> Error **errp)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 StreamBlockJob *s =3D container_of(job, S=
treamBlockJob, common.job);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 BlockBackend *blk =3D s->common.blk;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 BlockDriverState *bs =3D blk_bs(blk);
>> -=C2=A0=C2=A0=C2=A0 bool enable_cor =3D !backing_bs(s->bottom);
>> +=C2=A0=C2=A0=C2=A0 BlockDriverState *unfiltered_bs =3D bdrv_skip_filter=
s(bs);
>> +=C2=A0=C2=A0=C2=A0 bool enable_cor =3D !bdrv_cow_child(s->base_overlay)=
;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int64_t len;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int64_t offset =3D 0;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uint64_t delay_ns =3D 0;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int error =3D 0;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int64_t n =3D 0; /* bytes */
>> =C2=A0 -=C2=A0=C2=A0=C2=A0 if (bs =3D=3D s->bottom) {
>> +=C2=A0=C2=A0=C2=A0 if (unfiltered_bs =3D=3D s->base_overlay) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Nothing to str=
eam */
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> @@ -150,13 +153,14 @@ static int coroutine_fn stream_run(Job *job,
>> Error **errp)
>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 copy =3D f=
alse;
>> =C2=A0 -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D bdrv_is_alloc=
ated(bs, offset, STREAM_CHUNK, &n);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D bdrv_is_allocated(un=
filtered_bs, offset, STREAM_CHUNK,
>> &n);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ret =3D=3D 1)=
 {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 /* Allocated in the top, no need to copy.=C2=A0 */
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } else if (ret >=
=3D 0) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 /* Copy if allocated in the intermediate images.=C2=A0 Limit
>> to the
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 * known-unallocated area [offset,
>> offset+n*BDRV_SECTOR_SIZE).=C2=A0 */
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =
=3D bdrv_is_allocated_above(backing_bs(bs), s->bottom,
>> true,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =
=3D bdrv_is_allocated_above(bdrv_cow_bs(unfiltered_bs),
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 s->base_overlay, true,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 offset, n, &n);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 /* Finish early if end of backing file has been reached */
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 if (ret =3D=3D 0 && n =3D=3D 0) {
>> @@ -223,9 +227,29 @@ void stream_start(const char *job_id,
>> BlockDriverState *bs,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 BlockDriverState *iter;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bool bs_read_only;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int basic_flags =3D BLK_PERM_CONSISTENT_R=
EAD |
>> BLK_PERM_WRITE_UNCHANGED;
>> -=C2=A0=C2=A0=C2=A0 BlockDriverState *bottom =3D bdrv_find_overlay(bs, b=
ase);
>> +=C2=A0=C2=A0=C2=A0 BlockDriverState *base_overlay =3D bdrv_find_overlay=
(bs, base);
>> +=C2=A0=C2=A0=C2=A0 BlockDriverState *above_base;
>> =C2=A0 -=C2=A0=C2=A0=C2=A0 if (bdrv_freeze_backing_chain(bs, bottom, err=
p) < 0) {
>> +=C2=A0=C2=A0=C2=A0 if (!base_overlay) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 error_setg(errp, "'%s' is no=
t in the backing chain of '%s'",
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 base->node_name, bs->node_name);
>=20
> Sorry, I am not clear with the error message.
>=20
> In this case, there is no an intermediate COW node but the base, if not
> NULL, is
>=20
> in the backing chain of bs, isn't it?
>=20
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return;
>> +=C2=A0=C2=A0=C2=A0 }
>> +
>> +=C2=A0=C2=A0=C2=A0 /*
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * Find the node directly above @base.=C2=A0 @b=
ase_overlay is a COW
>> overlay, so
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * it must have a bdrv_cow_child(), but it is t=
he immediate
>> overlay of
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * @base, so between the two there can only be =
filters.
>> +=C2=A0=C2=A0=C2=A0=C2=A0 */
>> +=C2=A0=C2=A0=C2=A0 above_base =3D base_overlay;
>> +=C2=A0=C2=A0=C2=A0 if (bdrv_cow_bs(above_base) !=3D base) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 above_base =3D bdrv_cow_bs(a=
bove_base);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 while (bdrv_filter_bs(above_=
base) !=3D base) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 abov=
e_base =3D bdrv_filter_bs(above_base);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> +=C2=A0=C2=A0=C2=A0 }
>> +
>> +=C2=A0=C2=A0=C2=A0 if (bdrv_freeze_backing_chain(bs, above_base, errp) =
< 0) {
>=20
> When a concurrent stream job tries to freeze or remove the above_base nod=
e,
>=20
> we will encounter the frozen node error. The above_base node is a part
> of the
>=20
> concurrent job frozen chain.

Correct.

>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> =C2=A0 @@ -255,14 +279,19 @@ void stream_start(const char *job_id,
>> BlockDriverState *bs,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * and resizes. Reassign the base no=
de pointer because the
>> backing BS of the
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * bottom node might change after th=
e call to
>> bdrv_reopen_set_read_only()
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * due to parallel block jobs runnin=
g.
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * above_base node might change after the call =
to
> Yes, if not frozen.
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * bdrv_reopen_set_read_only() due to parallel =
block jobs running.
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
>> -=C2=A0=C2=A0=C2=A0 base =3D backing_bs(bottom);
>> -=C2=A0=C2=A0=C2=A0 for (iter =3D backing_bs(bs); iter && iter !=3D base=
; iter =3D
>> backing_bs(iter)) {
>> +=C2=A0=C2=A0=C2=A0 base =3D bdrv_filter_or_cow_bs(above_base);
>> +=C2=A0=C2=A0=C2=A0 for (iter =3D bdrv_filter_or_cow_bs(bs); iter !=3D b=
ase;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 iter =3D bdrv_filter_o=
r_cow_bs(iter))
>> +=C2=A0=C2=A0=C2=A0 {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 block_job_add_bdr=
v(&s->common, "intermediate node", iter, 0,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 basic_flags, &error_abort);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> =C2=A0 -=C2=A0=C2=A0=C2=A0 s->bottom =3D bottom;
>> +=C2=A0=C2=A0=C2=A0 s->base_overlay =3D base_overlay;
>> +=C2=A0=C2=A0=C2=A0 s->above_base =3D above_base;
>=20
> Generally, being the filter for a concurrent job, the above_base node
> may be deleted any time
>=20
> and we will keep the dangling pointer. It may happen even earlier if
> above_base is not frozen.
>=20
> If it is, as it here, we may get the frozen link error then.

I=E2=80=99m not sure what you mean here.  Freezing it was absolutely
intentional.  A dangling pointer would be a problem, but that=E2=80=99s why=
 it=E2=80=99s
frozen, so it stays around and can=E2=80=99t be deleted any time.

Max


--2MKmjT0Ndq5qyfUMWTdgbQalst3qlUHHh--

--JSYgP1lqE3wvsphKi39Ri95XB6TcxIQyD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl8IiCMACgkQ9AfbAGHV
z0B95Af8DFwRgQqeupX+ThzsFeWVefdWWfa7RQ519iRmx5iVxa8J2oZEUoP4qZon
5O/5xmQH8flgTceU+dMeJjOMXYJETF1+RAgFbN0PwcOpbY2rXqv+cpAvzaApwc4G
Aid6R17C1NsyD5aAXqFfysdWfxJtDv4rC3GMq6uaeSBL7Toy8dNRJjs4u+DLHHs+
snO35HFLNkYsWuoj3c+C8DIx3i0696GS9vvEwvpqMQQF0cUiRLrTTgh2uMHIOz3h
jYfUvcycgeT26eUbjftlCh5iGE1fn6VmvVftdc4oOCk9ypgC38YPGZgaU371HRQ2
0y+9H1qsNSi/6rd6WDPT0+6gwXcJTg==
=nCOr
-----END PGP SIGNATURE-----

--JSYgP1lqE3wvsphKi39Ri95XB6TcxIQyD--


