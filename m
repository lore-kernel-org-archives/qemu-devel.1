Return-Path: <SRS0=HxLX=Y5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4F71C5DF60
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2019 22:55:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4AB13206BA
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2019 22:55:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ms1EJD2G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4AB13206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51270 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iS7jh-0004Rg-Hz
	for qemu-devel@archiver.kernel.org; Tue, 05 Nov 2019 17:55:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58394)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iS7iK-0003Yx-M7
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 17:54:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iS7iI-0005Hy-QN
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 17:54:15 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:36038
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iS7iI-0005Gx-LM
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 17:54:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1572994453;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7y5torsmOj7fk74CEGxoKErib8Ikye+IYqgVp5FVBQU=;
 b=Ms1EJD2Gy5M67RD7MsQ+7UhPMCeDN7jpEgYKP84vEa9K6Hht1isw+t40w/rH07t33VWLLn
 qehSv3CLXw5TlA5bP7UM76LgjQeQz1cZMXUsg7b+oH40nOKNEaiHlCJ25SROieRozthJIj
 zcCdGaGYkf0Cx9hDOH9dmbj7Z70UJ8E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-48-R5AP4XijOd-x4BWfbH_noQ-1; Tue, 05 Nov 2019 17:54:12 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CA1961800D4A;
 Tue,  5 Nov 2019 22:54:10 +0000 (UTC)
Received: from x1w.redhat.com (ovpn-204-20.brq.redhat.com [10.40.204.20])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 034191001902;
 Tue,  5 Nov 2019 22:54:07 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v2 01/21] Makefile: Fix config-devices.mak not regenerated when
 Kconfig updated
Date: Tue,  5 Nov 2019 23:53:53 +0100
Message-Id: <20191105225353.9900-2-philmd@redhat.com>
In-Reply-To: <20191105225353.9900-1-philmd@redhat.com>
References: <20191105225353.9900-1-philmd@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: R5AP4XijOd-x4BWfbH_noQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
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
Cc: Laurent Vivier <lvivier@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

When hw/$DIR/Kconfig is changed, the corresponding generated
hw/$DIR/config-devices.mak is not being updated.
Fix this by including all the hw/*/Kconfig files to the prerequisite
names of the rule generating the config-devices.mak files.

Fixes: e0e312f3525a (build: switch to Kconfig)
Reported-by: Peter Maydell <peter.maydell@linaro.org>
Suggested-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
Reviewed-by: Laurent Vivier <lvivier@redhat.com>
Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 Makefile | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index bd6376d295..aa9d1a42aa 100644
--- a/Makefile
+++ b/Makefile
@@ -390,7 +390,8 @@ MINIKCONF_ARGS =3D \
     CONFIG_LINUX=3D$(CONFIG_LINUX) \
     CONFIG_PVRDMA=3D$(CONFIG_PVRDMA)
=20
-MINIKCONF_INPUTS =3D $(SRC_PATH)/Kconfig.host $(SRC_PATH)/hw/Kconfig
+MINIKCONF_INPUTS =3D $(SRC_PATH)/Kconfig.host $(SRC_PATH)/hw/Kconfig \
+                   $(wildcard $(SRC_PATH)/hw/*/Kconfig)
 MINIKCONF =3D $(PYTHON) $(SRC_PATH)/scripts/minikconf.py \
=20
 $(SUBDIR_DEVICES_MAK): %/config-devices.mak: default-configs/%.mak $(MINIK=
CONF_INPUTS) $(BUILD_DIR)/config-host.mak
--=20
2.21.0


