Return-Path: <SRS0=3Wv1=4U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6920C3F2CD
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2020 10:26:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 84028214D8
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2020 10:26:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KxfsKo/U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84028214D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44964 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j94lC-0004LD-OA
	for qemu-devel@archiver.kernel.org; Tue, 03 Mar 2020 05:26:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53697)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kraxel@redhat.com>) id 1j94Zi-0008Ba-Ju
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 05:14:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kraxel@redhat.com>) id 1j94Zh-0008DI-NU
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 05:14:54 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:39809
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1j94Zh-0008D7-JH
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 05:14:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583230493;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TeViLLngZ99Nmzkz63sOPAJWkn5vnxgZ4kRRKAS4vVY=;
 b=KxfsKo/U3WqM0gzfWADefemksngPiw5vDmSf6LU6Qf22WNi79tz7uS4eiY6wsuxdKpcKdt
 8RRzTLLrxHCWkd2P71eZwkbKo60EMq8GhfzAjBTexdCihW949we6nbwCCJDm5cTTRdYZcA
 fFvLkeZVzrVOScLMr2L1jyjmQ0I5ADo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-188-4_73X40BMZyWcliTz2e4WQ-1; Tue, 03 Mar 2020 05:14:49 -0500
X-MC-Unique: 4_73X40BMZyWcliTz2e4WQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3F50918A6EC0;
 Tue,  3 Mar 2020 10:14:48 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-150.ams2.redhat.com
 [10.36.116.150])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D11105D9C9;
 Tue,  3 Mar 2020 10:14:47 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 4E0BE17535; Tue,  3 Mar 2020 11:14:45 +0100 (CET)
Date: Tue, 3 Mar 2020 11:14:45 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
To: Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>
Subject: Re: [PATCH 3/3] usb/hcd-xhci: Split pci wrapper for xhci base model
Message-ID: <20200303101445.gvfucibdgj7zhb54@sirius.home.kraxel.org>
References: <1583141724-6229-1-git-send-email-sai.pavan.boddu@xilinx.com>
 <1583141724-6229-4-git-send-email-sai.pavan.boddu@xilinx.com>
MIME-Version: 1.0
In-Reply-To: <1583141724-6229-4-git-send-email-sai.pavan.boddu@xilinx.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
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
Cc: Yang Zhong <yang.zhong@intel.com>,
 "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>,
 Thomas Huth <thuth@redhat.com>, Vikram Garhwal <fnu.vikram@xilinx.com>,
 Stefan Weil <sw@weilnetz.de>, Richard Henderson <richard.henderson@linaro.org>,
 qemu-devel@nongnu.org, Gonglei <arei.gonglei@huawei.com>,
 Anthony Liguori <anthony@codemonkey.ws>, Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Mar 02, 2020 at 03:05:24PM +0530, Sai Pavan Boddu wrote:
> This patch sets the base to use xhci as sysbus model, for which pci
> specific hooks are moved to hcd-xhci-pci.c. As a part of this requirment
> msi/msix interrupts handling is moved under XHCIPCIState. Made required
> changes for qemu-xhci-nec.

> +static void usb_xhci_pci_realize(struct PCIDevice *dev, Error **errp)
> +{

> +    s->xhci->as =3D pci_get_address_space(dev);
> +}

Ah, here it is.  Should be in patch 1, otherwise the series isn't
bisecttable due to the temporary breakage.

cheers,
  Gerd


