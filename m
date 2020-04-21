Return-Path: <SRS0=H2wg=6F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CD92C2BA19
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2020 09:20:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 45B9620857
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2020 09:20:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LcvcHcOa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45B9620857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54436 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jQp4r-0003yC-Fu
	for qemu-devel@archiver.kernel.org; Tue, 21 Apr 2020 05:20:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33784)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kraxel@redhat.com>) id 1jQp46-0003Kp-T5
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 05:19:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <kraxel@redhat.com>) id 1jQp46-0007Oc-9n
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 05:19:38 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:29778
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jQp45-0007ON-Sm
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 05:19:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587460776;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IZd1/rhBCrtOHTgOtEteJvzWcWIajqnxjXWaNdPAVgo=;
 b=LcvcHcOaoiIJsNwZ3UhOGRc53DpGd7FXDptjzY9hD5ez2uQgnIKRYZXGWJ42eMJFx35fuE
 4UDdGPVnLedj7RR+w+7xPaPpzIzT4caLaJpnpQwhnWPyIcRASYjWB4vmfobu4P5XsGrz7a
 qEccaQlDfNPjIC3coPo79y1KzUPk1hY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-249-7XmqNaDaNRCnnHdvFQ4tTQ-1; Tue, 21 Apr 2020 05:19:33 -0400
X-MC-Unique: 7XmqNaDaNRCnnHdvFQ4tTQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 70509107B283;
 Tue, 21 Apr 2020 09:19:32 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-113-193.ams2.redhat.com
 [10.36.113.193])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0AD6128981;
 Tue, 21 Apr 2020 09:19:31 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 2136116E16; Tue, 21 Apr 2020 11:19:31 +0200 (CEST)
Date: Tue, 21 Apr 2020 11:19:31 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
To: Klaus Jensen <its@irrelevant.dk>
Subject: Re: [PATCH v7 46/48] pci: allocate pci id for nvme
Message-ID: <20200421091931.zvxqtftza2e33rwu@sirius.home.kraxel.org>
References: <20200415055140.466900-1-its@irrelevant.dk>
 <20200415055140.466900-47-its@irrelevant.dk>
MIME-Version: 1.0
In-Reply-To: <20200415055140.466900-47-its@irrelevant.dk>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=kraxel@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/21 04:54:00
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
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
Cc: Kevin Wolf <kwolf@redhat.com>, Beata Michalska <beata.michalska@linaro.org>,
 qemu-block@nongnu.org, Klaus Jensen <k.jensen@samsung.com>,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Keith Busch <kbusch@kernel.org>, Javier Gonzalez <javier.gonz@samsung.com>,
 Maxim Levitsky <mlevitsk@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Apr 15, 2020 at 07:51:38AM +0200, Klaus Jensen wrote:
> From: Klaus Jensen <k.jensen@samsung.com>
>=20
> The emulated nvme device (hw/block/nvme.c) is currently using an
> internal Intel device id.
>=20
> Prepare to change that by allocating a device id under the 1b36 (Red
> Hat, Inc.) vendor id.
>=20
> Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
> Cc: Gerd Hoffmann <kraxel@redhat.com>
> Acked-by: Keith Busch <kbusch@kernel.org>
> Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>

Acked-by: Gerd Hoffmann <kraxel@redhat.com>


