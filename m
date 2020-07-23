Return-Path: <SRS0=cpkI=BC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1FF1C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 17:58:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6D717206E3
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 17:58:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QwKxJ1bs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D717206E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41250 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyfUb-0000gL-Pc
	for qemu-devel@archiver.kernel.org; Thu, 23 Jul 2020 13:58:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45940)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1jyfSu-0007Xp-Vx
 for qemu-devel@nongnu.org; Thu, 23 Jul 2020 13:57:09 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:33399
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1jyfSt-0005Z0-3Z
 for qemu-devel@nongnu.org; Thu, 23 Jul 2020 13:57:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595527025;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=c2z4JxNcHTM8KejeT/Y47p4uG/5TXZ+/pgJKsojE5MY=;
 b=QwKxJ1bs0lUDM6ePPV0I0VKm3LeZP2H9eKkZyHhHiKDfQ+o+WXCsEjjf3Bznmv5GxadKoV
 rP2CVcStuFgHxhuwdwDvB/GeDedfFFtbPHQMBIimeBB3aT9v/oyyK9lnDknAdeh48Bm0re
 HSWG2uL2ds+NkMZ/qeybadweobDDEw4=
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com
 [209.85.166.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-475-PNCKKO0KOA2yZsVODmyX4Q-1; Thu, 23 Jul 2020 13:57:03 -0400
X-MC-Unique: PNCKKO0KOA2yZsVODmyX4Q-1
Received: by mail-il1-f198.google.com with SMTP id y13so3982574ila.10
 for <qemu-devel@nongnu.org>; Thu, 23 Jul 2020 10:57:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=c2z4JxNcHTM8KejeT/Y47p4uG/5TXZ+/pgJKsojE5MY=;
 b=nFMcftncERiWinKvv8Kp4iKzSxjuMUU8UECKRmLiwwradAfP9mFWNVRdJAo4bLfx0p
 Y2jzlyRj4dfxkcMzHxPk0IqUC1VQLWSEQeKOIdPK9djLSV7cWTeIMp3AiHHYFRdPq3YY
 iMMi76tfXJG5sNySyop4HMZnsn/0NWKQE8jTYkd/RbkOg3iYCfMhGdZS9ciDSa5Xgypc
 JoxBNuMKOzlgHWnH4v+qCOg3ZCEOW6IWc/40ipY2vEhfgLvK277QyUEwYH5ZkqoRTmZy
 Umsda4gXmudSzUOO6P0q1B7t3vg3IHNoapglfLm40LzK8FUajQORq7EG4pjCcmYoqnO/
 wPKA==
X-Gm-Message-State: AOAM5331C9EfuTfYfnyrPqTuDxPvQ5MRkK17/Cibi4e+PhNJnrskV+z5
 9XMe2TjsWuAhK09c04RimcGitwf2YmqTNIPqhUgqJOen78vBTDXUB3yCyQLCW2D3k22gsqRP0nM
 Dga0t3iN1zTfNMUPkNqGoiE7kev+3r2Y=
X-Received: by 2002:a92:4049:: with SMTP id n70mr6118233ila.161.1595527022967; 
 Thu, 23 Jul 2020 10:57:02 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw9wCCf6f07hv9eYq6PkgHdt5ZYMRXwSaPqZhz0ZAHPJFkXR99FTqRSOCZI765Q23/kRdI8IrWKqpPg48l6W88=
X-Received: by 2002:a92:4049:: with SMTP id n70mr6118216ila.161.1595527022760; 
 Thu, 23 Jul 2020 10:57:02 -0700 (PDT)
MIME-Version: 1.0
References: <20200723171935.18535-1-philmd@redhat.com>
In-Reply-To: <20200723171935.18535-1-philmd@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Thu, 23 Jul 2020 21:56:51 +0400
Message-ID: <CAMxuvawjeX6y1Y8T1KDVZ0aLzi1EQf5VkP3XAPUHjMP=_6UcJg@mail.gmail.com>
Subject: Re: [PATCH-for-5.1] libvhost-user: Report descriptor index on panic
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.120; envelope-from=mlureau@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/22 22:13:02
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Raphael Norwitz <raphael.norwitz@nutanix.com>,
 qemu-devel <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Jul 23, 2020 at 9:19 PM Philippe Mathieu-Daud=C3=A9
<philmd@redhat.com> wrote:
>
> We want to report the index of the descriptor,
> not its pointer.
>
> Fixes: 7b2e5c65f4 ("contrib: add libvhost-user")
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

> ---
>  contrib/libvhost-user/libvhost-user.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/contrib/libvhost-user/libvhost-user.c b/contrib/libvhost-use=
r/libvhost-user.c
> index d315db1396..53f16bdf08 100644
> --- a/contrib/libvhost-user/libvhost-user.c
> +++ b/contrib/libvhost-user/libvhost-user.c
> @@ -2074,7 +2074,7 @@ virtqueue_get_head(VuDev *dev, VuVirtq *vq,
>
>      /* If their number is silly, that's a fatal mistake. */
>      if (*head >=3D vq->vring.num) {
> -        vu_panic(dev, "Guest says index %u is available", head);
> +        vu_panic(dev, "Guest says index %u is available", *head);
>          return false;
>      }
>
> @@ -2133,7 +2133,7 @@ virtqueue_read_next_desc(VuDev *dev, struct vring_d=
esc *desc,
>      smp_wmb();
>
>      if (*next >=3D max) {
> -        vu_panic(dev, "Desc next is %u", next);
> +        vu_panic(dev, "Desc next is %u", *next);
>          return VIRTQUEUE_READ_DESC_ERROR;
>      }
>
> --
> 2.21.3
>


