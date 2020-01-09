Return-Path: <SRS0=I8Mx=26=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94474C33CA2
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2020 15:32:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F85F20721
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2020 15:32:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Jgonsh8E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F85F20721
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34216 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ipZn4-000303-KX
	for qemu-devel@archiver.kernel.org; Thu, 09 Jan 2020 10:32:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41237)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1ipZe5-0007aU-7P
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 10:22:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1ipZe4-0005QB-7a
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 10:22:49 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:54141
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1ipZe4-0005JK-1K
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 10:22:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578583366;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zSEVdD4q81/iEc/2OJsdkw6WfL0iI9AF0OwFhiGUJrs=;
 b=Jgonsh8Eiaj/GugQWIlYdK2EofFmuu6HaI7UnsNYQ8Z7nu+orSRCX4TGQz3qrk9BjfnXMH
 xpm0TBwvS/PGf+RCz8QvekjsysiQFiUulrpa4aItM2Tp6fr5+MiN8adDxUH2JMbiS1SMuR
 xoxE3oBccAFh/Bc6gohnuiSnTZXu+PQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-294-YHDvjnUkN62ZEraTmN9r2g-1; Thu, 09 Jan 2020 10:22:45 -0500
X-MC-Unique: YHDvjnUkN62ZEraTmN9r2g-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6D8698C4B4E;
 Thu,  9 Jan 2020 15:22:43 +0000 (UTC)
Received: from x1w.redhat.com (ovpn-204-180.brq.redhat.com [10.40.204.180])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id DD97980602;
 Thu,  9 Jan 2020 15:22:37 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 07/15] hw/core/machine-qmp-cmds: Replace current_machine by
 qdev_get_machine()
Date: Thu,  9 Jan 2020 16:21:25 +0100
Message-Id: <20200109152133.23649-8-philmd@redhat.com>
In-Reply-To: <20200109152133.23649-1-philmd@redhat.com>
References: <20200109152133.23649-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <ehabkost@redhat.com>, kvm@vger.kernel.org,
 Juan Quintela <quintela@redhat.com>, qemu-ppc@nongnu.org,
 Marcelo Tosatti <mtosatti@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu-arm@nongnu.org,
 Alistair Francis <alistair.francis@wdc.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

As we want to remove the global current_machine,
replace MACHINE_GET_CLASS(current_machine) by
MACHINE_GET_CLASS(qdev_get_machine()).

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 hw/core/machine-qmp-cmds.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/core/machine-qmp-cmds.c b/hw/core/machine-qmp-cmds.c
index eed5aeb2f7..5a04d00e4f 100644
--- a/hw/core/machine-qmp-cmds.c
+++ b/hw/core/machine-qmp-cmds.c
@@ -280,9 +280,9 @@ void qmp_cpu_add(int64_t id, Error **errp)
 {
     MachineClass *mc;
=20
-    mc =3D MACHINE_GET_CLASS(current_machine);
+    mc =3D MACHINE_GET_CLASS(qdev_get_machine());
     if (mc->hot_add_cpu) {
-        mc->hot_add_cpu(current_machine, id, errp);
+        mc->hot_add_cpu(MACHINE(qdev_get_machine()), id, errp);
     } else {
         error_setg(errp, "Not supported");
     }
--=20
2.21.1


