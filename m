Return-Path: <SRS0=PhvJ=UY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42D92C48BD6
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2019 20:57:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0B93A20663
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2019 20:57:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Waluhzwm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B93A20663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35216 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hfsVM-0001Oh-VK
	for qemu-devel@archiver.kernel.org; Tue, 25 Jun 2019 16:57:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53190)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <marcandre.lureau@gmail.com>) id 1hfsUM-0000xa-Cl
 for qemu-devel@nongnu.org; Tue, 25 Jun 2019 16:56:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcandre.lureau@gmail.com>) id 1hfsUK-0005oV-Bg
 for qemu-devel@nongnu.org; Tue, 25 Jun 2019 16:56:26 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:53770)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
 id 1hfsUH-0005jZ-Nr
 for qemu-devel@nongnu.org; Tue, 25 Jun 2019 16:56:23 -0400
Received: by mail-wm1-x342.google.com with SMTP id x15so229580wmj.3
 for <qemu-devel@nongnu.org>; Tue, 25 Jun 2019 13:56:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=7f9Q5YlzM/QTvCod6v4Xa81LTbKJnJm0q7DAqMKZxMI=;
 b=WaluhzwmibVlpvQR4c16t4EpSdqPWPTyu2E763MC3r0j7IrwUpyeM8NykIKUgtj3or
 6etwsO91ivD6B4OQALXQ+MZmMUt1QHg8M6CQcbk0oiU3EksFTO4/BBG9nLCBx/f0Ay07
 eLxZeI7mjvQ/WJzGdtbUuIYR3JW0N1G3peBRsnZUY4Y0Xcj5iKbgiHmabTBGK92dwpbD
 P5Li4ie2yhCbmjd6aUh56H7DS4s9o9ThcMm902/MwKFtmwzsoaLGQbvuMmmPk4iWS5c3
 YtuapRyKeJgzlaPBdCYqawkUX4aeVrF7baXPN3VY4sBaWMlEHSMGAlVthC0aub5n18gw
 S9Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=7f9Q5YlzM/QTvCod6v4Xa81LTbKJnJm0q7DAqMKZxMI=;
 b=XWBjOwKRVSrwO8TI4O1ubrV+YUAGeTvJi5F5QiRNCPb/AQmzqTO6H0atk6CVbWGRvu
 IxWQO+k3CljYoLe2CHXR8Va330SStwrDzzJlHKdCxOHcdkXqnTGuaQixo2DM3Zgof422
 gPslnhBk3w4tnCnIQSBJ0ODbgR2z7uhmPPrZUHFtfI5+TfsNSalZfD5KyA4RTVBPUTgr
 KvmyOVpQVIimh9jaZ6aayqgf6gfs7DzqUipObkpAa4Tkkp9evla1jVKuu2SesSh5UIqG
 lCkIDOpB4L2hyxIizkGWSdI/plpXGbFEFnhG6kA34wNO6iJyGUbxyU7gW8RpR3ZV5BDP
 laAA==
X-Gm-Message-State: APjAAAXUOftDWqwicd/yh5Pq88jUlLYnv98x2e3AJ8eairII+3hzLgXD
 GEGdujhiYmmRwH4fEte7FoMHdebrFPrBX4i34p83lgSt
X-Google-Smtp-Source: APXvYqxs2WPMdh7wAxR+0i5pbKVMQVPgWOqva419SudBMpXW82BssiOwJe7uQPw4uej7rOzersiH1zwhmUEkhm9FpmM=
X-Received: by 2002:a1c:be0a:: with SMTP id o10mr222298wmf.91.1561496177538;
 Tue, 25 Jun 2019 13:56:17 -0700 (PDT)
MIME-Version: 1.0
References: <20190529044020.27003-1-kraxel@redhat.com>
 <20190529044020.27003-9-kraxel@redhat.com>
 <af1192c3-1b56-eee3-35ef-25787f6ad67d@redhat.com>
In-Reply-To: <af1192c3-1b56-eee3-35ef-25787f6ad67d@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 25 Jun 2019 22:56:05 +0200
Message-ID: <CAJ+F1CJKBgw6ZE2Ja4NwpegSJCZ2_c+kM-w=3QfZHbeVfnE2vA@mail.gmail.com>
To: Laurent Vivier <lvivier@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
Subject: Re: [Qemu-devel] [PULL 8/9] virtio-gpu: split virtio-gpu-pci &
 virtio-vga
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, QEMU <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi

On Mon, Jun 24, 2019 at 5:53 PM Laurent Vivier <lvivier@redhat.com> wrote:
>
> On 29/05/2019 06:40, Gerd Hoffmann wrote:
> > From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> >
> > Add base classes that are common to vhost-user-gpu-pci and
> > vhost-user-vga.
> >
> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > Message-id: 20190524130946.31736-9-marcandre.lureau@redhat.com
> > Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> > ---
> >  hw/display/virtio-vga.h     |  32 +++++++++
> >  hw/display/virtio-gpu-pci.c |  52 +++++++++-----
> >  hw/display/virtio-vga.c     | 135 ++++++++++++++++++------------------
> >  MAINTAINERS                 |   2 +-
> >  4 files changed, 137 insertions(+), 84 deletions(-)
> >  create mode 100644 hw/display/virtio-vga.h
> >
>
> This patch breaks something in the migration (no need of an OS, tested du=
ring SLOF sequence).
>
> Tested between v4.0.0 and master.
>
> v4.0.0: ppc64-softmmu/qemu-system-ppc64 -machine pseries-4.0 \
>                                         -device virtio-gpu-pci \
>                                         -serial mon:stdio -incoming tcp:0=
:4444
>
> master: ppc64-softmmu/qemu-system-ppc64 -machine pseries-4.0 \
>                                         -device virtio-gpu-pci \
>                                         -serial mon:stdio
>
>
> master: (qemu) migrate tcp:localhost:4444
>
> v4.0.0:
>
>   qemu-system-ppc64: get_pci_config_device: Bad config data: i=3D0x34 rea=
d: 98 device: 84 cmask: ff wmask: 0 w1cmask:0
>   qemu-system-ppc64: Failed to load PCIDevice:config
>   qemu-system-ppc64: Failed to load virtio-gpu:virtio
>   qemu-system-ppc64: error while loading state for instance 0x0 of device=
 'pci@800000020000000:02.0/virtio-gpu'
>   qemu-system-ppc64: load of migration failed: Invalid argument
>
> Is this something known?

Thanks for the report, I wasn't aware of it.

The problem actually started from:

commit a4ee4c8baa37154f42b4dc6a13fee79268d15238
Author: Eduardo Habkost <ehabkost@redhat.com>
Date:   Wed Dec 5 17:57:03 2018 -0200

    virtio: Helper for registering virtio device types


Since that commit virtio_gpu_pci_properties got lost (overwritten in
virtio_pci_generic_class_init), and thus the PCI device changed (bar1
missing etc).

My patches actually restored it as a side effect of defining a new base cla=
ss.

There are other devices affected with missing vectors and ioeventfd
(and sometime a few others props): virtio-crypto-pci, virtio-9p-pci,
vhost-user-blk-pci and more. They probably suffer similar migration
issues.

Given that this is a 4.0 regression, I think we should fix the
remaining devices, and backport fixes to 4.0-stable. I am looking at
it




--
Marc-Andr=C3=A9 Lureau

