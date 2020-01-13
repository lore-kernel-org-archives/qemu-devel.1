Return-Path: <SRS0=PCRa=3C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32801C33CA9
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jan 2020 17:50:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F191A207FF
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jan 2020 17:49:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tXDY+olw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F191A207FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53836 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ir3qg-00046h-LF
	for qemu-devel@archiver.kernel.org; Mon, 13 Jan 2020 12:49:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44704)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1ir3pL-0001zo-Sc
 for qemu-devel@nongnu.org; Mon, 13 Jan 2020 12:48:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1ir3pK-0008UR-HU
 for qemu-devel@nongnu.org; Mon, 13 Jan 2020 12:48:35 -0500
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:43237)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1ir3pK-0008T3-A0
 for qemu-devel@nongnu.org; Mon, 13 Jan 2020 12:48:34 -0500
Received: by mail-wr1-x441.google.com with SMTP id d16so9519093wre.10
 for <qemu-devel@nongnu.org>; Mon, 13 Jan 2020 09:48:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=4fHF5HpVc9enwxccEmFdnoK7Y79nJAeMYXHbgXFGnq4=;
 b=tXDY+olwtt+n/MmdWrd+ZgOriTWBi70ZujIXks5lR/wpr11tCpdZ+knQdeZFXrLIYg
 kWSG87WO6SfGb4kFWF+TeclhUa/ONF4qTS8I3xtyJCKYehaLSxiZymShLXQZKIEfmt3N
 0OwkyXLW33IESnHZFhKQTx53IqfWnXsOBzzakOERhIPAB+DyMloImLN36KWNpdQy1vbh
 C3Fj/3GvHzBH3Y/gJl1LSAjHUcpIT4sl2Kmlgn73xpWsMV132UbwEs1Tq926zEac931X
 SCxxR5Nnfngz+MaL/Z0VsinbMK+49Eypf5Ki9MtPrIpNCauhjP1Rq0PpwZlC7KgWSxm4
 1HFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=4fHF5HpVc9enwxccEmFdnoK7Y79nJAeMYXHbgXFGnq4=;
 b=fPQKh37m+IUm1Gvzd5A7T+Q+gtugSohlCLE/V3bKjk6VDazHpcE5pMfK5hdnDBJjPQ
 SduQLL7BZ7elHDhNxHOxSej6vp2Ock3C4AUz0JzVmtggC953A7xr7dwREZNBdAaxdNOe
 4I/anofIOypNZRjXBBaWrda4CFCHM2d7BXifhS2+SGz6ac+S64MDFAyh89IZekRT3tnZ
 ldMR2IDKc/0wmKTxL1y2BvSN5qOp5IuT0+tNh/XtOxNGuep9ueVo9p3xxadE/LEzAzJo
 nLHingI59lQ8CDTPld0/OAsuuyDHHBc5LyfFb2Y5ZOgXoeua1rt0szaGV/gsuyHyENW2
 7z9g==
X-Gm-Message-State: APjAAAUT11lj1wijszR2lkKcct3O+TOXYIXVPzBALRa6e6wrgs0gBZwQ
 0FjGl5Qf4IZ33Jr9hBbPdMHNng==
X-Google-Smtp-Source: APXvYqzUcbcyl1omXfuMfpOZJJZVNCpQu2mEK8CFNmwPe2bRlSIkui1C/EKqjADvCqeugs223So+8Q==
X-Received: by 2002:a5d:410e:: with SMTP id l14mr19363838wrp.238.1578937712996; 
 Mon, 13 Jan 2020 09:48:32 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id f207sm16458935wme.9.2020.01.13.09.48.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Jan 2020 09:48:31 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id F3E221FF87;
 Mon, 13 Jan 2020 17:48:30 +0000 (GMT)
References: <157709434917.12933.4351155074716553976.stgit@pasha-Precision-3630-Tower>
 <157709448356.12933.1621745423878239085.stgit@pasha-Precision-3630-Tower>
User-agent: mu4e 1.3.6; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Pavel Dovgalyuk <pavel.dovgaluk@gmail.com>
Subject: Re: [for-5.0 PATCH 08/11] replay: flush rr queue before loading the
 vmstate
In-reply-to: <157709448356.12933.1621745423878239085.stgit@pasha-Precision-3630-Tower>
Date: Mon, 13 Jan 2020 17:48:30 +0000
Message-ID: <87y2ubmemp.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
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
Cc: kwolf@redhat.com, peter.maydell@linaro.org, pavel.dovgaluk@ispras.ru,
 pbonzini@redhat.com, crosthwaite.peter@gmail.com, ciro.santilli@gmail.com,
 jasowang@redhat.com, quintela@redhat.com, qemu-devel@nongnu.org,
 armbru@redhat.com, maria.klimushenkova@ispras.ru, mst@redhat.com,
 kraxel@redhat.com, boost.lists@gmail.com, thomas.dullien@googlemail.com,
 dovgaluk@ispras.ru, mreitz@redhat.com, artem.k.pisarenko@gmail.com,
 dgilbert@redhat.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Pavel Dovgalyuk <pavel.dovgaluk@gmail.com> writes:

> From: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
>
> Non-empty record/replay queue prevents saving and loading the VM state,
> because it includes pending bottom halves and block coroutines.
> But when the new VM state is loaded, we don't have to preserve the consis=
tency
> of the current state anymore. Therefore this patch just flushes the queue
> allowing the coroutines to finish and removes checking for empty rr queue
> for load_snapshot function.
>
> Signed-off-by: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
> ---
>  include/sysemu/replay.h  |    2 ++
>  migration/savevm.c       |   12 ++++++------
>  replay/replay-internal.h |    2 --
>  3 files changed, 8 insertions(+), 8 deletions(-)
>
> diff --git a/include/sysemu/replay.h b/include/sysemu/replay.h
> index e00ed2f4a5..239c01e7df 100644
> --- a/include/sysemu/replay.h
> +++ b/include/sysemu/replay.h
> @@ -149,6 +149,8 @@ void replay_disable_events(void);
>  void replay_enable_events(void);
>  /*! Returns true when saving events is enabled */
>  bool replay_events_enabled(void);
> +/* Flushes events queue */
> +void replay_flush_events(void);
>  /*! Adds bottom half event to the queue */
>  void replay_bh_schedule_event(QEMUBH *bh);
>  /* Adds oneshot bottom half event to the queue */
> diff --git a/migration/savevm.c b/migration/savevm.c
> index ae84bf6ab0..0c5cac372a 100644
> --- a/migration/savevm.c
> +++ b/migration/savevm.c
> @@ -2834,12 +2834,6 @@ int load_snapshot(const char *name, Error **errp)
>      AioContext *aio_context;
>      MigrationIncomingState *mis =3D migration_incoming_get_current();
>=20=20
> -    if (!replay_can_snapshot()) {
> -        error_setg(errp, "Record/replay does not allow loading snapshot "
> -                   "right now. Try once more later.");
> -        return -EINVAL;
> -    }
> -
>      if (!bdrv_all_can_snapshot(&bs)) {
>          error_setg(errp,
>                     "Device '%s' is writable but does not support snapsho=
ts",
> @@ -2873,6 +2867,12 @@ int load_snapshot(const char *name, Error **errp)
>          return -EINVAL;
>      }
>=20=20
> +    /*
> +     * Flush the record/replay queue. Now the VM state is going
> +     * to change. Therefore we don't need to preserve its consistency
> +     */
> +    replay_flush_events();
> +
<snip>

This is the commit that introduces:

  ERROR:/home/alex.bennee/lsrc/qemu.git/replay/replay-events.c:80:replay_fl=
ush_events:
  assertion failed: (replay_mutex_locked())

To the already failing:

  /bin/sh -c "cd builds/all && make -j4 && cd tests/qemu-iotests && ./check=
 -qcow2 267"

test case.

--=20
Alex Benn=C3=A9e

