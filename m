Return-Path: <SRS0=By5p=5W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99E41C2BA19
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2020 10:23:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6248E2054F
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2020 10:23:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EHfw2cJE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6248E2054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58286 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jLOux-0000Ux-JG
	for qemu-devel@archiver.kernel.org; Mon, 06 Apr 2020 06:23:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51442)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kraxel@redhat.com>) id 1jLOsM-0006L4-UX
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 06:21:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kraxel@redhat.com>) id 1jLOsL-0008LP-Vr
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 06:21:06 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:28539
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1jLOsL-0008LG-SG
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 06:21:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1586168465;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZyFSoghJX8HUqTYq4IubdmBS99a/vIhBGky/l6aaBro=;
 b=EHfw2cJEmwPWx5YwTGaq1yjU7/MUdNHwQ4JSJ/fZHi7qA5SWpscX3rkQU/7bdzyifIjyMc
 Z3aJDA7bIBTPNF/S4wvRiS6T4lStBxS4Nwlkhd5Y51THutwD/6247/omxRLwS4ubtvDsXy
 YmysVanfrUfeLHo8SQwOATIH63SQD+o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-40-BcQpguxoOpKBXERbp9eECQ-1; Mon, 06 Apr 2020 06:21:01 -0400
X-MC-Unique: BcQpguxoOpKBXERbp9eECQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7B0A0801E5D;
 Mon,  6 Apr 2020 10:21:00 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-113-60.ams2.redhat.com
 [10.36.113.60])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D2A7396B7B;
 Mon,  6 Apr 2020 10:20:54 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id EE79116E2C; Mon,  6 Apr 2020 12:20:53 +0200 (CEST)
Date: Mon, 6 Apr 2020 12:20:53 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
To: Igor Mammedov <imammedo@redhat.com>
Subject: Re: [PATCH v2 04/12] acpi: serial: don't use _STA method
Message-ID: <20200406102053.nppv674hrqtaz2tu@sirius.home.kraxel.org>
References: <20200403080502.8154-1-kraxel@redhat.com>
 <20200403080502.8154-5-kraxel@redhat.com>
 <20200403120052.5a40bb3f@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200403120052.5a40bb3f@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
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
Cc: Kevin Wolf <kwolf@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 qemu-block@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 John Snow <jsnow@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

> > Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> I'd drop this patch and squash commit message into 8/12,
> but I don't insist since get_system_io() added here is removed by 8/12,
> so either way=20

They are logically separate changes (even though the first enables the
second), so I'd prefer to keep them separate.

Reordering the series so they are grouped makes sense though I think.

take care,
  Gerd


