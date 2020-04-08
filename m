Return-Path: <SRS0=OEAU=5Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1975C2D0EA
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Apr 2020 09:09:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6EEBA2074F
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Apr 2020 09:09:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cYsaWIq+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6EEBA2074F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60496 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jM6iJ-0003pu-Id
	for qemu-devel@archiver.kernel.org; Wed, 08 Apr 2020 05:09:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34048)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1jM6ak-0007aH-9O
 for qemu-devel@nongnu.org; Wed, 08 Apr 2020 05:01:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1jM6aZ-0006fx-4T
 for qemu-devel@nongnu.org; Wed, 08 Apr 2020 05:01:49 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:41419
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1jM6aZ-0006ef-1G
 for qemu-devel@nongnu.org; Wed, 08 Apr 2020 05:01:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1586336498;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wFArfiRnUzWisktSAFgkY4kNHsrWzBNlvMfmbIoPbW0=;
 b=cYsaWIq+YGvG0c7sWqa8h4gljMrjXzUkGlzT/13jGaYCE1Bqq8ItZfpn6ml78m5y/GTnjT
 OBkYmYuoOlYDGxsmu0xj5UJF3HJpXV+K61pSt/HVybhqIB0X04WcEy9Yi3X0//pcKpudIf
 6GC3Arcj+RfEDheLU1dz5PAU2kZRxdA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-297-YFiy0FuoMe2gj-1UtYkNCg-1; Wed, 08 Apr 2020 05:01:33 -0400
X-MC-Unique: YFiy0FuoMe2gj-1UtYkNCg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 89813107ACC4;
 Wed,  8 Apr 2020 09:01:31 +0000 (UTC)
Received: from linux.fritz.box (ovpn-113-208.ams2.redhat.com [10.36.113.208])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1A8B15D9CA;
 Wed,  8 Apr 2020 09:01:25 +0000 (UTC)
Date: Wed, 8 Apr 2020 11:01:24 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH RESEND v4] nvme: introduce PMR support from NVMe 1.4 spec
Message-ID: <20200408090124.GA7914@linux.fritz.box>
References: <20200330164656.9348-1-andrzej.jakowski@linux.intel.com>
 <20200330165518.GA8234@redsun51.ssa.fujisawa.hgst.com>
MIME-Version: 1.0
In-Reply-To: <20200330165518.GA8234@redsun51.ssa.fujisawa.hgst.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
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
Cc: haozhong.zhang@intel.com, qemu-block@nongnu.org, stefanha@gmail.com,
 dgilbert@redhat.com, qemu-devel@nongnu.org, yi.z.zhang@linux.intel.com,
 Andrzej Jakowski <andrzej.jakowski@linux.intel.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Klaus Jensen <k.jensen@samsung.com>,
 mreitz@redhat.com, junyan.he@intel.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 30.03.2020 um 18:55 hat Keith Busch geschrieben:
> On Mon, Mar 30, 2020 at 09:46:56AM -0700, Andrzej Jakowski wrote:
> > This patch introduces support for PMR that has been defined as part of =
NVMe 1.4
> > spec. User can now specify a pmrdev option that should point to HostMem=
oryBackend.
> > pmrdev memory region will subsequently be exposed as PCI BAR 2 in emula=
ted NVMe
> > device. Guest OS can perform mmio read and writes to the PMR region tha=
t will stay
> > persistent across system reboot.
>=20
> Looks pretty good to me.
>=20
> Reviewed-by: Keith Busch <kbusch@kernel.org>

Thanks, applied to the block-next branch for 5.1.

Kevin


