Return-Path: <SRS0=KdPs=AG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5338C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 08:07:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ADB4F20720
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 08:07:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NCIVe6PO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ADB4F20720
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51642 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joMvA-0003PC-UV
	for qemu-devel@archiver.kernel.org; Thu, 25 Jun 2020 04:07:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34486)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1joMuR-0002wG-Pw
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 04:07:00 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:21239
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1joMuO-00034I-Jb
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 04:06:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593072414;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KYeFPYl7qX0F5nzOUPbPIrs1sE7FrltSH6fpdMc+wO8=;
 b=NCIVe6PO//rGz/4BrS82mTpfWF+BMlMB1V1czy5aZyvM8aLLjO1NXSIGBNWqZo3zSI3+Gf
 YqI4bWHPoGP7xonhVnymNEL13B16vTk/AEvveIJKnibgmZtNgr2CZuvNbgu/8BcHjHZZIA
 eGHRqFHp1bKkJyfyg6P4UC50D1rq4eU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-477-9yV39h_HNp6n3-1A0OIUYg-1; Thu, 25 Jun 2020 04:06:50 -0400
X-MC-Unique: 9yV39h_HNp6n3-1A0OIUYg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C3D3CBFC1;
 Thu, 25 Jun 2020 08:06:48 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-121.ams2.redhat.com
 [10.36.112.121])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 128BA8FF97;
 Thu, 25 Jun 2020 08:06:42 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 5CA7611384D4; Thu, 25 Jun 2020 10:06:41 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>
Subject: Re: [PATCH v2 2/3] usb/hcd-xhci: Move qemu-xhci device to
 hcd-xhci-pci.c
References: <1593008176-9629-1-git-send-email-sai.pavan.boddu@xilinx.com>
 <1593008176-9629-3-git-send-email-sai.pavan.boddu@xilinx.com>
Date: Thu, 25 Jun 2020 10:06:41 +0200
In-Reply-To: <1593008176-9629-3-git-send-email-sai.pavan.boddu@xilinx.com>
 (Sai Pavan Boddu's message of "Wed, 24 Jun 2020 19:46:15 +0530")
Message-ID: <87zh8rzi0e.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Received-SPF: pass client-ip=207.211.31.81; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/25 02:30:11
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org,
 Alistair Francis <alistair.francis@wdc.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Ying Fang <fangying1@huawei.com>,
 =?utf-8?Q?'Marc-Andr=C3=A9?= Lureau' <marcandre.lureau@redhat.com>,
 'Philippe =?utf-8?Q?Mathieu-Daud=C3=A9'?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Sai Pavan Boddu <sai.pavan.boddu@xilinx.com> writes:

> Move pci specific devices to new file. This set the environment to move all
> pci specific hooks in hcd-xhci.c to hcd-xhci-pci.c.
>
> Signed-off-by: Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>
> ---
>  hw/usb/hcd-xhci-pci.c | 64 +++++++++++++++++++++++++++++++++++++++++++++++++++
>  hw/usb/hcd-xhci.c     | 32 ++------------------------
>  hw/usb/hcd-xhci.h     |  2 ++
>  3 files changed, 68 insertions(+), 30 deletions(-)
>  create mode 100644 hw/usb/hcd-xhci-pci.c
>
> diff --git a/hw/usb/hcd-xhci-pci.c b/hw/usb/hcd-xhci-pci.c
> new file mode 100644
> index 0000000..26af683
> --- /dev/null
> +++ b/hw/usb/hcd-xhci-pci.c
> @@ -0,0 +1,64 @@
> +/*
> + * USB xHCI controller with PCI system bus emulation

Scratch "system".

> + *
> + * Copyright (c) 2011 Securiforest
> + * Date: 2011-05-11 ;  Author: Hector Martin <hector@marcansoft.com>

Let's use the opportunity to drop the "Date: " part, because we don't
have it anywhere else.

> + * Based on usb-ohci.c, emulates Renesas NEC USB 3.0
> + * Date: 2020-03-01; Author: Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>

And no new "Date: " parts, please.

> + * Moved the pci specific content for hcd-xhci.c to hcd-xhci-pci.c
> + *
> + * This library is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU Lesser General Public
> + * License as published by the Free Software Foundation; either
> + * version 2 of the License, or (at your option) any later version.
> + *
> + * This library is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> + * Lesser General Public License for more details.
> + *
> + * You should have received a copy of the GNU Lesser General Public
> + * License along with this library; if not, see <http://www.gnu.org/licenses/>.
> + */
[...]


