Return-Path: <SRS0=6DzB=ZD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA2BBC43331
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Nov 2019 10:19:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A2F59206BB
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Nov 2019 10:19:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hWJ0uE9r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2F59206BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50516 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iU6nb-0008U5-Ql
	for qemu-devel@archiver.kernel.org; Mon, 11 Nov 2019 05:19:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47513)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1iU6ln-0006xm-0O
 for qemu-devel@nongnu.org; Mon, 11 Nov 2019 05:18:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1iU6ll-0000oN-Rg
 for qemu-devel@nongnu.org; Mon, 11 Nov 2019 05:18:02 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:35874
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1iU6ll-0000o1-OC
 for qemu-devel@nongnu.org; Mon, 11 Nov 2019 05:18:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573467481;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/Z09O5HzS6QdzWa8EDPWyd2SK3M6EQ4wvljJa2g7nCc=;
 b=hWJ0uE9rhZ9zv7G8J6mlSLhPgUqa9R4A+r0eel2XsqaEj93spUpkRSWJlpnN4w0F470FJk
 5WuLII2SeqLgR/xhxmJ1VugaerApvroroaNL0HUfcfDX53BReP7j4wD0fCVKf4iNd+oeAn
 X87+V2v2doteVWDN2qGZSZQmOzAjhz4=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-12-k1v7DQ-HOzy2fSlLtGvsdA-1; Mon, 11 Nov 2019 05:16:47 -0500
Received: by mail-qv1-f72.google.com with SMTP id m43so2392974qvc.17
 for <qemu-devel@nongnu.org>; Mon, 11 Nov 2019 02:16:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=uEKmjpMzFxYdumZRbv8JATTBMMWBUbghULtgERy0pbo=;
 b=Gk4fg/AtXFmjzh2I2MaVqC+IhuAau2EW4TJRoy4BthaJtk/HAOGGMknsiAc9l6LTTJ
 JBnpzsYgk5yZ/b4uo/NGmGlWPLVV/cu+C9HrEoM/smG5UBSzrzxatrxt7ZLSyTV/7M+S
 PPCgP8/aQZdxyo3cY9nFD0lLcV+1In42byz3FB3P7Vy8mvgEx+zO+LVbW9SqN6LQk7cx
 j6joAit4l0UEXJozh5HWPbqFkino4qmINvtepa1lJwZ0sbl3O9YKvaYLp5ahH4vrILnb
 sOeIs6ZWJ8KDrmaxHvLM5+z2/QFdPVbP1e785AJjcGVNyR43atMYxZLPwOcKpR6HdxNo
 C1uw==
X-Gm-Message-State: APjAAAV+20l3LPDhaCrHuzgft3jSk8am0j5bztlWP0IXu/c/P3bGkBpQ
 VFjPErFIsvmuIvI9kXur0GX6uRGa1WjJhJoYnrUThMHpAEyt4wnNTVqbjVKl/lP4kwNsJ0tsSI0
 Rn64Ma5M59sJyWLg=
X-Received: by 2002:aed:2be2:: with SMTP id e89mr24523497qtd.161.1573467407530; 
 Mon, 11 Nov 2019 02:16:47 -0800 (PST)
X-Google-Smtp-Source: APXvYqyabDfL13W7SFtZyi7lBn3grH+4StX5UEIa479Fraj/bPzTyMc4miKFbqkFuFg3CpBLXTRIdA==
X-Received: by 2002:aed:2be2:: with SMTP id e89mr24523488qtd.161.1573467407361; 
 Mon, 11 Nov 2019 02:16:47 -0800 (PST)
Received: from redhat.com (bzq-79-176-6-42.red.bezeqint.net. [79.176.6.42])
 by smtp.gmail.com with ESMTPSA id w30sm8865823qtc.47.2019.11.11.02.16.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Nov 2019 02:16:46 -0800 (PST)
Date: Mon, 11 Nov 2019 05:16:41 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Klaus Birkelund <its@irrelevant.dk>
Subject: Re: [PATCH 1/1] pci: pass along the return value of dma_memory_rw
Message-ID: <20191111051055-mutt-send-email-mst@kernel.org>
References: <20191011070141.188713-1-its@irrelevant.dk>
 <20191011070141.188713-2-its@irrelevant.dk>
 <455e6dee-8dd8-fae7-5a2f-e175b9d1cb8d@redhat.com>
 <20191111093007.GA109346@apples.localdomain>
MIME-Version: 1.0
In-Reply-To: <20191111093007.GA109346@apples.localdomain>
X-MC-Unique: k1v7DQ-HOzy2fSlLtGvsdA-1
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

On Mon, Nov 11, 2019 at 10:30:07AM +0100, Klaus Birkelund wrote:
> On Thu, Oct 24, 2019 at 01:13:36AM +0200, Philippe Mathieu-Daud=E9 wrote:
> > On 10/11/19 9:01 AM, Klaus Jensen wrote:
> > > Some might actually care about the return value of dma_memory_rw. So
> > > let us pass it along instead of ignoring it.
> > >=20
> > > Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
> > > ---
> > >   include/hw/pci/pci.h | 3 +--
> > >   1 file changed, 1 insertion(+), 2 deletions(-)
> > >=20
> > > diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
> > > index f3f0ffd5fb78..4e95bb847857 100644
> > > --- a/include/hw/pci/pci.h
> > > +++ b/include/hw/pci/pci.h
> > > @@ -779,8 +779,7 @@ static inline AddressSpace *pci_get_address_space=
(PCIDevice *dev)
> > >   static inline int pci_dma_rw(PCIDevice *dev, dma_addr_t addr,
> > >                                void *buf, dma_addr_t len, DMADirectio=
n dir)
> > >   {
> > > -    dma_memory_rw(pci_get_address_space(dev), addr, buf, len, dir);
> > > -    return 0;
> > > +    return dma_memory_rw(pci_get_address_space(dev), addr, buf, len,=
 dir);
> > >   }
> > >   static inline int pci_dma_read(PCIDevice *dev, dma_addr_t addr,
> > >=20
> >=20
> > Reviewed-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>
>=20
> Gentle ping on this.
>=20
> This fix is required for the nvme device to start passing some of the
> nasty tests from blktests that flips bus mastering while doing I/O.
>=20
>=20
> Cheers,
> Klaus

So I looked and it does not seem like anyone at all checks the
return value. While this makes the patch safe, how come it
helps anyone at all?
Maybe this is just infrastructure to allow checks in the
future, in this case do we need this for the freeze?
Or can it wait until after the release?

--=20
MST


