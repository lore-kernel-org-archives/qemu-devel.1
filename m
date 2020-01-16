Return-Path: <SRS0=QWrs=3F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86D14C33CB1
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2020 08:14:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 51DB32077B
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2020 08:14:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OMoZSapY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51DB32077B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38076 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1is0Im-0000UT-EW
	for qemu-devel@archiver.kernel.org; Thu, 16 Jan 2020 03:14:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55977)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kraxel@redhat.com>) id 1is0Hu-0007l3-3V
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 03:14:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kraxel@redhat.com>) id 1is0Hp-0003de-3C
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 03:13:57 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:56405
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1is0Ho-0003dM-W4
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 03:13:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579162431;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=c2gxp0UH7tnpTdV1eF75NIs8zDhynmeDVtRVm3gu2DU=;
 b=OMoZSapYoqOSTeWGSmyYGICMyrwJpg5DmF1bOWOyCirYR5aYI1RCiGeqMZNWrnGhwmosNZ
 FMYpL0pr10FbTB/BkYFN9nMQwHIo6+I+wxUdt5qkFnADRyk2s9WIO+kMccEswvm39TsQfZ
 k0C095vtequ73lWtoHwRioRGQkeCsa4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-61-d34YXhIsM2mB7osKuUb0SQ-1; Thu, 16 Jan 2020 03:13:50 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5E111800D4C;
 Thu, 16 Jan 2020 08:13:49 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-106.ams2.redhat.com
 [10.36.116.106])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4FE779CA3;
 Thu, 16 Jan 2020 08:13:44 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 8543E9D61; Thu, 16 Jan 2020 09:13:43 +0100 (CET)
Date: Thu, 16 Jan 2020 09:13:43 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Subject: Re: [PATCH] ui/gtk: Get display refresh rate with GDK version 3.22
 or later
Message-ID: <20200116081343.fbcu5khme4jmu35a@sirius.home.kraxel.org>
References: <20200116011217.2144-1-philmd@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200116011217.2144-1-philmd@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: d34YXhIsM2mB7osKuUb0SQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>,
 qemu-devel@nongnu.org,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Nikola Pavlica <pavlica.nikola@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

  Hi,

> Fixes: c4c00922cc (display/gtk: get proper refreshrate)
> Signed-off-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>

Reviewed-by: Gerd Hoffmann <kraxel@redhat.com>

> ---
> Sorry I missed that, I only tested Nikola's patch on my workstation
> which runs Fedora 30:
>=20
>   $ pkg-config --modversion gtk+-3.0
>   3.24.11

Even RHEL-7 has a gtk version new enough for that, so my build tests
didn't catch it either ...

> If Gerd acks this patch, we might consider having it directly
> applied as a build fix.

Fine with me.

cheers,
  Gerd


