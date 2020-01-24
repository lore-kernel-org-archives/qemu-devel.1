Return-Path: <SRS0=z9mi=3N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50D5AC2D0CE
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2020 08:14:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 158932075D
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2020 08:14:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bD2XDEUS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 158932075D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38596 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuu6c-0004ZD-A4
	for qemu-devel@archiver.kernel.org; Fri, 24 Jan 2020 03:14:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49508)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1iuu5x-00045o-3C
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 03:13:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1iuu5v-0003FR-Jx
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 03:13:36 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:28478
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1iuu5v-0003Eu-Ga
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 03:13:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579853614;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RN9gaUQxuiWX0SOWadJplqQzr2RZtazK7KKNhKD2M2M=;
 b=bD2XDEUS27Hjn1kWCd8qcLhxfvmL9FV0a2Oks4Q02HbStY4ECAOeya0pQ0w0fgT2TRDzFp
 KoH+JZo9raIrWnVaB12HGxZRo105FtY1T+JsfAdV57fYX4M9j9SW4TMPnfg4uNEGWU6Ong
 ejP/I5rX6/TfjUK7/e3jE570stdwExA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-218-sQvDns2ZOqC0g36Wf3a37w-1; Fri, 24 Jan 2020 03:13:31 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 088E0100550E;
 Fri, 24 Jan 2020 08:13:30 +0000 (UTC)
Received: from localhost (unknown [10.43.2.114])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 803DC86CCC;
 Fri, 24 Jan 2020 08:13:29 +0000 (UTC)
Date: Fri, 24 Jan 2020 09:13:27 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: BALATON Zoltan <balaton@eik.bme.hu>
Subject: Re: [PATCH REPOST v3 06/80] alpha:dp264: use memdev for RAM
Message-ID: <20200124091327.30083143@redhat.com>
In-Reply-To: <alpine.BSF.2.21.99999.352.2001231605230.72857@zero.eik.bme.hu>
References: <1579779525-20065-1-git-send-email-imammedo@redhat.com>
 <1579779525-20065-7-git-send-email-imammedo@redhat.com>
 <alpine.BSF.2.21.99999.352.2001231605230.72857@zero.eik.bme.hu>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: sQvDns2ZOqC0g36Wf3a37w-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 23 Jan 2020 16:07:19 +0100 (CET)
BALATON Zoltan <balaton@eik.bme.hu> wrote:

> On Thu, 23 Jan 2020, Igor Mammedov wrote:
> > memory_region_allocate_system_memory() API is going away, so
> > replace it with memdev allocated MemoryRegion. The later is
> > initialized by generic code, so board only needs to opt in
> > to memdev scheme by providing
> >  MachineClass::default_ram_id
> > and using MachineState::ram instead of manually initializing
> > RAM memory region.
> >
> > Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> > Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> > Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> > Acked-by: Richard Henderson <richard.henderson@linaro.org>
> > ---
> > hw/alpha/alpha_sys.h | 2 +-
> > hw/alpha/dp264.c     | 3 ++-
> > hw/alpha/typhoon.c   | 8 ++------
> > 3 files changed, 5 insertions(+), 8 deletions(-) =20
>=20
> This still has a : instead of / in the patch title. Maybe should be=20
> alpha/dp264: ... Probably does not worth a respin but you could correct i=
t=20
> if there will be another version for some other reason or when applying=
=20
I plan to respin series, so it will be fixed up in v4

Thanks

> it.
>=20
> Regrards,
> BALATON Zoltan


