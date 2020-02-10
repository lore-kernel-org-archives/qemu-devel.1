Return-Path: <SRS0=Q7uJ=36=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20AEEC352A3
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2020 15:12:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD32220714
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2020 15:12:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NqMr+Clh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD32220714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34884 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1Aja-0007vh-Vl
	for qemu-devel@archiver.kernel.org; Mon, 10 Feb 2020 10:12:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36525)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1j1Ag0-0006Lr-Fe
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 10:08:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1j1Afx-0004GG-4Q
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 10:08:43 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:33907
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1j1Afx-0004FH-0o
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 10:08:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581347320;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=flz/nr8pxJBL0iPv6EluckMhgFwSmGWI2SJ+LCMYjyU=;
 b=NqMr+ClhD9OJjS6jpRHls/l9P/b0usOwV2mpqHInbDB4oJywBDNujzpK1UnmRyJxj3QmSb
 /vxtmoxb6ymqsj2FQRbNyJIQoClxKEu/lOjmM17hLJSGAPdHXZcJqsDbv9dbv0HWiGUi/f
 JmJjeTWW4dhTE5v72yDcVct3eZW0390=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-367-Mu1euFmvOeuKhXcO05OjDg-1; Mon, 10 Feb 2020 10:08:35 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E66FD8017DF;
 Mon, 10 Feb 2020 15:08:33 +0000 (UTC)
Received: from dell-r430-03.lab.eng.brq.redhat.com
 (dell-r430-03.lab.eng.brq.redhat.com [10.37.153.18])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6E6D060BF1;
 Mon, 10 Feb 2020 15:08:29 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 81/80] mips/mips_jazz: add max ram size check
Date: Mon, 10 Feb 2020 16:06:17 +0100
Message-Id: <1581347177-88501-1-git-send-email-imammedo@redhat.com>
In-Reply-To: <09243f48-76bb-2c8a-52b6-d7c1375cdb55@amsat.org>
References: <09243f48-76bb-2c8a-52b6-d7c1375cdb55@amsat.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: Mu1euFmvOeuKhXcO05OjDg-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: hpoussin@reactos.org, aleksandar.rikalo@rt-rk.com, philmd@redhat.com,
 amarkovic@wavecomp.com, aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

error out in case user asked for more RAM than board
supports.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
CC: philmd@redhat.com
CC: hpoussin@reactos.org
CC: aleksandar.rikalo@rt-rk.com
CC: aurelien@aurel32.net
CC: amarkovic@wavecomp.com


 hw/mips/mips_jazz.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/hw/mips/mips_jazz.c b/hw/mips/mips_jazz.c
index 85d49cf..32fbd10 100644
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
2.7.4


