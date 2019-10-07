Return-Path: <SRS0=TwS2=YA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FB3AC47404
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2019 11:07:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C0D12064A
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2019 11:07:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="by0ABk6a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C0D12064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43024 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iHQrJ-00080L-Cm
	for qemu-devel@archiver.kernel.org; Mon, 07 Oct 2019 07:07:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39954)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1iHQqO-0007RQ-GO
 for qemu-devel@nongnu.org; Mon, 07 Oct 2019 07:06:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1iHQqM-0008L9-Q1
 for qemu-devel@nongnu.org; Mon, 07 Oct 2019 07:06:23 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:57140
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1iHQqM-0008Ku-IQ
 for qemu-devel@nongnu.org; Mon, 07 Oct 2019 07:06:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1570446381;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=vbnMD/7NoyGaHnMSW14Qkx8O+GIbgDVqSHnOhyMIz+A=;
 b=by0ABk6aSNetBpN9hyDu3C5NDfWP2xHSEKWdR+8eWXZXwbDbuT1N7ec2RF0BuCmdqliWlx
 8VTBkp44wXx0O50hZEAZP0Bx8YgcjS9WITad5ZGyq2tNOJ8YOjDIzazdlZXWKRQdM+rqH4
 2STjXni0nFYZPaqb77T9mIas0/1EGoE=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-273-OvRPFa23POurgFBG6GLfnA-1; Mon, 07 Oct 2019 07:06:19 -0400
Received: by mail-wr1-f70.google.com with SMTP id 32so7362148wrk.15
 for <qemu-devel@nongnu.org>; Mon, 07 Oct 2019 04:06:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=WpTiXw1PnpBtqLC3a6ReXREa+xqhihGliBVrWTb489w=;
 b=mcwAyMHt8oYVTR+J0fo+udtdsljTFNzeSignLmxaO9fEn/eSD9pZEkjL0ENsyNoFNg
 ksKqSQ/gzV2aj+XZEcBa13M9qTOJEd313uS+MxGGCBub/5KwDWKdbHid4hV9DKu/lXwR
 6ronftlptQMtOFwpufipqIbQ2p3MeHavCD0OG5iijXhgtSxMfK8Mh78Cfk1wUYvuG1RA
 yZ+ln7M/Vfj3wOsh6E0k3yM7aS5H7l/SnYo5wUNg6DpvRCswpHwQ4ijT+ldYTtc+5xbE
 keLZY1Sn4paIUo/Cf+QnOZh3PaGT3cKcgEtIS926rvw/6ztD8N10GQFfWJqVENmsJfMY
 TaDQ==
X-Gm-Message-State: APjAAAXYf17RXHU3YYNhbDd8os+S2UGHVWRQfCPoX6U4apT/2z9Kbwoa
 yNCLEJHmgM0LWKfRF/W8gd974+NWMWNfQN6XDxL5d3lt1HBaCpFF1c8z7Xq/nWYZacxhTrv1eF0
 RzSo8nepFnE1ufHY=
X-Received: by 2002:a5d:4747:: with SMTP id o7mr5305934wrs.311.1570446377906; 
 Mon, 07 Oct 2019 04:06:17 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxO1z8Tz7Dvma34cOFnKHIwof6IY3JJ9CmLJ9x6vYUgKGUaCxljJRvqGg14HiW+0iO4hEOPCA==
X-Received: by 2002:a5d:4747:: with SMTP id o7mr5305906wrs.311.1570446377603; 
 Mon, 07 Oct 2019 04:06:17 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:9dd9:ce92:89b5:d1f2?
 ([2001:b07:6468:f312:9dd9:ce92:89b5:d1f2])
 by smtp.gmail.com with ESMTPSA id g17sm7228995wrq.58.2019.10.07.04.06.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 07 Oct 2019 04:06:16 -0700 (PDT)
Subject: Re: [Qemu-devel] qemu_futex_wait() lockups in ARM64: 2 possible issues
To: Jan Glauber <jglauber@marvell.com>,
 dann frazier <dann.frazier@canonical.com>
References: <cbe46ad6-ef6c-d155-e79a-672182c725ad@ubuntu.com>
 <d94f18f1-986f-ec19-02c0-e83e5e7af3d0@redhat.com>
 <1864070a-2f84-1d98-341e-f01ddf74ec4b@ubuntu.com>
 <20190924202517.GA21422@xps13.dannf> <20191002092253.GA3857@hc>
From: Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <6dd73749-49b0-0fbc-b9bb-44c3736642b8@redhat.com>
Date: Mon, 7 Oct 2019 13:06:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191002092253.GA3857@hc>
Content-Language: en-US
X-MC-Unique: OvRPFa23POurgFBG6GLfnA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
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
Cc: QEMU Developers <qemu-devel@nongnu.org>,
 Rafael David Tinoco <rafaeldtinoco@ubuntu.com>,
 QEMU Developers - ARM <qemu-arm@nongnu.org>, lizhengui <lizhengui@huawei.com>,
 Bug 1805256 <1805256@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 02/10/19 11:23, Jan Glauber wrote:
> I've looked into this on ThunderX2. The arm64 code generated for the
> atomic_[add|sub] accesses of ctx->notify_me doesn't contain any
> memory barriers. It is just plain ldaxr/stlxr.
>=20
> From my understanding this is not sufficient for SMP sync.
>=20
> If I read this comment correct:
>=20
>     void aio_notify(AioContext *ctx)
>     {
>         /* Write e.g. bh->scheduled before reading ctx->notify_me.  Pairs
>          * with atomic_or in aio_ctx_prepare or atomic_add in aio_poll.
>          */
>         smp_mb();
>         if (ctx->notify_me) {
>=20
> it points out that the smp_mb() should be paired. But as
> I said the used atomics don't generate any barriers at all.

Based on the rest of the thread, this patch should also fix the bug:

diff --git a/util/async.c b/util/async.c
index 47dcbfa..721ea53 100644
--- a/util/async.c
+++ b/util/async.c
@@ -249,7 +249,7 @@ aio_ctx_check(GSource *source)
     aio_notify_accept(ctx);
=20
     for (bh =3D ctx->first_bh; bh; bh =3D bh->next) {
-        if (bh->scheduled) {
+        if (atomic_mb_read(&bh->scheduled)) {
             return true;
         }
     }


And also the memory barrier in aio_notify can actually be replaced
with a SEQ_CST load:

diff --git a/util/async.c b/util/async.c
index 47dcbfa..721ea53 100644
--- a/util/async.c
+++ b/util/async.c
@@ -349,11 +349,11 @@ LinuxAioState *aio_get_linux_aio(AioContext *ctx)
=20
 void aio_notify(AioContext *ctx)
 {
-    /* Write e.g. bh->scheduled before reading ctx->notify_me.  Pairs
-     * with atomic_or in aio_ctx_prepare or atomic_add in aio_poll.
+    /* Using atomic_mb_read ensures that e.g. bh->scheduled is written bef=
ore
+     * ctx->notify_me is read.  Pairs with atomic_or in aio_ctx_prepare or
+     * atomic_add in aio_poll.
      */
-    smp_mb();
-    if (ctx->notify_me) {
+    if (atomic_mb_read(&ctx->notify_me)) {
         event_notifier_set(&ctx->notifier);
         atomic_mb_set(&ctx->notified, true);
     }


Would you be able to test these (one by one possibly)?

> I've tried to verify me theory with this patch and didn't run into the
> issue for ~500 iterations (usually I would trigger the issue ~20 iteratio=
ns).

Sorry for asking the obvious---500 iterations of what?

Paolo


