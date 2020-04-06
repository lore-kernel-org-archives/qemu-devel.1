Return-Path: <SRS0=By5p=5W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6547DC2BA19
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2020 12:18:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F767208E4
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2020 12:18:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OvyOKW1n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F767208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59496 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jLQhx-0006ru-BL
	for qemu-devel@archiver.kernel.org; Mon, 06 Apr 2020 08:18:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39436)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1jLQhF-0006Na-8v
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 08:17:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1jLQhE-0000EB-5N
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 08:17:45 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:25761
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1jLQhE-0000DR-1f
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 08:17:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1586175463;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7g2kGVN11f2hjwa108QxOoDTcbkZoYTXX/ylc9bm8ho=;
 b=OvyOKW1nY012vkuPNqfi4rphTciUXyeifGvLc3THXv/1P/iVnGaPoXRX/fDIWajd75H4X/
 PjZlHsI0Pn8lC1tjykwOPlJhsnq5hDQPh3pFz8Vh40QaZX1CfPjuVt7UA0W2lRRLdSRss4
 nRDLtlVi7Qc+sJzIlwduL1FcZ4bBTQE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-447-OgPnRytnMtui0UhbqRidHQ-1; Mon, 06 Apr 2020 08:17:41 -0400
X-MC-Unique: OgPnRytnMtui0UhbqRidHQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 81BCE18A8C81;
 Mon,  6 Apr 2020 12:17:40 +0000 (UTC)
Received: from localhost (unknown [10.40.208.65])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 88F88BEA62;
 Mon,  6 Apr 2020 12:17:07 +0000 (UTC)
Date: Mon, 6 Apr 2020 14:17:05 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH v2 07/12] acpi: move aml builder code for rtc device
Message-ID: <20200406141705.77d90b68@redhat.com>
In-Reply-To: <20200406082517.uyz7zv4jiqqjbcli@sirius.home.kraxel.org>
References: <20200403080502.8154-1-kraxel@redhat.com>
 <20200403080502.8154-8-kraxel@redhat.com>
 <20200403120921.258db9a5@redhat.com>
 <20200406082517.uyz7zv4jiqqjbcli@sirius.home.kraxel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: Kevin Wolf <kwolf@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 qemu-block@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?B?TWFy?= =?UTF-8?B?Yy1BbmRyw6k=?= Lureau <marcandre.lureau@redhat.com>,
 John Snow <jsnow@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 6 Apr 2020 10:25:17 +0200
Gerd Hoffmann <kraxel@redhat.com> wrote:

> On Fri, Apr 03, 2020 at 12:09:21PM +0200, Igor Mammedov wrote:
> > On Fri,  3 Apr 2020 10:04:57 +0200
> > Gerd Hoffmann <kraxel@redhat.com> wrote:
> >   
> > > Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> > > ---  
> > [...]  
> > > +static void rtc_build_aml(ISADevice *isadev, Aml *scope)
> > > +{
> > > +    Aml *dev;
> > > +    Aml *crs;
> > > +
> > > +    crs = aml_resource_template();
> > > +    aml_append(crs, aml_io(AML_DECODE16, 0x0070, 0x0070, 0x10, 0x02));
> > > +    aml_append(crs, aml_irq_no_flags(8));
> > > +    aml_append(crs, aml_io(AML_DECODE16, 0x0072, 0x0072, 0x02, 0x06));  
> > 
> > since this is made a part of device, can we fetch io port values from
> > device instead of hard-codding values here?  
> 
> No, the rtc device hasn't a configurable io port address.
what I'm after is consistent code, so if we switch to taking
io_base/irq from ISA device, then do it everywhere.
So we don't have a zoo of devices doing the same thing in multiple
ways.

> 
> cheers,
>   Gerd
> 


