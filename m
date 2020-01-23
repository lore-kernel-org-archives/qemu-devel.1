Return-Path: <SRS0=mO9Z=3M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21B1AC2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 15:02:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E1C3621734
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 15:02:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ag0jSI/q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1C3621734
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58714 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iue0M-0002RH-G0
	for qemu-devel@archiver.kernel.org; Thu, 23 Jan 2020 10:02:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49158)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <drjones@redhat.com>) id 1iubZp-0003Mo-Go
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 07:27:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <drjones@redhat.com>) id 1iubZo-0006Or-Eu
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 07:27:13 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:44300
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <drjones@redhat.com>) id 1iubZo-0006Oa-Bl
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 07:27:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579782432;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ik9+Ni0I2HIpFjFmmPCpB/I8lei/QzZGMkRoelzzCmo=;
 b=Ag0jSI/qKNrxbwxLoFAojE+Id8E/+PbmW5KhKlpiyjVb73hRNRut73857aVu96eacotE0Q
 d18FkGlgwgVPGxQEU9xETWlscOO1+fXpuh2ErbPN/lW7ix6OrcyemoNZyWSXG4K770kHvC
 HD9TtqEAPq+VMquYfNfVehVcq9pKBJg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-39-xAxm1qUhP9WIlZDX3QUqNg-1; Thu, 23 Jan 2020 07:27:08 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 99140DBA3;
 Thu, 23 Jan 2020 12:27:07 +0000 (UTC)
Received: from kamzik.brq.redhat.com (unknown [10.43.2.160])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A30BC5C1BB;
 Thu, 23 Jan 2020 12:27:06 +0000 (UTC)
Date: Thu, 23 Jan 2020 13:27:04 +0100
From: Andrew Jones <drjones@redhat.com>
To: Igor Mammedov <imammedo@redhat.com>
Subject: Re: [PATCH REPOST v3 09/80] arm/collie: use memdev for RAM
Message-ID: <20200123122704.qb333etpxfkjek5y@kamzik.brq.redhat.com>
References: <1579779525-20065-1-git-send-email-imammedo@redhat.com>
 <1579779525-20065-10-git-send-email-imammedo@redhat.com>
MIME-Version: 1.0
In-Reply-To: <1579779525-20065-10-git-send-email-imammedo@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: xAxm1qUhP9WIlZDX3QUqNg-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Jan 23, 2020 at 12:37:34PM +0100, Igor Mammedov wrote:
> memory_region_allocate_system_memory() API is going away, so
> replace it with memdev allocated MemoryRegion. The later is
> initialized by generic code, so board only needs to opt in
> to memdev scheme by providing
>   MachineClass::default_ram_id
> and using MachineState::ram instead of manually initializing
> RAM memory region.
>=20
> PS:
>  - while at it add check for user supplied RAM size and error
>    out if it mismatches board expected value.
>  - introduce RAM_ADDR_UFMT to avoid build errors on 32-bit hosts
>    when specifying format string for ram_addr_t type
>=20
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> ---
> v2:
>   * fix format string causing build failure on 32-bit host
>     (Philippe Mathieu-Daud=E9 <philmd@redhat.com>)
> v3:
>   * instead of RAM_ADDR_UFMT adding use size_to_str()
>      Philippe Mathieu-Daud=E9 <philmd@redhat.com>
>=20
> CC: drjones@redhat.com
> CC: peter.maydell@linaro.org
> CC: qemu-arm@nongnu.org
> ---
>  hw/arm/collie.c | 17 ++++++++++++-----
>  1 file changed, 12 insertions(+), 5 deletions(-)
>=20

I don't know anything about collie, but I promised Igor to put
another pair of eyes on his changes. Looks fine to me.

Reviewed-by: Andrew Jones <drjones@redhat.com>


