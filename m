Return-Path: <SRS0=6DzB=ZD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2DBEC43331
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Nov 2019 11:01:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C72F20679
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Nov 2019 11:01:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g8AljXmC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C72F20679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51028 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iU7S5-0003nU-Dz
	for qemu-devel@archiver.kernel.org; Mon, 11 Nov 2019 06:01:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54258)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1iU7RG-0003Fx-8b
 for qemu-devel@nongnu.org; Mon, 11 Nov 2019 06:00:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1iU7RE-0002RF-A1
 for qemu-devel@nongnu.org; Mon, 11 Nov 2019 06:00:54 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:52576)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1iU7RD-0002Qx-FW
 for qemu-devel@nongnu.org; Mon, 11 Nov 2019 06:00:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573470051;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XIEWfmvIm0tEcRtDcm2XQfaWLtsh8QXMBvEPxGTGgq8=;
 b=g8AljXmCCM/4BZcc9/IOavhLC5urq+tmXNDUjFV71fLWupta8sdoQhbjcBWa/z+22ksJ4A
 yJaZ077Zbdrt3EOA5eJaMo2kVqg63QD+dOd0A3Ec4FBVKnwoER/L//hrRcK4MR0MhXct7V
 uHWs/ToUsH3UdzWn91KsgM4YI2bpN30=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-7-cju-yK_5P1afJLuneaVU1A-1; Mon, 11 Nov 2019 06:00:49 -0500
Received: by mail-qk1-f199.google.com with SMTP id p68so7492178qkf.9
 for <qemu-devel@nongnu.org>; Mon, 11 Nov 2019 03:00:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=2Xj9aea6wb6RLR9vsXkWm7CGkGs1SIpe2jL/vXoFpH8=;
 b=GGFOEbN1dAhMMdWj8lHSMMDIEllKM+z/r41Tjum0r2iAO2iO2BbP1Rru4FxlBrT6oV
 7XY7Yj//qIK/8aX1OG2pbIfDVpBhCL7tTuj+kOFfcXlqUXWaeDU5Vr83qHtcUCB2Noul
 hQoOX+f3gV1oZTG8H/S6iGRrdjRaMEKy6nKE3H8Tmgxqwqw2n+Jo/W+5D/8CiMGxJIw0
 cl0CBHgva04E+E9v4VnM9yiCY3+gJ+9bCNCCrmGpu0rVDiyvp4vQxWvMsF17/I/zfeKL
 o7Tf54+jQ1uwE9PCVIK8TjiI+hVxOUkGrBjRRHBjGzjRWR5pDKGBmydBiKebdiVXG0Td
 t3mQ==
X-Gm-Message-State: APjAAAUK5LZsMzeQ1rLJkSZq76Yk7ovlqrYAy7MnJ6+LyD+ySZcKRpz0
 3nUeGDobfzWc2IKCZe7N+E95wUZihzq45CixTDDZ+b1rUYgsZl5EtpRWV6yG4e6XyIAK8ZredP1
 rRE9uoxyE6MSfK8c=
X-Received: by 2002:a05:620a:13c4:: with SMTP id
 g4mr9762369qkl.391.1573470049361; 
 Mon, 11 Nov 2019 03:00:49 -0800 (PST)
X-Google-Smtp-Source: APXvYqwjX8w1RxqYTNpy6Z2g9reltmp97dhB7ECGoJr3YNRLqThuiHiuazcqKuHqWAQ1SYw5cnOwdg==
X-Received: by 2002:a05:620a:13c4:: with SMTP id
 g4mr9762346qkl.391.1573470049038; 
 Mon, 11 Nov 2019 03:00:49 -0800 (PST)
Received: from redhat.com (bzq-79-176-6-42.red.bezeqint.net. [79.176.6.42])
 by smtp.gmail.com with ESMTPSA id f39sm8018285qtb.26.2019.11.11.03.00.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Nov 2019 03:00:48 -0800 (PST)
Date: Mon, 11 Nov 2019 06:00:42 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Klaus Birkelund <its@irrelevant.dk>
Subject: Re: [PATCH 1/1] pci: pass along the return value of dma_memory_rw
Message-ID: <20191111055959-mutt-send-email-mst@kernel.org>
References: <20191011070141.188713-1-its@irrelevant.dk>
 <20191011070141.188713-2-its@irrelevant.dk>
 <455e6dee-8dd8-fae7-5a2f-e175b9d1cb8d@redhat.com>
 <20191111093007.GA109346@apples.localdomain>
 <20191111051055-mutt-send-email-mst@kernel.org>
 <20191111103317.GA238995@apples.localdomain>
MIME-Version: 1.0
In-Reply-To: <20191111103317.GA238995@apples.localdomain>
X-MC-Unique: cju-yK_5P1afJLuneaVU1A-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
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
Cc: QEMU Trivial <qemu-trivial@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Nov 11, 2019 at 11:33:17AM +0100, Klaus Birkelund wrote:
> On Mon, Nov 11, 2019 at 05:16:41AM -0500, Michael S. Tsirkin wrote:
> > On Mon, Nov 11, 2019 at 10:30:07AM +0100, Klaus Birkelund wrote:
> > > On Thu, Oct 24, 2019 at 01:13:36AM +0200, Philippe Mathieu-Daud=E9 wr=
ote:
> > > > On 10/11/19 9:01 AM, Klaus Jensen wrote:
> > > > > Some might actually care about the return value of dma_memory_rw.=
 So
> > > > > let us pass it along instead of ignoring it.
> > > > >=20
> > > > > Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
> > > > > ---
> > > > >   include/hw/pci/pci.h | 3 +--
> > > > >   1 file changed, 1 insertion(+), 2 deletions(-)
> > > > >=20
> > > > > diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
> > > > > index f3f0ffd5fb78..4e95bb847857 100644
> > > > > --- a/include/hw/pci/pci.h
> > > > > +++ b/include/hw/pci/pci.h
> > > > > @@ -779,8 +779,7 @@ static inline AddressSpace *pci_get_address_s=
pace(PCIDevice *dev)
> > > > >   static inline int pci_dma_rw(PCIDevice *dev, dma_addr_t addr,
> > > > >                                void *buf, dma_addr_t len, DMADire=
ction dir)
> > > > >   {
> > > > > -    dma_memory_rw(pci_get_address_space(dev), addr, buf, len, di=
r);
> > > > > -    return 0;
> > > > > +    return dma_memory_rw(pci_get_address_space(dev), addr, buf, =
len, dir);
> > > > >   }
> > > > >   static inline int pci_dma_read(PCIDevice *dev, dma_addr_t addr,
> > > > >=20
> > > >=20
> > > > Reviewed-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>
> > >=20
> > > Gentle ping on this.
> > >=20
> > > This fix is required for the nvme device to start passing some of the
> > > nasty tests from blktests that flips bus mastering while doing I/O.
> > >=20
> > >=20
> > > Cheers,
> > > Klaus
> >=20
> > So I looked and it does not seem like anyone at all checks the
> > return value. While this makes the patch safe, how come it
> > helps anyone at all?
>=20
> I have a series[1] under review for the nvme device (I should have
> mentioned that). There is a certain test (block/011) from blktests[2],
> that disables the PCI device while doing I/O by flipping the bus master
> register. QEMU correctly understands this which causes the dma_memory_rw
> calls to fail while the device is not a bus master. For the NVMe device
> to pass that test, it needs to know that it could not do the DMA,
> otherwise it will just think that a completion queue entry was
> successfully posted or data was correctly read.
>=20
> > Maybe this is just infrastructure to allow checks in the
> > future, in this case do we need this for the freeze?
> > Or can it wait until after the release?
> >=20
>=20
> The series I'm mentioning won't be going into the release, so yeah - it
> can surely wait. I was just pinging to make sure someone would pick it
> up at some point :)
> =20
>     [1]: https://patchwork.kernel.org/cover/11190045/
>     [2]: https://github.com/osandov/blktests

It's probably best to just include it in the series.
When you do feel free to include

Reviewed-by: Michael S. Tsirkin <mst@redhat.com>

and mention that the return code has no existing
users so it's safe to change.


