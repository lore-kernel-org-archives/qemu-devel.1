Return-Path: <SRS0=CnYV=4F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BB46C34024
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 17:59:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 500A7207FD
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 17:59:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FqQec9sD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 500A7207FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49764 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j3kfm-0007BF-Ex
	for qemu-devel@archiver.kernel.org; Mon, 17 Feb 2020 12:59:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38695)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1j3kJf-0003D7-Ry
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 12:36:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1j3kJe-0002U5-SA
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 12:36:19 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:54414
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1j3kJe-0002TV-OP
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 12:36:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581960978;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NJaIgY+bKaOvZlfmkqpwWek60f+o8HnE5o0Knnu1RzA=;
 b=FqQec9sDPfVq2DIYKSllyNT/gWg1A7afrBxLFfwRlr1zKipPx6S8q4oUA16EbZEMcaQrU5
 OZEyNSjm4RIKc9sKCN42nD/eywB7uCLg5rqX52aA+Hg4eEZRJdduUAMQOQY2h1PPXhRYIb
 U9FYXRihLxAhs4Wa31jtgHtfwgGqZDM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-368-Bbn0HPLoNd6WSZgg90MLgA-1; Mon, 17 Feb 2020 12:36:15 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0A1B91005512
 for <qemu-devel@nongnu.org>; Mon, 17 Feb 2020 17:36:15 +0000 (UTC)
Received: from dell-r430-03.lab.eng.brq.redhat.com
 (dell-r430-03.lab.eng.brq.redhat.com [10.37.153.18])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 579E68CCE0;
 Mon, 17 Feb 2020 17:36:14 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 54/79] mips/mips_jazz: add max ram size check
Date: Mon, 17 Feb 2020 12:34:27 -0500
Message-Id: <20200217173452.15243-55-imammedo@redhat.com>
In-Reply-To: <20200217173452.15243-1-imammedo@redhat.com>
References: <20200217173452.15243-1-imammedo@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: Bbn0HPLoNd6WSZgg90MLgA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
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
Cc: Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

error out in case user asked for more RAM than board
supports.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Philippe Mathieu-Daude <philmd@redhat.com>
---
 hw/mips/mips_jazz.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/hw/mips/mips_jazz.c b/hw/mips/mips_jazz.c
index 85d49cf155..32fbd10b4e 100644
--- a/hw/mips/mips_jazz.c
+++ b/hw/mips/mips_jazz.c
@@ -164,6 +164,11 @@ static void mips_jazz_init(MachineState *machine,
     SysBusESPState *sysbus_esp;
     ESPState *esp;
=20
+    if (machine->ram_size > 256 * MiB) {
+        error_report("RAM size more than 256Mb is not supported");
+        exit(EXIT_FAILURE);
+    }
+
     /* init CPUs */
     cpu =3D MIPS_CPU(cpu_create(machine->cpu_type));
     env =3D &cpu->env;
--=20
2.18.1


