Return-Path: <SRS0=/hVT=5E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABE24C4332B
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2020 08:08:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 76D2F2072C
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2020 08:08:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VG2X2c65"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76D2F2072C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34586 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEqDo-0004Cr-Kb
	for qemu-devel@archiver.kernel.org; Thu, 19 Mar 2020 04:08:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39746)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kraxel@redhat.com>) id 1jEq7a-0001k5-25
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 04:01:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kraxel@redhat.com>) id 1jEq7Y-0005YP-VY
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 04:01:41 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:57793)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1jEq7Y-0005W4-Ql
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 04:01:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584604900;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ru0ezrnSjCOFrcw7qNzHSdv4vQBpHGBoNyHGfyYxptM=;
 b=VG2X2c65jo+hbaCPMpHP+dX/tB5wRDrh5QYhz1Ed5nDjpKF1TVnZokGsjx3tqvOCr+u0ei
 f0c+SYpM8do7nn59S9QH0YXTJVVdxVMKi/WeXjeJhVcwP0S+1TGpxCZlD4p9A5Z/fXB2/r
 GRDQT6cqmwRLH+1vVdP6+TTJlvGJ80Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-62-iwQyjvadPGOwwfTDglbeBw-1; Thu, 19 Mar 2020 04:01:36 -0400
X-MC-Unique: iwQyjvadPGOwwfTDglbeBw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C9BAF800D5B;
 Thu, 19 Mar 2020 08:01:35 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-112-49.ams2.redhat.com
 [10.36.112.49])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 89FC85C1D8;
 Thu, 19 Mar 2020 08:01:27 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id D7A3831F62; Thu, 19 Mar 2020 09:01:17 +0100 (CET)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 06/13] microvm: disable virtio-mmio cmdline hack
Date: Thu, 19 Mar 2020 09:01:10 +0100
Message-Id: <20200319080117.7725-7-kraxel@redhat.com>
In-Reply-To: <20200319080117.7725-1-kraxel@redhat.com>
References: <20200319080117.7725-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 63.128.21.74
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, Sergio Lopez <slp@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

... in case we are using ACPI.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/i386/microvm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/i386/microvm.c b/hw/i386/microvm.c
index 362d513f38e1..fd753764fc10 100644
--- a/hw/i386/microvm.c
+++ b/hw/i386/microvm.c
@@ -361,7 +361,7 @@ static void microvm_machine_reset(MachineState *machine=
)
     CPUState *cs;
     X86CPU *cpu;
=20
-    if (machine->kernel_filename !=3D NULL &&
+    if (!acpi_enabled && machine->kernel_filename !=3D NULL &&
         mms->auto_kernel_cmdline && !mms->kernel_cmdline_fixed) {
         microvm_fix_kernel_cmdline(machine);
         mms->kernel_cmdline_fixed =3D true;
--=20
2.18.2


