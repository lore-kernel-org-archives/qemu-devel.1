Return-Path: <SRS0=Dj2y=5L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15F10C43331
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 12:51:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D34D72073E
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 12:51:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Zz3JBwll"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D34D72073E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50952 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHRz3-0004gC-TP
	for qemu-devel@archiver.kernel.org; Thu, 26 Mar 2020 08:51:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47994)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1jHRyJ-00048C-Oz
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 08:50:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1jHRyH-0001bT-A6
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 08:50:54 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:51034)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1jHRyH-0001ae-47
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 08:50:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585227052;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dA28eh035IF+q5mF3wuOfuLdoVrT+QnaPGUuj5iUHTc=;
 b=Zz3JBwllNeTqFrtS/MYe3a1e+yoSTbQE+qkLQp6GRZ+KnJ4Zziep7jng0Z3OIjxYKR70XL
 sTw+ngZnFKsqw8wz2KAxMoKtaMErZx65SfDlHq76PV7qEpttPzQUpheLVpXt282orr6G07
 HfnEJapY6ns3bz8nGybRtq+fFVL0+jY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-287-nvT5C2OENsq8fKRO54LRfA-1; Thu, 26 Mar 2020 08:50:48 -0400
X-MC-Unique: nvT5C2OENsq8fKRO54LRfA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A6F0FDBA6;
 Thu, 26 Mar 2020 12:50:47 +0000 (UTC)
Received: from localhost (unknown [10.40.208.76])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D60595D9CD;
 Thu, 26 Mar 2020 12:50:43 +0000 (UTC)
Date: Thu, 26 Mar 2020 13:50:41 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: acpi_pcihp_eject_slot() bug if passed 'slots == 0'
Message-ID: <20200326135041.297de118@redhat.com>
In-Reply-To: <20200326132901.7aecb9e5@redhat.com>
References: <CAFEAcA-oWBjOXWmnLvPww9wrty_QbSc+Xv3BY3sQAnEXFkfQbA@mail.gmail.com>
 <20200326132901.7aecb9e5@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 216.205.24.74
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
Cc: QEMU Developers <qemu-devel@nongnu.org>,
 "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 26 Mar 2020 13:29:01 +0100
Igor Mammedov <imammedo@redhat.com> wrote:

> On Thu, 26 Mar 2020 11:52:36 +0000
> Peter Maydell <peter.maydell@linaro.org> wrote:
> 
> > Hi; Coverity spots that if hw/acpi/pcihp.c:acpi_pcihp_eject_slot()
> > is passed a zero 'slots' argument then ctz32(slots) will return 32,
> > and then the code that does '1U << slot' is C undefined behaviour
> > because it's an oversized shift. (This is CID 1421896.)
> > 
> > Since the pci_write() function in this file can call
> > acpi_pcihp_eject_slot() with an arbitrary value from the guest,
> > I think we need to handle 'slots == 0' safely. But what should
> > the behaviour be?  
> 
> 0 is not valid value, we should ignore and return early in this case
> like we do with bsel. I'll post a path shortly.
well, looking more that is only true for main bus, for bridges it can be
slot number can be zero, then AML left shifts it and writes into B0EJ
which traps into pci_write(, data) and that is supposed to eject
slot 0 according to guest(AML).

Michael,
what's your take on it?

> 
> > 
> > thanks
> > -- PMM
> >   
> 
> 


