Return-Path: <SRS0=TEh4=AD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF052C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 13:13:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8BAA62070E
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 13:13:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BJfUgE44"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8BAA62070E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51252 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnMGS-000644-Sc
	for qemu-devel@archiver.kernel.org; Mon, 22 Jun 2020 09:13:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45660)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jnMFn-0005ed-7f
 for qemu-devel@nongnu.org; Mon, 22 Jun 2020 09:12:51 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:21727
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jnMFl-0000RO-6m
 for qemu-devel@nongnu.org; Mon, 22 Jun 2020 09:12:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592831567;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type;
 bh=hQAxkJLRaY8ZLKKliiJ+/BTuKq7QlOfLkKuDoMFSP5o=;
 b=BJfUgE44vgRZygQCa/RzEJjd3Uc/bNv1NiwcRtJqZ150ijCfVPxAHvMCXOIICihgGuo+0n
 AYnpbmc9U7d9M2bZ4784PkI/zwBvyREv/t+UJOtfiImvAI3DuPXDhTXuifXCUGOZmtoewT
 72J4VAz7gq0tcGlR1gA1mlc7qxTDSro=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-13-RADOk1a5OmKPCJ4Jb7cjRQ-1; Mon, 22 Jun 2020 09:12:45 -0400
X-MC-Unique: RADOk1a5OmKPCJ4Jb7cjRQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 88DEB83DB39
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2020 13:12:44 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-112-67.ams2.redhat.com
 [10.36.112.67])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1FBBC5D9E2;
 Mon, 22 Jun 2020 13:12:41 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 16E9317477; Mon, 22 Jun 2020 15:12:40 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] configure: vgabios cleanups
Date: Mon, 22 Jun 2020 15:12:40 +0200
Message-Id: <20200622131240.9624-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kraxel@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Received-SPF: pass client-ip=207.211.31.120; envelope-from=kraxel@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/22 02:57:26
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Commit 91b8eba9ec3f ("vgabios: remove submodule and build rules.")
removed the vgabios submodule, but left some traces in the configure
script.  Remove them.

Reported-by: BALATON Zoltan <balaton@eik.bme.hu>
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 configure | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/configure b/configure
index ba88fd182447..1bc28ad014a1 100755
--- a/configure
+++ b/configure
@@ -8384,14 +8384,14 @@ DIRS="tests tests/tcg tests/tcg/lm32 tests/qapi-schema tests/qtest/libqos"
 DIRS="$DIRS tests/qtest tests/qemu-iotests tests/vm tests/fp tests/qgraph"
 DIRS="$DIRS docs docs/interop fsdev scsi"
 DIRS="$DIRS pc-bios/optionrom pc-bios/s390-ccw"
-DIRS="$DIRS roms/seabios roms/vgabios"
+DIRS="$DIRS roms/seabios"
 LINKS="Makefile"
 LINKS="$LINKS tests/tcg/lm32/Makefile po/Makefile"
 LINKS="$LINKS tests/tcg/Makefile.target tests/fp/Makefile"
 LINKS="$LINKS tests/plugin/Makefile"
 LINKS="$LINKS pc-bios/optionrom/Makefile pc-bios/keymaps"
 LINKS="$LINKS pc-bios/s390-ccw/Makefile"
-LINKS="$LINKS roms/seabios/Makefile roms/vgabios/Makefile"
+LINKS="$LINKS roms/seabios/Makefile"
 LINKS="$LINKS pc-bios/qemu-icon.bmp"
 LINKS="$LINKS .gdbinit scripts" # scripts needed by relative path in .gdbinit
 LINKS="$LINKS tests/acceptance tests/data"
@@ -8424,7 +8424,7 @@ export target_list source_path use_containers
 $source_path/tests/tcg/configure.sh)
 
 # temporary config to build submodules
-for rom in seabios vgabios ; do
+for rom in seabios; do
     config_mak=roms/$rom/config.mak
     echo "# Automatically generated by configure - do not modify" > $config_mak
     echo "SRC_PATH=$source_path/roms/$rom" >> $config_mak
-- 
2.18.4


