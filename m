Return-Path: <SRS0=2GMi=CD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8B1FC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 03:34:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 92D7820738
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 03:34:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bytedance-com.20150623.gappssmtp.com header.i=@bytedance-com.20150623.gappssmtp.com header.b="yp7orgYo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92D7820738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bytedance.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59992 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAPjF-0006Cn-O0
	for qemu-devel@archiver.kernel.org; Mon, 24 Aug 2020 23:34:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59838)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wanghonghao@bytedance.com>)
 id 1kAPie-0005mm-4l
 for qemu-devel@nongnu.org; Mon, 24 Aug 2020 23:33:56 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:41298)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wanghonghao@bytedance.com>)
 id 1kAPia-0007nI-CD
 for qemu-devel@nongnu.org; Mon, 24 Aug 2020 23:33:54 -0400
Received: by mail-pf1-x443.google.com with SMTP id t9so2055557pfq.8
 for <qemu-devel@nongnu.org>; Mon, 24 Aug 2020 20:33:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=avKJ2JIbR1Pzp2LbrbvOb37MOLZCmMfT4JIK3SyJHc8=;
 b=yp7orgYoXji7FxXxBhEFskT18o77S9ebmVZmYnsgrSbcccfvyXUXXpbuOrdF19bcO2
 tMxe/+nK4j5y7oyE8ugDiLkXFRYXpujulgcEyOBwQABBdiZ/C1y4vH8tnejM5EtK1ET9
 ZLZ4X1E9bXuhwxJl8ecpz1bpFLcpgCHl5CBnnhF6wHYUjqWgAatKFyxp8an9ceDdUhLl
 LSy9h/2drjCw+qknAZ/mnVZYpAY+uDxcsaFS2X1RjKHAJuuJMerIDZey8WsGQAqf7FNg
 bxZSNvy6Q2edjJQDMMVxPMU7NrfRBfuPxVmJpA0qx3WiQpopA4uXibgpR4LWRv9hi/1L
 NVxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=avKJ2JIbR1Pzp2LbrbvOb37MOLZCmMfT4JIK3SyJHc8=;
 b=bnAx+R2XEDrGkh2HAAaCUKCOrRFqCusDnNvKeJ+2sU/mB8CEiI+7BGcRKOugj3NpX4
 gvrY0L1tPs+M0PIaqHI4Bmy7z5i+Z6+AXZ/M6heD/Ockwd/t9jx4hbtvVY8++ES4/A9F
 lfFYJG0MSa2fUYpvTVdslAfpqQvPM8DzCSwgK7iaUNQn5kzFxw9kYFqHcTLriIV9Ut2A
 tTgTu7fmh4/SGcA4TykdsKRFHfowXpaEuQSvniGc2OW1Vr5qv74921++BpGuJhCOxEtq
 vTjYAoINmXUPGKDfCHYYJ7cOug/E+Z2HE7kKpMrl7ptHc2y2pN0zjetmYi3RaPZF3+Dy
 6qwQ==
X-Gm-Message-State: AOAM531T9bSdM4WmwersPcwaB6HnTE/dEiOC8QyRNT/qXeGbNmyUN/jw
 XI11ujHC2QiqZGhA4q1KahmurUNukwpeLUacExFU0w==
X-Google-Smtp-Source: ABdhPJyneZ2UfUA92hGBXGPjzhJa2WhApTqU6raSqh4ZcHfC9gZmDIfmaFBUy+hPnNIrqXZMNtbw87K8VSiEG3acH1c=
X-Received: by 2002:a63:c005:: with SMTP id h5mr5324183pgg.319.1598326429997; 
 Mon, 24 Aug 2020 20:33:49 -0700 (PDT)
MIME-Version: 1.0
References: <20200824043121.13421-1-wanghonghao@bytedance.com>
 <20200824152659.GA7124@stefanha-x1.localdomain>
In-Reply-To: <20200824152659.GA7124@stefanha-x1.localdomain>
From: =?UTF-8?B?546L5rSq5rWp?= <wanghonghao@bytedance.com>
Date: Tue, 25 Aug 2020 11:33:39 +0800
Message-ID: <CADzM5uTTB31+-y0MQbEgX0WxXk1pipSzYDtsAc=UkW4RDExP-g@mail.gmail.com>
Subject: Re: [External] Re: [PATCH 1/2] QSLIST: add atomic replace operation
To: Stefan Hajnoczi <stefanha@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::443;
 envelope-from=wanghonghao@bytedance.com; helo=mail-pf1-x443.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Cc: kwolf@redhat.com, pbonzini@redhat.com, fam@euphon.net,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This function is indeed a bit vague in semantics.
I'll modify this function to make it more in line with `replace`.

Stefan Hajnoczi <stefanha@redhat.com> =E4=BA=8E2020=E5=B9=B48=E6=9C=8824=E6=
=97=A5=E5=91=A8=E4=B8=80 =E4=B8=8B=E5=8D=8811:27=E5=86=99=E9=81=93=EF=BC=9A
>
> On Mon, Aug 24, 2020 at 12:31:20PM +0800, wanghonghao wrote:
> > Replace a queue with another atomicly. It's useful when we need to tran=
sfer
> > queues between threads.
> >
> > Signed-off-by: wanghonghao <wanghonghao@bytedance.com>
> > ---
> >  include/qemu/queue.h | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/include/qemu/queue.h b/include/qemu/queue.h
> > index 456a5b01ee..a3ff544193 100644
> > --- a/include/qemu/queue.h
> > +++ b/include/qemu/queue.h
> > @@ -226,6 +226,10 @@ struct {                                          =
                      \
> >          (dest)->slh_first =3D atomic_xchg(&(src)->slh_first, NULL);   =
     \
> >  } while (/*CONSTCOND*/0)
> >
> > +#define QSLIST_REPLACE_ATOMIC(dest, src) do {                         =
        \
> > +        (src)->slh_first =3D atomic_xchg(&(dest)->slh_first, (src)->sl=
h_first); \
> > +} while (/*CONSTCOND*/0)
>
> This is atomic for dest but not src.
>
> Maybe the name should make this clear: QSLIST_REPLACE_ATOMIC_DEST().
>
> Please also add a doc comment mentioning that the modification to src is
> not atomic.
>
> Stefan

