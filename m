Return-Path: <SRS0=bVMU=B5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8A8BC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2020 05:49:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A581220738
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2020 05:49:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SZZo1JIQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A581220738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50036 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k8Gyb-00041k-SD
	for qemu-devel@archiver.kernel.org; Wed, 19 Aug 2020 01:49:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50178)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1k8GwK-0007Ts-AB
 for qemu-devel@nongnu.org; Wed, 19 Aug 2020 01:47:12 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:55625
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1k8GwH-0006hA-Iy
 for qemu-devel@nongnu.org; Wed, 19 Aug 2020 01:47:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597816012;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:in-reply-to:in-reply-to:
 references:references; bh=rzbdtPaZkOVuo6ADv1rGwAcfmj/FfAKgyFlXaNMf44A=;
 b=SZZo1JIQQXyS6QHPS4Rw3C5rcLqVcRueJmk+jwZMWsYgDrpfmj4IWedJatubAooq64Zkrr
 eHvfjdI4XD99k9NkVJSDtE5QfWCUvXkA/DSuGRfi71GPXZqtPqUXgmVbWtoeORJxyUWrJ/
 76lIBCKk1anklJ6Niu7vznE+07jJQIk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-193-Ss6Caxo8OpGjxbzkZ83oLA-1; Wed, 19 Aug 2020 01:46:50 -0400
X-MC-Unique: Ss6Caxo8OpGjxbzkZ83oLA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 18E0D186A562;
 Wed, 19 Aug 2020 05:46:49 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-112-195.ams2.redhat.com
 [10.36.112.195])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2739719D7D;
 Wed, 19 Aug 2020 05:46:45 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 69CC99AE4; Wed, 19 Aug 2020 07:46:44 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 03/17] hw: ehci: check return value of 'usb_packet_map'
Date: Wed, 19 Aug 2020 07:46:30 +0200
Message-Id: <20200819054644.30610-4-kraxel@redhat.com>
In-Reply-To: <20200819054644.30610-1-kraxel@redhat.com>
References: <20200819054644.30610-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kraxel@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Received-SPF: pass client-ip=207.211.31.120; envelope-from=kraxel@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/18 22:38:38
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Li Qiang <liq3ea@163.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Li Qiang <liq3ea@163.com>

If 'usb_packet_map' fails, we should stop to process the usb
request.

Signed-off-by: Li Qiang <liq3ea@163.com>
Message-Id: <20200812161727.29412-1-liq3ea@163.com>
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/usb/hcd-ehci.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/hw/usb/hcd-ehci.c b/hw/usb/hcd-ehci.c
index 58cceacbf83a..4da446d2de6b 100644
--- a/hw/usb/hcd-ehci.c
+++ b/hw/usb/hcd-ehci.c
@@ -1373,7 +1373,10 @@ static int ehci_execute(EHCIPacket *p, const char *action)
         spd = (p->pid == USB_TOKEN_IN && NLPTR_TBIT(p->qtd.altnext) == 0);
         usb_packet_setup(&p->packet, p->pid, ep, 0, p->qtdaddr, spd,
                          (p->qtd.token & QTD_TOKEN_IOC) != 0);
-        usb_packet_map(&p->packet, &p->sgl);
+        if (usb_packet_map(&p->packet, &p->sgl)) {
+            qemu_sglist_destroy(&p->sgl);
+            return -1;
+        }
         p->async = EHCI_ASYNC_INITIALIZED;
     }
 
@@ -1453,7 +1456,10 @@ static int ehci_process_itd(EHCIState *ehci,
             if (ep && ep->type == USB_ENDPOINT_XFER_ISOC) {
                 usb_packet_setup(&ehci->ipacket, pid, ep, 0, addr, false,
                                  (itd->transact[i] & ITD_XACT_IOC) != 0);
-                usb_packet_map(&ehci->ipacket, &ehci->isgl);
+                if (usb_packet_map(&ehci->ipacket, &ehci->isgl)) {
+                    qemu_sglist_destroy(&ehci->isgl);
+                    return -1;
+                }
                 usb_handle_packet(dev, &ehci->ipacket);
                 usb_packet_unmap(&ehci->ipacket, &ehci->isgl);
             } else {
-- 
2.18.4


