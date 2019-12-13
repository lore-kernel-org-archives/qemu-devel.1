Return-Path: <SRS0=VaDC=2D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E646C2D0CA
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2019 21:27:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8D71421655
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2019 21:27:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JWTZsbqo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D71421655
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51154 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifntH-0001Xe-TR
	for qemu-devel@archiver.kernel.org; Fri, 13 Dec 2019 11:34:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35532)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cohuck@redhat.com>) id 1ifneu-0008Rn-Ec
 for qemu-devel@nongnu.org; Fri, 13 Dec 2019 11:19:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cohuck@redhat.com>) id 1ifnet-00012a-Ak
 for qemu-devel@nongnu.org; Fri, 13 Dec 2019 11:19:16 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:42552
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1ifnet-00010g-5B
 for qemu-devel@nongnu.org; Fri, 13 Dec 2019 11:19:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576253954;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8fD1jPf77hf5QwSCn7UJYPVPQ62que2NUPDBIS4Y2CY=;
 b=JWTZsbqoHTM0slTlMpVElwZs6CYHV0LrT1VS7LBeDMUQL8h0ZQZ1zrbCOHIU7hdQL3ifXX
 cBRSjNI9KrN0t8KMkyb1F04pH4cZF9QlzZfIPNw7oqw7vx6MtTFe7EBsZbB/z7bWD2LTuz
 jx6NMMQBahy593xdPMkC+TmBXSeW0LE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-82-397jilY5NrSiBO4eQdnubQ-1; Fri, 13 Dec 2019 11:19:11 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4DB87800D4E;
 Fri, 13 Dec 2019 16:19:10 +0000 (UTC)
Received: from localhost (ovpn-116-226.ams2.redhat.com [10.36.116.226])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1A52D5C553;
 Fri, 13 Dec 2019 16:19:06 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 03/16] s390x: Don't do a normal reset on the initial cpu
Date: Fri, 13 Dec 2019 17:18:38 +0100
Message-Id: <20191213161851.24687-4-cohuck@redhat.com>
In-Reply-To: <20191213161851.24687-1-cohuck@redhat.com>
References: <20191213161851.24687-1-cohuck@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: 397jilY5NrSiBO4eQdnubQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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
Cc: Cornelia Huck <cohuck@redhat.com>, qemu-s390x@nongnu.org,
 David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org,
 Janosch Frank <frankja@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Janosch Frank <frankja@linux.ibm.com>

The initiating cpu needs to be reset with an initial reset. While
doing a normal reset followed by a initial reset is not wrong per se,
the Ultravisor will only allow the correct reset to be performed.

Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Message-Id: <20191127175046.4911-2-frankja@linux.ibm.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 hw/s390x/s390-virtio-ccw.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index 01e7e209a5da..e0e28139a263 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -348,6 +348,9 @@ static void s390_machine_reset(MachineState *machine)
         break;
     case S390_RESET_LOAD_NORMAL:
         CPU_FOREACH(t) {
+            if (t =3D=3D cs) {
+                continue;
+            }
             run_on_cpu(t, s390_do_cpu_reset, RUN_ON_CPU_NULL);
         }
         subsystem_reset();
--=20
2.21.0


