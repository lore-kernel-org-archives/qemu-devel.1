Return-Path: <SRS0=Jnn8=YR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70DAACA9EAF
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 13:48:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A59E20659
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 13:48:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CnrB3vtc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A59E20659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43090 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNdTu-0002f2-Di
	for qemu-devel@archiver.kernel.org; Thu, 24 Oct 2019 09:48:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55822)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1iNczx-0006ok-Tx
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 09:17:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1iNczu-0003KC-RX
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 09:17:52 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:52030
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1iNczs-0003Ih-VI
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 09:17:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1571923067;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AL9DcZE1kz6lSCTw9ynvp52WRU3zvCyujWx7l1gnLz4=;
 b=CnrB3vtcFWQsoVFKzJhsy8cJY6VAhdt8np4AupW0YtoTxz26lskHfluSFwbhd0TDCcjqB1
 1vAxZ4gnQHPdbkEObLko1LvaEbrDCPgkSP0Vil0YvevDOQzYgVpBkH1lvYsjxrgyDHoPYM
 VLYPMU9X+LxTqKOdfN28Yhco/ZUIPF8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-146-6OUBI_p-PyqcvyQXgdvfwQ-1; Thu, 24 Oct 2019 09:17:44 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CA2C880183D;
 Thu, 24 Oct 2019 13:17:42 +0000 (UTC)
Received: from linux.fritz.box (unknown [10.36.118.122])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6C8D5100EBA2;
 Thu, 24 Oct 2019 13:17:40 +0000 (UTC)
Date: Thu, 24 Oct 2019 15:17:38 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Subject: Re: [PATCH 2/3] qcow2: Assert that qcow2_cache_get() callers hold
 s->lock
Message-ID: <20191024131738.GF6200@linux.fritz.box>
References: <20191023152620.13166-1-kwolf@redhat.com>
 <20191023152620.13166-3-kwolf@redhat.com>
 <3600fb84-e1f1-c70a-4b83-e7a379f50614@virtuozzo.com>
 <20191024105746.GB6200@linux.fritz.box>
 <a27c197e-c73f-e92f-8e28-1422cf313507@virtuozzo.com>
MIME-Version: 1.0
In-Reply-To: <a27c197e-c73f-e92f-8e28-1422cf313507@virtuozzo.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: 6OUBI_p-PyqcvyQXgdvfwQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
Cc: "psyhomb@gmail.com" <psyhomb@gmail.com>,
 "michael@weiser.dinsnail.net" <michael@weiser.dinsnail.net>,
 Denis Lunev <den@virtuozzo.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-stable@nongnu.org" <qemu-stable@nongnu.org>,
 "dgilbert@redhat.com" <dgilbert@redhat.com>,
 "mreitz@redhat.com" <mreitz@redhat.com>,
 "lersek@redhat.com" <lersek@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 24.10.2019 um 15:03 hat Vladimir Sementsov-Ogievskiy geschrieben:
> 24.10.2019 13:57, Kevin Wolf wrote:
> > Am 24.10.2019 um 12:01 hat Denis Lunev geschrieben:
> >> On 10/23/19 6:26 PM, Kevin Wolf wrote:
> >>> qcow2_cache_do_get() requires that s->lock is locked because it can
> >>> yield between picking a cache entry and actually taking ownership of =
it
> >>> by setting offset and increasing the reference count.
> >>>
> >>> Add an assertion to make sure the caller really holds the lock. The
> >>> function can be called outside of coroutine context, where bdrv_pread
> >>> and flushes become synchronous operations. The lock cannot and need n=
ot
> >>> be taken in this case.
> >>>
> >>> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> >>> ---
> >>>   block/qcow2-cache.c | 5 +++++
> >>>   1 file changed, 5 insertions(+)
> >>>
> >>> diff --git a/block/qcow2-cache.c b/block/qcow2-cache.c
> >>> index d29b038a67..75b13dad99 100644
> >>> --- a/block/qcow2-cache.c
> >>> +++ b/block/qcow2-cache.c
> >>> @@ -327,6 +327,9 @@ static int qcow2_cache_do_get(BlockDriverState *b=
s, Qcow2Cache *c,
> >>>       int min_lru_index =3D -1;
> >>>  =20
> >>>       assert(offset !=3D 0);
> >>> +    if (qemu_in_coroutine()) {
> >>> +        qemu_co_mutex_assert_locked(&s->lock);
> >>> +    }
> >>
> >> that is looking not good to me. If this is really requires lock, we sh=
ould
> >> check for the lock always. In the other hand we could face missed
> >> lock out of coroutine.
> >=20
> > As the commit message explains, outside of coroutine context, we can't
> > yield and bdrv_pread and bdrv_flush become synchronous operations
> > instead, so there is nothing else that we need to protect against.
> >=20
>=20
> Recently we discussed similar problems about block-dirty-bitmap-* qmp
> commands, which wanted to update qcow2 metadata about bitmaps from
> non-coroutine context.  "qcow2 lock"
> <135df452-397a-30bb-7518-2184fa5971aa@virtuozzo.com>
> https://lists.gnu.org/archive/html/qemu-devel/2019-09/msg01419.html

Hm, right, I already forgot about the nested event loop again...

> And, as I understand, the correct way is to convert to coroutine and
> lock mutex appropriately. Or we want to lock aio context and to be in
> drained section to avoid parallel requests accessing critical section.
> Should we assert such conditions in case of !qemu_in_coroutine() ?

The AioContext lock must be held anyway, so I don't think this would be
a new requirement. As for draining, I'll have to see.

I'm currently still auditing all the callers of qcow2_cache_do_get().
The synchronous callers I already know are the snapshot functions. I
think these happen to be in a drained section anyway (or should be at
least), so AioContext lock + drain seems like a very reasonable option
for them.

For other synchronous callers, if any, maybe conversion to a coroutine
would make more sense.

Kevin


