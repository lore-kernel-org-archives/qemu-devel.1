Return-Path: <SRS0=yzMV=5B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 362BDC18E5B
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 18:19:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E435520409
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 18:19:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LNHmCrBD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E435520409
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45608 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDuKZ-0000Eb-4O
	for qemu-devel@archiver.kernel.org; Mon, 16 Mar 2020 14:19:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51586)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jsnow@redhat.com>) id 1jDtwM-0000Rs-PN
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 13:54:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jsnow@redhat.com>) id 1jDtwL-0005km-54
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 13:54:14 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:54740)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jsnow@redhat.com>) id 1jDtwK-0005f0-VK
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 13:54:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584381252;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=pIqotPpMyi0cFIni40cTyy6gkpYnI+f9mncOyL/UKXg=;
 b=LNHmCrBDaL7vCu0lcK0eFr/OkxHU3gB5/cUbm22hGHfYyoElTj9InGz+53p7vO5Vp1Nzrn
 jSzmIBSFFexQSVZGd37lNt6zyYwg22jK84agC7WyTOTUJYUoDj3VRtIcCHohugFxTDuiOh
 TVfpVAKcClXiMNrnWKBeM6eH3T6tNdg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-336-7sOiVYJiN1iSKe5Ir4qO2A-1; Mon, 16 Mar 2020 13:54:10 -0400
X-MC-Unique: 7sOiVYJiN1iSKe5Ir4qO2A-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 795D09250DF;
 Mon, 16 Mar 2020 17:37:41 +0000 (UTC)
Received: from [10.10.125.118] (ovpn-125-118.rdu2.redhat.com [10.10.125.118])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 364DB5D9E2;
 Mon, 16 Mar 2020 17:37:39 +0000 (UTC)
Subject: Re: [PATCH 1/2] block: bdrv_set_backing_bs: fix use-after-free
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org
References: <20200316060631.30052-1-vsementsov@virtuozzo.com>
 <20200316060631.30052-2-vsementsov@virtuozzo.com>
 <db91173b-f485-b70f-01c1-4087298d4ec9@redhat.com>
From: John Snow <jsnow@redhat.com>
Autocrypt: addr=jsnow@redhat.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <f1ada90b-3dcd-ccf8-3328-a13222badb08@redhat.com>
Date: Mon, 16 Mar 2020 13:37:38 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <db91173b-f485-b70f-01c1-4087298d4ec9@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 63.128.21.74
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
Cc: kwolf@redhat.com, den@openvz.org, qemu-devel@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 3/16/20 4:47 AM, Philippe Mathieu-Daud=E9 wrote:
> On 3/16/20 7:06 AM, Vladimir Sementsov-Ogievskiy wrote:
>> There is a use-after-free possible: bdrv_unref_child() leaves
>> bs->backing freed but not NULL. bdrv_attach_child may produce nested
>> polling loop due to drain, than access of freed pointer is possible.
>>
>> I've produced the following crash on 30 iotest with modified code. It
>> does not reproduce on master, but still seems possible:
>>
>> =A0=A0=A0=A0 #0=A0 __strcmp_avx2 () at /lib64/libc.so.6
>> =A0=A0=A0=A0 #1=A0 bdrv_backing_overridden (bs=3D0x55c9d3cc2060) at bloc=
k.c:6350
>> =A0=A0=A0=A0 #2=A0 bdrv_refresh_filename (bs=3D0x55c9d3cc2060) at block.=
c:6404
>> =A0=A0=A0=A0 #3=A0 bdrv_backing_attach (c=3D0x55c9d48e5520) at block.c:1=
063
>> =A0=A0=A0=A0 #4=A0 bdrv_replace_child_noperm
>> =A0=A0=A0=A0=A0=A0=A0=A0 (child=3Dchild@entry=3D0x55c9d48e5520,
>> =A0=A0=A0=A0=A0=A0=A0=A0 new_bs=3Dnew_bs@entry=3D0x55c9d3cc2060) at bloc=
k.c:2290
>> =A0=A0=A0=A0 #5=A0 bdrv_replace_child
>> =A0=A0=A0=A0=A0=A0=A0=A0 (child=3Dchild@entry=3D0x55c9d48e5520,
>> =A0=A0=A0=A0=A0=A0=A0=A0 new_bs=3Dnew_bs@entry=3D0x55c9d3cc2060) at bloc=
k.c:2320
>> =A0=A0=A0=A0 #6=A0 bdrv_root_attach_child
>> =A0=A0=A0=A0=A0=A0=A0=A0 (child_bs=3Dchild_bs@entry=3D0x55c9d3cc2060,
>> =A0=A0=A0=A0=A0=A0=A0=A0 child_name=3Dchild_name@entry=3D0x55c9d241d478 =
"backing",
>> =A0=A0=A0=A0=A0=A0=A0=A0 child_role=3Dchild_role@entry=3D0x55c9d26ecee0 =
<child_backing>,
>> =A0=A0=A0=A0=A0=A0=A0=A0 ctx=3D<optimized out>, perm=3D<optimized out>, =
shared_perm=3D21,
>> =A0=A0=A0=A0=A0=A0=A0=A0 opaque=3D0x55c9d3c5a3d0, errp=3D0x7ffd117108e0)=
 at block.c:2424
>> =A0=A0=A0=A0 #7=A0 bdrv_attach_child
>> =A0=A0=A0=A0=A0=A0=A0=A0 (parent_bs=3Dparent_bs@entry=3D0x55c9d3c5a3d0,
>> =A0=A0=A0=A0=A0=A0=A0=A0 child_bs=3Dchild_bs@entry=3D0x55c9d3cc2060,
>> =A0=A0=A0=A0=A0=A0=A0=A0 child_name=3Dchild_name@entry=3D0x55c9d241d478 =
"backing",
>> =A0=A0=A0=A0=A0=A0=A0=A0 child_role=3Dchild_role@entry=3D0x55c9d26ecee0 =
<child_backing>,
>> =A0=A0=A0=A0=A0=A0=A0=A0 errp=3Derrp@entry=3D0x7ffd117108e0) at block.c:=
5876
>> =A0=A0=A0=A0 #8=A0 in bdrv_set_backing_hd
>> =A0=A0=A0=A0=A0=A0=A0=A0 (bs=3Dbs@entry=3D0x55c9d3c5a3d0,
>> =A0=A0=A0=A0=A0=A0=A0=A0 backing_hd=3Dbacking_hd@entry=3D0x55c9d3cc2060,
>> =A0=A0=A0=A0=A0=A0=A0=A0 errp=3Derrp@entry=3D0x7ffd117108e0)
>> =A0=A0=A0=A0=A0=A0=A0=A0 at block.c:2576
>> =A0=A0=A0=A0 #9=A0 stream_prepare (job=3D0x55c9d49d84a0) at block/stream=
.c:150
>> =A0=A0=A0=A0 #10 job_prepare (job=3D0x55c9d49d84a0) at job.c:761
>> =A0=A0=A0=A0 #11 job_txn_apply (txn=3D<optimized out>, fn=3D<optimized o=
ut>) at
>> =A0=A0=A0=A0=A0=A0=A0=A0 job.c:145
>> =A0=A0=A0=A0 #12 job_do_finalize (job=3D0x55c9d49d84a0) at job.c:778
>> =A0=A0=A0=A0 #13 job_completed_txn_success (job=3D0x55c9d49d84a0) at job=
.c:832
>> =A0=A0=A0=A0 #14 job_completed (job=3D0x55c9d49d84a0) at job.c:845
>> =A0=A0=A0=A0 #15 job_completed (job=3D0x55c9d49d84a0) at job.c:836
>> =A0=A0=A0=A0 #16 job_exit (opaque=3D0x55c9d49d84a0) at job.c:864
>> =A0=A0=A0=A0 #17 aio_bh_call (bh=3D0x55c9d471a160) at util/async.c:117
>> =A0=A0=A0=A0 #18 aio_bh_poll (ctx=3Dctx@entry=3D0x55c9d3c46720) at util/=
async.c:117
>> =A0=A0=A0=A0 #19 aio_poll (ctx=3Dctx@entry=3D0x55c9d3c46720,
>> =A0=A0=A0=A0=A0=A0=A0=A0 blocking=3Dblocking@entry=3Dtrue)
>> =A0=A0=A0=A0=A0=A0=A0=A0 at util/aio-posix.c:728
>> =A0=A0=A0=A0 #20 bdrv_parent_drained_begin_single (poll=3Dtrue, c=3D0x55=
c9d3d558f0)
>> =A0=A0=A0=A0=A0=A0=A0=A0 at block/io.c:121
>> =A0=A0=A0=A0 #21 bdrv_parent_drained_begin_single (c=3Dc@entry=3D0x55c9d=
3d558f0,
>> =A0=A0=A0=A0=A0=A0=A0=A0 poll=3Dpoll@entry=3Dtrue)
>> =A0=A0=A0=A0=A0=A0=A0=A0 at block/io.c:114
>> =A0=A0=A0=A0 #22 bdrv_replace_child_noperm
>> =A0=A0=A0=A0=A0=A0=A0=A0 (child=3Dchild@entry=3D0x55c9d3d558f0,
>> =A0=A0=A0=A0=A0=A0=A0=A0 new_bs=3Dnew_bs@entry=3D0x55c9d3d27300) at bloc=
k.c:2258
>> =A0=A0=A0=A0 #23 bdrv_replace_child
>> =A0=A0=A0=A0=A0=A0=A0=A0 (child=3Dchild@entry=3D0x55c9d3d558f0,
>> =A0=A0=A0=A0=A0=A0=A0=A0 new_bs=3Dnew_bs@entry=3D0x55c9d3d27300) at bloc=
k.c:2320
>> =A0=A0=A0=A0 #24 bdrv_root_attach_child
>> =A0=A0=A0=A0=A0=A0=A0=A0 (child_bs=3Dchild_bs@entry=3D0x55c9d3d27300,
>> =A0=A0=A0=A0=A0=A0=A0=A0 child_name=3Dchild_name@entry=3D0x55c9d241d478 =
"backing",
>> =A0=A0=A0=A0=A0=A0=A0=A0 child_role=3Dchild_role@entry=3D0x55c9d26ecee0 =
<child_backing>,
>> =A0=A0=A0=A0=A0=A0=A0=A0 ctx=3D<optimized out>, perm=3D<optimized out>, =
shared_perm=3D21,
>> =A0=A0=A0=A0=A0=A0=A0=A0 opaque=3D0x55c9d3cc2060, errp=3D0x7ffd11710c60)=
 at block.c:2424
>> =A0=A0=A0=A0 #25 bdrv_attach_child
>> =A0=A0=A0=A0=A0=A0=A0=A0 (parent_bs=3Dparent_bs@entry=3D0x55c9d3cc2060,
>> =A0=A0=A0=A0=A0=A0=A0=A0 child_bs=3Dchild_bs@entry=3D0x55c9d3d27300,
>> =A0=A0=A0=A0=A0=A0=A0=A0 child_name=3Dchild_name@entry=3D0x55c9d241d478 =
"backing",
>> =A0=A0=A0=A0=A0=A0=A0=A0 child_role=3Dchild_role@entry=3D0x55c9d26ecee0 =
<child_backing>,
>> =A0=A0=A0=A0=A0=A0=A0=A0 errp=3Derrp@entry=3D0x7ffd11710c60) at block.c:=
5876
>> =A0=A0=A0=A0 #26 bdrv_set_backing_hd
>> =A0=A0=A0=A0=A0=A0=A0=A0 (bs=3Dbs@entry=3D0x55c9d3cc2060,
>> =A0=A0=A0=A0=A0=A0=A0=A0 backing_hd=3Dbacking_hd@entry=3D0x55c9d3d27300,
>> =A0=A0=A0=A0=A0=A0=A0=A0 errp=3Derrp@entry=3D0x7ffd11710c60)
>> =A0=A0=A0=A0=A0=A0=A0=A0 at block.c:2576
>> =A0=A0=A0=A0 #27 stream_prepare (job=3D0x55c9d495ead0) at block/stream.c=
:150
>> =A0=A0=A0=A0 ...
>>
>=20
> Apparently:
> Fixes: 12fa4af61f (block: Add Error parameter to bdrv_set_backing_hd)
> Right?
>=20

It's possible, but the way the bug manifests is very likely to have
changed dramatically since 2.10.0.

This is (probably?) not a regression in any stable version supported
upstream, or caused by that commit. It likely happened later when attach
and recursive flushes were reworked.


>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>=20
> Reviewed-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>
>=20
>> ---
>> =A0 block.c | 2 +-
>> =A0 1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/block.c b/block.c
>> index 957630b1c5..a862ce4df9 100644
>> --- a/block.c
>> +++ b/block.c
>> @@ -2735,10 +2735,10 @@ void bdrv_set_backing_hd(BlockDriverState *bs,
>> BlockDriverState *backing_hd,
>> =A0 =A0=A0=A0=A0=A0 if (bs->backing) {
>> =A0=A0=A0=A0=A0=A0=A0=A0=A0 bdrv_unref_child(bs, bs->backing);
>> +=A0=A0=A0=A0=A0=A0=A0 bs->backing =3D NULL;
>> =A0=A0=A0=A0=A0 }
>> =A0 =A0=A0=A0=A0=A0 if (!backing_hd) {
>> -=A0=A0=A0=A0=A0=A0=A0 bs->backing =3D NULL;
>> =A0=A0=A0=A0=A0=A0=A0=A0=A0 goto out;
>> =A0=A0=A0=A0=A0 }
>> =A0
>=20
>=20

This seems more obviously correct; but what's the error policy if
bdrv_attach_child fails? We'll have dropped the old file but won't pick
the new one up.

(That already seems to happen without this patch, so ... not a new concern.=
)

I feel comfortable to say:

Reviewed-by: John Snow <jsnow@redhat.com>

But don't know the answer to more structural questions, like if it's
important that the detached child gets flushed or not, in what order
that happens, etc etc.


