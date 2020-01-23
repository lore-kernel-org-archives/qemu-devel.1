Return-Path: <SRS0=mO9Z=3M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40EBCC2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 14:13:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 09C6E2087E
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 14:13:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EW7trAUz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09C6E2087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57766 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iudER-0002bH-Ld
	for qemu-devel@archiver.kernel.org; Thu, 23 Jan 2020 09:13:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54073)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <drjones@redhat.com>) id 1iubn0-0003ou-6C
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 07:40:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <drjones@redhat.com>) id 1iubmy-0002GJ-Ot
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 07:40:50 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:45354
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <drjones@redhat.com>) id 1iubmy-0002Ev-Kd
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 07:40:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579783248;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CeuFK25U9RHqFoRab+T9Ogkit/2+wkjDCN/atYUZSmM=;
 b=EW7trAUzHUJVIpXuU4IAAf7X8S6Ct/hTVkeSOyC4UrEWiJ1X/GULgSz5I3c8qQrONGNswL
 Iy8SGXsLVuQffHPkQ0HNpFFDtzJBHghU1PL4+BmP1oXMOEUZY5HsYF8G2H37NkiZ8Sog3h
 mepdU6XkHYUwQcXbIrgGwA8w5leu770=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-257-gOUWXMsZM1iSXuVPe9pGBQ-1; Thu, 23 Jan 2020 07:40:44 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C3A03DB2D;
 Thu, 23 Jan 2020 12:40:42 +0000 (UTC)
Received: from kamzik.brq.redhat.com (unknown [10.43.2.160])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 90A4B5C290;
 Thu, 23 Jan 2020 12:40:41 +0000 (UTC)
Date: Thu, 23 Jan 2020 13:40:39 +0100
From: Andrew Jones <drjones@redhat.com>
To: Igor Mammedov <imammedo@redhat.com>
Subject: Re: [PATCH REPOST v3 15/80] arm/integratorcp: use memdev for RAM
Message-ID: <20200123124039.iz3pkwh6lm4mnatw@kamzik.brq.redhat.com>
References: <1579779525-20065-1-git-send-email-imammedo@redhat.com>
 <1579779525-20065-16-git-send-email-imammedo@redhat.com>
MIME-Version: 1.0
In-Reply-To: <1579779525-20065-16-git-send-email-imammedo@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: gOUWXMsZM1iSXuVPe9pGBQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org, peter.chubb@nicta.com.au,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Jan 23, 2020 at 12:37:40PM +0100, Igor Mammedov wrote:
> memory_region_allocate_system_memory() API is going away, so
> replace it with memdev allocated MemoryRegion. The later is
> initialized by generic code, so board only needs to opt in
> to memdev scheme by providing
>   MachineClass::default_ram_id
> and using MachineState::ram instead of manually initializing
> RAM memory region.
>=20
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> ---
> CC: drjones@redhat.com
> CC: peter.chubb@nicta.com.au
> CC: peter.maydell@linaro.org
> CC: qemu-arm@nongnu.org
> ---
>  hw/arm/integratorcp.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
>

I don't know anything about integratorcp, but I promised Igor to put
another pair of eyes on his changes. Looks fine to me.

Reviewed-by: Andrew Jones <drjones@redhat.com>


