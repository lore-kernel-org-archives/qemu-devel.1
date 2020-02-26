Return-Path: <SRS0=zj/5=4O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 918E0C4BA11
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 09:19:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 604E92084E
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 09:19:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JF6CCqdB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 604E92084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40786 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6srE-0004BS-Eh
	for qemu-devel@archiver.kernel.org; Wed, 26 Feb 2020 04:19:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38253)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <drjones@redhat.com>) id 1j6spM-0000qx-8v
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 04:18:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <drjones@redhat.com>) id 1j6spL-0006UI-8o
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 04:18:00 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:43982
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <drjones@redhat.com>) id 1j6spL-0006TV-5I
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 04:17:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582708678;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=v1x0zFotiGHLbWCwRHfYUDlZaAOKUXGwZLb+0Q8vy84=;
 b=JF6CCqdBa2sK4taCAL4+2JzAz2IbpCJ/KMTcrcfByvgZtEWEZrdqqxzPHzyQK66SsvfIX0
 U0acS5/TIaXAbdh/6EzuNEtScuHXHRxyvVyUd6VXjOd9mPnlPuQnFGAkJrt4NjOKMu5AL5
 mJ/LNIvFHgkHNyVZyz4KboZdt9ydEXo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-309-7X6ruzUtOTu3M7vwbEU89w-1; Wed, 26 Feb 2020 04:17:54 -0500
X-MC-Unique: 7X6ruzUtOTu3M7vwbEU89w-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 864B8800D5A;
 Wed, 26 Feb 2020 09:17:53 +0000 (UTC)
Received: from kamzik.brq.redhat.com (unknown [10.43.2.160])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 83CE292971;
 Wed, 26 Feb 2020 09:17:52 +0000 (UTC)
Date: Wed, 26 Feb 2020 10:17:50 +0100
From: Andrew Jones <drjones@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH] hw/intc/arm_gic_kvm: Don't assume kernel can provide a
 GICv2
Message-ID: <20200226091750.mqkbqffod247bori@kamzik.brq.redhat.com>
References: <20200225182435.1131-1-peter.maydell@linaro.org>
 <20200226085209.ni7oph6odt24warq@kamzik.brq.redhat.com>
 <CAFEAcA-Bhuy+2dU3joZoip5=tOkiTSoC+LzdNzyd+urUnoRNXw@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-Bhuy+2dU3joZoip5=tOkiTSoC+LzdNzyd+urUnoRNXw@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
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
Cc: Marc Zyngier <maz@kernel.org>, qemu-arm <qemu-arm@nongnu.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Feb 26, 2020 at 08:56:03AM +0000, Peter Maydell wrote:
> On Wed, 26 Feb 2020 at 08:52, Andrew Jones <drjones@redhat.com> wrote:
> > Although, many QEMU command line users still won't know what to do
> > without an explicit "Try -machine gic-version=3Dhost" hint, so that
> > might be nice to add too.
>=20
> In the GIC code we don't know if the machine even has a
> gic-version property, so we're not in the right place to try to
> produce that message.
>

Ah yes, we use qdev_init_nofail() in virt::create_gic(), so there's
no chance to append another hint at the machine level.

And what about when machine.gic-version is not provided and KVM is
in use? Shouldn't we try version '2', as we do now, but then also
'3', if '2' fails, before erroring out?

Thanks,
drew


