Return-Path: <SRS0=QduX=3Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BDF5C2D0B1
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 08:55:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 569F921744
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 08:55:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E36Oxm1r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 569F921744
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54736 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iytzy-0001iu-E8
	for qemu-devel@archiver.kernel.org; Tue, 04 Feb 2020 03:55:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37238)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1iytz8-0000eq-Ng
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 03:55:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1iytz7-0004Uq-Jf
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 03:55:06 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:59967
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>) id 1iytz7-0004U2-Fb
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 03:55:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580806505;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/fx0aW8/b2WuwBZNdVZcdOvRYtyDDk1GhWI9eT3yZ1U=;
 b=E36Oxm1rgiE8ADeNr2re3xKk8/zh+eZkL+9ht0lBV9bzgy+7FSIxX6jkwDtkYPqs3jdw/4
 HL6MHkhx5gEz5rXfgxTb2WXYe9ioQVJrOMNKGuJUACM2Fa/ExzrSOaj1Z/1hhwbgCTPeDc
 rhtoro9JxE+GPolEcGGbjQ64ELZ5XXY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-418-xvgp1k-CNveo6mFLMfMcQA-1; Tue, 04 Feb 2020 03:54:04 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EBDB8100726C;
 Tue,  4 Feb 2020 08:54:03 +0000 (UTC)
Received: from thuth.com (ovpn-116-39.ams2.redhat.com [10.36.116.39])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 19D1E8E9FE;
 Tue,  4 Feb 2020 08:54:02 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL v2 11/14] Makefile: Do not use wildcard hw/*/Kconfig as input
 for minikconf
Date: Tue,  4 Feb 2020 09:53:57 +0100
Message-Id: <20200204085358.17191-2-thuth@redhat.com>
In-Reply-To: <20200204085358.17191-1-thuth@redhat.com>
References: <20200204085358.17191-1-thuth@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: xvgp1k-CNveo6mFLMfMcQA-1
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The hw/*/Kconfig files should be sourced from hw/Kconfig, so there
is no need to pass them along as input files to minikconfig. We should
use the hw/*/Kconfig wildcard only for build dependencies in the Makefile.

With this change, there are now no duplicate entries in the generated
*-softmmu/config-devices.mak.d files anymore, and there is finally a
chance to get rid of stale Kconfig files like hw/bt/Kconfig, too (once
they do not show up in the config-devices.mak.d files now anymore).

Message-Id: <20200203153905.20544-1-thuth@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 Makefile | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Makefile b/Makefile
index a6f5d44082..461d40bea6 100644
--- a/Makefile
+++ b/Makefile
@@ -397,11 +397,11 @@ MINIKCONF_ARGS =3D \
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


