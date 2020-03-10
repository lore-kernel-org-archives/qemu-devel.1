Return-Path: <SRS0=ZRpO=43=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BCB6C10F27
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 18:07:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1BA642146E
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 18:07:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NYfupQJX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1BA642146E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38066 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBjIM-00031J-AQ
	for qemu-devel@archiver.kernel.org; Tue, 10 Mar 2020 14:07:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51613)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <wainersm@redhat.com>) id 1jBjFs-0007db-GJ
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 14:05:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <wainersm@redhat.com>) id 1jBjFr-00054G-FQ
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 14:05:24 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:39258
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <wainersm@redhat.com>) id 1jBjFr-0004yG-9G
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 14:05:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583863522;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/IavJEhyr76wx/WQVJrlu2MafjZF0yd8qqzcsHJBa0k=;
 b=NYfupQJX2vYvD6gaeEiwjyKpQnraoDU69OgHeOejjXwF4RuY6cgpEw1ON1pEJkQ2YOF8ep
 7g4a+lt/XAsN/ZFJLKjsKLMsGrikTPPKtLl3Vxktgt0V48cOs71qLMtxSsXFVArWRNltJT
 kTZ7ed5qpwJ1bPbtofXEyZmzX/Zwn50=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-401-AvrKYZPrPyOJgqPBXMIrrg-1; Tue, 10 Mar 2020 14:05:21 -0400
X-MC-Unique: AvrKYZPrPyOJgqPBXMIrrg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 030398017CC;
 Tue, 10 Mar 2020 18:05:20 +0000 (UTC)
Received: from localhost.localdomain (ovpn-125-115.rdu2.redhat.com
 [10.10.125.115])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6F52727184;
 Tue, 10 Mar 2020 18:05:18 +0000 (UTC)
From: Wainer dos Santos Moschetta <wainersm@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/2] hw/mem/pc-dimm: Print slot number on error at
 pc_dimm_pre_plug()
Date: Tue, 10 Mar 2020 15:05:09 -0300
Message-Id: <20200310180510.19489-2-wainersm@redhat.com>
In-Reply-To: <20200310180510.19489-1-wainersm@redhat.com>
References: <20200310180510.19489-1-wainersm@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
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
Cc: qemu-trivial@nongnu.org, imammedo@redhat.com, mst@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The error report in pc_dimm_pre_plug() now has the slot
number printed.

Signed-off-by: Wainer dos Santos Moschetta <wainersm@redhat.com>
---
 hw/mem/pc-dimm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/mem/pc-dimm.c b/hw/mem/pc-dimm.c
index 8f50b8afea..36edfcf467 100644
--- a/hw/mem/pc-dimm.c
+++ b/hw/mem/pc-dimm.c
@@ -44,8 +44,8 @@ void pc_dimm_pre_plug(PCDIMMDevice *dimm, MachineState *m=
achine,
                                    &error_abort);
     if ((slot < 0 || slot >=3D machine->ram_slots) &&
          slot !=3D PC_DIMM_UNASSIGNED_SLOT) {
-        error_setg(&local_err, "invalid slot number, valid range is [0-%"
-                   PRIu64 "]", machine->ram_slots - 1);
+        error_setg(&local_err, "invalid slot number %d, valid range is [0-=
%"
+                   PRIu64 "]", slot, machine->ram_slots - 1);
         goto out;
     }
=20
--=20
2.24.1


