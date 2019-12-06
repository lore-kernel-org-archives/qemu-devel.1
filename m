Return-Path: <SRS0=8N/K=Z4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3359EC43603
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2019 16:26:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF78320659
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2019 16:26:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gc0iy/11"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF78320659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40850 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1idGRF-0005hK-Th
	for qemu-devel@archiver.kernel.org; Fri, 06 Dec 2019 11:26:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44535)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1idF17-0003Q6-FI
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 09:55:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1idF14-0000gC-LY
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 09:55:36 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:56672
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1idF14-0000dc-Gt
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 09:55:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575644128;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WsAnELcbdTX/HuJfYOQMFJ+iseDalkBUX++X6oFslFs=;
 b=gc0iy/11VRpIgtpvFj1NoJSxZhIIsxFMkW+JEibOeMwSFBFtw3WudLqNR3cLxJKe43gRY/
 BXMHcahPgTMcIYt/r6R2Ia8p9wkSuOGWvLkN2VICkEsgSidOwfiota1rfy8bVhWdOT+h9a
 m9TzHXnVKBnx/Jya0h3rQEIgrac/n2Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-247-GCjSvCJJMtiVSROUxZJ_0g-1; Fri, 06 Dec 2019 03:54:24 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E8FFF1010FC0;
 Fri,  6 Dec 2019 08:54:22 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-134.ams2.redhat.com
 [10.36.116.134])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6702D5D6A3;
 Fri,  6 Dec 2019 08:54:22 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id DAA3A1138606; Fri,  6 Dec 2019 09:54:20 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Subject: Re: [PATCH v7 21/21] nbd: assert that Error** is not NULL in
 nbd_iter_channel_error
References: <20191205152019.8454-1-vsementsov@virtuozzo.com>
 <20191205152019.8454-22-vsementsov@virtuozzo.com>
 <c4ff448d-e756-9d95-b07e-4ae5f2d5b9b0@redhat.com>
 <93046486-1580-14a1-520d-08abdf74da0e@virtuozzo.com>
Date: Fri, 06 Dec 2019 09:54:20 +0100
In-Reply-To: <93046486-1580-14a1-520d-08abdf74da0e@virtuozzo.com> (Vladimir
 Sementsov-Ogievskiy's message of "Thu, 5 Dec 2019 17:39:21 +0000")
Message-ID: <87sglxltqb.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: GCjSvCJJMtiVSROUxZJ_0g-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com> writes:

> 05.12.2019 20:14, Eric Blake wrote:
>> On 12/5/19 9:20 AM, Vladimir Sementsov-Ogievskiy wrote:
>>> The local_err parameter is not here to return information about
>>> nbd_iter_channel_error failure. Instead it's assumed to be filled when
>>> passed to the function. This is already stressed by its name
>>> (local_err, instead of classic errp). Stress it additionally by
>>> assertion.
>>>
>>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>>> ---
>>> =C2=A0 block/nbd.c | 1 +
>>> =C2=A0 1 file changed, 1 insertion(+)
>>>
>>> diff --git a/block/nbd.c b/block/nbd.c
>>> index 5f18f78a94..d085554f21 100644
>>> --- a/block/nbd.c
>>> +++ b/block/nbd.c
>>> @@ -866,6 +866,7 @@ typedef struct NBDReplyChunkIter {
>>> =C2=A0 static void nbd_iter_channel_error(NBDReplyChunkIter *iter,
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 in=
t ret, Error **local_err)
>>> =C2=A0 {
>>> +=C2=A0=C2=A0=C2=A0 assert(local_err && *local_err);
>>=20
>> Why are we forbidding grandparent callers from passing NULL when they wa=
nt to ignore an error?=C2=A0 We are called by several parent functions that=
 get an errp from the grandparent, and use this function to do some common =
grunt work.=C2=A0 Let's look at the possibilities:
>>=20
>> 1. grandparent passes address of a local error: we want to append to the=
 error message, parent will then deal with the error how it wants (report i=
t, ignore it, propagate it, whatever)
>>=20
>> 2. grandparent passes &error_fatal: we want to append a hint, but before=
 ERRP_AUTO_PROPAGATE, the parent has already exited.=C2=A0 After ERRP_AUTO_=
PROPAGATE, this looks like case 1.
>>=20
>> 3. grandparent passes &error_abort: we should never be reached (failure =
earlier in the parent should have already aborted) - true whether or not ER=
RP_AUTO_PROPAGATE is applied
>>=20
>> 4. grandparent passes NULL to ignore the error. Does not currently happe=
n in any of the grandparent callers, because if it did, your assertion in t=
his patch would now fire.=C2=A0 After ERRP_AUTO_PROPAGATE, this would look =
like case 1.
>>=20
>> Would it be better to assert(!local_err || *local_err)?=C2=A0 The assert=
ion as written is too strict without ERRP_AUTO_PROPAGATE, but you get away =
with it because none of the grandparents pass NULL; but is appropriate as w=
ritten for after after the macro conversion so then we wonder if churn on t=
he macro is worth it.
>
> We don't have any grandparents, this function is always called on local_e=
rr. And it's argument named local_err to stress it.
> The function is an API to report error, and it wants filled local_err obj=
ect.
>
> It will crash anyway if local_err is NULL, as it dereferences it.

Yes.

We already assert ret < 0 explicitly, and we rely on !local_err
implicitly.  Making that explicit is obviously safe.

The code doesn't actually rely on !*local_err.  But when ret < 0, and
!local_err, surely local_err should point to an Error object.  Asserting
that makes sense to me.

> I just want to place an assertion at start of functions like this,
> which will be easily recognizable by coccinelle.

That's not a convincing argument.  Doesn't matter as long as we have
convincing ones :)

>
> ---
>
> We can improve the API, to support local_err=3D=3DNULL, for the case when=
 original request was called with
> errp=3D=3DNULL, but for this we'll need more changes, like, pass errp to =
NBD_FOREACH_REPLY_CHUNK and save
> it into iter object...
>
> But how to detect it in code? Something like
>
>
> --- a/block/nbd.c
> +++ b/block/nbd.c
> @@ -1059,8 +1059,10 @@ static int nbd_co_receive_blockstatus_reply(BDRVNB=
DState *s,
>           case NBD_REPLY_TYPE_BLOCK_STATUS:
>               if (received) {
>                   nbd_channel_error(s, -EINVAL);
> -                error_setg(&local_err, "Several BLOCK_STATUS chunks in r=
eply");
> -                nbd_iter_channel_error(&iter, -EINVAL, &local_err);
> +                if (errp) {
> +                    error_setg(&local_err, "Several BLOCK_STATUS chunks =
in reply");
> +                }
> +                nbd_iter_channel_error(&iter, -EINVAL, errp ? &local_err=
 : NULL);
>               }
>               received =3D true;
>
>
> is ugly..
>
>
> So, to support original errp=3DNULL the whole thing should be refactored.=
. Not worth it, I think.

The only change I'd consider in addition to the assertion is this
simplification:

diff --git a/block/nbd.c b/block/nbd.c
index 5f18f78a94..7bbac1e5b8 100644
--- a/block/nbd.c
+++ b/block/nbd.c
@@ -870,11 +870,9 @@ static void nbd_iter_channel_error(NBDReplyChunkIter *=
iter,
=20
     if (!iter->ret) {
         iter->ret =3D ret;
-        error_propagate(&iter->err, *local_err);
-    } else {
-        error_free(*local_err);
     }
=20
+    error_propagate(&iter->err, *local_err);
     *local_err =3D NULL;
 }
=20


