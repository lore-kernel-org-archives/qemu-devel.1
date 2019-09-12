Return-Path: <SRS0=eeqW=XH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA810C4CEC6
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2019 14:19:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A11A120684
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2019 14:19:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A11A120684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35006 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i8PwV-0004lP-7b
	for qemu-devel@archiver.kernel.org; Thu, 12 Sep 2019 10:19:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40426)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1i8PUX-0006gh-HB
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 09:50:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1i8PUV-0002sb-F0
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 09:50:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59356)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1i8PUT-0002nn-F3
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 09:50:30 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 9FF6018C8933;
 Thu, 12 Sep 2019 13:50:27 +0000 (UTC)
Received: from dgilbert-t580.localhost (unknown [10.36.118.12])
 by smtp.corp.redhat.com (Postfix) with ESMTP id EC63C5D717;
 Thu, 12 Sep 2019 13:50:22 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org, ivanren@tencent.com, peterx@redhat.com,
 richardw.yang@linux.intel.com, yury-kotov@yandex-team.ru,
 quintela@redhat.com
Date: Thu, 12 Sep 2019 14:49:57 +0100
Message-Id: <20190912135006.14820-4-dgilbert@redhat.com>
In-Reply-To: <20190912135006.14820-1-dgilbert@redhat.com>
References: <20190912135006.14820-1-dgilbert@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.70]); Thu, 12 Sep 2019 13:50:27 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 03/12] hw/net/vmxnet3: Fix leftover
 unregister_savevm
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Commit 78dd48df3 reworked vmxnet3's live migration but left a straggling
unregister_savevm call.  Remove it, although it doesn't seem to have
any bad effect.

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Message-Id: <20190822111218.12079-1-dgilbert@redhat.com>
Reviewed-by: Dmitry Fleytman <dmitry.fleytman@gmail.com>
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 hw/net/vmxnet3.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/hw/net/vmxnet3.c b/hw/net/vmxnet3.c
index b07adeed9c..39ff6624c5 100644
--- a/hw/net/vmxnet3.c
+++ b/hw/net/vmxnet3.c
@@ -2242,13 +2242,10 @@ static void vmxnet3_instance_init(Object *obj)
=20
 static void vmxnet3_pci_uninit(PCIDevice *pci_dev)
 {
-    DeviceState *dev =3D DEVICE(pci_dev);
     VMXNET3State *s =3D VMXNET3(pci_dev);
=20
     VMW_CBPRN("Starting uninit...");
=20
-    unregister_savevm(dev, "vmxnet3-msix", s);
-
     vmxnet3_net_uninit(s);
=20
     vmxnet3_cleanup_msix(s);
--=20
2.21.0


