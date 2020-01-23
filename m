Return-Path: <SRS0=mO9Z=3M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97F4CC2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 16:35:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6191B22464
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 16:35:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FgUWCe6n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6191B22464
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60512 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iufRo-0004yQ-EE
	for qemu-devel@archiver.kernel.org; Thu, 23 Jan 2020 11:35:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37418)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <drjones@redhat.com>) id 1iudlM-0006R5-44
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 09:47:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <drjones@redhat.com>) id 1iudlL-0004mY-2G
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 09:47:16 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:59087
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <drjones@redhat.com>) id 1iudlK-0004kY-V7
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 09:47:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579790834;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4sc/jjVxiwV1EWZOP4tR83rhMEz8nNn0bMAar083iYo=;
 b=FgUWCe6nAsoW3T1IK7yKoXTnXfA2Mx2I8cHMBv33ybknCb999XMsHkiNCLOI+X86gf/s90
 2ke7pWO+j34ID8JYck0E2rRGPQiGZCsim43jSS3KfvIvel627TUuq95kw20PpMtk0Ye1Sr
 Cw2qr1rIcymU/zG1WolL6vK8WxjX4wo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-362-BsyFJaSkNfmOvdZYeoOQ8A-1; Thu, 23 Jan 2020 09:47:10 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A1D8310054E3;
 Thu, 23 Jan 2020 14:47:09 +0000 (UTC)
Received: from kamzik.brq.redhat.com (unknown [10.43.2.160])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id ABA1F5DAA4;
 Thu, 23 Jan 2020 14:47:08 +0000 (UTC)
Date: Thu, 23 Jan 2020 15:47:06 +0100
From: Andrew Jones <drjones@redhat.com>
To: Igor Mammedov <imammedo@redhat.com>
Subject: Re: [PATCH v4 20/80] arm/mps2-tz: use memdev for RAM
Message-ID: <20200123144706.jiqitmtjcotqceal@kamzik.brq.redhat.com>
References: <1579779525-20065-21-git-send-email-imammedo@redhat.com>
 <1579790231-26731-1-git-send-email-imammedo@redhat.com>
MIME-Version: 1.0
In-Reply-To: <1579790231-26731-1-git-send-email-imammedo@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: BsyFJaSkNfmOvdZYeoOQ8A-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Jan 23, 2020 at 03:37:11PM +0100, Igor Mammedov wrote:
> memory_region_allocate_system_memory() API is going away, so
> replace it with memdev allocated MemoryRegion. The later is
> initialized by generic code, so board only needs to opt in
> to memdev scheme by providing
>   MachineClass::default_ram_id
> and using MachineState::ram instead of manually initializing
> RAM memory region.
>=20
> PS:
>  while at it add check for user supplied RAM size and error
>  out if it mismatches board expected value.
>=20
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> ---
> v2:
>   * fix format string causing build failure on 32-bit host
>     (Philippe Mathieu-Daud=E9 <philmd@redhat.com>)
> v4:
>   * move default_ram_size to mps2tz_class_init()
>     (Andrew Jones <drjones@redhat.com>)
>=20
> CC: drjones@redhat.com
> CC: peter.maydell@linaro.org
> CC: qemu-arm@nongnu.org
>=20
> mps2-tz
> ---
>  hw/arm/mps2-tz.c | 15 +++++++++++----
>  1 file changed, 11 insertions(+), 4 deletions(-)
>

Reviewed-by: Andrew Jones <drjones@redhat.com>


