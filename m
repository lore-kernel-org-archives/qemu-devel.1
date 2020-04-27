Return-Path: <SRS0=Hhxc=6L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECF0BC54FD0
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2020 14:34:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9FE5520656
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2020 14:34:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g/4AdATj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9FE5520656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48272 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jT4qT-0004Vh-PI
	for qemu-devel@archiver.kernel.org; Mon, 27 Apr 2020 10:34:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55468)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eric.auger@redhat.com>) id 1jT4nr-0000bm-Pl
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 10:32:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <eric.auger@redhat.com>) id 1jT4nr-00018M-AD
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 10:32:11 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:37328
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1jT4np-000182-Rb
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 10:32:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587997929;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6DSoist89sLde+5SYreI/3BC1hTgpbC4HndD/VV2RXg=;
 b=g/4AdATjFIPEgs1rMT4oYYcCnRRjhPCz9X1JprJXd6Qd7VQWFmLvGKujdhxFVmRLPdwg0Z
 jSNjgFaxXjMUwHwy49O/8iqEj4jgVekP3KbVC0D+3Naa9xaL7tbMv/Au7mGUAyJ9RRjjPo
 cGOPp2Qeiumbc5LVMDTYfIXJ7yj2pTE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-221-oQocEFixNfCA6zbhkX8ufw-1; Mon, 27 Apr 2020 10:32:06 -0400
X-MC-Unique: oQocEFixNfCA6zbhkX8ufw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A72551B18BC2;
 Mon, 27 Apr 2020 14:32:05 +0000 (UTC)
Received: from laptop.redhat.com (ovpn-115-95.ams2.redhat.com [10.36.115.95])
 by smtp.corp.redhat.com (Postfix) with ESMTP id BDE0A6062C;
 Mon, 27 Apr 2020 14:32:01 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, stefanb@linux.ibm.com,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, peter.maydell@linaro.org,
 cohuck@redhat.com
Subject: [PATCH 2/2] hw/arm/virt: Remove the compat forcing tpm-tis-device PPI
 to off
Date: Mon, 27 Apr 2020 16:31:45 +0200
Message-Id: <20200427143145.16251-3-eric.auger@redhat.com>
In-Reply-To: <20200427143145.16251-1-eric.auger@redhat.com>
References: <20200427143145.16251-1-eric.auger@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.120;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/27 02:05:28
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
Cc: drjones@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Now that the tpm-tis-device device PPI property is off by default,
we can remove the compat used for the same goal.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
---
 hw/arm/virt.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 7dc96abf72..2a68306f28 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -2311,11 +2311,6 @@ type_init(machvirt_machine_init);
=20
 static void virt_machine_5_0_options(MachineClass *mc)
 {
-    static GlobalProperty compat[] =3D {
-        { TYPE_TPM_TIS_SYSBUS, "ppi", "false" },
-    };
-
-    compat_props_add(mc->compat_props, compat, G_N_ELEMENTS(compat));
 }
 DEFINE_VIRT_MACHINE_AS_LATEST(5, 0)
=20
--=20
2.20.1


