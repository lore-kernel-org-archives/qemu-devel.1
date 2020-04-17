Return-Path: <SRS0=Zx28=6B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A635C352BE
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2020 10:12:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E990821D91
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2020 10:12:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=smartx-com.20150623.gappssmtp.com header.i=@smartx-com.20150623.gappssmtp.com header.b="dq6Teatb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E990821D91
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=smartx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44962 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jPNzQ-000792-2f
	for qemu-devel@archiver.kernel.org; Fri, 17 Apr 2020 06:12:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36203)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <fengli@smartx.com>) id 1jPNym-0006Vu-WD
 for qemu-devel@nongnu.org; Fri, 17 Apr 2020 06:12:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <fengli@smartx.com>) id 1jPNyl-0005Dw-Lj
 for qemu-devel@nongnu.org; Fri, 17 Apr 2020 06:12:12 -0400
Received: from mail-vs1-xe43.google.com ([2607:f8b0:4864:20::e43]:40545)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <fengli@smartx.com>) id 1jPNyl-0005Cy-HP
 for qemu-devel@nongnu.org; Fri, 17 Apr 2020 06:12:11 -0400
Received: by mail-vs1-xe43.google.com with SMTP id t189so821291vst.7
 for <qemu-devel@nongnu.org>; Fri, 17 Apr 2020 03:12:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=yAtVkugZDCn6+kbdRkckzOFgWwo0cPkVc3m43X/+PjU=;
 b=dq6Teatbg+yKPxhF39/qTnwmd9owDfQQf4IBwwkB15wITvK981nHmJVP/gvc9rqwRH
 6kX5PqQkRWz4cmca6TLcMwbI0NO6BT5rCdhycYFfMVClMlLBWW6FiauJXcFVutZfp9qo
 59PJC3d2IQGYncyBoe6B9p+KTaozBQHaVpBT/b9tPJHm3p++9duIe/HNuZcPt2BhYFje
 cBLhdnH1Ka7Oj0/8PVkmyt+5Lpc0SqelbWQWd4s/LqbImv770FU5CwxjQVjaP/PWCopa
 V/OwxAsSWvmYbJLB2Di1/Z7ZQufy3QC45unjjfiecpuh9MjfF4tJX7LQ/4Dia0Cn9Q/E
 HHJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=yAtVkugZDCn6+kbdRkckzOFgWwo0cPkVc3m43X/+PjU=;
 b=mqKbbQCiCl0t48mfsRlfQEkIjzylC9Ntud82D1ddsj0LYUHOH24LSPMnXS3FFqzVeb
 ugX0X9P4byqyWgt03wRj+xUfoZdAcOcqxYyoKjUgkcOKYc/3RBeRsqwv2pLCAWjtzQEC
 2Gg5Y76Mx/RPCV152OjQancf5pyLsanUmCw9xwkzNPtJiu00wq05OPjupGzP/Xhsvq0v
 AAA/UFqD5NbALlinqEea4054z4PEFAaNo87bn+WIhOLr/2qlYQIPDKtOwQSfCgo2Is/y
 EYs4ZT9lvGYHlPJVTvtxq54iXmVkoS1vIwgca85s3gL82k6nJlYhF8rrQUHdKpzVlOd7
 4W9A==
X-Gm-Message-State: AGi0PuZh+9UlAUPFHHzzIHCVaz+SHp/KUQExfGLgDSB/zEQXUv0/qM+3
 7AvjfLuXBDLKzEgMhvser+y+bO3kZHOrlTQyh820ZFY7uDP2c7WUHgZCTkPJnKnwMdYCaLut+Jf
 o55M42DsiDO3G9ppv4iwL+YUN
X-Google-Smtp-Source: APiQypIyADSJG/CNnx9i8SuI0k8rUixRJr2axXIOZxn7IoLemWDPN2Kml3A/YaxH9SD6NFVsFWjfnvlWdmsuJTTL6RE=
X-Received: by 2002:a67:d61c:: with SMTP id n28mr1641521vsj.70.1587118330299; 
 Fri, 17 Apr 2020 03:12:10 -0700 (PDT)
MIME-Version: 1.0
References: <20200415032826.16701-1-fengli@smartx.com>
 <20200417054439-mutt-send-email-mst@kernel.org>
In-Reply-To: <20200417054439-mutt-send-email-mst@kernel.org>
From: Li Feng <fengli@smartx.com>
Date: Fri, 17 Apr 2020 18:11:59 +0800
Message-ID: <CAHckoCxtB_-4+vu3CKtuNcEYDoj070SZG-9bn99GWY7yntCn+g@mail.gmail.com>
Subject: Re: [PATCH 0/4] fix crashes when inject errors to vhost-user-blk
 chardev
To: "Michael S. Tsirkin" <mst@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::e43
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
Cc: Kevin Wolf <kwolf@redhat.com>, lifeng1519@gmail.com,
 Yang Fan <fanyang@smartx.com>,
 "open list:Block layer core" <qemu-block@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>,
 Max Reitz <mreitz@redhat.com>, Kyle Zhang <kyle@smartx.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

OK, I will submit this patch "vhost-user-blk: fix invalid memory
access" firstly.
This is unrelated with other three and it has been acked.

Thanks,
Feng Li

Michael S. Tsirkin <mst@redhat.com> =E4=BA=8E2020=E5=B9=B44=E6=9C=8817=E6=
=97=A5=E5=91=A8=E4=BA=94 =E4=B8=8B=E5=8D=885:45=E5=86=99=E9=81=93=EF=BC=9A
>
> On Wed, Apr 15, 2020 at 11:28:22AM +0800, Li Feng wrote:
> > The following patches fix various crashes happened when injecting error=
s to
> > chardev unix domain socket.
>
> I think these are mostly unrelated fixes right?
> If so pls post them separately so I know I can just apply
> some and wait for others to get acked.
>
>
> > The crashes are encountered when the socket is from connected to discon=
nected at
> > vhost-user-blk realize routine.
> >
> > These crashes could be reproduced like this:
> > 1. gdb break at vhost_user_write;
> > 2. add a vhost-user-blk device through qmp;
> > 3. when stop at vhost_user_write, kill the vhost-user-blk target;
> > 3. let qemu continue running;
> > 4. start vhost-user-blk;
> > 5. see crash!
> >
> > The 'CLOSE' event path is core trouble maker.
> >
> > qemu_chr_fe_set_handlers
> >    -> vhost_user_blk_event(OPEN)
> >        -> vhost_user_blk_connect
> >             -> vhost_dev_init
> >                 -> vhost_user_blk_event(CLOSE)
> >                 -> vhost_dev_cleanup
> >
> >
> > Li Feng (4):
> >   vhost-user-blk: delay vhost_user_blk_disconnect
> >   vhost-user-blk: fix invalid memory access
> >   char-socket: avoid double call tcp_chr_free_connection
> >   vhost-user-blk: fix crash in realize process
> >
> >  chardev/char-socket.c     |  5 ++++
> >  hw/block/vhost-user-blk.c | 75 ++++++++++++++++++++++++++++++++-------=
--------
> >  hw/virtio/vhost.c         |  2 +-
> >  3 files changed, 58 insertions(+), 24 deletions(-)
> >
> > --
> > 2.11.0
> >
> >
> > --
> > The SmartX email address is only for business purpose. Any sent message
> > that is not related to the business is not authorized or permitted by
> > SmartX.
> > =E6=9C=AC=E9=82=AE=E7=AE=B1=E4=B8=BA=E5=8C=97=E4=BA=AC=E5=BF=97=E5=87=
=8C=E6=B5=B7=E7=BA=B3=E7=A7=91=E6=8A=80=E6=9C=89=E9=99=90=E5=85=AC=E5=8F=B8=
=EF=BC=88SmartX=EF=BC=89=E5=B7=A5=E4=BD=9C=E9=82=AE=E7=AE=B1. =E5=A6=82=E6=
=9C=AC=E9=82=AE=E7=AE=B1=E5=8F=91=E5=87=BA=E7=9A=84=E9=82=AE=E4=BB=B6=E4=B8=
=8E=E5=B7=A5=E4=BD=9C=E6=97=A0=E5=85=B3,=E8=AF=A5=E9=82=AE=E4=BB=B6=E6=9C=
=AA=E5=BE=97=E5=88=B0=E6=9C=AC=E5=85=AC=E5=8F=B8=E4=BB=BB=E4=BD=95=E7=9A=84=
=E6=98=8E=E7=A4=BA=E6=88=96=E9=BB=98=E7=A4=BA=E7=9A=84=E6=8E=88=E6=9D=83.
> >
>

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



