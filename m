Return-Path: <SRS0=Vgkn=6S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64562C3A5A9
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 14:31:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2FA6220757
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 14:31:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="On/eKKlo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FA6220757
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56548 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVc7h-0007nD-8R
	for qemu-devel@archiver.kernel.org; Mon, 04 May 2020 10:31:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47346)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jVc6H-0005Is-Jj
 for qemu-devel@nongnu.org; Mon, 04 May 2020 10:29:41 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:55677
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jVc6G-0005yF-P1
 for qemu-devel@nongnu.org; Mon, 04 May 2020 10:29:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588602580;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UFJCcfUPniOf5vXc8rH2NS/WfUBDG9stKmVsBSpYF/c=;
 b=On/eKKlodm7KxY0g5F/G3MZMsmO5lOChyCeFFxg5s7Q89PR2/uA1oTYzpBGTlGzSnJYw3F
 V4gcLvXAkBgP1nR72OxhyYB4sfO2GsL0/2maRSo1HWjXBdyOck5TvAKldqvM9cDgNLmy9z
 99t12sWo6nMCs1EjoUXPqIlBYK7mqhs=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-489-wODYEhw2OIO1Db5pCjfO2Q-1; Mon, 04 May 2020 10:29:37 -0400
X-MC-Unique: wODYEhw2OIO1Db5pCjfO2Q-1
Received: by mail-wr1-f70.google.com with SMTP id x8so2089466wrl.16
 for <qemu-devel@nongnu.org>; Mon, 04 May 2020 07:29:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=UfPNDPekMMkFXNne2POD4HoHEu9FovxK5J/ip16ICoI=;
 b=WJxmIGBAWddESjdCkDct5aWziwnhTO1RIdC5BzCapguoec1dUuiJSr0a9tGlf4Wc7S
 kb0XCczSwHiJI0QwZT6N6QwGW9IDShfLMZ0B/mp/i/zHnbmiWAELXYocHfsmPFLLd5eh
 Qq9Y7154OX2+4HN/KXVcxQMZ7F0xl4IEPchIn3LSj+bfGTN98JUhEjBsaE4kx/KVR4RT
 n7NQo5oJ7IHN16wk6y5G8JpULksum6JAx3LrRB4UnsWZ7oB1ipTvyYJai7f2dDMFiJZP
 P2D2Ut2TVy87AOo/D7CrMAnbvSwpoojXNPAc32gRJdvl0U/MA770piD1BWfQLO/1OXET
 oedA==
X-Gm-Message-State: AGi0PuatNz8F4NBFsUuf6FBU3lm0XjvGqHWoyxr2KDDPP1UisvChvelC
 fvVE8UeOlT5LwtQt+SArJckpGhzGIAXwAvz5ZD1tSYqk0e2+pAvKKs5VJw2r148G5CYFeUColpy
 7Jarm0YzOc3Dmziw=
X-Received: by 2002:a5d:6a4e:: with SMTP id t14mr6074215wrw.353.1588602576824; 
 Mon, 04 May 2020 07:29:36 -0700 (PDT)
X-Google-Smtp-Source: APiQypJ+3366N0mncyHWvmlxX0rEN7w6W0GC5GYKheErz47G9Ct4pHQMtWO6c+mtJka0uLx2lNmdTg==
X-Received: by 2002:a5d:6a4e:: with SMTP id t14mr6074199wrw.353.1588602576658; 
 Mon, 04 May 2020 07:29:36 -0700 (PDT)
Received: from redhat.com (bzq-109-66-7-121.red.bezeqint.net. [109.66.7.121])
 by smtp.gmail.com with ESMTPSA id
 v2sm6099951wrn.21.2020.05.04.07.29.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 May 2020 07:29:36 -0700 (PDT)
Date: Mon, 4 May 2020 10:29:34 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 09/29] virtio-vga: fix virtio-vga bar ordering
Message-ID: <20200504142814.157589-10-mst@redhat.com>
References: <20200504142814.157589-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200504142814.157589-1-mst@redhat.com>
X-Mailer: git-send-email 2.24.1.751.gd10ce2899c
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=mst@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/04 05:09:11
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Anthoine Bourgeois <anthoine.bourgeois@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>, Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Anthoine Bourgeois <anthoine.bourgeois@gmail.com>

With virtio-vga, pci bar are reordered. Bar #2 is used for compatibility
with stdvga. By default, bar #2 is used by virtio modern io bar.
This bar is the last one introduce in the virtio pci bar layout and it's
crushed by the virtio-vga reordering. So virtio-vga and
modern-pio-notify are incompatible because virtio-vga failed to
initialize with this option.

This fix sets the modern io bar to the bar #5 to avoid conflict.

Signed-off-by: Anthoine Bourgeois <anthoine.bourgeois@gmail.com>
Message-Id: <20200422215455.10244-1-anthoine.bourgeois@gmail.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/display/virtio-vga.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/display/virtio-vga.c b/hw/display/virtio-vga.c
index 2b4c2aa126..95757a6619 100644
--- a/hw/display/virtio-vga.c
+++ b/hw/display/virtio-vga.c
@@ -114,6 +114,7 @@ static void virtio_vga_base_realize(VirtIOPCIProxy *vpc=
i_dev, Error **errp)
      */
     vpci_dev->modern_mem_bar_idx =3D 2;
     vpci_dev->msix_bar_idx =3D 4;
+    vpci_dev->modern_io_bar_idx =3D 5;
=20
     if (!(vpci_dev->flags & VIRTIO_PCI_FLAG_PAGE_PER_VQ)) {
         /*
--=20
MST


