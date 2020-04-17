Return-Path: <SRS0=Zx28=6B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF2E2C352BE
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2020 10:08:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B2A6C21D91
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2020 10:08:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=smartx-com.20150623.gappssmtp.com header.i=@smartx-com.20150623.gappssmtp.com header.b="FlfuHEXe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2A6C21D91
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=smartx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44936 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jPNv9-0005Sk-SG
	for qemu-devel@archiver.kernel.org; Fri, 17 Apr 2020 06:08:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35771)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <fengli@smartx.com>) id 1jPNuZ-00052X-AL
 for qemu-devel@nongnu.org; Fri, 17 Apr 2020 06:07:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <fengli@smartx.com>) id 1jPNuX-0007lu-QN
 for qemu-devel@nongnu.org; Fri, 17 Apr 2020 06:07:50 -0400
Received: from mail-vk1-xa30.google.com ([2607:f8b0:4864:20::a30]:46737)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <fengli@smartx.com>) id 1jPNuX-0007iL-Ff
 for qemu-devel@nongnu.org; Fri, 17 Apr 2020 06:07:49 -0400
Received: by mail-vk1-xa30.google.com with SMTP id q200so201442vka.13
 for <qemu-devel@nongnu.org>; Fri, 17 Apr 2020 03:07:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=kgJaPyB2ehgEZXSy2LinQNOihr92buZx8gXVkYwFgsk=;
 b=FlfuHEXeU3jxD0s5bgSiWEVMgj1iB5+h9oOT5UaMp7Jk9fxUP2rEJAcW3AUP6tLwwT
 DXuf2IZWlo5qM5st+tkXb3HuPru2sk/KS9Bd4yBotfS4SurI7z54PgLaTh8ONhqr9mpD
 zP1mrNnQERNdrp0GJ5vcOrcZ+BV01zKBwQ5GUZ4FKKvkyi7x3QQYo8zJn51C5omXR5Cf
 bBKHBnnuIWxc8zRGhC785keWG+dcMOyHvbQBnNEn/Y9oN3fz9jaRsAKYU1PFjSchIduY
 Oxyd+RMN0slHVSaLU/e72q1i6PwgBMcjTaKJS6Vxjf5gpgShR2uFmiSUq/MNVmuvKJgV
 D5Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=kgJaPyB2ehgEZXSy2LinQNOihr92buZx8gXVkYwFgsk=;
 b=C0G2DyPwwH47xZAQsYylpDCBqwoAZs1VFlj/uA1TJfoi7JW229UmyClozSirLAIBnJ
 bhN3lhpb7ZRK/Uij4e7+B7VfH6YlRik4GExO6SHk1Di2qwqBH1NjLYdOKIOeVRNUJR88
 xTGrK0qob5Rn3HlNmOHPIAPOfo6sob+CdXDm8VlNVPUfWDAvcxRz0X+dKhfJ9osX3vdg
 6YHR/hYRf7H832MN2B9YOtYEQYk7eRC+yLAGh8qqhdtec5tuJhXHgG3QBEgdiRB/UuqX
 epln1+rSx+fjOMxo+o6M0j0M612L3cTzSTjqepmDyErN74e8TcPPSUTzJzUrB858O9Gk
 SGDA==
X-Gm-Message-State: AGi0Pua2MD/dNSZth//9Yauc9L9ebCav6HfKy0XvUrWAiuP3Zm9MjjDE
 XVQgMySv0TDkMEpiGxpegB4FePOHfkI0oEC1RoDLRxfKI5j8kkkQNmUqMtjG3jXmyPRxXsJApWG
 zRyp6jFcTd7OKARy8xgqliTel
X-Google-Smtp-Source: APiQypLuu8QDEypNGawFUgPOQby/g9f/1d5nt4kJ/boFFGkMRRASFR1BhlUnFGw747a2ret3eTXKPREtDkc84pAbtm8=
X-Received: by 2002:a1f:a756:: with SMTP id q83mr1748215vke.97.1587118067190; 
 Fri, 17 Apr 2020 03:07:47 -0700 (PDT)
MIME-Version: 1.0
References: <20200415032826.16701-1-fengli@smartx.com>
 <20200415032826.16701-5-fengli@smartx.com>
 <20200414015448.GA8307@localhost.localdomain>
 <CAHckoCwsLwqNhVHK4PF+pzt5ExkurPNsWLw7ueRG8dfOUA2rXg@mail.gmail.com>
In-Reply-To: <CAHckoCwsLwqNhVHK4PF+pzt5ExkurPNsWLw7ueRG8dfOUA2rXg@mail.gmail.com>
From: Li Feng <fengli@smartx.com>
Date: Fri, 17 Apr 2020 18:07:35 +0800
Message-ID: <CAHckoCx4brFwyq0Xz=FijRnuTfXgPzJGE+Pxb2F19EV_ijPksg@mail.gmail.com>
Subject: Fwd: [PATCH 4/4] vhost-user-blk: fix crash in realize process
To: Raphael Norwitz <raphael.norwitz@nutanix.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::a30
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
Cc: lifeng1519@gmail.com, Yang Fan <fanyang@smartx.com>,
 Kyle Zhang <kyle@smartx.com>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>,
 "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add mail group list.

Thank you, Raphael .

Raphael Norwitz <raphael.norwitz@nutanix.com> =E4=BA=8E2020=E5=B9=B44=E6=9C=
=8817=E6=97=A5=E5=91=A8=E4=BA=94 =E4=B8=8B=E5=8D=8812:10=E5=86=99=E9=81=93=
=EF=BC=9A
>
> Mostly looks good - just a few superficial notes.
>
> On Wed, Apr 15, 2020 at 11:28:26AM +0800, Li Feng wrote:
> > 1. set s->connected to true after vhost_dev_init;
> > 2. call vhost_dev_get_config when s->connected is true, otherwise the
> >     hdev->host_ops will be nullptr.
>
> You mean hdev->vhost_ops, right?
>
Yes.
> >
> > Signed-off-by: Li Feng <fengli@smartx.com>
> > ---
> >  hw/block/vhost-user-blk.c | 47 +++++++++++++++++++++++++--------------=
--------
> >  1 file changed, 25 insertions(+), 22 deletions(-)
> > +    /*
> > +     * set true util vhost_dev_init return ok, because CLOSE event may=
 happen
> > +     * in vhost_dev_init routine.
> > +     */
>
> I'm a little confused by this comment. Do you mean to say =E2=80=9Cwait u=
ntil vhost_dev_init
> succeeds to set connected to true, because a close event may happen while
> vhost_dev_init is executing=E2=80=9D?
Yes. This is the exception path:
qemu_chr_fe_set_handlers
   -> vhost_user_blk_event(OPEN)
       -> vhost_user_blk_connect
            -> vhost_dev_init
                -> vhost_user_blk_event(CLOSE)
                -> vhost_dev_cleanup
We should set connected to true only when vhost_dev_init returns OK.
If a close event is triggered, we shouldn't set connected to true.

--=20
The SmartX email address is only for business purpose. Any sent message=20
that is not related to the business is not authorized or permitted by=20
SmartX.
=E6=9C=AC=E9=82=AE=E7=AE=B1=E4=B8=BA=E5=8C=97=E4=BA=AC=E5=BF=97=E5=87=8C=E6=
=B5=B7=E7=BA=B3=E7=A7=91=E6=8A=80=E6=9C=89=E9=99=90=E5=85=AC=E5=8F=B8=EF=BC=
=88SmartX=EF=BC=89=E5=B7=A5=E4=BD=9C=E9=82=AE=E7=AE=B1. =E5=A6=82=E6=9C=AC=
=E9=82=AE=E7=AE=B1=E5=8F=91=E5=87=BA=E7=9A=84=E9=82=AE=E4=BB=B6=E4=B8=8E=E5=
=B7=A5=E4=BD=9C=E6=97=A0=E5=85=B3,=E8=AF=A5=E9=82=AE=E4=BB=B6=E6=9C=AA=E5=
=BE=97=E5=88=B0=E6=9C=AC=E5=85=AC=E5=8F=B8=E4=BB=BB=E4=BD=95=E7=9A=84=E6=98=
=8E=E7=A4=BA=E6=88=96=E9=BB=98=E7=A4=BA=E7=9A=84=E6=8E=88=E6=9D=83.



