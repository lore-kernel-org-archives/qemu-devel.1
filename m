Return-Path: <SRS0=cs6B=3X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0DF4C35247
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 15:40:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 80A8F20CC7
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 15:40:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JsrEijIg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80A8F20CC7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43518 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iydpQ-0000px-L5
	for qemu-devel@archiver.kernel.org; Mon, 03 Feb 2020 10:40:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33187)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1iydol-0008OH-Br
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 10:39:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1iydok-0006Fp-Ds
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 10:39:19 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:29602
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>) id 1iydok-0006FQ-AK
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 10:39:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580744357;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=eXEIG6iFtdRBfowazDT2POm+H3hVQ/L0WJhbXU28mUk=;
 b=JsrEijIgOzPKMflqZgti4C+UHBlfg/yP/yr94q2ZKV1Ho5Jq70btxRi7tG3vfD5ADA08rJ
 EBflZT7G7NclZ/YkbJNF6+8C8VjQp+5lJy8xJOFqn9FyFyBzUIobkgBTzwOl7RIeuPNyuK
 e//T56saKeSZnuzfR18dBYg09Iir6b4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-165-UJlzWScsPeuPY5wU7rPN_w-1; Mon, 03 Feb 2020 10:39:13 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3958B108C303;
 Mon,  3 Feb 2020 15:39:12 +0000 (UTC)
Received: from thuth.com (ovpn-116-129.ams2.redhat.com [10.36.116.129])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 87AD486C4A;
 Mon,  3 Feb 2020 15:39:08 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH] Makefile: Do not use wildcard hw/*/Kconfig as input for
 minikconf
Date: Mon,  3 Feb 2020 16:39:05 +0100
Message-Id: <20200203153905.20544-1-thuth@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: UJlzWScsPeuPY5wU7rPN_w-1
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The hw/*/Kconfig files should be sourced from hw/Kconfig, so there
is no need to pass them along as input files to minikconfig. We should
use the hw/*/Kconfig wildcard only for build dependencies in the Makefile.

With this change, there are now no duplicate entries in the generated
*-softmmu/config-devices.mak.d files anymore, and there is finally a
chance to get rid of stale Kconfig file like hw/bt/Kconfig, too (once
they do not show up in the config-devices.mak.d files now anymore).

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 Makefile | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Makefile b/Makefile
index 9a5a1e689c..a29ecc38f0 100644
--- a/Makefile
+++ b/Makefile
@@ -396,11 +396,11 @@ MINIKCONF_ARGS =3D \
     CONFIG_LINUX=3D$(CONFIG_LINUX) \
     CONFIG_PVRDMA=3D$(CONFIG_PVRDMA)
=20
-MINIKCONF_INPUTS =3D $(SRC_PATH)/Kconfig.host $(SRC_PATH)/hw/Kconfig \
-                   $(wildcard $(SRC_PATH)/hw/*/Kconfig)
+MINIKCONF_INPUTS =3D $(SRC_PATH)/Kconfig.host $(SRC_PATH)/hw/Kconfig
+MINIKCONF_DEPS =3D $(MINIKCONF_INPUTS) $(wildcard $(SRC_PATH)/hw/*/Kconfig=
)
 MINIKCONF =3D $(PYTHON) $(SRC_PATH)/scripts/minikconf.py \
=20
-$(SUBDIR_DEVICES_MAK): %/config-devices.mak: default-configs/%.mak $(MINIK=
CONF_INPUTS) $(BUILD_DIR)/config-host.mak
+$(SUBDIR_DEVICES_MAK): %/config-devices.mak: default-configs/%.mak $(MINIK=
CONF_DEPS) $(BUILD_DIR)/config-host.mak
 =09$(call quiet-command, $(MINIKCONF) $(MINIKCONF_ARGS) > $@.tmp, "GEN", "=
$@.tmp")
 =09$(call quiet-command, if test -f $@; then \
 =09  if cmp -s $@.old $@; then \
--=20
2.18.1


